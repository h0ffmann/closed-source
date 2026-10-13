//// Paper Fabric's tools, one subcommand per former Python script. Run through `tools/fabric`,
//// which builds this project and starts it at the repository root.

import fabric/arxiv
import fabric/logos
import fabric/sys
import fabric/zenodo_upload
import gleam/list
import gleam/string

fn commands() -> List(#(String, fn(List(String)) -> Int)) {
  [
    #("zenodo-upload", zenodo_upload.main),
    #("logos", logos.main),
    #("arxiv", arxiv.main),
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
