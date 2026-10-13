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
row of a release is added in a pull request after it
([releasing](docs/4-ways-of-working/releasing.md)).

**v0.2.0 is live** (13 October 2026).

## Next: v0.2.1 (not released yet)

The next release's changes, all on the website and the README (#41 and the pull request that adds
this section):

- the closed-source tile is in lower case, like the other tiles;
- the cover has a fourth box, the number of commits, beside the pages and the notes;
- a GitHub pill in the middle of the cover: the repository, the latest release and a star; and
  the same pill at the top of `README.md`;
- new Zenodo keywords, chosen for reverse engineers ([`KEYWORDS.md`](KEYWORDS.md)): eight added,
  three dropped.

After the merge, the owner releases it by its name: `just release 0.2.1` (or `just release
patch`). `just release` alone will suggest a minor bump, v0.3.0, because #41 was merged under a
`feat` title; the owner's number is 0.2.1. When Zenodo has minted the DOI, this section becomes a
row of the table below.

## Released

| Version | Date | Permanent DOI | Release | What changed |
|---|---|---|---|---|
| v0.2.0 | 2026-10-13 | [10.5281/zenodo.23335204](https://doi.org/10.5281/zenodo.23335204) | [GitHub](https://github.com/h0ffmann/closed-source/releases/tag/v0.2.0), [Zenodo](https://zenodo.org/records/23335204) | The release follows marola's chain: Zenodo's webhook mints the DOI (#31). The site has a DOIs section with a tile for each of the four works (#34), and a citation-scores section. `README.md` is in lower case with an easy pt-BR version, and four skills written here: `readme-style`, `easy-pt-br`, `card-style` and `citation-score` (#35). The identity is black and red with yellow letters. `.graphifyignore` keeps `CLAUDE_PROJECT.md` and the renderings out of a graph (#33) |
| v0.1.0 | 2026-10-13 | [10.5281/zenodo.23333657](https://doi.org/10.5281/zenodo.23333657) | [GitHub](https://github.com/h0ffmann/closed-source/releases/tag/v0.1.0), [Zenodo](https://zenodo.org/records/23333657) | The first release: the paper in three editions, Paper Fabric, the website, the 50 thinkers and the notes (#1 to #30) |

The paper's text did not change between v0.1.0 and v0.2.0: the three PDFs have the same prose.
Both records hold the source archive of their tag; the PDFs are on the GitHub releases.

The v0.1.0 record on Zenodo still says that it holds only the rendered PDF. That was the policy
when its metadata was written; the owner can correct it on zenodo.org.
