---
title: Paper Fabric charter
status: draft
date: 2026-10-12
related: [readiness/2026-10-12-ready-to-promote.md, ../4-ways-of-working/paper-fabric.md]
style: direction
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Paper Fabric charter

**Bottom line:** Paper Fabric is an open pipeline that helps its authors produce high-quality,
technical, credible papers as PDFs, with agents doing the drafting and checking and people
steering. This charter is a draft for the author to accept.

## Vision

Every technical paper its authors publish is open, reproducible from its sources and citable from
the day it is released.

## Mission

Turn Markdown and checked references into versioned PDFs with persistent identifiers, and get
measurably better with every paper.

## Principles

Paper Fabric adopts the Ouroboric [charter](https://github.com/ouroboric-dev/ouroboric/blob/main/docs/1-company/charter.md)
principles. In this product they mean:

1. **Humans steer, agents build.** Authors own the thesis, the authorship and every personal
   account. Agents draft, check, build and propose.
2. **Checks, not promises.** The build fails on an unresolved citation; the reference check fails
   on an unlogged reference.
3. **Measure everything.** Each paper records its reference-check results and its readiness gaps.
4. **Safe by default.** A release mints a permanent DOI, so only the owner releases, and
   `just release` refuses a `main` that is dirty, behind, or changed only in submodule pointers.
5. **Learn in public.** The agent configuration that produced a paper ships with it.
6. **Read before you borrow.** Borrow, cite, propagate ([AGENTS.md](../../AGENTS.md)).
7. **Narrow first.** One paper, one repository, one toolchain, until the second paper shows what
   is shared.

## What makes it ouroboric

1. **It improves itself:** each paper's reference log, readiness gaps and journal entry feed the
   next paper's starting point.
2. **It documents itself** the way it documents a paper: in Markdown, versioned, checked.
3. **It never weakens its guardrails:** the citation and reference checks are never skipped to
   get a build green.

## North-star measures

- Share of references `verified` on first check (target: all).
- Pandoc warnings per build (target: zero, enforced).
- Readiness gaps open at release, paper over paper.

## Boundaries

- **Zenodo archives the source at each release tag.** The rendered PDFs are attached to the GitHub
  release.
- **Not peer review.** Paper Fabric prepares preprints; journals and reviewers judge them.
- **Not a ghost-writer.** Agents never invent an author's experience or a reference.
- **Focus.** The Ouroboric charter puts Yggdrasil and Asgard before any new factory. Paper Fabric
  is an independent experiment until the Ouroboric operators decide otherwise (see readiness).
