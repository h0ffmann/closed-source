//// logos: fetch the logos a paper's title page shows and convert them for XeLaTeX.
////
//// A paper's metadata.md lists them under `logos:`, each with the SVG's URL at a pinned commit
//// and its sha256. The logos are trademarks of their projects and are not licensed here, so they
//// are never committed: this command downloads each one at build time, checks the hash, and
//// writes build/<file> (a PDF, with rsvg-convert, since XeLaTeX cannot include an SVG).
////
////     tools/fabric logos closed-source

import fabric/json.{type Json}
import fabric/sys
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn main(args: List(String)) -> Int {
  case each_slug(args) {
    Ok(_) -> 0
    Error(e) -> {
      sys.eprintln("logos: " <> e)
      1
    }
  }
}

fn each_slug(slugs: List(String)) -> Result(Nil, String) {
  list.try_each(slugs, fn(slug) {
    use meta <- result.try(metadata(slug))
    list.try_each(json.get_list(meta, "logos"), fn(logo) {
      use out <- result.map(fetch(logo, "build"))
      sys.eprintln("logos: build/" <> out)
    })
  })
}

/// The paper's metadata.md front matter as JSON, through pandoc's $meta-json$.
pub fn metadata(slug: String) -> Result(Json, String) {
  let dir = sys.temp_dir()
  let tpl = sys.join(dir, "meta.tpl")
  let out = {
    use _ <- result.try(sys.write(tpl, "$meta-json$"))
    sys.check_output(
      "pandoc",
      [
        sys.join(sys.join("papers", slug), "metadata.md"),
        "--template",
        tpl,
        "-t",
        "plain",
      ],
      "",
    )
  }
  sys.remove_all(dir)
  use out <- result.try(out)
  json.decode(out)
}

/// The sha256 of the downloaded bytes must be the one metadata.md pins.
pub fn check(
  data: BitArray,
  sha256: String,
  url: String,
) -> Result(Nil, String) {
  case sys.sha256_hex(data) {
    got if got == sha256 -> Ok(Nil)
    got ->
      Error(url <> ": sha256 is " <> got <> ", metadata.md pins " <> sha256)
  }
}

/// Path(p).with_suffix(suffix)
pub fn with_suffix(path: String, suffix: String) -> String {
  let name = sys.base_name(path)
  let stem = case string.split(name, ".") {
    [_] | ["", _] -> name
    parts -> list.take(parts, list.length(parts) - 1) |> string.join(".")
  }
  string.drop_end(path, string.byte_size(name)) <> stem <> suffix
}

/// Downloads, checks and converts one logo unless build/<file> is there; returns <file>.
fn fetch(logo: Json, build: String) -> Result(String, String) {
  let file = json.get_string(logo, "file")
  let out = sys.join(build, file)
  case sys.exists(out) {
    True -> Ok(file)
    False -> {
      let url = json.get_string(logo, "svg")
      use #(status, data) <- result.try(sys.http("GET", url, [], <<>>))
      use _ <- result.try(case status >= 200 && status < 300 {
        True -> Ok(Nil)
        False -> Error(url <> ": HTTP Error " <> int.to_string(status))
      })
      use _ <- result.try(check(data, json.get_string(logo, "sha256"), url))
      use _ <- result.try(sys.make_dirs(sys.parent(out)))
      let svg = with_suffix(out, ".svg")
      use _ <- result.try(sys.write_bytes(svg, data))
      use status <- result.try(
        sys.run("rsvg-convert", ["-f", "pdf", "-o", out, svg], "")
        |> result.map(fn(r) { r.status }),
      )
      case status {
        0 -> Ok(file)
        s ->
          Error(
            "Command 'rsvg-convert -f pdf -o "
            <> out
            <> " "
            <> svg
            <> "' returned non-zero exit status "
            <> int.to_string(s)
            <> ".",
          )
      }
    }
  }
}
