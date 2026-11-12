<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# The closed laboratories open up: weights, methods and definitions {#sec:openweights}

If closed source were still a good protection, the laboratories with the most to protect would be
the last to give it up. Between 2024 and 2026 several of them did the opposite. This section
reviews three events: a definition, a peer-reviewed model and an open-weight release by a
laboratory known for closed models.

## A definition of open source AI

On 28 October 2024 the Open Source Initiative published version 1.0 of the Open Source AI
Definition [@osi2024osaid]. It carries the four freedoms of free software over to AI systems: to
"Use the system for any purpose and without having to ask for permission", to "Study how the
system works and inspect its components", to "Modify the system for any purpose, including to
change its output" and to "Share the system for others to use with or without modifications, for
any purpose" [@osi2024osaid]. It then names what must be released for those freedoms to be real:
the parameters, all the code used to train and run the system, and enough information about the
training data that a skilled person could build a substantially equivalent system
[@osi2024osaid].

**[ANALYSIS]** The definition matters here because it sets a bar that most "open" models do not
reach. Weights without training code and data information are a binary: useful, inspectable in
part, but not a method that another laboratory can test. The distinction between open weights and
an open method is the distinction this paper draws between a product that can be used and a
result that can be checked.

## DeepSeek-R1: a frontier model in the peer-reviewed record

In September 2025 *Nature* published the paper behind DeepSeek-R1, a reasoning model trained
largely with reinforcement learning [@guo2025deepseekr1]. The paper reports that the pass@1 score
on the AIME 2024 mathematics benchmark rose from 15.6% to 77.9% during training of the R1-Zero
model, and it lists its own limitations, among them sensitivity to prompts, language mixing and
reward hacking on tasks that are hard to verify [@guo2025deepseekr1]. Its authors state that they
"release DeepSeek-R1-Zero, DeepSeek-R1, data samples and distilled models to the public"
[@guo2025deepseekr1].

**[ANALYSIS]** Two things in this record pull against each other, and both are evidence. The same
company is named, in Section [-@sec:espionage], in allegations of distillation from closed models
[@anthropic2026distillation; @csa2026distillation]. And the same company put its method through
peer review in the most visible journal in science and released the weights. Whatever the truth of
the allegations, the second act is the one that a reader can check. A closed competitor's claim
about a model cannot be reproduced by anyone outside it; a published method with released weights
can be.

## gpt-oss: the closed laboratory releases weights

On 5 August 2025 OpenAI released two open-weight language models, gpt-oss-120b and gpt-oss-20b,
under the Apache 2.0 licence [@openai2025gptoss]. The larger has 117 billion parameters, of which
5.1 billion are active for each token; the smaller has 21 billion, with 3.6 billion active
[@openai2025gptoss]. The announcement gives the reason in the company's own words: "Open models
complement our hosted models, giving developers a wider range of tools to accelerate leading edge
research" [@openai2025gptoss].

**[ANALYSIS]** The release does not make OpenAI an open laboratory, and the Open Source AI
Definition would ask for more than weights [@osi2024osaid]. But the direction is the evidence. A
laboratory that serves its frontier models only through an API, and that in 2026 was sued over
secrets (Section [-@sec:espionage]), concluded that some of its value was better served by
publication than by secrecy. When the owners of the most valuable closed artefacts start to open
some of them, the claim that secrecy is what keeps them valuable is no longer the owners' own
view.

## What the three events share

**[ANALYSIS]** None of the three events is altruism, and I do not need it to be. Each is a bet
that value comes from being used, studied and cited, more than from being hidden. The definition
says what openness requires; the *Nature* paper shows that a frontier method can enter the
scientific record; the open-weight release shows that even the most closed laboratory sees a
return in publication. The rest of this paper asks what follows for a single researcher, whose
work has far less to hide and far more to gain from being found.
