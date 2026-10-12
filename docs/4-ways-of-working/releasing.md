---
title: Releasing a paper
status: draft
date: 2026-10-12
related: [paper-fabric.md, ../../.zenodo.json]
style: procedure
---

# Releasing a paper

v0 policy: Zenodo archives **only the rendered PDF**.

## Once per repository

1. On zenodo.org, keep the GitHub integration **off** for this repository. It archives source, not
   the PDF.
2. Create a Zenodo personal access token with scopes `deposit:write` and `deposit:actions`.
3. Store it as the repository secret `ZENODO_TOKEN`.
4. Rehearse on sandbox.zenodo.org first: run `ZENODO_URL=https://sandbox.zenodo.org
   ZENODO_TOKEN=<sandbox token> scripts/zenodo_upload.py pdf/closed-source.pdf --version v0.0.1`.

## Each release

1. Merge the release's pull request to `main`. Check that the `pdf` and `citation` workflows pass.
2. Run `scripts/release.sh 0.1.0 --dry-run`, then `scripts/release.sh 0.1.0`.
3. Wait for the `release` workflow. It attaches the PDF to the GitHub release and creates a
   Zenodo draft.
4. Open the draft on zenodo.org. Check the metadata, the authors and that the only file is the
   PDF.
5. Press Publish. **Caution:** a published DOI is permanent.
6. After the first publication, put the concept DOI in `scripts/citation.py` (`CONCEPT_DOI`) and
   run `make citation`. Store the concept record id (the number in the concept DOI) as the
   repository variable `ZENODO_CONCEPT_RECID`, so later releases become new versions of the same
   record.
