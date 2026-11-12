<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Evidence register: how strong is each 2026 claim? {#sec:evidence}

Rule 2 of Section [-@sec:citing] asks that a citation say how it was checked. The repository's
reference log does this for every entry. This section gives the reader the short form for the
claims that carry the most weight and are the most recent, so that each can be weighed by the kind
of source behind it. *Primary* means the document itself: a court filing, a statute, a press
release by the party, a repository or a paper. *Report* means a news or analysis article about the
document. *Allegation* means a claim not yet tested by a court. Every source was fetched on 12
November 2026 unless the reference log says otherwise.

Table: The 2026 evidence by kind of source and status. {#tbl:evidence}

| Claim | Source | Kind | Status |
|----------------------------|--------------|--------|----------|
| Apple sued OpenAI, io and two former employees on 10 July 2026 | @apple2026complaint | primary | allegation |
| Over four hundred former Apple employees work at OpenAI | @apple2026complaint | primary | allegation |
| The court granted expedited discovery | @perez2026hiring | report | ruling |
| OpenAI agreed not to use the alleged secrets | @mendes2026agrees | report | stipulation |
| Trial set for 19 July 2027 | @mendes2026trial | report | order |
| Ding convicted on seven plus seven counts | @doj2026ding | primary | verdict |
| Ding sentenced to just under one year | @debenedetti2026ding | report | sentence |
| Claude Code source exposed by a source map | @franzen2026claudecode | report | admitted |
| Takedown reached some 8,100 repositories | @fernholz2026takedown | report | admitted |
| Three laboratories distilled Claude at scale | @anthropic2026distillation | primary | allegation |
| Six firms named in advisory AA26-251A | @csa2026distillation | report | allegation |
| Agent performed most of an espionage campaign | @anthropic2025espionage | primary | assessment |
| LLM decompilers diverge in 4.9% of tested cases | @liu2026recompile | primary | preprint |
| 100 fabricated citations in NeurIPS 2025 papers | @gptzero2026neurips | primary | audit |
| REA and its licence and limits | @morluto2026rea | primary | repository |
| PhotoCraft is a clean-room reimplementation | @storytold2026photocraft | primary | self-described |
| An obfuscator against agents raises the cost | @claburn2026blinding | report | self-described |
| Open source AI needs parameters, code and data information | @osi2024osaid | primary | definition |
| DeepSeek-R1 published in *Nature* in September 2025 | @guo2025deepseekr1 | primary | peer-reviewed |
| The SWHID is the standard ISO/IEC 18670 | @swh2026swhid | primary | standard |
| US and EU law treat reverse engineering as a lawful means | @usc2016dtsa; @eu2016tradesecrets | primary | statute |
| Brazilian law permits functional similarity and cited partial use | @brasil1998software | primary | statute |

**[ANALYSIS]** The table shows where the argument is strong and where it waits on others. The
legal texts, the conviction, the peer-reviewed papers and the repositories are firm. The Apple
case and the distillation accusations are allegations, and the advisory is read through reports.
The two admitted events, the leak and the takedown, are firm on what happened and say nothing of
intent. A reader who discards every row marked *allegation* still keeps the conviction, the leak,
the audit, the decompilation studies and the repositories, and the argument of Section
[-@sec:dead] still stands on them.

**[ANALYSIS]** A register like this is cheap to keep and rare in position papers. I include it
because the subject of the paper is credit, and a paper about credit should show its own.
