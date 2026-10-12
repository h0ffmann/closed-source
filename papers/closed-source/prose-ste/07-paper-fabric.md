# Paper Fabric: an ouroboric factory for papers {#sec:fabric}

Paper Fabric is the open pipeline that produced this preprint. Its design permits reuse for any
paper, and it follows the philosophy of Ouroboric, the project of Bruno Valério. The Ouroboric charter describes "open,
self-improving factories" that produce work, measure it and apply what they learn to themselves
[@ouroboric2026]. The charter lists a research factory "for scientific research and papers" as a
possible future direction. The charter explicitly states that this direction is not a commitment
[@ouroboric2026]. Paper Fabric is an independent experiment in that direction.

## Principles

Paper Fabric uses four principles of Ouroboric directly. These ideas are from Valério. *Humans steer, agents build*: I
approve the direction and every claim that is based on my own experience, and agents draft,
check and build. *Checks, not promises*: citations are checked against the source, and the build
fails if a citation is missing. *Read before you borrow*: licences decide what may be reused, and
each thing that is taken gets credit. *Learn in public*: the pipeline, the prompts and the agent
configuration that produced a paper are published with it.

## Pipeline

The toolchain follows the books of Sandy Maguire [@maguire2019thinking]. The prose is in Markdown,
with one file for each section. A `justfile` runs pandoc with a custom LaTeX template and a BibTeX
bibliography, and then runs XeLaTeX. The `justfile` then stamps the PDF with the Git revision that
the build used. A Nix flake sets each tool to one version, through the `paper` lab of picasso
[@hoffmann2026picasso]. Pandoc's built-in citeproc resolves the citations. The build treats warnings as
errors, so an unresolved citation key stops the build.

Each paper is in its own directory, `papers/<slug>/`, with a `metadata.md`, numbered prose files
and a `refs.bib`. The citation metadata for the repository is in `.zenodo.json`, and `CITATION.cff`
is generated from that file. I borrowed this metadata, with credit, from my earlier
projects [@hoffmann2026picasso; @hoffmann2026marola].

A release is a Git tag. For v0, the release workflow builds the PDF and attaches it to a GitHub
release. If a maintainer supplies a Zenodo token, and only then, the workflow uploads *only the
PDF* to a draft deposit on Zenodo. The publication of the deposit mints a permanent DOI, and this
step stays a human decision.

## The loop

**[ANALYSIS]** The pipeline is ouroboric, not only automated, because each paper gives input to the
next paper. The repository keeps the reference log, the readiness assessment and the exported agent
configuration. The next paper starts from these files. The journal records the problems. The
readiness assessment of the repository lists the known defects of this paper. This assessment is
part of the same pull request that introduced the paper.
