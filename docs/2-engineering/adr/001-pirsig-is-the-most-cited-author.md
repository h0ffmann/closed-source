---
title: "ADR 001: Robert M. Pirsig is the most cited author of the book"
status: accepted
date: 2026-10-14
related: [../../../BIO_ROBERT_PIRSIG.md, ../../../BOOKS.md, ../../../QUOTES.md, ../../../50THINKERS.md, ../../../DERIVATION.md]
style: research
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# ADR 001: Robert M. Pirsig is the most cited author of the book

The first architecture decision record of this repository. A change to a tool or a rule is still
a change proposal (`docs/2-engineering/changes/`); an ADR records a decision about the book
itself that later work must follow.

## Context

*Zen and the Art of Motorcycle Maintenance* is the first book of [`BOOKS.md`](../../../BOOKS.md),
and Pirsig is thinker 30 of [`50THINKERS.md`](../../../50THINKERS.md). The word "Quality" already
names what the checks of this repository are for. On 14 October 2026 the owner wrote that Pirsig
"will be the more cited author in this book (ADR 001)", and asked for his biography, a note, and
an essay on his two questions.

## Decision

Robert M. Pirsig is the author that *Closed Source: The God that Failed* cites most.

## What follows

1. **A quotation of Pirsig is exact and checked.** It goes into [`QUOTES.md`](../../../QUOTES.md)
   with its source and the status of the check, before a page or an essay uses it.
2. **His life is in one place**, [`BIO_ROBERT_PIRSIG.md`](../../../BIO_ROBERT_PIRSIG.md). A page
   of the book takes a fact of his life from there, with the source named there.
3. **When the paper cites him**, his book enters `papers/closed-source/refs.bib` and
   `REFERENCES.md`, as AGENTS.md says. Today it does not: `BOOKS.md` says the paper does not cite
   the books behind it.
4. **Most cited is a count, so it can be checked.** When the 100 pages exist, a count of the
   citations of each author must put Pirsig first. No check does this yet.
5. It does not change the roster. The 50 thinkers and their two pages each stay as they are.

## Status of the claim today

Not yet true as a count: on 14 October 2026 the paper cites Pirsig zero times. This record is a
decision about what the book will be, not a measure of what it is.
