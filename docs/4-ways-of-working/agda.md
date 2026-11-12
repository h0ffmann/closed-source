---
title: "Mathematics and types follow Agda"
status: draft
date: 2026-11-12
related: [AGENTS.md, ../../agda/, ../../scripts/agda-check.sh, ../../.github/workflows/agda.yml, ste100.md, ../../notes/202611120009-agda-over-lean-types-are-signals.md, ../../BOOKS.md]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Mathematics and types follow Agda

The owner, 12 November 2026: "Implement ASD-STE100 using Vale CI and also using Agda", and "Any
topic related to Math or types must follow agda implementation". So a claim of mathematics or of
types, in the paper, a note or a doc, has a module in `agda/` that states it as a type and proves
it. The table below lists each claim and its module. The reason for Agda and not Lean is in
[the note "Agda over Lean: types are signals"](../../notes/202611120009-agda-over-lean-types-are-signals.md);
the book to learn it from is Sandy Maguire's *Certainty by Construction* (`BOOKS.md`).

```sh
just agda   # the agda workflow of CI: every module under --safe, the self-test, Vale and Agda agree
```

## The rules of the check

1. **Every module checks under `--safe`** (`agda/closed-source.agda-lib`). `--safe` refuses a
   `postulate`, so no module assumes what it should prove. `agda/SelfTest/Postulate.agda` is a
   file with one postulate, and the check fails if Agda accepts it.
2. **Every module is in `agda/Everything.agda`.** The check fails for a module that is not there,
   because a module that nothing imports is never checked.
3. **Vale and Agda agree.** Vale's style `ste` ([ste100.md](ste100.md)) and the module
   `ClosedSource.STE.Rules` must use the same limits (25 words, six sentences), and
   `PhrasalVerbs.yml` must hold the same table as `ClosedSource.STE.PhrasalVerbs`. A change to one
   without the other fails the check.
4. **A model, said as a model.** A module proves a theorem about a model of the claim, not about
   the world. Each module says in its first lines which part of the claim it proves, and which part
   it does not.

## Two readings of "ASD-STE100 using Agda"

Vale reads the prose. Agda cannot read the prose, so here it does the other half: it states the
rules that Vale checks as types, and proves the properties that make the check sound.

| Module | Claim | What the proof says |
|---|---|---|
| `ClosedSource.STE.Rules` | ASD-STE100: 20 words in a procedure, 25 in a description; six sentences in a paragraph | `Short` and `WellFormed` are types, and both can be decided (`short?`, `wellFormed?`). A short procedure is also a short description. Each paragraph can be split into paragraphs of six sentences or fewer, and no sentence is lost (`split`). |
| `ClosedSource.STE.PhrasalVerbs` | the table of `PhrasalVerbs.yml` | No replacement is a phrase that the table replaces, so one pass reaches a fixed point. No phrase is swapped for itself. |
| `ClosedSource.STE.Preservation` | `tools/fabric ste-check`: an STE pass keeps the facts, as a multiset | Two passes that keep the facts keep them together (`keeps-∘`). A split keeps the facts. Facts are counted, not placed. |

## The claims of the paper and of this repository

| Claim | Where | Module | What the proof says, and what it does not |
|---|---|---|---|
| 66 pages: 33 authors, two pages each, in both editions | AGENTS.md, "The book" | `ClosedSource.Book` | The arithmetic of the rule and of the two rules that it replaced. `just check` counts the roster. |
| "The mapping is a bijection ... Whoever has it ... undoes the transformation" | paper, Section 8 (nashkell) | `ClosedSource.Obfuscation` | With the dictionary, smudge after clean gives back the program (`undo`). |
| "Structure survives. Only top-level names change." | paper, Section 8 (nashkell) | `ClosedSource.Obfuscation` | Renamed and original programs have the same shape (`structure-survives`). |
| "the mean key computation length increases exponentially with the length of the key" | paper, Section 8 (Nash) | `ClosedSource.KeySearch` | A search over keys of n bits is complete and has 2^n keys. One more bit doubles it. That no attack is better than search is Nash's conjecture, and the module does not prove it. |
| A SWHID names code by its hash; the first SHA-1 collision | paper, Section 8 | `ClosedSource.Hash` | Same content gives the same identifier, and different identifiers prove different content. The converse is false: with more contents than digests, a collision exists (pigeonhole). |

## Claims with no module yet

Read on 12 November 2026, with a search for words of mathematics and types in the Markdown files
that this repository writes:

| Claim | Where | Why no module |
|---|---|---|
| "I do not claim to have computed an equilibrium" | paper, Section 8 | The paper says that it makes no formal claim. A module would add one. |
| the bandit's trade of exploration against exploitation | the two notes on the Marola forecaster | The notes describe a system of another repository. They state no theorem. |
| Gleam's "no null values, no exceptions" | the note on Gleam's principles | A claim about Gleam, which Gleam's own type checker checks. |

A new claim of mathematics or types gets its module in the pull request that adds the claim, and
a row in this file.
