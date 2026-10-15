---
title: "Skills written for this repository"
status: draft
date: 2026-10-13
related: [../README.md, ../../AGENTS.md, ../../scripts/readme.sh]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Skills

The agent skills of this repository. Each one was written here, for this repository. None is a
copy of a skill from another repository: where a skill borrows an idea, its `Sources` section
names the file and the commit it was read from (AGENTS.md, "Borrow, cite, propagate").

| Skill | Use it to | Read from |
|---|---|---|
| [`readme-style`](readme-style/SKILL.md) | write `README.md` in its style: picasso's header, lower case except acronyms | h0ffmann/picasso `README.md` at `29eb385`; h0ffmann/h0ffmann `README.md` at `1a3a7e1` |
| [`easy-pt-br`](easy-pt-br/SKILL.md) | make `README.easy.pt-BR.md` from `README.md`, or an easy pt-BR version of any other document | marola-dev/marola `docs/MIPs/MIP-0091.easy.pt-BR.md` and `.claude/skills/eli5/SKILL.md` at `cf7bd4f` |
| [`citation-score`](citation-score/SKILL.md) | score how much of a phrase, a text, a dump, a file or a URL is cited, with a coloured verdict (`scripts/citation-score.sh`) | Hyland and Jiang (2019), doi:10.1093/applin/amx012; Liu, Zhang and Liang (2023), arXiv:2304.09848 |
| [`card-style`](card-style/SKILL.md) | style the site's cards, with a one-line drawing behind each | h0ffmann/picasso `site/static/drawings/` at `29eb385`; Anthropic's `frontend-design` skill (Apache-2.0) |
| [`essay-montaigne`](essay-montaigne/SKILL.md) | check that an essay keeps what Montaigne asked of an essay: eight countable rules (`scripts/essay-montaigne.sh`) and five that need a reader | Montaigne, *Essays*, Cotton's translation, Project Gutenberg eBook 3600 (public domain) |
| [`ouro-get`](ouro-get/SKILL.md) | get the full text of a work that is free to copy, as is, into `works/`, with its licence marked and indexed (`scripts/ouro-get.sh`, `works/index.md`); a citation only when it is not free | Lei 9.610/98 (planalto.gov.br); Cornell's public domain chart; the Project Gutenberg License |
| [`ouro-timeline`](ouro-timeline/SKILL.md) | draw the thinkers' lives on one timeline, one scale everywhere, empty centuries cut out (`tools/fabric timeline`, `timeline/`) | the site's tokens (`site/static/style.css`); h0ffmann/picasso `site/static/drawings/` at `29eb385`; Wikidata |
| [`print`](print/SKILL.md) | print an essay as one page, as a PDF whose text cannot be selected (`scripts/print.sh`, `PRINTING.md`) | written for this repository |

## The lock

`skills.lock` holds the sha256 of every file in this folder, after the `skills.lock` of
marola-dev/marola (`.claude/skills/skills.lock` at `cf7bd4f`) and Ouroboric's rule that skills are
vendored and pinned, never fetched live
(`docs/4-ways-of-working/ouroboric-patterns.md`, "Agents and skills"). marola's lock names an
upstream and a commit for each skill, because its skills are copies. These are not, so this lock
has no upstream: it pins the files, and the sources are in each skill.

`scripts/readme.sh --check` (in `just check`) fails when a file here does not match the lock. If
you changed a skill on purpose, run `scripts/readme.sh --lock` and commit the lock with it.

## The hooks

| Hook | Where | What it does |
|---|---|---|
| after an edit of `README.md`, and before the session ends | `.claude/settings.json` → `scripts/readme.sh --hook` | tells the agent to use `easy-pt-br` while the easy version is older than `README.md` |
| before a commit | `.githooks/pre-commit` (turn on with `just hooks`) | runs `scripts/readme.sh --check` when a README or a skill is staged |
| in CI | `just check` | the same check, for every pull request |
