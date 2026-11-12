<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Science and espionage in 2026: the reverse-engineering explosion {#sec:espionage}

I use *reverse engineering* for any process that recovers how an artefact works from the artefact
itself, without access to its design documents: decompiling a binary, inferring a model from its
outputs, or rebuilding a product from its parts. In earlier versions of this paper I wrote REA, in
my project's shorthand, for reverse engineering, assisted. In 2026 the same three letters became
the name of an open tool, *Reverse Engineer Anything*, and its case is told below. This section
reviews seven developments. Several of them are lawsuits or accusations, and their facts are
allegations; I report them as such.

## Apple v. OpenAI: secrets walk out on two legs

On 10 July 2026 Apple sued OpenAI, the device company io that OpenAI had acquired, and two former
Apple employees in the United States District Court for the Northern District of California, San
Jose Division, as *Apple Inc. v. Chang Liu et al.*, Case No. 5:26-cv-07078 [@apple2026complaint].
The six counts are trade-secret misappropriation under the Defend Trade Secrets Act of 2016,
against each of the four defendants, and breach of contract against the two individuals
[@apple2026complaint]. According to the complaint as reported, a former Apple engineer accessed
Apple systems through an authentication bug from a colleague's Apple-issued computer; OpenAI's
chief hardware officer, a former Apple executive, asked job candidates to bring Apple parts,
design files and prototypes to interviews; and new hires received guidance on avoiding Apple's exit
process [@perez2026allegations]. The complaint itself states: "With over four hundred former Apple
employees now working at OpenAI" [@apple2026complaint]. OpenAI said publicly that it has "no
interest in other companies' trade secrets" [@perez2026allegations]. In August it moved to
dismiss, arguing that Apple let employees use personal cloud accounts for work, did not revoke
access properly, and had not identified which secrets were taken [@perez2026motion].

The case moved quickly in the autumn. On 13 October 2026 Judge Edward Davila granted Apple
expedited access to OpenAI's records of interviews with former Apple staff and approved
depositions of three people named in the case [@perez2026hiring]. Before a hearing on Apple's
motion for a preliminary injunction, OpenAI said that it "has no need or desire for Apple's trade
secrets" [@mekelburg2026court]. At that hearing, as reported, OpenAI agreed not to use the
information Apple says was taken and to collect forensic images of devices from 14 employees, and
the judge said that he was "highly likely" to grant the injunction [@mendes2026agrees]. On 28
October the court set the trial for 19 July 2027 [@mendes2026trial]. At the time of writing, 12
November 2026, I found no report that the court had ruled on the motion to dismiss or on the
merits.

**[ANALYSIS]** Whatever the outcome, the dispute is instructive for what it is *not* about. It is
not about source code that an adversary failed to read because it was secret. Every alleged path
runs through people: their accounts, their devices, their recruiting conversations and their
memories. Secrecy, in this account, was a property of an organisation's processes, and processes
leak. Note also that OpenAI's defence, as reported, is partly that Apple's own practices did not
treat the information as secret. A secret that must be actively guarded at every exit interview is
expensive; the cost of the guard is part of the price of closed source.

*Verification note.* Earlier versions of this paper could not confirm the case number. It is now
read from the complaint's own caption [@apple2026complaint], and the reports of October 2026 name
the judge [@mekelburg2026court]. The docket on PACER was still not read directly.

## United States v. Ding: the secret in a personal cloud account

A criminal case about AI secrets ended earlier in the year. On 29 January 2026 a federal jury in San Francisco convicted Linwei Ding, a former Google
software engineer, of seven counts of economic espionage and seven counts of theft of trade
secrets [@doj2026ding]. According to the Department of Justice, he "stole more than two thousand
pages of confidential information containing Google's AI trade secrets" about the company's
supercomputing infrastructure for AI, its custom chips and the software that coordinates them. The
method was simple: between about May 2022 and April 2023 he "uploaded them to his personal Google
Cloud account" [@doj2026ding]. On 1 September 2026 Judge Vince Chhabria sentenced him to just
under one year in prison [@debenedetti2026ding].

**[ANALYSIS]** This is a proven case, not an allegation, and it points the same way as Apple's. The
secret did not fall to a clever adversary who read what was hidden. It left through an insider's
upload button, over many months, inside one of the best-defended companies in the world.

## The Claude Code leak: a secret published by a build step

On 31 March 2026 the full TypeScript source of Claude Code, Anthropic's commercial coding agent,
became public. A 59.8 MB source-map file, meant for internal debugging, had been included in
version 2.1.88 of its package on the public npm registry; the code it exposed was about 512,000
lines [@franzen2026claudecode]. Anthropic said: "This was a release packaging issue caused by
human error, not a security breach" [@franzen2026claudecode]. The company then sent takedown
notices to GitHub that reached some 8,100 repositories, including legitimate forks of its own
public Claude Code repository; it said the reach was an accident and retracted most of the
notices, keeping one repository and 96 forks that held the leaked code [@fernholz2026takedown].

**[ANALYSIS]** I disclose again that Anthropic makes the model that drafted this paper (see the
Statements). The point is not that one company made a mistake; every company that ships software
will. The point is that the boundary between closed and open was one configuration line in a
build. A protection that one line can undo, and that thousands of copies can outlive within a day,
is not a protection on which a researcher can rest the value of a life's work.

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

In September the accusation became official. On 8 September 2026 the NSA, CISA and the FBI
issued a joint advisory, AA26-251A, on distillation campaigns by China-based AI companies against
US companies [@csa2026distillation]. As reported, it names DeepSeek, Moonshot AI, Alibaba,
MiniMax, StepFun and Z.AI, and describes "aggressive, malicious, and targeted distillation
activities at an industrial scale" against models of Anthropic, OpenAI and Google, with billions
of tokens extracted over millions of exchanges since at least late 2024
[@lakshmanan2026agencies]. The agencies assess, in a sentence quoted by the Cloud Security
Alliance, that "this activity forms the critical core, not merely a supplement" of the named
companies' development strategy [@csa2026distillation]. I read the advisory through these two
reports; I did not fetch it from CISA.

**[ANALYSIS]** These are accusations, now by governments as well as by interested companies, and I
do not adjudicate them. Their relevance here is structural. A model served behind an API is closed
source in the strongest sense: its weights never leave the provider's servers. Yet every answer it
gives is a sample of its behaviour, and enough samples teach a student model much of what the
teacher knows. The interface that sells the model is the interface that leaks it, and a state
advisory cannot close that interface without closing the business.

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
interoperability, lawful [@samuelson2002law]. On 5 March 2019, at the RSA Conference, the US
National Security Agency released its own reverse-engineering framework, Ghidra, as open source
[@uchill2019ghidra] under the Apache-2.0 licence [@nsa2019ghidra]. Language models then lowered the
remaining barrier, which was skill. LLM4Decompile, a family of open models trained for
decompilation, produces source that recompiles and passes the original tests; its end-to-end
models more than double the re-executability rate of GPT-4o and Ghidra on the HumanEval and
ExeBench benchmarks [@tan2024llm4decompile]. Its authors then built Decompile-Bench, two million
binary-source function pairs from 450GB of binaries, and report that fine-tuning on it improves
re-executability by 20% [@tan2025decompilebench].

The newest work adds a warning. In September 2026 Liu, Raff and Micinski tested eight LLM
decompilers in nine configurations and found that output which passes every shipped test can still
behave differently from the original: "4.9% overall", and about 13% for the worst system. On 300
real library functions and 287 functions tied to known vulnerabilities, the strongest refinement
raised Ghidra's build rate from 75% to 90% while the rate of outputs that matched the original fell
from 74% to 62% [@liu2026recompile].

**[ANALYSIS]** The warning cuts in an interesting direction. It does not say that decompilation
fails; it says that decompiled code is good enough to run and not yet good enough to trust. For
the owner of a binary, that is no comfort: the attacker needs to understand the program, not to
ship it. For a scientist, it is one more reason to publish the real source, because a
reconstruction that runs but differs in 5% of cases is exactly the kind of silent error that
breaks reproducibility.

## The REA case: an open tool that reverse engineers anything, and the Craft suite

The developments above are papers, lawsuits and leaks. In October 2026 the explosion became a
product that anyone can install. *REA: Reverse Engineer Anything* is an open-source server, under
the MIT licence, that lets a coding agent drive reverse-engineering tools on native binaries,
JavaScript and Electron applications, .NET assemblies, Android packages and websites, and return
its findings with their evidence and limits [@morluto2026rea]. As reported, it began in April 2026
and wraps Ghidra, Hopper, IDA, JADX, Frida and Playwright [@akita2026adobe; @jonas2026rebuilt].
When I read its repository on 12 November 2026, it had 454.0k stars and 111.6k forks
[@morluto2026rea]. Its README limits its use: "REA is for lawful research, education,
interoperability, software preservation", and "You must legally obtain and be authorized to use
commercial tools" [@morluto2026rea].

At the same time a two-person team released a family of applications under the name ArtCraft,
written in Rust with a coding agent: PhotoCraft for image editing, and others for vector art,
video, photo libraries, motion graphics, layout, spreadsheets and presentations
[@jonas2026rebuilt; @akita2026adobe; @claburn2026blinding]. PhotoCraft's README calls it "an
open-source, clean-room reimplementation of Adobe Photoshop, rebuilt in pure Rust", and states:
"Clean-room: implemented from public specs and observed behaviour only. No proprietary code,
shaders or assets" [@storytold2026photocraft]. It is honest about its state: "it is not yet a
Photoshop replacement for daily professional work" [@storytold2026photocraft]. As reported, its
first commit was on 30 September 2026, and in tests "134 of 135 real test files are saved back byte
for byte" [@jonas2026rebuilt]. The same team then published Craft Anything, a tool in four steps,
study, build, check and ready, whose default "clean room" mode reads only what is visible, and
whose "Deep" mode decompiles and disassembles the target [@storytold2026craftanything]. It tells
its users to work "on software you own or are allowed to examine" and says it never bypasses DRM,
logins or anti-cheat [@storytold2026craftanything].

The first defensive answer followed within weeks. On 10 November 2026 *The Register* reported a
tool called Blind LLM Agents, which renames identifiers, encrypts strings, adds decoy code and
checks integrity so that shipped code is harder for an agent to analyse. Its author tested it
against REA and said: "We raise the cost — we don't claim it is unbreakable"
[@claburn2026blinding].

**[ANALYSIS]** The REA case is the thesis of this paper made into software. Nothing in it is new
in kind: Ghidra was open in 2019 and reverse engineering was lawful long before. What is new is
that the cost fell to the price of a prompt, and that the tool and its products are themselves
open, licensed and documented. Three features of the case matter for what follows. First, the
clean-room line, between studying behaviour and copying expression, is the same line the law draws
(Section [-@sec:law]); the projects write it into their own README files. Second, the defensive
answer is obfuscation again, with the same honest caveat that Section [-@sec:securing] finds in
my own example. Third, nobody in the case can hide anything; what they can still choose is whether
they say where their work came from. The Craft projects name what they studied and keep an
attribution file for what they borrowed. That is the behaviour this paper asks of every agent.

## Agents as operators

One more development shows that the same capability serves attackers as well as builders. In
November 2025 Anthropic reported what it called "the first documented case of a large-scale
cyberattack executed without substantial human intervention": a group it assessed "with high
confidence was a Chinese state-sponsored group" used its coding agent against "roughly thirty
global targets", and AI performed "80-90% of the campaign" [@anthropic2025espionage].

**[ANALYSIS]** An agent that can run an intrusion can read a binary. The defender's response
cannot be to hope that the code stays unread; it must be to make the code's integrity checkable
and its authorship provable, and to detect misuse in the open.

## The explosion, summed up

Table: The REA explosion in fourteen dated events, from 2016 to November 2026. {#tbl:timeline}

| Date | Event | Source |
|------------|----------------------------------------|--------------|
| 2016 | Models behind prediction APIs stolen by querying them | @tramer2016stealing |
| 5 Mar 2019 | NSA releases Ghidra as open source | @uchill2019ghidra |
| Mar 2024 | LLM4Decompile: binaries to source that recompiles | @tan2024llm4decompile |
| Jul 2024 | Embedding layer of production models extracted for under 20 USD | @carlini2024stealing |
| Aug 2025 | OpenAI releases open-weight models under Apache 2.0 | @openai2025gptoss |
| Sep 2025 | DeepSeek-R1 method published in *Nature* | @guo2025deepseekr1 |
| Nov 2025 | An agent performs most of an espionage campaign | @anthropic2025espionage |
| 29 Jan 2026 | Jury convicts ex-Google engineer of AI trade-secret theft | @doj2026ding |
| 23 Feb 2026 | Anthropic reports distillation by three laboratories | @anthropic2026distillation |
| 31 Mar 2026 | Claude Code source published by a packaging error | @franzen2026claudecode |
| 10 Jul 2026 | Apple sues OpenAI and two former employees | @apple2026complaint |
| 8 Sep 2026 | NSA, CISA and FBI advisory on industrial-scale distillation | @csa2026distillation |
| Oct 2026 | REA and the Craft clean-room rebuilds spread | @morluto2026rea |
| 10 Nov 2026 | An obfuscator against agents: "We raise the cost" | @claburn2026blinding |


**[ANALYSIS]** Put these developments together and the cost curve of reverse engineering has
collapsed along every axis: for binaries (decompilation and REA), for models (extraction and
distillation), for whole applications (clean-room rebuilds such as PhotoCraft) and for
organisations (people moving between employers, uploads and packaging errors). I call this the
*REA explosion*, after the tool that became its emblem. It does not make every artefact
transparent overnight, and it does not make copying lawful where the law forbids it. It does make
secrecy a weak and expensive defence, and it makes the question of credit, who did what first and
who built on whom, more important than the question of access.
