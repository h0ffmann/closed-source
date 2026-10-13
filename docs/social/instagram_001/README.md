---
title: "instagram_001: the book, the author, the skill, the thinkers"
status: draft
date: 2026-10-13
related: [render.mjs, ../../../CITATION_SCORES.md, ../../../50THINKERS.md, ../../../.claude/skills/citation-score/SKILL.md]
style: reference
instagram: not posted
caption: pt-BR
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# instagram_001: the first closed-source post

**Not posted.** The owner posts it; an agent does not. When it is posted, put the link in
`instagram:` above and change `status`.

A carousel of five slides, 1080x1350 (4:5), for Hoffmann's personal Instagram page. There are two
versions: this one, in English (`slide-N.png`), and an easy Brazilian Portuguese one with more
explanation (`slide-N.easy.pt-BR.png`, [README.easy.pt-BR.md](README.easy.pt-BR.md)), made with
the `easy-pt-br` skill. The story is
the book, its author, the `citation-score` skill and the thinkers the book stands on. Each number
on a slide shows its source under it, and `render.mjs` reads each number from that source when it
renders.

It follows the first picasso post, h0ffmann/picasso
[`docs/social/instagram_001/`](https://github.com/h0ffmann/picasso/tree/29eb385/docs/social/instagram_001)
at commit `29eb385`: the same slide system and the same drawings. The colours are the book's
identity, black and red with yellow letters, in place of picasso's blue.

| Slide | Shows | Sources |
|---|---|---|
| [slide-1.png](slide-1.png) | the book: the cover block, "if anyone can reverse engineer anything, cite what you borrow", the DOI; the owl | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656), from `CITATION.cff` |
| [slide-2.png](slide-2.png) | the author: Mr. Nobody on the cover, written by Matheus Hoffmann; his three other DOIs; the face | [`papers/closed-source/metadata.md`](../../../papers/closed-source/metadata.md) (`writer`, `works`) |
| [slide-3.png](slide-3.png) | the skill: `citation-score`, the two ends of its scale, and five READMEs scored | [`CITATION_SCORES.md`](../../../CITATION_SCORES.md), made by [`scripts/citation-score.sh`](../../../scripts/citation-score.sh) on 2026-10-13 |
| [slide-4.png](slide-4.png) | the references: 50 thinkers, 100 pages, 42 named, 41 references; fourteen names; the guitar | [`50THINKERS.md`](../../../50THINKERS.md); [`papers/closed-source/REFERENCES.md`](../../../papers/closed-source/REFERENCES.md) |
| [slide-5.png](slide-5.png) | borrow, cite, propagate: the paper, the DOI, the site and the source; the dove | the generated citation in [`README.md`](../../../README.md#cite) |

- The two verdicts on slide 3, "PERFECT. HIGHEST MATURITY LEVEL." and "POOR. 2 DIGIT IQ.", are
  the two ends of the skill's scale, in the owner's words. They are verdicts on a text.
- The fourteen names on slide 4 are the first rows of `50THINKERS.md` whose status is not `open`,
  in the file's order. A thinker listed under an alias from `PERSONAS.md` is not shown. The
  roster's status for most is `proposed`: the book has not been written, and no thinker has
  endorsed it.
- The drawings are picasso's own one-line homages (CC BY 4.0, © 2026 Matheus Hoffmann), read from
  the `forks/picasso` submodule at render time and not copied into this repository. No slide
  shows a work by Pablo Picasso.

## Caption (pt-BR)

```text
Saiu a v0.1.0 de "Closed Source: The God that Failed", a primeira versão com DOI no Zenodo (10.5281/zenodo.23333656). Se qualquer pessoa consegue fazer engenharia reversa de qualquer coisa, o caminho honesto é citar o que você pega emprestado. O livro terá 100 páginas: 50 pensadores, duas páginas cada. Junto vai uma skill, citation-score, que mede quanto de um texto tem citação. Ela conta marcas de citação, não a verdade delas. As fontes estão nos slides. É um preprint, ainda sem revisão por pares. Site, artigo e código: link na bio.

#opensource #citation #doi #research #zenodo
```

## Caption (English)

```text
"Closed Source: The God that Failed" v0.1.0 is out, the first release with a Zenodo DOI (10.5281/zenodo.23333656). If anyone can reverse engineer anything, the honest course is to cite what you borrow. The book will be 100 pages: 50 thinkers, two pages each. It comes with a skill, citation-score, that measures how much of a text is cited. It counts citation marks, not whether they are right. Sources are on the slides. It is a preprint and has not been peer reviewed. Site, paper and code: link in bio.

#opensource #citation #doi #research #zenodo
```

Link in the bio: https://h0ffmann.github.io/closed-source/

## Alt text

1. A book cover block: CLOSED SOURCE in yellow letters on black, THE GOD THAT FAILED on a red band. Text: if anyone can reverse engineer anything, cite what you borrow. The DOI 10.5281/zenodo.23333656. A one-line owl.
2. The author. Mr. Nobody on the cover, a person behind it: written in the first person by Matheus Hoffmann, Escola Politécnica, UFRJ. Three other works with their DOIs: marola, ww3-gpu and picasso. A one-line face.
3. The skill. How much of your text is cited? 100%: perfect, highest maturity level. 0%: poor, 2 digit IQ. Five READMEs scored as bars: closed-source 30%, marola 48%, ouroboric-dev 50%, h0ffmann 73%, picasso 42%. It counts marks, not truth.
4. The references. 50 thinkers, two pages each: 100 pages, 42 thinkers named and 8 places open; 41 references in the paper, each fetched before it was cited. Fourteen names, from Auguste Kerckhoffs to Geoffrey Hinton. A one-line cubist guitar.
5. Publish the method, mint an identifier, cite what you use. A position paper, v0, not peer reviewed. The DOI, the site and the source link. A one-line dove.

## Render again

```console
git submodule update --init --depth 1 forks/picasso   # the drawings
just citation-board                                   # refresh CITATION_SCORES.md, if the READMEs changed
cd docs/social/instagram_001
node render.mjs            # both versions; needs node and Chrome; CHROMIUM=<path> to pick a browser
```

The slides need the fonts Inter, Inter Display and DejaVu Sans Mono on the machine. If the
numbers in `CITATION_SCORES.md` change, update the alt text of slide 3 here and in the easy
version. If a slide's words change in `render.mjs`, change both versions there, then both READMEs.
