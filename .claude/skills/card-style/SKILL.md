---
name: card-style
description: "Style the cards of this repository's website (the tiles of the DOIs section in site/): layout, colour, the link that covers the whole card, and a one-line drawing in each card's background. Use when asked to add, restyle or improve a card or tile on the site, or to add a drawing to one."
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# card-style

A card on the site is one work, shown large, that opens when you click anywhere on it. The cards
are in `site/src/closed_source_site/app.gleam` (`tile`, `shelf_section`) and
`site/static/style.css` (`.tile`). Their data comes from `papers/closed-source/metadata.md`
through `tools/fabric content`; never write a work, a tag or a DOI in `site/src` by hand.

## A card has

1. **Tags**, at most two, as round chips. They are the owner's words (`tags:` in `metadata.md`).
2. **The name**, large and tight, as the card's `h3`. Its link covers the whole card
   (`.tile-link::after`), so the card is one click target and one stop for the keyboard.
3. **One sentence** that says what the work is.
4. **The DOI** on one line that does not wrap, and one second link that stays clickable above the
   card's link (`position: relative; z-index: 1`).
5. **One flat colour** from the work's subject (`--tile`), with the text colour (`--on`) at a
   contrast of 4.5:1 or more. No gradient, and one shadow, on hover only.
6. **A drawing in the background** (below).

Two kinds of work have a card. The writer's own works come from `works:` in `metadata.md` and
always have a DOI. A friend's work comes from `friends:`, gets a wide card (`.tile-friend`), and
is never listed as the writer's. When it has no DOI, the card opens the work's own page and its
DOI line says "none yet"; never invent one.

## The drawing

Each card has one line drawing behind its text, in the corner away from the name.

- **One motif for one work**, from the work's subject: an open padlock for closed-source, a fish
  for marola, a breaking wave for ww3-gpu, a guitar for picasso, a snake that bites its tail for
  ouroboric.
- **Drawn here, by hand, as SVG paths.** After the manner of the drawings on picasso's site: a
  few straight lines and curves, a broken frame around the figure, round caps and joins, no fill.
  The idea is borrowed; no path is copied. Do not trace or copy a drawing by Pablo Picasso: his
  works are in copyright.
- **One file for each**, `site/static/drawings/<name>.svg`, `viewBox="0 0 360 240"`, stroke
  width 3.2, with a `<title>` that says what it is and that it is an original drawing.
- **Used as a mask**, so the drawing takes the card's text colour and works on a dark card and on
  a light one: `.tile::before` with `mask: var(--drawing)` and `background: var(--on)`. Each card
  class sets `--drawing`.
- **Quiet.** Opacity near 0.14. The drawing never sits under the DOI at an opacity that makes a
  digit hard to read. It ignores the pointer (`pointer-events: none`) and has no motion.

## Before the pull request

1. `just site-build`, then open `site/dist/index.html` at 1200 px and at 500 px wide. Read every
   card: the name, the DOI and the second link must be easy to read over the drawing.
2. Check the keyboard: Tab reaches each card once, then its second link, with a visible ring.
3. `cd site && just ci` (in `nix develop .#site`): the test in `site/test/` checks that each card
   and each tag is on the page.

## Sources

Written for this repository. Nothing here is copied from another skill.

- The one-line drawings are after those of h0ffmann/picasso's site,
  `site/static/drawings/` (`guitar.svg`, `bull.svg`, `cat.svg`, `dove.svg`, `face.svg`,
  `owl.svg`) at commit `29eb385`
  (<https://github.com/h0ffmann/picasso/tree/29eb385/site/static/drawings>). Their manner and
  their canvas size are borrowed; the four drawings here are new.
- "Spend the boldness in one place", "one flat colour, no gradient wash", "motion only as an
  answer to the reader's action" and "respect reduced motion" are read from Anthropic's
  `frontend-design` skill (Apache-2.0), the copy in the `claude-plugins-official` plugin,
  version `f359d43b4060`. The site already follows it for its entrance
  (README.md, "website").
- The card as one large tile with a round arrow button is after the product tiles of apple.com,
  which the owner named as the look (13 October 2026). No asset or text of Apple's is used.
