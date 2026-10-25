---
title: "Skip the live link check on one pull request, by label"
status: accepted
date: 2026-10-25
related: [../README.md, ../../../../.github/workflows/links.yml, ../../../4-ways-of-working/md-quality.md, ../../../../ISSUE_LABELS.md]
style: procedure
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Skip the live link check on one pull request, by label

**Decided 2026-10-25:** the owner asked to "disable live checks in this PR", for pull request 72.

## Why

AGENTS.md, invariant 9: a CI job is a guardrail, and a change to it is a change proposal that the
owner approves. The owner asked for this one.

On pull request 72 the only red check was `live links`. It failed on links to
`h0ffmann/ww3-gpu`, a private repository that answers 404 to the check, in files the pull request
does not touch. The same workflow was red on `main` at `9e8bf40`.

## What changes

- `.github/workflows/links.yml`: the job `alive` does not run on a pull request that carries the
  label `ci/skip-live-links`. The workflow also runs when a label is added or removed, so the
  label takes effect at once.
- `ISSUE_LABELS.md`: the label, in a new `ci` group.
- `docs/4-ways-of-working/md-quality.md`: when the label is used, and what it does not skip.

## What does not change

- A push to `main`, the Monday run and a run by hand check every web link, with no exception.
- The `.md` workflow (markdownlint, Vale, lychee on local links) runs on every pull request.
- The dead links to `h0ffmann/ww3-gpu` stay dead. Fixing them is a separate choice: make the
  repository public, or exclude its URLs in `scripts/md-quality.sh`.
