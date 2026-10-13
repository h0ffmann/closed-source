//// arxiv: package a paper's LaTeX source for arXiv and write its submission metadata.
////
//// arXiv compiles submitted TeX itself, with pdfLaTeX, and refuses PDFs that were produced from
//// TeX. So this command takes the .tex that `just build` generates (citations already rendered by
//// citeproc, so no .bbl is needed), freezes the Git revision into it, checks that it compiles
//// with pdfLaTeX in a clean directory holding only the bundle, and writes:
////
////     build/arxiv/<slug>.tar.gz     the upload: <slug>.tex and the title-page logos, nothing else
////     build/arxiv/<slug>.txt        the form fields: title, authors, abstract, comments, categories, licence
////
//// Submitting stays a human step on arxiv.org (endorsement, licence choice and the final preview
//// are the submitter's). Metadata comes from the paper's metadata.md, `arxiv:` block included.
////
////     tools/fabric arxiv closed-source           # needs build/tex/closed-source.tex
////     tools/fabric arxiv closed-source --no-compile

import fabric/cli
import fabric/json.{type Json}
import fabric/logos
import fabric/re
import fabric/sys
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

// arXiv's documented limits and category scheme (arxiv.org/help/prep, checked 2026-10-12).
pub const abstract_max = 1920

pub const title_max = 240

const prog = "arxiv.py"

const usage = "usage: arxiv.py [-h] [--no-compile] [slug]\n"

const help =
  "
arxiv — package a paper's LaTeX source for arXiv and write its submission metadata.

arXiv compiles submitted TeX itself, with pdfLaTeX, and refuses PDFs that were produced from TeX.
So this script takes the .tex that `just build` generates (citations already rendered by citeproc, so no
.bbl is needed), freezes the Git revision into it, checks that it compiles with pdfLaTeX in a
clean directory holding only the bundle, and writes:

    build/arxiv/<slug>.tar.gz     the upload: <slug>.tex and the title-page logos, nothing else
    build/arxiv/<slug>.txt        the form fields: title, authors, abstract, comments, categories, licence

Submitting stays a human step on arxiv.org (endorsement, licence choice and the final preview are
the submitter's). Metadata comes from the paper's metadata.md, `arxiv:` block included.

    scripts/arxiv.py closed-source           # needs build/tex/closed-source.tex (just build closed-source)
    scripts/arxiv.py closed-source --no-compile

positional arguments:
  slug

options:
  -h, --help    show this help message and exit
  --no-compile
"

pub fn main(args: List(String)) -> Int {
  case cli.parse(args, [cli.Flag("--no-compile")], cli.Maybe) {
    Error(cli.Help) -> {
      io.print(usage <> help)
      0
    }
    Error(cli.Usage(msg)) -> cli.fail(usage, prog, msg)
    Ok(cli.Parsed(positionals: [slug], ..) as p) if slug != "" ->
      case package(slug, !cli.flag(p, "--no-compile")) {
        Ok(code) -> code
        Error(e) -> {
          sys.eprintln("arxiv: " <> e)
          1
        }
      }
    Ok(_) -> cli.fail(usage, prog, "name a paper, e.g. closed-source")
  }
}

/// The form fields arXiv asks for, as text, and what in the metadata arXiv would refuse.
pub fn form_fields(meta: Json) -> #(String, List(String)) {
  let ax = json.get(meta, "arxiv") |> result.unwrap(json.Object([]))
  let title = json.get_string(meta, "title")
  let abstract = squash(json.get_string(meta, "abstract"))
  let title_errs = case title == "" || length(title) > title_max {
    True -> ["title must be 1.." <> int.to_string(title_max) <> " characters"]
    False -> []
  }
  let abstract_errs = case abstract == "" || length(abstract) > abstract_max {
    True -> [
      "abstract is "
      <> int.to_string(length(abstract))
      <> " characters; arXiv allows "
      <> int.to_string(abstract_max),
    ]
    False -> []
  }
  let cross = strings(json.get_list(ax, "cross-list"))
  let category = re.compile("^[a-z-]+(\\.[A-Za-z-]+)?$", [])
  let cat_errs =
    [json.get_string(ax, "primary"), ..cross]
    |> list.filter(fn(c) { !re.search(category, c) })
    |> list.map(fn(c) {
      "category " <> cli.repr(c) <> " is not an arXiv category id"
    })
  let license_errs = case json.get_string(ax, "license") {
    "" -> ["arxiv.license is missing"]
    _ -> []
  }
  // The cover may carry a pen name (`author`); arXiv gets the writer's name when one is given.
  let people = case json.get(meta, "writer") {
    Ok(json.Object([_, ..]) as w) -> [w]
    _ -> json.get_list(meta, "author")
  }
  let authors =
    list.map(people, fn(a) { json.get_string(a, "name") }) |> string.join(", ")
  let text =
    string.join(
      [
        "Title: " <> title,
        "Authors: " <> authors,
        "Primary category: " <> json.get_string(ax, "primary"),
        "Cross-lists: " <> string.join(cross, " "),
        "Licence: " <> json.get_string(ax, "license"),
        "Comments: " <> json.get_string(ax, "comments"),
        "",
        "Abstract:",
        abstract,
        "",
      ],
      "\n",
    )
  #(text, list.flatten([title_errs, abstract_errs, cat_errs, license_errs]))
}

fn strings(l: List(Json)) -> List(String) {
  list.map(l, fn(j) {
    case j {
      json.String(s) -> s
      _ -> json.encode(j, 0, True)
    }
  })
}

/// len(s): code points, not graphemes.
fn length(s: String) -> Int {
  list.length(string.to_utf_codepoints(s))
}

/// " ".join(s.split()), with Python's whitespace.
pub fn squash(s: String) -> String {
  re.split(
    re.compile(
      "[\\t\\n\\x0b\\x0c\\r\\x1c-\\x1f \\x{85}\\x{a0}\\x{1680}\\x{2000}-\\x{200a}\\x{2028}\\x{2029}\\x{202f}\\x{205f}\\x{3000}]+",
      [],
    ),
    s,
  )
  |> list.filter(fn(w) { w != "" })
  |> string.join(" ")
}

/// Replaces the first \newcommand{\revision}{...} line's body with the frozen revision.
pub fn freeze_revision(
  tex: String,
  revision: String,
) -> Result(String, String) {
  let r = re.compile("\\\\newcommand\\{\\\\revision\\}\\{.*\\}", [])
  case re.first(r, tex) {
    Ok([whole, ..]) -> {
      let assert Ok(#(before, after)) = string.split_once(tex, whole)
      Ok(before <> "\\newcommand{\\revision}{" <> revision <> "}" <> after)
    }
    _ -> Error("no \\newcommand{\\revision}{...} line in the generated .tex")
  }
}

fn revision() -> Result(String, String) {
  use hash <- result.try(sys.check_output(
    "git",
    ["rev-parse", "--short", "HEAD"],
    "",
  ))
  use count <- result.try(sys.check_output(
    "git",
    ["rev-list", "--count", "HEAD"],
    "",
  ))
  Ok(string.trim(hash) <> "+" <> string.trim(count))
}

@external(erlang, "binary", "matches")
fn matches(subject: BitArray, pattern: BitArray) -> List(#(Int, Int))

/// The last 15 lines of pdflatex's output, split as str.splitlines() splits.
fn tail(out: String) -> String {
  let lines =
    re.split(
      re.compile(
        "\\r\\n|[\\n\\r\\x0b\\x0c\\x1c\\x1d\\x1e\\x{85}\\x{2028}\\x{2029}]",
        [],
      ),
      out,
    )
  let lines = case list.last(lines) {
    Ok("") -> list.take(lines, list.length(lines) - 1)
    _ -> lines
  }
  list.drop(lines, list.length(lines) - 15) |> string.join("\n")
}

fn compile_check(tarball: String, slug: String) -> Result(Nil, String) {
  let dir = sys.temp_dir()
  let r = {
    use _ <- result.try(sys.tar_gz_extract(tarball, dir))
    use _ <- result.try(pdflatex(dir, slug, 2))
    use log <- result.try(sys.read_bytes(sys.join(dir, slug <> ".log")))
    case matches(log, <<"Missing character":utf8>>) {
      [] -> Ok(Nil)
      _ -> Error("pdflatex dropped characters (Missing character in the log)")
    }
  }
  sys.remove_all(dir)
  r
}

fn pdflatex(dir: String, slug: String, times: Int) -> Result(Nil, String) {
  case times {
    0 -> Ok(Nil)
    _ -> {
      use r <- result.try(sys.run(
        "pdflatex",
        ["-interaction=nonstopmode", "-halt-on-error", slug <> ".tex"],
        dir,
      ))
      case r.status {
        0 -> pdflatex(dir, slug, times - 1)
        _ -> Error("pdflatex failed on the arXiv bundle:\n" <> tail(r.stdout))
      }
    }
  }
}

fn package(slug: String, compile: Bool) -> Result(Int, String) {
  let src = "build/tex/" <> slug <> ".tex"
  case sys.exists(src) {
    False -> {
      sys.eprintln(
        "arxiv: " <> src <> " is missing; run `just build " <> slug <> "` first",
      )
      Ok(1)
    }
    True -> {
      use meta <- result.try(logos.metadata(slug))
      case form_fields(meta) {
        #(_, [_, ..] as errs) -> {
          sys.eprintln(string.join(
            ["arxiv: metadata.md is not ready for arXiv:", ..errs],
            "\n  ",
          ))
          Ok(1)
        }
        #(text, []) -> {
          let out = "build/arxiv"
          use _ <- result.try(sys.make_dirs(out))
          use tex <- result.try(sys.read(src))
          use rev <- result.try(revision())
          use frozen <- result.try(freeze_revision(tex, rev))
          let stage = sys.temp_dir()
          let staged = sys.join(stage, slug <> ".tex")
          let tarball = out <> "/" <> slug <> ".tar.gz"
          // logos wrote them for the build.
          let logo_files =
            json.get_list(meta, "logos")
            |> list.map(fn(l) {
              let file = json.get_string(l, "file")
              #(file, sys.join("build", file))
            })
          let written = {
            use _ <- result.try(sys.write(staged, frozen))
            sys.tar_gz_create(tarball, [#(slug <> ".tex", staged), ..logo_files])
          }
          sys.remove_all(stage)
          use _ <- result.try(written)
          use _ <- result.try(sys.write(out <> "/" <> slug <> ".txt", text))
          use _ <- result.try(case compile {
            True -> compile_check(tarball, slug)
            False -> Ok(Nil)
          })
          sys.eprintln(
            "arxiv: wrote "
            <> tarball
            <> " and "
            <> slug
            <> ".txt"
            <> case compile {
              True -> " (pdfLaTeX check passed)"
              False -> ""
            },
          )
          Ok(0)
        }
      }
    }
  }
}
