<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Introduction {#sec:intro}

In 1949 six writers who had left the Communist movement published their reasons in a book called
*The God That Failed*. The title of this paper borrows the phrase for a smaller and less tragic
faith: the belief that keeping source code, models and methods secret is what keeps them
valuable. I call that belief *closed source* in a broad sense. It covers proprietary software,
unpublished research code, model weights behind an API and the scripts behind a thesis that only
its author has seen.

The faith has two articles. The first says that secrecy protects the owner: what nobody can read,
nobody can copy. The second says that secrecy is costless to everyone else: the world loses little
when one lab, one company or one student keeps their work to themselves. I argue that both
articles failed, and that the failure became obvious between 2024 and 2026.

The first article failed because reverse engineering stopped being rare. Reverse engineering has
always been lawful and common [@samuelson2002law]. What changed is its cost. Language models now
turn compiled binaries into source that compiles and passes tests [@tan2024llm4decompile]. A few
thousand API queries recover parts of a production language model [@carlini2024stealing]. Tens
of thousands of accounts can distil a frontier model's behaviour into a competitor's
[@anthropic2026distillation; @reuters2026deepseek]. And when one of the most valuable companies in
the world sued one of the most valuable laboratories over trade secrets in July 2026, its
complaint was about people, laptops and recruiting, not about source code that stayed safely
secret [@perez2026allegations; @bridgecounsels2026apple].

The second article failed because the costs of secrecy fall on science. A result that cannot be
inspected cannot be reproduced [@ince2012case], and code that cannot be found cannot be credited
[@smith2016software]. A whole economy now runs on code that someone chose to open: one estimate
puts the cost of rebuilding the open source that firms use at about 8.8 trillion US dollars
[@hoffmann2024value].

Robert M. Pirsig wrote the book that this one stands on. In *Zen and the Art of Motorcycle
Maintenance* he puts the trouble of science in one sentence: "The number of rational hypotheses
that can explain any given phenomenon is infinite" [@pirsig1974zen, p. 107].

**[ANALYSIS]** If the hypotheses have no end, science has no end, and no single laboratory can
test them all. A method that only its owner can open is a method that nobody else can test. That
is why I hold that openness comes first for science, before it comes for business.

If anyone can reverse engineer anything, the useful question is no longer *how do I hide my
work?* It is *how do I make sure my work is credited when it is used?* My answer is professional
citation: persistent identifiers, machine-readable metadata and, increasingly, agents that cite
by default. That answer has a practical side, so I also describe the open pipeline that produced
this paper.

The paper is organised as follows. Section [-@sec:bazaar] revisits Linux and Git as evidence that
openness scales. Section [-@sec:chemorx] is a confession about my closed
undergraduate thesis. Section [-@sec:espionage] reviews science and espionage in 2026 and the explosion of
AI-assisted reverse engineering. Section [-@sec:dead] gathers five lines of evidence that closed
source is dead as a protection. Section [-@sec:securing] turns to obfuscation, John Nash's
letters on cryptography and how to secure source code in 2026. Section [-@sec:citing] argues
for professional citation and states rules for agents. Section [-@sec:fabric] describes Paper Fabric. Section [-@sec:related] lists my
related work, and Section [-@sec:limits] states the limits of my argument.

A note on method. This is a position paper, written in the *research* style of the Ouroboric
documentation standard: every factual claim carries a citation, and passages of interpretation are
marked **[ANALYSIS]**. It is a v0 preprint and has not been peer reviewed.
