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
  assert string.contains(html, "5 works, 4 DOIs.")
  assert app.shelf_works() == 5
  assert app.shelf_dois() == 4
  assert list.all(content.friends, fn(w) {
    string.contains(html, "tile-" <> w.name <> " tile-friend")
    && w.doi == ""
    && string.contains(html, "none yet")
    && list.all(w.tags, fn(t) { string.contains(html, ">" <> t <> "<") })
  })
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

pub fn the_cover_counts_the_commits_beside_the_pages_and_the_notes_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert content.commits > 0
  assert string.contains(html, "/commits/main")
  assert string.contains(html, ">commits<")
  assert string.contains(html, ">pages, two each<")
  assert string.contains(html, ">notes in the second brain<")
}

pub fn the_paper_tile_is_in_lower_case_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert string.contains(
    html,
    string.lowercase(content.title) <> ": the paper you are reading about.",
  )
  assert string.contains(html, "permanent DOI for ")
    || string.contains(html, "all versions")
}

pub fn the_github_pill_names_the_repository_and_the_latest_release_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert app.repo_name() == #("h0ffmann", "closed-source")
  assert string.contains(html, "class=\"gh\"")
  assert string.contains(html, "href=\"" <> content.repo <> "\"")
  assert string.contains(html, "gh-star")
  // Empty when Zenodo was not reached at build time; then the pill shows no version.
  assert case content.version_dois {
    [#(version, _), ..] -> string.contains(html, ">" <> version <> "<")
    [] -> True
  }
}

pub fn the_paper_pdf_is_linked_from_the_cover_the_tile_and_read_test() {
  let html = app.initial() |> app.view |> element.to_string
  let link = "href=\"" <> app.pdf(app.Original) <> "\""
  // The cover's pill, the paper's tile and the Read section.
  assert list.length(string.split(html, link)) - 1 >= 3
  assert string.contains(html, "gh gh-read")
  assert string.contains(html, "read the paper (PDF)")
  // The preview, from the name the Zenodo record links to.
  assert app.paper == "paper.pdf"
  assert string.contains(html, "<iframe class=\"preview\"")
  assert string.contains(html, "src=\"paper.pdf\"")
  assert string.contains(html, "download=\"closed-source.pdf\"")
}

pub fn the_ci_card_shows_each_workflow_with_its_state_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert string.contains(html, "what happens when the book changes")
  assert list.length(app.checks) == 5
  assert list.all(list.append(app.checks, app.after), fn(c: app.Check) {
    string.contains(
      html,
      "href=\"" <> content.repo <> "/actions/workflows/" <> c.file <> "\"",
    )
    && string.contains(
      html,
      "/actions/workflow/status/h0ffmann/closed-source/" <> c.file <> "?",
    )
  })
  // A release runs on a tag, so its badge does not ask for main.
  assert string.contains(html, "release.yml?label=release")
  assert string.contains(html, "href=\"#ci\"")
}

pub fn the_latest_changelog_is_on_the_page_test() {
  let html = app.initial() |> app.view |> element.to_string
  // Empty before the first "## vX.Y.Z: what changed" section of RELEASES.md.
  assert case content.changelog {
    #("", _) -> True
    #(version, changes) ->
      string.contains(html, "What changed in " <> version)
      && changes != []
      && string.contains(html, "href=\"#changes\"")
      && string.contains(html, "/releases/tag/" <> version)
  }
}

pub fn the_abstract_has_an_easy_pt_br_version_test() {
  assert content.abstract_easy_pt_br != ""
  let html = app.initial() |> app.view |> element.to_string
  assert string.contains(html, "versão fácil, passo a passo")
  let #(model, _) = app.update(app.initial(), app.ShowText(app.EasyPtBr))
  let easy = model |> app.view |> element.to_string
  assert string.contains(easy, "lang=\"pt-BR\"")
  assert string.contains(easy, "<b>1. O que é \"código fechado\".</b>")
    || string.contains(easy, "<b>1. O que é &quot;código fechado&quot;.</b>")
  assert string.contains(easy, "Vale o original")
  assert app.pdf(app.EasyPtBr) == app.pdf(app.PtBr)
}

pub fn an_approved_note_shows_as_approved_test() {
  let html = app.initial() |> app.view |> element.to_string
  assert list.any(content.notes, fn(n) { n.status == "approved" })
  assert string.contains(html, "class=\"tag is-approved\">approved<")
}
