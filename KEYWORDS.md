---
title: "Keywords: the words a reader finds this work by"
status: draft
date: 2026-10-13
related: [.zenodo.json, RELATED_WORK.md, GITHUB_REPO_TOPICS.md, ISSUE_LABELS.md, notes/202610130845-seen-by-the-right-people.md]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Keywords

**Date of record: 13 October 2026.** The counts below were read from Zenodo's search on that day.

## The policy

You only need to be seen by the right people
([note](notes/202610130845-seen-by-the-right-people.md)). For this paper the right people are
reverse engineers, and after them the people who work on research software and its citation. So
a keyword is in the list only when both of these are true:

1. **the right reader would type it**, in those exact words; and
2. **the paper is about it**: the word, or the thing it names, is in the prose.

A keyword that would only bring more visitors is left out. A large count is not a reason to add
a word, and a small count is not a reason to drop one: a small room with the right people in it
is the room to be in.

## How a keyword works on Zenodo

- The list is `keywords` in [`.zenodo.json`](.zenodo.json). Zenodo's documentation calls it
  "Free form keywords for this deposition" (<https://developers.zenodo.org/>): there is no fixed
  vocabulary, so the exact wording is the whole game.
- On the record's page each keyword is a link. It opens a search for every record with the same
  keyword, written the same way (the link's query is `metadata.subjects.subject:"<keyword>"`;
  seen on <https://zenodo.org/records/23335204>). "trade secret" and "trade secrets" are two
  different rooms.
- Zenodo sends the keywords to DataCite with the DOI, where they are the record's `subjects`
  (<https://api.datacite.org/dois/10.5281/zenodo.23335204>).
- A change here reaches Zenodo with the next release. A published version keeps the keywords it
  had.

## The list

Twenty-one keywords, the reverse engineer's first. "Records" is how many Zenodo records carried
the same keyword on the date of record; "—" is a count that Zenodo's search did not return that
day (it timed out).

| Keyword | Records | Who types it, and where the paper is about it | Since |
|---|---:|---|---|
| reverse engineering | 272 | the reverse engineer; the paper's subject (section 4) | v0.1.0 |
| AI-assisted reverse engineering | 1 | the paper's own term for it; this record is the one | v0.1.0 |
| decompilation | 17 | the reverse engineer; LLMs that decompile binaries into source that runs again (section 4) | v0.1.0 |
| binary analysis | 44 | the reverse engineer; the same section, from the binary's side | next release |
| obfuscation | 113 | the reverse engineer and the one who defends against him; section 6, on obfuscation and why it cannot hide code | next release |
| code obfuscation | 17 | the same reader, in the narrower words | next release |
| model extraction | 17 | the machine-learning security reader; black-box queries that extract parts of production models (section 4) | v0.1.0 |
| knowledge distillation | 237 | the machine-learning reader; distillation as copying at scale (section 4) | v0.1.0 |
| large language models | 7,586 | the reader who comes from the tools; they are what changed the cost of reverse engineering | next release |
| AI coding agents | 90 | the reader who builds or studies agents; the three rules for agents (section 7) | v0.1.0 |
| trade secrets | 36 | the lawyer and the engineer under a secrecy agreement; the 2026 dispute (section 4) | v0.1.0 |
| proprietary software | 17 | the reader who says "proprietary" where the paper says "closed" | next release |
| closed source | — | the paper's title and thesis | v0.1.0 |
| open source | — | the other half of the thesis (section 2) | v0.1.0 |
| security through obscurity | 2 | the security reader; what closed source is, as protection | next release |
| Kerckhoffs's principle | 2 | the cryptographer; "only the key must be secret", which the paper applies to source code (section 6) | next release |
| software security | 204 | the security reader; what to secure instead of the source (section 6) | next release |
| software citation | 159 | the research-software reader; the paper's answer (section 7) | v0.1.0 |
| research software | 1,779 | the same reader; also on the writer's three other records | v0.1.0 |
| persistent identifiers | 650 | the librarian and the research-software reader; DOIs as the means | v0.1.0 |
| position paper | 61 | the reader who needs to know what kind of text this is | v0.1.0 |

Other counts taken that day, for words that are not in the list: "trade secret" 58,
"program analysis" 162, "cryptography" 3,708, "intellectual property" 1,654, "LLM" 8,115,
"decompiler" 7, "Ghidra" 8, "model stealing" 2, "industrial espionage" 5.

## Left out, and why

| Keyword | Why |
|---|---|
| FAIR | 8,485 records: a large room. The research-software reader is reached by "research software" and "software citation". Dropped from the next release |
| Linux, Git | The paper uses them as evidence that openness scales; a reader who searches for them is not looking for this. 583 and 386 records. Dropped from the next release |
| Ghidra | The paper names the tool in passing; it is not about it |
| LLM | "large language models" is the same room, written out |
| cryptography, intellectual property | Each is a field, and the paper touches it without being about it |
| software reverse engineering, software obfuscation | No record on Zenodo uses these exact words |

Dropping a word does not change a published version: v0.1.0 and v0.2.0 keep "FAIR", "Linux" and
"Git". v0.3.0 is the first record with the new list (21 subjects in DataCite, read on 13 October
2026).

## Where the words live

| Place | What it holds | Who reads it |
|---|---|---|
| [`.zenodo.json`](.zenodo.json) `keywords` | this list; the only place it is edited | Zenodo, then DataCite |
| `CITATION.cff` `keywords` | a copy, written by `just citation` | GitHub's "Cite this repository" |
| `papers/closed-source/metadata.md` `keywords` | the paper's own nine keywords, printed in the PDF. They are the paper's text and do not follow this list | the reader of the PDF |
| [`GITHUB_REPO_TOPICS.md`](GITHUB_REPO_TOPICS.md) | the repository's topics on GitHub, in GitHub's spelling | GitHub's search and topic pages |
| [`ISSUE_LABELS.md`](ISSUE_LABELS.md) `topic/*` | one label for each group of keywords | people who search issues and pull requests |

## How to change the list

1. Check the two tests in "The policy". Find the place in the prose.
2. Count the room: how many records already use the exact words.

   ```sh
   curl -s -G https://zenodo.org/api/records --data-urlencode 'q=metadata.subjects.subject:"binary analysis"' \
     --data-urlencode 'size=1' -A paper-fabric | jq .hits.total
   ```

3. Edit `keywords` in `.zenodo.json`, run `just citation`, and update the table here with the
   count and the date of record.
4. If the word belongs to a group in `ISSUE_LABELS.md`, add it to that label's meaning.
5. The change is live on Zenodo after the next release.
