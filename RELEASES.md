---
title: "Releases"
status: draft
date: 2026-10-13
related: [docs/4-ways-of-working/releasing.md, README.md, CITATION.cff]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Releases

Each release of this repository, newest first, with its permanent DOI. The latest DOI,
[10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656), always opens the newest one.
A release cannot name its own DOI, because Zenodo mints it a few minutes after the tag. So the
row of a release is added in a pull request after it, by one command
([releasing](docs/4-ways-of-working/releasing.md), "The report after a release").

<!-- releases:start -->
<!-- releases:end -->

The block above is written by `just minted` (`scripts/minted.sh`) after each release: the "is
live" line and one row for each Git tag, with Zenodo's DOI for it and the pull requests merged
since the version before. Do not edit it by hand. Notes that a script cannot write go below.

## Next: v0.3.0 (not released yet)

The next release's changes (#44, #45 and the pull request that adds `just md-quality`):

- on Zenodo the record is a **book**, not a preprint (`publication_type` in `.zenodo.json`); the
  generated citations follow: CFF `type: book`, BibTeX `@book`, APA "[Book]";
- the website publishes the paper as `paper.pdf`, a name that does not change, and shows a
  preview of it in "Read"; the Zenodo record and the READMEs link to that preview;
- the record's description names the writer's three other works with their DOIs (marola,
  WW3 GPU Lab, picasso) and says whose the Ouroboric ideas are;
- the record's ties add `requires` picasso and `cites` nashkell (#44), and `references` Hoppe's
  *Democracy: The God That Failed* by its publisher's DOI;
- the record's description starts with the book as a PDF: the link to read it and the link to
  download it;
- three analysers check the Markdown files (`just md-quality`), and a badge in the README says
  if every link is alive; two more count the links to GitHub and to Zenodo.

After the merge, the owner releases it: `just release minor`. When Zenodo has minted the DOI,
this section becomes a row of the table below.

## v0.2.1: on GitHub, with no DOI

v0.2.1 was tagged and released on GitHub on 13 October 2026
([release](https://github.com/h0ffmann/closed-source/releases/tag/v0.2.1)): the lower-case tile,
the commits box, the GitHub pill and the new keywords (#41 to #43). GitHub's two deliveries of
that release to Zenodo's webhook failed with a 500, so Zenodo made no record and minted no DOI
for it. Read on 13 October 2026: Zenodo lists v0.2.0 and v0.1.0 only. v0.3.0 carries the same
changes; if the owner redelivers the v0.2.1 delivery (Settings, Webhooks), it gets its own row.

## Notes

- The paper's text did not change between v0.1.0 and v0.2.1: the three PDFs have the same prose.
- Each record holds the source archive of its tag; the PDFs are on the GitHub releases.
- v0.2.1 is the first record with the keywords chosen for reverse engineers
  ([`KEYWORDS.md`](KEYWORDS.md)).

- The v0.1.0 record on Zenodo still says that it holds only the rendered PDF. That was the
  policy when its metadata was written; the owner can correct it on zenodo.org.
