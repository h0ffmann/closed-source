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
