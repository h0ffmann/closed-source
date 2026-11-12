<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Science and espionage in 2026: the reverse-engineering explosion {#sec:espionage}

In this paper, *reverse engineering* is each process that finds how an artefact works from the
artefact itself, without access to its design documents. Examples are to decompile a binary, to
infer a model from its outputs, and to build a product again from its parts. In earlier versions of
this paper, I wrote REA, the shorthand of my project for *reverse engineering, assisted*. In 2026,
the same three letters became the name of an open tool, *Reverse Engineer Anything*. Its case is
below.

This section reviews eight developments. Some of them are lawsuits or accusations. Their facts are
allegations, and I report them as allegations.

## Apple v. OpenAI: secrets leave on two legs

On 10 July 2026, Apple sued OpenAI, the device company io that OpenAI bought, and two former Apple
employees. Apple sued in the United States District Court for the Northern District of California,
San Jose Division. The case is *Apple Inc. v. Chang Liu et al.*, Case No. 5:26-cv-07078
[@apple2026complaint]. There are six counts. Four counts are trade-secret misappropriation under the
Defend Trade Secrets Act of 2016, one against each of the four defendants. Two counts are breach of
contract against the two persons [@apple2026complaint].

The reports of the complaint say these things. A former Apple engineer got access to Apple systems
through an authentication bug, from the Apple computer of a colleague. The chief hardware officer
of OpenAI, a former Apple executive, asked job candidates to bring Apple parts, design files and
prototypes to interviews. New employees received guidance about how to avoid the exit process of
Apple [@perez2026allegations]. The complaint itself counts "over four hundred former Apple
employees now working at OpenAI" [@apple2026complaint].

OpenAI said in public that it has "no interest in other companies' trade secrets"
[@perez2026allegations]. In August, it asked the court to dismiss the lawsuit. It said that Apple
let employees use personal cloud accounts for work and did not remove access correctly. It also said
that Apple did not identify the secrets that were taken [@perez2026motion].

The case moved quickly in the autumn. On 13 October 2026, Judge Edward Davila gave Apple fast
access to the records of OpenAI interviews with former Apple employees. He also approved
depositions of three persons in the case [@perez2026hiring]. Before a hearing on the request of
Apple for a preliminary injunction, OpenAI said that it "has no need or desire for Apple's trade
secrets" [@mekelburg2026court].

At that hearing, the reports say that OpenAI agreed not to use the information that Apple says was
taken. OpenAI also agreed to collect forensic images of the devices of 14 employees. The judge said
that he was "highly likely" to grant the injunction [@mendes2026agrees]. On 28 October, the court
set the trial for 19 July 2027 [@mendes2026trial]. I wrote this paper on 12 November 2026. On that
day, I found no report of a court decision on the request to dismiss or on the merits.

**[ANALYSIS]** The result of the dispute is not known. But the dispute teaches something, because
of what it is *not* about. It is not about source code that an adversary did not read because the
code was secret. Each alleged path goes through people: their accounts, their devices, their
recruitment conversations and their memories. In this account, secrecy was a property of the
processes of an organisation, and processes leak.

**[ANALYSIS]** As reported, part of the defence of OpenAI is that the practices of Apple did not
treat the information as secret. If a company must guard a secret at each exit interview, the
secret is expensive. The cost of the guard is part of the price of closed source.

*Verification note.* Earlier versions of this paper did not confirm the case number. I now read it
from the caption of the complaint [@apple2026complaint], and the reports of October 2026 name the
judge [@mekelburg2026court]. I did not read the docket on PACER directly.

## United States v. Ding: the secret in a personal cloud account

A court decided a criminal case about AI secrets earlier in the year. On 29 January 2026, a federal
jury in San Francisco convicted Linwei Ding, a former Google software engineer. The conviction is on
seven counts of economic espionage and seven counts of theft of trade secrets [@doj2026ding]. The
Department of Justice says that he "stole more than two thousand pages of confidential information
containing Google's AI trade secrets". These secrets were about the AI supercomputing infrastructure
of the company, its custom chips and the software that controls them.

The method was simple. Between about May 2022 and April 2023, he "uploaded them to his personal
Google Cloud account" [@doj2026ding]. On 1 September 2026, Judge Vince Chhabria sentenced him to
a little less than one year in prison [@debenedetti2026ding].

**[ANALYSIS]** This case is proven. It is not an allegation, and it shows the same thing as the
case of Apple. A clever adversary did not read the hidden secret. The secret left through the upload
button of an insider, over many months, in one of the best-defended companies in the world.

## The Claude Code leak: a build step publishes a secret

On 31 March 2026, the full TypeScript source of Claude Code became public. Claude Code is the
commercial coding agent of Anthropic. Version 2.1.88 of its package on the public npm registry
included a source-map file of 59.8 MB. This file was for internal debugging. The code that it
exposed was about 512,000 lines [@franzen2026claudecode]. Anthropic said: "This was a release
packaging issue caused by human error, not a security breach" [@franzen2026claudecode].

The company then sent takedown notices to GitHub. These notices affected about 8,100 repositories,
which included legitimate forks of its own public Claude Code repository. The company said that
this was an accident, and it withdrew most of the notices. It kept one repository and 96 forks that
held the leaked code [@fernholz2026takedown].

**[ANALYSIS]** I disclose again that Anthropic makes the model that wrote the drafts of this paper
(refer to the Statements). The point is not that one company made a mistake. Each company that
ships software will make mistakes. The point is that one configuration line in a build was the
boundary between closed and open. One line can remove this protection, and thousands of copies can
exist after one day. A researcher cannot use such a protection to keep the value of a life's work.

## Distillation: copying capability through the front door

Knowledge distillation is a standard and legitimate technique: you train a smaller model to
copy the outputs of a larger model [@hinton2015distilling]. In 2026, distillation also became the
centre of an accusation of industrial copying.

In February, Reuters reported that OpenAI wrote to the US House Select Committee on Strategic
Competition between the United States and the Chinese Communist Party. OpenAI wrote that accounts
related to DeepSeek employees had methods to get around the access restrictions of OpenAI and
"obtain outputs for distillation in programmatic ways" [@reuters2026deepseek]. DeepSeek did not
reply to Reuters.

Ten days after that, Anthropic reported "industrial-scale campaigns by three AI laboratories". The
three laboratories were DeepSeek, Moonshot AI and MiniMax. They used about 24,000 fraudulent
accounts and more than 16 million exchanges with the Claude models [@anthropic2026distillation].

In September, the accusation became official. On 8 September 2026, the NSA, CISA and the FBI
published the joint advisory AA26-251A. It is about distillation campaigns by China-based AI
companies against US companies [@csa2026distillation]. The reports say that it names DeepSeek,
Moonshot AI, Alibaba, MiniMax, StepFun and Z.AI. It describes "aggressive, malicious, and targeted
distillation activities at an industrial scale" against models of Anthropic, OpenAI and Google. The
reports say that these activities extracted billions of tokens over millions of exchanges since at
least late 2024 [@lakshmanan2026agencies].

The Cloud Security Alliance quotes one sentence of the agencies: "this activity forms the critical
core, not merely a supplement" of the development strategy of the named companies
[@csa2026distillation]. I read the advisory through these two reports. I did not fetch it from
CISA.

**[ANALYSIS]** These are accusations, now by governments and also by interested companies. I do
not make a decision about them. They are important here because of their structure. A model behind
an API is closed source in the strongest sense: its weights never leave the servers of the
provider.

**[ANALYSIS]** But each answer of the model is a sample of its behaviour. Enough samples teach a
student model much of what the teacher knows. The interface that sells the model is the interface
that leaks it. A government advisory cannot close that interface without closing the business.

## Extraction: reading the model through its answers

Academic work showed the same point with more precision and less drama. In 2016, Tramèr and
colleagues showed that an attacker can steal machine-learning models behind prediction APIs: the
attacker sends queries to them [@tramer2016stealing].

In 2024, Carlini and colleagues went further, against production language models. Their attack
recovered the full embedding projection matrix of the OpenAI Ada and Babbage models, for less than
twenty US dollars in queries. It also confirmed their hidden dimensions for the first time
[@carlini2024stealing]. The paper was published at ICML 2024, and it ends with defences and
mitigations. When a research community finds a leak, it publishes the leak so that others can fix
it.

## Decompilation: the end of the opaque binary

Reverse engineering of compiled software was routine for a long time. For some purposes, for example
interoperability, it is lawful [@samuelson2002law]. On 5 March 2019, at the RSA Conference, the US
National Security Agency released its own reverse-engineering framework, Ghidra, as open source
[@uchill2019ghidra]. The licence is Apache-2.0 [@nsa2019ghidra].

Then language models removed the remaining barrier, which was skill. LLM4Decompile is a family of
open models for decompilation. It produces source code that compiles again and passes the original
tests. On the HumanEval and ExeBench benchmarks, its end-to-end models get more than two times the
re-executability rate of GPT-4o and Ghidra [@tan2024llm4decompile]. Its authors then made
Decompile-Bench: two million binary-source function pairs from 450GB of binaries. They report that
fine-tuning on this dataset increases re-executability by 20% [@tan2025decompilebench].

The newest work adds a warning. In September 2026, Liu, Raff and Micinski tested eight LLM
decompilers in nine configurations. Output that passes each shipped test can still operate
differently from the original: "4.9% overall", and about 13% for the worst system. They also used
300 real library functions and 287 functions related to known vulnerabilities. The strongest
refinement increased the build rate of Ghidra from 75% to 90%. But the rate of outputs that agreed
with the original decreased from 74% to 62% [@liu2026recompile].

**[ANALYSIS]** This warning goes in an interesting direction. It does not say that decompilation
fails. It says that decompiled code is good enough to run, but not yet good enough to trust. This
does not help the owner of a binary: the attacker must understand the program, not ship it.

**[ANALYSIS]** For a scientist, it is one more reason to publish the real source. A reconstruction
that runs but is different in 5% of cases makes exactly the type of silent error that stops
reproducibility.

## The REA case: an open tool that reverse engineers anything, and the Craft suite

The developments above are papers, lawsuits and leaks. In October 2026, the explosion became a
product that anyone can install. *REA: Reverse Engineer Anything* is an open-source server with the
MIT licence. It lets a coding agent operate reverse-engineering tools on native binaries,
JavaScript and Electron applications, .NET assemblies, Android packages and websites. It gives
its findings with their evidence and limits [@morluto2026rea].

The reports say that REA started in April 2026, and that it wraps Ghidra, Hopper, IDA, JADX, Frida
and Playwright [@akita2026adobe; @jonas2026rebuilt]. When I read its repository on 12 November 2026,
it had 454.0k stars and 111.6k forks [@morluto2026rea]. Its README limits its use: "REA is for
lawful research, education, interoperability, software preservation", and "You must legally obtain
and be authorized to use commercial tools" [@morluto2026rea].

At the same time, a team of two persons released a family of applications with the name ArtCraft.
They wrote them in Rust with a coding agent. PhotoCraft is for image editing. Other applications
are for vector art, video, photo libraries, motion graphics, layout, spreadsheets and presentations
[@jonas2026rebuilt; @akita2026adobe; @claburn2026blinding].

The README of PhotoCraft calls it "an open-source, clean-room reimplementation of Adobe Photoshop,
rebuilt in pure Rust". It states: "Clean-room: implemented from public specs and observed behaviour
only. No proprietary code, shaders or assets" [@storytold2026photocraft]. It is honest about its
status: "it is not yet a Photoshop replacement for daily professional work"
[@storytold2026photocraft]. The reports say that its first commit was on 30 September 2026. In
tests, "134 of 135 real test files are saved back byte for byte" [@jonas2026rebuilt].

The same team then published Craft Anything. This tool has four steps: study, build, check and
ready. Its default "clean room" mode reads only what is visible. Its "Deep" mode decompiles and
disassembles the target [@storytold2026craftanything]. It tells its users to work "on software you
own or are allowed to examine". It says that it never goes around DRM, logins or anti-cheat
[@storytold2026craftanything].

The first defensive answer came after a few weeks. On 10 November 2026, *The Register* reported a
tool with the name Blind LLM Agents. It renames identifiers, encrypts strings, adds decoy code and
checks integrity, so that it is more difficult for an agent to analyse shipped code. Its author
tested it against REA and said: "We raise the cost — we don't claim it is unbreakable"
[@claburn2026blinding].

**[ANALYSIS]** The REA case is the thesis of this paper in the form of software. Nothing in it is a
new type of thing. Ghidra was open in 2019, and reverse engineering was lawful long before that.
What is new is that the cost decreased to the price of a prompt. Also, the tool and its products
are open, licensed and documented.

**[ANALYSIS]** Three features of the case are important for the subsequent sections. First, the
clean-room line, between the study of behaviour and the copy of expression, is the same line that
the law makes (Section [-@sec:law]). The projects write it into their own README files. Second, the
defensive answer is obfuscation again, with the same honest warning that Section [-@sec:securing]
finds in my own example.

**[ANALYSIS]** Third, nobody in the case can hide anything. But they can still choose to say where
their work came from, or not. The Craft projects name what they studied, and they keep an
attribution file for what they borrowed. This is the behaviour that this paper asks of each agent.

## Agents as operators

One more development shows that the same capability serves attackers and builders. In November
2025, Anthropic reported a case that it called "the first documented case of a large-scale
cyberattack executed without substantial human intervention". A group that it assessed "with high
confidence was a Chinese state-sponsored group" used its coding agent against "roughly thirty
global targets". AI did "80-90% of the campaign" [@anthropic2025espionage].

**[ANALYSIS]** An agent that can do an intrusion can read a binary. The defender cannot hope that
nobody reads the code. The defender must make the integrity of the code possible to check, and its
authorship possible to prove. The defender must also find misuse in the open.

## Summary of the explosion

Table: The REA explosion in fourteen dated events, from 2016 to November 2026. {#tbl:timeline}

| Date | Event | Source |
|------------|----------------------------------------|--------------|
| 2016 | An attacker steals models behind prediction APIs with queries | @tramer2016stealing |
| 5 Mar 2019 | NSA releases Ghidra as open source | @uchill2019ghidra |
| Mar 2024 | LLM4Decompile: binaries to source code that compiles again | @tan2024llm4decompile |
| Jul 2024 | Extraction of the embedding layer of production models for less than 20 USD | @carlini2024stealing |
| Aug 2025 | OpenAI releases open-weight models under Apache 2.0 | @openai2025gptoss |
| Sep 2025 | *Nature* publishes the DeepSeek-R1 method | @guo2025deepseekr1 |
| Nov 2025 | An agent does most of an espionage campaign | @anthropic2025espionage |
| 29 Jan 2026 | A jury convicts a former Google engineer of AI trade-secret theft | @doj2026ding |
| 23 Feb 2026 | Anthropic reports distillation by three laboratories | @anthropic2026distillation |
| 31 Mar 2026 | A packaging error publishes the Claude Code source | @franzen2026claudecode |
| 10 Jul 2026 | Apple sues OpenAI and two former employees | @apple2026complaint |
| 8 Sep 2026 | Advisory of the NSA, CISA and FBI on industrial-scale distillation | @csa2026distillation |
| Oct 2026 | REA and the Craft clean-room rebuilds spread | @morluto2026rea |
| 10 Nov 2026 | An obfuscator against agents: "We raise the cost" | @claburn2026blinding |

**[ANALYSIS]** When you put these developments together, the cost curve of reverse engineering
fell on each axis. It fell for binaries (decompilation and REA) and for models (extraction and
distillation). It fell for full applications (clean-room rebuilds such as PhotoCraft). It fell for
organisations (people who change employers, uploads and packaging errors). I call this the *REA
explosion*, after the tool that became its symbol.

**[ANALYSIS]** The REA explosion does not make each artefact transparent immediately. It does not
make copying lawful where the law forbids it. But it makes secrecy a weak and expensive defence.
It also makes the question of credit (who did what first, and who built on whom) more important
than the question of access.
