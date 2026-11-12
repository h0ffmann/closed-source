---
title: "Closed Source: The God that Failed"
subtitle: "Reverse engineering, espionage and the ethics of citation in the age of coding agents"
# The cover names Mr. Nobody. The writer, in the first person, is credited in the citation
# metadata (.zenodo.json) and in the Statements; the site reads `writer` for its Authors section.
author:
  - name: Mr. Nobody
writer:
  name: Matheus Hoffmann
  orcid: 0009-0009-1056-7661
  affiliation: Escola Politécnica, Universidade Federal do Rio de Janeiro
# The owner's two words for this work, for its own tile in the site's DOIs section, where it is
# listed beside the others under its repository name (Hoffmann, 13 October 2026).
tags: [non-profit, ideas]
# The writer's other citable works, for the site's DOIs and Author sections. `tags` are the
# owner's two words for each work (Hoffmann, 13 October 2026). Each `doi` is the concept DOI,
# which resolves to the latest version. Source: the "DOI's" list of h0ffmann/h0ffmann,
# me/ways-of-working.md at 1a3a7e1; the same three DOIs are `cites` entries in .zenodo.json.
# The full index of the writer's works, on his three accounts, is WORKS.md (read on 11 November
# 2026); gramatico, of piabrota, was added from it. It is not a tie in .zenodo.json: the book does
# not cite it. Its `tags` are proposed, not yet the owner's words: "FOSS" from the piabrota
# profile ("Every project is FOSS", piabrota/.github at 481e94f) and "portuguese" from its subject.
# marola's `text` names the marola-dev repositories its record archives (marola .zenodo.json at
# 94121b8, read on 12 November 2026). marola-bench, of marola-dev, was added from WORKS.md: its DOI
# is in the marola-research README at 59d7ef6 (HEAD on 12 November 2026). Its `tags` are proposed:
# "non-profit" as for marola, and "benchmark" from its subject.
works:
  - name: marola
    text: "an open, non-profit platform for sea conditions and bathing-water quality at Brazilian beaches, on marola-dev: the app, the site at marola.dev, the open ocean data store, the corpus, the models and the devkit"
    doi: 10.5281/zenodo.23224155
    tags: [non-profit, water]
    href: https://github.com/marola-dev/marola
  - name: ww3-gpu
    text: "the WW3 GPU Lab: moving WAVEWATCH III kernels to GPUs without changing the answer"
    doi: 10.5281/zenodo.23221351
    tags: [non-profit, waves]
    href: https://github.com/h0ffmann/ww3-gpu
  - name: picasso
    text: "self-contained Nix flakes for scientific and agentic toolchains"
    doi: 10.5281/zenodo.23311208
    tags: [profit, nix]
    href: https://github.com/h0ffmann/picasso
  - name: nashkell
    text: "an open book in progress, in the voice of Nash: game theory, pictures that are equations, and the mask of Latin that Section 5 studies"
    doi: 10.5281/zenodo.23356739
    tags: [book, game theory]
    href: https://h0ffmann.github.io/nashkell/
  - name: gramatico
    text: "controlled technical Brazilian Portuguese for people and agents: a Claude Code plugin, by piabrota, that rewrites technical text so it reads once"
    doi: 10.5281/zenodo.23554531
    tags: [FOSS, portuguese]
    href: https://github.com/piabrota/gramatico
  - name: marola-bench
    text: "a WeatherBench for Brazil: a proposal, in marola-research, beside marola's wave models on GPUs"
    doi: 10.5281/zenodo.23352633
    tags: [non-profit, benchmark]
    href: https://github.com/marola-dev/marola-research
# The writer's partners (Hoffmann, 12 November 2026: "Partners are piabrota and marola-dev"). The
# texts follow README.md, "the writer's works". `tools/fabric content` writes them for the site.
partners:
  - name: piabrota
    text: "an open software fabric made in rio de janeiro"
    href: https://github.com/piabrota
  - name: marola-dev
    text: "marola and water: open ocean science"
    href: https://github.com/marola-dev
# Shown on the title page. Trademarks of their projects, not licensed here: `tools/fabric logos`
# fetches each SVG at a pinned commit, checks its hash and converts it; nothing is committed.
# The website shows the same marks as linked stamps, after picasso's site, and reads the keys from
# `href` down; it loads each SVG from its owner's repository at the same commit.
logos:
  - file: logos/marola.pdf
    svg: https://raw.githubusercontent.com/marola-dev/marola/d0d576ea014335acbc190a09ce9fcbe0f89a391d/docs/assets/logo.svg
    sha256: 71567f8c69a5c5e18b8b712a280cae1dac402e6a2e7ceb331408a4e713159cf9
    href: https://marola.dev
    label: marola
    text: "open ocean science, live at marola.dev"
    width: "56"
    height: "54"
date: "November 2026"
version: "v0 (preprint, not peer reviewed)"
keywords:
  - open source
  - reverse engineering
  - AI-assisted reverse engineering
  - model distillation
  - trade secrets
  - software citation
  - research software
  - FAIR
  - coding agents
abstract: |
  For thirty years, closed source has promised that secrecy protects value. I argue that the
  promise has failed, for science first. I read the case through Robert M. Pirsig's *Zen and the
  Art of Motorcycle Maintenance* (1974), the book this work stands on: rational hypotheses are
  infinite, so science never closes, and a method only its owner can open cannot be tested.
  Evidence from 2024 to 12 November 2026 makes the case. Large language models now decompile
  binaries into re-executable source, and an open tool, REA (Reverse Engineer Anything), puts
  the whole chain behind one agent; clean-room rebuilds of professional applications followed
  within weeks. Black-box queries extract parts of production models, and three US agencies
  called distillation industrial. Secrets also leak from inside: Apple's 2026 suit against
  OpenAI turns on people, laptops and recruiting, a former Google engineer was convicted of
  taking AI secrets, and a packaging error published a commercial agent's source. Meanwhile the
  closed laboratories began to publish weights and methods. Linus Torvalds' Linux and Git show
  that openness scales; Heartbleed and the xz backdoor show that open failures get found. I read
  the law of the United States, the European Union and Brazil, which all treat reverse
  engineering of a lawfully held product as lawful. I show why obfuscation, including my own,
  cannot hide code, and contrast it with John Nash's 1955 idea of security from computational
  cost: signed commits, keys held in hardware and two-factor authentication protect what secrecy
  cannot. I argue that the ethical answer to universal reverse engineering is professional
  citation: persistent identifiers, machine-readable citation metadata and agents that borrow,
  cite and propagate credit by default. I describe Paper Fabric, an open, self-improving
  pipeline that produced this preprint, and answer six objections.
arxiv:
  primary: cs.CY
  cross-list: [cs.SE, cs.CR, cs.DL]
  license: http://creativecommons.org/licenses/by/4.0/
  comments: "v0 preprint, not peer reviewed. 2 tables. Source, build and agent configuration: https://github.com/h0ffmann/closed-source"
lang: en-US
papersize: a4
fontsize: 11pt
geometry:
  - top=25mm
  - bottom=25mm
  - left=28mm
  - right=28mm
numbersections: true
link-citations: true
colorlinks: true
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
