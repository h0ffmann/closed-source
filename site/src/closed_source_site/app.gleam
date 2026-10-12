//// The page as one Lustre application. `view(initial())` is also what `prerender` writes into
//// `index.html`, so the page reads without JavaScript and the client takes it over in place.

import closed_source_site/content.{type Author}
import closed_source_site/ffi
import gleam/int
import gleam/list
import gleam/string
import lustre/attribute.{type Attribute}
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

pub type Text {
  Original
  Ste
}

pub type Model {
  Model(text: Text, cite: Int, copied: Bool)
}

pub type Msg {
  ShowText(Text)
  ShowCite(Int)
  Copy
  Copied(Bool)
}

pub fn initial() -> Model {
  Model(text: Original, cite: 0, copied: False)
}

pub fn init(_: Nil) -> #(Model, Effect(Msg)) {
  #(initial(), effect.none())
}

pub fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    ShowText(text) -> #(Model(..model, text:), effect.none())
    ShowCite(cite) -> #(Model(..model, cite:, copied: False), effect.none())
    Copy -> #(model, {
      use dispatch <- effect.from
      ffi.copy(citation(model.cite).1, fn(ok) { dispatch(Copied(ok)) })
    })
    Copied(ok) -> #(Model(..model, copied: ok), effect.none())
  }
}

/// The citation style at `index`, or the first one.
pub fn citation(index: Int) -> #(String, String) {
  case list.drop(content.citations, index), content.citations {
    [c, ..], _ -> c
    [], [c, ..] -> c
    [], [] -> #("", "")
  }
}

/// The PDF's file name in dist/: the original, or its ASD-STE100 text.
pub fn pdf(text: Text) -> String {
  case text {
    Original -> content.slug <> ".pdf"
    Ste -> content.slug <> "-ste.pdf"
  }
}

pub fn view(model: Model) -> Element(Msg) {
  html.div([], [
    header(),
    html.main([attribute.class("wrap")], [
      read_section(),
      abstract_section(model),
      contents_section(),
      authors_section(),
      fabric_section(),
      cite_section(model),
    ]),
    footer(),
  ])
}

fn link(href: String, label: String) -> Element(msg) {
  html.a([attribute.href(href)], [html.text(label)])
}

fn external(href: String, label: String) -> Element(msg) {
  html.a([attribute.href(href), attribute.rel("noopener")], [html.text(label)])
}

fn section_head(
  id: String,
  title: String,
  aside: Element(msg),
) -> Element(msg) {
  html.div([attribute.class("section-head")], [
    html.h2([attribute.id(id)], [html.text(title)]),
    aside,
  ])
}

fn header() -> Element(msg) {
  html.header([attribute.class("top")], [
    html.div([attribute.class("wrap")], [
      html.p([attribute.class("eyebrow")], [
        html.text("Paper Fabric · Ouroboric DEV"),
        html.span([attribute.class("version")], [html.text("v0")]),
      ]),
      html.h1([], [html.text(content.title)]),
      html.p([attribute.class("lede")], [html.text(content.subtitle)]),
      html.p([attribute.class("meta")], [
        html.text(
          content.date
          <> " · "
          <> content.authors
          |> list.map(fn(a: Author) { a.name })
          |> string.join(", "),
        ),
      ]),
      html.ul([attribute.class("status")], [
        html.li([attribute.class("is-soon")], [
          html.span([attribute.class("dot")], []),
          html.b([], [html.text("Preprint")]),
          html.text(" not peer reviewed"),
        ]),
        html.li([attribute.class("is-live")], [
          html.span([attribute.class("dot")], []),
          html.b([], [html.text("Open")]),
          html.text(" text CC BY 4.0, build AGPL-3.0"),
        ]),
      ]),
      html.nav([attribute.class("jump")], [
        link("#read", "Read"),
        link("#abstract", "Abstract"),
        link("#contents", "Contents"),
        link("#authors", "Authors"),
        link("#fabric", "How it is made"),
        link("#cite", "Cite"),
      ]),
    ]),
  ])
}

fn stat(value: Int, label: String) -> Element(msg) {
  html.div([attribute.class("stat")], [
    html.b([], [html.text(int.to_string(value))]),
    html.span([], [html.text(label)]),
  ])
}

fn read_section() -> Element(msg) {
  html.section([attribute.aria_labelledby("read")], [
    section_head("read", "Read", external(content.repo, "source on GitHub")),
    html.p([attribute.class("sub")], [html.text(content.version)]),
    html.ul([attribute.class("labs")], [
      card(
        pdf(Original),
        "The paper (PDF)",
        "Typeset with XeLaTeX from the Markdown sources.",
      ),
      card(
        pdf(Ste),
        "ASD-STE100 text (PDF)",
        "The same paper in Simplified Technical English, with the same citations and numbers.",
      ),
      card(
        content.repo <> "/releases",
        "Releases",
        "Each tagged release: the PDFs, the arXiv source bundle, and the Zenodo DOI once published.",
      ),
    ]),
    html.div([attribute.class("stats")], [
      stat(content.pages, "pages"),
      stat(list.length(content.sections), "sections"),
      stat(content.references, "references"),
      stat(content.verified, "references fetched and verified"),
      stat(list.length(content.authors), "authors"),
    ]),
  ])
}

fn card(href: String, title: String, body: String) -> Element(msg) {
  html.li([], [link(href, title), html.p([], [html.text(body)])])
}

fn pressed(on: Bool) -> Attribute(msg) {
  attribute.attribute("aria-pressed", case on {
    True -> "true"
    False -> "false"
  })
}

fn abstract_section(model: Model) -> Element(Msg) {
  let text = case model.text {
    Original -> content.abstract
    Ste -> content.abstract_ste
  }
  html.section([attribute.aria_labelledby("abstract")], [
    section_head("abstract", "Abstract", element.none()),
    html.div([attribute.class("filters")], [
      html.button(
        [pressed(model.text == Original), event.on_click(ShowText(Original))],
        [
          html.text("Original"),
        ],
      ),
      html.button([pressed(model.text == Ste), event.on_click(ShowText(Ste))], [
        html.text("Simplified Technical English"),
      ]),
    ]),
    html.div(
      [attribute.class("prose")],
      text
        |> string.split("\n\n")
        |> list.map(fn(p) { html.p([], [html.text(p)]) }),
    ),
    html.ul(
      [attribute.class("keywords")],
      list.map(content.keywords, fn(k) { html.li([], [html.text(k)]) }),
    ),
  ])
}

fn contents_section() -> Element(msg) {
  html.section([attribute.aria_labelledby("contents")], [
    section_head("contents", "Contents", element.none()),
    html.ol(
      [attribute.class("eras")],
      list.index_map(content.sections, fn(title, i) {
        html.li([attribute.class("era")], [
          html.div([attribute.class("era-head")], [
            html.span([attribute.class("era-n")], [
              html.text(int.to_string(i + 1)),
            ]),
            html.h3([], [html.text(title)]),
          ]),
        ])
      }),
    ),
  ])
}

fn authors_section() -> Element(msg) {
  html.section([attribute.aria_labelledby("authors")], [
    section_head("authors", "Authors", element.none()),
    html.ul(
      [attribute.class("labs")],
      list.map(content.authors, fn(a: Author) {
        html.li([], [
          html.b([attribute.class("name")], [html.text(a.name)]),
          html.p([], [html.text(a.affiliation)]),
          html.p([], [
            external("https://orcid.org/" <> a.orcid, "ORCID " <> a.orcid),
          ]),
        ])
      }),
    ),
  ])
}

fn fabric_section() -> Element(msg) {
  let step = fn(title, body) {
    html.li([], [html.b([], [html.text(title)]), html.text(" " <> body)])
  }
  html.section([attribute.aria_labelledby("fabric")], [
    section_head(
      "fabric",
      "How it is made",
      external(
        content.repo <> "/blob/main/docs/4-ways-of-working/paper-fabric.md",
        "Paper Fabric",
      ),
    ),
    html.p([attribute.class("sub")], [
      html.text(
        "Paper Fabric is the open pipeline that produced this preprint. Humans steer and agents build: authors set the thesis and write their own accounts, agents research, draft and check, and every source is fetched before it is cited.",
      ),
    ]),
    html.ol([attribute.class("steps")], [
      step("Write.", "Markdown prose, one file per section, and a BibTeX file."),
      step(
        "Build.",
        "pandoc with pandoc-crossref and citeproc, a LaTeX template, XeLaTeX. An unresolved citation stops the build.",
      ),
      step(
        "Check.",
        "Every reference has a row in the reference log; the ASD-STE100 text keeps every citation and number.",
      ),
      step(
        "Release.",
        "A tag makes a GitHub release with the PDFs and the arXiv source; a person publishes the Zenodo draft, which mints the DOI.",
      ),
    ]),
    html.div([attribute.class("credit")], [
      html.p([], [
        html.text("Tools pinned by Nix from "),
        external("https://github.com/h0ffmann/picasso", "picasso"),
        html.text("'s labs: "),
        external(
          "https://github.com/h0ffmann/picasso/tree/main/labs/paper",
          "paper",
        ),
        html.text(" for the PDF and "),
        external(
          "https://github.com/h0ffmann/picasso/tree/main/labs/gleam-website",
          "gleam-website",
        ),
        html.text(
          " for this site. The build follows Sandy Maguire's books (isovector).",
        ),
      ]),
    ]),
  ])
}

fn cite_section(model: Model) -> Element(Msg) {
  let #(_, text) = citation(model.cite)
  html.section([attribute.aria_labelledby("cite")], [
    section_head("cite", "Cite", element.none()),
    html.p([attribute.class("cite")], [
      html.text(
        "Professional citation is the paper's own argument. Cite it, and cite what you borrow.",
      ),
    ]),
    html.div(
      [attribute.class("filters")],
      list.index_map(content.citations, fn(c, i) {
        html.button([pressed(i == model.cite), event.on_click(ShowCite(i))], [
          html.text(c.0),
        ])
      }),
    ),
    html.pre([attribute.class("citation")], [html.code([], [html.text(text)])]),
    html.button([attribute.class("copy"), event.on_click(Copy)], [
      html.text(case model.copied {
        True -> "Copied"
        False -> "Copy"
      }),
    ]),
  ])
}

fn footer() -> Element(msg) {
  html.footer([attribute.class("foot wrap")], [
    html.p([], [
      html.text(
        "Text CC BY 4.0. Site and build scripts AGPL-3.0-only. Built from revision ",
      ),
      html.code([], [html.text(content.revision)]),
      html.text(". "),
      external(content.repo, "Source"),
      html.text("."),
    ]),
    html.p([], [
      html.text(
        "Style after picasso's site. Ouroboric's names and logos are not licensed here.",
      ),
    ]),
  ])
}
