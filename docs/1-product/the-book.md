---
title: "The book: history, references, licences and citation"
status: draft
date: 2026-11-13
related: [../../README.md, ../../BOOKS.md, ../../WORKS.md, ../../RELEASES.md, ../4-ways-of-working/releasing.md]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# The book: history, references, licences and citation

The README is short. This page keeps the detail it used to carry about the book itself. It was
moved here from `README.md` on 13 November 2026, with no change of fact.

## History and intent

The repository and the first draft were made on 12 October 2026, as a v0 preprint. The next day
it had three releases, and v0.3.0 became a book on Zenodo
([note](../../notes/202610132130-why-i-wrote-fast-from-preprint-to-book.md)). The rules of the
book came from the owner in those days and are in [`AGENTS.md`](../../AGENTS.md): 66 pages, 33
thinkers (100 and 50 until 12 November 2026), two languages, the proclaimed AI gurus as the
opponent, and a cite line on every file.

- **The claim.** Closed source asked researchers to trust that secrecy would protect their work.
  Between 2024 and 2026 that trust failed in public: agents decompile binaries, queries extract
  models, distillation copies them. If anyone can reverse engineer anything, the honest course is
  to publish the method, mint an identifier and cite whatever you use, and to ask the same of
  the agents that now do much of the reading and writing.
- **The root.** Pirsig wrote that "the number of rational hypotheses that can explain any given
  phenomenon is infinite"
  ([the note](../../notes/202610181353-pirsig-infinite-hypotheses-science-does-not-close.md)).
  So science never closes, and a method that only its owner can open is one that nobody else
  can test.
- **The title** borrows *The God that Failed*, the 1949 book of six writers who left the
  communist movement, for a smaller faith: that secret code, models and methods stay valuable.
  The colours, black and red with a yellow title, are after the cover of Hans-Hermann Hoppe's
  *Democracy: The God That Failed* (2001).
- **The intent** is to replace secrecy with professional citation: persistent identifiers,
  machine-readable metadata, and agents that borrow, cite and propagate credit by default. The
  book is written that way itself, in public, with agents, and every claim has a source or an
  `[ANALYSIS]` mark.
- **Why fast.** Everybody talked about reverse engineering with agents in October 2026, and the
  writer wanted the book out while the question was open (the same note).
- **What it is not.** It is not peer reviewed, and it argues against claims, not persons. What
  must change before v1: the
  [readiness assessment](readiness/2026-10-12-ready-to-promote.md).

## The big references

| Work | What the book takes from it | Where |
|---|---|---|
| Robert M. Pirsig, *Zen and the Art of Motorcycle Maintenance* (ZAMM), 1974 | the book it stands on: quality, the rider who can open the engine, and the infinite hypotheses of chapter 10. Named in the abstract, cited in the introduction (`pirsig1974zen`), and a `references` tie by ISBN in `.zenodo.json`, which Zenodo shows from the next release | [`BOOKS.md`](../../BOOKS.md), [ADR 001](../2-engineering/adr/001-pirsig-is-the-most-cited-author.md), [biography](../../BIO_ROBERT_PIRSIG.md), [essay](../../essays/2026-the-hypotheses-have-no-end.md) |
| Hans-Hermann Hoppe, *Democracy: The God That Failed*, 2001 | the title's second half and the colours; no art or text is copied | [`BOOKS.md`](../../BOOKS.md) |
| Stephan Kinsella; Michele Boldrin and David K. Levine | the case against intellectual property, beside Hoppe's | [`BOOKS.md`](../../BOOKS.md) |
| Michel de Montaigne, *Essays* | what an essay must be: the rules that check each essay | [`essay-montaigne`](../../.claude/skills/essay-montaigne/SKILL.md) |

## Licence research

Before anything is copied here, its licence is read and recorded (AGENTS.md, "Borrow, cite,
propagate").

- **Full texts** go into [`works/`](../../works/index.md) only when they are free to copy in the
  United States and in Brazil: in the US, published before 1931; in Brazil, 70 years after the
  author's death (Lei 9.610/98, art. 41). The [`ouro-get`](../../.claude/skills/ouro-get/SKILL.md)
  skill does the check, and a work that fails it gets a citation and the reason, never the text.
- **ZAMM is under copyright**, so it is quoted briefly, with its page, and never copied
  ([`QUOTES.md`](../../QUOTES.md)). The same holds for Hoppe's book and its cover.
- **Borrowed code and skills** keep their SPDX line, and [`REUSE.toml`](../../REUSE.toml) records
  the licence of each file. Names and logos of other projects are not licensed here
  ([`TRADEMARKS.md`](../../TRADEMARKS.md)).
- **A work by OpenAI** in `works/openai/` was copied under its Apache-2.0 licence
  ([`works/index.md`](../../works/index.md)).

## The writer's works

The writer works in the open on three GitHub accounts: `h0ffmann`, `marola-dev` and `piabrota`.
[`WORKS.md`](../../WORKS.md) is the full index, with the DOI, the licence and the commit of each
work, and its date of record. The book's record cites four of them. The site shows five as tiles.

## Two DOIs: the latest and the permanent

A DOI is an identifier that keeps resolving when a URL moves. Zenodo gives this work two kinds,
and each answers a different question.

| | Latest DOI (concept DOI) | Permanent DOI (version DOI) |
|---|---|---|
| This work | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) | one for each release, listed in [`RELEASES.md`](../../RELEASES.md) |
| Resolves to | the newest release, whichever it is on the day you click | one release, the same bytes forever |
| How many | one for the whole work | one for each release |
| Changes when a release is made | no; it starts to point at the new release | no; the new release gets its own |
| Use it to | cite the work: "Closed Source: The God that Failed" | say exactly which text you read, quoted or reproduced |

- **Cite the latest DOI** in a reference list. A reader then gets the corrected text, and all
  citations count for one work.
- **Add the permanent DOI** when the exact wording matters: a quotation, a reproduction, a
  review. A version's DOI will always be the source archive of that version's tag.
- Neither can be deleted. A wrong release stays on Zenodo; a new release replaces it only as the
  latest.

`just release` makes a new permanent DOI: Zenodo archives the release and mints it a few minutes
after the tag ([releasing](../4-ways-of-working/releasing.md)). So a release cannot print its own
permanent DOI; [Zenodo's page for the latest DOI](https://zenodo.org/doi/10.5281/zenodo.23333656)
lists every version with its DOI, and so does [`RELEASES.md`](../../RELEASES.md).

## How a reader finds this work

You only need to be seen by the right people
([note](../../notes/202610130845-seen-by-the-right-people.md)). For this paper they are reverse
engineers first, then the people who work on research software. Three kinds of word lead a
reader here. Each has its own page, with the counts and the day they were read.

| | What it is | Where a reader meets it | Page |
|---|---|---|---|
| Keywords | phrases on the Zenodo record, such as "reverse engineering" and "decompilation" | on any Zenodo record, a keyword is a link to every record with the same keyword | [`KEYWORDS.md`](../../KEYWORDS.md) |
| Related work | the works this one cites, by DOI | Zenodo's "related works" box; Zenodo sends the ties to DataCite, which counts them in both directions | [`RELATED_WORK.md`](../../RELATED_WORK.md) |
| Topics | words on the GitHub repository, such as `reverse-engineering` | GitHub's topic pages and its search | [`GITHUB_REPO_TOPICS.md`](../../GITHUB_REPO_TOPICS.md) |

- **A keyword must be written as the reader writes it.** Zenodo has no fixed list, so "trade
  secret" and "trade secrets" are two different rooms.
- **A tie counts only when it is a DOI.** A link to a URL is kept, and not counted.
- **Both change only with a release.** A published version keeps the words and the ties it had.
- **A word is kept when the right reader would type it and the paper is about it.** A word that
  only brings more visitors is left out.
