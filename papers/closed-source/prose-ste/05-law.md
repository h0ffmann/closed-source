<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# What the law already says: reverse engineering in the US, the EU and Brazil {#sec:law}

A reader can accept the evidence of Section [-@sec:dead] and still say that the law will give back
what technology removed. This section examines three bodies of law: the law of the United States,
of the European Union and of Brazil, where I live and work. I am not a lawyer, and this section is
not legal advice. I quote the texts and say what they clearly include.

## The United States: reverse engineering is not an improper means

Apple sued OpenAI under the Defend Trade Secrets Act of 2016 [@apple2026complaint]. This act
changed the definitions of the federal Economic Espionage Act. In these definitions, "improper
means" "includes theft, bribery, misrepresentation, breach or inducement of a breach of a duty to
maintain secrecy, or espionage through electronic or other means". It "does not include reverse
engineering, independent derivation, or any other lawful means of acquisition" [@usc2016dtsa].

Samuelson and Scotchmer examine the law and economics of the same rule. They find that the rule is
generally correct when reverse engineering is slow and expensive enough to give the first company a
lead [@samuelson2002law].

## The European Union: observation, study, disassembly or testing

Directive (EU) 2016/943 on trade secrets lists the lawful ways to get a trade secret. Article
3(1)(a) names "independent discovery or creation". Article 3(1)(b) names "observation, study,
disassembly or testing of a product or object that has been made available to the public or that
is lawfully in the possession of the acquirer of the information who is free from any legally
valid duty to limit the acquisition of the trade secret" [@eu2016tradesecrets]. Member states had
to put the directive into their national law.

## Brazil: what is not an offence against the owner of a program

The software law of Brazil is Lei nº 9.609 of 19 February 1998. It protects computer programs as
works. Its Article 6 then lists acts that are not an offence against the rights of the owner
[@brasil1998software]. Two of these acts are important here.

Item II permits "a citação parcial do programa, para fins didáticos, desde que identificados o
programa e o titular dos direitos respectivos". This is the partial citation of a program for
teaching, if the text identifies the program and its rights holder. Item III permits "a ocorrência
de semelhança de programa a outro, preexistente, quando se der por força das características
funcionais de sua aplicação". This is the similarity of one program to an earlier program, when
the functional features of its application cause the similarity [@brasil1998software].

## What the three texts have in common

**[ANALYSIS]** Three legal systems, from different decades and in different languages, make the
same line. If you study a product that you hold lawfully, the law permits it. If you take the
product by theft, bribery or breach of a duty, the law does not permit it. None of these laws gives
the owner of a closed artefact a right that nobody understands it.

**[ANALYSIS]** The text of Brazil goes one step further. It connects a permitted use to citation:
partial citation of a program is lawful when the text identifies the program and its owner. That is
the rule of this paper, in a law of 1998.

**[ANALYSIS]** The same line goes through the cases of 2026 in Section [-@sec:espionage]. The lawsuit
of Apple and the conviction of Ding are about the improper side of the line: devices, uploads,
recruitment and breach of duty [@apple2026complaint; @doj2026ding]. The Craft projects put
themselves on the other side. They call their work clean-room reimplementations from "public specs
and observed behaviour only" [@storytold2026photocraft].

**[ANALYSIS]** A court, not this paper, must decide if a given rebuild stays on that side. But the
law cannot change the lawful side into a protected secret. When reverse engineering is cheap, the
law of trade secrets protects against theft, which was always wrong. It does not protect against
understanding, which the law always permitted.

**[ANALYSIS]** Two limits keep this reading honest. First, copyright, patents and contracts still
apply. A clean-room rebuild can copy behaviour, but not protected expression. A licence can forbid
reverse engineering by contract where the local law permits such a clause. Second, a person can use
a lawful method for an unlawful purpose. If a tool is lawful, that does not make each use of it
lawful. The point is narrower: the law never promised that nobody would read a closed artefact.
Thus closed source never had the guarantee that its faith assumed.
