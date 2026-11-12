---
title: "Cut the roster from 50 thinkers to 33"
status: proposed
date: 2026-11-12
related: [../README.md, ../../../../AGENTS.md, ../../../../33THINKERS.md, ../../../../33THINKERS.easy.pt-BR.md, ../../../../500AUTHORS.md, ../../../../timeline/lives.tsv]
style: procedure
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Cut the roster from 50 thinkers to 33

**Asked 2026-11-12:** the owner wrote "in a new PR reduce to 33 thinkers". The owner approves this
proposal when they merge the pull request.

## Why

AGENTS.md, invariant 9: "The book" is a hard rule, and a change to it is a change proposal that
the owner approves. The rule said 50 authors and 100 pages. Two pages per author stays, so 33
authors make 66 pages.

## Which 17 rows were cut

The owner did not name the rows. The cut follows three rules, in this order:

1. **Keep every row the owner chose** (status `chosen`, 23 rows), and the open row that keeps a
   place for the reverse-engineering thinker the owner will name (old row 32).
2. **Keep the two thinkers the book is built on**, though the paper does not cite them yet:
   Robert M. Pirsig (ADR 001, the most cited author of the book) and Hans-Hermann Hoppe (the title
   formula).
3. **Keep the 7 `proposed` thinkers whose works the paper cites most**, counted as citation keys
   of their works in `papers/closed-source/prose/*.md` on 12 November 2026: Pamela Samuelson and
   Suzanne Scotchmer (7, `samuelson2002law`), Nicholas Carlini (5), John F. Nash (4), Eric S.
   Raymond (3), Florian Tramèr (3) and Arfon M. Smith (3).

Cut (old number, citation keys in `prose/`):

| Old # | Row | Keys |
|---:|---|---:|
| 6 | Linus Torvalds | 2 |
| 8 | Boaz Barak | 1 |
| 14 | Marc Stevens | 1 |
| 16 | Michele Boldrin | 0 |
| 19 | David K. Levine | 0 |
| 21 | Geoffrey Hinton | 1 |
| 22 | Stephan Kinsella | 0 |
| 23 | Ronald L. Rivest | 2 |
| 24 | open | — |
| 26 | Auguste Kerckhoffs | 2 |
| 27 | open | — |
| 29 | open | — |
| 31 | Gwern Branwen | 2 |
| 35 | Sandy Maguire | 1 |
| 36 | Adi Shamir | 2 |
| 38 | Mark D. Wilkinson | 1 |
| 45 | open | — |

Any of them can come back: swap it for a kept row.

## What changes

- `33THINKERS.md` and `33THINKERS.easy.pt-BR.md`: 33 rows, in the same order, numbered 1 to 33.
  After the cut no two neighbours share an area. The easy version drops the hard words that only
  the cut rows used.
- `AGENTS.md`: the hard rule is 66 pages and 33 authors, in both editions.
- `tools/fabric book-check` checks 33 rows; `tools/fabric timeline` titles the drawing "The 33
  thinkers"; `timeline/lives.tsv` and `timeline/thinkers.svg` hold the 33.
- The site counts the thinkers and the pages from the roster, instead of a fixed 50 and 100.
- `500AUTHORS.md`: every cut thinker keeps a row (the paper still reads their work); the Thinker
  column holds the new numbers, and is empty for the cut rows.
- Pages that point at a thinker by number (`BIO_ROBERT_PIRSIG.md`, `PERSONAS.md`, ADR 001, the
  `essay-montaigne` skill) use the new numbers.

## What does not change

- The paper: `refs.bib` and the prose keep every citation. A thinker is a person the book is
  about; cutting one removes no reference.
- The file name stayed `50THINKERS.md` in this change. The owner asked for the rename to
  `33THINKERS.md` later the same day ("change to 33THINKERS"), in a separate pull request.
- `NAGORI.md` (written by hand, hard rule) and `CLAUDE_PROJECT.md` (not for agents, hard rule)
  still say 100 pages. Only the owner changes them.
- Dated texts (essays, notes, `RELEASES.md`, `.claude/project/request.md`, the social posts) say
  what was true on their date.
