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
**v0.3.0 is live** (13 October 2026).

| Version | Date | Permanent DOI | Release | Pull requests merged since the version before |
|---|---|---|---|---|
| v0.3.0 | 2026-10-13 | [10.5281/zenodo.23349831](https://doi.org/10.5281/zenodo.23349831) | [GitHub](https://github.com/h0ffmann/closed-source/releases/tag/v0.3.0), [Zenodo](https://zenodo.org/records/23349831) | feat(site): a CI card with the state of each check, and the thinkers drawn again (#47); ci(md): .md / quality: three Markdown analysers, link badges, and the record names Hoppe's book (#46); feat(release): v0.3.0: the record is a book, with a PDF preview and the writer's open works (#45); docs(release): the record names every work of the writer that the paper cites (#44) |
| v0.2.1 | 2026-10-13 | not minted | [GitHub](https://github.com/h0ffmann/closed-source/releases/tag/v0.2.1) | promotion and self promotion (essay) (#43); v0.2.1: a GitHub pill on the site's cover and at the top of the README (#42); feat(site): the closed-source tile in lower case; a commits box beside the pages and the notes (#41); docs(release): v0.2.0 is live; RELEASES.md; and the Ouroboric tile on the site (#38) |
| v0.2.0 | 2026-10-13 | [10.5281/zenodo.23335204](https://doi.org/10.5281/zenodo.23335204) | [GitHub](https://github.com/h0ffmann/closed-source/releases/tag/v0.2.0), [Zenodo](https://zenodo.org/records/23335204) | essays: citation (#35); chore(viz): keep CLAUDE_PROJECT.md, copies and renderings out of the graph; what the graph covers (#33); feat(site): a DOIs section with a large clickable tile for each of the four works (#34); feat(release): Zenodo's webhook mints the DOI, as in marola; the two DOIs in the README (#31) |
| v0.1.0 | 2026-10-13 | [10.5281/zenodo.23333657](https://doi.org/10.5281/zenodo.23333657) | [GitHub](https://github.com/h0ffmann/closed-source/releases/tag/v0.1.0), [Zenodo](https://zenodo.org/records/23333657) | docs(notes): authors' rights, patents and Edmund Burke; Burke as thinker 11 (#30); feat(site): the Marola and Ouroboric stamps of picasso's site on the cover (#29); feat: just viz, the code graph from picasso's viz lab (#28); docs(changes): options to port the Python tooling to Go, V or Gleam (#21); feat(tools): port the Python tooling to Gleam on the Erlang target (#27); docs: CLAUDE_PROJECT.md, the export of the project settings and memory (#26); and 22 more |
<!-- releases:end -->

The block above is written by `just minted` (`scripts/minted.sh`) after each release: the "is
live" line and one row for each Git tag, with Zenodo's DOI for it and the pull requests merged
since the version before. Do not edit it by hand. Notes that a script cannot write go below.

## How the changelog is written

Before a release, a pull request adds a section `## Next: vX.Y.Z (not released yet)` here: one
line that says since which version, then one bullet for each change a reader will see. After the
release, `just minted` changes its heading to `## vX.Y.Z: what changed` and the bullets stay.
The website shows the newest such section, so a reader of the site sees what the latest release
changed.

## v0.3.0: what changed

Changes since v0.2.1 (#44 to #47):

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
  if every link is alive; two more count the links to GitHub and to Zenodo;
- the website has a CI card: what happens when the book changes, with the state of each check;
- the 50 thinkers are in a new order, with no two neighbours of the same area;
- the repository has a social preview: the website's cover as a picture for a link in a chat.

## v0.2.1: on GitHub, with no DOI

v0.2.1 was tagged and released on GitHub on 13 October 2026
([release](https://github.com/h0ffmann/closed-source/releases/tag/v0.2.1)): the lower-case tile,
the commits box, the GitHub pill and the new keywords (#41 to #43). GitHub's two deliveries of
that release to Zenodo's webhook failed with a 500, so Zenodo made no record and minted no DOI
for it. v0.3.0 carries the same changes, and its delivery was accepted (202). If the owner
redelivers the v0.2.1 delivery (Settings, Webhooks), v0.2.1 gets its DOI too.

## Notes

- The paper's text did not change between v0.1.0 and v0.3.0: the three PDFs have the same prose.
- Each record holds the source archive of its tag; the PDFs are on the GitHub releases.
- v0.3.0 is the first record that is a book, the first with the keywords chosen for reverse
  engineers ([`KEYWORDS.md`](KEYWORDS.md)), and the first that names Hoppe's book
  ([`RELATED_WORK.md`](RELATED_WORK.md)). v0.1.0 and v0.2.0 stay preprints.

- The v0.1.0 record on Zenodo still says that it holds only the rendered PDF. That was the
  policy when its metadata was written; the owner can correct it on zenodo.org.
