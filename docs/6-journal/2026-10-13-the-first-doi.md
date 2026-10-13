---
date: 2026-10-13
tags: [release, zenodo, rules]
status: open
post-candidate: no
evidence: [../2-engineering/changes/2026-10-13-zenodo-webhook-release/proposal.md, ../4-ways-of-working/releasing.md]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
## Challenge
The first release, v0.1.0, got a DOI that the repository's rules said it could not get.

## Context
The rules said that Zenodo's GitHub webhook stays off, that CI uploads only the PDFs to a Zenodo
draft, and that a person publishes it. The webhook had been switched on for this repository three
hours before the release, and `ZENODO_TOKEN` was not set. The workflow printed "skipping the
Zenodo draft"; Zenodo archived the release through the webhook a few seconds later. An agent
read the workflow log, not the repository's hooks, and reported that no DOI existed.

## Options
- Switch the webhook off and keep the draft policy. The minted DOI stays; it cannot be deleted.
- Keep the webhook and change the rules to marola's pattern, which the owner asked for.

## Decision
Proposed: marola's pattern, by the change proposal 2026-10-13-zenodo-webhook-release. The owner
decides by merging it.

## Result
Version DOI 10.5281/zenodo.23333657 under concept DOI 10.5281/zenodo.23333656. The record holds
the source archive. Its description still says it holds only the PDF, until the owner corrects it
on zenodo.org.

## Lessons
- A rule that lives only in a comment does not hold a switch that lives on another website. Check
  the state, here `gh api repos/<owner>/<repo>/hooks`, not only the files.
- A skipped step in a log is not proof that nothing happened.
- Read the repository's AGENTS.md and MEMORY.md before the first command in it.
