# Why closed source is dead: five lines of evidence {#sec:dead}

"Dead" is a strong word, and I should say what I mean. Closed-source software will be sold for
a long time. What is dead is closed source *as a protection*: the idea that keeping an artefact
unreadable keeps its value safe, and that this protection is worth what it costs science. Five
references, from cryptography, law, machine learning, software engineering and economics,
support that claim. I chose them for credibility: each is peer reviewed, a primary legal or
historical source, or a widely cited working paper from a research university.

Table: Five references on why secrecy fails as a protection. {#tbl:five}

| # | Reference | Field | What it shows |
|--|----------------------|----------------|------------------------------------------------------------|
| 1 | @kerckhoffs1883cryptographie | cryptography | A system must stay secure when the enemy has it; only the key may be secret. |
| 2 | @samuelson2002law | law and economics | Reverse engineering is an old, lawful and economically useful practice. |
| 3 | @carlini2024stealing | machine learning | Parts of a production model behind an API can be extracted for under 20 US dollars. |
| 4 | @tan2024llm4decompile | software engineering | Language models decompile binaries into source that recompiles and passes tests. |
| 5 | @ince2012case | science policy | Results computed by unpublished code cannot be properly checked or reproduced. |

**1. Security by obscurity was refuted in 1883.** Auguste Kerckhoffs' second principle for
military ciphers says the system "must not require secrecy and can be stolen by the enemy without
causing trouble" [@kerckhoffs1883cryptographie]. Modern cryptography is built on the principle:
the algorithms are public, and only keys are secret. A design whose security depends on the
design staying hidden is considered broken in advance.

**2. The law has long accepted reverse engineering.** Samuelson and Scotchmer open their survey
with the observation that reverse engineering "has a long history as an accepted practice"
[@samuelson2002law]. Trade-secret law protects against improper means, such as theft and breach
of confidence, not against someone who studies a product they lawfully obtained. Closed source
therefore never had a legal guarantee against being understood. It had a practical one: reverse
engineering was slow and expensive.

**3. That practical guarantee is gone for models.** Extraction attacks on prediction APIs
[@tramer2016stealing] matured into attacks on production language models
[@carlini2024stealing], and distillation at scale is now alleged by the providers themselves
[@anthropic2026distillation; @reuters2026deepseek].

**4. It is going for binaries.** Open decompilation models, built on an open reverse-engineering
framework released by a signals-intelligence agency [@nsa2019ghidra], recover executable source
from compiled code [@tan2024llm4decompile].

**5. Meanwhile, secrecy costs science.** Ince and colleagues argued in *Nature* that, with
few exceptions, "anything less than the release of source programs is intolerable for results
that depend on computation" [@ince2012case]. The economic weight of the alternative is now
measurable: the open source that firms use would cost an estimated 4.15 billion US dollars to
write once, and about 8.8 trillion US dollars if each firm had to replace it on its own
[@hoffmann2024value].

**[ANALYSIS]** Lines 1 to 4 say that secrecy no longer protects; line 5 says that it never came
free. Together they leave a researcher with a choice that is no longer between *hidden* and
*exposed*. It is between *exposed and uncredited* and *exposed and credited*. The next section is
about choosing the second.
