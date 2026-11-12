<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Introduction {#sec:intro}

In 1949, six writers who left the Communist movement published their reasons in a book with the
title *The God That Failed* [@crossman1949god]. The title of this paper borrows the phrase for a
smaller and less tragic faith. This faith is the belief that secrecy is the thing that keeps source
code, models and methods valuable. I call that belief *closed source* in a broad sense. It includes
closed-source software, unpublished research code, model weights behind an API, and the scripts of
a thesis that only its author saw.

The faith has two articles. The first article says that secrecy protects the owner: if nobody can
read a thing, nobody can copy it. The second article says that secrecy costs nothing to everyone
else. When one laboratory, one company or one student keeps their work secret, the world loses
little. I argue that both articles failed. I also argue that this failure became clear between
2024 and 2026.

The first article failed because reverse engineering is no longer rare. Reverse engineering was
always lawful and common [@samuelson2002law]. The change is in its cost.

Language models can now change compiled binaries into source code that compiles and passes tests
[@tan2024llm4decompile]. Queries that cost less than 20 US dollars recover a part of a production
language model [@carlini2024stealing]. Tens of thousands of accounts can distil the behaviour of a
frontier model into the model of a competitor [@anthropic2026distillation; @reuters2026deepseek]. In
September 2026, three US agencies said that such campaigns occur at "industrial scale"
[@lakshmanan2026agencies]. In July 2026, one of the most valuable companies in the world sued one of
the most valuable laboratories about trade secrets. Its complaint was about people, laptops and
recruitment, not about source code that stayed safely secret [@apple2026complaint;
@perez2026allegations].

The first article also failed in a different way: secrets leak without reverse engineering. In
January 2026, a jury convicted a former Google engineer. He took more than two thousand pages of AI
trade secrets: he uploaded them to a personal cloud account [@doj2026ding]. In March 2026, a
packaging error published the full source of a commercial coding agent on a public registry
[@franzen2026claudecode]. It is easy to read closed source from outside. It is also difficult to
keep it closed from inside.

The second article failed because the costs of secrecy fall on science. If nobody can examine a
result, nobody can reproduce it [@ince2012case]. If nobody can find code, nobody can credit it
[@smith2016software].

Researchers tried to build the code of 601 computer-systems papers. Only 27% of these papers had
code that was publicly available [@collberg2016repeatability]. A whole economy now operates on code
that someone chose to make open. One estimate says that the open source that firms use would cost
about 8.8 trillion US dollars to build again [@hoffmann2024value].

Robert M. Pirsig wrote the book that this book stands on. In *Zen and the Art of Motorcycle
Maintenance*, he gives the problem of science in one sentence: "The number of rational hypotheses
that can explain any given phenomenon is infinite" [@pirsig1974zen, p. 107].

**[ANALYSIS]** If the number of hypotheses has no end, science has no end. No single laboratory
can test all the hypotheses. Only its owner can open a closed method, thus no other person can
test it. For this reason, I think that openness is necessary for science first, and for business
after.

If anyone can reverse engineer anything, the useful question is no longer *how do I hide my work*?
The useful question is now *how do I make sure that people credit my work when they use it*? My
answer is professional citation. It has these parts: persistent identifiers, machine-readable
metadata and, more and more, agents that cite by default.

This is urgent. In January 2026, an audit of the accepted papers of one of the largest
machine-learning conferences found 100 fabricated citations. These citations passed peer review
[@gptzero2026neurips]. My answer has a practical side. Thus I also describe the open pipeline that
produced this paper.

## Contributions

This paper has five contributions.

1. It collects the evidence from 2024 to 12 November 2026 that secrecy no longer protects code,
   models or methods. Each item has a source (Sections [-@sec:espionage] and [-@sec:dead]).
2. It shows that the law accepts reverse engineering of a lawfully obtained product as a lawful
   means. This is true in the United States, the European Union and Brazil. Thus closed source
   never had a legal guarantee against understanding (Section [-@sec:law]).
3. It separates the things that cryptography can protect (integrity and identity) from the thing
   that it cannot protect (readability). It lists the tools for integrity and identity in 2026
   (Section [-@sec:securing]).
4. It gives three citation rules for agents, and the evidence that agents need them (Section
   [-@sec:citing]).
5. It describes Paper Fabric, an open pipeline that applies those rules automatically, and it lists
   the defects of the pipeline (Sections [-@sec:fabric] and [-@sec:limits]).

## Structure

Section [-@sec:history] examines three documents, from 1976, 1983 and 1998. In these documents,
the faith started, people argued against it, and a company left it for the first time. Section
[-@sec:bazaar] examines Linux and Git again as evidence that openness works at a large scale. It
also examines two failures of open source.

Section [-@sec:openweights] reviews how the closed laboratories started to publish weights and
methods. Section [-@sec:espionage] reviews science and espionage in 2026, and the explosion of
AI-assisted reverse engineering. Section [-@sec:dead] gives seven lines of evidence that closed
source is dead as a protection. Section [-@sec:law] examines the law.

Section [-@sec:securing] examines obfuscation, John Nash's letters on cryptography, and how to
secure source code in 2026. Section [-@sec:citing] argues for professional citation and gives rules
for agents. Section [-@sec:objections] answers six objections. Section [-@sec:checklist] changes
the argument into a checklist.

Section [-@sec:fabric] describes Paper Fabric. Section [-@sec:related] lists my related work.
Section [-@sec:evidence] puts the 2026 evidence into groups by the type of source. Section
[-@sec:limits] gives the limits of my argument. Section [-@sec:conclusion] gives the conclusion.

This paragraph is about my method. This is a position paper. It uses a *research* style. In this
style, each factual claim has a citation, and the mark **[ANALYSIS]** shows each passage of
interpretation.

I report allegations as allegations, with the source and the status of the case. I fetched each
source before I cited it. I fetched the sources about events after June 2026 on 12 November 2026.
This paper is a v0 preprint, and it is not peer reviewed.
