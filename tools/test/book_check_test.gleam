import fabric/book_check
import gleam/int
import gleam/list
import gleam/string

fn table() -> String {
  list.repeat(Nil, 50)
  |> list.index_map(fn(_, i) {
    let n = int.to_string(i + 1)
    "| " <> n <> " | T" <> n <> " | area | why | ☐ | proposed |"
  })
  |> string.join("\n")
}

pub fn full_table_test() {
  assert book_check.check(table()) == #([], 0)
}

pub fn named_twice_test() {
  let #(errs, _) = book_check.check(string.replace(table(), "| T2 |", "| T1 |"))
  assert errs == ["T1 is named twice"]
}

pub fn missing_row_test() {
  let #(errs, _) =
    book_check.check(string.replace(
      table(),
      "| 50 | T50 | area | why | ☐ | proposed |",
      "",
    ))
  assert errs
    == ["the table must have rows numbered 1 to 50 in order; it has 49 rows"]
}

pub fn open_row_test() {
  assert book_check.check(string.replace(
      table(),
      "| T3 | area | why | ☐ |",
      "| — | — | — | — |",
    ))
    == #([], 1)
}

pub fn bad_cited_and_status_test() {
  let text =
    table()
    |> string.replace("| T4 | area | why | ☐ |", "| T4 | area | why | x |")
    |> string.replace(
      "| T5 | area | why | ☐ | proposed |",
      "| T5 | area | why | ☐ | it's |",
    )
  let #(errs, _) = book_check.check(text)
  assert errs
    == [
      "row 5: status \"it's\" is not one of ['chosen', 'open', 'proposed', 'written']",
      "row 4: Cited 'x' is not ☑ or ☐",
    ]
}

pub fn authors_test() {
  let authors = "| 1 | T1 | `k` | 1 |\n| 2 | A | `k` | |"
  assert book_check.check_authors(authors, ["T1"]) == []
  assert book_check.check_authors(authors, ["T1", "T9"])
    == ["thinker T9 has no row"]
  assert book_check.check_authors(string.replace(authors, "| 2 |", "| 3 |"), [])
    == ["the rows must be numbered from 1 in order"]
  assert book_check.check_authors("| 1 | A | b | c |\n| 2 | A | b | c |", [])
    == ["A is named twice"]
}

pub fn named_test() {
  let assert [a, b, c, ..] =
    book_check.named(string.replace(table(), "| T3 |", "| — |"))
  assert [a, b, c] == ["T1", "T2", "T4"]
  assert book_check.named("| 1 | A | `k` | 1 |") == []
}
