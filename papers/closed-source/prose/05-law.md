<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# What the law already says: reverse engineering in the US, the EU and Brazil {#sec:law}

A reader may accept the evidence of Section [-@sec:dead] and still answer that the law will
restore what technology took away. This section reads three bodies of law, the United States, the
European Union and Brazil, where I live and work. I am not a lawyer, and nothing here is legal
advice. I quote the texts and say what they plainly cover.

## The United States: reverse engineering is not an improper means

The Defend Trade Secrets Act of 2016, under which Apple sued OpenAI [@apple2026complaint], amended
the definitions of the federal Economic Espionage Act. There, "improper means" "includes theft,
bribery, misrepresentation, breach or inducement of a breach of a duty to maintain secrecy, or
espionage through electronic or other means", and it "does not include reverse engineering,
independent derivation, or any other lawful means of acquisition" [@usc2016dtsa]. Samuelson and
Scotchmer survey the law and economics of the same rule, and find it generally sound where reverse
engineering is slow and costly enough to leave the first mover a lead [@samuelson2002law].

## The European Union: observation, study, disassembly or testing

Directive (EU) 2016/943 on trade secrets lists the lawful ways to acquire one. Article 3(1)(a)
names "independent discovery or creation", and Article 3(1)(b) names "observation, study,
disassembly or testing of a product or object that has been made available to the public or that
is lawfully in the possession of the acquirer of the information who is free from any legally
valid duty to limit the acquisition of the trade secret" [@eu2016tradesecrets]. Member states
had to bring the directive into national law.

## Brazil: what is not an offence against the owner of a program

Brazil's software law, Lei nº 9.609 of 19 February 1998, protects computer programs as works and
then lists, in its Article 6, acts that are not an offence against the owner's rights
[@brasil1998software]. Two of them matter here. Item II permits "a citação parcial do programa,
para fins didáticos, desde que identificados o programa e o titular dos direitos respectivos"
(the partial citation of a program for teaching, provided that the program and its rights holder
are identified). Item III permits "a ocorrência de semelhança de programa a outro, preexistente,
quando se der por força das características funcionais de sua aplicação" (the similarity of one
program to an earlier one, when it follows from the functional features of its application)
[@brasil1998software].

## What the three texts share

**[ANALYSIS]** Three legal systems, written in different decades and languages, draw the same
line. Studying a product you lawfully hold is permitted; taking it by theft, bribery or breach of a
duty is not. None of them gives the owner of a closed artefact a right not to be understood. The
Brazilian text goes one step further and ties a permitted use to citation: partial citation of a
program is lawful when the program and its owner are identified. That is the rule of this paper,
written into a statute in 1998.

**[ANALYSIS]** The same line runs through the 2026 cases of Section [-@sec:espionage]. Apple's suit
and the Ding conviction are about the improper side of the line: devices, uploads, recruiting and
breach of duty [@apple2026complaint; @doj2026ding]. The Craft projects place themselves on the
other side by calling their work clean-room reimplementations from "public specs and observed
behaviour only" [@storytold2026photocraft]. Whether a given rebuild stays on that side is a
question of fact for a court, not for this paper. What the law cannot do is turn the lawful side
into a protected secret. Once reverse engineering is cheap, the law of trade secrets protects
against theft, which was always wrong, and not against understanding, which was always allowed.

**[ANALYSIS]** Two limits keep this reading honest. First, copyright, patents and contracts still
apply: a clean-room rebuild may copy behaviour, but not protected expression, and a licence may
forbid reverse engineering by contract where the local law allows such a clause. Second, a lawful
method can still be used for an unlawful end, and the legality of a tool says nothing about every
use of it. The point is narrower: the law never promised that a closed artefact would stay
unread, and so closed source never had the guarantee that its faith assumed.
