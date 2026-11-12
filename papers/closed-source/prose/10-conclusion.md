<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Conclusion {#sec:conclusion}

Closed source asked researchers to trust that secrecy would protect their work. Between 2024 and
2026 that trust failed in public: binaries decompiled by language models, production models read
through their own answers, capability copied through the front door, a commercial agent's source
published by a build step, a professional image editor rebuilt from its behaviour in weeks, and
the biggest trade-secret fight in the field fought over laptops and job interviews. Linux and Git
showed long ago that the alternative works at scale, and the closed laboratories themselves began
to publish weights and methods.

The law did not promise otherwise. In the United States, the European Union and Brazil, studying a
product one lawfully holds is a lawful means; only theft, bribery and breach of duty are not.
Cryptography did not promise otherwise either: since Kerckhoffs, and in Nash's letters, the method
is public and only the key is secret. What can be protected in 2026 is integrity and identity,
with signed commits, keys in hardware and content hashes that double as citations.

What remains is a question of manners, made urgent by machines. If anyone can reverse engineer
anything, the honest course is to publish the method, mint an identifier, and cite whatever you
use, and to require the same of the agents that now do much of the reading and writing. Paper
Fabric is my attempt to make that course the default for my own work. Its source, its agent
configuration and its known defects are published with this paper.

**[ANALYSIS]** The writers of 1949 did not leave their faith because they found a better one. They
left because what they had been promised did not match what they saw [@crossman1949god]. The
faith in closed source fails in the same way. It promised that what was hidden would stay
hidden, and between 2024 and 2026 the record shows a binary read by a model, a model read through
its answers, a commercial agent published by its own build, an application rebuilt from its
behaviour, and secrets carried out by the people trusted with them. It promised that the cost of
secrecy fell on nobody, and the record shows code that cannot be found, methods that cannot be
run, and references that cannot be checked.

**[ANALYSIS]** Pirsig's sentence gives the reason why the alternative matters most for science.
If the hypotheses that can explain a phenomenon have no end [@pirsig1974zen, p. 107], then no
owner can test them all, and every method that only its owner can open is a hypothesis that the
rest of us cannot test. Openness is not a gift that science gives to business. It is the condition
under which science can go on at all.

**[ANALYSIS]** The work that remains is modest and concrete. Publish the method. Sign it. Give it
an identifier and a hash. Cite what it stands on, at the point of use, and make the agents that
help you do the same, mechanically, with a build that fails when they do not. Do this, and the
question of 2026, *can anyone reverse engineer my work?*, has a calm answer: yes, and when they do,
they will know whose it is.

# Statements {.unnumbered}

**Authorship.** The cover names Mr. Nobody. I, Matheus Hoffmann, wrote this paper in the first
person, and the citation metadata names me.

**Acknowledgements.** The idea of a self-improving factory in this paper is Bruno Valério's.

**Use of AI.** The structure, prose drafts, reference checks, build tooling and repository
configuration of this v0 were produced by a Claude coding agent (Anthropic) working in a Claude
project, under my direction. Every reference was fetched and checked by the agent at
the time of writing; the checks are recorded in the repository's reference log. The agent
configuration is published in the repository's `.claude/` directory. I am responsible
for the content.

**Competing interests.** I maintain the open-source projects cited in Section
[-@sec:related]. Anthropic, whose report is cited in Section [-@sec:espionage], also makes the
model that drafted this paper. I declare no other competing interests.

**Availability.** Source, build pipeline and agent configuration:
<https://github.com/h0ffmann/closed-source>. Licence: text CC BY 4.0; build scripts AGPL-3.0-only;
LaTeX template MIT.

# References {.unnumbered}

::: {#refs}
:::
