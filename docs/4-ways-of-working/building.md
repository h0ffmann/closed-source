---
title: "Build the PDFs and the site"
status: draft
date: 2026-11-13
related: [../../README.md, ../../justfile, ../../flake.nix, paper-fabric.md, ste100.md, releasing.md]
style: procedure
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Build the PDFs and the site

The README gives the two commands. This page gives the rest: the toolchain, the three editions,
the website and the layout of the repository. It was moved here from `README.md` on 13 November
2026, with no change of fact.

## The commands

On any Ubuntu, you need only Nix and `just`. Nothing else is installed on the machine. Nix comes
from the official installer at [nixos.org](https://nixos.org/download/):

```sh
curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon        # Nix, once; then open a new shell
echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf   # flakes on, once
sudo apt install just                                               # just 1.21 on 24.04
just paper     # the PDFs, in picasso's paper lab -> pdf/
just book      # the PDFs and the book's checks (33 thinkers, cite lines, references, STE)
```

The tools (pandoc 3.7, pandoc-crossref, XeLaTeX, pdfLaTeX, Gleam, Erlang, `just`, `gh`) come from
the `paper` lab of [h0ffmann/picasso](https://github.com/h0ffmann/picasso/tree/main/labs/paper),
pinned by `flake.lock`. `just paper` and `just book` turn flakes on for themselves; the commands
below need the `nix.conf` line above.

```sh
nix develop            # or `just shell`: every tool on PATH
just                   # every paper -> pdf/<slug>.pdf, pdf/<slug>-ste.pdf and pdf/<slug>-pt-BR.pdf
just build closed-source
just check             # build, then the reference-log and STE checks (what CI runs)
just arxiv             # arXiv source bundles, checked with pdfLaTeX, in build/arxiv/
just --list            # every recipe
```

## Tooling

The checks and generators are one Gleam project (Erlang target) in `tools/`. Run them as
`tools/fabric <command>` from the repository root, in `nix develop`. The commands are `arxiv`,
`book-check`, `citation`, `cite-check`, `content`, `logos`, `notes-check`, `refs-check`,
`ste-check` and `zenodo-upload`. `just` calls them for you. `cd tools && gleam test` runs their
tests.

## The three editions

Each paper builds twice: `pdf/<slug>.pdf` from `prose/`, and `pdf/<slug>-ste.pdf` from
`prose-ste/`, the same paper in ASD-STE100 Simplified Technical English (after h0ffmann/picasso's
`WHITEPAPER.md`). `/ste100` ([`.claude/commands/ste100.md`](../../.claude/commands/ste100.md))
makes the STE text; `tools/fabric ste-check`, run by `just check`, fails if it changes a citation,
quotation, number or marker. The passes are logged in `papers/<slug>/STE100.md`. A paper with
`prose-pt-BR/` also builds `pdf/<slug>-pt-BR.pdf`, the printed edition in Brazilian Portuguese;
`just check` runs `tools/fabric ste-check --translation` on it, so it keeps every citation, number
and quotation.

The toolchain follows Sandy Maguire's books
([isovector/thinking-with-types](https://github.com/isovector/thinking-with-types)): Markdown
prose, pandoc with pandoc-crossref and citeproc, a hand-written LaTeX template, XeLaTeX, and the
Git revision stamped on every page.

## Drawings of a flow

Tools, checks and the site are built with coding agents. Flows are drawn with archify, adopted
after [ww3-gpu](https://github.com/h0ffmann/ww3-gpu). archify
([tt-a1i/archify](https://github.com/tt-a1i/archify), MIT) draws a flow as an explorable HTML page
with inline SVG. It is not copied: it is the submodule `vendor/archify`, pinned at v3.0.1
(`2ab3cae`), and `.claude/skills/archify` links to it. Run `just archify init` once, then
`just archify render`, `pdf`, `check` or `refresh` ([`docs/archify/`](../archify/README.md)).

## The website

`site/` is the paper's website: a [Lustre](https://lustre.build) application in Gleam, in the
style of [picasso's site](https://h0ffmann.github.io/picasso/). The title, abstract (original and
ASD-STE100), authors, contents, counts and citations come from the paper and the README
(`tools/fabric content`), so the site never repeats a fact by hand. The PDFs ship with it.

```sh
just site-build        # PDFs, then site/dist/; needs only Nix and just
just site-serve        # the same, served on http://localhost:8000
```

Each half runs in its own toolchain from picasso: the `paper` lab for the PDFs and the
`gleam-website` lab for the site (`nix develop .#site`). The `site` workflow builds it on every
pull request and publishes `site/dist` to GitHub Pages from `main`. Turn that on once in
GitHub → Settings → Pages → Source: **GitHub Actions**. Pages needs no secret.

The cover carries a stamp for marola, after the logo band of picasso's site: it links the project
and loads its logo from its own repository, at the commit the paper's title page pins (`logos:` in
the paper's `metadata.md`). No logo is copied here ([`TRADEMARKS.md`](../../TRADEMARKS.md)).

The front page opens with the 33 thinkers and the second brain (`notes/`). The site is set like a
book cover, after the colour scheme and type of the cover of

> Hoppe, Hans-Hermann. *Democracy—The God That Failed: The Economics and Politics of Monarchy,
> Democracy, and Natural Order*. New Brunswick, NJ: Transaction Publishers, 2001. ISBN 0-7658-0088-8.

The identity is black and red, as on that cover, with the title in yellow letters; the owner set
it on 13 October 2026. The colours are choices, not samples. The book is under copyright
(© 2001), so the site copies no cover art and no text from it. The motion follows Anthropic's
[frontend-design skill](https://github.com/anthropics/skills) (Apache-2.0): one entrance, and
nothing moves when the reader asks for reduced motion. Hoppe argues that ideas should not be
property; the law still gives the copyright. [`BOOKS.md`](../../BOOKS.md) says more, with the
other books behind this repository.

## Layout

| Path | What's there |
|---|---|
| [`papers/closed-source/`](../../papers/closed-source/) | the paper: `metadata.md`, `prose/NN-*.md`, `refs.bib`, and the reference log `REFERENCES.md` |
| [`format/`](../../format/) | the LaTeX template and pandoc-crossref settings shared by every paper |
| [`justfile`](../../justfile), [`flake.nix`](../../flake.nix) | the build recipes, and the toolchain pins (picasso's `paper` and `gleam-website` labs) |
| [`site/`](../../site/) | the website: Gleam + Lustre, `tools/fabric content` reads the paper |
| [`tools/`](../../tools/) | the checks and generators, one Gleam project: reference check, STE check, arXiv bundle, citation metadata, site content and Zenodo upload |
| [`scripts/`](../../scripts/) | `release.sh`, which tags a release, `readme.sh`, which checks the README's style and its easy version, and `citation-score.sh`, which scores how much of a text is cited |
| [`README.easy.pt-BR.md`](../../README.easy.pt-BR.md) | the README in easy Brazilian Portuguese, made from it by the `easy-pt-br` skill; `scripts/readme.sh` checks that it is current |
| [`.claude/skills/`](../../.claude/skills/README.md) | the agent skills written for this repository, pinned in `skills.lock` |
| [`docs/`](../README.md) | Paper Fabric's charter, ways of working, journal and readiness |
| [`.claude/`](../../.claude/README.md) | the exported Claude project configuration that produced this repository |
| [`TRADEMARKS.md`](../../TRADEMARKS.md), [`SECURITY.md`](../../SECURITY.md) | the names the licences do not cover; how to report a vulnerability |
| [`33THINKERS.md`](../../33THINKERS.md) | the book's roster: 33 thinkers, two pages each, 66 pages (the hard rule in AGENTS.md) |
| [`500AUTHORS.md`](../../500AUTHORS.md) | the long list the 33 thinkers are chosen from: up to 500 authors the book reads |
| [`WORKS.md`](../../WORKS.md) | the index of the writer's open works on h0ffmann, marola-dev and piabrota, with DOIs, licences and commits, and its date of record |
| [`RELEASES.md`](../../RELEASES.md) | each release with its date, its permanent DOI and what changed |
| [`KEYWORDS.md`](../../KEYWORDS.md), [`RELATED_WORK.md`](../../RELATED_WORK.md), [`GITHUB_REPO_TOPICS.md`](../../GITHUB_REPO_TOPICS.md) | how a reader finds this work: the Zenodo keywords, the works this one is tied to in Zenodo and DataCite, and the GitHub topics, each with its counts and its date of record |
| [`CITATION_SCORES.md`](../../CITATION_SCORES.md) | how much of four READMEs is cited (this repository's, marola, h0ffmann, picasso), measured by the `citation-score` skill; `just citation-board` writes it and the website shows it |
| [`BOOKS.md`](../../BOOKS.md) | the books behind the paper: Pirsig, Hoppe, Kinsella, Boldrin and Levine |
| [`SMART_NOTE_POLICY.md`](../../SMART_NOTE_POLICY.md), [`notes/`](../../notes/index.md) | the slip box: Zettelkasten notes for the book, Obsidian readable; `/note` makes one |
| [`DESCRIPTION.md`](../../DESCRIPTION.md), [`QUOTES.md`](../../QUOTES.md), [`ACRONYMOUS.md`](../../ACRONYMOUS.md), [`INDEX_REMISS.md`](../../INDEX_REMISS.md) | the one-paragraph description, the quotations with their sources, the acronyms, and the index of cross-references; skeletons until the ingest |
| [`NAGORI.md`](../../NAGORI.md) | the partial snapshot of the private `h0ffmann/nagori` after the 66 pages; written by the owner by hand, never by an agent or automation (hard rule) |
| [`forks/`](../../forks/README.md) | the owner's forks as shallow Git submodules |
| [`PERSONAS.md`](../../PERSONAS.md) | the personas that every Markdown file cites as its main and last author (hard rule) |
| [`AGENTS.md`](../../AGENTS.md) | the rules every agent follows here, including borrow, cite, propagate |
