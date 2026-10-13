---
description: Make Zettelkasten notes in notes/ from what you give (Obsidian readable), per SMART_NOTE_POLICY.md
argument-hint: <the idea, the text of a message, or a link; say who it came from>
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

Turn $ARGUMENTS into notes, following `SMART_NOTE_POLICY.md` exactly.

1. Read `SMART_NOTE_POLICY.md`, `PERSONAS.md` and `notes/index.md`.
2. Split the input into atomic ideas: one note each.
3. For each idea: choose the type (fleeting, literature, permanent), the id (UTC `YYYYMMDDHHMM`,
   one minute apart if several), a short slug, tags, and the source (the person's alias, or the
   link). If the source is a person not in PERSONAS.md, add them under the next free alias
   (`friendN`) and keep their real name out of every file.
4. Check each factual claim: fetch a primary source when you can. Mark `verified` or `partial`
   only with the source cited in the note; otherwise `unverified` or `open-question`, and say what
   would verify it.
5. Link each note to the closest existing notes, and add it to `notes/index.md`.
6. Run `python3 scripts/notes_check.py` and `python3 scripts/cite_check.py`; fix what they report.
7. Commit on a branch and open a pull request; do not push to `main`. Report the notes made,
   with their status.
