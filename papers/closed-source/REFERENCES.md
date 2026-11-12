---
title: 'Reference log for "Closed Source: The God that Failed"'
status: draft
date: 2026-10-12
style: research
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Reference log

Every entry in [`refs.bib`](refs.bib) was fetched by the drafting agent on 2026-10-12. This log
records what was checked and how, so a reviewer can repeat the check. `tools/fabric refs-check`
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
| samuelson2002law | verified | yalelawjournal.org article page; Crossref (12 Nov 2026) | vol. 111, no. 7, p. 1575, May 2002; DOI 10.2307/797533 from Crossref |
| tramer2016stealing | verified | usenix.org presentation page | pp. 601–618 |
| carlini2024stealing | verified | arxiv.org/abs/2403.06634; proceedings.mlr.press/v235 | PMLR 235, pp. 5680–5705; Ada and Babbage, under 20 USD |
| tan2024llm4decompile | verified | arxiv.org/abs/2403.05286 | DOI from the arXiv page; "over 100%" vs GPT-4o and Ghidra |
| ince2012case | verified | Crossref; nature.com abstract | quote checked verbatim |
| hoffmann2024value | verified | aiinstitute.hbs.edu summary; SSRN link from search | WP 24-038; 4.15 billion and 8.8 trillion USD |
| nsa2019ghidra | verified | github.com/NationalSecurityAgency/ghidra; axios.com (uchill2019ghidra) | NSA Research Directorate; Apache-2.0. Release on 5 Mar 2019 confirmed by uchill2019ghidra on 12 Nov 2026 |
| hinton2015distilling | verified | arxiv.org/abs/1503.02531 | |
| perez2026allegations | verified | techcrunch.com article | 13 Jul 2026; complaint filed 10 Jul 2026 |
| perez2026motion | verified | techcrunch.com article | 6 Aug 2026; motion to dismiss pending |
| bridgecounsels2026apple | partial | bridgecounsels.com summary | N.D. Cal., San Jose; 5:26-cv-07078. The number is now confirmed by the complaint (apple2026complaint) and the judge, Edward Davila (EJD), by mekelburg2026court; no longer cited in the prose |
| reuters2026deepseek | verified | koreajoongangdaily.com (Reuters) | 13 Feb 2026; memo to House Select Committee on the CCP |
| anthropic2026distillation | verified | anthropic.com/news | 23 Feb 2026; 24,000 accounts, 16 million exchanges |
| smith2016software | verified | Crossref | PeerJ CS 2:e86 |
| wilkinson2016fair | verified | Crossref | Sci Data 3:160018 |
| barker2022fair4rs | verified | Crossref | Sci Data 9:622 |
| maguire2019thinking | partial | git clone of isovector/thinking-with-types | build files read; the year is the book's first edition, not checked |
| hoffmann2026ww3gpu | verified | zenodo.org/records/23221351; repo CITATION.cff | concept DOI |
| hoffmann2026marola | verified | zenodo.org/records/23224155; marola-dev/marola .zenodo.json | concept DOI; creators and ORCIDs checked; cited as "Hoffmann and others" on the paper owner's instruction (12 October 2026) |
| hoffmann2026picasso | partial | h0ffmann/picasso CITATION.cff | Zenodo record page rate-limited; concept DOI taken from the repo's CITATION.cff |
| ouroboric2026 | verified | git clone of ouroboric-dev/ouroboric | charter quotes checked |
| nash1950equilibrium | verified | Crossref | PNAS 36(1):48–49 |
| nash1955letters | partial | media.defense.gov PDF | dates Jan–Mar 1955 and NSA quote "affords only limited security" checked; OCR too poor for Nash's own text |
| branwen2012nash | partial | gwern.net transcription | Nash's "exponentially" quote taken from this transcription (the transcriber marks one word as uncertain); NSA declassification in 2012 stated here |
| rivest2012nash | verified | iacr.org rump-session page | chosen-plaintext polynomial, known-plaintext subexponential; "a much better game theorist than a cryptographer" |
| barak2012impossibility | verified | Crossref; author's PDF abstract | JACM 59(2):1–48; virtual black box definition |
| hoffmann2026nashkell | verified | git clone of h0ffmann/nashkell; its record on Zenodo (concept DOI 10.5281/zenodo.23356739, a book, CC BY 4.0), read from Zenodo's API on 14 October 2026 | README and README-latinizer: filter design and stated limitations, quotes checked; the DOI added on 14 October 2026 |
| chacon2014signing | verified | git-scm.com Pro Git chapter | GnuPG signing, merge --verify-signatures |
| git2021relnotes234 | verified | git/git RelNotes 2.34.0 | ssh keys can sign |
| git2020relnotes229 | verified | git/git RelNotes 2.29.0 | SHA-256 marked experimental |
| openssh2020release82 | verified | openssh.org release notes | 14 Feb 2020; ecdsa-sk, ed25519-sk |
| hanley2022twofactor | verified | github.blog | 4 May 2022; 2FA for code contributors by end of 2023 |
| newman2022sigstore | verified | Crossref; abstract via sos-vo.org | CCS '22 pp. 2353–2367; ephemeral keys, OIDC identity, transparency logs |
| stevens2017first | verified | link.springer.com | CRYPTO 2017, LNCS 10401 |
| pirsig1974zen | partial | openlibrary.org/isbn/0688002307 (edition); todayinsci.com, Pirsig quotations (sentence and page) | read 18 Oct 2026: Morrow, New York, 1974, 418 pp., ISBN 0688002307. The sentence on p. 107 matches a second online copy of chapter 10; not yet read in a printed copy |

Rows added on 2026-11-12, for the expansion to 33 pages; every source was fetched that day.

| Key | Status | Checked against | Note |
|---|---|---|---|
| crossman1949god | partial | en.wikipedia.org (The God that Failed); openlibrary.org/books/OL6067302M | editor Crossman, Harper & Brothers, six contributors; Wikipedia gives 1949, Open Library's first US edition is 1950 (LCCN 50005050) |
| apple2026complaint | verified | courthousenews.com copy of the complaint (Document 1) | caption, Case No. 5:26-cv-07078, N.D. Cal. San Jose, filed 10 Jul 2026, six counts; quote of para. 53 checked |
| perez2026hiring | verified | techcrunch.com article | 13 Oct 2026; Judge Davila; expedited access to hiring records, three depositions |
| mekelburg2026court | verified | claimsjournal.com (Bloomberg News) | 14 Oct 2026; case 5:26-cv-07078, Apple v. Liu; OpenAI quote checked |
| mendes2026agrees | verified | 9to5mac.com article | 14 Oct 2026; stipulation, 14 employees' devices, "highly likely" |
| mendes2026trial | verified | 9to5mac.com article | 28 Oct 2026; trial 19 Jul 2027; motion to dismiss not mentioned |
| doj2026ding | verified | justice.gov press release | 30 Jan 2026; verdict the day before; 7 + 7 counts; quotes checked |
| debenedetti2026ding | verified | kqed.org article | 1 Sep 2026; Judge Chhabria; just under one year |
| franzen2026claudecode | verified | venturebeat.com article | 31 Mar 2026; v2.1.88; 59.8 MB source map; ~512,000 lines; statement quoted |
| fernholz2026takedown | verified | techcrunch.com article | 1 Apr 2026; ~8,100 repositories; one repository and 96 forks kept |
| csa2026distillation | partial | labs.cloudsecurityalliance.org research note | advisory AA26-251A, 8 Sep 2026, six firms; quote checked in the note. The advisory itself was not fetched from cisa.gov |
| lakshmanan2026agencies | verified | thehackernews.com article | 9 Sep 2026; NSA, CISA, FBI; firms and quote checked |
| anthropic2025espionage | verified | anthropic.com/news | 13 Nov 2025; quotes "80-90%", "roughly thirty" checked |
| liu2026recompile | verified | arxiv.org/abs/2609.05370 | 4 Sep 2026; 4.9%, ~13%, 75 to 90%, 74 to 62% |
| tan2025decompilebench | verified | arxiv.org/abs/2505.12668 | two million pairs, 450GB, 20% |
| guo2025deepseekr1 | verified | pmc.ncbi.nlm.nih.gov (PMC12443585) | Nature 645(8081):633-638, 17 Sep 2025; 15.6% to 77.9%; release quote checked |
| openai2025gptoss | verified | openai.com/index/introducing-gpt-oss | 5 Aug 2025; Apache 2.0; 117B/5.1B and 21B/3.6B; quote checked |
| osi2024osaid | verified | opensource.org/ai/open-source-ai-definition | v1.0, 28 Oct 2024; four freedoms quoted |
| freund2024xz | verified | openwall.com oss-security archive | 29 Mar 2024; quote; 0.299 s and 0.807 s |
| durumeric2014heartbleed | verified | Crossref; author PDF at nebelwelt.net | IMC '14 pp. 475-488; 31 Dec 2011, 14 Mar 2012, 7 Apr 2014; 24-55% quote |
| collberg2016repeatability | verified | Crossref; acawiki.org summary | CACM 59(3):62-69; 601 papers, 27%, 32% |
| trisovic2022code | verified | nature.com article page | Sci Data 9:60; 74% and 56% |
| gptzero2026neurips | verified | gptzero.me/news/neurips | 21 Jan 2026; 4,841 papers; 100 hallucinated citations |
| ansari2026compound | verified | arxiv.org/abs/2602.05930 | 5 Feb 2026; 100 citations in 53 papers, ~1%; 3 to 5 reviewers |
| swh2026swhid | verified | softwareheritage.org news | 23 Apr 2026; ISO/IEC 18670 published Apr 2025 |
| usc2016dtsa | verified | law.cornell.edu 18 U.S.C. 1839 | para. (6) quoted |
| eu2016tradesecrets | verified | eur-lex.europa.eu (metadata); legislation.gov.uk (text of art. 3) | Art. 3(1)(a) and (b) quoted |
| brasil1998software | verified | legis.senado.leg.br | Art. 6, items II and III quoted in Portuguese |
| uchill2019ghidra | verified | axios.com article | 5 Mar 2019; RSA Conference |
| morluto2026rea | partial | github.com/morluto/rea, read 12 Nov 2026 | MIT; description and README quotes checked; star and fork counts are that day's; start in April 2026 is from secondary reports |
| storytold2026photocraft | verified | github.com/storytold/photocraft, read 12 Nov 2026 | MIT OR Apache-2.0; clean-room and status quotes checked |
| storytold2026craftanything | verified | github.com/storytold/craft-anything, read 12 Nov 2026 | four steps, clean room and Deep modes, usage rules |
| jonas2026rebuilt | verified | innfactory.ai blog | 13 Oct 2026; first commit 30 Sep 2026; 134 of 135 files |
| akita2026adobe | verified | akitaonrails.com article | 13 Oct 2026; REA wraps Ghidra, Hopper, IDA, JADX, Frida, Playwright |
| claburn2026blinding | verified | theregister.com article | 10 Nov 2026; Blind LLM Agents; quote checked |
| gates1976letter | verified | digibarn.com transcription | 3 Feb 1976; Homebrew newsletter vol. 2 no. 1; three quotes checked |
| stallman1983gnu | verified | gnu.org/gnu/initial-announcement | 27 Sep 1983; quote checked |
| netscape1998source | partial | lkml.indiana.edu forward of the press release | 22 Jan 1998; two quotes checked; the release's own headline is not in the forward, title taken from secondary listings |
| ssi2021unesco | partial | software.ac.uk news | Nov 2021, 193 member states; quote is the SSI's paraphrase, the Recommendation's text was not fetched |
| casrai2022nelson | partial | casrai.org summary | Aug 2022, Alondra Nelson; quotes checked in the summary; the memo itself was not fetched from whitehouse.gov |

## Not used

- The 1949 anthology *The God That Failed* now has an entry, `crossman1949god` (12 November 2026).
- A doi.org or Crossref check of Samuelson and Scotchmer (2002) and Raymond (1998) was
  rate-limited; their DOIs came from the publishers' pages instead (Raymond) or were omitted
  (Samuelson and Scotchmer).
