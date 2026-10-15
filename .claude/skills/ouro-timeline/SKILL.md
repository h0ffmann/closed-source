---
name: ouro-timeline
description: "Draw the lives of the thinkers of 50THINKERS.md on one timeline (timeline/thinkers.svg), in the book's black, red and yellow and after picasso's line drawings. Use when asked for a timeline, a chronology or a drawing of when the thinkers lived, when a thinker is added to or removed from 50THINKERS.md, when a thinker's dates change, or when `tools/fabric timeline --check` fails."
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# ouro-timeline

One picture of when the thinkers lived. Lives overlap, so it is not a sequence of events but a set
of lines, one per life, stacked in lanes. The thinkers span 2,500 years, most of them inside the
last hundred: a plain axis would crush the crowd, and a log axis would lie about how long a life
is. So the drawing keeps **one scale everywhere** and **cuts out the empty years**.

## The rules of the drawing

1. **One scale.** `px_per_year` (3) is the same in every era, so a life of 70 years is as long in
   Athens as in Silicon Valley. Never stretch one era to fill space.
2. **Cut the empty years.** When more than `max_gap` (60) years pass with no thinker alive, the
   axis stops, a red double stroke (//) marks the cut, and the label under it says how many years
   it hides (≈ 1308 years, from Cicero's death to Dante's birth). The number is the real gap.
3. **Lanes, not rows per person.** Each life takes the first lane where it fits, its name
   included, so the picture is as low as the overlaps allow.
4. **A life is one line:** an open circle at birth, a straight stroke, a short bar at death, an
   open arrowhead for the living. Round caps and joins, no fill, stroke 3.2: the manner of the
   drawings on picasso's site (`card-style`), with a broken frame.
5. **The book's colours** (AGENTS.md): ink on paper, a black band with yellow capitals for the
   title, red for the cuts and for the thinkers the paper already cites (☑). No brown. The SVG
   carries a dark scheme (`prefers-color-scheme`) with the site's dark tokens.
6. **No life without a source.** A thinker with no dates is listed under the drawing ("Not
   drawn, no dates found"), never placed by a guess.

The code is `tools/src/fabric/timeline.gleam`; its tests (`tools/test/timeline_test.gleam`) hold
rules 1 to 3.

## Steps

1. **Data.** Every named thinker of `50THINKERS.md` has a row in `timeline/lives.tsv`:
   number, name (exactly as in the table), born, died, Wikidata item. A year BCE is negative; an
   empty `died` is a living person; empty `born` and `died` is a life not drawn. Take the years
   from the person's Wikidata item (P569, P570), and check that the item is the right person (the
   description, the works). If no source gives the dates, leave them empty.
2. **Draw:** `tools/fabric timeline` (inside `nix develop`) writes `timeline/thinkers.svg`. It
   fails when a named thinker has no row in `lives.tsv`.
3. **Look at it.** Render a PNG and read it, at full size:

   ```sh
   box=$(grep -o 'viewBox="0 0 [0-9]* [0-9]*"' timeline/thinkers.svg | tr -dc '0-9 ')
   w=$(echo $box | awk '{print $3}'); h=$(echo $box | awk '{print $4}')
   google-chrome --headless=new --hide-scrollbars --window-size=$w,$((h + 200)) \
     --screenshot=/tmp/timeline.png "file://$PWD/timeline/thinkers.svg"
   convert /tmp/timeline.png -crop ${w}x${h}+0+0 +repage /tmp/timeline.png
   ```

   Chrome's viewport is shorter than its window, hence the 200 extra pixels and the crop. Check
   that no name runs into another, that each cut's label is readable, and that the list of lives
   not drawn is there.
4. **Check:** `just check` runs `tools/fabric timeline --check`, which fails when the SVG is not
   what the data draws. Commit `lives.tsv` and `thinkers.svg` together.
5. **Show it.** Put the drawing in the pull request description (the SVG on the branch, by its
   raw URL), so the owner sees the result without running anything.

## Sources

Written for this repository.

- The colours and type are the site's tokens, `site/static/style.css` (`--paper`, `--ink`,
  `--red`, `--yellow`, `--black`), after Hoppe's *Democracy: The God That Failed* (AGENTS.md).
- The line manner is after the drawings of h0ffmann/picasso's site, `site/static/drawings/` at
  commit `29eb385`, as in the `card-style` skill. No path is copied.
- The dates are from Wikidata, read on 15 October 2026; each row names its item.
