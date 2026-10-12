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
# Shown on the title page. Trademarks of their projects, not licensed here: scripts/logos.py
# fetches each SVG at a pinned commit, checks its hash and converts it; nothing is committed.
logos:
  - file: logos/marola.pdf
    svg: https://raw.githubusercontent.com/marola-dev/marola/d0d576ea014335acbc190a09ce9fcbe0f89a391d/docs/assets/logo.svg
    sha256: 71567f8c69a5c5e18b8b712a280cae1dac402e6a2e7ceb331408a4e713159cf9
  - file: logos/ouroboric.pdf
    svg: https://raw.githubusercontent.com/ouroboric-dev/ouroboric/4ab80ed2486a5e0ab0ade13e5089c2a4acdb4216/docs/7-branding/identity/logo/ouroboric-logo-horizontal.svg
    sha256: 935eb9acf636f5da8651bdee14e6b53670e216d6a1667b46c48d62ec6f26f59d
date: "October 2026"
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
  promise has failed, for science first. Three trends from 2024 to 2026 make the case. Large
  language models now decompile binaries into re-executable source. Black-box queries extract
  parts of production models, and distillation copies capabilities at industrial scale. The
  largest 2026 trade-secret dispute in artificial intelligence, Apple's suit against OpenAI,
  turns on people, laptops and recruiting, not on code that stayed secret. Against this
  background I revisit Linus Torvalds' Linux and Git as evidence that openness scales, and my
  closed undergraduate thesis as evidence of what secrecy costs a researcher. I review
  obfuscation, including my own, and why it cannot hide code, and I contrast it with
  John Nash's 1955 idea of security from computational cost: signed commits, keys held in
  hardware and two-factor authentication protect what secrecy cannot. I then
  argue that the ethical answer to universal reverse engineering is professional citation:
  persistent identifiers, machine-readable citation metadata and agents that borrow, cite and
  propagate credit by default. I describe Paper Fabric, an open, self-improving pipeline in
  the Ouroboric style that produced this preprint, and list its own known limitations.
arxiv:
  primary: cs.CY
  cross-list: [cs.SE, cs.CR, cs.DL]
  license: http://creativecommons.org/licenses/by/4.0/
  comments: "v0 preprint, not peer reviewed. 1 table. Source, build and agent configuration: https://github.com/h0ffmann/closed-source"
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
