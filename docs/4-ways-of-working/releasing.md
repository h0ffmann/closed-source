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

Policy: every published GitHub release is archived by Zenodo's GitHub webhook, which mints a
version DOI under one concept DOI. The pattern is marola's
([`scripts/release.sh`](https://github.com/marola-dev/marola/blob/cf7bd4f/scripts/release.sh) and
[`release.yml`](https://github.com/marola-dev/marola/blob/cf7bd4f/.github/workflows/release.yml),
its MIP-0079), adopted here by the change proposal
[2026-10-13-zenodo-webhook-release](../2-engineering/changes/2026-10-13-zenodo-webhook-release/proposal.md).
The Zenodo record holds the source tree at the tag. The rendered PDFs are attached to the GitHub
release. arXiv receives the LaTeX source, because arXiv compiles submissions itself and refuses
PDFs made from TeX.

The latest release is v0.2.0, with the version DOI
[10.5281/zenodo.23335204](https://doi.org/10.5281/zenodo.23335204). The first, v0.1.0, has
[10.5281/zenodo.23333657](https://doi.org/10.5281/zenodo.23333657). The concept DOI, which always
resolves to the latest version, is
[10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656).
[`RELEASES.md`](../../RELEASES.md) lists every release.

## Once per repository

1. On zenodo.org, log in with GitHub and switch this repository **on** (your account menu →
   GitHub). Zenodo then adds a webhook to the repository. No token is stored in GitHub.
2. Keep `ZENODO_TOKEN` **unset** as a repository secret. Nothing in the release reads it.

The README's "Secrets and keys" table lists every key, where it lives and how to get it.

## Each release

1. Merge the release's pull request to `main`. Check that the `pdf` and `citation` workflows pass.
2. Run `just release` to see what is unreleased and the suggested bump. Then run
   `just release minor --dry-run` (or `patch`, `major`, or a version such as `0.2.0`), then the
   same without `--dry-run`. The tag is signed when `git config user.signingkey` is set. The dry
   run is the rehearsal: there are no `-rc` tags, because each archived release is a permanent
   DOI.
3. Wait for the `release` workflow. It reruns the checks and the pointer guard, builds the PDFs
   and the arXiv bundle, and publishes the GitHub release with them attached.
4. Wait a few minutes for Zenodo. Its webhook archives the release with `.zenodo.json` from the
   tagged commit. **Caution:** the DOI is permanent.
5. Open the new version on zenodo.org and check the metadata. An edit to `.zenodo.json` reaches
   Zenodo only with the next release; a wrong field on a published version is corrected by hand
   on zenodo.org.
6. Open a pull request that adds the release to [`RELEASES.md`](../../RELEASES.md) with its
   version DOI, and updates the places that name the latest release: the README's badge and its
   DOI table (and the easy version, with `scripts/readme.sh --stamp`), this page, and any open
   draft in `docs/social/`. Read the new record's ties and keywords back from DataCite and set
   the date of record in [`RELATED_WORK.md`](../../RELATED_WORK.md) and
   [`KEYWORDS.md`](../../KEYWORDS.md). The website needs no change: its next build asks Zenodo for the
   version DOIs.

## Rules the release keeps

- **`.zenodo.json` is the only citation file edited by hand.** `just citation` generates
  `CITATION.cff` and the README's citation block from it, and the check fails on drift.
- **A submodule pointer move never makes a Zenodo version.** `scripts/release.sh --guard` refuses
  a release whose only change since the previous `v*` tag is a pointer under `forks/`.
  `just release` runs it, and `release.yml` runs it again, so a tag pushed by hand is caught too.
- **Cite the concept DOI**, never a version DOI, in the README and in `CITATION.cff`
  (`concept_doi` in `tools/src/fabric/citation.gleam`).
- **An agent does not release** unless the owner asks for that release by name (AGENTS.md,
  invariant 6).

## A deposit made by hand

`tools/fabric zenodo-upload`, with `just zenodo-draft`, `just zenodo-sandbox` and
`just zenodo-dry-run`, still uploads PDFs to a Zenodo draft through the deposit API. It is not
part of a release. A draft made with it is a separate record with its own DOI, so do not publish
one for a version that the webhook already archived.

## arXiv

**Caution:** since 31 October 2025, arXiv's computer-science category accepts review articles and
position papers only after they pass peer review at a journal or conference. The submission must
have the journal reference and the DOI ([arXiv blog](https://blog.arxiv.org/?p=1740)). A v0 position
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
