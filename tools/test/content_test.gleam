import fabric/content
import fabric/json

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

pub fn logo_test() {
  let entry =
    json.Object([
      #("file", json.String("logos/marola.pdf")),
      #("svg", json.String("https://x/logo.svg")),
      #("href", json.String("https://marola.dev")),
      #("width", json.String("56")),
    ])
  assert content.logo(entry)
    == "Logo(name: \"marola\", svg: \"https://x/logo.svg\", svg_dark: \"\", href: \"https://marola.dev\", label: \"\", text: \"\", width: \"56\", height: \"\")"
}

pub fn version_dois_keep_only_the_concept_test() {
  let assert Ok(reply) =
    json.decode(
      "{\"hits\":{\"hits\":[{\"doi\":\"10.5281/zenodo.9\",\"conceptdoi\":\"10.5281/zenodo.8\",\"metadata\":{\"version\":\"v0.1.1\"}},{\"doi\":\"10.5281/zenodo.7\",\"conceptdoi\":\"10.5281/zenodo.6\",\"metadata\":{\"version\":\"v9.9.9\"}},{\"conceptdoi\":\"10.5281/zenodo.8\",\"metadata\":{}}]}}",
    )
  assert content.version_dois("10.5281/zenodo.8", reply)
    == [#("v0.1.1", "10.5281/zenodo.9")]
  assert content.version_dois("10.5281/zenodo.8", json.Object([])) == []
  assert content.versions_url("10.5281/zenodo.8")
    == "https://zenodo.org/api/records?q=conceptrecid%3A8&all_versions=true&sort=mostrecent&size=25"
  assert content.versions_url("10.1000/x") == ""
}

pub fn work_test() {
  let assert Ok(entry) =
    json.decode(
      "{\"name\":\"marola\",\"text\":\"sea\",\"doi\":\"10.5281/zenodo.1\",\"href\":\"https://x\",\"tags\":[\"non-profit\",\"water\"]}",
    )
  assert content.work(entry)
    == "Work(name: \"marola\", text: \"sea\", doi: \"10.5281/zenodo.1\", href: \"https://x\", tags: [\"non-profit\", \"water\"])"
}
