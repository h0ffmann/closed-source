//// content: write site/src/closed_source_site/content.gleam from the papers, so the site never
//// repeats a fact by hand. Runs in the paper toolchain (pandoc reads the YAML, pdfinfo counts
//// pages).
////
////     tools/fabric content              # from the repository root, after `just build`
////     tools/fabric content --self-test  # site.yml runs it

import fabric/json
import fabric/re
import fabric/sys
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

const out = "site/src/closed_source_site/content.gleam"

const repo = "https://github.com/h0ffmann/closed-source"

pub fn main(args: List(String)) -> Int {
  case list.contains(args, "--self-test") {
    True -> self_test()
    False -> {
      let slug = "closed-source"
      case render(slug) {
        Ok(text) ->
          case sys.write(out, text) {
            Ok(_) -> {
              io.println("content: wrote " <> out)
              0
            }
            Error(e) -> fail(e)
          }
        Error(e) -> fail(e)
      }
    }
  }
}

fn fail(e: String) -> Int {
  sys.eprintln("content: " <> e)
  1
}

/// subprocess.run(capture_output=True): stderr is captured, so it is dropped here too.
fn quiet(
  command: String,
  args: List(String),
  cwd: String,
) -> Result(sys.Run, String) {
  sys.run("sh", ["-c", "exec \"$0\" \"$@\" 2>/dev/null", command, ..args], cwd)
}

/// The merged YAML metadata of the files (later files win), as pandoc reads it.
fn meta(files: List(String)) -> Result(json.Json, String) {
  let dir = sys.temp_dir()
  let tpl = sys.join(dir, "meta.tpl")
  let got = {
    use _ <- result.try(sys.write(tpl, "$meta-json$"))
    use run <- result.try(quiet(
      "pandoc",
      list.append(files, [
        "--template=" <> tpl,
        "-t",
        "plain",
        "--wrap=none",
      ]),
      "",
    ))
    case run.status {
      0 -> json.decode(run.stdout)
      s -> Error("pandoc returned non-zero exit status " <> int.to_string(s))
    }
  }
  sys.remove_all(dir)
  got
}

/// Path.read_text(): universal newlines.
fn read(path: String) -> Result(String, String) {
  sys.read(path)
  |> result.map(fn(s) {
    s |> string.replace("\r\n", "\n") |> string.replace("\r", "\n")
  })
}

/// str.splitlines()
pub fn splitlines(s: String) -> List(String) {
  let parts =
    re.split(
      re.compile(
        "\\r\\n|[\\n\\r\\x0b\\x0c\\x1c\\x1d\\x1e\\x{85}\\x{2028}\\x{2029}]",
        [],
      ),
      s,
    )
  case list.reverse(parts) {
    ["", ..rest] -> list.reverse(rest)
    _ -> parts
  }
}

/// str.strip(): Python's whitespace is Unicode White_Space plus \x1c-\x1f.
pub fn strip(s: String) -> String {
  re.sub(re.compile("^[\\s\\x1c-\\x1f]+|[\\s\\x1c-\\x1f]+\\z", []), s, "")
}

pub fn sections(texts: List(String)) -> List(String) {
  let heading = re.compile("^# (.+?)(\\s*\\{[^}]*\\})?\\s*$", [])
  list.flat_map(texts, fn(text) {
    list.filter_map(splitlines(text), fn(line) {
      case re.first(heading, line) {
        Ok([_, title, attrs, ..]) ->
          case string.contains(attrs, "unnumbered") {
            True -> Error(Nil)
            False -> Ok(title)
          }
        _ -> Error(Nil)
      }
    })
  })
}

fn between(text: String, start: String, end: String) -> Result(String, String) {
  case string.split_once(text, start) {
    Ok(#(_, rest)) ->
      case string.split(rest, end) {
        [block, ..] -> Ok(block)
        [] -> Ok(rest)
      }
    Error(_) -> Error("README.md has no " <> start)
  }
}

/// (label, text) for each style in the README's generated citation block.
pub fn citations(readme: String) -> Result(List(#(String, String)), String) {
  use block <- result.map(between(
    readme,
    "<!-- citation:start -->",
    "<!-- citation:end -->",
  ))
  let style =
    re.compile(
      "^(\\w[\\w ()0-9]*?):\\n\\n(.*?)(?=\\n\\n\\w[\\w ()0-9]*?:\\n\\n|\\z)",
      [re.Dotall, re.Multiline],
    )
  let fence = re.compile("^```\\w*\\n|\\n```$", [])
  let emphasis = re.compile("\\*\\*?([^*]+)\\*\\*?", [])
  re.scan(style, strip(block))
  |> list.map(fn(m) {
    let assert [_, label, body, ..] = m
    let body = re.sub(fence, strip(body), "")
    let body =
      splitlines(body)
      |> list.map(fn(l) {
        case string.starts_with(l, "> ") {
          True -> string.drop_start(l, 2)
          False -> l
        }
      })
      |> string.join("\n")
    // Markdown emphasis: plain text here
    let body = case string.starts_with(label, "BibTeX") {
      True -> body
      False -> re.sub(emphasis, body, "\\1")
    }
    #(strip(label), strip(body))
  })
}

pub type Thinker {
  Thinker(n: Int, name: String, why: String, status: String)
}

/// One row of 50THINKERS.md's table (# | Thinker | Area | Why | Cited | Status). The rows stay
/// in the file's order, which is shuffled on purpose.
pub fn thinkers(roster: String) -> List(Thinker) {
  re.scan(
    re.compile(
      "^\\|\\s*(\\d+)\\s*\\|([^|]*)\\|([^|]*)\\|([^|]*)\\|([^|]*)\\|([^|]*)\\|\\s*$",
      [re.Multiline],
    ),
    roster,
  )
  |> list.map(fn(m) {
    let assert [_, n, t, _, w, _, st, ..] = m
    let assert Ok(n) = int.parse(n)
    Thinker(n, strip(t), strip(w), strip(st))
  })
}

/// (file stem, title, type, status) for each note in notes/, newest first.
fn notes(
  folder: String,
) -> Result(List(#(String, String, String, String)), String) {
  sys.glob(folder, ".md")
  |> list.reverse
  |> list.filter(fn(f) { sys.base_name(f) != "index.md" })
  |> list.try_map(fn(f) {
    use text <- result.map(read(f))
    let fm = case string.split_once(text, "\n---\n") {
      Ok(#(head, _)) -> head
      Error(_) -> text
    }
    let get = fn(k) {
      case
        re.first(
          re.compile("^" <> k <> ":\\s*\"?(.*?)\"?\\s*$", [re.Multiline]),
          fm,
        )
      {
        Ok([_, v, ..]) -> v
        _ -> ""
      }
    }
    #(sys.stem(f), get("title"), get("type"), get("status"))
  })
}

fn pages(pdf: String) -> Int {
  case sys.exists(pdf) {
    False -> 0
    True ->
      case quiet("pdfinfo", [pdf], "") {
        Ok(run) ->
          case
            re.first(
              re.compile("^Pages:\\s+(\\d+)", [re.Multiline]),
              run.stdout,
            )
          {
            Ok([_, n, ..]) -> result.unwrap(int.parse(n), 0)
            _ -> 0
          }
        Error(_) -> 0
      }
  }
}

pub fn gleam_string(s: String) -> String {
  "\""
  <> s
  |> string.replace("\\", "\\\\")
  |> string.replace("\"", "\\\"")
  |> string.replace("\n", "\\n")
  <> "\""
}

fn gleam_list(items: List(String)) -> String {
  "[\n" <> string.concat(list.map(items, fn(i) { "  " <> i <> ",\n" })) <> "]"
}

fn author(a: json.Json) -> String {
  "Author(name: "
  <> gleam_string(json.get_string(a, "name"))
  <> ", orcid: "
  <> gleam_string(json.get_string(a, "orcid"))
  <> ", affiliation: "
  <> gleam_string(json.get_string(a, "affiliation"))
  <> ")"
}

/// One `logos:` entry of metadata.md as the site's stamp; a key the entry lacks is "".
pub fn logo(l: json.Json) -> String {
  let field = fn(key) { gleam_string(json.get_string(l, key)) }
  "Logo(name: "
  <> gleam_string(sys.stem(json.get_string(l, "file")))
  <> ", svg: "
  <> field("svg")
  <> ", svg_dark: "
  <> field("svg-dark")
  <> ", href: "
  <> field("href")
  <> ", label: "
  <> field("label")
  <> ", text: "
  <> field("text")
  <> ", width: "
  <> field("width")
  <> ", height: "
  <> field("height")
  <> ")"
}

fn count(pattern: String, flags: List(re.Flag), text: String) -> Int {
  list.length(re.scan(re.compile(pattern, flags), text))
}

fn falsy(j: Result(json.Json, Nil)) -> Bool {
  case j {
    Error(_) | Ok(json.Null) | Ok(json.Bool(False)) | Ok(json.String("")) ->
      True
    Ok(json.Array([])) | Ok(json.Object([])) -> True
    _ -> False
  }
}

fn render(slug: String) -> Result(String, String) {
  let paper = sys.join("papers", slug)
  use m <- result.try(meta([sys.join(paper, "metadata.md")]))
  use ste <- result.try(case sys.is_dir(sys.join(paper, "prose-ste")) {
    True ->
      meta([
        sys.join(paper, "metadata.md"),
        sys.join(paper, "prose-ste/00-metadata.md"),
      ])
    False -> Ok(m)
  })
  use bib <- result.try(read(sys.join(paper, "refs.bib")))
  let refs = count("^@\\w+\\{", [re.Multiline], bib)
  let log_path = sys.join(paper, "REFERENCES.md")
  use log <- result.try(case sys.exists(log_path) {
    True -> read(log_path)
    False -> Ok("")
  })
  let verified = count("\\|\\s*verified\\s*\\|", [], log)
  let authors = list.map(json.get_list(m, "author"), author)
  // `writer`: who wrote a paper whose cover carries a pen name; the cover's author otherwise.
  let writer = case falsy(json.get(m, "writer")) {
    False -> result.unwrap(json.get(m, "writer"), json.Null)
    True -> result.unwrap(list.first(json.get_list(m, "author")), json.Null)
  }
  let logos = list.map(json.get_list(m, "logos"), logo)
  use readme <- result.try(read("README.md"))
  use cites <- result.try(citations(readme))
  let cites =
    list.map(cites, fn(c) {
      "#(" <> gleam_string(c.0) <> ", " <> gleam_string(c.1) <> ")"
    })
  let keywords =
    list.filter_map(json.get_list(m, "keywords"), fn(k) {
      case k {
        json.String(s) -> Ok(gleam_string(s))
        _ -> Error(Nil)
      }
    })
  use prose <- result.try(
    sys.glob(sys.join(paper, "prose"), ".md") |> list.try_map(read),
  )
  let secs = list.map(sections(prose), gleam_string)
  use roster <- result.try(case sys.exists("50THINKERS.md") {
    True -> read("50THINKERS.md") |> result.map(thinkers)
    False -> Ok([])
  })
  let thinker_rows =
    list.map(roster, fn(t) {
      "Thinker(n: "
      <> int.to_string(t.n)
      <> ", name: "
      <> gleam_string(t.name)
      <> ", why: "
      <> gleam_string(t.why)
      <> ", status: "
      <> gleam_string(t.status)
      <> ")"
    })
  use note_list <- result.try(notes("notes"))
  let note_rows =
    list.map(note_list, fn(n) {
      "Note(file: "
      <> gleam_string(n.0)
      <> ", title: "
      <> gleam_string(n.1)
      <> ", kind: "
      <> gleam_string(n.2)
      <> ", status: "
      <> gleam_string(n.3)
      <> ")"
    })
  let rev = case quiet("git", ["rev-parse", "--short", "HEAD"], "") {
    Ok(run) -> strip(run.stdout)
    Error(_) -> ""
  }
  let rev = case rev {
    "" -> "unversioned"
    r -> r
  }
  Ok(
    "//// Generated by tools/fabric content from papers/"
    <> slug
    <> "/ and README.md; do not edit.

pub type Author {
  Author(name: String, orcid: String, affiliation: String)
}

pub type Logo {
  Logo(
    name: String,
    svg: String,
    svg_dark: String,
    href: String,
    label: String,
    text: String,
    width: String,
    height: String,
  )
}

pub type Thinker {
  Thinker(n: Int, name: String, why: String, status: String)
}

pub type Note {
  Note(file: String, title: String, kind: String, status: String)
}

pub const slug = "
    <> gleam_string(slug)
    <> "

pub const repo = "
    <> gleam_string(repo)
    <> "

pub const revision = "
    <> gleam_string(rev)
    <> "

pub const title = "
    <> gleam_string(json.get_string(m, "title"))
    <> "

pub const subtitle = "
    <> gleam_string(json.get_string(m, "subtitle"))
    <> "

pub const version = "
    <> gleam_string(json.get_string(m, "version"))
    <> "

pub const date = "
    <> gleam_string(json.get_string(m, "date"))
    <> "

pub const abstract = "
    <> gleam_string(strip(json.get_string(m, "abstract")))
    <> "

pub const abstract_ste = "
    <> gleam_string(strip(json.get_string(ste, "abstract")))
    <> "

pub const pages = "
    <> int.to_string(pages("pdf/" <> slug <> ".pdf"))
    <> "

pub const pages_pt_br = "
    <> int.to_string(pages("pdf/" <> slug <> "-pt-BR.pdf"))
    <> "

pub const references = "
    <> int.to_string(refs)
    <> "

pub const verified = "
    <> int.to_string(verified)
    <> "

pub const authors = "
    <> gleam_list(authors)
    <> "

pub const writer = "
    <> author(writer)
    <> "

pub const logos = "
    <> gleam_list(logos)
    <> "

pub const keywords = "
    <> gleam_list(keywords)
    <> "

pub const sections = "
    <> gleam_list(secs)
    <> "

pub const citations = "
    <> gleam_list(cites)
    <> "

pub const thinkers = "
    <> gleam_list(thinker_rows)
    <> "

pub const notes = "
    <> gleam_list(note_rows)
    <> "
",
  )
}

/// The --self-test site.yml runs; the same cases are in test/content_test.gleam.
fn self_test() -> Int {
  let readme =
    "x\n<!-- citation:start -->\n\nBibTeX:\n\n```bibtex\n@misc{k,\n}\n```\n\nAPA:\n\n> A. (2026). *T*.\n\n<!-- citation:end -->\n"
  let roster =
    "| # | Thinker | Area | Why | Cited | Status |\n|---:|---|---|---|:---:|---|\n| 1 | Linus Torvalds | software | Linux | ☑ | proposed |\n| 2 | — | — | — | — | open |\n"
  let ok =
    gleam_string("a\"b\\c\nd") == "\"a\\\"b\\\\c\\nd\""
    && citations(readme)
    == Ok([#("BibTeX", "@misc{k,\n}"), #("APA", "A. (2026). T.")])
    && thinkers(roster)
    == [
      Thinker(1, "Linus Torvalds", "Linux", "proposed"),
      Thinker(2, "—", "—", "open"),
    ]
  case ok {
    True -> {
      io.println("content: self-test ok")
      0
    }
    False -> {
      sys.eprintln("content: self-test failed")
      1
    }
  }
}
