# The ethical answer: professional citation {#sec:citing}

If anyone can read your work, the remaining protection is the norm that whoever uses it says so.
That norm is old in science; it is young for software, and it is barely formed for agents.

## Citation for people

The FORCE11 *Software citation principles* set out what it means to cite software properly:
software is a legitimate product of research and should be cited as such; citations should give
credit, be unique and persistent, be accessible, and be specific to the version used
[@smith2016software]. The FAIR principles ask that research outputs be findable, accessible,
interoperable and reusable [@wilkinson2016fair], and FAIR4RS adapts them to research software
[@barker2022fair4rs].

In practice this needs three things in every repository. The first is a persistent identifier:
a DOI minted by an archive such as Zenodo, with a *concept* DOI that always resolves to the latest
version and a *version* DOI for each release. The second is machine-readable metadata, so that a
citation can be generated rather than typed: `CITATION.cff` for GitHub's "Cite this repository",
and `.zenodo.json` for the archive. The third is a release process in which every published
version gets its own identifier, so that a reader can cite exactly what they used.

This repository follows that recipe; Section [-@sec:fabric] gives the details. So does the related
work in Section [-@sec:related], each item of which has a concept DOI.

## Citation for agents: borrow, cite, propagate

Coding and research agents now write a large share of new code and text, including the drafting
of this paper (see the AI-use statement). Agents read far more than any person and copy fluently.
If they do not cite, the REA explosion becomes a laundering machine: code and ideas go in with
authors and come out without them. I therefore propose three rules for agents, which Paper
Fabric's `AGENTS.md` makes binding for any agent that works in its repositories.

1. **Borrow only what the licence allows.** Before reusing code, text, figures or data, read
   the licence and record it. Reuse that the licence does not permit is not borrowing. When in
   doubt, describe the idea and cite it instead of copying its expression.
2. **Cite at the point of use, with a persistent identifier.** Every borrowed element gets a
   citation where it is used, not only in a final list. Prefer a DOI; fall back to a URL with a
   commit hash or archive snapshot. Never invent a reference: an agent that cannot fetch and check
   a source must mark the claim as unverified.
3. **Propagate credit downstream.** When an agent's output is itself published, the citations
   travel with it: in the bibliography, in `CITATION.cff` references, and in the Zenodo record's
   related identifiers (`cites`, `isDerivedFrom`, `isSupplementTo`). Credit that stops at the
   first hop is lost at the second.

**[ANALYSIS]** The rules ask nothing exotic. They are what a careful graduate student does. The
difference is scale and verifiability: a person who forgets a citation forgets one; an agent that
forgets forgets thousands, and an agent that invents references poisons the record. Rule 2's
prohibition on invented references is therefore enforced mechanically in Paper Fabric, by a
reference log that records how each entry was checked.
