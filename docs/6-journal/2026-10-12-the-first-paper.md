---
date: 2026-10-12
tags: [references, agents, zenodo, tooling]
status: open
post-candidate: yes
evidence: [../../papers/closed-source/REFERENCES.md, ../1-product/readiness/2026-10-12-ready-to-promote.md]
---
## Challenge
Set up Paper Fabric and produce its first paper in one pull request, drafted by an agent, with
references a reviewer can trust and a v0 release that puts only the PDF on Zenodo.

## Context
The paper covers 2026 events that are recent, contested and partly in litigation. The authors'
earlier projects (WW3 GPU Lab, picasso, marola) already had citation tooling, but it archived
source through Zenodo's GitHub integration.

## Options
- References: draft from memory and check later, or fetch every source before citing it.
- Zenodo: the GitHub integration (archives source), or the deposit API with only the PDF.
- Toolchain: picasso's publisher lab (Nix), or Sandy Maguire's Makefile and pandoc layout.

## Decision
Fetch before citing, with a reference log and a CI check that every BibTeX key has a logged
check. Use the deposit API, creating drafts only. Mirror Sandy Maguire's layout, as the authors
asked, with pinned pandoc and pandoc-crossref.

## Result
41 references logged after the follow-ups: 34 verified, 7 partial, none unverified. Fetching caught one wrong DOI
recalled from memory (Raymond 1998) and one unsupported claim (that a 2024 attack paper reported
its responsible disclosure), both removed before the build. The build produces a 12-page PDF with
no pandoc warnings. Pending: CI's first run, the authors' review and the first Zenodo draft.

## Lessons
- Recall is not a source. An agent's memory of a DOI was close and wrong.
- Rate limits shape verification: Crossref and Zenodo throttled the checks, so the log must say
  which detail came from which page.
- An agent can draft a confession but must not write one. The personal account stays a
  placeholder until its author fills it.
