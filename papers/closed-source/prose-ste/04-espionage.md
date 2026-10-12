# Science and espionage in 2026: the reverse-engineering explosion {#sec:espionage}

I use the term *reverse engineering* for any process that recovers how an artefact works from the
artefact itself, without access to its design documents. My project uses the shorthand REA for
reverse engineering, assisted. Examples are to decompile a binary, to infer a model from its
outputs, or to build a product again from its parts. This section reviews four developments. The
first development is a lawsuit, and its facts are allegations. I report them as allegations.

## Apple v. OpenAI: secrets leave on two legs

On 10 July 2026, Apple sued OpenAI, the device company io that OpenAI acquired before, and two
former Apple employees. The court is the United States District Court for the Northern District of
California (San Jose). The claims are trade-secret misappropriation under the Defend Trade Secrets
Act of 2016 and, against the two individuals, breach of contract [@bridgecounsels2026apple;
@perez2026allegations].

According to the complaint as reported, a former Apple engineer accessed Apple systems through an
authentication bug, from the Apple-issued computer of a colleague. The complaint says that OpenAI's
chief hardware officer, a former Apple executive, asked job candidates to bring Apple parts, design
files and prototypes to interviews. The complaint also says that new employees received guidance
about how to avoid Apple's exit process. Apple also alleges that more than 400 former Apple
employees now work at OpenAI [@perez2026allegations].

OpenAI said publicly that it has "no interest in other companies' trade secrets"
[@perez2026allegations]. In August, OpenAI moved to dismiss. It argued that Apple let employees use
personal cloud accounts for work, did not revoke access correctly, and did not identify which
secrets were taken [@perez2026motion]. When I wrote this paper, the motion to dismiss and a motion
for a preliminary injunction were pending, and no court ruled on the merits
[@bridgecounsels2026apple; @perez2026motion].

**[ANALYSIS]** Whatever the result, the dispute is useful because it is *not* about source code that
an adversary could not read because it was secret. Each alleged path goes through people: their
accounts, their devices, their recruitment conversations and their memories. In this account,
secrecy was a property of the processes of an organisation, and processes leak. Also, as reported,
part of OpenAI's defence is that Apple's own practices did not treat the information as secret. A
secret that must have an active guard at each exit interview is expensive. The cost of the guard is
part of the price of closed source.

*Verification note.* I could not fetch the docket directly. Secondary sources give the case number
as 5:26-cv-07078, with two judge suffixes that do not agree (VKD and EJD). They give the caption
both as *Apple Inc. v. OpenAI* and as *Apple Inc. v. Liu* [@bridgecounsels2026apple]. The number
must be checked against PACER before this paper leaves v0.

## Distillation: capability copied through the front door

Knowledge distillation trains a smaller model to imitate the outputs of a larger model. It is a
standard and legitimate technique [@hinton2015distilling]. In 2026, it also became the centre of an
accusation of industrial copying.

According to Reuters, OpenAI made a statement in February to a committee of the US House. The
committee is the US House Select Committee on Strategic Competition between the United States and
the Chinese Communist Party. OpenAI said that accounts associated with DeepSeek employees developed
methods to bypass OpenAI's access restrictions and "obtain outputs for distillation in programmatic
ways" [@reuters2026deepseek]. DeepSeek did not reply to Reuters. Ten days later, Anthropic reported
"industrial-scale campaigns by three AI laboratories": DeepSeek, Moonshot AI and MiniMax. According
to Anthropic, these campaigns used about 24,000 fraudulent accounts and more than 16 million
exchanges with Anthropic's Claude models [@anthropic2026distillation].

**[ANALYSIS]** These are accusations by interested parties, and I do not judge them. Their
relevance here is structural. A model served behind an API is closed source in the strongest sense:
its weights never leave the servers of the provider. But each answer from the model is a sample of
its behaviour. Enough samples teach a student model much of what the teacher model knows. The
interface that sells the model is the interface that leaks it.

## Extraction: a model read through its answers

Academic work made the same point with more precision and less drama. In 2016, Tramèr and colleagues
showed that it is possible to steal machine-learning models served through prediction APIs, with
queries to these models [@tramer2016stealing].

In 2024, Carlini and colleagues went further, with an attack on production language models. Their
attack recovered the entire embedding projection matrix of OpenAI's Ada and Babbage models, for
under twenty US dollars in queries. The attack also confirmed the hidden dimensions of these models
for the first time [@carlini2024stealing]. The paper, published at ICML 2024, ends with defences and
mitigations. When a research community discovers a leakage, its response is to publish it, so that
it can be fixed.

## Decompilation: the end of the opaque binary

Reverse engineering of compiled software is a routine practice with a long history, and it is lawful
for purposes such as interoperability [@samuelson2002law]. In 2019, the US National Security Agency
released its own reverse-engineering framework, Ghidra, as open source under the Apache-2.0 licence
[@nsa2019ghidra]. Then language models lowered the last barrier, which was skill. LLM4Decompile is a
family of open models trained for decompilation. It produces source code that recompiles and passes
the original tests. Its end-to-end models more than double the re-executability rate of GPT-4o and
Ghidra on the HumanEval and ExeBench benchmarks [@tan2024llm4decompile].

**[ANALYSIS]** If I put these four developments together, I see that the cost curve of reverse
engineering collapsed on all axes. The axes are binaries (decompilation), models (extraction and
distillation) and organisations (people who move between employers). I call this the *REA
explosion*. It does not make each artefact transparent overnight, and it does not make copies
lawful where the law forbids them. But it does make secrecy a weak and expensive defence. It also
makes the question of credit (who did what first, and who used whose work) more important than the
question of access.
