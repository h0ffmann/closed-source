---
name: print
description: "Turn the pure text of an essay of essays/ into a printed page: a one-page PDF whose text cannot be selected, with the book's name and DOI in its foot. Use when asked to print, render or make a PDF of an essay, or to check that an essay fits a page of the book."
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# print

The rules are in [`PRINTING.md`](../../../PRINTING.md). This page is the order of work.

## Steps

1. **Check the essay first:** `scripts/essay-montaigne.sh <essay>`. Do not print an essay that
   fails it.
2. **Print:** `just print <essay>` (or `scripts/print.sh <essay>` inside `nix develop`). The
   PDF goes to `pdf/essays/<name>.pdf`.
3. **If it says the essay makes more pages than it must:** cut the essay. Take out a sentence
   that repeats another, then the weakest trial. Do not change the type, the margins or the
   page in `scripts/print.sh` to make one essay fit. Only when the owner wants a longer essay,
   set `pages: 2` in its front matter.
4. **Look at the page.** Make a picture of it (`pdftoppm -r 90 -png <pdf> <name>`) and read it:
   the title, the draft line if it is a draft, no line of one word at the end, the foot.
5. **Report** the path, the page count, and that `pdftotext` finds no character. Say that the
   PDF is not committed, and that the Markdown file is the form a machine can read.

## Do not

- Do not commit a file of `pdf/`.
- Do not print the `## Sources` section, and do not delete it from the Markdown file.
- Do not present the printed page as protection that cannot be passed. `PRINTING.md`, "What
  rule 3 costs", says what it is.

## Sources

- [`PRINTING.md`](../../../PRINTING.md), written for this repository on 14 October 2026.
- The shape of this page: `.claude/skills/essay-montaigne/SKILL.md`, in this repository.
