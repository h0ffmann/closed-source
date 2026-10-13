//// notes-check: the slip box follows SMART_NOTE_POLICY.md.
////
//// Every notes/<id>-<slug>.md has front matter with id, title, type, status, source and
//// created; the id matches the file name and is unique; type and status are known values; it
//// links to at least one other note; every [[link]] in notes/ resolves; and notes/index.md
//// links to every note.
////
////     tools/fabric notes-check

import fabric/pystr
import fabric/re
import fabric/sys
import gleam/int
import gleam/list
import gleam/result
import gleam/string

const types = ["fleeting", "literature", "permanent"]

const types_sorted = "['fleeting', 'literature', 'permanent']"

const statuses = ["unverified", "partial", "verified", "open-question"]

const statuses_sorted = "['open-question', 'partial', 'unverified', 'verified']"

const fields = ["id", "title", "type", "status", "source", "created"]

fn link_re() -> re.Regex {
  re.compile("\\[\\[([^\\]|#]+)(?:[|#][^\\]]*)?\\]\\]", [])
}

/// The front matter's keys and values, the last value of a key winning. Error when the front
/// matter is never closed (Python's front() raised ValueError there).
pub fn front(text: String) -> Result(List(#(String, String)), Nil) {
  case string.starts_with(text, "---\n") {
    False -> Ok([])
    True -> {
      let after = string.drop_start(text, 4)
      use #(body, _) <- result.map(string.split_once(after, "\n---\n"))
      pystr.splitlines(body)
      |> list.filter(fn(l) {
        string.contains(l, ":") && !string.starts_with(l, " ")
      })
      |> list.map(fn(l) {
        let assert Ok(#(k, v)) = string.split_once(l, ":")
        #(pystr.strip(k), strip_quotes(pystr.strip(v)))
      })
      // A key's last value wins, as in the dict.
      |> list.fold([], fn(acc, kv) { list.key_set(acc, kv.0, kv.1) })
    }
  }
}

fn strip_quotes(s: String) -> String {
  re.sub(re.compile("^\"+|\"+$", []), s, "")
}

fn get(fm: List(#(String, String)), key: String) -> String {
  case list.key_find(fm, key) {
    Ok(v) -> v
    Error(_) -> ""
  }
}

/// The errors in the notes (stem and text, in file order) and notes/index.md.
pub fn check(notes: List(#(String, String)), index: String) -> List(String) {
  let stems = list.map(notes, fn(n) { n.0 })
  let index_links = re.findall(link_re(), index)
  let per_note =
    list.flat_map(notes, fn(note) {
      let #(stem, text) = note
      let name = re.first(re.compile("^(\\d{12})-[a-z0-9-]+$", []), stem)
      let fm = case front(text) {
        Ok(fm) -> fm
        Error(_) -> []
      }
      let bad_name = case name {
        Ok(_) -> []
        Error(_) -> [stem <> ": name must be <YYYYMMDDHHMM>-<slug>"]
      }
      let missing =
        list.filter_map(fields, fn(f) {
          case get(fm, f) {
            "" -> Ok(stem <> ": front matter has no " <> f)
            _ -> Error(Nil)
          }
        })
      let id = case name, get(fm, "id") {
        Ok([_, digits]), id if id != "" && id != digits -> [
          stem <> ": id " <> id <> " does not match the file name",
        ]
        _, _ -> []
      }
      let type_ = case get(fm, "type") {
        "" -> []
        t ->
          case list.contains(types, t) {
            True -> []
            False -> [
              stem
              <> ": type "
              <> pystr.repr(t)
              <> " is not one of "
              <> types_sorted,
            ]
          }
      }
      let status = case get(fm, "status") {
        "" -> []
        s ->
          case list.contains(statuses, s) {
            True -> []
            False -> [
              stem
              <> ": status "
              <> pystr.repr(s)
              <> " is not one of "
              <> statuses_sorted,
            ]
          }
      }
      let links =
        re.findall(link_re(), text)
        |> list.unique
        |> list.filter(fn(l) { l != stem })
        |> list.sort(string.compare)
      let no_links = case links {
        [] -> [stem <> ": links to no other note"]
        _ -> []
      }
      let dangling =
        list.filter_map(links, fn(l) {
          case list.contains(stems, l) {
            True -> Error(Nil)
            False -> Ok(stem <> ": [[" <> l <> "]] does not resolve")
          }
        })
      let unindexed = case list.contains(index_links, stem) {
        True -> []
        False -> [stem <> ": notes/index.md does not link to it"]
      }
      list.flatten([
        bad_name,
        missing,
        id,
        type_,
        status,
        no_links,
        dangling,
        unindexed,
      ])
    })
  let ids =
    pystr.duplicates(list.map(stems, string.slice(_, 0, 12)))
    |> list.map(fn(i) { "id " <> i <> " is used twice" })
  let index_dangling =
    index_links
    |> list.unique
    |> list.sort(string.compare)
    |> list.filter_map(fn(l) {
      case list.contains(stems, l) {
        True -> Error(Nil)
        False -> Ok("index.md: [[" <> l <> "]] does not resolve")
      }
    })
  list.flatten([per_note, ids, index_dangling])
}

fn read(path: String) -> String {
  case pystr.read_text(path) {
    Ok(s) -> s
    Error(e) -> {
      sys.eprintln("notes_check: " <> e)
      sys.exit(1)
    }
  }
}

pub fn main(_args: List(String)) -> Int {
  let notes =
    sys.glob("notes", ".md")
    |> list.filter(fn(p) { sys.base_name(p) != "index.md" })
    |> list.map(fn(p) { #(sys.stem(p), read(p)) })
  let unclosed =
    list.filter_map(notes, fn(n) {
      case front(n.1) {
        Ok(_) -> Error(Nil)
        Error(_) -> Ok(n.0 <> ": front matter has no closing ---")
      }
    })
  let errs = case unclosed {
    [] ->
      check(notes, case sys.exists("notes/index.md") {
        True -> read("notes/index.md")
        False -> ""
      })
    _ -> unclosed
  }
  list.each(errs, fn(e) { sys.eprintln("notes_check: " <> e) })
  case errs {
    [] -> {
      sys.eprintln(
        "notes_check: "
        <> int.to_string(list.length(notes))
        <> " notes, all linked",
      )
      0
    }
    _ -> 1
  }
}
