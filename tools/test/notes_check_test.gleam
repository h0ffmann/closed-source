import fabric/notes_check

fn note(id: String, link: String) -> String {
  "---\nid: \""
  <> id
  <> "\"\ntitle: t\ntype: fleeting\nstatus: unverified\nsource: s\ncreated: 2026-10-12\n---\n[["
  <> link
  <> "]]\n"
}

const a = "202610122236-a"

const b = "202610122237-b"

pub fn good_test() {
  let good = [#(a, note("202610122236", b)), #(b, note("202610122237", a))]
  assert notes_check.check(good, "[[" <> a <> "]] [[" <> b <> "]]") == []
  assert notes_check.check(good, "[[" <> a <> "]]")
    == [b <> ": notes/index.md does not link to it"]
}

pub fn dangling_link_test() {
  let bad = [#(a, note("202610122236", "202610122299-x"))]
  assert notes_check.check(bad, "[[" <> a <> "|x]] [[nope]]")
    == [
      a <> ": [[202610122299-x]] does not resolve",
      "index.md: [[nope]] does not resolve",
    ]
}

pub fn front_matter_test() {
  let text = "---\nid: 1\ntype: odd\nstatus: \"done\"\n---\nno links\n"
  assert notes_check.check([#("x", text)], "[[x]]")
    == [
      "x: name must be <YYYYMMDDHHMM>-<slug>",
      "x: front matter has no title",
      "x: front matter has no source",
      "x: front matter has no created",
      "x: type 'odd' is not one of ['fleeting', 'literature', 'permanent']",
      "x: status 'done' is not one of ['approved', 'open-question', 'partial', 'unverified', 'verified']",
      "x: links to no other note",
    ]
  assert notes_check.front("---\na: 1\na: 2\n b: 3\n---\n") == Ok([#("a", "2")])
  assert notes_check.front("---\na: 1\n") == Error(Nil)
  assert notes_check.front("# x") == Ok([])
}

pub fn id_mismatch_and_twice_test() {
  let c = "202610122236-c"
  let notes = [#(a, note("202610122236", c)), #(c, note("202610122230", a))]
  assert notes_check.check(notes, "[[" <> a <> "]] [[" <> c <> "]]")
    == [
      c <> ": id 202610122230 does not match the file name",
      "id 202610122236 is used twice",
    ]
}
