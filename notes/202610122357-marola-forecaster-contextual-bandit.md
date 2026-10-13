---
id: "202610122357"
title: "The Marola forecaster: a contextual bandit over forecast models"
type: permanent
status: open-question
source: "Matheus Hoffmann, project chat, 2026-10-12"
tags: [marola, contextual-bandit, ww3, weather, benchmark]
created: 2026-10-12
---
<!-- cite: main="Matheus Hoffmann"; last="Matheus Hoffmann" -->

# The Marola forecaster: a contextual bandit over forecast models

The Marola forecaster is a contextual bandit run on a benchmark in the shape of
[[202610122356-operational-weatherbench]], scored on Brazilian instruments
([[202610122358-brazilian-instruments-under-acts]]).

- **Arms** (the forecasters it can pick): the WW3 GPU port; the latest Google model; Google's own
  tests of that model; classical WW3 run as its regression tests, in WW4.
- **Context** (what the choice depends on): region, lead time, season and the ENSO phase (El Niño
  now), and the variable (wave height, wind, period).
- **Reward:** the skill of the picked forecast against the instruments, by a metric fixed before the
  run, as Operational WeatherBench fixes its own.

The question it answers is not "which model is best" but "which model is best here, now, at this
lead". That is the question behind the WW3-GPU effort: is porting WW3 to the GPU worth it against
picking up the latest Google model as it comes? The bandit answers it with data, case by case.

Operations and experiments stay apart: [[202610122359-exploit-in-operations-explore-in-simulation]].
The habit of mind is REA: [[202610130000-rea-for-forecast-models]].

**Open:** WW4 and its January 2027 release are the owner's information; no public source is cited
yet. Google's wave model, if any, is not named yet: the Google models on the benchmark are
atmospheric.
