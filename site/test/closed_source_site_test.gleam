import closed_source_site/app
import closed_source_site/content
import gleam/list
import gleam/string
import gleeunit
import lustre/element

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn citation_falls_back_to_the_first_test() {
  let assert [first, ..] = content.citations
  assert app.citation(0) == first
  assert app.citation(99) == first
}

pub fn pdf_names_test() {
  assert app.pdf(app.Original) == "closed-source.pdf"
  assert app.pdf(app.Ste) == "closed-source-ste.pdf"
  assert app.pdf(app.PtBr) == "closed-source-pt-BR.pdf"
}

pub fn prerender_has_the_title_and_every_section_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert string.contains(html, content.title)
  assert list.all(content.sections, fn(s) {
    string.contains(html, string.replace(s, "'", "&#39;"))
    || string.contains(html, s)
  })
}

pub fn front_page_shows_the_thinkers_and_the_notes_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert list.length(content.thinkers) == 50
  assert string.contains(html, "The 50 Thinkers")
  assert string.contains(html, "Second brain")
  assert list.all(content.notes, fn(n) { string.contains(html, n.file) })
}

pub fn each_project_stamp_links_its_project_and_loads_its_logo_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert list.length(content.logos) == 2
  assert list.all(content.logos, fn(l) {
    string.contains(html, "data-logo=\"" <> l.name <> "\"")
    && string.contains(html, "href=\"" <> l.href <> "\"")
    && string.contains(html, "src=\"" <> l.svg <> "\"")
    && string.contains(html, l.text)
    && string.starts_with(l.svg, "https://raw.githubusercontent.com/")
    && { l.svg_dark == "" || string.contains(html, l.svg_dark) }
  })
}

pub fn both_dois_and_the_other_works_are_on_the_page_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert content.doi != ""
  assert string.contains(html, "https://doi.org/" <> content.doi)
  assert string.contains(html, "Latest DOI")
  // Empty when Zenodo was not reached at build time; then the page shows the concept DOI alone.
  assert list.all(content.version_dois, fn(v) {
    string.contains(html, "https://doi.org/" <> v.1)
  })
  assert list.length(content.works) == 3
  assert list.all(content.works, fn(w) {
    string.contains(html, "https://doi.org/" <> w.doi)
  })
}

pub fn the_dois_section_has_a_tile_for_each_work_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert string.contains(html, "id=\"dois\"")
  assert string.contains(html, "4 works, 4 DOIs.")
  assert string.contains(html, "tile-paper")
  assert list.all(content.works, fn(w) {
    string.contains(html, "tile-" <> w.name)
    && list.length(w.tags) == 2
    && list.all(w.tags, fn(t) { string.contains(html, ">" <> t <> "<") })
  })
  assert list.all(content.tags, fn(t) { string.contains(html, ">" <> t <> "<") })
}

pub fn the_citation_scores_are_on_the_page_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert list.length(content.scores) == 5
  assert string.contains(html, "id=\"scores\"")
  assert list.all(content.scores, fn(s) {
    string.contains(html, s.name) && string.contains(html, s.verdict)
  })
  assert app.band(100) == "high"
  assert app.band(48) == "mid"
  assert app.band(0) == "low"
}
