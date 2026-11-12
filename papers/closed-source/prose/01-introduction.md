<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Introduction {#sec:intro}

In 1949 six writers who had left the Communist movement published their reasons in a book called
*The God That Failed* [@crossman1949god]. The title of this paper borrows the phrase for a smaller
and less tragic faith: the belief that keeping source code, models and methods secret is what keeps
them valuable. I call that belief *closed source* in a broad sense. It covers proprietary software,
unpublished research code, model weights behind an API and the scripts behind a thesis that only
its author has seen.

The faith has two articles. The first says that secrecy protects the owner: what nobody can read,
nobody can copy. The second says that secrecy is costless to everyone else: the world loses little
when one lab, one company or one student keeps their work to themselves. I argue that both
articles failed, and that the failure became obvious between 2024 and 2026.

The first article failed because reverse engineering stopped being rare. Reverse engineering has
always been lawful and common [@samuelson2002law]. What changed is its cost. Language models can now
turn compiled binaries into source that compiles and passes tests [@tan2024llm4decompile]. Queries
that cost under 20 US dollars recover part of a production language model [@carlini2024stealing].
Tens of thousands of accounts can distil a frontier model's behaviour into a competitor's
[@anthropic2026distillation; @reuters2026deepseek], and in September 2026 three US agencies
described such campaigns as "industrial scale" [@lakshmanan2026agencies]. And when one of the most
valuable companies in the world sued one of the most valuable laboratories over trade secrets in
July 2026, its complaint was about people, laptops and recruiting, not about source code that stayed
safely secret [@apple2026complaint; @perez2026allegations].

The first article also failed in the other direction: secrets leak without any reverse
engineering at all. In January 2026 a jury convicted a former Google engineer of taking more than
two thousand pages of AI trade secrets by uploading them to a personal cloud account
[@doj2026ding]. In March 2026 a packaging error published the full source of a commercial coding
agent on a public registry [@franzen2026claudecode]. Closed source is not only easy to read from
outside; it is hard to keep closed from inside.

The second article failed because the costs of secrecy fall on science. A result that cannot be
inspected cannot be reproduced [@ince2012case], and code that cannot be found cannot be credited
[@smith2016software]. When researchers tried to build the code behind 601 computer-systems papers,
only 27% of the papers had code that was publicly available [@collberg2016repeatability]. A whole
economy now runs on code that someone chose to open: one estimate puts the cost of rebuilding the
open source that firms use at about 8.8 trillion US dollars [@hoffmann2024value].

Robert M. Pirsig wrote the book that this one stands on. In *Zen and the Art of Motorcycle
Maintenance* he puts the trouble of science in one sentence: "The number of rational hypotheses
that can explain any given phenomenon is infinite" [@pirsig1974zen, p. 107].

**[ANALYSIS]** If the hypotheses have no end, science has no end, and no single laboratory can
test them all. A method that only its owner can open is a method that nobody else can test. That
is why I hold that openness comes first for science, before it comes for business.

If anyone can reverse engineer anything, the useful question is no longer *how do I hide my
work?* It is *how do I make sure my work is credited when it is used?* My answer is professional
citation: persistent identifiers, machine-readable metadata and, increasingly, agents that cite
by default. The need is urgent. In January 2026 an audit of the papers accepted at one of the
largest machine-learning conferences found 100 fabricated citations that had passed peer review
[@gptzero2026neurips]. That answer has a practical side, so I also describe the open pipeline
that produced this paper.

## Contributions

This paper makes five contributions.

1. It gathers, in one place and with sources, the evidence from 2024 to 12 November 2026 that
   secrecy no longer protects code, models or methods (Sections [-@sec:espionage] and
   [-@sec:dead]).
2. It shows that the law of the United States, the European Union and Brazil already treats
   reverse engineering of a lawfully obtained product as a lawful means, so that closed source
   never had a legal guarantee against being understood (Section [-@sec:law]).
3. It separates what cryptography can protect, integrity and identity, from what it cannot,
   readability, and lists the tools that protect the first in 2026 (Section [-@sec:securing]).
4. It states three rules of citation for agents and the evidence that they are needed (Section
   [-@sec:citing]).
5. It describes Paper Fabric, an open pipeline that applies those rules mechanically, and lists
   its defects (Sections [-@sec:fabric] and [-@sec:limits]).

## Organisation

Section [-@sec:history] reads three documents, from 1976, 1983 and 1998, in which the faith was
founded, contested and first abandoned. Section [-@sec:bazaar] revisits Linux and Git as evidence
that openness scales, and looks honestly at two failures of open source. Section [-@sec:openweights]
reviews how the closed laboratories themselves began to publish weights and methods. Section
[-@sec:espionage] reviews science and espionage in 2026 and the explosion of AI-assisted reverse
engineering. Section [-@sec:dead] gathers seven lines of evidence that closed source is dead as a
protection. Section [-@sec:law] reads the law. Section [-@sec:securing] turns to obfuscation, John
Nash's letters on cryptography and how to secure source code in 2026. Section [-@sec:citing] argues
for professional citation and states rules for agents. Section [-@sec:objections] answers six
objections, and Section [-@sec:checklist] turns the argument into a checklist. Section
[-@sec:fabric] describes Paper Fabric. Section [-@sec:related] lists my related work. Section
[-@sec:evidence] grades the 2026 evidence by its kind of source, Section [-@sec:limits] states the
limits of my argument, and Section [-@sec:conclusion] concludes.

A note on method. This is a position paper, written in the *research* style of the Ouroboric
documentation standard: every factual claim carries a citation, and passages of interpretation are
marked **[ANALYSIS]**. Allegations are reported as allegations, with the source and the status of
the case. Every source was fetched before it was cited; sources about events after June 2026 were
fetched on 12 November 2026. It is a v0 preprint and has not been peer reviewed.
