<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
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

A fourth element is now standard. A DOI names a release that someone chose to archive; a Software
Hash Identifier names any artefact of source code by its content, and since April 2025 it is the
international standard ISO/IEC 18670 [@swh2026swhid]. The two do different work. The DOI carries
the metadata of credit, authors, title and version, and the SWHID proves that the code a reader
holds is the code that was cited. A citation that carries both is checkable by anyone, with no
trust in the archive.

This repository follows that recipe; Section [-@sec:fabric] gives the details. So does the related
work in Section [-@sec:related], each item of which has a concept DOI.

## What policy already asks

Public policy has moved in the same direction. In November 2021 the 193 member states of UNESCO
adopted a Recommendation on Open Science which, as the Software Sustainability Institute reported,
recognises "the role of software, source code and software infrastructure as key parts of Open
Science"; it was the first UNESCO recommendation of its kind to include open-source software
[@ssi2021unesco]. In August 2022 the White House Office of Science and Technology Policy, in a
memorandum signed by Alondra Nelson, directed US federal agencies to make publications from the
research they fund freely available "immediately on publication, with no embargo", and extended
the principle to the scientific data underlying those publications, with implementation expected
by the end of 2025 [@casrai2022nelson].

**[ANALYSIS]** Neither text is a law that compels a researcher to publish code, and I do not claim
otherwise. They show where the public that pays for research has placed its expectation. A closed
method funded by public money is now an exception that needs a reason, not a default that needs
none.

## The evidence that citation is failing

The need is not hypothetical. In January 2026 GPTZero reported that it had scanned 4,841 papers
accepted at NeurIPS 2025, one of the largest conferences in machine learning, and confirmed 100
hallucinated citations in them: references with invented authors, DOIs that do not exist or venues
that do not match [@gptzero2026neurips]. A follow-up taxonomy of the same 100 citations found them
in 53 published papers, "approx. 1% of all accepted papers", each of which had been reviewed by
three to five experts [@ansari2026compound].

**[ANALYSIS]** A fabricated reference is the mirror image of an uncredited borrowing. One gives
credit to work that does not exist; the other withholds credit from work that does. Both pass
peer review because reviewers read for argument, not for provenance, and both scale with the
tools that write text. If one of the most selective venues of machine learning, the field that
builds these tools, lets about one paper in a hundred through with invented sources, the check
cannot be left to reviewers. It must
be part of how the text is made.

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
forgets can forget thousands, and an agent that invents references poisons the record. Rule 2's
prohibition on invented references is therefore enforced mechanically in Paper Fabric, by a
reference log that records how each entry was checked.

## The same rules, seen in the wild

**[ANALYSIS]** The rules are not only mine. The clean-room projects of Section [-@sec:espionage]
write a version of them into their own repositories. Craft Anything tells its agent not to copy
logos, photos or text unless the user confirms ownership or permission, and keeps borrowed assets
under their own licences in an attribution file [@storytold2026craftanything]. REA states that
third-party material "retains its own licenses and copyright notices" [@morluto2026rea]. These are
rules 1 and 3 in other words. What the projects lack, and what most of the field lacks, is rule 2
at the level of ideas: a citation, at the point of use, of the products and specifications that
were studied. A clean-room rebuild that names what it studied, with a version and an identifier,
would be both lawful and honest. One that does not is lawful and silent.

## A minimal citation record

For a repository that wants to be cited by people and by agents, I propose the following minimal
record, each item of which this paper's repository carries.

1. A `CITATION.cff` file at the root, with authors, title, version and the concept DOI.
2. A `.zenodo.json` file with the same metadata and `related_identifiers` for every work cited
   (`cites`) or derived from (`isDerivedFrom`).
3. A release process in which each tag mints a version DOI, and a log of the releases.
4. A reference log that records, for each entry in the bibliography, what was fetched, when, and
   whether it matched.
5. An `AGENTS.md` that states the three rules above as invariants for every agent.

As an example, the part of a `.zenodo.json` file that propagates credit for a clean-room rebuild
could read as follows. The identifiers are those of works cited in this paper; the relations are
the vocabulary that Zenodo and DataCite already accept.

```json
"related_identifiers": [
  { "relation": "cites", "scheme": "url",
    "identifier": "https://github.com/morluto/rea" },
  { "relation": "isDerivedFrom", "scheme": "doi",
    "identifier": "10.5210/fm.v3i2.578" },
  { "relation": "cites", "scheme": "doi",
    "identifier": "10.1145/2812803" }
]
```

A record like this is read by machines. Once deposited, DataCite holds the ties, and any index
that reads DataCite can show, for each cited work, who built on it.

**[ANALYSIS]** None of the five items needs a new tool or a new standard. Each takes minutes to add
and saves hours for every later reader, human or machine, who wants to know where the work came
from.
