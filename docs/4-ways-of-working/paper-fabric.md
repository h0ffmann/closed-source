---
title: How Paper Fabric makes a paper
status: draft
date: 2026-10-12
related: [../1-product/charter.md, ouroboric-patterns.md, releasing.md]
style: guide
---

# How Paper Fabric makes a paper

Paper Fabric is generic: nothing in the build knows about one paper. Add a paper by adding a
directory.

## 1. Start a paper

1. Create `papers/<slug>/` with `metadata.md` (title, authors with ORCID and affiliation,
   abstract, keywords), `prose/01-introduction.md` and an empty `refs.bib`.
2. Copy `papers/closed-source/REFERENCES.md`'s header into a new `REFERENCES.md`.
3. Run `just build <slug>`. The PDF lands in `pdf/<slug>.pdf`.

## 2. The loop

Each paper runs the same loop. The *who* column is the Ouroboric rule: humans steer, agents build.

| Step | Who | Output |
|---|---|---|
| Direction: thesis, audience, authors | authors | `metadata.md`, an outline in the prose files |
| Research: find and fetch sources | agent | `refs.bib` entries, `REFERENCES.md` rows |
| Draft: one prose file per section | agent | `prose/NN-*.md`, with `[ANALYSIS]` and `[AUTHOR ANECDOTE]` markers |
| Personal accounts | authors | the anecdote placeholders, filled |
| Check: `just check` | CI | PDF; fails on unresolved citations or unlogged references |
| Readiness: what blocks the next step | agent, then authors | `docs/1-product/readiness/` |
| Release: tag, PDF to a Zenodo draft, arXiv bundle | authors | GitHub release; DOI after a human publishes; arXiv submission by hand |
| Learn: what went wrong | agent, then authors | a journal entry; changes to this guide |

## 3. Rules that make the output credible

- **Reference checks.** An agent fetches every source before citing it and logs how. The 2026
  sources in the first paper show why: one DOI guessed from memory was wrong (Raymond 1998 is
  `v3i2.578`, not `v3i3.578`), and was caught by fetching.
- **Allegations stay allegations.** Legal cases are reported with their court, date, status and
  source. A docket that was not read directly is flagged.
- **Personal accounts belong to their authors.** Agents leave `**[AUTHOR ANECDOTE: ...]**`.
- **AI use is disclosed** in each paper's statements, and the agent configuration is exported to
  `.claude/`.

## 4. Toolchain

The build mirrors Sandy Maguire's (isovector) books: Markdown, pandoc with pandoc-crossref and
citeproc, a hand-written LaTeX template, XeLaTeX twice, and a revision stamp. Differences: no
Haskell `design-tools` filter, no EPUB target yet, a template that also compiles with pdfLaTeX
for arXiv, BibTeX through citeproc instead of
`pandoc-citeproc` (which pandoc 2.11 replaced), `just` instead of Make, and every tool pinned by
`flake.lock` through the `paper` lab of h0ffmann/picasso.
