<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# MEMORY.md

The memory of this repository. Project memory in Claude is off for this project, so
what an agent must know in the next session is in files in the repository. This file tells you
where each kind of memory is. Read it after `AGENTS.md`.

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
| Notes, one idea each | [`notes/`](notes/) and [`SMART_NOTE_POLICY.md`](SMART_NOTE_POLICY.md) |

When you learn a fact that the next session needs, write it in the correct file above, in the
same pull request. Do not write it only in a chat.

## Code graph: graphify

To find "where is X" in the code, use graphify, as h0ffmann/picasso does. graphify builds a graph
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

graphify is in the code-graph routing part of [`OUROBORIC_RESEARCH.md`](OUROBORIC_RESEARCH.md)
(section 2.7), with its upstream, [Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify).
