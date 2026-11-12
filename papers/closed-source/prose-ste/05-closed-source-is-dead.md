<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Why closed source is dead: seven lines of evidence {#sec:dead}

"Dead" is a strong word, and I must say what I mean. People will sell closed-source software for a
long time. What is dead is closed source *as a protection*. This is the idea that if an artefact
stays unreadable, its value stays safe, and that this protection is worth its cost to science.

Seven references support that claim. They come from cryptography, law, machine learning, software
engineering, security, research practice and economics. I chose them for credibility. Each one is
peer reviewed, a primary legal or official source, or a working paper from a research university
that many people cite.

Table: Seven references on why secrecy fails as a protection. {#tbl:five}

| # | Reference | Field | What it shows |
|--|----------------------|----------------|------------------------------------------------------------|
| 1 | @kerckhoffs1883cryptographie | cryptography | A system must stay secure when the enemy has it. Only the key can be secret. |
| 2 | @samuelson2002law | law and economics | Reverse engineering is an old, lawful and economically useful practice. |
| 3 | @carlini2024stealing | machine learning | An attacker can extract parts of a production model behind an API for less than 20 US dollars. |
| 4 | @tan2024llm4decompile | software engineering | Language models decompile binaries into source code that compiles again and passes tests. |
| 5 | @doj2026ding | security | Secrets leave through insiders: more than two thousand pages through one cloud account. |
| 6 | @collberg2016repeatability | research practice | Only 27% of 601 computer-systems papers had code that was publicly available. |
| 7 | @ince2012case | science policy | If unpublished code calculated a result, nobody can correctly check or reproduce the result. |

**1. A refutation of security by obscurity came in 1883.** The second principle of Auguste
Kerckhoffs for military ciphers says that the system "must not require secrecy and can be stolen by
the enemy without causing trouble" [@kerckhoffs1883cryptographie]. Modern cryptography uses this
principle: the algorithms are public, and only the keys are secret. If the security of a design
depends on the secrecy of the design, cryptographers think that the design is broken before anyone
attacks it.

**2. The law accepted reverse engineering a long time ago.** At the start of their survey, Samuelson
and Scotchmer write that reverse engineering "has a long history as an accepted practice"
[@samuelson2002law]. Trade-secret law protects against improper means, for example theft and breach
of confidence. It does not protect against a person who studies a product that they obtained
lawfully.

Thus closed source never had a legal guarantee against understanding. It had a practical guarantee:
reverse engineering was slow and expensive. Section [-@sec:law] examines the laws.

**3. For models, that practical guarantee is gone.** Extraction attacks on prediction APIs
[@tramer2016stealing] developed into attacks on production language models
[@carlini2024stealing]. The providers themselves now allege distillation at a large scale
[@anthropic2026distillation; @reuters2026deepseek], and so do three US agencies
[@csa2026distillation].

**4. For binaries and full applications, it is going.** Open decompilation models recover executable
source code from compiled code [@tan2024llm4decompile]. These models use an open reverse-engineering
framework from a signals-intelligence agency [@nsa2019ghidra]. In 2026, an open tool put the full
chain behind one agent [@morluto2026rea]. After a few weeks, clean-room rebuilds of a professional
image editor were available [@storytold2026photocraft].

**5. Secrets also leak from inside.** A former Google engineer uploaded AI trade secrets to a
personal cloud account, and a jury convicted him [@doj2026ding]. A trade-secret lawsuit is about
recruitment and devices [@apple2026complaint]. A packaging error published the source of a
commercial agent [@franzen2026claudecode].

These are three different failures, with one lesson. Secrecy is a property of people and processes,
and people and processes leak.

**6. Secrecy costs science, and there are measurements of the cost.** Collberg and Proebsting tried
to get and build the code of 601 papers from eight ACM conferences and five journals. Only 27% of
the papers had code that was publicly available. The team could build the code of 32% within 30
minutes [@collberg2016repeatability].

Published code can also decay when nobody records its environment. A study examined research code
in the Harvard Dataverse. In the first run, 74% of R files did not complete without error. After
automatic code cleaning, 56% still failed [@trisovic2022code].

**7. Science policy said so years ago.** Ince and colleagues argued in *Nature* that, with few
exceptions, "anything less than the release of source programs is intolerable for results that
depend on computation" [@ince2012case]. It is now possible to measure the economic weight of the
alternative. The open source that firms use would cost about 4.15 billion US dollars to write one
time. If each firm had to replace it alone, it would cost about 8.8 trillion US dollars
[@hoffmann2024value].

**[ANALYSIS]** Lines 1 to 5 say that secrecy no longer protects. Lines 6 and 7 say that secrecy
never came free. Together, they give a researcher a choice that is no longer between *hidden* and
*exposed*. The choice is between *exposed and not credited* and *exposed and credited*. The
remaining sections of this paper are about how to choose the second.

**[ANALYSIS]** The evidence has one weak point, and I must name it. Lines 3 to 5 depend partly on
events of 2026. People still dispute some of these facts in court, or interested parties report
them. If you remove all of these events, lines 1, 2, 6 and 7 still support the argument. Each of
these is a peer-reviewed or primary source, and each is more than two years old. The events of 2026
change the speed of the argument, not its direction.
