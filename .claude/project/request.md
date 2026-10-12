# The request

Posted by Hoffmann in the project chat on 2026-10-12 at 18:33 UTC. Verbatim, typos included.

```text
PAPER fabric should be a mater of REA, and me my personal assistant for producing HIGH QUALITY, TECHNICAL, CREDIBLE, PEER REVIEWED cience, with PDFs. Paper structure should be Md, using same tooling as sandy maguire does in his projects (isovector). V0 should release only the rendered PDF on Zenodo.

It should use ouroboric-dev patterns (add to this project memory)
First paper should be. Closed Source: The God that failed

1. This article should praise Linus Tovardls and his fenomenal work with FOSS, Git and Linux
2. It should contain some anecdotes from the author, explaining history of my academic closed source chemo-RX
3. Science and spionage, OpenAI case 2026. REA explosion
4. Agents should know how to borrowo, cite, propagate
5. It should contain 5 good credible references on why closed source is dead. People can REA anything. The ethical answer is professional citing. Creating DOIs, Should explain why I do Open Source for years and the products of my research (ww3-gpu,  marola-dev, ouroboric-dev, picasso). It should be cited as related work from the same author
6. This PR on h0ffmann/closed-source, should include Zenodo citing tooling (grab from ww3-gpu, picasso or marola)
7. PAPERFABRIC generic work, in the philosophy of Ouroboric
8. This paper should be signed by Rob Kler, Bruno Valério, and me. In the name of Ouroboric DEV
9. Current issues or problems to fix before promoting this repository to ouroboric-dev organization
10. At the end, expor the entire claude project config used to produce the PR in the same PR
```

## Where each point landed

| # | Where |
|---|---|
| 1 | `papers/closed-source/prose/02-bazaar.md` |
| 2 | `papers/closed-source/prose/03-chemo-rx.md` (facts from the public repository; personal accounts left as placeholders for the author) |
| 3 | `papers/closed-source/prose/04-espionage.md` (Apple v. OpenAI, distillation, extraction, decompilation) |
| 4 | `papers/closed-source/prose/06-citing.md`, `AGENTS.md` |
| 5 | `papers/closed-source/prose/05-closed-source-is-dead.md`, `08-related-work.md` |
| 6 | `.zenodo.json`, `CITATION.cff`, `scripts/citation.py`, `scripts/zenodo_upload.py`, `.github/workflows/` |
| 7 | `papers/closed-source/prose/07-paper-fabric.md`, `docs/` |
| 8 | `papers/closed-source/metadata.md`, `.zenodo.json` |
| 9 | `docs/1-product/readiness/2026-10-12-ready-to-promote.md` |
| 10 | this folder |
| follow-up: ASD-STE100 pass | `papers/closed-source/prose-ste/`, `STE100.md`, `.claude/commands/ste100.md`, `scripts/ste_check.py` |
| follow-up: Nash, obfuscation, securing source | `papers/closed-source/prose/05a-securing-source.md` (section 6) |
| follow-up: arXiv setup | `scripts/arxiv.py`, `make arxiv` (now `just arxiv`), `docs/4-ways-of-working/releasing.md` |
| follow-up: just, tooling in picasso | `justfile`, `flake.nix`, `flake.lock`; h0ffmann/picasso#114 (`labs/paper`) |
| follow-up: release guide and secrets | `README.md` ("Secrets and keys", "Release"), `scripts/release.sh` (signed tags) |

"REA" was read as reverse engineering, AI-assisted; the paper says so in section 4.

## Follow-up in the thread

Hoffmann, 2026-10-12 18:39 UTC, verbatim:

```text
This first PR should include arXiv setup as well
```

```text
do a sta100 pass, like we have in h0ffmann/picasso, without changing meaning
```

```text
add some John Nash work to be cited in this paper. The paper should cite obsfuction terchniques like I used in h0ffmann/nashkell, its limitations, and how to secure source code in 2026, criptography on Git plus Keys(with 2FA)
```

## Second pull request (after #1 merged)

Hoffmann, 2026-10-12 19:22 and 19:28 UTC, verbatim:

```text
use just, not makefile. ADD all binary tooling required in this repository to picasso, create a PR there (with new lab paper)
```

```text
in the same PR add clear instructions on read on how to release with just to create NEW ZENODO record + NEW PDF on arvIX. ANY SECRET TOOLING MUST BE CLEAR on readme (keys, token needed)
```

## Third pull request: the website

Hoffmann, 2026-10-12 20:06 UTC, verbatim (relayed by the project's coordinator session):

```text
now create a website for closed-source, in same picasso style, with gleam,create  PR in picasso to create gleam-website labs, to paper fabric doesnt need to install anything just vm site-build, using labs provided by picasso
```

Read as: `just site-build` with only Nix and just installed. Picasso: h0ffmann/picasso#115 (`labs/gleam-website`).

## Third pull request, continued: the jacket, the books and the author

Hoffmann, 2026-10-12, verbatim (relayed by the project's coordinator session):

```text
The website must have same style as picasso, but adapted from 'Democracy: The God That Failed' by HHH. Do citation in readme. There are no proprietary rights on HHH work, by its principle of non existent IP, which matches with Closed Source Philosophy. Add a BOOKS.md it should cover ZAMM and HHH Democracy, and the most famous book critizing IP
```

Read as: a jacket in the site's header after the title of Hoppe's book (type only: the book is
under copyright), its citation in the README, and BOOKS.md (Pirsig, Hoppe, Kinsella, with Boldrin
and Levine beside Kinsella).

Hoffmann, 2026-10-12 20:35 and 20:37 UTC, verbatim:

```text
Only let my names for now, ouroboric ideas should be Credited only to Brunão, Picasso ia a use-case of self-improving system. Add marola and ouroboric logos to the book. This book will have only 50pages. explained later
```

```text
author should be MR. NOBODY, in the front of the book, but will be written by me in 1st person for sure
```

Read as: the cover and title page say Mr. Nobody; the prose is in the first person singular; the
citation metadata names Matheus Hoffmann alone; Ouroboric is credited to Bruno Valério; picasso is
described as a use case of a self-improving system; the Marola and Ouroboric logos go on the title
page and the site's jacket. The 50-page length waits for the explanation.

Hoffmann, 2026-10-12 20:52 UTC, verbatim (relayed by the project's coordinator session), the
explanation of the 50 pages:

```text
hard rule of the book, 50 authors, 1 page per author
```


On the decision card "Who are the 50 authors, one page each, in the book?", Hoffmann chose
"50 thinkers" (20:56 UTC). Then, verbatim (20:57 UTC):

```text
change hardrule to 100pgs, 2 pgs per author
```

Recorded as the hard rule in AGENTS.md, with the roster in papers/closed-source/THINKERS.md.
