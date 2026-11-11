---
title: "Works"
status: draft
date: 2026-11-11
related: [README.md, papers/closed-source/metadata.md, RELATED_WORK.md, CITATION.cff]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Works

The index of the open works of the writer, Matheus Hoffmann, across his three GitHub accounts:
[`h0ffmann`](https://github.com/h0ffmann) (his own),
[`marola-dev`](https://github.com/marola-dev) (marola, water) and
[`piabrota`](https://github.com/piabrota) (an open software fabric made in Rio de Janeiro).

**Date of record: 11 November 2026.** Each row was read that day: the repository list from
GitHub's search (`user:<account> fork:false`), the commit from `git ls-remote <repo> HEAD`, the
licence from the repository's `LICENSE`, and each DOI from the repository's own `CITATION.cff`,
`.zenodo.json` or README at that commit. A DOI here is the concept DOI, which always resolves to
the newest version. Never add a row, a DOI or a commit that was not read from its source on the
date of record; change the date when you read them again.

Left out: forks, private repositories, and repositories with no code or text yet (`piabrota/ihero`,
`marola-dev/marola-swim`). Repositories last pushed before 2026 are not indexed.

## Citable works (with a DOI)

These have a DOI on Zenodo. The book's site shows each as a tile in its DOIs section, from
`works:` in [`papers/closed-source/metadata.md`](papers/closed-source/metadata.md).

| Work | Account | What it is | Concept DOI | Read at |
|---|---|---|---|---|
| [closed-source](https://github.com/h0ffmann/closed-source) | h0ffmann | this book: *Closed Source: The God that Failed* | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) | [`RELEASES.md`](RELEASES.md) |
| [marola](https://github.com/marola-dev/marola) | marola-dev | an open, non-profit platform for sea conditions and bathing-water quality at Brazilian beaches | [10.5281/zenodo.23224155](https://doi.org/10.5281/zenodo.23224155) | `CITATION.cff` at `94121b8` |
| [ww3-gpu](https://github.com/h0ffmann/ww3-gpu) | h0ffmann | the WW3 GPU Lab: a bit-for-bit GPU port of WAVEWATCH III, with agentic coding and research | [10.5281/zenodo.23221351](https://doi.org/10.5281/zenodo.23221351) | `CITATION.cff` at `eca3b0b` |
| [picasso](https://github.com/h0ffmann/picasso) | h0ffmann | deterministic toolchains with just, Nix and Rust; it builds this book | [10.5281/zenodo.23311208](https://doi.org/10.5281/zenodo.23311208) | `CITATION.cff` at `5da5237` |
| [nashkell](https://h0ffmann.github.io/nashkell/) | h0ffmann | an open book in progress, in the voice of Nash: game theory and Haskell | [10.5281/zenodo.23356739](https://doi.org/10.5281/zenodo.23356739) | `CITATION.cff` at `2afe237` |
| [gramatico](https://github.com/piabrota/gramatico) | piabrota | controlled technical Brazilian Portuguese for people and agents: a Claude Code plugin that rewrites technical text so it reads once | [10.5281/zenodo.23554531](https://doi.org/10.5281/zenodo.23554531) | `CITATION.cff` at `87d9960` |
| [marola-bench](https://github.com/marola-dev/marola-research) | marola-dev | a WeatherBench for Brazil: a proposal, in marola-research | [10.5281/zenodo.23352633](https://doi.org/10.5281/zenodo.23352633) | README at `59d7ef6` |

The ww3-gpu concept DOI also has the version v0.2.0,
[10.5281/zenodo.24130909](https://doi.org/10.5281/zenodo.24130909), whose work is in
[ww3-dia-gpu-v2](https://github.com/h0ffmann/ww3-dia-gpu-v2) (ww3-gpu `CITATION.cff` at `eca3b0b`).

## h0ffmann

| Work | What it is | Licence | Commit |
|---|---|---|---|
| [ww3-dia-gpu-v2](https://github.com/h0ffmann/ww3-dia-gpu-v2) | the whole W3SNL1, inside WAVEWATCH III, bit for bit | MIT | `9d07a8c` |
| [chaceon](https://github.com/h0ffmann/chaceon) | CPU and GPU wave modelling in pure agentic Rust | MPL-2.0 | `89a11e4` |
| [proof](https://github.com/h0ffmann/proof) | incubating: specifications proved in Lean 4, implementations checked against them, and Agda experiments | MPL-2.0 | `27f1a2e` |
| [smart-notes](https://github.com/h0ffmann/smart-notes) | Obsidian for humans | MPL-2.0 | `500c6ff` |
| [montaigne](https://github.com/h0ffmann/montaigne) | text-to-sound (TTS) experiments | MIT | `c88bf33` |
| [awesome-neurosymbolic-ai](https://github.com/h0ffmann/awesome-neurosymbolic-ai) | a curated list for neurosymbolic AI, where symbolic AI meets deep networks | see the repository | `74a9908` |
| [astrbot_dw_ext_br_south_disaster](https://github.com/h0ffmann/astrbot_dw_ext_br_south_disaster) | disaster alerts for the south of Brazil (RS, SC, PR), an AstrBot extension | MPL-2.0 | `a667547` |
| [astrbot_dw_ext_br_south_waterq](https://github.com/h0ffmann/astrbot_dw_ext_br_south_waterq) | bathing-water quality alerts for the south of Brazil, an AstrBot extension | MPL-2.0 | `12b71ac` |
| [chemo-rx](https://github.com/h0ffmann/chemo-rx) | the writer's undergraduate thesis (the repository's description) | see the repository | `c887e9c` |

## marola-dev

| Work | What it is | Licence | Commit |
|---|---|---|---|
| [marola-research](https://github.com/marola-dev/marola-research) | marola's science: wave models on GPUs and marola-bench | MIT | `59d7ef6` |
| [marola-site](https://github.com/marola-dev/marola-site) | the marola.dev frontend | MIT | `6579b18` |
| [marola-app](https://github.com/marola-dev/marola-app) | the marola backend | MIT | `7061a08` |
| [marola-oods](https://github.com/marola-dev/marola-oods) | the open ocean data store: Brazilian bathing-water data as versioned files | MIT | `3db8113` |
| [marola-corpus](https://github.com/marola-dev/marola-corpus) | a knowledge corpus of sourced ocean and marine-safety notes, released as a pinned tarball | MIT | `1137cd4` |
| [marola-ml](https://github.com/marola-dev/marola-ml) | marolaGPT: the fine-tune, the DSPy prompt compile, the local model image and the benchmark gate | MIT | `e63f0ad` |
| [marola-skills](https://github.com/marola-dev/marola-skills) | the marola way of coding: agent skills | MIT | `f613dac` |
| [marola-devkit](https://github.com/marola-dev/marola-devkit) | the dev-flow harness for the marola repositories: scripts, a plugin marketplace and reusable workflows | MIT | `2d49d22` |
| [awesome-ocean-sciences](https://github.com/marola-dev/awesome-ocean-sciences) | a curated list of ocean-science software, models, data and resources | CC0-1.0 | `2370e33` |

## piabrota

The descriptions follow the org profile, [`piabrota/.github`](https://github.com/piabrota/.github)
`profile/README.md` at `481e94f`, "Projects".

| Work | What it is | Licence | Commit |
|---|---|---|---|
| [pirsig](https://github.com/piabrota/pirsig) | a second brain: PARA and a Zettelkasten slip box in one Rust app, with a desktop app, a REST API and the `psg` CLI | MPL-2.0 | `caa7bc7` |
| [alerts](https://github.com/piabrota/alerts) | a generic alert platform from official sources only, to Discord and an Atom feed with CAP 1.2; first hazard: floods in the south of Brazil | MPL-2.0 | `d69858c` |
| [rax](https://github.com/piabrota/rax) | Rustic Agentic Runtime: a pure-Rust port of AX, the declarative orchestrator for agentic tasks | MPL-2.0 | `92e7f0d` |
| [room](https://github.com/piabrota/room) | a personal site that is a 3D room in three.js, at [room.piabrota.art](https://room.piabrota.art) | MPL-2.0 | `872f416` |
| [skills](https://github.com/piabrota/skills) | a Swiss army knife of agent skills | MPL-2.0 | `cd06801` |
| [nix-os](https://github.com/piabrota/nix-os) | the NixOS configuration of the VPS that serves piabrota.art | MPL-2.0 | `4147c1a` |
| [agents](https://github.com/piabrota/agents) | small agents that watch nix-os and its VPS, and open pull requests as piabrota-ops | MPL-2.0 | `c1bbebb` |
| [mu](https://github.com/piabrota/mu) | the company chart: the dogma, the standards, the journal and the index of the org's repositories | CC BY 4.0, AGPL-3.0, MPL-2.0 | `b48daba` |
| [dojo](https://github.com/piabrota/dojo) | the umbrella of the piabrota projects, being set up | MPL-2.0 | `7d31e93` |
