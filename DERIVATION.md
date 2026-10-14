---
title: "Derivation: from notes to an essay"
status: draft
date: 2026-10-14
related: [SMART_NOTE_POLICY.md, notes/index.md, essays/index.md, .claude/skills/essay-montaigne/SKILL.md, AGENTS.md]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Derivation: from notes to an essay

A note holds one idea ([`SMART_NOTE_POLICY.md`](SMART_NOTE_POLICY.md)). An essay is several notes
tried against one question. This page is the short way from the first to the second. It was
written while the first essay was derived, [New vs. better, 2026](essays/2026-new-vs-better.md),
and the last section shows that derivation as it was done.

## The rule that makes it short

**Nothing new is written at the essay.** Every fact, every quotation and every "I" is already in
a note, with its status. The essay only chooses, orders and joins. If the essay needs something
that no note holds, stop and write the note first, or leave a marker.

That is why it is quick: the slow work (to fetch a source, to check a number, to ask the owner)
was done once, at the note.

## Seven steps

1. **One question.** Write it in one line. It comes from a `literature` note: somebody else's
   sentence that the essay will try. No question, no essay.
2. **Pull the notes.** List every note that touches the question: follow the links of the first
   one, then read `notes/index.md` by section. Five to twelve notes is the right size.
3. **Sort them into three piles.**
   - *the case*: one or two `fleeting` notes with something that happened to the writer. The
     essay opens with it.
   - *the borrowing*: the `literature` notes. They enter after the writer has spoken.
   - *the trials*: the `permanent` notes, each a position of the writer. One paragraph each.
4. **Find the gaps.** Set the brief beside the piles. A topic of the brief with no note is a gap.
   A gap of fact is closed by a fetch, and the fetch is recorded in the essay's sources. A gap of
   experience is not closed by an agent: it becomes `**[AUTHOR ANECDOTE: ...]**`.
5. **Write it once, in order:** the case, the borrowing, the trials, the doubt. First person,
   plain words, no heading inside the body, no lesson at the end. Keep each note's status: a
   note that is `unverified` enters as memory or as opinion, never as fact.
6. **Check it.** `scripts/essay-montaigne.sh <file>`, then the reader's part of the
   `essay-montaigne` skill. Fix the essay, never the check.
7. **Close the loop.** The essay ends with `## Sources`, one line for each note and each fetch.
   `essays/index.md` gets its row, and each note that was used gets a link to the essay when it
   is next edited. The status is `draft` while a marker is open; only the owner moves it on.

## What costs time, and how to not pay it

| It costs | Do this |
|---|---|
| reading every note for every essay | start from one note and follow links; read the index, not the folder |
| checking a fact twice | take the status from the note; check again only what the note marks `unverified` and the essay needs as a fact |
| an essay that grows | one question, one paragraph for each trial, and stop: an essay never treats the whole of a thing |
| writing the owner's life for him | a marker takes one line; an invented memory costs the whole essay |
| a second draft to add the sources | carry each note's id beside its paragraph while you write, and turn the ids into `## Sources` at the end |

## The first derivation, as it was done

**The question** (step 1): Pirsig's two questions, from the note
[the Chautauquas](notes/202610140004-whats-new-and-what-is-best.md). The owner's brief: an
analogy for 2026, with AI, El Niño, social media, Bitcoin and privacy.

**The notes, in their piles** (steps 2 and 3):

| Pile | Note | Status | What the essay took |
|---|---|---|---|
| the case | [the first Scala](notes/202610132352-the-first-scala-a-risk-project-at-ufrj.md) | partial | Scala learned because a tool failed |
| the case | [Marcus Baffa laughed with me](notes/202610132353-marcus-baffa-laughed-with-me.md) | unverified | the Latin classes, and "with me"; the essay does not name him |
| the borrowing | [the Chautauquas](notes/202610140004-whats-new-and-what-is-best.md) | partial | the two questions, quoted |
| the borrowing | [Pirsig, the legend](notes/202610140003-robert-pirsig-the-legend.md) | partial | who is speaking, and the year 1974 |
| trial: AI | [why I wrote fast](notes/202610132130-why-i-wrote-fast-from-preprint-to-book.md) | partial | "everybody talks about one subject" |
| trial: AI | [the port to Gleam](notes/202610132355-gleam-principles-and-the-port-to-pure-gleam.md) | partial | 8,222 lines, and "the same output" |
| trial: El Niño | [exploit in operations, explore in simulation](notes/202610122359-exploit-in-operations-explore-in-simulation.md) | open question | the rule for a forecast |
| trial: social media | [seen by the right people](notes/202610130845-seen-by-the-right-people.md) | verified | the rule of the right reader |
| trial: privacy | [not against property](notes/202610132128-not-against-property-copy-professionally.md) | open question | the book is not against what is private |
| trial: privacy | rule 8 of the policy, [`PERSONAS.md`](PERSONAS.md) | a rule | friends under an alias |

**The gaps** (step 4):

| Topic of the brief | What was missing | How it was closed |
|---|---|---|
| El Niño | the state of El Niño in 2026 | fetched: NOAA's ENSO Diagnostic Discussion of 8 October 2026 |
| Bitcoin | everything: no note speaks of it | one fetched sentence of its paper, and a marker for the owner's position |
| social media | the owner's own case | a marker |

**The check** (step 6): the script's eight rules hold, with a note that two markers are open. So
the essay is a draft, and it says so in its first lines.

**What the derivation showed.** Eight of the ten sources were already notes. The two fetches and
the two markers are exactly the topics that no note covered: the gaps of the essay are the gaps
of the slip box. The next note to write is the owner's on Bitcoin.

## The second derivation: a short essay for one page

[Peer reviewing: the god that failed](essays/2026-peer-reviewing-the-god-that-failed.md), 14
October 2026. The log of it, step by step:

| Step | What was done |
|---|---|
| 1. the question | the owner's sentence: peer review has failed, and it is a ritual ([the note](notes/202610140034-peer-reviewing-the-god-that-failed.md)) |
| 2, 3. the notes | the case: [why I wrote fast](notes/202610132130-why-i-wrote-fast-from-preprint-to-book.md) (a book with no review). The trial: [what is MetaQuality](notes/202610131752-what-is-metaquality.md) (a check that nobody can open) |
| 4. the gaps, closed by a fetch | the history of peer review (one encyclopedia page); the journal business (one article of *The Guardian*); Kubrick's last film (one encyclopedia page). All three are quoted in the note first |
| 4. the gaps, left open | the links that the owner asked for from this business to Jeffrey Epstein and from him to named people, services and crimes. No source was fetched, so none is in the note and none is in the essay |
| 5. written | 309 words. Three sentences of the first draft were removed because no note and no fetched source held them: two details of the film, and "I have never been a referee" |
| 5. where the record changed the essay | the owner's sentence was "it started in the wrong way, by the wrong person". The record names a first referee in 1665 and a businessman in the 1950s. The essay says both, in the first person, and says that it cannot join them |
| 6. checked | `scripts/essay-montaigne.sh`: the eight countable rules hold, no open marker |
| 7. printed | `just print`: one A5 page, no text that can be selected ([`PRINTING.md`](PRINTING.md)) |

**What the second derivation showed.** A short essay has room for one case, one borrowing, one
image and one doubt. A fifth thing does not fit the page, and the page is the check.

## Sources

- The slip box and the three kinds of note: [`SMART_NOTE_POLICY.md`](SMART_NOTE_POLICY.md), after
  Luhmann as Ahrens describes him.
- The order "the writer first, the borrowing after": Montaigne, *Essays*, II, "Of Books", in the
  `essay-montaigne` skill.
- The marker: `AGENTS.md`, invariant 3.
