---
title: Ready for ai-memory as the long-term memory — assessment 2026-10-14
status: draft
date: 2026-10-14
related: [../../2-engineering/changes/2026-10-14-ai-memory-long-term-memory/proposal.md, ../../../MEMORY.md, "https://github.com/akitaonrails/ai-memory/tree/v3.0.0"]
style: direction
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Ready for ai-memory as the long-term memory — assessment 2026-10-14

**Bottom line: not adopted yet.** Today the long-term memory of closed-source is files on
GitHub: `MEMORY.md` and the files it lists. ai-memory is chosen
([the change proposal](../../2-engineering/changes/2026-10-14-ai-memory-long-term-memory/proposal.md)),
but nothing runs: no server is installed, the plugin is not enabled, and the store is empty.
Most of the blocking work is manual and is the owner's, because it happens on the owner's
machine. Each item says who closes it.

Sources: ai-memory at tag `v3.0.0`: `README.md`, `DATA_HANDLING.md`, `INSTALL_FOR_AGENTS.md`,
`docs/cookbook.md`, `docs/usage.md`, `docs/marker-file.md`, `docs/backup.md`,
`companions/ai-memory-wikisync/README.md` and `companions/ai-memory-importer/README.md`, read
on 14 October 2026. Nothing below was run.

## What "full adoption" means

1. Every Claude Code session in this repository is captured, and the next session starts with a
   brief and a handoff.
2. The memory that is on GitHub today is in ai-memory too, as pages that a search finds (the
   reindex, B5).
3. Nothing leaves the owner's machine without a decision.
4. The wiki has a backup outside the machine.
5. The files on GitHub stay the public record. The [change proposal](../../2-engineering/changes/2026-10-14-ai-memory-long-term-memory/proposal.md)
   says why: a reader of this repository does not see the wiki.

## Blocking issues

Do them in this order: the plugin before `setup`, because `setup` leaves Claude's settings
alone when the plugin is enabled (the plugin's `README.md`), so the hooks are not installed
twice.

| # | Issue | What to do | Closed by |
|---|---|---|---|
| B1 | **The plugin is not enabled.** | Add to `.claude/settings.json` the lines in the proposal's [`delta.md`](../../2-engineering/changes/2026-10-14-ai-memory-long-term-memory/delta.md): the marketplace `akitaonrails/ai-memory` at `ref: v3.0.0`, and `enabledPlugins: {"ai-memory@ai-memory": true}`. An agent was not allowed to make this edit. | owner |
| B2 | **No binary and no server.** | On the owner's machine: `curl -fsSL https://github.com/akitaonrails/ai-memory/releases/download/v3.0.0/install.sh \| AI_MEMORY_VERSION=3.0.0 sh` (without the variable, the script installs the latest release), then `ai-memory setup --agent claude-code`. `setup` shows its plan and asks first. It makes the data directory with an owner-only token and starts a per-user systemd service on `127.0.0.1`. Then check `ai-memory --version` says 3.0.0. Add `--agent codex` (or another) for each other agent that works here. | owner |
| B3 | **The scope and the exclusions are not set.** | Without a marker, the project name comes from the `origin` remote (`h0ffmann/closed-source`), which is right. A marker is still needed for exclusions: `.ai-memory.toml` at the root, with `[capture]` and `ignore_paths`. Candidates: `CLAUDE_PROJECT.md` (no agent reads it; AGENTS.md), `build/**`, `pdf/**`. Exclusions are "best-effort" for shell commands (`docs/marker-file.md`). The owner chooses the list; an agent then commits the file. | owner decides; agent commits |
| B4 | **The paths that send data out are not confirmed off.** | In `~/.config/ai-memory/config.toml` (or `ai-memory status`): `embedding_provider` is `local`, assistant capture is off, and `AI_MEMORY_RERANKER` is not `llm` (`DATA_HANDLING.md`). Set no `AI_MEMORY_LLM_PROVIDER` unless you decide that a provider may read the sessions. | owner |
| B5 | **The memory on GitHub is not in ai-memory: the reindex.** | Three steps, after B1 to B4. **(a)** `ai-memory backfill --dry-run`, then `ai-memory backfill`. It imports the earlier Claude Code sessions of this project, once, into an empty store (`docs/cookbook.md`). Those sessions include what they read, private sources too; it stays on the machine. **(b)** Seed one pinned page for each file in the table below, with `ai-memory write-page` or the `memory_write_page` tool, in a session where the plugin works. A page holds a short summary and the link to the file at its commit, not a copy. The file stays the source. **(c)** Do not drop files into the wiki directory by hand: `reindex` needs a clean derived database (`docs/usage.md`). | an agent, in a session the owner starts |
| B6 | **Nothing is verified.** | `/ai-memory:status` in Claude Code, and `ai-memory doctor`, which must say that the session was captured. Then ask, in a new session, three facts that only the seeded pages hold: the book's page count (100), who edits `NAGORI.md` (the owner only), and the concept DOI (10.5281/zenodo.23333656). End a session in the middle of a task and check that the next one starts with its handoff. | owner, with an agent |

### What the reindex seeds (B5 b)

| ai-memory page family | From these files |
|---|---|
| `_rules/` | `AGENTS.md`: the invariants and each hard rule, one page each |
| `decisions/` | `docs/2-engineering/changes/*/proposal.md`, one page for each change |
| `procedures/` | `docs/4-ways-of-working/releasing.md`, `paper-fabric.md`, `md-quality.md`, `ouroboric-patterns.md` |
| `concepts/` | `RELEASES.md`, `KEYWORDS.md`, `RELATED_WORK.md`, `GITHUB_REPO_TOPICS.md`, `ISSUE_LABELS.md`, `PERSONAS.md` (the aliases only, no real name) |
| `notes/` | `notes/*.md`, one page for each note, with its id |
| — | `.claude/project/request.md`: one page that says where the owner's requests are |

Not seeded: `CLAUDE_PROJECT.md` (the hard rule in AGENTS.md); `NAGORI.md`, unless the owner
says so; anything of the private `h0ffmann/nagori`.

## Non-blocking issues

| # | Issue | What to do | Closed by |
|---|---|---|---|
| N1 | **No backup outside the machine.** | The wiki directory is a git repository (`docs/backup.md`). Push it to a **private** remote, for example a private GitHub repository. Then the long-term memory is on GitHub again, privately. It must be private, because the capture holds what the sessions read. Also: `ai-memory backup --to <tarball>`. | owner |
| N2 | **The repository does not mirror the wiki.** | `ai-memory-wikisync` can export allowlisted families (`_rules`, `decisions`) into a directory here, dry-run first, and it never runs git. Its CI check needs a server that the runner can reach, which a laptop is not. So it would be a local `post-merge` hook at most. Decide whether the mirror is needed, since the files are already the record. | owner |
| N3 | **Upgrades.** | A new version is a pull request that changes the `ref` in `.claude/settings.json`, then `ai-memory upgrade` on the machine. v3.0.0 was released on 14 October 2026, the day of this assessment. | owner; agent for the pull request |
| N4 | **Notes about Akita.** | The owner's: "notes about akita later". | owner |
| N5 | **No measure of the gain.** | After a month: a note on what the memory gave, what it missed, and whether `MEMORY.md` should change again. | agent, with the owner |

## Done when

B1 to B6 are closed, N1 is closed or refused in writing, and `MEMORY.md` says that ai-memory
*is* the long-term memory, not that it will be.
