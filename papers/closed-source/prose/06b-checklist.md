<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# What to do now: a checklist for a researcher in 2026 {#sec:checklist}

The argument of this paper ends in practice. I close the argument with a checklist that any
researcher, research group or small laboratory can follow in a week. Each item names the section
where its reason is given. None of it requires permission from anyone.

## Publish

1. **Publish the method with the result.** Put the code, the configuration and the environment
   that produced a result in a public repository, under a licence that allows reuse
   (Sections [-@sec:dead] and [-@sec:openweights]).
2. **Record the environment, not only the code.** Pin the versions of every tool, for example with
   a lock file or a Nix flake, so that the code still runs when its dependencies move; published
   code that does not run is only half open (Section [-@sec:dead]).
3. **Keep secret only what must be secret.** Keys, credentials, personal data and material under
   agreement stay private and encrypted; the method does not (Sections [-@sec:securing] and
   [-@sec:limits]).

## Protect

4. **Sign what you publish.** Sign commits and tags, keep the signing key on a hardware token, and
   turn on two-factor authentication on the forge (Section [-@sec:securing]).
5. **Name artefacts by their hash.** Cite code by a content hash, such as a commit or a SWHID, as
   well as by a DOI (Sections [-@sec:securing] and [-@sec:citing]).
6. **Do not rely on obfuscation.** If a product must ship as a binary, obfuscation can raise an
   attacker's cost; it cannot keep a method secret, and it costs the owner too (Section
   [-@sec:securing]).

## Cite

7. **Mint identifiers.** Archive each release and get a concept DOI and a version DOI; add a
   `CITATION.cff` so that a citation can be generated rather than typed (Section [-@sec:citing]).
8. **Cite at the point of use, and propagate.** Put each borrowed element's citation where it is
   used, and list the cited works as related identifiers in the archive record (Section
   [-@sec:citing]).
9. **Check every reference.** Fetch each source before it is cited, and keep a log of the check;
   never let an agent cite what it did not fetch (Sections [-@sec:citing] and [-@sec:fabric]).

## Configure the agents

10. **Write the rules down.** Give every agent that works on the repository an `AGENTS.md` with the
    three rules of Section [-@sec:citing], and make the build fail when a rule is broken.
11. **Mark what is interpretation.** Ask agents to separate facts from analysis, and to leave a
    marker where only the author's own experience can fill a gap, rather than invent it
    (Section [-@sec:fabric]).
12. **Study others lawfully, and say so.** When an agent studies another product, keep to what you
    lawfully hold, prefer a clean room, and cite what was studied (Sections [-@sec:law] and
    [-@sec:espionage]).

**[ANALYSIS]** The list is short on purpose. Each item costs minutes or hours, once. Each protects
something that secrecy cannot: that the work can be checked, that it is the author's, and that the
author is credited when it is used. In the world that the REA explosion has made, those are the
only protections that still work.
