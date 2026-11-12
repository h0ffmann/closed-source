<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# The closed laboratories open up: weights, methods and definitions {#sec:openweights}

If closed source was still a good protection, the laboratories with the most to protect would be
the last to stop it. Between 2024 and 2026, some of them did the opposite. This section reviews
three events: a definition, a peer-reviewed model, and an open-weight release by a laboratory that
is known for closed models.

## A definition of open source AI

On 28 October 2024, the Open Source Initiative published version 1.0 of the Open Source AI
Definition [@osi2024osaid]. It applies the four freedoms of free software to AI systems. These
freedoms are to "Use the system for any purpose and without having to ask for permission", to
"Study how the system works and inspect its components", to "Modify the system for any purpose,
including to change its output" and to "Share the system for others to use with or without
modifications, for any purpose" [@osi2024osaid].

The definition then says what a release must include to make these freedoms real. It must include
the parameters and all the code that trains and runs the system. It must also include enough
information about the training data to let a skilled person build a substantially equivalent
system [@osi2024osaid].

**[ANALYSIS]** The definition is important here because most "open" models do not meet it. Weights
without training code and data information are a binary. A binary is useful, and people can examine
parts of it. But it is not a method that another laboratory can test. Open weights differ from an
open method. This paper makes the same difference between a product that people can use and a result
that people can check.

## DeepSeek-R1: a frontier model in the peer-reviewed record

In September 2025, *Nature* published the paper about DeepSeek-R1. DeepSeek-R1 is a reasoning model,
and its developers trained it mostly with reinforcement learning [@guo2025deepseekr1]. During the
training of the R1-Zero model, the pass@1 score on the AIME 2024 mathematics benchmark increased
from 15.6% to 77.9%. The paper also lists its own limitations. These include sensitivity to
prompts, language mixing, and reward hacking on tasks that are difficult to verify
[@guo2025deepseekr1]. The authors state that they "release DeepSeek-R1-Zero, DeepSeek-R1, data
samples and distilled models to the public" [@guo2025deepseekr1].

**[ANALYSIS]** Two facts in this record go in opposite directions, and both are evidence. Section
[-@sec:espionage] names the same company in allegations of distillation from closed models
[@anthropic2026distillation; @csa2026distillation]. The same company also put its method through
peer review in the most visible journal in science, and released the weights.

**[ANALYSIS]** The allegations may be true or false. But a reader can check only the second act.
Nobody outside a closed competitor can reproduce its claim about a model. Anyone can reproduce a
published method with released weights.

## gpt-oss: the closed laboratory releases weights

On 5 August 2025, OpenAI released two open-weight language models, gpt-oss-120b and gpt-oss-20b,
under the Apache 2.0 licence [@openai2025gptoss]. The larger model has 117 billion parameters. Of
these, 5.1 billion are active for each token. The smaller model has 21 billion parameters, and 3.6
billion are active [@openai2025gptoss]. The announcement gives the reason in the words of the
company: "Open models complement our hosted models, giving developers a wider range of tools to
accelerate leading edge research" [@openai2025gptoss].

**[ANALYSIS]** This release does not make OpenAI an open laboratory. The Open Source AI Definition
asks for more than weights [@osi2024osaid]. But the direction is the evidence. This laboratory
serves its frontier models only through an API, and in 2026 a company sued it about secrets (Section
[-@sec:espionage]).

**[ANALYSIS]** It decided that publication gives more value than secrecy for some of its work. The
owners of the most valuable closed artefacts now open some of them. Thus the owners themselves no
longer think that secrecy is the thing that keeps these artefacts valuable.

## What the three events have in common

**[ANALYSIS]** None of the three events is charity, and my argument does not need charity. Each
event is a bet that value comes from use, study and citation more than from secrecy.

**[ANALYSIS]** The definition says what openness requires. The *Nature* paper shows that a frontier
method can go into the scientific record. The open-weight release shows that even the most closed
laboratory sees a return in publication. The remaining sections of this paper ask what this means
for one researcher. The work of one researcher has much less to hide, and much more to gain when
people find it.