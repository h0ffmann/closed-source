<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Paper Fabric: an ouroboric factory for papers {#sec:fabric}

Paper Fabric is the open pipeline that produced this preprint. It is designed to be reused for
any paper, and it follows the philosophy of Ouroboric, Bruno Valério's project, whose charter describes "open,
self-improving factories" that produce work, measure it and feed what they learn back into
themselves [@ouroboric2026]. The Ouroboric charter lists a research factory "for scientific
research and papers" as a possible future direction, explicitly not a commitment
[@ouroboric2026]. Paper Fabric is an independent experiment in that direction.

## Principles

Paper Fabric takes four of Ouroboric's principles directly; the ideas are Valério's. *Humans steer, agents build*: I
approve the direction and every claim that rests on my own experience; agents draft,
check and build. *Checks, not promises*: citations are verified against the source, and the
build fails on a missing citation. *Read before you borrow*: licences decide what may be reused,
and credit is given for what is taken. *Learn in public*: the pipeline, the prompts and the agent
configuration that produced a paper are published with it.

## Pipeline

The toolchain follows Sandy Maguire's books [@maguire2019thinking]: prose is written in Markdown,
one file per section, and a `justfile` runs pandoc with a custom LaTeX template and a BibTeX
bibliography, then XeLaTeX, and stamps the PDF with the Git revision it was built from. A Nix flake
pins every tool to one version, through the `paper` lab of picasso [@hoffmann2026picasso]. Pandoc's
built-in citeproc resolves citations, and the build runs with warnings treated as errors, so an
unresolved citation key stops the build.

Each paper lives in its own directory, `papers/<slug>/`, with a `metadata.md`, numbered prose
files and a `refs.bib`. The repository-level citation metadata (`.zenodo.json`, from which
`CITATION.cff` is generated) is borrowed, with credit, from my earlier projects
[@hoffmann2026picasso; @hoffmann2026marola]. A release is a Git tag. For v0, the release
workflow builds the PDF, attaches it to a GitHub release and, only when a maintainer supplies a
Zenodo token, uploads *only the PDF* to a Zenodo draft deposit. Publishing the deposit, which
mints a permanent DOI, stays a human decision.

## Checks

The build is surrounded by checks, each a small program in the repository's own tools, and CI runs
them on every pull request. I list them because they are how the rules of Section
[-@sec:citing] become more than advice.

1. **References.** Every key in the bibliography must have a row in the reference log, with a
   status of `verified` or `partial` and a note of what was fetched; a key without a row, or a row
   without a key, fails the build.
2. **Citations in every file.** Every Markdown file in the repository names its main author and its
   last author on one line; a file without that line fails.
3. **Translations keep the facts.** The paper is written three times: in English, in ASD-STE100
   Simplified Technical English and in Brazilian Portuguese. A check compares each version with
   the English text and fails if a citation, a number, a quotation or a marker of interpretation
   was lost or added.
4. **Warnings are errors.** Pandoc runs with warnings treated as errors, so an unresolved citation
   key or a broken cross-reference stops the build.
5. **Live links.** The links of the repository's Markdown files are checked on every pull request.

## The loop

**[ANALYSIS]** What makes the pipeline ouroboric rather than merely automated is that each paper
feeds the next. The reference log, the readiness assessment and the exported agent configuration
are kept in the repository. The next paper starts from them, and the journal records what went
wrong. This paper's own known defects are listed in the repository's readiness assessment, which
is part of the same pull request that introduced it.

**[ANALYSIS]** This version is an example of the loop. Its owner asked, on 12 November 2026, for the
paper to be expanded, its holes filled and its evidence brought up to that day. The agent read the
readiness assessment, which listed an unverified case number, a missing entry for the 1949
anthology, a missing DOI and a broken sentence; each is fixed in this version, and each fix is in
the reference log or the diff. What the agent could not do, write the author's own experience, it
left marked for the author.

## This version in numbers

The version of 12 November 2026 grew from 10 sections to 16. Its bibliography grew from 41 entries
to 81: each of the 40 new entries was fetched on that day and has a row in the reference log, and 6
of the 40 are marked `partial` because a detail could not be read from the primary document. The
paper exists in three editions built from the same sources and the same bibliography, and the
translation check passes for both the ASD-STE100 edition and the Brazilian Portuguese edition. One
passage is still reserved for the author, and no agent wrote it.

**[ANALYSIS]** I give these numbers because a position paper about citation should be measurable by
its own standard. A reader can count the entries, open the log, follow each link and check whether
the paper did what it asks of others. If it did not, the defect is visible, and the next version
can fix it.
