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
}

pub fn prerender_has_the_title_and_every_section_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert string.contains(html, content.title)
  assert list.all(content.sections, fn(s) {
    string.contains(html, string.replace(s, "'", "&#39;"))
    || string.contains(html, s)
  })
}
