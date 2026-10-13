<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# AGENTS.md

This repository is Paper Fabric and the papers it builds. It is a map, not a manual. Read the
linked docs before you change what they cover.

## Map

- Papers: `papers/<slug>/` holds `metadata.md`, `prose/NN-*.md`, `refs.bib` and `REFERENCES.md`.
- Build: `just`, `just check`, `just --list`. Toolchain: `nix develop` (picasso's `paper` lab, pinned in
  `flake.lock`). Release and secrets: the README.
- Website: `site/` (Gleam + Lustre). `just site-build`. `site/content.py` generates its content from
  the paper; never write a fact into `site/src` by hand.
- Charter and direction: `docs/1-product/charter.md`.
- How a paper is made: `docs/4-ways-of-working/paper-fabric.md`.
- Ouroboric conventions used here: `docs/4-ways-of-working/ouroboric-patterns.md`.
- Release and Zenodo: `docs/4-ways-of-working/releasing.md`.
- Known gaps: `docs/1-product/readiness/`.

## Invariants

1. Humans steer, agents build. Do not change a paper's thesis, authors or conclusions without a
   human-approved task.
2. Never invent a reference. Fetch every source before you cite it. Record the check in the
   paper's `REFERENCES.md`. If you cannot fetch a source, do not cite it; mark the claim
   unverified instead.
3. Never invent an author's experience. Write `**[AUTHOR ANECDOTE: ...]**` and leave it for the
   author.
4. Mark interpretation with `**[ANALYSIS]**`. Keep facts and analysis in separate paragraphs.
5. Report allegations as allegations. Name the source and the status of any legal case.
6. Never publish a Zenodo deposit. Drafts only; a human publishes. A DOI is permanent.
7. Never commit secrets, tokens or personal contact data.

## The book (hard rule)

*Closed Source: The God that Failed* has exactly 100 pages: 50 authors, two pages per author
(Hoffmann, 12 October 2026; first 50 pages and one per author, changed the same evening). The 50
authors are thinkers the book is about, and each gets two first-person pages; the cover names Mr.
Nobody. `papers/closed-source/THINKERS.md` is the roster, and `just check` fails unless it has
exactly 50 distinct thinkers. A change that breaks the 100-page count is wrong. The current
11-section text is material for those pages; ask the owner before you restructure it.

After the 100 pages, the book carries a partial snapshot of `h0ffmann/nagori` (Hoffmann, 12
October 2026), outside the 100-page count. nagori is a private repository: the owner chooses which
parts go in and at which commit, and an agent copies nothing from it that the owner did not name.
The snapshot states the commit it was taken from.

## Two languages (hard rule)

The book is distributed in Brazilian Portuguese (pt-BR) and English (en) (Hoffmann, 12 October
2026). Every release ships both editions, each with the same 50 thinkers and 100 pages. A change
to one edition's facts goes into the other in the same pull request, as `prose/` and `prose-ste/`
already do. The pt-BR edition does not exist yet.

## The opponent (hard rule)

The book's enemies are the proclaimed AI gurus (Hoffmann, 12 October 2026): people who sell
certainty about AI without open work that anyone can check. None of the 50 thinkers is one. The
book argues against their claims, not their persons: quote each claim exactly, cite where it was
made, and answer it with evidence. Name a person only for a public claim that a source records;
never state a private fact, a motive or an accusation that no source supports.

## Every Markdown file is cited (hard rule)

Each Markdown file names its main author and its last author (Hoffmann, 12 October 2026), on one
line after its front matter, or as its first line: `<!-- cite: main="Claude"; last="Matheus
Hoffmann" -->`. Both are personas in `PERSONAS.md`. A new file gets the line when it is created;
`just check` fails without it.

## Local render (hard rule)

`just paper` and `just book` render the book on any Ubuntu that has only Nix and the `just` from
`apt` (Hoffmann, 12 October 2026). Every tool comes from picasso's `paper` lab through
`flake.nix`; nothing else may need to be installed on the machine. A recipe must parse with just
1.21 (Ubuntu 24.04). CI's `ubuntu-just` job runs `just book` this way.

## Notes

Notes go into `notes/` as a Zettelkasten that Obsidian reads, under `SMART_NOTE_POLICY.md`: one
idea per note, a permanent id, links between notes, a status that is `unverified` until a source
is cited, and friends under an alias from `PERSONAS.md`. `/note` makes them; `just check` runs
`scripts/notes_check.py`.

## Borrow, cite, propagate

1. **Borrow** only what the licence allows. Read the licence first and record it. Keep the
   original SPDX line on copied files.
2. **Cite** at the point of use, with a DOI when one exists, else a URL with a commit hash.
3. **Propagate** credit: add borrowed works to `refs.bib`, and to `.zenodo.json`
   `related_identifiers` with `cites` or `isDerivedFrom`.

## Writing

- A paper's ASD-STE100 text is `papers/<slug>/prose-ste/`. If you change a fact in `prose/`,
  change it in `prose-ste/` in the same pull request. Use `/ste100` and log the pass in
  `papers/<slug>/STE100.md`.

- `OUROBORIC.md` and `OUROBORIC_RESEARCH.md` digest the public ouroboric-dev repositories. Refresh
  them with `just ouroboric-sources` and `/update-ouroboric`. Each fact in them has a source line;
  do not add one without its source.
- Style: `research` for papers (Ouroboric writing styles), `agent-facing` for this file.
- Short sentences. Active voice. No undefined jargon. Numbers over adjectives.
- Every doc has front matter: `title`, `status`, `date`, `related`, optional `style`.

## Checks before a pull request

1. `just check` passes with no pandoc warning.
2. `python3 scripts/citation.py --check` passes.
3. New references have a `verified` or `partial` row in `REFERENCES.md`.
