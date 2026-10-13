---
name: readme-style
description: "Write or edit this repository's README.md in its house style: a centred header after picasso's README, and lower case everywhere except acronyms. Use when asked to change README.md, add a section or a badge to it, or fix a failure of scripts/readme.sh --check."
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# readme-style

`README.md` is the front door of this repository. It has one look, and a script checks it.

## The rules

1. **Lower case.** Every word of prose is in lower case: sentences, headings, names of people,
   projects and products. The owner asked for this on 13 October 2026.
2. **Acronyms keep their capitals:** UFRJ, IFS, DOI, PDF, CI, CC BY, AGPL, MIT, ASD-STE100, SSH,
   2FA. A plural keeps one small s: PDFs, DOIs. A word with one capital, or with mixed case, is
   not an acronym: write github, zenodo, arxiv, latex, bibtex.
3. **Not prose, so not changed:** code in backticks and code blocks, file names in backticks,
   link targets, HTML attributes, badge URLs, the cite line, and the block between
   `<!-- citation:start -->` and `<!-- citation:end -->`, which `just citation` generates.
4. **The header** is one centred `<div align="center">`, in this order: the icon, the `#` title,
   one `<sub>` line of links to the site and to the page's own sections, the badges, and one
   paragraph that says what the repository is. Badges use shields.io with `style=flat-square`.
5. **Sentences stay short and plain**, as AGENTS.md says under Writing. Lower case is the look;
   it does not excuse a long sentence.
6. **A fact changes in one place.** The citation block comes from `.zenodo.json`. The DOIs are in
   `tools/src/fabric/citation.gleam` and in `papers/closed-source/metadata.md`.

## How to work

1. Edit `README.md`.
2. Run `scripts/readme.sh --check`. It names each word that breaks rule 1.
3. The easy version is now older than the page. Use the `easy-pt-br` skill, then run
   `scripts/readme.sh --stamp`. A hook in `.claude/settings.json` reminds you after each edit of
   `README.md` and before the session ends.
4. Run `just check` before the pull request.

## Sources

Written for this repository. Nothing here is copied from another skill.

- The header's shape (centred block, `<sub>` link line, flat-square badges) is read from
  h0ffmann/picasso, `README.md` at commit `29eb385`
  (<https://github.com/h0ffmann/picasso/blob/29eb385/README.md>). Its text is not in lower case.
- The lower-case voice is read from h0ffmann/h0ffmann, `README.md` at commit `1a3a7e1`
  (<https://github.com/h0ffmann/h0ffmann/blob/1a3a7e1/README.md>). That page writes its acronyms
  in lower case too; this one does not, by the owner's rule.
- The way a skill names its sources and is pinned by a lock file is read from
  marola-dev/marola, `.claude/skills/skills.lock` and `.claude/skills/eli5/SKILL.md` at commit
  `cf7bd4f`.
