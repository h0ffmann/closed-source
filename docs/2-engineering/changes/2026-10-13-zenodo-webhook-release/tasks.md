---
title: "Release with Zenodo's webhook: tasks"
status: draft
date: 2026-10-13
related: [proposal.md, delta.md]
style: procedure
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Tasks

1. This pull request: the guard in `scripts/release.sh` and `release.yml`, the draft step
   removed, the concept DOI in `citation.gleam`, `.zenodo.json`, and the rules and docs in
   [delta.md](delta.md).
2. The owner, on zenodo.org: correct the v0.1.0 record
   ([10.5281/zenodo.23333657](https://doi.org/10.5281/zenodo.23333657)). Its description and
   notes say that it holds only the rendered PDF; it holds the source archive. An agent does not
   edit a Zenodo record.
3. A second pull request: the paper's section 7 (`prose/07-paper-fabric.md`, with `prose-ste/`
   and `prose-pt-BR/` in the same pull request) and the website's release sentence
   (`site/src/closed_source_site/app.gleam`) still say that a person publishes a Zenodo draft.
   The owner approves the new wording first: it is the paper's text.
4. The owner decides: keep `tools/fabric zenodo-upload` and the `just zenodo-draft`,
   `zenodo-sandbox` and `zenodo-dry-run` recipes for a deposit made by hand, or remove them.
5. The next release, by the owner: `just release` and then the suggested bump. Zenodo mints the
   new version under the concept DOI.
