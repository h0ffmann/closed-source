<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Objections and replies {#sec:objections}

A position paper must give its reader the strongest case against it. I give six objections in the
words that their holders would use, and I reply to each. The replies are interpretation, and I mark
them. The facts under them have citations in earlier sections.

## Objection 1: secrecy still works for most companies most of the time

*Nobody reverse engineers most software, because nobody is sufficiently interested. The cases in
this paper are the exceptions: the most valuable companies and the most valuable models.*

**[ANALYSIS]** The objection is true about attention and false about cost. Secrecy protected most
software because reverse engineering was expensive. Thus only valuable targets were worth the cost.
Section [-@sec:espionage] shows that the cost decreased for everyone at the same time. An open tool
operates Ghidra, IDA and a browser from a prompt [@morluto2026rea]. It does not care if a target is
famous. When the cost of reading decreases to the price of a prompt, the set of targets that are
"worth it" increases to almost everything. The exception becomes the rule.

## Objection 2: open weights and open methods are dangerous

*If the weights of a model are public, a person can fine-tune the model to remove its safeguards.
If a method is published, an attacker can use it. For some artefacts, secrecy is a safety measure,
not a business model.*

**[ANALYSIS]** This is the strongest objection, and I do not ignore it. Section [-@sec:limits]
already excludes security-sensitive details, personal data and material under embargo from my
argument. Two replies make the remaining part of the objection smaller.

**[ANALYSIS]** First, the objection assumes that secrecy holds. The evidence shows that for models
that serve many users, it does not hold. The providers and three US agencies allege distillation
through the API at industrial scale [@anthropic2026distillation; @csa2026distillation]. A safety
measure that leaks to the most determined adversaries, but stops honest researchers, protects the
wrong side.

**[ANALYSIS]** Second, the attack in the espionage report of 2025 used a closed, hosted agent, not an
open agent [@anthropic2025espionage]. Closed source did not prevent misuse. Detection and
publication of the misuse did the work. It can be correct to keep one specific dangerous capability
secret. But that is an argument about that capability, made in the open. It is not a general
argument for closed source.

## Objection 3: without secrecy there is no reason to invest

*If a competitor can build a product again in weeks, nobody will spend years to build it. Trade
secrets exist because they pay for innovation.*

**[ANALYSIS]** The objection mixes the protection of investment with the protection of readability.
Patents, copyright, contracts and the lead time of the first company all protect investment. None
of them needs the product to stay unread. The argument of Samuelson and Scotchmer for lawful
reverse engineering depends on the lead time that it leaves [@samuelson2002law].

**[ANALYSIS]** The laboratories with the largest investments released weights and methods in 2025,
because they saw a return when people use and cite them [@openai2025gptoss; @guo2025deepseekr1].
Firms already use open source that would cost about 8.8 trillion US dollars to replace
[@hoffmann2024value]. People built it without the reason that the objection says is necessary. For
science, the objection does not apply: the return of a researcher is citation, and citation needs
readers.

## Objection 4: citation is an empty courtesy, and machines will ignore it

*Agents already copy without credit. If you ask them to cite, you ask a flood to apologise.*

**[ANALYSIS]** Agents do what their operators and their configuration require. An agent may work
under an `AGENTS.md` with a rule against invented references, in a build that fails on an entry
that nobody checked. This agent cites, because it cannot finish if it does not cite. That is not a
hope. It is how this paper was made (Section [-@sec:fabric]).

**[ANALYSIS]** The evidence of fabricated references in peer-reviewed papers
[@gptzero2026neurips; @ansari2026compound] is an argument to make the check mechanical. It is not an
argument to stop the check. Also, the law of at least one country already connects a permitted use
of software to the identification of its source [@brasil1998software].

## Objection 5: clean-room rebuilds harm the people who built the original

*A team worked for decades on a professional application. An agent builds its behaviour again in
weeks and gives it away free. The law can permit this, but it is not fair to the original authors.*

**[ANALYSIS]** This objection needs a direct answer, because the Craft projects of Section
[-@sec:espionage] make it concrete. First, the rebuilds say themselves that they are far from
parity. PhotoCraft states that "it is not yet a Photoshop replacement for daily professional work"
[@storytold2026photocraft]. The decades of work show in this gap.

**[ANALYSIS]** Second, the law always let a competitor study a product and build a competitor that
operates in the same way. The law forbids the copy of protected expression and the theft of secrets
by improper means (Section [-@sec:law]).

**[ANALYSIS]** Third, and this is the point of the paper, the fair response is credit, not secrecy.
A rebuild can name what it studied, with a version and an identifier. This gives the original
authors a public record of their influence, and secrecy never gave them that. A rebuild that hides
its sources is the problem. The solution is the citation rules of Section [-@sec:citing], for
agents and for the people who control them.

## Objection 6: the author has an interest in openness

*The author builds open tools and cites his own projects. Of course he argues that openness wins.*

**[ANALYSIS]** The interest is real, and I declare it (Section [-@sec:limits] and the Statements).
My reply is the method of the paper itself. Each factual claim has a fetched source, and the
reference log records each check. The source of the paper, its build and its agent configuration
are public. A reader who doubts my motive can check my evidence and does not need to trust me. That
is the difference between an open argument and a closed argument, and it is my full case.
