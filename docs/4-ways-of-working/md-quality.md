---
title: "The quality of the Markdown files"
status: draft
date: 2026-10-13
related: [AGENTS.md, scripts/md-quality.sh, .markdownlint-cli2.jsonc, .vale.ini, .github/workflows/md.yml, .github/workflows/links.yml, notes/202610131752-what-is-metaquality.md]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# The quality of the Markdown files

Three analysers read the Markdown files of this repository. Each one looks for one kind of fault.
`just md-quality` runs the three; the workflow `.md` runs them on each pull request and each push
to `main`, as the check ".md / quality".

```sh
just md-quality              # structure, prose, links to files: what CI runs
just md-quality --online     # the same, and every web link, the website's too
just md-quality --self-test  # each analyser gets a bad file and must refuse it
```

The tools come from the `md` shell in `flake.nix`, from the same pinned nixpkgs as the paper's
toolchain. Read on 13 October 2026: markdownlint-cli2 0.23.3, Vale 3.17.1, lychee 0.24.2.

## What each one checks

| Analyser | Fault | Configuration | Fails the check |
|---|---|---|---|
| [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2) | structure: a heading with no blank line, two blank lines, a list that is not set apart, a skipped heading level | `.markdownlint-cli2.jsonc` | every finding |
| [Vale](https://vale.sh) | prose: the four rules of AGENTS.md | `.vale.ini`, `.vale/styles/fabric/` | an error; a warning is advice |
| [lychee](https://lychee.cli.rs) | a link to a file or a heading that does not exist; with `--online`, a web link that does not answer | flags in `scripts/md-quality.sh` | every dead link |

## The prose rules

AGENTS.md says: "Short sentences. Active voice. No undefined jargon. Numbers over adjectives."
The style `fabric` was written here for those four rules. No rule file was copied from another
style.

| Rule | From | Level | What it finds |
|---|---|---|---|
| `fabric.PlainWords` | "No undefined jargon" | error | a long word where a plain one exists: `utilize` for `use`, `in order to` for `to` |
| `fabric.NumbersOverAdjectives` | "Numbers over adjectives" | error | a word that praises and measures nothing: `very`, `seamless`, `state-of-the-art` |
| `fabric.ShortSentences` | "Short sentences" | warning | a sentence of more than 35 words |
| `fabric.ActiveVoice` | "Active voice" | suggestion | a verb that may be passive |

The two errors have one fix each, so they can fail a build. A long sentence and a passive verb
are sometimes right, so they are advice. `vale --minAlertLevel=suggestion <file>` shows all four.

The idea of a list of words that praise and measure nothing is old: Vale's own `write-good`
style has a "weasel words" list (<https://github.com/errata-ai/write-good>). The lists here are
shorter and were written for this repository.

## What is left out, and why

| Left out | Of | Why |
|---|---|---|
| `forks/`, `LICENSES/`, `docs/4-ways-of-working/ouroboric/` | all three | other people's text |
| `OUROBORIC.md`, `OUROBORIC_RESEARCH.md` | all three | written by `just ouroboric-sources`, not by hand |
| `CLAUDE_PROJECT.md`, `NAGORI.md` | all three | the hard rules: no agent reads the first, only the owner writes the second |
| `papers/*/prose*/`, `papers/*/metadata.md` | all three | pandoc's Markdown; `tools/fabric ste-check` is their check |
| files in Portuguese | Vale | the rules are for English |
| `.claude/project/request.md` | Vale | the owner's requests, word for word |
| `notes/` | Vale | a note keeps an idea, and a quotation, as it came |
| line length (MD013), table padding (MD060), bare URLs (MD034), inline HTML (MD033), first line (MD041) | markdownlint | `.markdownlint-cli2.jsonc` gives the reason beside each |

## The first run

On 13 October 2026, before any fix, on `main` after #45:

- markdownlint, with the configuration above: 23 findings in 4 files (headings and lists with no
  blank line, two blank lines), and one bare URL in a note. All fixed.
- Vale: it could not read 2 files. Their front matter was not valid YAML: a title with a colon
  and no quotation marks (`papers/closed-source/REFERENCES.md` and `STE100.md`). Fixed. Then 8
  errors, 6 of them in notes (now left out) and 2 fixed: `a very large room` in `KEYWORDS.md`
  and `truly shared` in the charter. 40 long sentences are warnings and were left.
- lychee: 400 links, 212 of them different, 0 dead, to files and to the web.

## Live links

The workflow `live links` runs `just md-quality --online` on each pull request, after each push
to `main`, each Monday and by hand. lychee fetches every web link of the Markdown files and of
<https://h0ffmann.github.io/closed-source/>. It passes only when every link answers, so its
badge in `README.md` is green only at 100%.

**The same checks on a pull request and on `main`.** At first this workflow ran only on `main`,
so that a site that was down for an hour would not block a merge. The cost was worse: twice on
13 October 2026 a link failed on `main` after its pull request was green (a publisher that
answered 405, then a settings page that only the owner can open). So the rule is: a check that
can fail on `main` runs on the pull request first. lychee tries a link five times; if one still fails, it runs once
more after a minute and fetches only the links that failed. That takes care of the site that is
busy for a moment (GitHub answered 503 to one link of 540 while this was written), and a dead
link still fails.

It asks one host for two links at a time, half a second apart. github.com answers 500 and 503 to
a checker that asks faster: on 14 October 2026 two runs failed here that way, on links that
were alive, and one of them was on a pull request that was then merged. The pace changes how
fast the check asks. It changes no rule of what passes.

A link to a page that needs a login (a repository's settings) is written as code, not as a
link: the check cannot open it.

The same goes for a host that does not answer outside its country. planalto.gov.br, the
Brazilian government's site for its laws, did not answer GitHub's runners on 15 October 2026:
15 runs on `main` and on pull requests failed on that link, and so did a test from outside
Brazil on 18 October 2026. Its address is written as code, and the link beside it
goes to a copy of the same text that the check can open (the Câmara dos Deputados' collection).
A 408 or a 503 from Zenodo or GitHub in one run is not this case: it is a busy server, and the
retries take care of it.

A 403, a 405 and a 429 count as an answer: some sites refuse a robot and serve a person. The
first run on `main` (13 October 2026) failed on one link of 513: the DOI
[10.4337/qmjip.2016.03.06](https://doi.org/10.4337/qmjip.2016.03.06) resolved, and the
publisher's page answered 405 to lychee and 200 to a browser. So 405 was added to the list.

## The link counters

Two badges in `README.md` count where the links go: "github links" and "zenodo links".

`scripts/md-quality.sh --count` prints the numbers as JSON, with `git` and `grep` only. It counts
each different web link once, in the files that the analysers check. A GitHub link starts with
`github.com`. A Zenodo link is `zenodo.org`, or a DOI that Zenodo minted (`10.5281/zenodo.N`)
through `doi.org` or DataCite's API.

`just site-build` writes the JSON to `site/dist/links.json`, so the website publishes it at
<https://h0ffmann.github.io/closed-source/links.json>, and the badges read it from there. No
number is written into `README.md` by hand, so none can go stale: the count changes with each
deploy from `main`.

A count is not a quality. It says how much of this repository points at open code and at
permanent records, and nothing about whether a link is the right one.

## What the three do not check

They are judges of form. The note [what is MetaQuality](../../notes/202610131752-what-is-metaquality.md) says a judge must say what it does
not check:

- if a sentence is true, or if its source says what the sentence says;
- if a translation is right (`scripts/readme.sh --check` and `ste-check --translation` do part
  of that);
- Obsidian's `[[links]]` between notes (`tools/fabric notes-check` does);
- the cite line (`tools/fabric cite-check` does);
- if a link that answers still shows the page that was cited.
