---
title: "Change proposals"
date: 2026-10-13
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Change proposals

A change to something that already exists and that the owner decides (a hard rule in AGENTS.md,
the 50 thinkers, the 100-page structure, the book's sections) gets one folder,
`YYYY-MM-DD-<slug>/`, holding:

- `proposal.md`: why, and what changes;
- `delta.md`: the rules or text added, modified and removed;
- `tasks.md`: the steps, one pull request each where it can be.

The owner's answer goes at the top of `proposal.md` as `**Decided YYYY-MM-DD:** ...`. A change
proposal can start as a GitHub issue (the *Change proposal* template) and become a folder when the
work begins. A decided proposal moves to `archive/` once its delta is in the files it changes.

Adapted from Yggdrasil's
[change proposals](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/2-engineering/changes/README.md)
(CC BY 4.0), which follows Ouroboric's spec-driven development
(`docs/4-ways-of-working/ouroboric/spec-driven-development.md`).

## Open

- [2026-10-13-port-python-tooling](2026-10-13-port-python-tooling/proposal.md): port the Python tooling to Go and V.
- [2026-10-13-zenodo-webhook-release](2026-10-13-zenodo-webhook-release/proposal.md): release with Zenodo's webhook, as marola does.
- [2026-10-14-ai-memory-long-term-memory](2026-10-14-ai-memory-long-term-memory/proposal.md): ai-memory as the long-term memory of this repository.
