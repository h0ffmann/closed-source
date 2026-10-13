//// cite-check: every Markdown file is cited (AGENTS.md hard rule).
////
//// Each git-tracked .md file carries one line, after its front matter or as its first line:
////
////     <!-- cite: main="<persona>"; last="<persona>" -->
////
//// and both personas are rows of PERSONAS.md's table. GitHub and pandoc hide the line. A file
//// copied as is from another project cannot carry the line: the README.md beside it names it in
//// its front matter (`verbatim: [file.md, ...]`) and gives the citation instead.
////
////     tools/fabric cite-check

import fabric/pystr
import fabric/re
import fabric/sys
import gleam/int
import gleam/list
import gleam/set
import gleam/string

/// The personas in PERSONAS.md's table.
pub fn personas(text: String) -> List(String) {
  re.compile("^\\|\\s*([^|]+?)\\s*\\|\\s*(?:person|pen name|agent)\\s*\\|", [
    re.Multiline,
  ])
  |> re.findall(text)
  |> list.unique
}

/// The line after the front matter, or the first line.
pub fn cite_line(text: String) -> Result(String, Nil) {
  let lines = pystr.splitlines(text)
  let rest = case lines {
    ["---", ..after] ->
      case list.split_while(after, fn(l) { l != "---" }) {
        #(_, [_, ..body]) -> body
        #(_, []) -> []
      }
    _ -> lines
  }
  list.first(rest)
}

/// The files a README.md's front matter names as copied as is.
pub fn verbatim(readme: String) -> List(String) {
  let head = case string.split_once(readme, "\n---\n") {
    Ok(#(h, _)) -> h
    Error(_) -> readme
  }
  case
    re.first(re.compile("^verbatim:\\s*\\[(.*?)\\]\\s*$", [re.Multiline]), head)
  {
    Ok([_, files]) ->
      string.split(files, ",")
      |> list.map(pystr.strip)
      |> list.filter(fn(f) { f != "" })
    _ -> []
  }
}

pub fn check(name: String, text: String, known: List(String)) -> List(String) {
  let line = case cite_line(text) {
    Ok(l) -> l
    Error(_) -> ""
  }
  let cite =
    re.compile("^<!-- cite: main=\"([^\"]+)\"; last=\"([^\"]+)\" -->$", [])
  case re.first(cite, line) {
    Ok([_, main, last]) ->
      list.filter_map([#("main", main), #("last", last)], fn(pair) {
        case list.contains(known, pair.1) {
          True -> Error(Nil)
          False ->
            Ok(
              name
              <> ": "
              <> pair.0
              <> " author "
              <> pystr.repr(pair.1)
              <> " is not in PERSONAS.md",
            )
        }
      })
    _ -> [name <> ": no cite line after the front matter (see PERSONAS.md)"]
  }
}

fn read(path: String) -> String {
  case pystr.read_text(path) {
    Ok(s) -> s
    Error(e) -> {
      sys.eprintln("cite_check: " <> e)
      sys.exit(1)
    }
  }
}

pub fn main(_args: List(String)) -> Int {
  let known = personas(read("PERSONAS.md"))
  case sys.check_output("git", ["ls-files", "*.md"], "") {
    Error(e) -> {
      sys.eprintln("cite_check: " <> e)
      1
    }
    Ok(out) -> {
      let files =
        re.split(re.compile("\\s+", []), out) |> list.filter(fn(f) { f != "" })
      let skip =
        files
        |> list.filter(fn(f) { sys.base_name(f) == "README.md" })
        |> list.flat_map(fn(f) {
          list.map(verbatim(read(f)), fn(v) {
            pystr.path_str(sys.join(sys.parent(f), v))
          })
        })
        |> set.from_list
      let files = list.filter(files, fn(f) { !set.contains(skip, f) })
      let errs = list.flat_map(files, fn(f) { check(f, read(f), known) })
      list.each(errs, fn(e) { sys.eprintln("cite_check: " <> e) })
      case errs {
        [] -> {
          sys.eprintln(
            "cite_check: "
            <> int.to_string(list.length(files))
            <> " Markdown files cited, "
            <> int.to_string(set.size(skip))
            <> " copied as is",
          )
          0
        }
        _ -> 1
      }
    }
  }
}
