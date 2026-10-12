---
title: "Personas"
status: draft
date: 2026-10-12
related: [AGENTS.md, scripts/cite_check.py]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Personas

The hard rule (AGENTS.md): **every Markdown file is cited**. Each one names a *main author*, the
persona that wrote most of it, and a *last author*, the persona that answers for it, on one line
after its front matter (or on its first line):

```markdown
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
```

GitHub and pandoc do not show the line. `just check` fails if a tracked `.md` file has no such
line, or names a persona that is not in this table. To cite a new persona, add its row first.

| Persona | Kind | Who it is | Identifier |
|---|---|---|---|
| Matheus Hoffmann | person | The owner of this repository and the writer of the book, in the first person. | [ORCID 0009-0009-1056-7661](https://orcid.org/0009-0009-1056-7661) |
| Mr. Nobody | pen name | The name on the book's cover and title page. It is Matheus Hoffmann. | — |
| Claude | agent | The Claude coding agent (Anthropic) that drafts, checks and builds here, under the owner's direction. | the `Co-Authored-By` trailer of its commits |

The existing files were cited on 12 October 2026 as main author Claude, last author Matheus
Hoffmann: Claude drafted them, and the owner directed and merged them. Change a file's line when
its authorship is different.
