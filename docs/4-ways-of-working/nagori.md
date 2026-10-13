---
title: NAGORI.md is written by hand
status: accepted
date: 2026-10-13
related: [../../NAGORI.md, ../../AGENTS.md]
style: procedure
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# NAGORI.md is written by hand

`NAGORI.md` holds the partial snapshot of the private `h0ffmann/nagori` that the book carries
after its 100 pages. Only the owner writes it, by hand (Hoffmann, 13 October 2026). This is a hard
rule in `AGENTS.md`.

## For agents

1. Read `NAGORI.md` when a task needs it. Do not write to it.
2. Do not run a formatter, generator, script or bulk replace that touches it. Exclude it by path.
3. If a check fails on `NAGORI.md`, do not fix the file. Report the failure and the change you
   would make, and wait for the owner.
4. Do not copy text from nagori into any other file of this repository.

## For automation

No CI job, workflow, bot or scheduled task writes `NAGORI.md`. A job may read it, for example to
build the book.

## For the owner

1. Choose the part of nagori and the commit.
2. Write the part into `NAGORI.md` with its commit, and update the `last=` author on the cite line
   if you want it to name you.
3. Commit it under your own name, without an agent's trailers.
