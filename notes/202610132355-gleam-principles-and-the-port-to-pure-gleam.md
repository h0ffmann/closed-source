---
id: "202610132355"
title: "Gleam's principles, and why the tools here became pure Gleam"
type: literature
status: partial
source: "gleam.run, read 2026-10-13; pull request h0ffmann/closed-source#27 and its change proposal; Matheus Hoffmann, message, 2026-10-13"
tags: [gleam, erlang, tooling, claude-code, gleam-engineering]
created: 2026-10-13
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Gleam's principles, and why the tools here became pure Gleam

**What Gleam says of itself (verified, <https://gleam.run>, read on 13 October 2026).** "Gleam is
a friendly language for building type-safe systems that scale!" Its front page gives these
points:

- **Types, and no surprises.** "No null values, no exceptions, clear error messages, and a
  practical type system."
- **The Erlang runtime.** It runs on the Erlang virtual machine, with "multi-core actor based
  concurrency" and "fast immutable data structures".
- **One tool.** "Gleam comes with compiler, build tool, formatter, editor integrations, and
  package manager all built in".
- **Many languages.** It uses packages "written in Gleam, Erlang, or Elixir", and it "can
  additionally compile to JavaScript".

**What was done here (verified, read from GitHub).** Pull request
[#27](https://github.com/h0ffmann/closed-source/pull/27), "feat(tools): port the Python tooling
to Gleam on the Erlang target", was merged on 13 October 2026. It added 8,222 lines and removed
1,647 in 71 files: 6,575 lines more than before. Eleven Python scripts of 1,570 lines became one
Gleam project, `tools/`. The website was already Gleam, so after it the checks, the generators
and the site are one language.

**Why (verified, the [change
proposal](../docs/2-engineering/changes/2026-10-13-port-python-tooling/proposal.md)).** I asked
for options in Go and V first. "Gleam for everything, on the Erlang target" was chosen on 13
October 2026. The description of the pull request gives what it cost in dependencies: three Hex
packages, and the rest from Erlang's own libraries.

**What I say of it (my words, unverified as a claim).** "This is what I call a good usage of
Claude Code. Writing Gleam." My second brain stands on Erlang, through Gleam. More Gleam
engineering will be added to these notes.

**Status: partial.** Gleam's page and the pull request are verified. That this is a *good* use
of a coding agent is my judgement, with no measure behind it yet: the pull request's own proof
is that each port gave the same output as the script it replaced.

The person who loved Erlang before I did: [[202610132353-marcus-baffa-laughed-with-me]]. The
language before this one: [[202610132352-the-first-scala-a-risk-project-at-ufrj]].
