//// The page as one Lustre application. `view(initial())` is also what `prerender` writes into
//// `index.html`, so the page reads without JavaScript and the client takes it over in place.

import closed_source_site/content.{
  type Author, type Logo, type Note, type Score, type Thinker, type Work,
}
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
  PtBr
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
    PtBr -> content.slug <> "-pt-BR.pdf"
  }
}

pub fn view(model: Model) -> Element(Msg) {
  html.div([], [
    header(),
    html.main([attribute.class("wrap")], [
      shelf_section(),
      thinkers_section(),
      notes_section(),
      read_section(),
      abstract_section(model),
      contents_section(),
      authors_section(),
      fabric_section(),
      scores_section(),
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

/// A DOI as a two-part badge that opens doi.org, after picasso's site.
fn doi_link(label: String, doi: String) -> Element(msg) {
  html.a(
    [
      attribute.class("doi"),
      attribute.href("https://doi.org/" <> doi),
      attribute.rel("noopener"),
    ],
    [html.span([], [html.text(label)]), html.span([], [html.text(doi)])],
  )
}

/// The newest release and its own DOI, when Zenodo was reached at build time.
fn latest_version() -> Result(#(String, String), Nil) {
  list.first(content.version_dois)
}

/// The two DOIs side by side, for the cover: the latest and the newest release's own.
fn doi_badges() -> Element(msg) {
  case content.doi {
    "" -> element.none()
    doi ->
      html.p([attribute.class("doi-line")], [
        doi_link("Latest DOI", doi),
        case latest_version() {
          Ok(#(version, own)) -> doi_link("Permanent DOI · " <> version, own)
          Error(_) -> element.none()
        },
      ])
  }
}

/// The two DOIs with what each is for, and every release's own DOI.
fn dois() -> Element(msg) {
  case content.doi {
    "" -> element.none()
    doi ->
      html.div([attribute.class("dois")], [
        html.dl([], [
          html.dt([], [doi_link("Latest DOI", doi)]),
          html.dd([], [
            html.text(
              "One DOI for the whole work. It always resolves to the newest release. Cite this one.",
            ),
          ]),
          ..case latest_version() {
            Ok(#(version, own)) -> [
              html.dt([], [doi_link("Permanent DOI · " <> version, own)]),
              html.dd([], [
                html.text(
                  "One DOI for release "
                  <> version
                  <> " alone: the same text forever. Add it when the exact wording matters, as in a quotation or a review.",
                ),
              ]),
            ]
            Error(_) -> []
          }
        ]),
        html.p([], [
          html.text("Each release gets its own permanent DOI: "),
          ..list.append(
            list.map(content.version_dois, fn(v) {
              html.span([attribute.class("version")], [
                html.text(v.0 <> " "),
                external("https://doi.org/" <> v.1, v.1),
                html.text(" · "),
              ])
            }),
            [
              external(
                "https://zenodo.org/doi/" <> doi,
                "all versions on Zenodo",
              ),
            ],
          )
        ]),
      ])
  }
}

/// One work as one large tile. The whole tile opens `href`; `more` holds the tile's second
/// link, which stays clickable above it. `label` and `value` are the line under the text: "DOI"
/// and the DOI, or what stands in for one.
fn tile(
  kind: String,
  tags: List(String),
  name: String,
  text: String,
  href: String,
  label: String,
  value: String,
  more: Element(msg),
) -> Element(msg) {
  html.li([attribute.class("tile tile-" <> kind)], [
    html.p(
      [attribute.class("tile-tags")],
      list.map(tags, fn(t) { html.span([], [html.text(t)]) }),
    ),
    html.h3([], [
      html.a(
        [
          attribute.class("tile-link"),
          attribute.href(href),
          attribute.rel("noopener"),
        ],
        [html.text(name)],
      ),
    ]),
    html.p([attribute.class("tile-text")], [html.text(text)]),
    html.p([attribute.class("tile-doi")], [
      html.span([], [html.text(label)]),
      html.text(" " <> value),
    ]),
    html.p([attribute.class("tile-more")], [more]),
    html.span([attribute.class("tile-go"), attribute.aria_hidden(True)], []),
  ])
}

/// A tile for a work with a DOI: the tile opens doi.org.
fn doi_tile(
  kind: String,
  tags: List(String),
  name: String,
  text: String,
  doi: String,
  more: Element(msg),
) -> Element(msg) {
  tile(kind, tags, name, text, "https://doi.org/" <> doi, "DOI", doi, more)
}

/// A wide tile for a friend's work. With no DOI yet, it opens the work's own page and says so.
fn friend_tile(k: Work) -> Element(msg) {
  case k.doi {
    "" ->
      tile(
        k.name <> " tile-friend",
        k.tags,
        k.name,
        k.text,
        k.href,
        "DOI",
        "none yet",
        external(k.href, string.replace(k.href, "https://", "")),
      )
    doi ->
      doi_tile(
        k.name <> " tile-friend",
        k.tags,
        k.name,
        k.text,
        doi,
        external(k.href, "repository"),
      )
  }
}

/// The works on the shelf: this paper, the writer's other works and the friends' works.
pub fn shelf_works() -> Int {
  1 + list.length(content.works) + list.length(content.friends)
}

/// How many of them have a DOI.
pub fn shelf_dois() -> Int {
  1
  + list.length(content.works)
  + list.length(list.filter(content.friends, fn(k: Work) { k.doi != "" }))
}

/// Every DOI of the writer's work, this paper's first: large tiles that open doi.org.
fn shelf_section() -> Element(msg) {
  case content.doi {
    "" -> element.none()
    doi ->
      html.section(
        [attribute.class("shelf"), attribute.aria_labelledby("dois")],
        [
          html.h2([attribute.id("dois")], [
            html.text(
              int.to_string(shelf_works())
              <> " works, "
              <> int.to_string(shelf_dois())
              <> " DOIs.",
            ),
          ]),
          html.p([attribute.class("shelf-lede")], [
            html.text(
              "Click a tile to open its DOI, or the work's own page when it has no DOI yet. A DOI still resolves after a repository moves, so cite the DOI, not the URL.",
            ),
          ]),
          html.ul(
            [attribute.class("tiles")],
            list.flatten([
              [
                doi_tile(
                  "paper",
                  content.tags,
                  content.slug,
                  string.lowercase(content.title)
                    <> ": the paper you are reading about. its latest DOI always opens the newest release.",
                  doi,
                  html.span([], [
                    link(pdf(Original), "read the paper (PDF)"),
                    html.text(" · "),
                    case latest_version() {
                      Ok(#(version, own)) ->
                        external(
                          "https://doi.org/" <> own,
                          "permanent DOI for " <> version <> ": " <> own,
                        )
                      Error(_) ->
                        external(
                          "https://zenodo.org/doi/" <> doi,
                          "all versions",
                        )
                    },
                  ]),
                ),
              ],
              list.map(content.works, fn(k: Work) {
                doi_tile(
                  k.name,
                  k.tags,
                  k.name,
                  k.text,
                  k.doi,
                  external(k.href, "repository"),
                )
              }),
              list.map(content.friends, friend_tile),
            ]),
          ),
        ],
      )
  }
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
  html.header([attribute.class("cover")], [cover(), jump()])
}

fn jump() -> Element(msg) {
  html.nav([attribute.class("jump wrap")], [
    link("#dois", "DOIs"),
    link("#thinkers", "50 Thinkers"),
    link("#notes", "Second brain"),
    link("#read", "Read"),
    link("#abstract", "Abstract"),
    link("#contents", "Contents"),
    link("#authors", "Author"),
    link("#fabric", "How it is made"),
    link("#scores", "Scores"),
    link("#cite", "Cite"),
  ])
}

fn author_names(separator: String) -> String {
  content.authors
  |> list.map(fn(a: Author) { a.name })
  |> string.join(separator)
}

/// The title as a book cover, after the cover of Hoppe's "Democracy: The God That Failed"
/// (Transaction, 2001), which this paper's title echoes: a black field with the first half of the
/// title in yellow letters, a red band, then the second half in black. Only the type and colour scheme are
/// borrowed; no cover art, image or text is reproduced.
fn cover() -> Element(msg) {
  let #(head, tail) = case string.split_once(content.title, ": ") {
    Ok(parts) -> parts
    Error(_) -> #(content.title, "")
  }
  html.div([attribute.class("cover-art")], [
    html.div([attribute.class("field")], [
      html.div([attribute.class("wrap")], [
        html.p([attribute.class("imprint")], [
          html.text("Paper Fabric · " <> content.date),
        ]),
        html.h1([attribute.class("cover-title")], [
          html.span([attribute.class("head")], [html.text(head)]),
          html.span([attribute.class("visually-hidden")], [
            html.text(": " <> tail),
          ]),
        ]),
      ]),
    ]),
    html.div([attribute.class("band")], [
      html.div([attribute.class("wrap")], [
        html.p([], [html.text(content.subtitle)]),
      ]),
    ]),
    html.div([attribute.class("paper")], [
      html.div([attribute.class("wrap")], [
        html.p([attribute.class("tail"), attribute.aria_hidden(True)], [
          html.text(tail),
        ]),
        html.p([attribute.class("byline")], [html.text(author_names(" · "))]),
        doi_badges(),
        html.div([attribute.class("figures")], [
          figure(50, "thinkers", "#thinkers"),
          figure(100, "pages, two each", "#thinkers"),
          figure(
            list.length(content.notes),
            "notes in the second brain",
            "#notes",
          ),
          // The commits behind the built revision; left out when the build had no history.
          case content.commits {
            0 -> element.none()
            n -> figure(n, "commits", content.repo <> "/commits/main")
          },
        ]),
        github_pill(),
        html.nav(
          [attribute.class("stamps"), attribute.aria_label("Projects")],
          list.map(content.logos, stamp),
        ),
        html.p([attribute.class("status")], [
          html.text(content.version <> " · text CC BY 4.0, build AGPL-3.0"),
        ]),
      ]),
    ]),
  ])
}

/// A project's mark as a linked stamp, after the logo band of picasso's site. The dark SVG, when
/// the project publishes one, follows the reader's colour scheme.
fn stamp(logo: Logo) -> Element(msg) {
  let name = string.capitalise(logo.name)
  let img =
    html.img([
      attribute.src(logo.svg),
      attribute.alt(name <> " logo"),
      attribute.attribute("width", logo.width),
      attribute.attribute("height", logo.height),
    ])
  let mark = case logo.svg_dark {
    "" -> img
    dark ->
      html.picture([], [
        html.source([
          attribute.attribute("media", "(prefers-color-scheme: dark)"),
          attribute.attribute("srcset", dark),
        ]),
        img,
      ])
  }
  let label = case logo.label {
    "" -> []
    l -> [html.b([], [html.text(l)])]
  }
  html.a(
    [
      attribute.class("stamp"),
      attribute.data("logo", logo.name),
      attribute.href(logo.href),
      attribute.rel("noopener"),
    ],
    [mark, html.span([], list.append(label, [html.text(logo.text)]))],
  )
}

// GitHub's own mark, loaded from GitHub and never copied here (TRADEMARKS.md).
const github_icon = "https://github.githubassets.com/favicons/favicon.svg"

/// "owner/name" of the repository, as #(owner, name).
pub fn repo_name() -> #(String, String) {
  case list.reverse(string.split(content.repo, "/")) {
    [name, owner, ..] -> #(owner, name)
    _ -> #("", content.repo)
  }
}

/// One pill in the middle of the cover that opens the repository on GitHub: the mark, the
/// repository's name, the latest release, and a star to ask for one. After the pill of
/// marola-dev/marola-site's navigation; the round shape is picasso's site's, and the star is one
/// line that crosses itself.
fn github_pill() -> Element(msg) {
  let #(owner, name) = repo_name()
  html.p([attribute.class("gh-row")], [
    // The paper itself comes first: the PDF built with this page.
    html.a([attribute.class("gh gh-read"), attribute.href(pdf(Original))], [
      html.span([attribute.class("gh-name")], [html.text("read the paper")]),
      html.span([attribute.class("gh-version")], [html.text("PDF")]),
    ]),
    html.a(
      [
        attribute.class("gh"),
        attribute.href(content.repo),
        attribute.rel("noopener"),
        attribute.aria_label(
          owner <> "/" <> name <> " on GitHub: star the repository",
        ),
      ],
      [
        html.img([
          attribute.src(github_icon),
          attribute.alt(""),
          attribute.width(20),
          attribute.height(20),
        ]),
        html.span([attribute.class("gh-name")], [
          html.span([attribute.class("gh-owner")], [html.text(owner <> "/")]),
          html.text(name),
        ]),
        case latest_version() {
          Ok(#(version, _)) ->
            html.span([attribute.class("gh-version")], [html.text(version)])
          Error(_) -> element.none()
        },
        html.span([attribute.class("gh-star")], [html.text("star")]),
      ],
    ),
  ])
}

fn figure(value: Int, label: String, href: String) -> Element(msg) {
  html.a([attribute.class("figure"), attribute.href(href)], [
    html.b([], [html.text(int.to_string(value))]),
    html.span([], [html.text(label)]),
  ])
}

fn thinkers_section() -> Element(msg) {
  let named =
    list.filter(content.thinkers, fn(t: Thinker) { t.status != "open" })
  html.section(
    [attribute.aria_labelledby("thinkers"), attribute.class("feature")],
    [
      section_head(
        "thinkers",
        "The 50 Thinkers",
        external(content.repo <> "/blob/main/50THINKERS.md", "50THINKERS.md"),
      ),
      html.p([attribute.class("sub")], [
        html.text(
          "The book is 100 pages: 50 thinkers, two first-person pages each. "
          <> int.to_string(list.length(named))
          <> " are proposed, "
          <> int.to_string(50 - list.length(named))
          <> " places are still open.",
        ),
      ]),
      html.ol(
        [attribute.class("thinkers")],
        list.map(content.thinkers, fn(t: Thinker) {
          let open = t.status == "open"
          html.li(
            [
              attribute.class(case open {
                True -> "thinker is-open"
                False -> "thinker"
              }),
              attribute.style("--i", int.to_string(t.n)),
            ],
            [
              html.span([attribute.class("n")], [html.text(int.to_string(t.n))]),
              html.b([], [
                html.text(case open {
                  True -> "Open"
                  False -> t.name
                }),
              ]),
              case open {
                True -> element.none()
                False -> html.span([attribute.class("why")], [html.text(t.why)])
              },
            ],
          )
        }),
      ),
    ],
  )
}

fn notes_section() -> Element(msg) {
  html.section(
    [attribute.aria_labelledby("notes"), attribute.class("feature")],
    [
      section_head(
        "notes",
        "Second brain",
        external(content.repo <> "/blob/main/notes/index.md", "notes/index.md"),
      ),
      html.p([attribute.class("sub")], [
        html.text(
          "A Zettelkasten that Obsidian opens: one idea per note, linked, each with its verification status. The book is written from it.",
        ),
      ]),
      html.ul(
        [attribute.class("notes")],
        list.map(content.notes, fn(n: Note) {
          html.li([attribute.class("note")], [
            html.a(
              [
                attribute.href(
                  content.repo <> "/blob/main/notes/" <> n.file <> ".md",
                ),
                attribute.rel("noopener"),
              ],
              [html.text(n.title)],
            ),
            html.span([attribute.class("tags")], [
              html.span([attribute.class("tag")], [html.text(n.kind)]),
              html.span([attribute.class("tag is-" <> n.status)], [
                html.text(string.replace(n.status, "-", " ")),
              ]),
            ]),
          ])
        }),
      ),
    ],
  )
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
        pdf(PtBr),
        "Edição em português (PDF)",
        "The printed edition in Brazilian Portuguese, with the same citations and numbers.",
      ),
      card(
        content.repo <> "/releases",
        "Releases",
        "Each tagged release: the PDFs and the arXiv source bundle. Zenodo archives each one and gives it a permanent DOI.",
      ),
    ]),
    html.div([attribute.class("stats")], [
      stat(content.pages, "pages"),
      stat(list.length(content.sections), "sections"),
      stat(content.references, "references"),
      stat(content.verified, "references fetched and verified"),
      stat(list.length(content.authors), case list.length(content.authors) {
        1 -> "author"
        _ -> "authors"
      }),
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
    Ste -> content.abstract_ste
    _ -> content.abstract
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
    section_head("authors", "Author", element.none()),
    html.ul(
      [attribute.class("labs")],
      list.map(content.authors, fn(a: Author) {
        let w = content.writer
        html.li([], [
          html.b([attribute.class("name")], [html.text(a.name)]),
          case w.name == a.name {
            True -> element.none()
            False ->
              html.p([], [
                html.text(
                  "The name on the cover. Written in the first person by ",
                ),
                html.b([], [html.text(w.name)]),
                html.text("."),
              ])
          },
          html.p([], [html.text(w.affiliation)]),
          html.p([], [
            external("https://orcid.org/" <> w.orcid, "ORCID " <> w.orcid),
          ]),
          case content.works {
            [] -> element.none()
            works ->
              html.div([], [
                html.p([], [
                  html.text("Other citable work by " <> w.name <> ":"),
                ]),
                html.ul(
                  [attribute.class("works")],
                  list.map(works, fn(k: Work) {
                    html.li([], [
                      external(k.href, k.name),
                      html.text(": " <> k.text <> " "),
                      doi_link("DOI", k.doi),
                    ])
                  }),
                ),
              ])
          },
          html.p([], [
            html.text("The ouroboric ideas are Bruno Valério's ("),
            external("https://github.com/ouroboric-dev/ouroboric", "Ouroboric"),
            html.text(")."),
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
        "A tag makes a GitHub release with the PDFs and the arXiv source. Zenodo archives the release and mints its permanent DOI a few minutes later.",
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

/// The band of a citation score, as the script's colours: 75 and up, 25 and up, below.
pub fn band(percent: Int) -> String {
  case percent {
    p if p >= 75 -> "high"
    p if p >= 25 -> "mid"
    _ -> "low"
  }
}

/// CITATION_SCORES.md on the page: how much of each README is cited.
fn scores_section() -> Element(msg) {
  case content.scores {
    [] -> element.none()
    scores ->
      html.section([attribute.aria_labelledby("scores")], [
        section_head(
          "scores",
          "Citation scores",
          external(
            content.repo <> "/blob/main/CITATION_SCORES.md",
            "CITATION_SCORES.md",
          ),
        ),
        html.p([attribute.class("sub")], [
          html.text(
            "How much of each README is cited: the share of its sentences that carry a link, a DOI or another citation mark. A README is not a paper, and a low score is not a fault; it says how much of a text points at something else.",
          ),
        ]),
        html.ul(
          [attribute.class("scores")],
          list.map(scores, fn(s: Score) {
            let href = case string.starts_with(s.href, "http") {
              True -> s.href
              False -> content.repo <> "/blob/main/" <> s.href
            }
            html.li([attribute.class("score is-" <> band(s.percent))], [
              html.p([attribute.class("score-name")], [
                external(href, s.name),
                html.span([], [html.text(" " <> s.file <> ", " <> s.at)]),
              ]),
              html.div(
                [
                  attribute.class("score-bar"),
                  attribute.role("img"),
                  attribute.aria_label(int.to_string(s.percent) <> "% cited"),
                ],
                [
                  html.span(
                    [
                      attribute.style("width", int.to_string(s.percent) <> "%"),
                    ],
                    [],
                  ),
                ],
              ),
              html.p([attribute.class("score-figure")], [
                html.b([], [html.text(int.to_string(s.percent) <> "% cited")]),
                html.text(
                  " "
                  <> int.to_string(s.cited)
                  <> " of "
                  <> int.to_string(s.total)
                  <> " sentences. "
                  <> s.verdict,
                ),
              ]),
            ])
          }),
        ),
        html.p([attribute.class("sub")], [
          html.text("Measured with "),
          external(
            content.repo <> "/blob/main/scripts/citation-score.sh",
            "scripts/citation-score.sh",
          ),
          html.text(
            ", which counts marks and cannot tell if a citation is right. Each row names the commit that was scored.",
          ),
        ]),
      ])
  }
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
    dois(),
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

// Each project's own site icon, loaded from where the project publishes it and never copied
// here: the names and icons are their owners' marks, not licensed with this repository.
const gleam_icon =
  "https://raw.githubusercontent.com/gleam-lang/branding/01ae432a99a83216c23c34dfe666ea4c4e651582/lucy/lucy-circle.svg"

const claude_code_icon =
  "https://code.claude.com/docs/_mintlify/favicons/claude-code/pLsy-mRpNksna2sx/_generated/favicon/favicon-32x32.png"

fn made_with(name: String, icon: String, href: String) -> Element(msg) {
  html.a([attribute.href(href), attribute.rel("noopener")], [
    html.img([
      attribute.src(icon),
      attribute.alt(""),
      attribute.width(16),
      attribute.height(16),
    ]),
    html.text(" " <> name),
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
    html.p([attribute.class("made-with")], [
      html.text("Made with "),
      made_with("Gleam", gleam_icon, "https://gleam.run"),
      html.text(" and "),
      made_with(
        "Claude Code",
        claude_code_icon,
        "https://claude.com/claude-code",
      ),
      html.text("."),
    ]),
    html.p([], [
      html.text(
        "The cover after the type and colours of the cover of Hoppe's Democracy: The God That Failed (2001); no cover art is reproduced. Marola's, Ouroboric's, Gleam's and Claude Code's names and logos are not licensed here; the logos load from their owners' sites.",
      ),
    ]),
  ])
}
