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

## The loop

**[ANALYSIS]** What makes the pipeline ouroboric rather than merely automated is that each paper
feeds the next. The reference log, the readiness assessment and the exported agent configuration
are kept in the repository. The next paper starts from them, and the journal records what went
wrong. This paper's own known defects are listed in the repository's readiness assessment, which
is part of the same pull request that introduced it.
