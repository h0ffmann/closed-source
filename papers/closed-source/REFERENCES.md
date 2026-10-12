---
title: Reference log for "Closed Source: The God that Failed"
status: draft
date: 2026-10-12
style: research
---

# Reference log

Every entry in [`refs.bib`](refs.bib) was fetched by the drafting agent on 2026-10-12. This log
records what was checked and how, so a reviewer can repeat the check. `scripts/refs_check.py`
fails when a `refs.bib` key has no row here, or a row's key is not in `refs.bib`.

Status values: `verified` (source fetched, details match), `partial` (source fetched, a detail
could not be confirmed), `unverified` (not fetched; must not be cited).

| Key | Status | Checked against | Note |
|---|---|---|---|
| torvalds1991minix | verified | Google Groups thread page | author, date 25 Aug 1991, quote match |
| torvalds2005git | verified | github.com/git/git commit page | author, title; root commit |
| wikipedia2026linuxhistory | verified | en.wikipedia.org | 0.01 on 17 Sep 1991; 0.95 first GPL release, Mar 1992 |
| wikipedia2026git | verified | en.wikipedia.org | dates 3, 7, 18 Apr and 26 Jul 2005; BitKeeper |
| raymond1998cathedral | verified | firstmonday.org article page | DOI is v3i2.578 (the issue page says Number 3) |
| kerckhoffs1883cryptographie | verified | petitcolas.net/kerckhoffs | volume IX, pp. 5–38 and 161–191; principle 2 in English |
| samuelson2002law | partial | yalelawjournal.org article page | vol. 111, p. 1575, May 2002; DOI not checked, so omitted |
| tramer2016stealing | verified | usenix.org presentation page | pp. 601–618 |
| carlini2024stealing | verified | arxiv.org/abs/2403.06634; proceedings.mlr.press/v235 | PMLR 235, pp. 5680–5705; Ada and Babbage, under 20 USD |
| tan2024llm4decompile | verified | arxiv.org/abs/2403.05286 | DOI from the arXiv page; "over 100%" vs GPT-4o and Ghidra |
| ince2012case | verified | Crossref; nature.com abstract | quote checked verbatim |
| hoffmann2024value | verified | aiinstitute.hbs.edu summary; SSRN link from search | WP 24-038; 4.15 billion and 8.8 trillion USD |
| nsa2019ghidra | partial | github.com/NationalSecurityAgency/ghidra | NSA Research Directorate; Apache-2.0. 2019 release year from general knowledge, not re-fetched |
| hinton2015distilling | verified | arxiv.org/abs/1503.02531 | |
| perez2026allegations | verified | techcrunch.com article | 13 Jul 2026; complaint filed 10 Jul 2026 |
| perez2026motion | verified | techcrunch.com article | 6 Aug 2026; motion to dismiss pending |
| bridgecounsels2026apple | partial | bridgecounsels.com summary | N.D. Cal., San Jose; 5:26-cv-07078 with conflicting suffixes VKD and EJD. Check PACER before v1 |
| reuters2026deepseek | verified | koreajoongangdaily.com (Reuters) | 13 Feb 2026; memo to House Select Committee on the CCP |
| anthropic2026distillation | verified | anthropic.com/news | 23 Feb 2026; 24,000 accounts, 16 million exchanges |
| smith2016software | verified | Crossref | PeerJ CS 2:e86 |
| wilkinson2016fair | verified | Crossref | Sci Data 3:160018 |
| barker2022fair4rs | verified | Crossref | Sci Data 9:622 |
| maguire2019thinking | partial | git clone of isovector/thinking-with-types | build files read; the year is the book's first edition, not checked |
| hoffmann2018chemorx | verified | git clone of h0ffmann/chemo-rx | 8 commits, 23 Mar to 25 Apr 2018 |
| hoffmann2026ww3gpu | verified | zenodo.org/records/23221351; repo CITATION.cff | concept DOI |
| hoffmann2026marola | verified | zenodo.org/records/23224155; marola-dev/marola .zenodo.json | concept DOI; creators and ORCIDs |
| hoffmann2026picasso | partial | h0ffmann/picasso CITATION.cff | Zenodo record page rate-limited; concept DOI taken from the repo's CITATION.cff |
| ouroboric2026 | verified | git clone of ouroboric-dev/ouroboric | charter quotes checked |

## Not used

- The 1949 anthology *The God That Failed* is named in the introduction as the source of the
  title's allusion, without a bibliography entry. Add a checked entry before v1.
- A doi.org or Crossref check of Samuelson and Scotchmer (2002) and Raymond (1998) was
  rate-limited; their DOIs came from the publishers' pages instead (Raymond) or were omitted
  (Samuelson and Scotchmer).
