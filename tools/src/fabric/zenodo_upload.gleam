//// zenodo-upload: put a paper's rendered PDFs, and nothing else, into one Zenodo deposit.
////
//// Paper Fabric's v0 release policy archives only the PDF. Zenodo's GitHub integration would
//// archive the whole source tree, so it stays switched off for this repository; this command uses
//// Zenodo's deposit API instead, with the metadata in .zenodo.json.
////
//// By default it creates a draft: nothing is public and no DOI is registered until a person
//// reviews the draft on zenodo.org and presses Publish (Ouroboric principle: humans steer; a DOI
//// is permanent). --publish publishes straight away and is meant for a human at a terminal.
////
//// Environment: ZENODO_TOKEN (scope deposit:write, plus deposit:actions for --publish);
//// ZENODO_URL (default https://zenodo.org; use https://sandbox.zenodo.org to rehearse).
//// --self-test stays a flag because citation.yml runs it.

import fabric/cli
import fabric/json.{type Json}
import fabric/sys
import gleam/bit_array
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

const zenodo_json = ".zenodo.json"

/// Keys the deposit API accepts from .zenodo.json as they are.
const keep = [
  "title", "upload_type", "publication_type", "description", "creators",
  "contributors", "license", "access_right", "language", "keywords",
  "related_identifiers", "notes",
]

const prog = "zenodo_upload.py"

const usage =
  "usage: zenodo_upload.py [-h] [--version VERSION]
                        [--concept-recid CONCEPT_RECID] [--publish]
                        [--dry-run] [--self-test]
                        [pdf ...]
"

const help =
  "

zenodo_upload — put a paper's rendered PDFs, and nothing else, into one Zenodo deposit.

Paper Fabric's v0 release policy archives only the PDF. Zenodo's GitHub integration would archive
the whole source tree, so it stays switched off for this repository; this script uses Zenodo's
deposit API instead, with the metadata in .zenodo.json.

By default it creates a **draft**: nothing is public and no DOI is registered until a person
reviews the draft on zenodo.org and presses Publish (Ouroboric principle: humans steer; a DOI is
permanent). --publish publishes straight away and is meant for a human at a terminal, not CI.

    scripts/zenodo_upload.py pdf/closed-source.pdf pdf/closed-source-ste.pdf --version v0.1.0 --dry-run
    ZENODO_TOKEN=... scripts/zenodo_upload.py pdf/closed-source.pdf --version v0.1.0
    ZENODO_TOKEN=... scripts/zenodo_upload.py pdf/closed-source.pdf --version v0.2.0 --concept-recid 123
    scripts/zenodo_upload.py --self-test

Environment: ZENODO_TOKEN (scope deposit:write, plus deposit:actions for --publish);
ZENODO_URL (default https://zenodo.org; use https://sandbox.zenodo.org to rehearse).

positional arguments:
  pdf

options:
  -h, --help            show this help message and exit
  --version VERSION
  --concept-recid CONCEPT_RECID
                        concept record id of the paper, to add a new version
  --publish             publish now (mints a permanent DOI)
  --dry-run
  --self-test
"

/// The deposit API's {"metadata": ...}: the kept keys in `keep`'s order, then the version.
pub fn deposit_metadata(meta: Json, version: String) -> Json {
  let kept =
    list.filter_map(keep, fn(k) {
      json.get(meta, k) |> result.map(fn(v) { #(k, v) })
    })
  json.Object([
    #(
      "metadata",
      json.Object(list.append(kept, [#("version", json.String(version))])),
    ),
  ])
}

pub fn main(args: List(String)) -> Int {
  let parsed =
    cli.parse(
      args,
      [
        cli.Value("--version"),
        cli.Value("--concept-recid"),
        cli.Flag("--publish"),
        cli.Flag("--dry-run"),
        cli.Flag("--self-test"),
      ],
      cli.Star,
    )
  case parsed {
    Error(cli.Help) -> {
      io.print(usage <> string.drop_start(help, 1))
      0
    }
    Error(cli.Usage(msg)) -> cli.fail(usage, prog, msg)
    Ok(p) ->
      case cli.flag(p, "--self-test") {
        True -> self_test()
        False -> run(p)
      }
  }
}

fn run(p: cli.Parsed) -> Int {
  let pdfs = list.map(p.positionals, normalise)
  case pdfs, cli.value(p, "--version") {
    [_, ..], Ok(version) if version != "" ->
      case list.find(pdfs, fn(f) { !is_pdf(f) }) {
        Ok(bad) ->
          cli.fail(
            usage,
            prog,
            bad <> " is not a PDF file; v0 archives rendered PDFs only",
          )
        Error(_) -> {
          let base =
            sys.getenv("ZENODO_URL") |> result.unwrap("https://zenodo.org")
          let recid = cli.value(p, "--concept-recid") |> result.unwrap("")
          let publish = cli.flag(p, "--publish")
          case cli.flag(p, "--dry-run") {
            True -> dry_run(pdfs, version, recid, publish, base)
            False ->
              case sys.getenv("ZENODO_TOKEN") {
                Ok(token) if token != "" ->
                  case upload(pdfs, version, recid, publish, base, token) {
                    Ok(dep) -> {
                      let state = case truthy(json.get(dep, "submitted")) {
                        True -> "published"
                        False -> "draft, waiting for a human to publish"
                      }
                      let links =
                        json.get(dep, "links") |> result.unwrap(json.Null)
                      let link = case json.get(links, "html") {
                        Ok(l) -> l
                        Error(_) ->
                          json.get(links, "self") |> result.unwrap(json.Null)
                      }
                      sys.eprintln(
                        "zenodo_upload: " <> state <> ": " <> py_str(link),
                      )
                      0
                    }
                    Error(e) -> {
                      sys.eprintln("zenodo_upload: " <> e)
                      1
                    }
                  }
                _ -> {
                  sys.eprintln(
                    "zenodo_upload: ZENODO_TOKEN is not set; nothing uploaded",
                  )
                  1
                }
              }
          }
        }
      }
    _, _ -> cli.fail(usage, prog, "at least one PDF and --version are required")
  }
}

fn dry_run(
  pdfs: List(String),
  version: String,
  recid: String,
  publish: Bool,
  base: String,
) -> Int {
  case read_meta() {
    Error(e) -> {
      sys.eprintln("zenodo_upload: " <> e)
      1
    }
    Ok(meta) -> {
      let action = case publish {
        True -> "publish"
        False -> "leave as draft"
      }
      let names =
        list.map(pdfs, fn(f) {
          let size = case sys.read_bytes(f) {
            Ok(b) -> bit_array.byte_size(b)
            Error(_) -> 0
          }
          f <> " (" <> int.to_string(size) <> " bytes)"
        })
        |> string.join(", ")
      let target = case recid {
        "" -> "new record"
        r -> "new version of " <> r
      }
      sys.eprintln(
        "zenodo_upload: would upload "
        <> names
        <> " to "
        <> base
        <> ", "
        <> target
        <> ", then "
        <> action,
      )
      io.print(json.encode(deposit_metadata(meta, version), 2, False) <> "\n")
      0
    }
  }
}

fn read_meta() -> Result(Json, String) {
  use text <- result.try(sys.read(zenodo_json))
  json.decode(text) |> result.map_error(fn(e) { zenodo_json <> ": " <> e })
}

/// One API call: the parsed JSON reply ({} when the body is empty), or an error for a status
/// that urllib would have raised on.
fn call(
  method: String,
  url: String,
  token: String,
  body: Result(#(BitArray, String), Nil),
) -> Result(Json, String) {
  let auth = #("Authorization", "Bearer " <> token)
  let #(headers, data) = case body {
    Ok(#(data, ctype)) -> #([auth, #("Content-Type", ctype)], data)
    Error(_) -> #([auth], <<>>)
  }
  use #(status, raw) <- result.try(sys.http(method, url, headers, data))
  case status >= 200 && status < 300, raw {
    False, _ ->
      Error(method <> " " <> url <> ": HTTP Error " <> int.to_string(status))
    True, <<>> -> Ok(json.Object([]))
    True, _ ->
      case bit_array.to_string(raw) {
        Ok(text) ->
          json.decode(text)
          |> result.map_error(fn(e) { method <> " " <> url <> ": " <> e })
        Error(_) -> Error(method <> " " <> url <> ": reply is not UTF-8")
      }
  }
}

fn link(j: Json, name: String) -> Result(String, String) {
  case json.get(j, "links") |> result.try(json.get(_, name)) {
    Ok(json.String(s)) -> Ok(s)
    _ -> Error("the deposit has no links." <> name)
  }
}

fn upload(
  pdfs: List(String),
  version: String,
  recid: String,
  publish: Bool,
  base: String,
  token: String,
) -> Result(Json, String) {
  let root = strip_slashes(base)
  let api = root <> "/api/deposit/depositions"
  use draft <- result.try(case recid {
    // A new version of an existing record: Zenodo copies the previous files; remove them so
    // the new version holds only this PDF. The concept record id resolves to the latest
    // published version, which is the one Zenodo accepts a newversion action on.
    "" -> call("POST", api, token, Ok(#(<<"{}":utf8>>, "application/json")))
    _ -> {
      use rec <- result.try(call(
        "GET",
        root <> "/api/records/" <> recid,
        token,
        Error(Nil),
      ))
      use latest <- result.try(case json.get(rec, "id") {
        Ok(id) -> Ok(py_str(id))
        Error(_) -> Error("the record has no id")
      })
      use nv <- result.try(call(
        "POST",
        api <> "/" <> latest <> "/actions/newversion",
        token,
        Error(Nil),
      ))
      use url <- result.try(link(nv, "latest_draft"))
      use draft <- result.try(call("GET", url, token, Error(Nil)))
      use _ <- result.try(
        list.try_each(json.get_list(draft, "files"), fn(f) {
          use url <- result.try(link(f, "self"))
          call("DELETE", url, token, Error(Nil))
        }),
      )
      Ok(draft)
    }
  })
  use bucket <- result.try(link(draft, "bucket"))
  use _ <- result.try(
    list.try_each(pdfs, fn(pdf) {
      use data <- result.try(sys.read_bytes(pdf))
      call(
        "PUT",
        bucket <> "/" <> sys.base_name(pdf),
        token,
        Ok(#(data, "application/octet-stream")),
      )
    }),
  )
  use meta <- result.try(read_meta())
  let body = json.encode(deposit_metadata(meta, version), 0, True)
  use self <- result.try(link(draft, "self"))
  use draft <- result.try(call(
    "PUT",
    self,
    token,
    Ok(#(<<body:utf8>>, "application/json")),
  ))
  case publish {
    False -> Ok(draft)
    True -> {
      use url <- result.try(link(draft, "publish"))
      call("POST", url, token, Error(Nil))
    }
  }
}

fn strip_slashes(s: String) -> String {
  case string.ends_with(s, "/") {
    True -> strip_slashes(string.drop_end(s, 1))
    False -> s
  }
}

/// str() of a JSON value as Python prints it after json.loads.
fn py_str(j: Json) -> String {
  case j {
    json.String(s) -> s
    json.Null -> "None"
    json.Bool(True) -> "True"
    json.Bool(False) -> "False"
    _ -> json.encode(j, 0, True)
  }
}

fn truthy(j: Result(Json, Nil)) -> Bool {
  case j {
    Ok(json.Bool(b)) -> b
    Ok(json.Int(i)) -> i != 0
    Ok(json.Float(f)) -> f != 0.0
    Ok(json.String(s)) -> s != ""
    Ok(json.Array(l)) -> l != []
    Ok(json.Object(l)) -> l != []
    _ -> False
  }
}

/// str(Path(p)): repeated slashes and "." parts dropped, as pathlib prints a path.
pub fn normalise(p: String) -> String {
  let lead = case string.starts_with(p, "//") && !string.starts_with(p, "///") {
    True -> "//"
    False ->
      case string.starts_with(p, "/") {
        True -> "/"
        False -> ""
      }
  }
  let parts = string.split(p, "/") |> list.filter(fn(s) { s != "" && s != "." })
  case lead, parts {
    "", [] -> "."
    _, _ -> lead <> string.join(parts, "/")
  }
}

/// pdf.suffix.lower() == ".pdf" and pdf.is_file()
pub fn is_pdf(p: String) -> Bool {
  let name = sys.base_name(p)
  string.ends_with(string.lowercase(name), ".pdf")
  && string.length(name) > 4
  && sys.exists(p)
  && !sys.is_dir(p)
}

fn self_test() -> Int {
  let meta =
    json.Object([
      #("title", json.String("t")),
      #("upload_type", json.String("publication")),
      #("publication_type", json.String("preprint")),
      #("x", json.Int(1)),
    ])
  let assert Ok(json.Object(got)) =
    deposit_metadata(meta, "v0.1.0") |> json.get("metadata")
  let assert True =
    got
    == [
      #("title", json.String("t")),
      #("upload_type", json.String("publication")),
      #("publication_type", json.String("preprint")),
      #("version", json.String("v0.1.0")),
    ]
  let assert Ok(real) = read_meta()
  let assert Ok(real) = deposit_metadata(real, "v0.0.0") |> json.get("metadata")
  let assert Ok(json.String("publication")) = json.get(real, "upload_type")
  let assert Error(_) = json.get(real, "doi")
  sys.eprintln("zenodo_upload: self-test ok")
  0
}
