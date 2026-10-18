---
title: "The compound loop's plans and learnings"
status: draft
date: 2026-10-18
related: [../../AGENTS.md, ../../.compound-engineering/config.yaml]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# The compound loop's plans and learnings

Compound Engineering's skills write here (`docs_root: docs/compound` in
[`.compound-engineering/config.yaml`](../../.compound-engineering/config.yaml); the rules are in
[`AGENTS.md`, "Engineering work: the compound loop"](../../AGENTS.md#engineering-work-the-compound-loop)).
The pattern is ww3-gpu's
([`docs/compound/README.md` at 60189b0](https://github.com/h0ffmann/ww3-gpu/blob/60189b0/docs/compound/README.md)).

- `plans/`: one plan per medium or large change, written by `/ce-plan` (and `/ce-brainstorm` for
  a large one). A plan names the file, the check or the rule it changes, and how `just check`
  will show that it works.
- `solutions/`: one learning per lesson that is not obvious from the diff and will hold, written
  by `/ce-compound`, read by the next `/ce-plan`.

Both follow the rules of every page here: a cite line, front matter, and a source for each fact.
A lesson about the book itself (a thinker, a quotation) is a note in `notes/`, not a learning.
