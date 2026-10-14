---
title: "Printing: an essay to a printed page"
status: draft
date: 2026-10-14
related: [DERIVATION.md, essays/index.md, scripts/print.sh, .claude/skills/print/SKILL.md, LICENSE]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Printing: an essay to a printed page

How the pure text of an essay becomes a PDF for a page of the book. `just print <essay>` does
it (`scripts/print.sh`); the `print` skill says when and how to use it.

## Rules

1. **Only the essay's own text is printed.** The front matter, the cite line and the
   `## Sources` section stay in the Markdown file. A link is printed as its words.
2. **One page.** An essay fits one A5 page at 10 pt. A longer one says so in its front matter
   (`pages: 2`), and the build fails when the count is not the one it says. To make an essay
   fit, cut the essay; never shrink the type or the margins.
3. **No text that can be selected.** Each letter is drawn as a shape, so a reader of the PDF
   cannot select or copy the words. The owner asked for this (14 October 2026: "without
   selection, to respect license"). The build fails if `pdftotext` finds one character.
4. **The foot names the book and its DOI**, and says: "cite it, do not copy it".
5. **The source stays open.** The essay's Markdown file is in this repository under its licence.
   The printed page adds a barrier to copying; it removes no right that the licence gives.
6. **A draft is printed as a draft.** The line that says so is part of the text.
7. **The PDF is built, not committed.** It goes to `pdf/essays/`, which Git ignores, like the
   book's own PDFs. Build it again with the same recipe.
8. **The same toolchain as the book**: pandoc and XeLaTeX from the pinned lab, then
   `pdftocairo` and `rsvg-convert` for the shapes. Nothing else is installed.

## What rule 3 costs

A PDF with no text cannot be read by a screen reader, searched, or indexed. So the printed page
is never the only form: every printed essay has its Markdown file, which a machine and a blind
reader can read. Say this where a printed PDF is published.

It is also a barrier and not a lock. A person can still type the page again, or run character
recognition on it. The licence is what protects the text; the shapes only say that copying
was not invited.

## How

```sh
just print essays/2026-peer-reviewing-the-god-that-failed.md   # pdf/essays/<name>.pdf
just print --all
```

## Sources

- The owner's request of 14 October 2026, in `.claude/project/request.md`.
- The page size and the count rule follow the book's hard rule of two pages for each thinker
  (`AGENTS.md`): a page is a fixed thing, and a text is cut to it.
