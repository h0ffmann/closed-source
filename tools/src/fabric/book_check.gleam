//// book-check: the book's hard rule (AGENTS.md): 50 thinkers, two pages each, 100 pages.
////
//// Checks 50THINKERS.md (columns # | Thinker | Area | Why | Cited | Status): rows numbered 1 to
//// 50 in order, no thinker named twice, a known status, and Cited is ☑ or ☐ on a named row. The
//// order of the names is shuffled on purpose (an essay, not a ranking), so it is not checked.
//// Open rows (thinker "—") are allowed while the roster is a draft; the check says how many are
//// left. Checks 500AUTHORS.md, the long list the thinkers come from: at most 500 rows numbered
//// from 1 in order, no author named twice, and every named thinker listed.
////
////     tools/fabric book-check

import fabric/pystr
import fabric/re
import fabric/sys
import gleam/int
import gleam/list
import gleam/string

const thinkers = 50

const authors = 500

const statuses = ["open", "proposed", "chosen", "written"]

const statuses_sorted = "['chosen', 'open', 'proposed', 'written']"

const cited = ["☑", "☐"]

const open = ["—", "-", ""]

fn row_re() -> re.Regex {
  re.compile(
    "^\\|\\s*(\\d+)\\s*\\|\\s*([^|]*?)\\s*\\|\\s*([^|]*?)\\s*\\|\\s*([^|]*?)\\s*\\|\\s*$",
    [],
  )
}

fn thinker_re() -> re.Regex {
  re.compile(
    "^\\|\\s*(\\d+)\\s*\\|"
      <> string.repeat("\\s*([^|]*?)\\s*\\|", 5)
      <> "\\s*$",
    [],
  )
}

/// Each line's groups, for the lines the pattern matches.
fn rows(r: re.Regex, text: String) -> List(List(String)) {
  list.filter_map(pystr.splitlines(text), fn(line) {
    case re.first(r, line) {
      Ok([_, ..groups]) -> Ok(groups)
      _ -> Error(Nil)
    }
  })
}

fn at(row: List(String), i: Int) -> String {
  case list.drop(row, i) {
    [x, ..] -> x
    [] -> ""
  }
}

/// The rows are numbered 1, 2, 3, ... in order.
fn in_order(rows: List(List(String))) -> Bool {
  list.index_map(rows, fn(r, i) { pystr.to_int(at(r, 0)) == i + 1 })
  |> list.all(fn(ok) { ok })
}

/// The errors in 50THINKERS.md, and how many rows are still open.
pub fn check(text: String) -> #(List(String), Int) {
  let rows = rows(thinker_re(), text)
  let numbering = case in_order(rows) && list.length(rows) == thinkers {
    True -> []
    False -> [
      "the table must have rows numbered 1 to "
      <> int.to_string(thinkers)
      <> " in order; it has "
      <> int.to_string(list.length(rows))
      <> " rows",
    ]
  }
  let names =
    list.map(rows, at(_, 1)) |> list.filter(fn(n) { !list.contains(open, n) })
  let twice =
    list.map(pystr.duplicates(names), fn(n) { n <> " is named twice" })
  let status =
    list.filter_map(rows, fn(r) {
      case list.contains(statuses, at(r, 5)) {
        True -> Error(Nil)
        False ->
          Ok(
            "row "
            <> at(r, 0)
            <> ": status "
            <> pystr.repr(at(r, 5))
            <> " is not one of "
            <> statuses_sorted,
          )
      }
    })
  let cites =
    list.filter_map(rows, fn(r) {
      case list.contains(open, at(r, 1)) || list.contains(cited, at(r, 4)) {
        True -> Error(Nil)
        False ->
          Ok(
            "row "
            <> at(r, 0)
            <> ": Cited "
            <> pystr.repr(at(r, 4))
            <> " is not ☑ or ☐",
          )
      }
    })
  #(
    list.flatten([numbering, twice, status, cites]),
    thinkers - list.length(names),
  )
}

/// The errors in 500AUTHORS.md, given the thinkers named in 50THINKERS.md.
pub fn check_authors(text: String, named: List(String)) -> List(String) {
  let rows = rows(row_re(), text)
  let n = list.length(rows)
  let numbering = case in_order(rows) {
    True -> []
    False -> ["the rows must be numbered from 1 in order"]
  }
  let size = case n > authors {
    True -> [
      "the table has "
      <> int.to_string(n)
      <> " rows; the long list holds at most "
      <> int.to_string(authors),
    ]
    False -> []
  }
  let names = list.map(rows, at(_, 1))
  let twice =
    list.map(pystr.duplicates(names), fn(n) { n <> " is named twice" })
  let missing =
    list.filter_map(named, fn(t) {
      case list.contains(names, t) {
        True -> Error(Nil)
        False -> Ok("thinker " <> t <> " has no row")
      }
    })
  list.flatten([numbering, size, twice, missing])
}

/// The thinkers named in 50THINKERS.md, open rows left out.
pub fn named(text: String) -> List(String) {
  rows(thinker_re(), text)
  |> list.map(at(_, 1))
  |> list.filter(fn(n) { !list.contains(open, n) })
}

pub fn main(_args: List(String)) -> Int {
  case pystr.read_text("50THINKERS.md") {
    Error(e) -> {
      sys.eprintln("book_check: " <> e)
      1
    }
    Ok(text) -> {
      let #(errs, left) = check(text)
      let errs = list.map(errs, fn(e) { "50THINKERS.md: " <> e })
      let #(errs, n) = case sys.exists("500AUTHORS.md") {
        False -> #(errs, 0)
        True ->
          case pystr.read_text("500AUTHORS.md") {
            Ok(a) -> #(
              list.append(
                errs,
                list.map(check_authors(a, named(text)), fn(e) {
                  "500AUTHORS.md: " <> e
                }),
              ),
              list.length(rows(row_re(), a)),
            )
            Error(e) -> #(list.append(errs, [e]), 0)
          }
      }
      list.each(errs, fn(e) { sys.eprintln("book_check: " <> e) })
      case errs {
        [] -> {
          sys.eprintln(
            "book_check: "
            <> int.to_string(thinkers)
            <> " thinkers, "
            <> int.to_string(left)
            <> " still open; "
            <> int.to_string(n)
            <> " of "
            <> int.to_string(authors)
            <> " authors",
          )
          0
        }
        _ -> 1
      }
    }
  }
}
