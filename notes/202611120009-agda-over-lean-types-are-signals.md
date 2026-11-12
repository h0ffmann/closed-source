---
id: "202611120009"
title: "Agda over Lean: types are signals"
type: permanent
status: open-question
source: "Matheus Hoffmann, message, 2026-11-12; Agda and Lean documentation, Wadler's PLFA paper and Maguire's book page, read 2026-11-12"
tags: [agda, lean, types, proof]
created: 2026-11-12
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Agda over Lean: types are signals

**The claim (my words).** A type is a signal. It tells the reader, and the machine, what a
program promises before anyone runs it. So a proof language is good when the signal stays on the
page: you read the type, you read the term, and nothing hidden changes what they say. On that
measure I choose Agda over Lean.

**Why Agda keeps the signal (verified, sources below).**

- **The type is the statement.** "Agda is a dependently typed programming language", and
  "thanks to the Curry-Howard correspondence, one can express a logical specification using
  dependent types" (Agda docs, *What is Agda?*). Maguire's book has a section with the same
  idea in its title: "Statements are Types; Programs are Proofs" (*Certainty by Construction*,
  table of contents, Leanpub).
- **The proof is on the page.** Wadler moved his course from Coq to Agda because "proofs in Coq
  require an interactive environment to be understood, while proofs in Agda can be read on the
  page", and "in Agda, there is no longer any need to learn about tactics" (Wadler, *Programming
  Language Foundations in Agda*, SBMF 2018 paper). Lean also proves with tactics, so I read the
  same point as true of Lean. **[ANALYSIS]**: that last step is my reading; Wadler wrote about
  Coq, not Lean.
- **No assumption is silent.** In Agda an axiom is a `postulate` that you write. `--safe` refuses
  it, because a postulate "can be used to assume any axiom" (Agda docs, *Safe Agda*).

**What Lean puts in the signal (verified).** Lean's reference says three axioms, `propext`,
`Classical.choice` and `Quot.sound`, "are important parts of how mathematics is done in Lean".
"Axioms do not reduce to other terms", so they can make terms "get stuck", and code that relies on
them "must be marked `noncomputable` and can't be compiled" (Lean reference, *Axioms*, 4.27.0).
That is a choice for classical mathematics, and a fair one. But it means a Lean type can promise
a value that no run will give.

**[ANALYSIS] The signal, in one line.** In Agda, if a term checks under `--safe`, it computes and
you can read why. In Lean, the type checks, and the reader must also ask which axioms are under
it.

**Status: open-question.** The quotations are verified. That a signal you can read on the page is
worth more than Lean's larger use in mathematics is my judgement; I did not measure the size of
either community, and this note does not claim it. The note waits for the owner's approval.

**[AUTHOR ANECDOTE: where I first met Agda, and what made me prefer it]**

The same idea in a language I already use: Gleam's "no null values, no exceptions"
([[202610132355-gleam-principles-and-the-port-to-pure-gleam]]). The book to learn Agda from is
in `BOOKS.md` (*Certainty by Construction*).

## Sources read on 12 November 2026

- Agda docs, "What is Agda?": <https://agda.readthedocs.io/en/latest/getting-started/what-is-agda.html>
- Agda docs, "Safe Agda": <https://agda.readthedocs.io/en/latest/language/safe-agda.html>
- Lean language reference 4.27.0, "Axioms": <https://lean-lang.org/doc/reference/4.27.0/Axioms>
- Philip Wadler, "Programming Language Foundations in Agda", SBMF 2018:
  <https://homepages.inf.ed.ac.uk/wadler/papers/plfa/sbmf.pdf>
- Sandy Maguire, *Certainty by Construction: Software and Mathematics in Agda*, Leanpub:
  <https://leanpub.com/certainty-by-construction>
