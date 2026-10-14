---
title: "ai-memory as the long-term memory: tasks"
status: draft
date: 2026-10-14
related: [proposal.md, delta.md]
style: procedure
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Tasks

1. This pull request: `MEMORY.md`, `AGENTS.md` and this proposal, as in [delta.md](delta.md).
2. The owner: add the marketplace and the plugin to `.claude/settings.json`, with the lines in
   [delta.md](delta.md), in this pull request or the next one. The agent was not allowed to
   enable a third-party plugin whose hooks run outside the sandbox.
3. The owner, on the owner's machine: install the binary and the service, with the commands in
   `MEMORY.md`. Then restart Claude Code in this repository and run `/ai-memory:status`.
4. The owner: keep the three opt-in paths off, or decide which one to turn on
   (`DATA_HANDLING.md` of ai-memory). Decide whether `[capture] ignore_paths` keeps any path out.
5. The owner: notes about Akita (the owner's words: "notes about akita later").
6. After a month of use: a note on what the memory gave and what it missed, and whether
   `MEMORY.md` should change again.
