<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
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

## Checks

Checks surround the build. Each check is a small program in the tools of the repository, and CI
runs them on each pull request. I list them, because they make the rules of Section
[-@sec:citing] more than advice.

1. **References.** Each key in the bibliography must have a row in the reference log. The row has
   a status of `verified` or `partial`, and a note of what was fetched. A key without a row, or a
   row without a key, makes the build fail.
2. **Citations in each file.** Each Markdown file in the repository names its main author and its
   last author on one line. A file without that line makes the build fail.
3. **Translations keep the facts.** The paper has three texts: English, ASD-STE100 Simplified
   Technical English, and Brazilian Portuguese. A check compares each text with the English text.
   It fails if a citation, a number, a quotation or a marker of interpretation is lost or added.
4. **Warnings are errors.** Pandoc treats warnings as errors. Thus a citation key that does not
   resolve, or a broken cross-reference, stops the build.
5. **Live links.** A check examines the links of the Markdown files of the repository on each pull
   request.

## The loop

**[ANALYSIS]** The pipeline is ouroboric, not only automated, because each paper gives input to the
next paper. The repository keeps the reference log, the readiness assessment and the exported agent
configuration. The next paper starts from these files. The journal records the problems. The
readiness assessment of the repository lists the known defects of this paper. This assessment is
part of the same pull request that introduced the paper.

**[ANALYSIS]** This version is an example of the loop. On 12 November 2026, its owner asked for
these changes: make the paper longer, fill its holes, and bring its evidence up to that day. The
agent read the readiness assessment. It listed a case number that nobody verified, a missing entry
for the 1949 anthology, a missing DOI and a broken sentence. This version corrects each item, and
the reference log or the diff shows each correction. The agent could not write the experience of
the author. It left that part with a marker for the author.

## This version in numbers

The version of 12 November 2026 has 16 sections. Before, it had 10 sections. Its bibliography had
41 entries, and now it has 81. I fetched each of the 40 new entries on that day, and each has a row
in the reference log. Of these 40 entries, 6 have the status `partial`, because I could not read a
detail from the primary document. The paper has three editions. They use the same sources and the
same bibliography. The translation check passes for the ASD-STE100 edition and for the Brazilian
Portuguese edition. One passage is still for the author, and no agent wrote it.

**[ANALYSIS]** I give these numbers because a position paper about citation must be measurable by
its own standard. A reader can count the entries, open the log, follow each link and check if the
paper did what it asks of others. If it did not, the defect is visible, and the next version can
correct it.
