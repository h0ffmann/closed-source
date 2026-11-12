<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# What to do now: a checklist for a researcher in 2026 {#sec:checklist}

The argument of this paper ends in practice. Thus I end with a checklist. Any researcher,
research group or small laboratory can do it in one week. Each item names the section that gives
its reason. Nothing in it needs permission from anyone.

## Publish

1. **Publish the method with the result.** Put the code, the configuration and the environment that
   produced a result in a public repository. Use a licence that permits reuse
   (Sections [-@sec:dead] and [-@sec:openweights]).
2. **Record the environment, not only the code.** Pin the version of each tool, for example with a
   lock file or a Nix flake. Then the code still runs when its dependencies change. Published code
   that does not run is only half open (Section [-@sec:dead]).
3. **Keep secret only what must be secret.** Keys, credentials, personal data and material under
   agreement stay private and encrypted. The method does not stay secret (Sections
   [-@sec:securing] and [-@sec:limits]).

## Protect

4. **Sign what you publish.** Sign commits and tags. Keep the signing key on a hardware token. Enable
   two-factor authentication on the forge (Section [-@sec:securing]).
5. **Name artefacts by their hash.** Cite code by a content hash, for example a commit or a SWHID,
   and also by a DOI (Sections [-@sec:securing] and [-@sec:citing]).
6. **Do not use obfuscation as protection.** If a product must ship as a binary, obfuscation can make
   the cost higher for an attacker. It cannot keep a method secret, and it also costs the owner
   (Section [-@sec:securing]).

## Cite

7. **Get identifiers.** Archive each release, and get a concept DOI and a version DOI. Add a
   `CITATION.cff`, so that tools can make a citation and nobody must type it (Section
   [-@sec:citing]).
8. **Cite at the point of use, and propagate.** Put the citation of each borrowed element where you
   use it. List the cited works as related identifiers in the archive record (Section
   [-@sec:citing]).
9. **Check each reference.** Fetch each source before you cite it, and keep a log of the check.
   Never let an agent cite a source that it did not fetch (Sections [-@sec:citing] and
   [-@sec:fabric]).

## Configure the agents

10. **Write the rules.** Give each agent that works on the repository an `AGENTS.md` with the three
    rules of Section [-@sec:citing]. Make the build fail when an agent breaks a rule.
11. **Mark interpretation.** Tell agents to keep facts and analysis separate. Where only the
    experience of the author can fill a gap, tell agents to leave a marker and not to invent the
    experience (Section [-@sec:fabric]).
12. **Study other products lawfully, and say so.** When an agent studies a different product, use
    only what you hold lawfully, prefer a clean room, and cite what the agent studied (Sections
    [-@sec:law] and [-@sec:espionage]).

**[ANALYSIS]** The list is short on purpose. Each item costs minutes or hours, one time. Each item
protects something that secrecy cannot protect. Others can check the work, the work is the work of
the author, and the author gets credit when people use it. After the REA explosion, these are the
only protections that still work.