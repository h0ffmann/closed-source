---
name: citation-score
description: "Score how much of a text is cited, from 0% to 100%, with a coloured verdict. Use when asked to score, rate or check the citations of a phrase, a text, a pasted dump, a file or a URL, or when someone asks how original, how supported or how well cited a text is."
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# citation-score

How much of a text stands on a source, and how much is the writer's own? This skill counts it,
approximately. The scale's two ends are the owner's words (Hoffmann, 13 October 2026):

| Score | Verdict | Colour |
|---:|---|---|
| 100% | PERFECT. HIGHEST MATURITY LEVEL. | green, bold |
| 75% to 99% | STRONG. Almost every sentence stands on a source. | green |
| 50% to 74% | FAIR. Half of it stands on a source; the rest is yours, or unsupported. | yellow |
| 25% to 49% | THIN. Most of it is yours, or unsupported. | yellow |
| 1% to 24% | WEAK. Nearly all of it is yours, or unsupported. | red |
| 0% | POOR. 2 DIGIT IQ. | red, bold |

The verdict is about the text, never about the person. The four middle rows are this skill's.

## Run it

```sh
scripts/citation-score.sh "a phrase, or a longer text"
scripts/citation-score.sh papers/closed-source/prose/04-espionage.md
scripts/citation-score.sh 'https://example.org/page'
pbpaste | scripts/citation-score.sh -            # a dump, on stdin
scripts/citation-score.sh --color=always --list=10 notes/index.md
```

It prints a bar of 20 blocks, the percentage, the verdict, the counts, and the first sentences
that have no citation mark. In a terminal the bar and the verdict are in colour; `NO_COLOR` or
`--color=never` turns that off.

## Show the result

A chat does not show terminal colours. When you report a score to a person, run the script with
`--color=never` and draw the bar again with coloured squares, 10 squares for 100%:

- 🟩 for each 10% that is cited, when the score is 75% or more; 🟨 from 25% to 74%; 🟥 below 25%;
- ⬜ for the rest.

Then give the percentage and the verdict in bold, the counts, and the uncited sentences.
Example: `🟨🟨🟨🟨⬜⬜⬜⬜⬜⬜ **38% cited: THIN.** 16 of 42 sentences carry a citation mark.`

## What it counts

The script splits the text into sentences of three words or more. Headings, code blocks, HTML
comments, front matter and table rules are left out. A sentence is *cited* when it carries one of
these marks:

- a pandoc citation: `[@smith2016]` or `@smith2016`;
- a DOI, a URL, a Markdown link, or a wiki link `[[note]]`;
- a footnote `[^1]`, or a numbered reference `[12]`;
- an author and a year: `(Nash, 1955)`, `Smith et al. 2016`, `Boldrin and Levine (2008)`;
- a line that starts with `Source:` or `Fonte:`.

The score is the cited sentences over all sentences, rounded.

## What it cannot tell you

Say these limits when you give a score. They are why the score is approximate.

1. **It counts marks, not truth.** A wrong or invented citation scores the same as a right one.
   This repository's rule still holds: fetch every source before you cite it (AGENTS.md).
2. **One mark covers one sentence.** A paragraph that ends with one citation for three sentences
   scores 33%, though a reader would call it cited.
3. **An uncited sentence is not always a fault.** It can be the writer's own idea, a transition,
   or common knowledge. "Original" and "unsupported" look the same to the script; a person must
   tell them apart.
4. **100% is not the goal for every text.** A paper that is only citations has no thesis. The
   paper's argument is that you cite what you borrow, not that every sentence is borrowed.
5. **A link is not always a source.** On a web page, navigation links count as marks, so a URL's
   score runs high.

## Sources

Written for this repository. Nothing here is copied from another skill.

- The measure, cited units over all units, is a per-sentence form of the *citation density* that
  Hyland and Jiang (2019) count per 10,000 words in "Points of Reference: Changing Patterns of
  Academic Citation", *Applied Linguistics* 40(1), 64-85,
  [doi:10.1093/applin/amx012](https://doi.org/10.1093/applin/amx012).
- "Cited" as "the statement carries a citation", apart from whether the citation supports it,
  follows the two measures of Liu, Zhang and Liang (2023), "Evaluating Verifiability in
  Generative Search Engines", [arXiv:2304.09848](https://arxiv.org/abs/2304.09848): citation
  recall and citation precision. This skill measures only the first, and only by marks.
- The pandoc citation forms are those of this repository's papers (`papers/*/prose/`).
