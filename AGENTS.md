# AGENTS.md

This repository is Paper Fabric and the papers it builds. It is a map, not a manual. Read the
linked docs before you change what they cover.

## Map

- Papers: `papers/<slug>/` holds `metadata.md`, `prose/NN-*.md`, `refs.bib` and `REFERENCES.md`.
- Build: `make`, `make check`. Toolchain: `scripts/setup-toolchain.sh`.
- Charter and direction: `docs/1-product/charter.md`.
- How a paper is made: `docs/4-ways-of-working/paper-fabric.md`.
- Ouroboric conventions used here: `docs/4-ways-of-working/ouroboric-patterns.md`.
- Release and Zenodo: `docs/4-ways-of-working/releasing.md`.
- Known gaps: `docs/1-product/readiness/`.

## Invariants

1. Humans steer, agents build. Do not change a paper's thesis, authors or conclusions without a
   human-approved task.
2. Never invent a reference. Fetch every source before you cite it. Record the check in the
   paper's `REFERENCES.md`. If you cannot fetch a source, do not cite it; mark the claim
   unverified instead.
3. Never invent an author's experience. Write `**[AUTHOR ANECDOTE: ...]**` and leave it for the
   author.
4. Mark interpretation with `**[ANALYSIS]**`. Keep facts and analysis in separate paragraphs.
5. Report allegations as allegations. Name the source and the status of any legal case.
6. Never publish a Zenodo deposit. Drafts only; a human publishes. A DOI is permanent.
7. Never commit secrets, tokens or personal contact data.

## Borrow, cite, propagate

1. **Borrow** only what the licence allows. Read the licence first and record it. Keep the
   original SPDX line on copied files.
2. **Cite** at the point of use, with a DOI when one exists, else a URL with a commit hash.
3. **Propagate** credit: add borrowed works to `refs.bib`, and to `.zenodo.json`
   `related_identifiers` with `cites` or `isDerivedFrom`.

## Writing

- A paper's ASD-STE100 text is `papers/<slug>/prose-ste/`. If you change a fact in `prose/`,
  change it in `prose-ste/` in the same pull request. Use `/ste100` and log the pass in
  `papers/<slug>/STE100.md`.

- Style: `research` for papers (Ouroboric writing styles), `agent-facing` for this file.
- Short sentences. Active voice. No undefined jargon. Numbers over adjectives.
- Every doc has front matter: `title`, `status`, `date`, `related`, optional `style`.

## Checks before a pull request

1. `make check` passes with no pandoc warning.
2. `python3 scripts/citation.py --check` passes.
3. New references have a `verified` or `partial` row in `REFERENCES.md`.
