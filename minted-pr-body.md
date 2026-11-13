## Task

The report that follows every release (`docs/4-ways-of-working/releasing.md`, step 6), written by `just minted`.

**v0.4.0 is live.**


Changes since v0.3.4 (#73 to #92):

- the paper grows to 33 pages, with evidence from 2024 to 12 November 2026 (#77), and a second
  writing pass corrects claims that went further than their sources (#88);
- the paper no longer tells the story of the writer's closed undergraduate thesis (#74), and the
  record's description no longer says that it does;
- the book's roster is cut from 50 thinkers to 33, each linked to their Wikipedia page, in
  `33THINKERS.md` (#81 to #83);
- the paper's STE text is checked against ASD-STE100 with Vale (#87), and Agda proofs back the
  STE rules and the paper's mathematical claims (#90);
- notes on Psycho-Pass and its Sibyl system as a closed judge, with a study plan (#80, #84, #85);
- the website: a retro restyle in orange neon (#76) and the writer's top 10 projects at the
  bottom (#78, #79);
- compound engineering and a side project are removed; the record names the writer's
  partners, piabrota and marola-dev (#86, #89, #92).

- Tag: `v0.4.0` at `08e24a1`, 12 November 2026.
- GitHub release: https://github.com/h0ffmann/closed-source/releases/tag/v0.4.0
- Permanent DOI of v0.4.0: [10.5281/zenodo.24182034](https://doi.org/10.5281/zenodo.24182034)
- Latest DOI, unchanged: [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656). It now opens v0.4.0.
- Since v0.3.4: release: regenerate the timeline; keep person-only files out of the zenodo archive (#94); release: prepare v0.4.0 (#93); remove every ouroboric mention; partners are piabrota and marola-dev (onto main) (#92); paper: second writing pass over the 33-page text (#88); agda: back the ASD-STE100 rules and the paper's math claims with Agda (#90); studies: a plan for the psycho-pass study (#85); and 13 more

`scripts/minted.sh` wrote the release into `RELEASES.md`, the README's badge, status line and DOI table, the easy version (restamped), `releasing.md` and the drafts in `docs/social/`. The website needs no change: its next build asks Zenodo for the version DOIs.

By hand, if they apply: the date of record in `RELATED_WORK.md` and `KEYWORDS.md`, read back from DataCite for the new DOI.

## Proof

- Zenodo's API lists `v0.4.0` with the DOI above under the concept DOI.
- `just check` passes on this branch.

## Checklist

- [x] A fact changed in `prose/` is changed in `prose-ste/` and `prose-pt-BR/` too. (No prose changed.)
- [x] Every new Markdown file has its cite line (PERSONAS.md). (No new Markdown file.)
- [x] A change to a hard rule links its change proposal in `docs/2-engineering/changes/`. (No rule changed.)
- [ ] A journal entry is added if this change met a challenge worth recording.
