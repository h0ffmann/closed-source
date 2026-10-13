import fabric/arxiv
import fabric/json
import gleam/string

fn meta(abstract: String, ax: List(#(String, json.Json))) -> json.Json {
  json.Object([
    #("title", json.String("t")),
    #("abstract", json.String(abstract)),
    #(
      "author",
      json.Array([
        json.Object([#("name", json.String("A B"))]),
        json.Object([#("name", json.String("C D"))]),
      ]),
    ),
    #("arxiv", json.Object(ax)),
  ])
}

const good_ax = [
  #("primary", json.String("cs.CY")),
  #("cross-list", json.Array([json.String("cs.SE")])),
  #("license", json.String("x")),
  #("comments", json.String("c")),
]

pub fn form_fields_good_test() {
  let #(text, errs) = arxiv.form_fields(meta("a  b\nc", good_ax))
  assert errs == []
  assert text
    == "Title: t\nAuthors: A B, C D\nPrimary category: cs.CY\nCross-lists: cs.SE\nLicence: x\nComments: c\n\nAbstract:\na b c\n"
}

pub fn form_fields_bad_test() {
  let long = string.repeat("x", arxiv.abstract_max + 1)
  let #(_, errs) =
    arxiv.form_fields(meta(long, [#("primary", json.String("CS CY"))]))
  assert errs
    == [
      "abstract is 1921 characters; arXiv allows 1920",
      "category 'CS CY' is not an arXiv category id",
      "arxiv.license is missing",
    ]
}

pub fn form_fields_prefers_the_writer_test() {
  let m =
    json.set(
      meta("a", good_ax),
      "writer",
      json.Object([#("name", json.String("W"))]),
    )
  let #(text, _) = arxiv.form_fields(m)
  assert string.contains(text, "\nAuthors: W\n")
}

pub fn squash_uses_python_whitespace_test() {
  assert arxiv.squash(" a\u{a0}b\t\nc \u{3000}") == "a b c"
}

pub fn freeze_revision_test() {
  let tex =
    "a\n\\newcommand{\\revision}{\\IfFileExists{.current-revision}{x}{y}}\nb"
  assert arxiv.freeze_revision(tex, "abc+3")
    == Ok("a\n\\newcommand{\\revision}{abc+3}\nb")
  assert arxiv.freeze_revision("no macro", "x")
    == Error("no \\newcommand{\\revision}{...} line in the generated .tex")
}
