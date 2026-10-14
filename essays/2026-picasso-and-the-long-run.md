---
title: "picasso, and the long run"
type: essay
status: draft
date: 2026-10-14
topics: "determinism,picasso,profit"
pages: 2
related: [../DERIVATION.md, ../notes/202610140142-picasso-determinism-and-the-long-run.md, ../.claude/skills/essay-montaigne/SKILL.md]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# picasso, and the long run

*A draft, derived by Claude from the owner's notes ([`DERIVATION.md`](../DERIVATION.md)).
Written in October 2026.*

I keep a repository of Nix flakes that I named picasso. It has ninety-nine commits and one
star. This week I wrote of it: picasso may be the first profitable
open source, in the long run. I try that sentence here, a word at a time.

*First* does not hold. A company that sold open source reported, for one year, an operating
income of "$512 million", and that was in 2019. I was late before I began. I take the word out.

*Profitable* I cannot defend today. Nobody can pay picasso: it has no price, and no body that
could take the money. So the sentence is down to two words, *picasso* and *the long run*, and
one argument. The argument is determinism.

Here is what I see when I look at how code reaches a machine in 2026. In March, a Python
package with millions of installs a week carried malware for two and a half hours. The people
who run the index counted that "between ~40-50% of all installs" were "unpinned and fetching
the latest version". A year before, somebody moved the tags of a small helper that builds
other people's code, and "over 23,000 repositories" ran what the tags then pointed to. In both
cases a name was trusted in the place of a content. The name moved, and the code arrived by
itself. Open code, delivered, not checked, distributed by a machine. I called it a mess.

Nix answers the name with a hash. "Building a Nix expression twice should yield the same
result", its manual says. The verb before that sentence is honest: Nix "tries". Another page of the
same people says that builds "may still leak timestamps or have other nondeterminisms". I like
a tool that tells me where it stops. In picasso each lab has its own lock, and the lock holds a
content and not a name.

Then I read my own files with the same eye, and I found the mess at home. The workflow that
builds my pinned labs calls its installer by a tag. It is the same thing that was moved in
that attack. I had locked the house and left the key under the name of the door.

I also wrote that picasso would beat the Nix of Determinate Systems. picasso runs on that Nix.
My own study of it says that I am "a customer" of it, "not a competitor". I cannot beat the
ground that I stand on. What I can do is read them at a commit, weigh what I read on one
measure that I name first, adopt what their licence allows, and cite them where I use it, and
again in the record that an index reads, so that the credit goes back up. Then do it again.
If a thing of mine ever improves itself, it will be by that loop, and its first task is small:
pin the workflow.

What do I know? I do not know who would pay for determinism, or when. I know that I trust a
content more than a name, and that this year gave me reasons. The long run is long.

## Sources

Every fact and every quotation is in
[the note](../notes/202610140142-picasso-determinism-and-the-long-run.md), with its address and the day it was read:

- Red Hat's fiscal year 2019; PyPI's report on LiteLLM (March 2026); GitHub's advisory
  GHSA-mrrh-fwg8-r2c3 (CVE-2025-30066); the Nix manual and reproducible.nixos.org.
- picasso at commit `52c5772`: its commits and star, its locks, the tag in its workflow, and
  the sentence of its own study.
- The loop: Ouroboric's REA, in [REA for forecast models](../notes/202610130000-rea-for-forecast-models.md).
- "What do I know?": Montaigne, *Essays*, "Apology for Raimond Sebond".
