---
title: Ready to promote to ouroboric-dev — assessment 2026-10-12
status: draft
date: 2026-10-12
related: [../charter.md, "https://github.com/ouroboric-dev/asgard/blob/main/templates/readiness/checklist.md", "https://github.com/ouroboric-dev/ouroboric/blob/main/docs/1-company/readiness/2026-10-11-ready-to-build.md"]
style: direction
---

# Ready to promote to ouroboric-dev — assessment 2026-10-12

**Bottom line: not ready to move into the `ouroboric-dev` organisation.** The build, checks and
release tooling work. What blocks the move is mostly human: an Ouroboric decision on scope, the
three authors' agreement on ownership and text, and four unfilled personal accounts. Each issue
below names who closes it.

Scope: this repository (Paper Fabric v0 and the paper *Closed Source: The God that Failed*).
Checklist: Asgard's [readiness checklist](https://github.com/ouroboric-dev/asgard/blob/main/templates/readiness/checklist.md),
the items that apply to a paper repository, plus issues specific to the move.

## Blocking issues

| # | Issue | Area | Checklist | Closed by |
|---|---|---|---|---|
| B1 | **Scope decision.** The Ouroboric charter puts "Yggdrasil and Asgard before any new factory" and names a research factory only as an illustration. Moving Paper Fabric into the organisation needs the operators to accept it as a product, or as an experiment outside the portfolio. | direction | RB-02 | Ouroboric operators |
| B2 | **Ownership and licence.** Organisation repositories hold copyright under one name and will require a contributor licence agreement. All three authors must agree to the transfer, the CC BY 4.0 / AGPL-3.0 / MIT split and the copyright lines in `REUSE.toml`. | legal | RB-08, RB-09, RB-10 | the three authors |
| B3 | **Personal accounts missing.** Four `[AUTHOR ANECDOTE]` placeholders in sections 3 and 8 must be written by Matheus Hoffmann. | content | RP-03 | Matheus Hoffmann |
| B4 | **Authors have not approved the text.** Rob Kler Soares da Silva Junior and Bruno Valério are named authors; their CRediT roles are unconfirmed and they have not reviewed the draft. | direction | RB-02 | the three authors |
| B5 | **Docket not read.** The Apple v. OpenAI case number (5:26-cv-07078, N.D. Cal.) comes from a secondary source with two conflicting judge suffixes. Check PACER and cite the complaint itself. | record | RP-04 | any author |
| B6 | **Naming.** Ouroboric names its products and modules from Norse myth and reserves them as trademarks. "Paper Fabric" does not follow the naming record, and the repository name `closed-source` is the paper's, not the product's. Decide the product name and split the repository: one for the factory, one per paper or a papers umbrella. | brand | RB-06, RB-07 | Ouroboric operators |
| B7 | **Publishing hardening not done.** The organisation's first-publish checklist: secret and private-data scan of the full history, branch protection on `main`, secret scanning with push protection, issues off and Discussions on, the Zenodo GitHub integration confirmed off, `ZENODO_TOKEN` stored as a secret. | security | RB-14, RP-04 | repository admin |
| B8 | **arXiv will hold a position paper until it is peer reviewed.** Since 31 October 2025, arXiv CS accepts review and position papers only with documented peer review ([arXiv blog](https://blog.arxiv.org/?p=1740)). The arXiv tooling is ready (`make arxiv`), but submission waits for an accepted venue. The first submitter in `cs.CY` also needs an endorsement. | publishing | RP-03 | the three authors |

## Non-blocking issues

| # | Issue | Area | Closed by |
|---|---|---|---|
| N1 | Docs check missing: front-matter and link checks and Vale with the `research` style are not wired into CI. | process | agent |
| N2 | Docs layout is a partial product umbrella: no `2-engineering/` (spec of the build) or `3-using/` yet. | process | agent |
| N3 | One `.zenodo.json` per repository, but Paper Fabric is meant for many papers. Move citation metadata to `papers/<slug>/` and loop the release over papers. | build | agent |
| N4 | Reference gaps: Samuelson and Scotchmer's DOI not checked; picasso's Zenodo record not fetched (rate-limited); Ghidra's 2019 release year not re-fetched; no entry for the 1949 anthology the title alludes to; Wikipedia used for Linux and Git dates (primary sources preferred). | record | agent |
| N5 | Not peer reviewed. Choose a venue or an open-review route before v1. | direction | the three authors |
| N6 | Skills are not vendored: the exported `.claude/` lists the skills and tools used, but Ouroboric requires a `skills.lock` with pinned, licensed copies. | supply chain | agent |
| N7 | The organisation pull-request template expects an issue, a plan task id and a named proof test; this repository has no issue tracker or plan yet. | process | agent |
| N8 | CI has not run yet: the first pull request is the first run of `pdf`, `citation` and `release` is untested until a tag. The arXiv bundle was compiled with this container's TeX Live, not arXiv's own. | build | agent |
| N9 | `pandoc-crossref` 0.3.16.0 is built for pandoc 3.1.2 and warns on 3.1.3. Pin both to a matching pair, or move to a Nix shell from picasso's publisher lab. | build | agent |

## Met

| Item | Evidence |
|---|---|
| Licence chosen for everything public (RB-08, partial until B2) | [`REUSE.toml`](../../../REUSE.toml), [`LICENSES/`](../../../LICENSES/) |
| Principles turned into `AGENTS.md` invariants (RB-05) | [`AGENTS.md`](../../../AGENTS.md) |
| Charter drafted (RB-02, partial until B1 and B4) | [charter](../charter.md) |
| Journal started (RB-17) | [journal](../../6-journal/README.md) |
| Research behind key claims recorded (RB-16) | [reference log](../../../papers/closed-source/REFERENCES.md) |
| Release path that archives only the PDF | [releasing](../../4-ways-of-working/releasing.md) |
