<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Evidence register: how strong is each 2026 claim? {#sec:evidence}

Rule 2 of Section [-@sec:citing] asks that a citation say how someone checked it. The reference log
of the repository does this for each entry. This section gives the reader the short form for the
claims that are the most important and the most recent. Thus the reader can weigh each claim by the
type of its source. *Primary* means the document itself: a court filing, a law, a press release by
the party, a repository or a paper. *Report* means a news or analysis article about the document.
*Allegation* means a claim that a court did not test yet. I fetched each source on 12 November 2026,
unless the reference log gives a different date.

Table: The 2026 evidence by type of source and status. {#tbl:evidence}

| Claim | Source | Kind | Status |
|----------------------------|--------------|--------|----------|
| Apple sued OpenAI, io and two former employees on 10 July 2026 | @apple2026complaint | primary | allegation |
| Over four hundred former Apple employees work at OpenAI | @apple2026complaint | primary | allegation |
| The court gave fast discovery | @perez2026hiring | report | ruling |
| OpenAI agreed not to use the alleged secrets | @mendes2026agrees | report | stipulation |
| Trial on 19 July 2027 | @mendes2026trial | report | order |
| Conviction of Ding on seven plus seven counts | @doj2026ding | primary | verdict |
| Sentence of Ding: a little less than one year | @debenedetti2026ding | report | sentence |
| A source map exposed the Claude Code source | @franzen2026claudecode | report | admitted |
| The takedown affected about 8,100 repositories | @fernholz2026takedown | report | admitted |
| Three laboratories distilled Claude at scale | @anthropic2026distillation | primary | allegation |
| Advisory AA26-251A names six firms | @csa2026distillation | report | allegation |
| An agent did most of an espionage campaign | @anthropic2025espionage | primary | assessment |
| LLM decompilers are different in 4.9% of tested cases | @liu2026recompile | primary | preprint |
| 100 fabricated citations in NeurIPS 2025 papers | @gptzero2026neurips | primary | audit |
| REA, its licence and its limits | @morluto2026rea | primary | repository |
| PhotoCraft is a clean-room reimplementation | @storytold2026photocraft | primary | self-described |
| An obfuscator against agents makes the cost higher | @claburn2026blinding | report | self-described |
| Open source AI must give parameters, code and data information | @osi2024osaid | primary | definition |
| *Nature* published DeepSeek-R1 in September 2025 | @guo2025deepseekr1 | primary | peer-reviewed |
| The SWHID is the standard ISO/IEC 18670 | @swh2026swhid | primary | standard |
| The law of the US and the EU accepts reverse engineering as a lawful means | @usc2016dtsa; @eu2016tradesecrets | primary | statute |
| The law of Brazil permits functional similarity and cited partial use | @brasil1998software | primary | statute |

**[ANALYSIS]** The table shows where the argument is strong and where it waits for others. The legal
texts, the conviction, the peer-reviewed papers and the repositories are firm. The Apple case and
the distillation accusations are allegations, and I read the advisory through reports. The two
admitted events, the leak and the takedown, are firm about what occurred. They say nothing about
intent.

**[ANALYSIS]** A reader can remove each row with the status *allegation*. The reader still keeps the
conviction, the leak, the audit, the decompilation studies and the repositories. The argument of
Section [-@sec:dead] still stands on them.

**[ANALYSIS]** A register like this is cheap to keep, but position papers do not usually have one. I
include it because the subject of the paper is credit. A paper about credit must show its own
credit.
