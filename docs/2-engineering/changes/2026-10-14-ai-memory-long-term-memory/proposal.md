---
title: "ai-memory as the long-term memory of closed-source"
status: draft
date: 2026-10-14
related: [../README.md, delta.md, tasks.md, ../../../../MEMORY.md, ../../../../AGENTS.md, ../../../../.claude/settings.json]
style: research
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# ai-memory as the long-term memory of closed-source

**Decision pending.** The owner asked for this change (Hoffmann, 14 October 2026). Merging the
pull request that carries this proposal is the decision; the owner then writes
`**Decided YYYY-MM-DD:** ...` here.

## Why

The owner's words (14 October 2026): "adopting this https://github.com/akitaonrails/ai-memory
notes about akita later, but this will be the long-term memory for closed-source".

Today the memory of this repository is files in the repository (`MEMORY.md`), and project
memory in Claude is off. A file holds what was decided. It does not hold what a session tried,
what failed, or where the work stopped. The next session, or the next agent, learns that again
from the start.

## Read: what ai-memory is

Source: [akitaonrails/ai-memory](https://github.com/akitaonrails/ai-memory) at
[`705aba7`](https://github.com/akitaonrails/ai-memory/tree/705aba70bc1a3ce6349194135206fb622ca55749),
its `README.md`, `DATA_HANDLING.md` and `INSTALL_FOR_AGENTS.md`; the Claude Code plugin at tag
`v3.0.0` (`14f3fa8`, released 14 October 2026), its `README.md`, `hooks/hooks.json`, `.mcp.json`
and `scripts/ai-memory-hook`. Licence: MIT, "Copyright (c) 2026 Fabio Akita". Read on 14 October
2026.

- It is "Long-term memory for AI coding agents". Its README gives the use: "Quit Claude Code
  mid-task, start OpenAI Codex in the same directory, continue without re-explaining the
  architecture, the failed approaches, or the open questions."
- It is a server that you run. Lifecycle hooks capture prompts, tool calls and session
  boundaries. At session end, the server writes them as pages of a wiki, and the next session
  gets a short brief and a handoff.
- "The source of truth is a git-backed wiki of ordinary `.md` files". The database is an index
  that can be built again from the files.
- The default "uses **zero LLM calls**". By default nothing leaves the machine: "ai-memory does
  not phone home", and embeddings are local. Three opt-in paths send data out: a cloud embedding
  provider, assistant capture, and LLM reranking (`DATA_HANDLING.md`).
- The Claude Code plugin does not contain the server. "Without the binary the plugin captures
  nothing: it says so once at session start and never blocks Claude." Its hooks "run with your
  user permissions, outside Claude's sandbox".

## Evaluate

- **It fits the rule of this repository.** The memory is Markdown in git, which a person can
  read and correct. The default makes no model call and sends nothing out.
- **The wiki is not in this repository.** It lives in the server's data directory on the
  owner's machine. A reader of this repository, or an agent on another machine, does not see it.
  So the files that `MEMORY.md` lists stay the record: a decision, a rule or a fact that a reader
  needs goes into them, as before. ai-memory holds the long-term working memory: the sessions,
  the handoffs, what failed and what is open.
- **It captures everything that a session reads.** That includes a private source that a session
  opens, for example a part of `h0ffmann/nagori`. The capture stays on the owner's machine while
  the three opt-in paths stay off. `[capture] ignore_paths` can keep a path out (README, "Docker").
- **It is new.** v3.0.0 was released on the day of this proposal. The plugin is pinned to that
  tag, and an update is a change to `.claude/settings.json` in a pull request.
- Not tested in this repository: no server was installed, the plugin was not enabled, and no
  session was captured while this proposal was written.

## Adopt: what changes

1. `.claude/settings.json` registers the marketplace `akitaonrails/ai-memory` at tag `v3.0.0` and
   enables the plugin `ai-memory@ai-memory`, as marola-research enables its coding plugin. The
   owner makes this edit: the agent that wrote this proposal was not allowed to enable a
   third-party plugin whose hooks run outside the sandbox (tasks.md, step 2).
2. `MEMORY.md` gets a section, "Long-term memory: ai-memory": what it holds, what the files hold,
   how to install it, and the settings that keep the capture on the machine.
3. `AGENTS.md` says in its map that the long-term memory is ai-memory, through `MEMORY.md`.

The text of each change is in [delta.md](delta.md). The steps are in [tasks.md](tasks.md).

## Not in this proposal

- Notes about Akita. The owner will write them later ("notes about akita later").
- A citation of ai-memory in the paper, `refs.bib` or `.zenodo.json`. ai-memory is a tool of the
  work, not a source of the book. If the book cites it, that goes through the paper's
  `REFERENCES.md` like any other source.
- The install on the owner's machine. It is the owner's act (tasks.md, step 2).
