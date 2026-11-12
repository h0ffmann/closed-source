<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Conclusion {#sec:conclusion}

Closed source asked researchers to trust secrecy to protect their work. Between 2024 and 2026, that
trust failed in public. Language models decompiled binaries, and production models were read through
their own answers. Capability was copied through the front door.

A trade-secret dispute between two of the most valuable companies in the field was about laptops
and job interviews. A build step published the source of a commercial agent. In a few weeks, an
agent built a part of a professional image editor again from its behaviour. Linux and Git showed
long ago that the alternative works at scale, and the closed laboratories themselves started to
publish weights and methods.

The law did not promise a different result. In the United States, the European Union and Brazil, it
is a lawful means to study a product that you hold lawfully. Improper means, for example theft,
bribery and breach of duty, are not lawful. Cryptography did not promise a different result. Since
Kerckhoffs, and in the letters of Nash, the method is public and only the key is secret. In 2026, we
can protect integrity and identity, with signed commits, keys in hardware, and content hashes that
are also citations.

What remains is a question of manners, and machines make it urgent. If anyone can reverse engineer
anything, the honest course is this: publish the method, mint an identifier, and cite all that you
use. The course also includes a requirement: the agents that now read and write much of the text
must do the same. Paper Fabric is my attempt to make that course the default for my own work. Its
source, its agent configuration and its known defects are published with this paper.

**[ANALYSIS]** The writers of 1949 did not leave their faith because they found a better faith. They
left because what they saw did not agree with the promise [@crossman1949god]. The faith in closed
source fails in the same way. It promised that what was hidden would stay hidden.

**[ANALYSIS]** Between 2024 and 2026, the record shows a model that read a binary, and a model that
people read through its answers. It shows a commercial agent that its own build published, and an
application that people partly built again from its behaviour. It also shows secrets that trusted
people took away.

**[ANALYSIS]** The faith also promised that the cost of secrecy fell on nobody. The record shows
code that nobody can find, methods that nobody can run, and references that nobody can check.

**[ANALYSIS]** The sentence of Pirsig gives the reason why the alternative is most important for
science. The hypotheses that can explain a phenomenon have no end [@pirsig1974zen, p. 107]. Thus no
owner can test them all. Each method that only its owner can open is a hypothesis that other
people cannot test. Openness is not a gift from science to business. It is the condition that lets
science continue.

**[ANALYSIS]** The remaining work is small and concrete. Publish the method. Sign it. Give it an
identifier and a hash. Cite what it stands on, at the point of use.

**[ANALYSIS]** Make the agents that help you do the same, mechanically, with a build that fails when
they do not. Then the question of 2026, *can anyone reverse engineer my work?*, has a calm answer:
yes. And when they do, they will know whose work it is.

# Statements {.unnumbered}

**Authorship.** The cover gives the name Mr. Nobody. I, Matheus Hoffmann, wrote this paper in the
first person. The citation metadata gives my name.

**Acknowledgements.** The ouroboric ideas in this paper are from Bruno Valério [@ouroboric2026].

**Use of AI.** A Claude coding agent (Anthropic) produced the structure, prose drafts, reference
checks, build tools and repository configuration of this v0. The agent worked in a Claude project,
under my direction. The agent fetched and checked each reference when the paper was written.

The reference log of the repository records these checks. The agent configuration is published in
the `.claude/` directory of the repository. I am responsible for the content.

**Competing interests.** I maintain the open-source projects that Section
[-@sec:related] cites. Section [-@sec:espionage] cites reports by Anthropic. Anthropic also makes
the model that drafted this paper. I declare no other competing interests.

**Availability.** Source, build pipeline and agent configuration:
<https://github.com/h0ffmann/closed-source>. Licence: text CC BY 4.0; build scripts AGPL-3.0-only;
LaTeX template MIT.

# References {.unnumbered}

::: {#refs}
:::
