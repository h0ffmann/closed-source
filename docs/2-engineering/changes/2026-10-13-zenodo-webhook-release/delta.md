---
title: "Release with Zenodo's webhook: delta"
status: draft
date: 2026-10-13
related: [proposal.md, tasks.md, ../../../../AGENTS.md, ../../../1-product/charter.md]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Delta

## Modified

**AGENTS.md, invariant 6.**

- Was: "Never publish a Zenodo deposit. Drafts only; a human publishes. A DOI is permanent."
- Is: "A release mints a DOI, and a DOI is permanent: Zenodo's webhook archives every published
  GitHub release. Never tag or release unless the owner asks for that release by name; prepare
  the pull request and give the owner the `just release` command. Never publish a Zenodo deposit
  by hand or through the API."

**Charter, principle 4, "Safe by default".**

- Was: "A Zenodo deposit is a draft until a person publishes it."
- Is: "A release mints a permanent DOI, so only the owner releases, and `just release` refuses a
  `main` that is dirty, behind, or changed only in submodule pointers."

**Charter, boundary.**

- Was: "v0 releases only the rendered PDF on Zenodo. Sources live on GitHub."
- Is: "Zenodo archives the source at each release tag. The rendered PDFs are attached to the
  GitHub release."

## Added

- **A submodule pointer move never makes a Zenodo version.** `scripts/release.sh --guard` refuses
  a release whose only change since the previous `v*` tag is a pointer under `forks/`;
  `release.yml` runs the same guard (`releasing.md`, "Rules the release keeps").
- **Cite the concept DOI**, 10.5281/zenodo.23333656, never a version DOI (`releasing.md`).

## Removed

- "Zenodo's GitHub webhook integration must stay OFF for this repository" (`release.yml`,
  `releasing.md`).
- The `ZENODO_TOKEN` secret and the `ZENODO_CONCEPT_RECID` variable as parts of a release
  (README, "Secrets and keys"; `release.yml`).
