import fabric/content

pub fn gleam_string_test() {
  assert content.gleam_string("a\"b\\c\nd") == "\"a\\\"b\\\\c\\nd\""
}

pub fn citations_test() {
  let readme =
    "x\n<!-- citation:start -->\n\nBibTeX:\n\n```bibtex\n@misc{k,\n}\n```\n\nAPA:\n\n> A. (2026). *T*.\n\n<!-- citation:end -->\n"
  assert content.citations(readme)
    == Ok([#("BibTeX", "@misc{k,\n}"), #("APA", "A. (2026). T.")])
}

pub fn thinkers_test() {
  let roster =
    "| # | Thinker | Area | Why | Cited | Status |\n|---:|---|---|---|:---:|---|\n| 1 | Linus Torvalds | software | Linux | ☑ | proposed |\n| 2 | — | — | — | — | open |\n"
  assert content.thinkers(roster)
    == [
      content.Thinker(1, "Linus Torvalds", "Linux", "proposed"),
      content.Thinker(2, "—", "—", "open"),
    ]
}

pub fn sections_test() {
  assert content.sections([
      "# One\ntext\n# Two {#sec:two}\n# Refs {.unnumbered}\n## Sub\n",
      "# Three  \n",
    ])
    == ["One", "Two", "Three"]
}

pub fn splitlines_and_strip_test() {
  assert content.splitlines("a\nb\r\nc\n") == ["a", "b", "c"]
  assert content.splitlines("") == []
  assert content.splitlines("a\n\nb") == ["a", "", "b"]
  assert content.strip(" \n\u{a0}x y\t\n") == "x y"
}
