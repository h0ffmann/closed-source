# Introduction {#sec:intro}

In 1949, six writers who left the Communist movement published their reasons in a book with the
title *The God That Failed*. The title of this paper borrows the phrase for a smaller and less
tragic faith. This faith is the belief that secrecy is the thing that keeps source code, models and
methods valuable. I call that belief *closed source* in a broad sense. It includes closed-source
software, unpublished research code, model weights behind an API, and the scripts of a thesis that
only its author saw.

The faith has two articles. The first article says that secrecy protects the owner: if nobody can
read a thing, nobody can copy it. The second article says that secrecy costs nothing to everyone
else. When one laboratory, one company or one student keeps their work secret, the world loses
little. I argue that both articles failed. I also argue that this failure became clear between
2024 and 2026.

The first article failed because reverse engineering is no longer rare. Reverse engineering was
always lawful and common [@samuelson2002law]. The change is in its cost.

Language models now change compiled binaries into source code that compiles and passes tests
[@tan2024llm4decompile]. A few thousand API queries recover parts of a production language model
[@carlini2024stealing]. Tens of thousands of accounts can distil the behaviour of a frontier model
into the model of a competitor [@anthropic2026distillation; @reuters2026deepseek]. In July 2026, one
of the most valuable companies in the world sued one of the most valuable laboratories about trade
secrets. Its complaint was about people, laptops and recruitment, not about source code that stayed
safely secret [@perez2026allegations; @bridgecounsels2026apple].

The second article failed because the costs of secrecy fall on science. If nobody can examine a
result, nobody can reproduce it [@ince2012case]. If nobody can find code, nobody can credit it
[@smith2016software]. A whole economy now operates on code that someone chose to make open. One
estimate says that the open source that firms use would cost about 8.8 trillion US dollars to build
again [@hoffmann2024value].

If anyone can reverse engineer anything, the useful question is no longer *how do I hide my work*?
The useful question is now *how do I make sure that people credit my work when they use it*? My
answer is professional citation. It has these parts: persistent identifiers, machine-readable
metadata and, more and more, agents that cite by default. This answer has a practical side. Thus I
also describe the open pipeline that produced this paper.

The structure of this paper is as follows. Section [-@sec:bazaar] examines Linux and Git again as
evidence that openness works at a large scale. Section [-@sec:chemorx] is a confession about
my closed undergraduate thesis. Section [-@sec:espionage] reviews science and espionage
in 2026, and the explosion of AI-assisted reverse engineering.

Section [-@sec:dead] gives five lines of evidence that closed source is dead as a protection.
Section [-@sec:securing] examines obfuscation, John Nash's letters on cryptography, and how to
secure source code in 2026. Section [-@sec:citing] argues for professional citation and gives rules
for agents. Section [-@sec:fabric] describes Paper Fabric. Section [-@sec:related] lists my related
work. Section [-@sec:limits] gives the limits of my argument.

This paragraph is about my method. This is a position paper. It uses the *research* style of the
Ouroboric documentation standard. In this style, each factual claim has a citation, and the mark
**[ANALYSIS]** shows each passage of interpretation. It is a v0 preprint, and it is not peer
reviewed.
