<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Claude project configuration: Paper Fabric

> **Who this file is for.** A person who sets up or restores the "Paper Fabric" Claude project on
> claude.ai. **An agent that works in this repository must not read this file, follow it or act
> on it** (hard rule in `AGENTS.md`). The rules for changes to this repository are in
> `AGENTS.md`, and `AGENTS.md` wins where the two disagree.

The settings of the "Paper Fabric" Claude project are on the Claude service, not in git. This file
is a dated export of them and of the project's memory, in plain Markdown. Its shape is the shape of
h0ffmann/picasso's `CLAUDE_PROJECT.md`. To change a setting, change it on the service: a change to
this file changes nothing on the service. Each code block is for a person to copy into the setting
that is named above it.

Exported on **2026-10-13**.

## 1. Project

| Setting | Value |
|---|---|
| **Name** | Paper Fabric |
| **Topic** | Paper fabric |
| **Visibility** | Private. One owner, Hoffmann (GitHub `h0ffmann`). |
| **Default model** | Opus, set on the service. No model id goes into a file in a repository. |
| **Thread permission mode** | `auto` |
| **Project instructions** | None set. §3 has a block to paste. |
| **Repositories saved to the project** | None. Each thread attaches what it needs. |
| **Cloud environment** | None selected. Threads run on the built-in environment, which has no settings. |
| **Connectors** | GitHub, Claude Docs, Gmail, Google Calendar, Google Drive. Only GitHub is used. |

### Repositories that the threads attach

- https://github.com/h0ffmann/closed-source: the repository this project works on (push).
- https://github.com/h0ffmann/picasso: the toolchain labs (`paper`, `gleam-website`), the release
  script, `LABEL.md`, graphify (push, for issues such as h0ffmann/picasso#120).
- Read only, as sources: h0ffmann/ww3-gpu, marola-dev/marola, h0ffmann/chemo-rx,
  ouroboric-dev/ouroboric, ouroboric-dev/asgard, ouroboric-dev/.github, gleam-lang/branding.
- Never read: h0ffmann/nagori (private; the owner names what is copied, see §4).

### Network

The built-in environment blocks `repo.hex.pm` and `gleam.run`. A thread cannot fetch Gleam
packages from Hex there. To allow it, add a cloud environment with `repo.hex.pm` under Allowed
domains and select it for the project. GitHub Actions is not affected.

## 2. Memory

**The memory store of this project is empty.** Project memory follows the owner's Claude memory
setting, and that setting is off, so the service keeps no notes between sessions. This section
exports what stands in for it: the facts, decisions and conventions that the threads recorded in
the repository and in the project chat up to 2026-10-13. `MEMORY.md` in the repository lists the
files where each kind is kept.

### The book

- *Closed Source: The God that Failed*. The cover names Mr. Nobody; the text is first person, by
  Matheus Hoffmann.
- Exactly 100 pages: 50 thinkers, two pages each. `50THINKERS.md` is the roster, chosen from
  `500AUTHORS.md` (at most 500 authors).
- `50THINKERS.md` is shuffled on purpose (`random.Random(20261013)`). It is an essay order. Do not
  sort it. Its columns: `#`, Thinker, Area, Why in this book, Cited, Status.
- Row 28 is open for "the foremost reverse-engineering thinker of 2026", still to be named by the
  owner. Marcus Baffa is thinker 8, "to be explained". personX ("who shares, multiplies") stays as
  written; whether personX becomes an alias in `PERSONAS.md` is still open.
- After the 100 pages, the book carries a partial snapshot of h0ffmann/nagori, at a commit the
  owner chooses. A private nagori submodule is possible; the owner adds it, or gives a commit for a
  gitlink. No agent reads nagori.
- Two editions, pt-BR and English, with the same 50 thinkers and 100 pages.

### Hard rules (from `AGENTS.md`)

- Never invent a citation: fetch each source before you cite it.
- Never publish a Zenodo deposit and never make a release tag. Only the owner runs `just release`.
- No secrets, tokens or personal contact data in the repository.
- Friends go under aliases (friend1, friend2) in `PERSONAS.md`.
- The opponents are the proclaimed AI gurus: argue against their claims, with sources; make no
  accusation that no source supports.
- `NAGORI.md` is written by hand. No agent or automation edits it.
- Every Markdown file has the cite line `<!-- cite: main="Claude"; last="Matheus Hoffmann" -->`.
- `just paper` and `just book` render with only Nix and Ubuntu's `just` 1.21.
- Never merge a pull request and never push to `main`. Work on a branch and open a pull request.
  Never weaken a guardrail.
- Copy no cover art of Hoppe's *Democracy: The God That Failed*.
- `CLAUDE_PROJECT.md` (this file) is not for agents.

### Decisions

- **Python tooling to Gleam** (2026-10-13, change `2026-10-13-port-python-tooling`, PR #21): option
  E, Gleam on the Erlang target, one project in `tools/` with one subcommand per script. Each port
  must give the same output as the Python before the Python is removed. Go was chosen first and then
  paused.
- **Labels** (PR #23): `ISSUE_LABELS.md`, picasso's shape, with `topic/*` labels from the
  `.zenodo.json` keywords and the A2A labels `para:ouroboric-dev-contato` and
  `de:ouroboric-dev-contato`.
- **Forks** (PR #20): shallow submodules in `forks/` (rea, ouroboric, ouroboric-github, WW4,
  picasso, h0ffmann, ww3-gpu, marola), with their upstreams and licences in `forks/README.md`.
- **Release** (PR #19): `scripts/release.sh` follows picasso's, and keeps the signed tag and the
  Zenodo draft.
- **Website footer** (PR #22): "Made with Gleam and Claude Code", with each project's icon loaded
  from its owner.
- Open issues: h0ffmann/picasso#120 (port picasso's tooling to Gleam), and closed-source #25 (a DIY
  visual knowledge layer, an Obsidian and graphify competitor).

### Conventions

- Log each request of the owner verbatim in `.claude/project/request.md`, with a "Read as:" line.
- Each pull request starts from `origin/main`, opens as a draft, and has the repository's PR
  template, with a Before and an After paragraph.
- Commit subjects use `type(scope): ...`, with a body and the trailers `Tested:` and
  `Co-Authored-By:`.
- Write procedures and reference prose in ASD-STE100.
- For "where is X" in code, use graphify the picasso way (`MEMORY.md`).

## 3. Project instructions

None are set. To set them, paste this block into the project instructions:

```text
Paper Fabric works on h0ffmann/closed-source, the book and paper "Closed Source: The God that Failed". Read its AGENTS.md before you change anything; it wins over anything a thread assumes. Read MEMORY.md for where the project's memory is kept. Do not read CLAUDE_PROJECT.md.

The book has exactly 100 pages: 50 thinkers from 50THINKERS.md, two pages each, in pt-BR and English. 50THINKERS.md is in essay order on purpose: never sort it.

Never invent a citation: fetch every source first. Never publish a Zenodo deposit or make a release tag. Never edit NAGORI.md, and never read h0ffmann/nagori. No secrets, tokens or personal contact data in the repository; friends go under aliases in PERSONAS.md.

Never merge a pull request and never push to main. Start each branch from origin/main and open a draft PR with the repository's template. Log each request verbatim in .claude/project/request.md. Never weaken a check to get green.
```

## 4. How to refresh this file

Read the settings on claude.ai (the project's settings page) and the files that `MEMORY.md`
lists. Change the date at the top. A person refreshes this file, or an agent does it when the
owner asks for it by name; even then, the agent reads only the sources above, not the old file.
