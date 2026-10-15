---
title: "Works: full texts copied as is"
status: draft
date: 2026-10-15
related: [.claude/skills/ouro-get/SKILL.md, scripts/ouro-get.sh, 500AUTHORS.md, REUSE.toml, LICENSES/LicenseRef-PublicDomain.txt]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Works

Full texts the book reads, copied **as is**, byte for byte, from where they were published. A
text comes here only when it is free to copy in the United States and in Brazil. The `ouro-get`
skill (`.claude/skills/ouro-get/SKILL.md`) gets them. `REUSE.toml` marks `works/**/*.txt` as
`LicenseRef-PublicDomain`.

A work that is not free to copy gets a row in [Not copied](#not-copied): its citation, and why.

## Copied

<!-- One section per work, newest last (ouro-get, step 5). -->

### The Dream of a Ridiculous Man, Fyodor Dostoevsky (1877)

- **File:** [`works/dostoevsky/pg40745.txt`](dostoevsky/pg40745.txt), lines 7986–8683 (the file
  also holds eight other stories: *An Honest Thief*, *A Novel in Nine Letters*, *An Unpleasant
  Predicament*, *Another Man's Wife*, *The Heavenly Christmas Tree*, *The Peasant Marey*, *The
  Crocodile* and *Bobok*, with the Project Gutenberg header and licence)
- **Source:** Project Gutenberg eBook #40745, <https://www.gutenberg.org/cache/epub/40745/pg40745.txt>,
  fetched 2026-10-15, sha256 `e9edcecd5731892dfde5a12bbcbc78cde06b74585d69f3226fc818bce08d02a1`
- **Edition:** *Short Stories*, by Fiodor Dostoievski, "The World's Popular Classics", Books, Inc.,
  New York and Boston (no date on the title page), made from images at the Internet Archive
- **Translator:** not named in the file; identified as Constance Garnett (1861–1946). The nine
  stories are, in the same order, the contents of Garnett's *An Honest Thief and Other Stories*
  (Heinemann, 1919), and the first paragraphs match, word for word, the Garnett text on
  Wikisource (<https://en.wikisource.org/wiki/The_Dream_of_a_Ridiculous_Man>, read 2026-10-15,
  which dates the translation 1916)
- **Licence:** public domain. US: Garnett's translation was first published in 1919 (1916 by
  Wikisource), before 1931, and Project Gutenberg cleared the print edition as not protected by
  US copyright. Brazil: Dostoevsky died in 1881 and Garnett on 17 December 1946, both before 1956
  (Lei 9.610/98, art. 41). Fairly sure: the identification rests on the contents and the text,
  not on a named translator; a scan of the Books, Inc. title page verso naming Garnett would make
  it sure. If the translator were not Garnett, the edition is still a reprint of a pre-1931
  translation, but the Brazilian test would need that translator's death year.

### Integer multiplication below n log n, OpenAI (2026)

- **Files:** [`works/openai/integer-multiplication-below-n-log-n/`](openai/integer-multiplication-below-n-log-n/):
  `paper.pdf`, and `build/`, its LaTeX source (`main.tex`, 12 sections, `references.bib`, and the
  two figures, drawn in TikZ). 17 files, unchanged.
- **Source:** openai/math, `preprints/Integer-multiplication-below-n-log-n-September-23-2026/`,
  <https://github.com/openai/math/tree/1581d4cbdd69a0faf34b2089614fe2a814316a6a/preprints/Integer-multiplication-below-n-log-n-September-23-2026>,
  commit `1581d4c`, fetched 2026-10-15; `paper.pdf` sha256
  `834f644c3ce67932b9f7357d3615fb8fea4a7ff198d90e4f6883a15ba9df7129`
- **Edition:** the preprint dated 23 September 2026, author "OpenAI", in OpenAI's mathematics
  release of 6 October 2026 (the repository's first commit).
- **Translator:** none
- **Licence:** Apache-2.0, not public domain. The repository's `LICENSE` is Apache-2.0, and the
  preprint folder has no licence of its own. Apache-2.0 lets anyone copy and share the work if the
  licence goes with it: its text is [`LICENSES/Apache-2.0.txt`](../LICENSES/Apache-2.0.txt),
  copied from that `LICENSE`, and `REUSE.toml` marks the folder.

## Not copied

| Work | Author, translator | Why not | Where to read it |
|---|---|---|---|
