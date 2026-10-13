---
name: easy-pt-br
description: "Make or update an easy Brazilian Portuguese version of a document: README.easy.pt-BR.md from README.md, or <name>.easy.pt-BR.md beside any other source, such as a social post. Use after any change to README.md, when the hook or scripts/readme.sh --check says the easy version is older than README.md, or when asked for a 'versão fácil' or an 'easy pt-BR' of anything."
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# easy-pt-br

`README.easy.pt-BR.md` is `README.md` in Brazilian Portuguese that a person outside the field can
read. `README.md` is the source of truth. The easy version is always made from it, never edited
on its own, and never the other way round.

## Steps

1. Read all of `README.md` and the current `README.easy.pt-BR.md`.
2. Run `git diff` on `README.md`, or compare the two files, to find what changed. Change the same
   sections of the easy version. When there is no easy version, or the page was restructured,
   write it again from the top.
3. Keep the header block of the easy version (see "The header block"). Update its date.
4. Run `scripts/readme.sh --stamp`. It writes the sha256 of `README.md` into the easy version.
   Never write the hash by hand, and never stamp a version you did not bring up to date.
5. Run `scripts/readme.sh --check`. It fails if a DOI is missing, the number of `##` sections
   differs, a word has a capital that is not an acronym, or the stamp is old.

## How to write it

- **Same sections, same order.** One `##` section in the easy version for each one in
  `README.md`, so a reader can go from one to the other.
- **Short sentences, one idea each.** Aim for 20 words or fewer. Use the active voice and the
  present tense. Say "você".
- **Common words.** Say "arquivo", not "artefato"; "programa", not "binário". When a technical
  word is needed, keep it and explain it once, in a few words, the first time: "DOI (um
  identificador que não muda)".
- **Do not translate:** commands and code blocks, file names, names of projects and people,
  names of licences, DOIs and URLs. Copy code blocks as they are; translate only their `#`
  comments. Keep a quotation in English and give the translation after it, as AGENTS.md says for
  the book.
- **Lower case**, as in `README.md`: acronyms keep their capitals, nothing else has one.
- **Shorten, do not invent.** A long table or a list of options may become one sentence that
  points to the section of `README.md`. Never add a fact, a number or a promise that
  `README.md` does not have. If `README.md` is unclear, say what it says; do not guess.
- **The generated citation block stays in `README.md`.** The easy version explains how to cite
  and links to that section.

## The header block

The easy version starts with the cite line, the stamp line, and a block that tells the reader
what this file is:

```markdown
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
<!-- easy: source="README.md"; sha256="" -->
# versão fácil: closed source: the god that failed

> **esta é a versão fácil, em português, do [README.md](README.md).**
>
> - **vale o original.** se este texto e o original discordarem, vale o original, em inglês.
> - **feita a partir de:** a versão do original de <date>.
> - **para quem é:** quem quer entender o projeto sem ser da área.
> - **o que ficou de fora:** <what was shortened, and where it is in the original>.
> - **escrita por:** claude, com a skill `easy-pt-br`; revisão de matheus hoffmann.
```

## Other documents

The same rules make an easy version of any document. Put it beside its source, with the same
name and `.easy.pt-BR.md` at the end, and start it with the header block.

- **The case follows the source.** Only the root `README.md` and its easy version are in lower
  case. A document in sentence case gets an easy version in sentence case.
- **More explanation is allowed, more facts are not.** An easy version may add a list of the hard
  words with one plain sentence each, as `docs/social/instagram_001/README.easy.pt-BR.md` does.
  Each sentence explains a word; it does not add a claim about the work.
- **Images with words** (the slides of a post) get an easy version too: the words are in
  `T['easy.pt-BR']` in the post's `render.mjs`, and the files are `slide-N.easy.pt-BR.png`.
- **Only the root README has a stamp.** `scripts/readme.sh` checks that one. For any other
  document, the header block's "feita a partir de" line carries the date of the source.

## Why there is a stamp

A script cannot tell if a translation is right. It can tell if the translation was made from this
exact `README.md`. So the stamp is the contract: `just check`, the pre-commit hook in
`.githooks/` and the hook in `.claude/settings.json` all compare it with the file's sha256.
`tools/fabric ste-check --translation` does the deeper check for the paper; this page has no
citations or numbers that need it.

## Sources

Written for this repository. Nothing here is copied from another skill.

- The header block ("vale o original", "feita a partir de", "para quem é", "o que ficou de
  fora", "escrita por") is the one of marola-dev/marola,
  `docs/MIPs/MIP-0091.easy.pt-BR.md` at commit `cf7bd4f`
  (<https://github.com/marola-dev/marola/blob/cf7bd4f/docs/MIPs/MIP-0091.easy.pt-BR.md>).
- "Explain to a reader who knows nothing about the topic, short sentences, one idea at a time,
  the field's word after the plain one" is read from marola's `eli5` skill,
  `.claude/skills/eli5/SKILL.md` at `cf7bd4f`. That skill says it adapts the community `eli5`
  skill by Thariq Shihipar (MIT); only marola's file was read.
- "A rendering keeps every citation, number and quotation of its source" is this repository's
  own rule for `prose-ste/` and `prose-pt-BR/` (AGENTS.md, "Two languages";
  `.claude/commands/ste100.md`).
