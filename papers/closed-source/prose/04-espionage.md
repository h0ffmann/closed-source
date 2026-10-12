<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Science and espionage in 2026: the reverse-engineering explosion {#sec:espionage}

I use *reverse engineering* (REA in my project's shorthand, for reverse engineering, assisted)
for any process that recovers how an artefact works from the artefact itself, without access to
its design documents: decompiling a binary, inferring a model from its outputs, or rebuilding a
product from its parts. This section reviews four developments. The first is a lawsuit, and its
facts are allegations; I report them as such.

## Apple v. OpenAI: secrets walk out on two legs

On 10 July 2026 Apple sued OpenAI, the device company io that OpenAI had acquired, and two former
Apple employees in the United States District Court for the Northern District of California
(San Jose). The claims are trade-secret misappropriation under the Defend Trade Secrets Act of
2016 and, against the two individuals, breach of contract
[@bridgecounsels2026apple; @perez2026allegations]. According to the complaint as reported, a
former Apple engineer accessed Apple systems through an authentication bug from a colleague's
Apple-issued computer; OpenAI's chief hardware officer, a former Apple executive, asked job
candidates to bring Apple parts, design files and prototypes to interviews; and new hires
received guidance on avoiding Apple's exit process. Apple also alleges that more than 400 former
Apple employees now work at OpenAI [@perez2026allegations]. OpenAI said publicly that it has "no
interest in other companies' trade secrets" [@perez2026allegations]. In August it moved to
dismiss, arguing that Apple let employees use personal cloud accounts for work, did not revoke
access properly, and had not identified which secrets were taken [@perez2026motion]. At the time
of writing, the motion to dismiss and a motion for a preliminary injunction were pending, and no
court had ruled on the merits [@bridgecounsels2026apple; @perez2026motion].

**[ANALYSIS]** Whatever the outcome, the dispute is instructive for what it is *not* about. It is
not about source code that an adversary failed to read because it was secret. Every alleged path
runs through people: their accounts, their devices, their recruiting conversations and their
memories. Secrecy, in this account, was a property of an organisation's processes, and processes
leak. Note also that OpenAI's defence, as reported, is partly that Apple's own practices did not
treat the information as secret. A secret that must be actively guarded at every exit interview is
expensive; the cost of the guard is part of the price of closed source.

*Verification note.* I could not retrieve the docket directly. Secondary sources give the case
number as 5:26-cv-07078, with conflicting judge suffixes (VKD and EJD), and caption it both as
*Apple Inc. v. OpenAI* and *Apple Inc. v. Liu* [@bridgecounsels2026apple]. The number must be
checked against PACER before this paper leaves v0.

## Distillation: copying capability through the front door

Knowledge distillation, training a smaller model to imitate a larger one's outputs, is a
standard and legitimate technique [@hinton2015distilling]. In 2026 it also became the centre of
an accusation of industrial copying. In February, according to Reuters, OpenAI told the US House
Select Committee on Strategic Competition between the United States and the Chinese Communist
Party that accounts associated with DeepSeek employees
had developed methods to circumvent OpenAI's access restrictions and "obtain outputs for
distillation in programmatic ways" [@reuters2026deepseek]. DeepSeek did not respond to Reuters.
Ten days later Anthropic reported "industrial-scale campaigns by three AI laboratories",
DeepSeek, Moonshot AI and MiniMax, using about 24,000 fraudulent accounts and more than 16 million
exchanges with its Claude models [@anthropic2026distillation].

**[ANALYSIS]** These are accusations by interested parties, and I do not adjudicate them. Their
relevance here is structural. A model served behind an API is closed source in the strongest
sense: its weights never leave the provider's servers. Yet every answer it gives is a sample of
its behaviour, and enough samples teach a student model much of what the teacher knows. The
interface that sells the model is the interface that leaks it.

## Extraction: reading the model through its answers

Academic work made the same point with more precision and less drama. In 2016 Tramèr and
colleagues showed that machine-learning models served through prediction APIs can be stolen by
querying them [@tramer2016stealing]. In 2024 Carlini and colleagues went further against
production language models: their attack recovered the entire embedding projection matrix of
OpenAI's Ada and Babbage models, for under twenty US dollars in queries, and confirmed their
hidden dimensions for the first time [@carlini2024stealing]. The paper, published at ICML 2024,
closes with defences and mitigations: the response of a research community to discovered leakage
is to publish it, so that it can be fixed.

## Decompilation: the end of the opaque binary

Reverse engineering of compiled software has long been routine and, for purposes such as
interoperability, lawful [@samuelson2002law]. In 2019 the US National Security Agency released its
own reverse-engineering framework, Ghidra, as open source under the Apache-2.0 licence
[@nsa2019ghidra]. Language models then lowered the remaining barrier, which was skill. LLM4Decompile,
a family of open models trained for decompilation, produces source that recompiles and passes the
original tests; its end-to-end models more than double the re-executability rate of GPT-4o and
Ghidra on the HumanEval and ExeBench benchmarks [@tan2024llm4decompile].

**[ANALYSIS]** Put these four developments together and the cost curve of reverse engineering
has collapsed along every axis: for binaries (decompilation), for models (extraction and
distillation) and for organisations (people moving between employers). I call this the
*REA explosion*. It does not make every artefact transparent overnight, and it does not make
copying lawful where the law forbids it. It does make secrecy a weak and expensive defence, and it
makes the question of credit, who did what first and who built on whom, more important than the
question of access.
