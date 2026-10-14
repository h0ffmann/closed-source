<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# MEMORY.md

The memory of this repository. Project memory in Claude is off for this project. The long-term
memory is ai-memory (below), and what a reader or an agent must know is in files in the
repository. This file tells you where each kind of memory is. Read it after `AGENTS.md`.

## Where the memory is

| What | File |
|---|---|
| The rules and the hard rules | [`AGENTS.md`](AGENTS.md) |
| Each request of the owner, verbatim, with how it was read | [`.claude/project/request.md`](.claude/project/request.md) |
| The Claude project's settings and brief | [`.claude/project/`](.claude/project/) |
| The Ouroboric patterns that this repository uses | [`docs/4-ways-of-working/ouroboric-patterns.md`](docs/4-ways-of-working/ouroboric-patterns.md) |
| Decisions and the changes that are open | [`docs/2-engineering/changes/`](docs/2-engineering/changes/) |
| The people and their aliases | [`PERSONAS.md`](PERSONAS.md) |
| The labels for issues and pull requests | [`ISSUE_LABELS.md`](ISSUE_LABELS.md) |
| The Zenodo keywords, the related works as Zenodo and DataCite record them, and the GitHub topics, each with its date of record | [`KEYWORDS.md`](KEYWORDS.md), [`RELATED_WORK.md`](RELATED_WORK.md), [`GITHUB_REPO_TOPICS.md`](GITHUB_REPO_TOPICS.md) |
| Each release, with its permanent DOI and what changed | [`RELEASES.md`](RELEASES.md) |
| Citation scores of this README and four others, with the commit each was scored at | [`CITATION_SCORES.md`](CITATION_SCORES.md) |
| Notes, one idea each | [`notes/`](notes/) and [`SMART_NOTE_POLICY.md`](SMART_NOTE_POLICY.md) |

When you learn a fact that the next session needs, write it in the correct file above, in the
same pull request. Do not write it only in a chat.

## Long-term memory: ai-memory

The long-term memory of closed-source is
[ai-memory](https://github.com/akitaonrails/ai-memory) (Fabio Akita, MIT), adopted on 14
October 2026. The owner's request, and why, are in
[the change proposal](docs/2-engineering/changes/2026-10-14-ai-memory-long-term-memory/proposal.md).

- **What it holds.** What each session did, what failed, what is open, and a handoff to the
  next session or the next agent (Claude Code, Codex and others). Hooks capture it; you do not
  ask it to remember.
- **What it does not hold.** The record. A rule, a decision or a fact that a reader needs goes
  into the files in the table above, in the same pull request, as before. The wiki of ai-memory
  lives on the owner's machine, and nobody who reads this repository sees it.
- **The plugin.** The Claude Code plugin is `ai-memory@ai-memory`, from the marketplace
  `akitaonrails/ai-memory`, pinned to the tag `v3.0.0`. The owner enables it in
  `.claude/settings.json` (the change proposal's `delta.md` has the lines). Without the
  ai-memory binary, the plugin captures nothing: it says so once when the session starts and
  does not block the session. A new version is a change to the pin, in a pull request.
- **The install, once for each machine, by the owner** (ai-memory's `README.md`, "Quick start"):

  ```bash
  curl -fsSL https://github.com/akitaonrails/ai-memory/releases/latest/download/install.sh | sh
  ai-memory setup --agent claude-code
  ```

  `setup` shows its plan and asks first. Restart Claude Code, then run `/ai-memory:status`.
- **Nothing leaves the machine by default.** Keep it that way: leave `embedding_provider` on
  `local`, do not turn on assistant capture, and do not set `AI_MEMORY_RERANKER=llm`
  (ai-memory's `DATA_HANDLING.md`). The capture includes what a session reads, so a private
  source that a session opens is in the wiki on the owner's machine.
- Notes about ai-memory and its author come later, from the owner.

## Code graph: graphify

To find "where is X" in the code, use graphify, as h0ffmann/picasso does. Run it with
`just viz` (build the graph and print the path of `graph.html`), then `just viz query "<q>"`,
`just viz path <a> <b>` or `just viz explain <x>`. The recipe runs picasso's `viz` lab from the
`forks/picasso` submodule, and `.graphifyignore` keeps the forks and the build outputs out of the graph. graphify builds a graph
of the code and answers questions about it. Use it in the picasso way: code only, with no API key,
no model and no network, and with the graph outside the checkout.

- How picasso uses it, and why: [picasso `AGENTS.md`, "Vendored skills"](https://github.com/h0ffmann/picasso/blob/2d6f8d8/AGENTS.md#vendored-skills).
- The recipe, `just graphify build | query "<q>" | path <a> <b> | explain <x>`:
  [picasso `justfile`](https://github.com/h0ffmann/picasso/blob/2d6f8d8/justfile#L55-L71).
- The files it does not read: [picasso `.graphifyignore`](https://github.com/h0ffmann/picasso/blob/2d6f8d8/.graphifyignore).
- The graph goes to `~/.cache/marola-graph/<repo>`, never into the checkout. Answers are capped
  with `--budget 400`.
- Do not use the `/graphify` skill or `graphify install`. Their LLM pass over the documents costs
  about 0.6M tokens, and they install a second copy with `pip` or `uv`.
- graphify reads scripts and code, not prose. For the book and the paper, read
  `50THINKERS.md`, `papers/<slug>/` and `notes/` directly.

What the graph covers, measured on 13 October 2026 with graphify 0.9.88:

- The code graph is small: 14 nodes from 5 files (`scripts/release.sh`, `tools/fabric`,
  `tools/src/fabric_ffi.erl` and the site's two `.mjs` files). graphify has no parser for Gleam,
  so the 38 `.gleam` files of `tools/` and `site/` are not in it. For Gleam code, use `grep` and
  the module list in `tools/src/fabric/cli.gleam`.
- `fabric_ffi.erl` adds nothing until the lab installs graphify's `erlang` extra.
- `.graphifyignore` also keeps out `CLAUDE_PROJECT.md` (the hard rule in AGENTS.md), the licence
  texts, Ouroboric's docs copied as is, and the two renderings of `prose/`. With them, a document
  pass reads 85 files and 50,000 words, not 118 files and 79,000 words.
- One document pass was run with the `/graphify` skill at the owner's request, against the rule
  above: 832 nodes, 62 communities, about 745,000 tokens. It is at
  `~/.cache/marola-graph/closed-source-docs/` on the owner's machine. It showed that a concept
  named in several files becomes one node for each file, so the three editions of the paper
  tripled its concepts.

graphify is in the code-graph routing part of [`OUROBORIC_RESEARCH.md`](OUROBORIC_RESEARCH.md)
(section 2.7), with its upstream, [Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify).
