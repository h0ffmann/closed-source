---
title: "Port the Python tooling to Gleam: tasks"
status: accepted
date: 2026-10-13
related: [proposal.md]
style: procedure
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Tasks

1. Add Gleam and Erlang/OTP to this repository's default devShell (`flake.nix`).
2. Create `tools/`, a Gleam project on the Erlang target, with one subcommand per Python script.
   Each subcommand keeps the script's arguments, output and exit code.
3. Port each script's `--self-test` to `gleeunit` tests (`gleam test` in `tools/`).
4. Compare the Gleam output with the Python output on this repository: messages, exit codes, and
   the files they write (`CITATION.cff`, `content.gleam`, the arXiv bundle and form text).
5. Point the justfile and the workflows at `tools/`, then delete the Python files.
6. Update README, AGENTS.md and the docs that name the Python scripts.
