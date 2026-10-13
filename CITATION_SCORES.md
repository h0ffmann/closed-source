---
title: "Citation scores of five READMEs"
status: draft
date: 2026-10-13
related: [.claude/skills/citation-score/SKILL.md, scripts/citation-score.sh, scripts/citation-board.sh]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Citation scores

How much of each README is cited, measured with [`scripts/citation-score.sh`](scripts/citation-score.sh)
on 13 October 2026. The score is the share of sentences that carry a citation mark: a
link, a DOI, a pandoc key, a footnote or an author and a year. `just citation-board` writes this
file from [`scripts/citation-board.tsv`](scripts/citation-board.tsv); do not edit the table by
hand. The website shows the same table.

<!-- citation-board:start -->
| README | File | At commit | Cited sentences | Sentences | Score | Verdict |
|---|---|---|---:|---:|---:|---|
| closed-source | [h0ffmann/closed-source `README.md`](README.md) | working tree | 35 | 115 | 30% | THIN. Most of it is yours, or unsupported. |
| marola | [marola-dev/marola `README.md`](https://github.com/marola-dev/marola/blob/cf7bd4f/README.md) | `cf7bd4f` | 57 | 120 | 48% | THIN. Most of it is yours, or unsupported. |
| ouroboric-dev | [ouroboric-dev/.github `profile/README.md`](https://github.com/ouroboric-dev/.github/blob/b799793/profile/README.md) | `b799793` | 2 | 4 | 50% | FAIR. Half of it stands on a source; the rest is yours, or unsupported. |
| h0ffmann | [h0ffmann/h0ffmann `README.md`](https://github.com/h0ffmann/h0ffmann/blob/5d81ea1/README.md) | `5d81ea1` | 22 | 30 | 73% | FAIR. Half of it stands on a source; the rest is yours, or unsupported. |
| picasso | [h0ffmann/picasso `README.md`](https://github.com/h0ffmann/picasso/blob/29eb385/README.md) | `29eb385` | 60 | 142 | 42% | THIN. Most of it is yours, or unsupported. |
<!-- citation-board:end -->

## How to read it

- **A README is not a paper.** Most of its marks are links to its own files and to the projects
  it names. A link shows where a thing is; it does not always show where an idea came from.
- **A low score is not a fault.** A page that says what its author built, in the author's own
  words, has little to cite. The score says how much of a text points at something else.
- **The verdicts are a scale for texts, set by the owner of this repository**
  ([the `citation-score` skill](.claude/skills/citation-score/SKILL.md)). They are not a
  judgement of the people or the projects behind the other READMEs.
- **The numbers are approximate.** The skill lists what the script cannot tell.
- **Each row names the commit** that was scored, so a reader can run the script on the same text.
