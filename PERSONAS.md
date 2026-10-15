---
title: "Personas"
status: draft
date: 2026-10-12
related: [AGENTS.md, tools/src/fabric/cite_check.gleam]
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
| friend1 | person | A friend of the owner who gives notes for the book. The real name stays out of the repository (SMART_NOTE_POLICY.md). | — |
| friend2 | person | A friend of the owner who gives notes on the owner's work. The real name stays out of the repository (SMART_NOTE_POLICY.md). | — |
| friend3 | person | The scientist: a friend the owner thinks out loud to. A note whose source is "messages to friend3" holds the owner's words, not friend3's. The real name stays out of the repository (SMART_NOTE_POLICY.md). | — |
| friend4 | person | A friend of the owner from UFRJ, one of the three of the 2017 course project (notes, "the first Scala"). The real name stays out of the repository (SMART_NOTE_POLICY.md). | — |
| friend5 | person | A friend of the owner from UFRJ, one of the three of the 2017 course project. The real name stays out of the repository (SMART_NOTE_POLICY.md). | — |
| prof1 | person | A professor of the owner at UFRJ, who gave the course of the 2017 project. The real name stays out of the repository (SMART_NOTE_POLICY.md). | — |
| prof2 | person | A professor the owner spoke with about peer review (notes, "Peer reviewing: the god that failed"). The note holds the owner's position, not prof2's words. The real name stays out of the repository (SMART_NOTE_POLICY.md). | — |
| Stanley Kubrick | person | The film director (he died in 1999); thinker 39 of `50THINKERS.md`, for *Eyes Wide Shut*, his last film. A public figure, named as every thinker is. He wrote nothing here, so no file names him as an author. | — |
| Marcus Baffa | person | A technical leader at Stone, who has passed away; thinker 46 of `50THINKERS.md`. The one person of the notes who is written with his real name: the owner asked for it by name (13 October 2026). He wrote nothing here, so no file names him as an author. | — |
| Rust Cohle | fictional character | Detective Rustin Cohle of HBO's *True Detective*, season 1 (2014), played by Matthew McConaughey. A character, not a real person; named for his view of religion (notes, "Is religion like a virus?"). He wrote nothing here, so no file names him as an author. | — |
| Claude | agent | The Claude coding agent (Anthropic) that drafts, checks and builds here, under the owner's direction. | the `Co-Authored-By` trailer of its commits |

The existing files were cited on 12 October 2026 as main author Claude, last author Matheus
Hoffmann: Claude drafted them, and the owner directed and merged them. Change a file's line when
its authorship is different.
