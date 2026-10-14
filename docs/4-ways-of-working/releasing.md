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

<!-- minted:start -->
The latest release is v0.3.0, with the version DOI
[10.5281/zenodo.23349831](https://doi.org/10.5281/zenodo.23349831). The concept DOI, which always resolves to the latest version, is
[10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656). [`RELEASES.md`](../../RELEASES.md) lists every release.
<!-- minted:end -->

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
6. Write the report: `just minted --wait`, then open its pull request. The next section says
   what that does.

## The daily release (`perma-doi.yml`)

The owner asked for it on 14 October 2026: every day at 18:00 in Brasília (21:00 UTC), the
`perma-doi` workflow runs `just release patch` (`scripts/release.sh`) from GitHub Actions, when
`main` has commits since the latest `v*` tag. A day with nothing new makes no release, because
every release is a permanent DOI.

- A tag pushed with `GITHUB_TOKEN` starts no workflow, so `perma-doi.yml` calls `release.yml`
  itself (`workflow_call`, with the tag). `release.yml` runs its checks, builds the PDFs and
  publishes the release; Zenodo's webhook mints the DOI, as it did for v0.1.0, which
  `release.yml` published with `GITHUB_TOKEN`.
- "Run workflow" in the Actions tab runs it on demand. Its `dry_run` box is ticked by default: it
  runs every check and prints the tag it would cut, without tagging.
- After a daily release, `just minted` still writes it into the repository, in a pull request.

## The report after a release

A release cannot name its own DOI: Zenodo mints it after the tag. So each release is followed by
one pull request that says "vX.Y.Z is live" and puts the new DOI wherever the latest release is
named. One command writes it, the same way each time, so nobody has to remember the places.

```sh
just release X.Y.Z          # 1. tag and push; the `release` workflow publishes the GitHub release
git switch -c docs/vX.Y.Z-live
just minted --wait          # 2. wait until Zenodo has the DOI, then write it into the repository
git diff                    # 3. read what it wrote
just check                  # 4. the same gate as any pull request
git add -u && git commit -m "docs(release): vX.Y.Z is live"
git push -u origin docs/vX.Y.Z-live
scripts/minted.sh --pr-body | gh pr create --title "docs(release): vX.Y.Z is live" --body-file -
```

What `scripts/minted.sh` writes, and from where:

| It writes | From |
|---|---|
| `RELEASES.md`: the "is live" line and one row for each release | the Git tags, Zenodo's version DOIs, the pull requests merged between tags |
| `RELEASES.md`: removes "Next: vX.Y.Z" when that version is released | the latest tag |
| `README.md`: the version DOI badge, the status line, the two-DOI table's row | the latest tag and its DOI |
| `README.easy.pt-BR.md`: the same two places, then the stamp | the same |
| this page: the paragraph that names the latest release | the same |
| drafts in `docs/social/`: the version they announce | the previous and the latest tag |

What it does not write, because a person or an agent must read an index first: the date of
record in [`RELATED_WORK.md`](../../RELATED_WORK.md) and [`KEYWORDS.md`](../../KEYWORDS.md). The
website needs no change: its next build asks Zenodo for the version DOIs.

It stops, and changes nothing more, when a line it expects is not there. That means a page
changed shape: fix the pattern in the script in the same pull request.

**The loop is not closed yet.** A person still runs step 2 and opens the pull request. The
`release` workflow could do it: wait for Zenodo, run the script, open the pull request. Two
things stand in the way, and both are the owner's to decide: the repository's setting "Allow
GitHub Actions to create and approve pull requests" is off, and a pull request opened by a
workflow would be one that no person asked for.

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
