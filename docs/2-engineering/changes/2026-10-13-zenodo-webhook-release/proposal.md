---
title: "Release with Zenodo's webhook, as marola does"
status: draft
date: 2026-10-13
related: [../README.md, delta.md, tasks.md, ../../../4-ways-of-working/releasing.md, ../../../../scripts/release.sh, ../../../../.github/workflows/release.yml]
style: research
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Release with Zenodo's webhook, as marola does

**Decision pending.** The owner asked for this change (Hoffmann, 13 October 2026). Merging the
pull request that carries this proposal is the decision; the owner then writes
`**Decided YYYY-MM-DD:** ...` here.

## Why

The owner asked to see how `just release` works in marola-dev/marola and to copy that pattern to
this repository, with the Zenodo DOI minted by the release (Hoffmann, 13 October 2026). The
method is Ouroboric's Read, Evaluate, Adopt.

The repository's rules and its state had also come apart:

- AGENTS.md invariant 6, the charter and `release.yml` said that Zenodo's GitHub webhook stays
  off, that CI uploads only the PDFs to a Zenodo draft with `ZENODO_TOKEN`, and that a person
  publishes the draft.
- The webhook was switched on for this repository on 13 October 2026 at 03:27 UTC (GitHub
  repository hook 696472794, event `release`). `ZENODO_TOKEN` was never set.
- `just release minor` tagged v0.1.0 the same day. The `release` workflow skipped the draft
  ("ZENODO_TOKEN is not set"), published the GitHub release at 06:18 UTC, and Zenodo's webhook
  archived it. The record is [10.5281/zenodo.23333657](https://doi.org/10.5281/zenodo.23333657),
  under the concept DOI [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656). It
  holds `h0ffmann/closed-source-v0.1.0.zip`, the source tree, and no PDF.

So the first release already follows marola's chain. This proposal makes the rules, the workflow
and the docs say what the release does.

## Read: marola's pattern

Source: marola-dev/marola at `cf7bd4f`, files `scripts/release.sh`,
`.github/workflows/release.yml` and `.claude/skills/zenodo-release/SKILL.md` (its MIP-0079).

1. `just release X.Y.Z` tags `main` and pushes the tag. It refuses unless `main` is clean and
   level with `origin/main`, the tag is new and the citation check passes. `--dry-run` is the
   rehearsal.
2. `release.yml` reruns the citation check and turns the tag into a published GitHub release,
   with `GITHUB_TOKEN` only.
3. Zenodo's webhook archives the release with `.zenodo.json` from the tagged commit and mints a
   version DOI under one concept DOI. No secret is stored.
4. A guard, `scripts/release.sh --guard`, refuses a release whose only change since the previous
   `v*` tag is a submodule pointer. The script and the workflow both run it.
5. `.zenodo.json` is the only citation file edited by hand. The concept DOI, never a version DOI,
   goes in the README and `CITATION.cff`.
6. An agent does not tag or release; the maintainer does.

## Evaluate: against this repository

| marola | Here | Verdict |
|---|---|---|
| Webhook mints the DOI, no secret | Webhook already on; v0.1.0 minted this way | adopt |
| `release.yml` publishes the GitHub release | The same, plus the PDFs and the arXiv bundle attached | keep ours |
| Pointer guard | `forks/` holds eight shallow submodules | adopt |
| `just release X.Y.Z` | `just release`, `patch`, `minor`, `major` or a version; signed tag | keep ours |
| `.zenodo.json` by hand, the rest generated | The same, in `tools/fabric citation` | already here |
| Agent does not release | Invariant 6 forbade publishing a deposit | adopt, reworded |
| Record holds the source archive | v0 policy was "only the rendered PDF" | changes, see below |

**[ANALYSIS]** What is lost: the Zenodo record no longer holds the PDF, and no person reviews a
draft before the DOI exists. What is gained: one command, no token to keep or leak, the same
chain in every repository the owner releases, and a record that holds what a reader needs to
rebuild the paper. The PDFs stay public on the GitHub release of the same tag.

**[ANALYSIS]** The draft step cannot stay beside the webhook. With `ZENODO_TOKEN` set, each
release would make two records with two DOIs for one version.

## Adopt: what changes

- `scripts/release.sh`: marola's `--guard` and its self-test; the header and the last message
  say that Zenodo mints the DOI.
- `.github/workflows/release.yml`: the guard step is added and the Zenodo draft step is removed.
- `tools/src/fabric/citation.gleam`: `concept_doi` is the concept DOI of the first release;
  `just citation` regenerates `CITATION.cff` and the README's citation block.
- `.zenodo.json`: the description and the notes no longer say the record holds only the PDF.
- AGENTS.md invariant 6, the charter, the README, `releasing.md`, `paper-fabric.md` and
  `ISSUE_LABELS.md`: see [delta.md](delta.md).

## Not in this pull request

See [tasks.md](tasks.md): the paper's section 7 in its three editions and the website still
describe the draft; `tools/fabric zenodo-upload` is kept; and the v0.1.0 record on Zenodo still
says it holds only the PDF.
