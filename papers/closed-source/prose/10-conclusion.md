# Conclusion {#sec:conclusion}

Closed source asked researchers to trust that secrecy would protect their work. Between 2024 and
2026 that trust failed in public: binaries decompiled by language models, production models read
through their own answers, capability copied through the front door, and the biggest trade-secret
fight in the field fought over laptops and job interviews. Linux and Git showed long ago that the
alternative works at scale.

What remains is a question of manners, made urgent by machines. If anyone can reverse engineer
anything, the honest course is to publish the method, mint an identifier, and cite whatever you
use, and to require the same of the agents that now do much of the reading and writing. Paper
Fabric is my attempt to make that course the default for my own work. Its source, its agent
configuration and its known defects are published with this paper.

# Statements {.unnumbered}

**Authorship.** The cover names Mr. Nobody. I, Matheus Hoffmann, wrote this paper in the first
person, and the citation metadata names me.

**Acknowledgements.** The ouroboric ideas in this paper are Bruno Valério's [@ouroboric2026].

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
