---
title: Releasing a paper
status: draft
date: 2026-10-12
related: [paper-fabric.md, ../../.zenodo.json]
style: procedure
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Releasing a paper

The README's "Release" section is the short checklist. This page gives the reasons.

v0 policy: Zenodo archives **only the rendered PDF**. arXiv receives the LaTeX source, because
arXiv compiles submissions itself and refuses PDFs made from TeX.

## Once per repository

1. On zenodo.org, keep the GitHub integration **off** for this repository. It archives source, not
   the PDF.
2. Create a Zenodo personal access token with scopes `deposit:write` and `deposit:actions`.
3. Store it as the repository secret `ZENODO_TOKEN`.
4. Rehearse on sandbox.zenodo.org first: `ZENODO_SANDBOX_TOKEN=<sandbox token> just zenodo-sandbox 0.0.1`.

The README's "Secrets and keys" table lists every token and key, where it lives and how to get it.

## Each release

1. Merge the release's pull request to `main`. Check that the `pdf` and `citation` workflows pass.
2. Run `just release 0.1.0 --dry-run`, then `just release 0.1.0`. The tag is signed when
   `git config user.signingkey` is set.
3. Wait for the `release` workflow. It attaches the PDF to the GitHub release and creates a
   Zenodo draft.
4. Open the draft on zenodo.org. Check the metadata, the authors and that the only file is the
   PDF.
5. Press Publish. **Caution:** a published DOI is permanent.
6. After the first publication, put the concept DOI in `scripts/citation.py` (`CONCEPT_DOI`) and
   run `just citation`. Store the concept record id (the number in the concept DOI) as the
   repository variable `ZENODO_CONCEPT_RECID`, so later releases become new versions of the same
   record.

## arXiv

**Caution:** since 31 October 2025, arXiv's computer-science category accepts review articles and
position papers only after they pass peer review at a journal or conference, with the journal
reference and DOI in the submission ([arXiv blog](https://blog.arxiv.org/?p=1740)). A v0 position
paper will be put on hold. Submit to arXiv after acceptance, or choose a non-CS category only if
the paper genuinely belongs there.

1. Run `just arxiv`. It writes `build/arxiv/<slug>.tar.gz` (the single `.tex` file, with
   citations already rendered and the Git revision frozen) and `build/arxiv/<slug>.txt` (title,
   authors, categories, licence, comments and abstract for the form). It fails if the bundle does
   not compile with pdfLaTeX, the engine arXiv uses, or if the abstract exceeds 1,920 characters.
2. The `release` workflow attaches both files to the GitHub release.
3. On arxiv.org, start a new submission. The submitter needs an endorsement for the primary
   category (`cs.CY`) on a first submission there.
4. Choose the licence from `metadata.md` (`arxiv.license`, CC BY 4.0), upload the tarball, and
   paste the fields from the `.txt` file.
5. Check arXiv's compiled preview against `pdf/<slug>.pdf` before you submit.
6. After the paper is announced, add `https://arxiv.org/abs/<id>` to `.zenodo.json` as a
   related identifier with relation `isVariantFormOf` and scheme `url`, then run `just citation`.
