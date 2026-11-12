<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Objections and replies {#sec:objections}

A position paper owes its reader the strongest case against it. I state six objections as their
holders would, and reply to each. The replies are interpretation, marked as such; the facts they
rest on are cited in earlier sections.

## Objection 1: secrecy still works for most companies most of the time

*Most software is never reverse engineered, because nobody cares enough. The cases in this paper
are the exceptions: the most valuable companies and the most valuable models.*

**[ANALYSIS]** The objection is true of attention and false of cost. Secrecy held for most
software because reverse engineering was expensive, so only valuable targets were worth the cost.
The evidence of Section [-@sec:espionage] is that the cost fell for everyone at once. An open tool
that drives Ghidra, IDA and a browser from a prompt [@morluto2026rea] does not care whether a
target is famous. When the cost of reading falls to the price of a prompt, the set of targets that
are "worth it" grows to include almost everything. The exception becomes the rule.

## Objection 2: open weights and open methods are dangerous

*A model whose weights are public can be fine-tuned to remove its safeguards. A method that is
published can be used by an attacker. For some artefacts, secrecy is a safety measure, not a
business model.*

**[ANALYSIS]** This is the strongest objection, and I do not dismiss it. My argument in Section
[-@sec:limits] already excludes security-sensitive details, personal data and material under
embargo. Two replies narrow the rest. First, the objection assumes that secrecy holds, and the
evidence is that for models served at scale it does not: distillation through the API is alleged
at industrial scale by the providers and by three US agencies [@anthropic2026distillation;
@csa2026distillation]. A safety measure that leaks to the most determined adversaries while it
binds honest researchers protects the wrong side. Second, the attack described in the 2025
espionage report used a closed, hosted agent, not an open one [@anthropic2025espionage]. Closedness
did not prevent misuse; detection and publication of the misuse did the work. The case for
withholding a specific dangerous capability may be good. It is a case about that capability, made
in the open, not a general case for closed source.

## Objection 3: without secrecy there is no incentive to invest

*If a rival can rebuild a product in weeks, nobody will spend years building it. Trade secrets
exist because they fund innovation.*

**[ANALYSIS]** The objection confuses the protection of investment with the protection of
readability. Patents, copyright, contracts and the lead time of the first mover all protect
investment without requiring that a product stay unread; Samuelson and Scotchmer's case for
lawful reverse engineering rests precisely on the lead time it leaves [@samuelson2002law]. The
laboratories with the largest investments released weights and methods in 2025 because they saw a
return in being used and cited [@openai2025gptoss; @guo2025deepseekr1]. And the open source that
firms already rely on, worth an estimated 8.8 trillion US dollars to replace
[@hoffmann2024value], was built without the incentive the objection says is necessary. For
science, the objection does not arise: a researcher's return is citation, and citation requires
being read.

## Objection 4: citation is an empty courtesy that machines will ignore

*Agents already copy without credit. Asking them to cite is asking a flood to apologise.*

**[ANALYSIS]** Agents do what their operators and their configuration require. An agent that works
under an `AGENTS.md` with a rule against invented references, and in a build that fails on an
unchecked entry, cites because it cannot finish otherwise. That is not a hope; it is how this
paper was made (Section [-@sec:fabric]). The evidence of fabricated references in peer-reviewed
papers [@gptzero2026neurips; @ansari2026compound] is an argument for making the check mechanical,
not for giving up on it. And the law of at least one country already ties a permitted use of
software to the identification of its source [@brasil1998software].

## Objection 5: clean-room rebuilds harm the people who built the original

*A team spent decades on a professional application. An agent rebuilds its behaviour in weeks and
gives it away. Whatever the law says, that is unfair to the original authors.*

**[ANALYSIS]** The objection deserves a direct answer, because the Craft projects of Section
[-@sec:espionage] make it concrete. First, the rebuilds are, by their own account, far from
parity: PhotoCraft states that "it is not yet a Photoshop replacement for daily professional work"
[@storytold2026photocraft]. The decades of work show in the gap. Second, the law has always let a
competitor study a product and build a rival that behaves alike; what it forbids is copying
protected expression and taking secrets by improper means (Section [-@sec:law]). Third, and this is
the point of the paper, the fair response is credit, not secrecy. A rebuild that names what it
studied, with a version and an identifier, gives the original authors a public record of their
influence, which secrecy never gave them. A rebuild that hides its sources is the problem, and the
remedy is the citation rules of Section [-@sec:citing], applied to agents and to the people who
direct them.

## Objection 6: the author has an interest in openness

*The author builds open tools and cites his own projects. Of course he argues that openness wins.*

**[ANALYSIS]** The interest is real and declared (Section [-@sec:limits] and the Statements). The
reply is the method of the paper itself: every factual claim carries a fetched source, the
reference log records each check, and the source of the paper, its build and its agent
configuration are public. A reader who doubts my motive can check my evidence without trusting
me. That is the difference between an open argument and a closed one, and it is the whole of my
case.
