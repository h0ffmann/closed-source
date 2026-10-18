---
title: "Archify pages"
status: draft
date: 2026-10-18
related: [../../scripts/archify.sh, ../../AGENTS.md, ../compound/README.md]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Archify pages

Interactive HTML drawings of this repository's flows, made with the `archify` skill
([tt-a1i/archify](https://github.com/tt-a1i/archify) v3.0.1, MIT). The skill is the submodule
`vendor/archify`, pinned at `2ab3cae`, shallow and sparse (only its `archify/` folder is on disk),
with `.claude/skills/archify` a symlink into it. Nothing of it is copied here. This is how
[ww3-gpu](https://github.com/h0ffmann/ww3-gpu/blob/1ec9679/docs/archify/README.md) adopted it.

A drawing is never a fact of the book. Each node names the file and the lines it was read from.

Only the typed source (`<slug>.json`) and its printed PDF are committed. The HTML pages are build
output, and git ignores them:

```bash
just archify init     # once per clone: the pinned commit, shallow, only archify/ on disk
just archify render   # every docs/archify/<slug>.json -> <slug>.html, validated in a browser
just archify pdf      # every rendered <slug>.html -> <slug>.pdf, printed by headless Chrome
just archify check    # the drawings whose JSON or Archify pin moved since their PDF was printed
just archify refresh  # render and print only those, then rewrite pdf.lock
```

`render` needs `node`, and `pdf` needs Google Chrome or Chromium. Nothing redraws on a merge.

## Drawings

None yet. To add one: ask the agent for it with the `archify` skill, save the source as
`docs/archify/<slug>.json`, run `just archify refresh`, list it here and commit the JSON, the PDF
and `pdf.lock`.
