//// citation — .zenodo.json is the one hand-edited citation file; CITATION.cff is generated from it.
////
//// Zenodo reads only .zenodo.json when both exist, and GitHub's "Cite this repository" reads only
//// CITATION.cff, so the CFF is derived here, with the BibTeX, APA and ABNT references between the
//// READMEs' citation markers, and --check fails when any of them drifts. Ported from
//// scripts/citation.py (copied from h0ffmann/picasso, itself from marola-dev/marola's MIP-0079).
////
////     tools/fabric citation               # validate, rewrite CITATION.cff and the READMEs' block
////     tools/fabric citation --check       # validate; exit 1 if any generated text is stale
////     tools/fabric citation add --name "Family, Given" [--orcid ID] [--affiliation TEXT]
////                          [--type Researcher | --author]
////     tools/fabric citation --self-test   # kept: citation.yml runs it

import fabric/html
import fabric/json.{type Json}
import fabric/re
import fabric/sys
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub const zenodo = ".zenodo.json"

pub const cff = "CITATION.cff"

pub const readmes = ["README.md"]

pub const start = "<!-- citation:start -->"

pub const end = "<!-- citation:end -->"

// The concept DOI resolves to the latest release. Zenodo minted it with v0.1.0, the first release
// its webhook archived (docs/4-ways-of-working/releasing.md).
pub const concept_doi = "10.5281/zenodo.23333656"

const name = "Closed Source: The God that Failed"

const homepage = "https://github.com/h0ffmann/closed-source"

const year = "2026"

// developers.zenodo.org, deposit metadata, checked 2026-10-07.
const relations = [
  "isCitedBy", "cites", "isSupplementTo", "isSupplementedBy", "isContinuedBy",
  "continues", "isDescribedBy", "describes", "hasMetadata", "isMetadataFor",
  "isNewVersionOf", "isPreviousVersionOf", "isPartOf", "hasPart",
  "isReferencedBy", "references", "isDocumentedBy", "documents", "isCompiledBy",
  "compiles", "isVariantFormOf", "isOriginalFormof", "isIdenticalTo",
  "isAlternateIdentifier", "isReviewedBy", "reviews", "isDerivedFrom",
  "isSourceOf", "requires", "isRequiredBy", "isObsoletedBy", "obsoletes",
]

// Sorted, as argparse's choices=sorted(CONTRIBUTOR_TYPES) prints them.
const contributor_types = [
  "ContactPerson", "DataCollector", "DataCurator", "DataManager", "Distributor",
  "Editor", "HostingInstitution", "Other", "Producer", "ProjectLeader",
  "ProjectManager", "ProjectMember", "RegistrationAgency",
  "RegistrationAuthority", "RelatedPerson", "ResearchGroup", "Researcher",
  "RightsHolder", "Sponsor", "Supervisor", "WorkPackageLeader",
]

const spdx = [
  #("mit", "MIT"),
  #("agpl-3.0-only", "AGPL-3.0-only"),
  #("cc-by-4.0", "CC-BY-4.0"),
]

// Zenodo publication types accepted for upload_type "publication", sorted.
const publication_types = [
  "article", "preprint", "report", "technicalnote", "workingpaper",
]

// Zenodo sets these itself (version from the tag, date from the release, DOI minted); a value
// here would override or break that.
const forbidden = ["version", "publication_date", "doi", "prereserve_doi"]

pub fn orcid_ok(orcid: String) -> Bool {
  case re.search(re.compile("^\\d{4}-\\d{4}-\\d{4}-\\d{3}[\\dX]$", []), orcid) {
    False -> False
    True -> {
      let digits =
        string.replace(orcid, "-", "")
        |> string.to_utf_codepoints
        |> list.map(string.utf_codepoint_to_int)
      let assert Ok(last) = list.last(digits)
      let total =
        list.take(digits, list.length(digits) - 1)
        |> list.fold(0, fn(t, c) { { t + c - 0x30 } * 2 })
      let check = { 12 - total % 11 } % 11
      case check {
        10 -> last == 0x58
        _ -> last == 0x30 + check
      }
    }
  }
}

fn person_errors(p: Json, where: String) -> List(String) {
  let name_re = re.compile("^[^,]+, [^,]+$", [])
  let name_errs = case re.search(name_re, json.get_string(p, "name")) {
    True -> []
    False -> [
      where
      <> ": name "
      <> repr(json.get(p, "name") |> result.unwrap(json.Null))
      <> " is not 'Family, Given'",
    ]
  }
  let orcid_errs = case json.get(p, "orcid") {
    Ok(o) ->
      case orcid_ok(json.get_string(p, "orcid")) {
        True -> []
        False -> [
          where <> ": orcid " <> repr(o) <> " is not a valid bare ORCID iD",
        ]
      }
    Error(_) -> []
  }
  list.append(name_errs, orcid_errs)
}

/// Python's truthiness of meta.get(key).
fn truthy(j: Result(Json, Nil)) -> Bool {
  case j {
    Error(_) | Ok(json.Null) | Ok(json.Bool(False)) | Ok(json.Int(0)) -> False
    Ok(json.String("")) | Ok(json.Array([])) | Ok(json.Object([])) -> False
    Ok(json.Float(f)) -> f != 0.0
    _ -> True
  }
}

fn get_or_null(j: Json, key: String) -> Json {
  json.get(j, key) |> result.unwrap(json.Null)
}

fn is_one_of(j: Result(Json, Nil), options: List(String)) -> Bool {
  case j {
    Ok(json.String(s)) -> list.contains(options, s)
    _ -> False
  }
}

pub fn validate(meta: Json) -> List(String) {
  let missing =
    ["title", "description", "creators", "license", "keywords", "language"]
    |> list.filter(fn(k) { !truthy(json.get(meta, k)) })
    |> list.map(fn(k) { "missing " <> k })
  let upload = json.get(meta, "upload_type")
  let upload_errs = case
    is_one_of(upload, ["software", "dataset", "publication"])
  {
    True -> []
    False -> ["upload_type must be software, dataset or publication"]
  }
  let pub_errs = case
    upload == Ok(json.String("publication"))
    && !is_one_of(json.get(meta, "publication_type"), publication_types)
  {
    True -> [
      "publication_type must be one of " <> repr_list(publication_types),
    ]
    False -> []
  }
  let access_errs = case json.get(meta, "access_right") {
    Ok(json.String("open")) -> []
    _ -> ["access_right must be open"]
  }
  let license_errs = case
    is_one_of(json.get(meta, "license"), list.map(spdx, fn(s) { s.0 }))
  {
    True -> []
    False -> [
      "license "
      <> repr(get_or_null(meta, "license"))
      <> " has no SPDX mapping here",
    ]
  }
  let language_errs = case
    re.search(re.compile("^[a-z]{3}\\z", []), json.get_string(meta, "language"))
  {
    True -> []
    False -> ["language must be an ISO 639-3 code such as eng"]
  }
  let forbidden_errs =
    forbidden
    |> list.filter(fn(k) { json.get(meta, k) != Error(Nil) })
    |> list.map(fn(k) { k <> " is set by Zenodo; remove it" })
  let creator_errs =
    json.get_list(meta, "creators")
    |> list.index_map(fn(p, i) {
      person_errors(p, "creators[" <> int.to_string(i) <> "]")
    })
    |> list.flatten
  let contributor_errs =
    json.get_list(meta, "contributors")
    |> list.index_map(fn(p, i) {
      let where = "contributors[" <> int.to_string(i) <> "]"
      let type_errs = case is_one_of(json.get(p, "type"), contributor_types) {
        True -> []
        False -> [
          where
          <> ": type "
          <> repr(get_or_null(p, "type"))
          <> " is not Zenodo's",
        ]
      }
      list.append(person_errors(p, where), type_errs)
    })
    |> list.flatten
  let related_errs =
    json.get_list(meta, "related_identifiers")
    |> list.index_map(fn(r, i) {
      let where = "related_identifiers[" <> int.to_string(i) <> "]"
      let rel_errs = case is_one_of(json.get(r, "relation"), relations) {
        True -> []
        False -> [
          where
          <> ": relation "
          <> repr(get_or_null(r, "relation"))
          <> " unknown",
        ]
      }
      let ident = json.get(r, "identifier") |> result.unwrap(json.String(""))
      let ident_s = json.get_string(r, "identifier")
      let scheme_errs = case json.get(r, "scheme") {
        Ok(json.String("doi")) ->
          case re.search(re.compile("^10\\.\\d{4,9}/\\S+$", []), ident_s) {
            True -> []
            False -> [where <> ": " <> repr(ident) <> " is not a bare DOI"]
          }
        Ok(json.String("url")) ->
          case string.starts_with(ident_s, "https://") {
            True -> []
            False -> [where <> ": " <> repr(ident) <> " is not an https URL"]
          }
        _ -> [where <> ": scheme must be doi or url"]
      }
      list.append(rel_errs, scheme_errs)
    })
    |> list.flatten
  list.flatten([
    missing,
    upload_errs,
    pub_errs,
    access_errs,
    license_errs,
    language_errs,
    forbidden_errs,
    creator_errs,
    contributor_errs,
    related_errs,
  ])
}

/// json.dumps(x, ensure_ascii=False)
fn q(j: Json) -> String {
  json.encode(j, 0, False)
}

fn qs(s: String) -> String {
  json.quote(s, False)
}

/// The description as plain text: paragraphs split by a blank line, tags dropped, entities
/// decoded.
pub fn plain(description: String) -> String {
  let text = re.sub(re.compile("</p>\\s*<p>", []), description, "\n\n")
  re.sub(re.compile("<[^>]+>", []), text, "")
  |> html.unescape
  |> py_strip
}

fn repo(meta: Json) -> Result(String, String) {
  json.get_list(meta, "related_identifiers")
  |> list.find(fn(r) {
    json.get(r, "relation") == Ok(json.String("isSupplementTo"))
    && string.starts_with(
      json.get_string(r, "identifier"),
      "https://github.com/",
    )
  })
  |> result.map(fn(r) { json.get_string(r, "identifier") })
  |> result.replace_error(
    "no related_identifiers entry with relation isSupplementTo and a https://github.com/ URL",
  )
}

fn split_name(p: Json) -> #(String, String) {
  case string.split_once(json.get_string(p, "name"), ", ") {
    Ok(fg) -> fg
    Error(_) -> #(json.get_string(p, "name"), "")
  }
}

pub fn render_cff(meta: Json, doi: String) -> Result(String, String) {
  use repo <- result.map(repo(meta))
  let upload = json.get_string(meta, "upload_type")
  let title = get_or_null(meta, "title")
  let abstract =
    string.split(plain(json.get_string(meta, "description")), "\n\n")
    |> list.flat_map(fn(para) {
      list.append(list.map(wrap(para, 96), fn(l) { "  " <> l }), [""])
    })
  let abstract = list.take(abstract, list.length(abstract) - 1)
  let creators = json.get_list(meta, "creators")
  let authors =
    list.flat_map(creators, fn(p) {
      let #(family, given) = split_name(p)
      list.flatten([
        ["  - family-names: " <> qs(family), "    given-names: " <> qs(given)],
        case json.get(p, "orcid") {
          Ok(_) -> [
            "    orcid: \"https://orcid.org/"
            <> json.get_string(p, "orcid")
            <> "\"",
          ]
          Error(_) -> []
        },
        case json.get(p, "affiliation") {
          Ok(a) -> ["    affiliation: " <> q(a)]
          Error(_) -> []
        },
      ])
    })
  let doi_lines = case doi {
    "" -> []
    _ -> [
      "doi: " <> doi,
      "identifiers:",
      "  - type: doi",
      "    value: " <> doi,
      "    description: Concept DOI, resolves to the latest release",
    ]
  }
  let license =
    list.key_find(spdx, json.get_string(meta, "license"))
    |> result.unwrap("")
  let preferred = case upload {
    "publication" ->
      list.flatten([
        [
          "preferred-citation:",
          "  type: generic",
          "  title: " <> q(title),
          "  authors:",
        ],
        list.flat_map(creators, fn(p) {
          let #(family, given) = split_name(p)
          [
            "    - family-names: " <> qs(family),
            "      given-names: " <> qs(given),
            ..case json.get(p, "orcid") {
              Ok(_) -> [
                "      orcid: \"https://orcid.org/"
                <> json.get_string(p, "orcid")
                <> "\"",
              ]
              Error(_) -> []
            }
          ]
        }),
        [
          "  year: " <> year,
          "  medium: " <> q(get_or_null(meta, "publication_type")),
          "  url: \"" <> repo <> "\"",
        ],
        case doi {
          "" -> []
          _ -> ["  doi: " <> doi]
        },
      ])
    _ -> []
  }
  list.flatten([
    [
      "# Generated from .zenodo.json by tools/fabric citation; edit that file, then `just citation`.",
      "cff-version: 1.2.0",
      "message: \"If you use "
        <> name
        <> ", please cite it using the metadata below.\"",
      "type: "
        <> case upload {
        "dataset" -> "dataset"
        _ -> "software"
      },
      "title: " <> q(title),
      "abstract: >-",
    ],
    abstract,
    ["authors:"],
    authors,
    ["repository-code: \"" <> repo <> "\"", "url: \"" <> homepage <> "\""],
    doi_lines,
    ["license: " <> license, "keywords:"],
    list.map(json.get_list(meta, "keywords"), fn(k) { "  - " <> q(k) }),
    preferred,
  ])
  |> string.join("\n")
  <> "\n"
}

/// Greedy word wrap at `width` code points, words split on Python's whitespace.
pub fn wrap(text: String, width: Int) -> List(String) {
  let #(lines, line) =
    list.fold(py_split(text), #([], ""), fn(acc, word) {
      let #(lines, line) = acc
      case line != "" && string.length(line) + 1 + string.length(word) > width {
        True -> #([line, ..lines], word)
        False ->
          case line {
            "" -> #(lines, word)
            _ -> #(lines, line <> " " <> word)
          }
      }
    })
  case line {
    "" -> list.reverse(lines)
    _ -> list.reverse([line, ..lines])
  }
}

/// Adds a contributor (or, with `author`, a creator); Error when the name is already listed.
pub fn add_person(
  meta: Json,
  name: String,
  orcid: String,
  affiliation: String,
  ctype: String,
  author: Bool,
) -> Result(Json, String) {
  let person =
    list.flatten([
      [#("name", json.String(name))],
      case affiliation {
        "" -> []
        _ -> [#("affiliation", json.String(affiliation))]
      },
      case orcid {
        "" -> []
        _ -> [#("orcid", json.String(orcid))]
      },
      case author {
        True -> []
        False -> [#("type", json.String(ctype))]
      },
    ])
  let key = case author {
    True -> "creators"
    False -> "contributors"
  }
  let listed =
    list.append(
      json.get_list(meta, "creators"),
      json.get_list(meta, "contributors"),
    )
    |> list.any(fn(p) { json.get(p, "name") == Ok(json.String(name)) })
  case listed {
    True -> Error(name <> " is already listed")
    False ->
      Ok(json.set(
        meta,
        key,
        json.Array(list.append(json.get_list(meta, key), [json.Object(person)])),
      ))
  }
}

pub fn write_json(path: String, meta: Json) -> Result(Nil, String) {
  sys.write(path, json.encode(meta, 2, False) <> "\n")
}

fn initials(given: String) -> String {
  py_split(given)
  |> list.map(fn(part) { first_codepoint(part) <> "." })
  |> string.join(" ")
}

fn first_codepoint(s: String) -> String {
  case string.to_utf_codepoints(s) {
    [c, ..] -> string.from_utf_codepoints([c])
    [] -> ""
  }
}

fn slug(s: String) -> String {
  re.sub(re.compile("[^a-z0-9]", []), string.lowercase(s), "")
}

pub fn render_refs(meta: Json, doi: String) -> Result(String, String) {
  use repo <- result.map(repo(meta))
  let people = list.map(json.get_list(meta, "creators"), split_name)
  let title = json.get_string(meta, "title")
  let #(short, sub) = case string.split_once(title, ": ") {
    Ok(ss) -> ss
    Error(_) -> #(title, "")
  }
  let #(kind, medium) = case json.get_string(meta, "upload_type") {
    "publication" -> #("misc", "Preprint")
    _ -> #("software", "Computer software")
  }
  let family_slug = case people {
    [#(f, _), ..] -> slug(f)
    [] -> ""
  }
  let bib =
    list.flatten([
      [
        "@"
          <> kind
          <> "{"
          <> family_slug
          <> "_"
          <> year
          <> "_"
          <> slug(short)
          <> ",",
        "  author    = {"
          <> string.join(
          list.map(people, fn(p) { p.0 <> ", " <> p.1 }),
          " and ",
        )
          <> "},",
        "  title     = {{" <> title <> "}},",
        "  year      = {" <> year <> "},",
      ],
      case doi {
        "" -> []
        _ -> ["  publisher = {Zenodo},", "  doi       = {" <> doi <> "},"]
      },
      ["  url       = {" <> repo <> "}", "}"],
    ])
  let apa_names = list.map(people, fn(p) { p.0 <> ", " <> initials(p.1) })
  let apa_authors = case list.reverse(apa_names) {
    [one] -> one
    [last, ..rest] -> string.join(list.reverse(rest), ", ") <> ", & " <> last
    [] -> ""
  }
  let where = case doi {
    "" -> repo
    _ -> "Zenodo. https://doi.org/" <> doi
  }
  let apa =
    apa_authors
    <> " ("
    <> year
    <> "). *"
    <> title
    <> "* ["
    <> medium
    <> "]. "
    <> where
  let abnt_authors =
    people
    |> list.map(fn(p) { string.uppercase(p.0) <> ", " <> p.1 })
    |> string.join("; ")
  let abnt_title = case sub {
    "" -> "**" <> title <> "**"
    _ -> "**" <> short <> "**: " <> sub
  }
  let abnt = case doi {
    "" ->
      abnt_authors
      <> ". "
      <> abnt_title
      <> ". [S. l.]: GitHub, "
      <> year
      <> ". Disponível em: "
      <> repo
      <> "."
    _ ->
      abnt_authors
      <> ". "
      <> abnt_title
      <> ". [S. l.]: Zenodo, "
      <> year
      <> ". DOI "
      <> doi
      <> "."
  }
  list.flatten([
    [start, "", "BibTeX:", "", "```bibtex"],
    bib,
    [
      "```",
      "",
      "APA:",
      "",
      "> " <> apa,
      "",
      "ABNT (NBR 6023):",
      "",
      "> " <> abnt,
    ],
    ["", end],
  ])
  |> string.join("\n")
}

/// Replaces the text from `start` through `end` with `block`.
pub fn splice(text: String, block: String) -> Result(String, String) {
  case string.split_once(text, start) {
    Ok(#(head, rest)) ->
      case string.split_once(rest, end) {
        Ok(#(_, tail)) -> Ok(head <> block <> tail)
        Error(_) -> Error("no " <> start <> " ... " <> end <> " block")
      }
    Error(_) -> Error("no " <> start <> " ... " <> end <> " block")
  }
}

fn read_meta(path: String) -> Result(Json, String) {
  use text <- result.try(sys.read(path))
  json.decode(text) |> result.map_error(fn(e) { path <> ": " <> e })
}

/// Validates `zenodo`, then rewrites `cff_path` and the READMEs' block, or with `check` only
/// says whether they are stale.
pub fn run(
  zenodo_path: String,
  cff_path: String,
  check: Bool,
  readme_paths: List(String),
) -> Int {
  case read_meta(zenodo_path) {
    Error(e) -> fail(e)
    Ok(meta) ->
      case validate(meta) {
        [_, ..] as errs -> {
          sys.eprintln(string.join(
            ["citation: .zenodo.json is invalid:", ..errs],
            "\n  ",
          ))
          1
        }
        [] ->
          case render_refs(meta, concept_doi), render_cff(meta, concept_doi) {
            Ok(block), Ok(cff_text) ->
              case splice_all(readme_paths, block, [#(cff_path, cff_text)]) {
                Ok(wanted) -> finish(wanted, check)
                Error(code) -> code
              }
            Error(e), _ | _, Error(e) -> fail(e)
          }
      }
  }
}

fn fail(e: String) -> Int {
  sys.eprintln("citation: " <> e)
  1
}

fn splice_all(
  readme_paths: List(String),
  block: String,
  acc: List(#(String, String)),
) -> Result(List(#(String, String)), Int) {
  case readme_paths {
    [] -> Ok(list.reverse(acc))
    [path, ..rest] -> {
      let spliced = case sys.read(path) {
        Ok(text) ->
          splice(text, block)
          |> result.map_error(fn(e) { sys.base_name(path) <> ": " <> e })
        Error(e) -> Error(e)
      }
      case spliced {
        Ok(text) -> splice_all(rest, block, [#(path, text), ..acc])
        Error(e) -> Error(fail(e))
      }
    }
  }
}

fn finish(wanted: List(#(String, String)), check: Bool) -> Int {
  let stale = list.filter(wanted, fn(w) { sys.read(w.0) != Ok(w.1) })
  case check, stale {
    True, [_, ..] -> {
      let names =
        list.map(stale, fn(w) { sys.base_name(w.0) }) |> string.join(", ")
      fail("stale: " <> names <> "; run `just citation`")
    }
    True, [] -> {
      sys.eprintln("citation: .zenodo.json valid, generated text current")
      0
    }
    False, _ ->
      list.fold(stale, 0, fn(code, w) {
        case code, sys.write(w.0, w.1) {
          0, Ok(_) -> {
            sys.eprintln("citation: wrote " <> sys.base_name(w.0))
            0
          }
          0, Error(e) -> fail(e)
          _, _ -> code
        }
      })
  }
}

// --- Python's str helpers the script leaned on --------------------------------------------

fn is_py_space(c: Int) -> Bool {
  case c {
    0x09 | 0x0A | 0x0B | 0x0C | 0x0D | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 -> True
    0x85 | 0xA0 | 0x1680 | 0x2028 | 0x2029 | 0x202F | 0x205F | 0x3000 -> True
    _ -> c >= 0x2000 && c <= 0x200A
  }
}

fn codepoints(s: String) -> List(Int) {
  string.to_utf_codepoints(s) |> list.map(string.utf_codepoint_to_int)
}

fn from_codepoints(cs: List(Int)) -> String {
  list.filter_map(cs, string.utf_codepoint) |> string.from_utf_codepoints
}

/// str.split() with no argument.
pub fn py_split(s: String) -> List(String) {
  codepoints(s)
  |> list.chunk(is_py_space)
  |> list.filter(fn(run) {
    case run {
      [c, ..] -> !is_py_space(c)
      [] -> False
    }
  })
  |> list.map(from_codepoints)
}

/// str.strip() with no argument.
pub fn py_strip(s: String) -> String {
  codepoints(s)
  |> list.drop_while(is_py_space)
  |> list.reverse
  |> list.drop_while(is_py_space)
  |> list.reverse
  |> from_codepoints
}

/// repr() of a value read from JSON, as an f-string's `!r` prints it.
pub fn repr(j: Json) -> String {
  case j {
    json.Null -> "None"
    json.Bool(True) -> "True"
    json.Bool(False) -> "False"
    json.Int(i) -> int.to_string(i)
    json.Float(_) -> json.encode(j, 0, False)
    json.String(s) -> repr_str(s)
    json.Array(items) -> "[" <> string.join(list.map(items, repr), ", ") <> "]"
    json.Object(kvs) ->
      "{"
      <> string.join(
        list.map(kvs, fn(kv) { repr_str(kv.0) <> ": " <> repr(kv.1) }),
        ", ",
      )
      <> "}"
  }
}

fn repr_list(items: List(String)) -> String {
  "[" <> string.join(list.map(items, repr_str), ", ") <> "]"
}

pub fn repr_str(s: String) -> String {
  let quote = case string.contains(s, "'") && !string.contains(s, "\"") {
    True -> "\""
    False -> "'"
  }
  let body =
    codepoints(s)
    |> list.map(fn(c) {
      case c {
        0x5C -> "\\\\"
        0x0A -> "\\n"
        0x0D -> "\\r"
        0x09 -> "\\t"
        _ if c < 0x20 || { c >= 0x7F && c <= 0xA0 } || c == 0xAD ->
          "\\x" <> string.pad_start(string.lowercase(int.to_base16(c)), 2, "0")
        _ ->
          case from_codepoints([c]) {
            ch if ch == quote -> "\\" <> ch
            ch -> ch
          }
      }
    })
    |> string.concat
  quote <> body <> quote
}

// --- command line -------------------------------------------------------------------------

const prog = "tools/fabric citation"

const main_usage =
  "usage: tools/fabric citation [-h] [--check] [--self-test] {add} ..."

const add_usage =
  "usage: tools/fabric citation add [-h] --name NAME [--orcid ORCID]
                                 [--affiliation AFFILIATION]
                                 [--type {ContactPerson,DataCollector,DataCurator,DataManager,Distributor,Editor,HostingInstitution,Other,Producer,ProjectLeader,ProjectManager,ProjectMember,RegistrationAgency,RegistrationAuthority,RelatedPerson,ResearchGroup,Researcher,RightsHolder,Sponsor,Supervisor,WorkPackageLeader}]
                                 [--author]"

const main_help =
  "

citation — .zenodo.json is the one hand-edited citation file; CITATION.cff is generated from it.

Zenodo reads only .zenodo.json when both exist, and GitHub's \"Cite this repository\" reads only
CITATION.cff, so the CFF is derived here, with the BibTeX, APA and ABNT references between the
READMEs' citation markers, and --check fails when any of them drifts. Ported to Gleam from
h0ffmann/picasso's scripts/citation.py, itself copied from marola-dev/marola's (MIP-0079). Changes
for Paper Fabric: the record may be a preprint (upload_type publication), the licence may be
CC BY 4.0, and a publication gets a CFF preferred-citation and a BibTeX @misc instead of @software.

    tools/fabric citation                  # validate .zenodo.json, rewrite CITATION.cff and the READMEs' block
    tools/fabric citation --check          # validate; exit 1 if any generated text is stale
    tools/fabric citation add --name \"Family, Given\" [--orcid ID] [--affiliation TEXT]
                          [--type Researcher | --author]
    tools/fabric citation --self-test

positional arguments:
  {add}
    add        add a contributor (or, with --author, a creator)

options:
  -h, --help   show this help message and exit
  --check
  --self-test
"

const add_help =
  "

options:
  -h, --help            show this help message and exit
  --name NAME           \"Family, Given\"
  --orcid ORCID         bare iD, 0000-0000-0000-0000
  --affiliation AFFILIATION
  --type {ContactPerson,DataCollector,DataCurator,DataManager,Distributor,Editor,HostingInstitution,Other,Producer,ProjectLeader,ProjectManager,ProjectMember,RegistrationAgency,RegistrationAuthority,RelatedPerson,ResearchGroup,Researcher,RightsHolder,Sponsor,Supervisor,WorkPackageLeader}
  --author              list as a creator (cited author)
"

type Add {
  Add(
    name: Result(String, Nil),
    orcid: String,
    affiliation: String,
    ctype: String,
    author: Bool,
  )
}

type Opts {
  Opts(check: Bool, self_test: Bool, add: Result(Add, Nil), extra: List(String))
}

type Exit {
  Exit(code: Int)
}

fn usage_error(usage: String, prog: String, msg: String) -> Exit {
  sys.eprintln(usage <> "\n" <> prog <> ": error: " <> msg)
  Exit(2)
}

/// argparse's unique-prefix matching of a long option.
fn resolve(
  arg: String,
  options: List(String),
  usage: String,
  prog: String,
) -> Result(String, Exit) {
  let #(flag, _) = string.split_once(arg, "=") |> result.unwrap(#(arg, ""))
  case list.contains(options, flag), string.starts_with(flag, "--") {
    True, _ -> Ok(flag)
    False, True ->
      case list.filter(options, fn(o) { string.starts_with(o, flag) }) {
        [one] -> Ok(one)
        [_, _, ..] as many ->
          Error(usage_error(
            usage,
            prog,
            "ambiguous option: "
              <> flag
              <> " could match "
              <> string.join(many, ", "),
          ))
        [] -> Ok(flag)
      }
    False, False -> Ok(flag)
  }
}

fn parse_main(args: List(String), opts: Opts) -> Result(Opts, Exit) {
  case args {
    [] -> Ok(Opts(..opts, extra: list.reverse(opts.extra)))
    [arg, ..rest] ->
      case string.starts_with(arg, "-") && arg != "-" {
        False ->
          case arg {
            "add" ->
              parse_add(
                rest,
                Add(Error(Nil), "", "", "ProjectMember", False),
                opts,
              )
            _ ->
              Error(usage_error(
                main_usage,
                prog,
                "argument cmd: invalid choice: "
                  <> repr_str(arg)
                  <> " (choose from 'add')",
              ))
          }
        True -> {
          use flag <- result.try(resolve(
            arg,
            ["--help", "--check", "--self-test"],
            main_usage,
            prog,
          ))
          case flag {
            "-h" | "--help" -> {
              io.print(main_usage <> main_help)
              Error(Exit(0))
            }
            "--check" | "--self-test" ->
              case string.split_once(arg, "=") {
                Ok(#(_, v)) ->
                  Error(usage_error(
                    main_usage,
                    prog,
                    "argument "
                      <> flag
                      <> ": ignored explicit argument "
                      <> repr_str(v),
                  ))
                Error(_) if flag == "--check" ->
                  parse_main(rest, Opts(..opts, check: True))
                Error(_) -> parse_main(rest, Opts(..opts, self_test: True))
              }
            _ -> parse_main(rest, Opts(..opts, extra: [arg, ..opts.extra]))
          }
        }
      }
  }
}

const add_prog = "tools/fabric citation add"

fn parse_add(args: List(String), a: Add, opts: Opts) -> Result(Opts, Exit) {
  case args {
    [] ->
      case a.name {
        Error(_) ->
          Error(usage_error(
            add_usage,
            add_prog,
            "the following arguments are required: --name",
          ))
        Ok(_) -> Ok(Opts(..opts, add: Ok(a), extra: list.reverse(opts.extra)))
      }
    [arg, ..rest] ->
      case string.starts_with(arg, "-") && arg != "-" {
        False -> parse_add(rest, a, Opts(..opts, extra: [arg, ..opts.extra]))
        True -> {
          use flag <- result.try(resolve(
            arg,
            [
              "--help",
              "--name",
              "--orcid",
              "--affiliation",
              "--type",
              "--author",
            ],
            add_usage,
            add_prog,
          ))
          case flag {
            "-h" | "--help" -> {
              io.print(add_usage <> add_help)
              Error(Exit(0))
            }
            "--author" -> parse_add(rest, Add(..a, author: True), opts)
            "--name" | "--orcid" | "--affiliation" | "--type" -> {
              use #(value, rest) <- result.try(
                case string.split_once(arg, "="), rest {
                  Ok(#(_, v)), _ -> Ok(#(v, rest))
                  Error(_), [v, ..r] ->
                    case string.starts_with(v, "-") && v != "-" {
                      False -> Ok(#(v, r))
                      True -> Error(Nil)
                    }
                  Error(_), [] -> Error(Nil)
                }
                |> result.map_error(fn(_) {
                  usage_error(
                    add_usage,
                    add_prog,
                    "argument " <> flag <> ": expected one argument",
                  )
                }),
              )
              case flag {
                "--name" -> parse_add(rest, Add(..a, name: Ok(value)), opts)
                "--orcid" -> parse_add(rest, Add(..a, orcid: value), opts)
                "--affiliation" ->
                  parse_add(rest, Add(..a, affiliation: value), opts)
                _ ->
                  case list.contains(contributor_types, value) {
                    True -> parse_add(rest, Add(..a, ctype: value), opts)
                    False ->
                      Error(usage_error(
                        add_usage,
                        add_prog,
                        "argument --type: invalid choice: "
                          <> repr_str(value)
                          <> " (choose from "
                          <> string.join(
                          list.map(contributor_types, repr_str),
                          ", ",
                        )
                          <> ")",
                      ))
                  }
              }
            }
            _ -> parse_add(rest, a, Opts(..opts, extra: [arg, ..opts.extra]))
          }
        }
      }
  }
}

pub fn main(args: List(String)) -> Int {
  case parse_main(args, Opts(False, False, Error(Nil), [])) {
    Error(Exit(code)) -> code
    Ok(Opts(extra: [_, ..] as extra, ..)) ->
      usage_error(
        main_usage,
        prog,
        "unrecognized arguments: " <> string.join(extra, " "),
      ).code
    Ok(Opts(self_test: True, ..)) -> self_test()
    Ok(Opts(check:, add: Ok(a), ..)) -> {
      let assert Ok(name) = a.name
      case read_meta(zenodo) {
        Error(e) -> fail(e)
        Ok(meta) ->
          case
            add_person(meta, name, a.orcid, a.affiliation, a.ctype, a.author)
          {
            Error(e) -> fail(e)
            Ok(meta) ->
              case validate(meta) {
                [_, ..] as errs -> {
                  sys.eprintln(string.join(
                    ["citation: not added:", ..errs],
                    "\n  ",
                  ))
                  1
                }
                [] ->
                  case write_json(zenodo, meta) {
                    Error(e) -> fail(e)
                    Ok(_) -> run(zenodo, cff, check, readmes)
                  }
              }
          }
      }
    }
    Ok(Opts(check:, ..)) -> run(zenodo, cff, check, readmes)
  }
}

// --- self-test (citation.yml runs `--self-test`; the same cases are in the gleeunit suite) ---

pub fn sample() -> Json {
  let assert Ok(j) =
    json.decode(
      "{\"title\": \"t\", \"upload_type\": \"software\",
        \"description\": \"<p>One &amp; two.</p><p>Three.</p>\",
        \"creators\": [{\"name\": \"Santos, Matheus Hoffmann Fernandes\", \"orcid\": \"0009-0009-1056-7661\"}],
        \"license\": \"mit\", \"access_right\": \"open\", \"language\": \"eng\", \"keywords\": [\"nix\"],
        \"related_identifiers\": [
          {\"identifier\": \"https://github.com/x/y\", \"relation\": \"isSupplementTo\", \"scheme\": \"url\"},
          {\"identifier\": \"10.5281/zenodo.23221352\", \"relation\": \"references\", \"scheme\": \"doi\"}]}",
    )
  j
}

fn ok(cond: Bool, what: String) -> Result(Nil, String) {
  case cond {
    True -> Ok(Nil)
    False -> Error(what)
  }
}

/// The script's self-test, case for case; Error names the first case that failed.
pub fn self_test_cases() -> Result(Nil, String) {
  let good = sample()
  use _ <- result.try(ok(validate(good) == [], "validate(good)"))
  use _ <- result.try(ok(
    orcid_ok("0000-0002-1825-0097") && !orcid_ok("0000-0002-1825-0098"),
    "orcid_ok",
  ))
  let bad =
    good
    |> json.set("version", json.String("v1"))
    |> json.set(
      "creators",
      json.Array([
        json.Object([
          #("name", json.String("Matheus Santos")),
          #("orcid", json.String("0009-0009-1056-7661")),
        ]),
      ]),
    )
    |> json.set(
      "related_identifiers",
      json.Array(case json.get_list(good, "related_identifiers") {
        [a, b] -> [a, json.set(b, "relation", json.String("isRelatedTo"))]
        other -> other
      }),
    )
  use _ <- result.try(ok(list.length(validate(bad)) == 3, "validate(bad)"))
  use cff_text <- result.try(render_cff(good, ""))
  use _ <- result.try(ok(
    string.contains(cff_text, "family-names: \"Santos\"")
      && string.contains(cff_text, "orcid.org/0009-0009-1056-7661"),
    "render_cff authors",
  ))
  use _ <- result.try(ok(
    string.contains(cff_text, "  One & two.\n\n  Three.\n")
      && !string.contains(cff_text, "doi:"),
    "render_cff abstract",
  ))
  use cff_doi <- result.try(render_cff(good, "10.5281/zenodo.1"))
  use _ <- result.try(ok(
    string.contains(cff_doi, "doi: 10.5281/zenodo.1\n"),
    "render_cff doi",
  ))
  use good <- result.try(add_person(
    good,
    "Valério, Bruno",
    "",
    "",
    "ProjectMember",
    False,
  ))
  use _ <- result.try(ok(
    json.get(good, "contributors")
      == Ok(
      json.Array([
        json.Object([
          #("name", json.String("Valério, Bruno")),
          #("type", json.String("ProjectMember")),
        ]),
      ]),
    ),
    "add_person",
  ))
  use _ <- result.try(ok(validate(good) == [], "validate after add"))
  use _ <- result.try(ok(
    add_person(good, "Valério, Bruno", "", "", "Other", True)
      == Error("Valério, Bruno is already listed"),
    "duplicate accepted",
  ))
  use refs <- result.try(render_refs(good, ""))
  use _ <- result.try(ok(
    string.contains(refs, "author    = {Santos, Matheus Hoffmann Fernandes}")
      && !string.contains(refs, "doi"),
    "render_refs author",
  ))
  use _ <- result.try(ok(
    string.contains(
      refs,
      "> Santos, M. H. F. (2026). *t* [Computer software]. https://github.com/x/y",
    ),
    "render_refs apa",
  ))
  let good =
    good
    |> json.set(
      "creators",
      json.Array(
        list.append(json.get_list(good, "creators"), [
          json.Object([#("name", json.String("Valério, Bruno"))]),
        ]),
      ),
    )
    |> json.set("title", json.String("m: a sub"))
  use refs <- result.try(render_refs(good, "10.5281/zenodo.1"))
  use _ <- result.try(ok(
    string.contains(refs, "Santos, M. H. F., & Valério, B. (2026)")
      && string.contains(refs, "doi       = {10.5281/zenodo.1}"),
    "render_refs two authors",
  ))
  use _ <- result.try(ok(
    string.contains(
      refs,
      "SANTOS, Matheus Hoffmann Fernandes; VALÉRIO, Bruno. **m**: a sub.",
    ),
    "render_refs abnt",
  ))
  use _ <- result.try(ok(
    string.contains(refs, "DOI 10.5281/zenodo.1.")
      && string.contains(refs, "@software{santos_2026_m,"),
    "render_refs bibtex",
  ))
  use _ <- result.try(ok(
    splice("a\n" <> start <> "\nold\n" <> end <> "\nb", "NEW")
      == Ok("a\nNEW\nb"),
    "splice",
  ))
  let d = sys.temp_dir()
  let z = sys.join(d, ".zenodo.json")
  let c = sys.join(d, "CITATION.cff")
  let r = sys.join(d, "README.md")
  let assert Ok(_) = write_json(z, good)
  let assert Ok(_) =
    sys.write(r, "# x\n\n" <> start <> "\n" <> end <> "\n\n## y\n")
  let outcome = {
    use _ <- result.try(ok(run(z, c, True, [r]) == 1, "run --check on stale"))
    use _ <- result.try(ok(
      run(z, c, False, [r]) == 0 && run(z, c, True, [r]) == 0,
      "run writes, then --check passes",
    ))
    let readme = sys.read(r) |> result.unwrap("")
    use _ <- result.try(ok(
      string.contains(readme, "BibTeX:")
        && string.ends_with(readme, "\n\n## y\n"),
      "README block",
    ))
    let assert Ok(_) = sys.write(r, "no markers\n")
    ok(run(z, c, True, [r]) == 1, "run without markers")
  }
  sys.remove_all(d)
  outcome
}

fn self_test() -> Int {
  case self_test_cases() {
    Ok(_) -> {
      sys.eprintln("citation: self-test ok")
      0
    }
    Error(what) -> fail("self-test failed: " <> what)
  }
}
