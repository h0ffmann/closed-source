---
name: essay-montaigne
description: "Check that an essay, in English or in Brazilian Portuguese, keeps what Montaigne asked of an essay in his own Essays: the writer is in it, it opens on the writer's case, it is a trial and not a lesson, it doubts, it is of its day, what it borrows is weighed, and its translation says the same thing. Use when asked to check, review or finish an essay of essays/, after deriving one from notes (DERIVATION.md), or when someone asks whether a text is an essay."
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# essay-montaigne

Michel de Montaigne gave the essay its name: an *essai* is a trial. He also said, inside the
*Essays*, what he was doing. This skill turns those sentences into rules and checks an essay
against them. It checks the form. It cannot tell you that an essay is good.

## The rules, short

An essay, in the sense of Montaigne's *Essays*:

1. has its writer in it, in the first person, from the first paragraph;
2. opens on a case of the writer's, not on a definition or a survey;
3. tries the writer's judgement; it does not display learning;
4. moves by a method that a reader can name;
5. lets the writer speak first and the borrowed words after;
6. weighs its borrowings: quoted words are a small part;
7. gives a judgement as the writer's measure, with "I think" or "I do not know";
8. doubts at least once, in earnest;
9. has a date, and may be contradicted later by its own writer;
10. does not teach: no orders to the reader, no list of lessons;
11. takes any subject and stops before it has covered all of it.

This repository adds four: what is borrowed is named; the brief is met; the writer's experience
is the writer's to write; and a translation says the same thing. The table below gives each rule
with the sentence it comes from, and says whether the script or a reader checks it.

## Run it

```sh
scripts/essay-montaigne.sh essays/2026-new-vs-better.md
scripts/essay-montaigne.sh --topics "AI,El Niño,social media,Bitcoin,privacy" <file>
scripts/essay-montaigne.sh --self-test
just essay-check essays/2026-why-i-write.pt-BR.md
```

The language comes from the front matter (`lang: pt-BR`) or from a name that ends in
`.pt-BR.md`; with neither, the essay is English. A Portuguese essay is checked with Portuguese
words: the first person is `eu`, `meu`, `minha` and their forms; a doubt is `não sei`, `que sei
eu`, `não tenho certeza`; an order is `você deve`, `você precisa`; its last section is
`## Fontes`. Quotations keep the language they were found in, and the translation comes after
them (AGENTS.md, "Two languages").

`just check` runs it on every essay of `essays/`. With no `--topics`, the brief is the essay's
own front matter: `topics: "a,b,c"`.

## The rules, each from his text

Every quotation below was read in Charles Cotton's translation, Project Gutenberg eBook 3600,
fetched on 14 October 2026. The translation is in the public domain.

| Rule | His words | Where | Checked by |
|---|---|---|---|
| **1. The writer is in it.** First person, and the writer's own life as matter | "myself am the matter of my book" | "The Author to the Reader" | script: `first-person` |
| **2. A trial, not a display.** It tries the writer's judgement; it does not show learning | "You have here purely an essay of my natural parts, and not of those acquired" | II, "Of Books" | reader |
| **3. Method over matter** | "let none lay stress upon the matter I write, but upon my method in writing it" | II, "Of Books" | reader |
| **4. The writer speaks first, and borrows after** | "I make others say for me, not before but after me, what [...] I cannot myself so well express" | II, "Of Books" | script: `own-first` |
| **5. Borrowings are weighed** | "I do not number my borrowings, I weigh them" | II, "Of Books" | script: `borrowings` (at most 20% quoted words) |
| **6. An opinion is the measure of the writer, not of the thing** | "the judgment I deliver, is to show the measure of my own sight, and not of the things I make so bold to criticise" | II, "Of Books" | reader |
| **7. It doubts** | "What do I know?" | II, "Apology for Raimond Sebond" | script: `doubt` |
| **8. It is of its day, and may be contradicted** | "I do not paint its being, I paint its passage"; "I may peradventure contradict myself" | III, "Of Repentance" | script: `dated` |
| **9. It does not teach** | "I do not teach; I only relate" | III, "Of Repentance" | script: `no-lesson` |
| **10. Any subject, and never the whole of it** | "I leave the choice of my arguments to fortune [...] I never design to go through any of them; for I never see all of anything" | I, "Of Democritus and Heraclitus" | reader |
| **1a. The writer is in it from the start**: the first paragraph of prose has the first person | "myself am the matter of my book" | "The Author to the Reader" | script: `case-first` |

Three more rules are this repository's, not his:

| Rule | Why | Checked by |
|---|---|---|
| **11. What is borrowed is named**, in a `## Sources` section | Montaigne often left his borrowings unnamed. AGENTS.md does not: cite at the point of use | script: `sources` |
| **12. The brief is met**: each topic that was asked for is in the text | an essay that was asked for five things and treats four is not finished | script: `topics` |
| **14. A case before a claim.** It opens on something the writer saw or did, and the general idea comes after the case | Montaigne's rule 2, as Theodore Dalrymple practised it in "The Frivolity of Evil" (*City Journal*, Autumn 2004): it opens on released prisoners and, a few lines on, a woman of 21 who "consulted me" the day before; he writes from "14 years of my hospital and prison work" | reader; `case-first` counts the "I" |
| **15. A translation says the same thing.** An essay in two languages has the same markers and the same numbers in both | AGENTS.md, "Two languages": a change to one edition goes into the other in the same pull request; the front matter names the other file in `translation:` | script: `translation` |
| **13. The writer's experience is the writer's** | AGENTS.md, invariant 3: never invent an author's experience. A gap is a `**[AUTHOR ANECDOTE: ...]**` marker, and an essay with an open marker stays `draft` | script: `anecdotes` |

## The reader's part

The script cannot judge rules 2, 3, 6, 10 and 14. After it passes, read the essay and answer each
in one line, with the sentence of the essay that shows it:

1. **Rule 2.** Does it begin from something that happened to the writer, and not from a
   definition or a survey?
2. **Rule 3.** Can you say how the essay moves (one case tried on several things, a walk, a
   quarrel with one sentence)? If you can only say what it is about, it is an article.
3. **Rule 6.** Where it judges a thing, does it say "I think", "I can show", "I do not know"?
   A judgement with no "I" is a verdict.
4. **Rule 10.** Does it stop before it has covered the subject? An essay that tries to be
   complete has become a treatise.
5. **Rule 14.** Does the first idea of the essay come after a case? Name the case and the
   sentence where the idea first appears. Dalrymple's order is the model: the patient first,
   the diagnosis of the culture after.
6. **Every "I".** In an essay that an agent drafted, each first-person sentence must stand on a
   note that the writer gave. Name the note for each one, or replace the sentence with a marker.

Report as a table: rule, pass or fail, the sentence. Then say plainly that the form was checked
and the quality was not.

## A second model: Theodore Dalrymple

Montaigne is the source of the rules. Theodore Dalrymple, the pen name of Anthony Daniels, is a
second model, for the essay of cultural criticism written from a working life. He was a
psychiatrist and prison doctor in Birmingham, at City Hospital and Winson Green Prison, and
wrote for *City Journal*; he is thinker 37 of `50THINKERS.md`. Read him for rules 2, 7 and 14:
the case before the claim, the writer's own measure, and the place he speaks from.

| Work | What to read it for | Status |
|---|---|---|
| "The Frivolity of Evil", *City Journal*, Autumn 2004 (published 2004-11-01), <https://city-journal.org/article/the-frivolity-of-evil>. His best-known essay | it opens on a case, speaks from 14 years of hospital and prison work, and ends on the writer leaving: "I'm leaving—I hope for good." | verified: the text was read on 2026-10-25, and the quoted sentences were found in it |
| *Life at the Bottom: The Worldview That Makes the Underclass* (Chicago: Ivan R. Dee, 2001), ISBN 1-56663-505-5 | essays first published in *City Journal* from 1994, in two parts, "Grim Reality" and "Grimmer Theory" | partial: Wikipedia, "Life at the Bottom", read on 2026-10-25 |
| *Our Culture, What's Left of It: The Mandarins and the Masses* (Chicago: Ivan R. Dee, 2005), ISBN 1-56663-643-4 | twenty-six pieces of cultural criticism, from drug laws to Shakespeare | partial: Wikipedia, "Our Culture, What's Left of It", and the Manhattan Institute's page of the book, read on 2026-10-25; whether "The Frivolity of Evil" is in it was not checked |

## What it cannot tell you

- That the essay is true. A sourced claim is checked by reading its source.
- That it is well written, or that Montaigne would have liked it.
- That an "I" is honest. The script counts the word; only the writer knows.

## Sources

- Montaigne, Michel de. *Essays of Michel de Montaigne, Complete*. Translated by Charles Cotton,
  edited by William Carew Hazlitt. Project Gutenberg eBook 3600,
  <https://www.gutenberg.org/ebooks/3600>. Each quotation above was found in the plain text of
  that edition on 14 October 2026. "The Author to the Reader" is marked there as "Omitted by
  Cotton" and given in the editor's version.
- The marker and the rule on experience: `AGENTS.md`, invariant 3.
- Theodore Dalrymple: the three works in the table above, with the date each was read; his
  life and work: Wikipedia, "Theodore Dalrymple", read on 2026-10-25.
- The rule on translation: `AGENTS.md`, "Two languages".
- The shape of this page (a script for what can be counted, a list for what needs a reader,
  and a section on what it cannot tell): `.claude/skills/citation-score/SKILL.md`, in this
  repository.
