---
title: "Smart note policy"
status: draft
date: 2026-10-12
related: [AGENTS.md, PERSONAS.md, notes/index.md, .claude/commands/note.md, tools/src/fabric/notes_check.gleam]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Smart note policy

How notes come into this repository: in the Zettelkasten style (Luhmann's slip box, as Sönke Ahrens
describes it in *How to Take Smart Notes*), as plain Markdown that [Obsidian](https://obsidian.md)
reads when you open `notes/` as a vault. `/note` (`.claude/commands/note.md`) makes one.

## Rules

1. **One idea, one note.** A note holds one claim, one fact or one question. Split a message with
   five ideas into five notes.
2. **Own words.** Write the idea in plain words. Quote only what must stay exact, in quotation
   marks, with its source.
3. **A permanent name.** The file is `notes/<id>-<slug>.md`. `id` is the UTC time it was made,
   `YYYYMMDDHHMM`. The id never changes; the title can.
4. **Front matter** (Obsidian reads it as properties):

   ```yaml
   ---
   id: "202610122236"
   title: "Katib's UI and Vertex AI's UI"
   type: fleeting | literature | permanent
   status: unverified | partial | verified | open-question | approved
   source: "friend1, conversation, 2026-10-12"   # who or what the idea came from
   tags: [open-source, cloud]
   created: 2026-10-12
   ---
   ```

   - *fleeting*: a raw idea from a person, as it came.
   - *literature*: what one source says, with its link or DOI.
   - *permanent*: my own claim, built from other notes, ready for the book.

   `approved` is the owner's word, not a check of the facts: the owner read the note and
   approved it for the book. It is for a note that holds his own reading or position, where
   there is no outside source to fetch. Only the owner gives it, and the note says when. A
   factual claim inside an approved note still follows rule 7.
5. **The cite line** follows the front matter, as in every Markdown file here (PERSONAS.md):
   main author = whose thinking the note records; last author = who filed it and answers for it.
6. **Links.** Every note links to at least one other note with `[[<id>-<slug>]]`, and
   `notes/index.md` (the map of content) links to every note. A link must point to a note that
   exists.
7. **Truth.** A factual claim is `unverified` until a source is fetched and cited in the note. Never
   invent a source, a quotation or a number. A note may say "I could not verify this".
8. **People.** A friend who gives notes, or who is in one, appears under an alias (`friend1`,
   `friend2`, ...) that PERSONAS.md lists, and a teacher under `prof1`, `prof2`, ...; the real
   name stays out of the repository. A person of a note is written with a real name only when
   the owner asks for that person by name, and PERSONAS.md then says so in the person's row. A proclaimed AI guru is quoted
   only for a public, cited claim (AGENTS.md).
9. **Into the book.** A permanent note with status `verified`, `partial` or `approved` can become text in a
   thinker's two pages. The page cites the note's sources, not the note.

`just check` runs `tools/fabric notes-check`: front matter, unique ids and links that resolve.
