<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# ISSUE_LABELS.md

The label set for the issues and pull requests of closed-source. Every item has one `type/*` and
at least one `area/*`. An open item also has one `status/*` and one `priority/*`. Add `topic/*`
labels when the item is about the topic, so that people who search GitHub for the topic find it.

The shape comes from h0ffmann/picasso's `LABEL.md` (after marola-dev/marola's MIP-0063 §5.2). What
is different: the `area/*` labels are the parts of this repository, and the `topic/*` labels are
the book's keywords.

## type: the kind of change

The same words as the commit subjects (`feat`, `fix`, `docs`, `chore`).

| Label | Colour | Means |
|---|---|---|
| `type/feat` | `#A2EEEF` | A new capability: a thinker, a chapter, a recipe, a script, a page, a workflow |
| `type/fix` | `#D73A4A` | Something that was broken now works |
| `type/docs` | `#0075CA` | Documentation, metadata or prose only |
| `type/chore` | `#C5DEF5` | Pins, bumps and housekeeping, with no change in behaviour |
| `type/refactor` | `#D4C5F9` | The same behaviour in a different shape |
| `type/goal` | `#5319E7` | A tracking issue: an outcome with a "Done when" list, closed by many PRs |

## area: the part of the repository

| Label | Colour | Means |
|---|---|---|
| `area/book` | `#C2E0C6` | The 66 pages: `33THINKERS.md`, `500AUTHORS.md`, `QUOTES.md`, the index and the acronyms |
| `area/paper` | `#C2E0C6` | `papers/`: prose, `refs.bib`, `REFERENCES.md`, the ASD-STE100 text |
| `area/translation` | `#C2E0C6` | The pt-BR edition (`prose-pt-BR/`) and its translation check |
| `area/notes` | `#C2E0C6` | `notes/`: the Zettelkasten and `SMART_NOTE_POLICY.md` |
| `area/site` | `#BFDADC` | `site/`: the Gleam page and GitHub Pages |
| `area/tooling` | `#BFD4F2` | `scripts/`, `tools/`, `justfile`, `flake.nix`, `format/` |
| `area/ci` | `#006B75` | `.github/workflows/` and the CI gate |
| `area/release` | `#FBCA04` | Tags, `CITATION.cff`, `.zenodo.json` and the Zenodo record |
| `area/forks` | `#EDEDED` | `forks/`: the submodules and their upstreams |
| `area/repo` | `#FEF2C0` | README, AGENTS.md, licences, `PERSONAS.md`, `TRADEMARKS.md`, the docs |

## status: the state of an open item

| Label | Colour | Means |
|---|---|---|
| `status/triage` | `#EDEDED` | Not examined yet |
| `status/ready` | `#0E8A16` | Scoped; anyone can start it |
| `status/in-progress` | `#FBCA04` | A PR for it is open, or merged PRs did a part of it |
| `status/needs-human` | `#E99695` | Waits on a decision or an action that only the owner can do: a review, an anecdote, a Zenodo publish |
| `status/blocked` | `#5A5A5A` | Waits on a different issue or PR, which its body names |

## priority

| Label | Colour | Means |
|---|---|---|
| `priority/high` | `#B60205` | Do before the other open work |
| `priority/medium` | `#FF9F1C` | Next, when no high item is open |
| `priority/low` | `#FFF5B1` | When there is time |

## topic: keywords for outreach

These are the keywords of `.zenodo.json` ([`KEYWORDS.md`](KEYWORDS.md)), in groups, so that a GitHub search for a topic finds the issues and
pull requests about it. Use a `topic/*` label only when the item is about that topic. When a
keyword changes in `.zenodo.json`, change its label here.

| Label | Colour | Means |
|---|---|---|
| `topic/open-source` | `#7057FF` | Open source as practice, licence or argument |
| `topic/closed-source` | `#7057FF` | Closed source: secrecy, proprietary software, security through obscurity, the book's subject |
| `topic/reverse-engineering` | `#7057FF` | Reverse engineering, decompilation, binary analysis, obfuscation and AI-assisted reverse engineering |
| `topic/model-extraction` | `#7057FF` | Model extraction and knowledge distillation |
| `topic/trade-secrets` | `#7057FF` | Trade secrets and the law around them |
| `topic/ai-coding-agents` | `#7057FF` | AI coding agents, and the claims made about them |
| `topic/research-software` | `#7057FF` | Research software, software citation, FAIR and persistent identifiers |

## ci: what CI runs

| Label | Colour | Means |
|---|---|---|
| `ci/skip-live-links` | `#E4E669` | Skip the live links workflow on this pull request; main still checks every link. The owner applies it, or asks for it by name |

## GitHub's default labels

GitHub's defaults (`bug`, `enhancement`, `documentation`, …) stay, so that nothing that filters on
them breaks. Do not apply them to new items: use `type/fix`, `type/feat` and `type/docs`.

## Adding a label

Add its row here, then make it with the same name, colour and description:

```console
gh label create "topic/<name>" --color 7057FF --description "<the Means column>"
```
