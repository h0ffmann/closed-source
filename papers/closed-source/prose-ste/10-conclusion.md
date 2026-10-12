# Conclusion {#sec:conclusion}

Closed source asked researchers to trust secrecy to protect their work. Between 2024 and 2026, that
trust failed in public. Language models decompiled binaries, and production models were read
through their own answers. Capability was copied through the front door. The biggest trade-secret
dispute in the field was about laptops and job interviews. Linux and Git showed long ago that the
alternative works at scale.

What remains is a question of manners, and machines make it urgent. If anyone can reverse engineer
anything, the honest course is this: publish the method, mint an identifier, and cite all that you
use. The course also includes a requirement: the agents that now read and write much of the text
must do the same. Paper Fabric is my attempt to make that course the default for my own work. Its
source, its agent configuration and its known defects are published with this paper.

# Statements {.unnumbered}

**Authorship.** The cover gives the name Mr. Nobody. I, Matheus Hoffmann, wrote this paper in the
first person. The citation metadata gives my name.

**Acknowledgements.** The ouroboric ideas in this paper are from Bruno Valério [@ouroboric2026].

**Use of AI.** A Claude coding agent (Anthropic) produced the structure, prose drafts,
reference checks, build tools and repository configuration of this v0. The agent worked
in a Claude project, under my direction. The agent fetched and checked each
reference when the paper was written. The reference log of the repository records these checks.
The agent configuration is published in the `.claude/` directory of the repository. I am
responsible for the content.

**Competing interests.** I maintain the open-source projects that Section
[-@sec:related] cites. Section [-@sec:espionage] cites a report by Anthropic. Anthropic also makes
the model that drafted this paper. I declare no other competing interests.

**Availability.** Source, build pipeline and agent configuration:
<https://github.com/h0ffmann/closed-source>. Licence: text CC BY 4.0; build scripts AGPL-3.0-only;
LaTeX template MIT.

# References {.unnumbered}

::: {#refs}
:::
