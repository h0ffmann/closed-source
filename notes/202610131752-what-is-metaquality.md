---
id: "202610131752"
title: "What is MetaQuality"
type: permanent
status: open-question
source: "Matheus Hoffmann, Claude Code session, 2026-10-13: the word and the question are his; the reading below is a draft by Claude"
tags: [quality, pirsig, checks, essay]
created: 2026-10-13
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# What is MetaQuality

An essay for the book, in draft. The word is the owner's. He asked for a tool "to increase quality? Pirsig
quality" in the Markdown files, and then for this essay. He has not yet said what the word means, so this note gives one
reading and marks it as a proposal.

## The reading

Pirsig asks what Quality is ([`BOOKS.md`](../BOOKS.md), *Zen and the Art of Motorcycle
Maintenance*, 1974). This repository's answer for a paper is care that can be run: the reference
check, the STE check, the pinned toolchain. `BOOKS.md` calls that care "Pirsig's Quality, applied
to a paper".

**MetaQuality is the next question: how good is the thing that judges quality?**

A check says "this paper is good". MetaQuality asks whether the check is good. A check that never
fails says nothing. A check that fails for the wrong reason teaches the writer to ignore it. A
check that nobody can read is closed source in a small size: you must trust it, and you cannot
open it.

So a judge of quality has MetaQuality when four things are true:

1. **It can fail.** Somebody gave it a bad input and saw it refuse.
2. **It is open.** A reader can read the rule and the code that applies it.
3. **It says what it does not check.** A score for citation is not a score for truth.
4. **It is applied to itself.** The tool that scores other people's text scores its own.

## Where this repository already does it

Each line is a file in this repository, read on 13 October 2026.

- `just self-test` runs the checkers' own tests. One example: the citation tool gets a bad record
  and must name each fault in it (`tools/test/citation_test.gleam`).
- `scripts/readme.sh --check` fails when the easy version was not made from this exact
  `README.md`. The script says that it cannot tell if a translation is right
  (`.claude/skills/easy-pt-br/SKILL.md`, "Why there is a stamp").
- [`CITATION_SCORES.md`](../CITATION_SCORES.md) scores this repository's own README with the
  same tool that scores four others.
- [`RELATED_WORK.md`](../RELATED_WORK.md) says "Read this table honestly": every record that
  cites these works is the writer's own, or one he shares with his co-authors.
- A hard rule in `AGENTS.md` says never to weaken a guardrail. That rule protects the checks, not
  the paper.

## Why it belongs in this book

The paper's argument is that secrecy asks for trust and openness lets a reader check. MetaQuality
is that argument turned on the checker. It is also the answer to the reach that
[[202610130845-seen-by-the-right-people]] describes: the right reader does not count stars, they
open the engine. And it is the plain kind of care that [[202610130121-what-makes-the-work-japanese]]
is about.

## What is not verified

- The word "MetaQuality" is not Pirsig's as far as this repository knows. No source was fetched
  for it. Nothing here says that Pirsig or any other writer used it.
- The only claim about Pirsig is the one `BOOKS.md` already makes.
- The four conditions are a proposal. They were not taken from a source.

**Open, for the owner:** is this what you mean by MetaQuality? If not, write the definition in
your words and this note changes to it. Which thinker of the 50 does the essay belong to: Pirsig
(row 14), or a page of its own?
