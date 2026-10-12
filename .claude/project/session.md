# The session

| Item | Value |
|---|---|
| Harness | Claude Code, running as a thread session of a Claude project, in a cloud container |
| Model | Claude Opus (the configured model; the exact serving model can differ per turn) |
| Date | 2026-10-12 |
| Working rules | the harness's project protocol (reply in the thread, keep a status checklist, act on reversible work without asking, confirm irreversible steps) and the brief in `brief.md` |
| Permission mode | auto |

## Repositories read

| Repository | Access | Why |
|---|---|---|
| h0ffmann/closed-source | push | this repository (empty before this pull request) |
| h0ffmann/ww3-gpu | read | Zenodo release workflow, `CITATION.cff`, pandoc build |
| h0ffmann/picasso | read | `scripts/citation.py` (copied), `.zenodo.json`, citation workflow |
| marola-dev/marola | read | authors' names and ORCIDs from `.zenodo.json` |
| h0ffmann/chemo-rx | read | facts for the Chemo-RX section |
| ouroboric-dev/ouroboric, asgard, .github | read | charter, docs standard, writing styles, journal, readiness checklist, PR template |
| isovector/thinking-with-types, algebra-driven-design, certainty-by-construction | read | the Makefile, pandoc and XeLaTeX layout mirrored here |

## Toolchain installed in the container

TeX Live XeLaTeX from Debian packages, pandoc 3.1.3 (preinstalled), pandoc-crossref 0.3.16.0 from
its GitHub release. `scripts/setup-toolchain.sh` reproduces this.

## Web sources

Every reference was fetched with the session's web tools; the log is in
[`papers/closed-source/REFERENCES.md`](../../papers/closed-source/REFERENCES.md). Crossref and
Zenodo rate-limited some checks; the log says which.
