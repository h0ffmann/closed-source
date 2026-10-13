---
title: "GitHub repository topics"
status: draft
date: 2026-10-13
related: [KEYWORDS.md, RELATED_WORK.md, ISSUE_LABELS.md]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# GitHub repository topics

**Date of record: 13 October 2026.** On that day this repository had no topics, and the counts
below were read from GitHub's search.

## What a topic is

A topic is a word on a repository's front page, under "About". Each one is a link to a page that
lists every public repository with the same topic, and GitHub's search finds repositories by
`topic:<name>`. It is to GitHub what a keyword is to Zenodo ([`KEYWORDS.md`](KEYWORDS.md)), with
GitHub's spelling: lower case, digits and hyphens, at most 20 topics for one repository.

The policy is the same: the right reader would type it, and the work is about it
([note](notes/202610130845-seen-by-the-right-people.md)).

## The twenty topics

"Repositories" is how many public repositories carried the topic on the date of record
(`gh api -X GET search/repositories -f q='topic:<name>'`).

| Topic | Repositories | Who it is for |
|---|---:|---|
| `reverse-engineering` | 13,770 | the reverse engineer; the paper's subject |
| `decompilation` | 760 | the same reader, on the paper's first line of evidence |
| `binary-analysis` | 1,054 | the same reader, from the binary's side |
| `obfuscation` | 1,614 | the reader who hides code, and the one who reads it anyway |
| `model-extraction` | 36 | the machine-learning security reader |
| `knowledge-distillation` | 1,249 | the machine-learning reader |
| `large-language-models` | 7,543 | the reader who comes from the tools |
| `coding-agents` | 6,124 | the reader who builds agents; the paper gives them three rules |
| `ai-agents` | 113,153 | the same, in the wider word |
| `closed-source` | 88 | the paper's title; a small room that is exactly this subject |
| `proprietary-software` | 26 | the same subject, in the other word |
| `open-source` | 74,005 | the other half of the thesis |
| `licensing` | 762 | the reader who studies licences, as the writer does here |
| `software-citation` | 12 | the research-software reader; the paper's answer |
| `research-software` | 1,201 | the same reader |
| `doi` | 508 | the reader who works with identifiers |
| `zenodo` | 361 | the reader who archives on Zenodo |
| `open-science` | 2,621 | the reader who cares how research is published |
| `position-paper` | 26 | what kind of text this is |
| `preprint` | 216 | its status: not peer reviewed |

## Left out, and why

| Topic | Repositories | Why |
|---|---:|---|
| `llm` | 152,228 | `large-language-models` is the same room, and smaller |
| `security`, `cryptography` | 64,901 and 22,025 | each is a field; the paper touches it without being about it |
| `pandoc`, `gleam`, `paper` | 1,807, 669 and 5,630 | they say how the repository is built, not what it says. They would bring the wrong reader |
| `decompiler` | 722 | this repository is not one |
| `reproducible-research` | 7,992 | true of the build, not the subject |
| `trade-secrets`, `kerckhoffs-principle` | 0 | nobody is in the room yet |

## How to set them

Topics are a setting of the repository, not a file, so merging this page does not set them. The
owner sets them once:

```sh
gh repo edit h0ffmann/closed-source \
  --add-topic reverse-engineering,decompilation,binary-analysis,obfuscation,model-extraction \
  --add-topic knowledge-distillation,large-language-models,coding-agents,ai-agents,closed-source \
  --add-topic proprietary-software,open-source,licensing,software-citation,research-software \
  --add-topic doi,zenodo,open-science,position-paper,preprint
```

Check them with `gh api repos/h0ffmann/closed-source/topics --jq '.names'`. When the list
changes, change this page first, with the new count and the date of record.
