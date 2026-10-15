---
name: ouro-get
description: "Get the full text of a work that is free to copy (public domain or an open licence), paste it as is into works/ with its licence marked, and index it in this repository. Use when asked to get, fetch, download, copy or keep the full text of a book, story, essay or poem by an author, when the owner says a work is old or in the public domain, or before notes on a thinker's work need the text itself. It also says no, with a citation only, when the text is not free to copy."
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# ouro-get

Read a thinker's work in the work itself. This skill brings the full text into `works/`, byte for
byte, so that notes and essays can quote it with a line number. It copies a text only when the
law lets everyone copy it; otherwise it records where to read it, and stops.

## 1. Find the text

Prefer a source that says what the text is and lets you copy it:

1. **Project Gutenberg** (gutenberg.org): plain text, with a header that names title, author and
   often translator. `scripts/ouro-get.sh` fetches it.
2. **Standard Ebooks** (CC0 for their work) or **Wikisource** (the page names its edition).

Find the eBook that holds the work; a short story is often inside a collection. Read the
header and the first pages: title, author, translator, editor, the edition it was made from, and
its year.

## 2. Decide if it is free to copy

The owner works from Brazil, and the repository is on GitHub, in the United States. So a text is
free to copy only when it is free in **both**:

| Test | Free when (in 2026) | Source |
|---|---|---|
| United States | first published **before 1931** | 17 U.S.C. § 304; Cornell's public domain chart |
| Brazil, named author | the author died **before 1956** (70 years from 1 January after the death) | Lei 9.610/98, art. 41 |
| Brazil, anonymous work | first published **before 1956** | Lei 9.610/98, art. 43 |

**A translation is its own work** (Lei 9.610/98, art. 7, XI). Test the translator as you test
the author. Dostoevsky died in 1881, but a translation made in 2000 is not free. When the file
does not name the translator, try to identify the translation (same contents, same first
sentence as a known edition) and say how sure you are. If you cannot, treat the translation as
anonymous and use the year of its first publication.

Under an open licence (CC0, CC BY, CC BY-SA), the text is free to copy if you keep the licence
and the notice. Record which.

**When it is not free** (or you cannot tell): do not copy the text. Add a row to "Not copied" in
`works/index.md`, with the citation and the reason, and tell the owner. A short quotation for
study or criticism, with author and source, is still allowed in a note (Lei 9.610/98, art. 46,
III), but that is the note's business, not this skill's.

## 3. Copy it as is

```sh
scripts/ouro-get.sh <ebook-number> <author-slug> "TITLE OF THE WORK"
```

It writes `works/<author-slug>/pg<number>.txt`, unchanged, and prints the header, the sha256,
the `START`/`END` markers and the line where the work starts. Keep the whole eBook, the Project
Gutenberg header and licence included: that licence asks for itself to stay when the file is
copied under the Project Gutenberg name. Do not trim, reflow or fix typos. For a source the
script does not cover, save the file by hand with `curl`, unchanged, and take its sha256.

Find the line where the work ends (the next work's title, or `THE END`) with `grep -n`.

## 4. Mark the licence

`REUSE.toml` already marks `works/**/*.txt` as `LicenseRef-PublicDomain`
(`LICENSES/LicenseRef-PublicDomain.txt`). A text under an open licence needs its own
`[[annotations]]` block in `REUSE.toml`, with the licensor's notice and SPDX id, closer than
the public domain one.

## 5. Index it

Add one section under "Copied" in `works/index.md`:

```markdown
### <Work title>, <author> (<year written>)

- **File:** [`works/<author>/pg<n>.txt`](<author>/pg<n>.txt), lines <a>–<b> (<what else the file holds>)
- **Source:** Project Gutenberg eBook #<n>, <url>, fetched <YYYY-MM-DD>, sha256 `<hash>`
- **Edition:** <the edition the eBook was made from, as its header and title page say>
- **Translator:** <name, death year> | <not named; identified as X because Y> | none
- **Licence:** public domain. US: <reason>. Brazil: <reason>. <how sure, and what would make it sure>
```

Then:

- In `500AUTHORS.md`, put the work and its path in the author's "Read in" cell.
- In `50THINKERS.md` and its easy pt-BR version, do not change the row: a thinker's row says why
  the thinker is in the book, not where the text is.

## 6. Check

Run `just check` (inside `nix develop`). Then `scripts/readme.sh --lock` if you changed this
skill. Report: the file, its lines, the licence reasoning, and anything you were not sure of.

## Sources

- Lei 9.610/98, arts. 7 XI, 41, 43, 46 III, read at
  <https://www.planalto.gov.br/ccivil_03/leis/l9610.htm> on 15 October 2026.
- Cornell University Library, "Copyright Term and the Public Domain in the United States", read
  at <https://guides.library.cornell.edu/copyright/publicdomain> on 15 October 2026: works
  published before 1931 are in the public domain.
- The Project Gutenberg License, in each eBook (section 1.C and 1.E).
