<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
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

A fourth element is now standard. A DOI names a release that someone chose to archive. A Software
Hash Identifier names each artefact of source code by its content. Since April 2025, it is the
international standard ISO/IEC 18670 [@swh2026swhid]. The two identifiers do different work. The
DOI carries the metadata of credit: authors, title and version. The SWHID proves that the code that
a reader has is the code that the citation names. If a citation has both, anyone can check it, and
nobody must trust the archive.

This repository uses this method, and Section [-@sec:fabric] gives the details. Each item of the
related work in Section [-@sec:related] also uses this method and has a concept DOI.

## What policy already asks for

Public policy moved in the same direction. In November 2021, the 193 member states of UNESCO
adopted a Recommendation on Open Science. The Software Sustainability Institute reported that it
recognises "the role of software, source code and software infrastructure as key parts of Open
Science". It was the first UNESCO recommendation of this type that included open-source software
[@ssi2021unesco].

In August 2022, the White House Office of Science and Technology Policy published a memorandum,
signed by Alondra Nelson. It told US federal agencies to make the publications from the research
that they fund freely available "immediately on publication, with no embargo". It applied the same
principle to the scientific data of those publications. The agencies had to do this by the end of
2025 [@casrai2022nelson].

**[ANALYSIS]** Neither text is a law that makes a researcher publish code, and I do not say that it
is. The texts show what the public that pays for research now expects. If public money pays for a
closed method, the method is now an exception that needs a reason. It is no longer a default that
needs no reason.

## The evidence that citation is failing

This need is real. In January 2026, GPTZero reported that it examined 4,841 papers that NeurIPS
2025 accepted. NeurIPS is one of the largest conferences in machine learning. GPTZero confirmed 100
hallucinated citations in these papers: references with invented authors, DOIs that do not exist,
or venues that do not agree [@gptzero2026neurips]. A subsequent taxonomy of the same 100
citations found them in 53 published papers, "approx. 1% of all accepted papers". Three to five
experts reviewed each of these papers [@ansari2026compound].

**[ANALYSIS]** A fabricated reference is the opposite of a borrowing without credit. The first
gives credit to work that does not exist. The second does not give credit to work that exists.
Both pass peer review, because reviewers read for the argument, not for the source. Both increase
with the tools that write text.

**[ANALYSIS]** The most selective conferences in the field of these tools let one paper in a
hundred through with invented sources. Thus we cannot leave the check to reviewers. The check must
be part of how people and agents make the text.

## Citation for agents: borrow, cite, propagate

Coding and research agents now write a large part of new code and text, which includes the drafts
of this paper (see the AI-use statement). Agents read much more than any person, and they copy
easily. If agents do not cite, the REA explosion becomes a machine that launders work. Code and
ideas enter with their authors and exit without them. Thus, I propose three rules for agents.
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

## The same rules in other projects

**[ANALYSIS]** These rules are not only my rules. The clean-room projects of Section
[-@sec:espionage] write a version of them into their own repositories. Craft Anything tells its
agent not to copy logos, photos or text unless the user confirms ownership or permission. It keeps
borrowed assets under their own licences in an attribution file [@storytold2026craftanything]. REA
states that third-party material "retains its own licenses and copyright notices"
[@morluto2026rea]. These are rules 1 and 3 in different words.

**[ANALYSIS]** The projects do not have rule 2 at the level of ideas, and most of the field does not
have it. This is a citation, at the point of use, of the products and specifications that they
studied. A clean-room rebuild that names what it studied, with a version and an identifier, would
be both lawful and honest. A rebuild that does not do this is lawful and silent.

## A minimal citation record

A repository that wants citations from people and agents needs a minimal record. I propose the
items below. The repository of this paper has each of them.

1. A `CITATION.cff` file at the root, with authors, title, version and the concept DOI.
2. A `.zenodo.json` file with the same metadata. It also has `related_identifiers` for each work
   that the repository cites (`cites`) or comes from (`isDerivedFrom`).
3. A release process in which each tag gets a version DOI, and a log of the releases.
4. A reference log. For each entry in the bibliography, it records what was fetched, when, and if
   it agreed.
5. An `AGENTS.md` that gives the three rules above as invariants for each agent.

For example, the part of a `.zenodo.json` file that propagates credit for a clean-room rebuild can
be as follows. The identifiers are those of works that this paper cites. The relations are the
vocabulary that Zenodo and DataCite already accept.

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

Machines read a record like this. After the deposit, DataCite keeps the relations. Any index that
reads DataCite can then show, for each cited work, who built on it.

**[ANALYSIS]** None of the five items needs a new tool or a new standard. Each item takes minutes
to add. It saves hours for each subsequent reader, person or machine, who wants to know where the
work came from.
