# The ethical answer: professional citation {#sec:citing}

If anyone can read your work, one protection remains: the norm that each person who uses the work
says so. That norm is old in science. It is new for software, and for agents it is almost not
formed.

## Citation for people

The FORCE11 *Software citation principles* define a correct citation of software. Software is a
valid product of research, and people should cite it as a product of research. A citation should
give credit, be unique and persistent, and be accessible. It should also be specific to the
version that the person used [@smith2016software]. The FAIR principles ask that research outputs
are findable, accessible, interoperable and reusable [@wilkinson2016fair]. FAIR4RS adapts these
principles to research software [@barker2022fair4rs].

In practice, each repository needs three things for this. The first is a persistent identifier: a
DOI that an archive such as Zenodo issues. The archive gives a *concept* DOI that always resolves
to the latest version, and a *version* DOI for each release. The second is machine-readable
metadata, so that a tool can generate a citation and a person does not type it. The metadata files
are `CITATION.cff` for GitHub's "Cite this repository", and `.zenodo.json` for the archive. The
third is a release process that gives each published version its own identifier, so that a reader
can cite exactly what they used.

This repository uses this method, and Section [-@sec:fabric] gives the details. Each item of the
related work in Section [-@sec:related] also uses this method and has a concept DOI.

## Citation for agents: borrow, cite, propagate

Coding and research agents now write a large part of new code and text, which includes the drafts
of this paper (see the AI-use statement). Agents read much more than any person, and they copy
easily. If agents do not cite, the REA explosion becomes a machine that launders work. Code and
ideas enter with their authors and exit without them. Thus, we propose three rules for agents.
Paper Fabric's `AGENTS.md` makes these rules mandatory for each agent that works in its
repositories.

1. **Borrow only what the licence allows.** Before you reuse code, text, figures or data, read
   the licence. Then record the licence. If the licence does not permit the reuse, it is not
   borrowing. If you are not sure, describe the idea and cite it. Do not copy its expression.
2. **Cite at the point of use, with a persistent identifier.** Give each borrowed element a
   citation at the point where you use it. A citation only in a final list is not sufficient. If
   a DOI exists, use the DOI. If no DOI exists, use a URL with a commit hash or an archive
   snapshot. Never invent a reference. If you cannot fetch and check a source, mark the claim as
   unverified.
3. **Propagate credit downstream.** If your output is published, keep its citations with it. Put
   the citations in the bibliography and in the `CITATION.cff` references. Also put them in the
   related identifiers of the Zenodo record (`cites`, `isDerivedFrom`, `isSupplementTo`). If
   credit stops at the first hop, it is lost at the second hop.

**[ANALYSIS]** The rules do not ask for an unusual thing: a careful graduate student does the same.
The differences are scale and verifiability. A person who forgets a citation forgets one, but an
agent that forgets forgets thousands. An agent that invents references poisons the record. Thus,
Paper Fabric enforces the rule 2 prohibition of invented references mechanically, with a reference
log that records how each entry was checked.
