//// Paper Fabric's tools, one subcommand per former Python script. Run through `tools/fabric`,
//// which builds this project and starts it at the repository root.

import fabric/book_check
import fabric/cite_check
import fabric/notes_check
import fabric/refs_check
import fabric/sys
import gleam/list
import gleam/string

fn commands() -> List(#(String, fn(List(String)) -> Int)) {
  [
    #("book-check", book_check.main),
    #("cite-check", cite_check.main),
    #("notes-check", notes_check.main),
    #("refs-check", refs_check.main),
  ]
}

pub fn main() -> Nil {
  case sys.args() {
    [name, ..rest] ->
      case list.key_find(commands(), name) {
        Ok(command) -> sys.exit(command(rest))
        Error(_) -> usage()
      }
    [] -> usage()
  }
}

fn usage() -> Nil {
  sys.eprintln(
    "usage: tools/fabric <command> [args]\ncommands: "
    <> string.join(list.map(commands(), fn(c) { c.0 }), ", "),
  )
  sys.exit(2)
}
