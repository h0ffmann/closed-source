---
title: Ouroboric patterns used in Paper Fabric
status: draft
date: 2026-10-12
related: [paper-fabric.md, ../1-product/charter.md]
style: guide
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Ouroboric patterns used in Paper Fabric

The project chat that started this repository asked to record the `ouroboric-dev` patterns in
project memory. Project memory was off, so they are recorded here instead, where every agent and
person reads them. Source: the [ouroboric](https://github.com/ouroboric-dev/ouroboric),
[asgard](https://github.com/ouroboric-dev/asgard) and [.github](https://github.com/ouroboric-dev/.github)
repositories, read on 2026-10-12.

## Direction

- **Charter shape:** vision, mission, what "ouroboric" means, principles, values, portfolio,
  north-star measures, boundaries. Product charters must conform to the company charter.
- **Ouroboric means three things:** the product improves itself through its own loop, documents
  itself as it documents its output, and never weakens its own guardrails.
- **Seven principles:** humans steer, agents build; checks, not promises; measure everything;
  safe by default; learn in public; read before you borrow; narrow first.
- **Focus boundary:** Yggdrasil and Asgard before any new factory. A research factory "for
  scientific research and papers" is named only as an illustration, not a commitment.

## Documentation standard

- **Numbered umbrella layout:** `1-company` or `1-product`, `2-engineering`, `3-using`
  (Diátaxis), `4-ways-of-working`, `5-research`, `6-journal`, `7-branding`, `assets/diagrams`.
  Leaves have `README.md`, `AGENTS.md` (about 100 lines, a map, not a manual) and
  `docs/architecture.md`.
- **Front matter on every doc:** `title`, `status` (draft, accepted, implemented, superseded),
  `date`, `related`, optional `style`.
- **Dated file names** for decisions and records (`YYYY-MM-DD-<slug>.md`); undated for living
  docs. Decisions inside docs: `**Decided YYYY-MM-DD:** ...`.
- **Writing styles:** fourteen style ids. Papers here use `research` (every claim cited, facts
  separate from `[ANALYSIS]`, unverified items marked); `AGENTS.md` uses `agent-facing`.
- **Docs are checked like code:** front matter, naming, links, Vale prose rules.
- **Diagrams as code** (Mermaid, D2) with light and dark renders.
- **Renderer-agnostic Markdown.** Zensical for sites.

## Journal

- One entry per challenge: Challenge, Context, Options, Decision, Result, Lessons; front matter
  `date`, `tags`, `status`, `post-candidate`, `evidence`.
- Scrubbing rules for public repos: no secrets, private names, client data or raw transcripts.

## Readiness

- Asgard's checklist has three levels: ready to build (RB), ready to launch (RL), ready to promote
  (RP). Each item is met, partial, missing or n/a, with evidence. Assessments live in
  `readiness/YYYY-MM-DD-<level>.md`.

## Licensing and publishing

- AGPL-3.0 for factory code, MIT for anything copied into what operators build, CC BY 4.0 for
  docs; names and logos reserved (`TRADEMARKS.md`). REUSE.toml records per-path licences.
- Contributions will require a contributor licence agreement.
- Before going public: secret and private-data scans over the full history, professional author
  email, branch protection, secret scanning with push protection, issues off and Discussions on.

## Agents and skills

- Skills are **vendored** with a `skills.lock` (upstream, commit, licence, per-file hash), never
  fetched live or synced from an employer's plugin system.
- The organisation pull request template asks for the task (issue and plan id), proof (a named
  test that fails before and passes after) and a checklist (spec delta, docs check, secret scan,
  journal entry).
