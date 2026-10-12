<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Why closed source is dead: five lines of evidence {#sec:dead}

"Dead" is a strong word, and I should say what I mean. Closed-source software will be sold for a
long time. What is dead is closed source *as a protection*: the idea that if an artefact stays
unreadable, its value stays safe. It is also the idea that this protection is worth its cost to
science. Five references from cryptography, law, machine learning, software engineering and
economics support this claim. I chose them for credibility: each is peer reviewed, a primary legal
or historical source, or a widely cited working paper from a research university.

Table: Five references on why secrecy fails as a protection. {#tbl:five}

| # | Reference | Field | What it shows |
|--|----------------------|----------------|------------------------------------------------------------|
| 1 | @kerckhoffs1883cryptographie | cryptography | A system must stay secure when the enemy has it; only the key may be secret. |
| 2 | @samuelson2002law | law and economics | Reverse engineering is an old, lawful and economically useful practice. |
| 3 | @carlini2024stealing | machine learning | Parts of a production model behind an API can be extracted for under 20 US dollars. |
| 4 | @tan2024llm4decompile | software engineering | Language models decompile binaries into source that recompiles and passes tests. |
| 5 | @ince2012case | science policy | Results computed by unpublished code cannot be properly checked or reproduced. |

**1. Security by obscurity was refuted in 1883.** Auguste Kerckhoffs' second principle for military
ciphers says that the system "must not require secrecy and can be stolen by the enemy without
causing trouble" [@kerckhoffs1883cryptographie]. Modern cryptography has this principle as its base:
the algorithms are public, and only the keys are secret. A design is considered broken in advance if
its security needs the design to stay hidden.

**2. The law accepted reverse engineering long ago, and accepts it now.** Samuelson and Scotchmer
start their survey with the observation that reverse engineering "has a long history as an accepted
practice" [@samuelson2002law]. Trade-secret law gives protection against improper means, such as
theft and breach of confidence. It does not give protection against a person who studies a product
that they lawfully obtained. Thus closed source never had a legal guarantee that nobody would
understand it. It had a practical guarantee: reverse engineering was slow and expensive.

**3. That practical guarantee is gone for models.** Extraction attacks on prediction APIs
[@tramer2016stealing] developed into attacks on production language models [@carlini2024stealing].
Now the providers themselves allege distillation at scale [@anthropic2026distillation;
@reuters2026deepseek].

**4. For binaries, it starts to disappear.** Open decompilation models recover executable source
from compiled code [@tan2024llm4decompile]. These models use an open reverse-engineering framework
that a signals-intelligence agency released [@nsa2019ghidra].

**5. At the same time, secrecy costs science.** Ince and colleagues argued in *Nature* that, with
few exceptions, "anything less than the release of source programs is intolerable for results that
depend on computation" [@ince2012case]. Now it is possible to measure the economic weight of the
alternative. The open source that firms use would cost an estimated 4.15 billion US dollars to write
once. If each firm had to replace it alone, the cost would be about 8.8 trillion US dollars
[@hoffmann2024value].

**[ANALYSIS]** Lines 1 to 4 say that secrecy no longer protects. Line 5 says that secrecy was never
free. Together they leave a researcher with a choice that is no longer between *hidden* and
*exposed*. It is between *exposed and uncredited* and *exposed and credited*. The next section is
about the choice of the second option.
