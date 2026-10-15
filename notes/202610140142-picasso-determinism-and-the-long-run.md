---
id: "202610140142"
title: "picasso: determinism, and the long run to profit"
type: permanent
status: partial
source: "Matheus Hoffmann, message, 2026-10-14: the thesis is his; a study of 14 October 2026 by an agent (Claude, the Fable model, high effort), six of whose quotations were checked again by the agent that filed this note"
tags: [picasso, nix, determinism, supply-chain, rea, ouroboric, essay]
cssclasses: [ouroboric]
created: 2026-10-14
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# picasso: determinism, and the long run to profit

**The owner's thesis.** picasso may be the first profitable open source, in the long run. Its
argument is determinism. JavaScript and Python build systems deliver open code that nobody
checked, automatically: "a mess". picasso can add determinism to the 21st century, if it is
applied and distributed in the right way. The plan: make picasso a self-improving app that
beats Determinate Systems' Nix, by Ouroboric's REA pattern and reverse citing.

This note sets the record beside each part. The study read picasso at
[`52c5772`](https://github.com/h0ffmann/picasso/tree/52c5772a292e38ac3966a0b7b4d3d337ee1ce1f0),
gvolpe/nix-config at `8d86a82` and DeterminateSystems/nix-src at `b9ca37a`.

## The mess: verified

Each quotation is from the source named, fetched on 14 October 2026.

- **PyPI, March 2026, LiteLLM and telnyx.** "The malware ran on install". From upload to
  quarantine: "2h 32m". And the sentence that matters here: "between ~40-50% of all installs of
  LiteLLM were unpinned and fetching the latest version on each install invocation" (PyPI blog,
  <https://blog.pypi.org/posts/2026-04-02-incident-report-litellm-telnyx-supply-chain-attack/>).
- **GitHub Actions, March 2025, tj-actions/changed-files, CVE-2025-30066.** "Attackers
  retroactively modified multiple version tags to reference a malicious commit", "impacting
  over 23,000 repositories" ([GHSA-mrrh-fwg8-r2c3](https://github.com/advisories/GHSA-mrrh-fwg8-r2c3)).
- **npm, September 2025.** The study also read GitHub's and CISA's pages on the worm named
  "Shai-Hulud" and the advisories on `chalk` and `debug` (CVE-2025-59144), and PyPI's analysis
  of `ultralytics` (December 2024). The filing agent did not check those again.

What the incidents share: a name (a tag, a version range, "latest") was trusted in the place of
a content. When the name moved, the new code arrived by itself.

## Determinism: what Nix gives, and where it stops

- "Nix tries very hard to ensure that Nix expressions are deterministic: building a Nix
  expression twice should yield the same result." (Nix Reference Manual, introduction,
  <https://nix.dev/manual/nix/latest/introduction>; read by the study.)
- The limit: "builds may still leak timestamps or have other nondeterminisms"
  (<https://reproducible.nixos.org/>). Checked again.
- picasso's own whitepaper says the same, at `52c5772`: "Bitwise reproducibility is not
  universal."
- What picasso does with it: nine labs, each a flake with its own `flake.lock`. In the three
  labs that the study read, the only input is nixpkgs, pinned to one revision.

**A fault in picasso that this very argument finds.** Its CI names Determinate's installer by a
tag: `DeterminateSystems/nix-installer-action@v23`, on lines 32, 48 and 135 of
`.github/workflows/ci.yml` at `52c5772` (checked again). A tag is what was moved in the
tj-actions attack. The labs are pinned by content; the workflow that builds them is not.

## picasso, nix-config and Determinate Nix

| | picasso | gvolpe/nix-config | Determinate Nix |
|---|---|---|---|
| What it is | nine self-contained flakes ("labs") for toolchains, with a publisher Action and papers | a NixOS and Home Manager configuration: three hosts, three profiles | a distribution of the Nix CLI with a daemon, an installer, a hosted cache and registry (FlakeHub), a signed package set |
| Licence | AGPL-3.0 (its Zenodo record of v0.1.1 still says MIT) | Apache-2.0 | LGPL-2.1 for nix-src and the installer; the hosted services show none |
| Size | 99 commits, 1 star, one person, since 31 December 2024 | 1,802 commits, 1,117 stars, since 2020 | the installer says "over 7 million installs"; nix-src is a fork of NixOS/nix |
| Money | nothing stated; "no registered legal organization" | nothing stated | paid plans, enterprise support with service levels |

All of it is the study's reading on 14 October 2026.

**The relations, which the plan must start from.**

- picasso **runs on** Determinate Nix. Its README's first sentence says "running Determinate
  Nix" (checked again), and its own study says: "picasso is a customer of the first layer, not
  a competitor to it."
- picasso does not depend on gvolpe/nix-config in code: no flake of picasso has it as an input,
  and picasso's licence table says "the layout is borrowed, no code was copied". Its README
  says "Built on", which is more than its files show.

## The two claims, against the record

- **"The first profitable open source."** Not the first. Red Hat, "the world's leading provider
  of open source solutions", reported for its fiscal year 2019: "total revenue was $3.4
  billion" and "GAAP operating income was $512 million"
  (<https://www.redhat.com/en/about/press-releases/red-hat-reports-fourth-quarter-and-fiscal-year-2019-results>,
  checked again). And picasso earns nothing today: the study found no price, plan, sponsor
  link or legal entity in it. "Profitable in the long run" stays open; "first" does not.
- **"Beat Determinate Systems' Nix."** As the two stand, they are not the same kind of thing:
  one is a Nix, the other needs a Nix to run. No file of picasso measures the two against
  each other. The claim has no test yet.

## The plan, as REA with reverse citing

REA is Ouroboric's pattern: Read, Evaluate, Adopt ([[202610130000-rea-for-forecast-models]]).
Written for this case, each step with what would make it checkable:

1. **Read** Determinate's public repositories at a commit, with their licence (LGPL-2.1), as
   the study did. Read what they sell, from their own pages.
2. **Evaluate** on one axis that is named first. "Beat" needs it. A candidate that follows from
   this note: for a toolchain that an agent or a paper needs, how much of what runs is pinned
   by content, from the compiler to the CI action, and can a reader check it with one command.
3. **Adopt** what the licence allows, and cite it at the point of use, with the commit.
4. **Reverse citing**: the credit also goes back up. The source is named in `.zenodo.json` as a
   related work, so that the index shows the tie from its side too
   ([[202610130845-seen-by-the-right-people]]).
5. **Again.** A self-improving app is this loop run by agents on a schedule, with each round
   logged. The first round has a plain task: pin the CI actions by commit.

**What the plan does not have yet:** the axis, a measurement, a buyer, and an entity that can
be paid. Those are the owner's to decide.

**Status: partial.** The incidents, the limit of Nix, Red Hat's numbers and three facts of
picasso were checked twice. The rest of the comparison is one study's reading. The thesis and
the plan are the owner's; the two claims are contradicted or untested as written, and this
note says so.

The essay: [picasso, and the long run](../essays/2026-picasso-and-the-long-run.md). The same
care for a paper: [[202610131752-what-is-metaquality]].
