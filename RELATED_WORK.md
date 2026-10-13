---
title: "Related work, as the indexes record it"
status: draft
date: 2026-10-13
related: [.zenodo.json, KEYWORDS.md, RELEASES.md, docs/4-ways-of-working/releasing.md, notes/202610130845-seen-by-the-right-people.md]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Related work

**Date of record: 13 October 2026.** Every row below was read on that day from DataCite's public
record of this work's v0.2.0 DOI,
[10.5281/zenodo.23335204](https://api.datacite.org/dois/10.5281/zenodo.23335204), which DataCite
registered on 13 October 2026 at 07:38 UTC. A row is true for that date. "How to refresh" at the
end says how to check it again.

## What this is, in plain words

A work on Zenodo does not stand alone. Its record names other works and says how it is tied to
each: it *cites* this one, it is a *version of* that one, it is a *supplement to* a third. Zenodo
sends those ties to DataCite, the registry that gives the DOI. From there they are public data:
a search engine, a library index or a person can follow a tie from one work to the next, in both
directions.

So a reader does not need to know this paper exists. A reader of a work that this paper cites,
or of a work with the same keyword ([`KEYWORDS.md`](KEYWORDS.md)), is already one step away. That
is the point of the note
[you only need to be seen by the right people](notes/202610130845-seen-by-the-right-people.md).

The ties are written by hand in one place, `related_identifiers` in
[`.zenodo.json`](.zenodo.json). Everything else copies them.

## How Zenodo indexes related work

Five steps. Each one was seen on the date of record; where Zenodo's documentation says it, the
documentation is quoted.

1. **The author writes the tie.** `.zenodo.json` has a list, `related_identifiers`. Zenodo's
   developer documentation calls them "Persistent identifiers of related publications and
   datasets" (<https://developers.zenodo.org/>). Each entry has an `identifier` (a DOI, a URL, an
   arXiv id and so on; Zenodo detects which), a `relation` from a fixed list (`cites`,
   `isCitedBy`, `isSupplementTo`, `requires`, `isRequiredBy`, `references`, `hasPart`,
   `isDerivedFrom` and about two dozen more) and, if you wish, a `resource_type`.
2. **A release copies it into the record.** When a GitHub release is published, Zenodo reads
   `.zenodo.json` at the tagged commit and makes the record. The record's own data then carries
   the same list (<https://zenodo.org/api/records/23335204>, `metadata.related_identifiers`).
3. **The record shows it to readers.** The record's page has a "Related works" box that lists
   each tie by its relation: "Cites", "Is supplement to"
   (<https://zenodo.org/records/23335204>). Each DOI there is a link.
4. **Zenodo registers it with DataCite.** Zenodo mints the DOI at DataCite and sends the
   metadata with it. DataCite's record for the DOI holds the ties as `relatedIdentifiers`, and
   the keywords as `subjects` (<https://api.datacite.org/dois/10.5281/zenodo.23335204>).
5. **DataCite turns ties into counts, in both directions.** For this record it shows
   `referenceCount: 6`. For a work that others point at, it shows `citationCount` and the list
   of citing DOIs (`?include=citations`). Any index that reads DataCite can follow the tie from
   either end.

What the documentation does not say, and this file does not claim: how fast other indexes
(search engines, library catalogues) pick the ties up, and whether a tie to a journal article
shows on the publisher's side. Zenodo's developer page describes the field, not what happens to
it after; steps 2 to 5 are what the indexes showed, not a promise.

Two things follow for an author:

- **A tie counts only if it is a DOI.** DataCite counted six references for this record; the two
  ties that are URLs (the repository and Ouroboric) are stored, and not counted.
- **A tie is frozen in each version.** It reaches Zenodo only with a release, and a published
  version keeps what it had. A tie added today shows from the next release on.

## What this work points at

Nine ties, as DataCite holds them for v0.2.0.

| Tie | To (DOI) | Publisher's page | Whose work | What it is |
|---|---|---|---|---|
| cites | [10.1038/nature10836](https://doi.org/10.1038/nature10836) | [nature.com/articles/nature10836](https://www.nature.com/articles/nature10836) | other people: Ince, Hatton and Graham-Cumming (2012) | "The case for open computer programs", *Nature* |
| cites | [10.1038/s41597-022-01710-x](https://doi.org/10.1038/s41597-022-01710-x) | [nature.com/articles/s41597-022-01710-x](https://www.nature.com/articles/s41597-022-01710-x) | other people: Barker, Chue Hong, Katz and others (2022) | "Introducing the FAIR Principles for research software", *Scientific Data*, a Nature Portfolio journal |
| cites | [10.7717/peerj-cs.86](https://doi.org/10.7717/peerj-cs.86) | [peerj.com/articles/cs-86](https://peerj.com/articles/cs-86) | other people: Smith, Katz, Niemeyer and the FORCE11 Software Citation Working Group (2016) | "Software citation principles", *PeerJ Computer Science* |
| cites | [10.5281/zenodo.23224155](https://doi.org/10.5281/zenodo.23224155) | [zenodo.org/doi/10.5281/zenodo.23224155](https://zenodo.org/doi/10.5281/zenodo.23224155) | the writer with five other people: Hoffmann, Valério, Soares da Silva Junior, Oliveira, Almeida and Ribeiro | marola, an open, non-profit platform for sea conditions and bathing-water quality |
| cites | [10.5281/zenodo.23221351](https://doi.org/10.5281/zenodo.23221351) | [zenodo.org/doi/10.5281/zenodo.23221351](https://zenodo.org/doi/10.5281/zenodo.23221351) | the writer: Hoffmann | WW3 GPU Lab, a bit-for-bit GPU port of WAVEWATCH III |
| cites | [10.5281/zenodo.23311208](https://doi.org/10.5281/zenodo.23311208) | [zenodo.org/doi/10.5281/zenodo.23311208](https://zenodo.org/doi/10.5281/zenodo.23311208) | the writer: Hoffmann | picasso, Nix flakes for scientific and agentic toolchains |
| cites | none: a URL | <https://github.com/ouroboric-dev/ouroboric> | another person: Bruno Valério | Ouroboric. It has no DOI yet (issue #40 asks for one), so the tie is stored and not counted |
| is a supplement to | none: a URL | <https://github.com/h0ffmann/closed-source> | the writer | this repository |
| is a version of | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) | [zenodo.org/doi/10.5281/zenodo.23333656](https://zenodo.org/doi/10.5281/zenodo.23333656) | the writer | the concept DOI, which ties every release of this work together |

The three publisher pages are where each DOI resolved on the date of record. The table is
complete: it has every tie in the record.

DataCite counts six references for the record: the six ties above that are DOIs to other works.
Three of the six are to works by other people.

The paper itself cites 41 works (`papers/closed-source/refs.bib`, each with its check in
`REFERENCES.md`). Only these are in the record, because a record's ties are for the works the
paper stands on most, not for its whole reference list.

## Added for the next release

The record of v0.2.0 is frozen. Two ties were added to `.zenodo.json` after it, so that the
writer's other works are cited here in full. They show from v0.2.1 on.

| Tie | To | Why |
|---|---|---|
| requires | [10.5281/zenodo.23311208](https://doi.org/10.5281/zenodo.23311208) (picasso) | This repository builds its PDFs and its website with picasso's `paper` and `gleam-website` labs, pinned in `flake.nix`. The paper already cites picasso; `requires` says the second thing, and it answers the `isRequiredBy` that picasso's record gets in return |
| cites | <https://github.com/h0ffmann/nashkell> (nashkell) | The paper cites it three times (sections 6 and 9; `hoffmann2026nashkell` in `refs.bib`), and the record did not name it. It is the writer's work and has no DOI, so the tie is a URL: stored, and not counted |

A third tie was added on 13 October 2026, to a work by another person:

| Tie | To | Why |
|---|---|---|
| references | [10.4324/9780203793572](https://doi.org/10.4324/9780203793572): Hoppe, *Democracy: The God That Failed* (Routledge) | The paper's title takes its formula from this book, and the website's cover follows its type and colours ([`BOOKS.md`](BOOKS.md)). The paper's reference list does not cite it, so the tie is `references`, not `cites`. Crossref holds the DOI: type book, publisher Routledge, read on 13 October 2026 |

The book has no record on Zenodo. Searched on 13 October 2026 in Zenodo's API: the title
"Democracy: The God That Failed" and the creators Hoppe, Mises, Rothbard and Kinsella each gave 0
records; the keyword "Austrian economics" gave 25 records, none of them a work this paper
stands on. A tie does not need a Zenodo record: it needs a DOI, and the publisher's DOI is one.

With these, every work of the writer that the paper cites is in the record: marola, ww3-gpu and
picasso by DOI, and nashkell by URL. A DOI for nashkell would turn its tie into one that counts;
that is a release of nashkell with Zenodo switched on, as for the others.

## What points at these works

The other direction: which records cite each work, as DataCite showed on the date of record.

| Work | Cited by | Who cites it |
|---|---:|---|
| WW3 GPU Lab, [10.5281/zenodo.23221351](https://doi.org/10.5281/zenodo.23221351) | 6 records | this paper (its concept DOI and two version DOIs) and marola (three of its DOIs) |
| marola, [10.5281/zenodo.23224155](https://doi.org/10.5281/zenodo.23224155) | 3 records | this paper (its concept DOI and two version DOIs) |
| picasso, [10.5281/zenodo.23311208](https://doi.org/10.5281/zenodo.23311208) | 3 records | this paper (its concept DOI and two version DOIs) |
| this paper, [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) | 0 records | nobody yet |

Read this table honestly. Every citing record here is the writer's own, or one he shares with
his co-authors on marola. No record by another person cites these works yet. The count goes up
by itself with each release, because each release is a new record that repeats the ties; that
growth is this work citing itself, not other people reading it. The day a stranger's record
appears in the right-hand column is the day to write it down here.

## Are the writer's four works linked to each other?

Checked on the date of record, in the latest Zenodo record of each work. A tick means the row's
record names the column's work by its DOI.

| Record of ↓ names → | marola | ww3-gpu | picasso | closed-source |
|---|:---:|:---:|:---:|:---:|
| **marola** v0.2.2 ([10.5281/zenodo.23266642](https://doi.org/10.5281/zenodo.23266642)) | — | ✓ `references` | ✗ | ✗ |
| **ww3-gpu** v0.1.3 ([10.5281/zenodo.23268515](https://doi.org/10.5281/zenodo.23268515)) | ✓ `isReferencedBy` | — | ✗ | ✗ |
| **picasso** v0.1.1 ([10.5281/zenodo.23311209](https://doi.org/10.5281/zenodo.23311209)) | ✓ `isRequiredBy` | ✓ `isRequiredBy` | — | ✗ |
| **closed-source** v0.2.0 ([10.5281/zenodo.23335204](https://doi.org/10.5281/zenodo.23335204)) | ✓ `cites` | ✓ `cites` | ✓ `cites` | — |

Seven of the twelve possible ties exist. Five are missing, and each is a line in another
repository's `.zenodo.json`. A pull request for each was opened on 13 October 2026:

| In | Adds | Why it is true | Pull request |
|---|---|---|---|
| marola | `requires` 10.5281/zenodo.23311208 (picasso) | its `flake.nix` takes the `lint` and `agentic` labs from h0ffmann/nix-config, which is picasso's earlier name | [marola-dev/marola#809](https://github.com/marola-dev/marola/pull/809) |
| marola | `isCitedBy` 10.5281/zenodo.23333656 (closed-source) | this paper cites marola | the same |
| ww3-gpu | `requires` 10.5281/zenodo.23311208 (picasso) | its toolchain is the `nix-config` submodule and a flake input on h0ffmann/nix-config | [h0ffmann/ww3-gpu#106](https://github.com/h0ffmann/ww3-gpu/pull/106) |
| ww3-gpu | `isCitedBy` 10.5281/zenodo.23333656 (closed-source) | this paper cites ww3-gpu | the same |
| picasso | `isCitedBy` and `isRequiredBy` 10.5281/zenodo.23333656 (closed-source) | this paper cites picasso, and builds with picasso's `paper` and `gleam-website` labs | [h0ffmann/picasso#125](https://github.com/h0ffmann/picasso/pull/125) |

Each uses the concept DOI of the other work, as these records already do, so the tie follows its
latest version. A pull request is a proposal: the tie exists on Zenodo only after the owner
merges it and that repository makes its next release. Until then the table of ticks above is the
state of the record. When all three have released, the twelve ties will be there, and this
section is read again against the records.

A second kind of link is the keyword. Three keywords are shared across these records today:
"research software" is on all four, "AI coding agents" on ww3-gpu, picasso and this paper, and
"large language models" on marola (and on this paper from its next release,
[`KEYWORDS.md`](KEYWORDS.md)). A reader who clicks one of them on any of the records sees the
others in the list.

## With other people

Where this work is already tied to people other than the writer, on the date of record:

1. **Three works it cites** were written by other people, and the tie is in DataCite: Smith and
   others (2016), Barker and others (2022), and Ince, Hatton and Graham-Cumming (2012).
2. **marola**, which it cites, has six creators; five are not the writer.
3. **Ouroboric**, which it cites by URL, is Bruno Valério's.
4. **Its keywords** are shared with records by other people; [`KEYWORDS.md`](KEYWORDS.md) has the
   counts.

## The loop

The paper argues that the honest course is to publish the method, mint an identifier and cite
what you use. This file is that argument applied to the paper:

1. the paper cites its sources (`refs.bib`, `REFERENCES.md`);
2. the record carries the ties (`.zenodo.json`), and each release sends them to DataCite;
3. this file reads the ties back from DataCite and says what they are, with the date;
4. what it finds (a work with no DOI, a tie that is missing) becomes an issue, and the next
   release carries the fix.

## How to refresh

After a release, or when a tie changes:

```sh
# the ties this work points at, and DataCite's date for the record
curl -s https://api.datacite.org/dois/10.5281/zenodo.<the new version's number> \
  | jq '.data.attributes | {registered, referenceCount, relatedIdentifiers}'

# who cites a work
curl -s 'https://api.datacite.org/dois/10.5281/zenodo.23221351?include=citations' \
  | jq '.data.relationships.citations.data'
```

Then change the date of record at the top and the rows that differ. Rules:

- A tie is changed only in `.zenodo.json`, then `just citation`. It reaches Zenodo and DataCite
  with the next release, not before.
- A row here is what an index showed on the date of record. Never write a tie or a count that
  was not read from the index that day.
- A citing record by another person gets its DOI, its authors and the date it was first seen.
