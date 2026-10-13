<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
<div align="center">

<img alt="the site's icon: an open letter c with a dot, on a dark square" src="site/static/icons/favicon.svg" width="96"/>

# closed source: the god that failed

<sub>since 2026 · <a href="https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source.pdf">read the paper (PDF)</a> · <a href="https://h0ffmann.github.io/closed-source/">the site</a> · <a href="#build-the-pdf">build</a> · <a href="#release-a-new-zenodo-version-and-a-new-arxiv-pdf">release</a> · <a href="#cite">cite</a> · <a href="#licence">licence</a> · <a href="README.easy.pt-BR.md">🇧🇷 versão fácil</a></sub>

[![h0ffmann/closed-source on github: star the repository](https://img.shields.io/github/stars/h0ffmann/closed-source?style=for-the-badge&logo=github&logoColor=white&label=h0ffmann%2Fclosed-source&labelColor=111111&color=A3201C)](https://github.com/h0ffmann/closed-source)

[![release](https://img.shields.io/github/v/tag/h0ffmann/closed-source?sort=semver&filter=v*&label=release&style=flat-square&color=A3201C)](#release-a-new-zenodo-version-and-a-new-arxiv-pdf)
[![pdf](https://github.com/h0ffmann/closed-source/actions/workflows/pdf.yml/badge.svg)](https://github.com/h0ffmann/closed-source/actions/workflows/pdf.yml)
[![site](https://github.com/h0ffmann/closed-source/actions/workflows/site.yml/badge.svg)](https://github.com/h0ffmann/closed-source/actions/workflows/site.yml)
[![latest DOI](https://img.shields.io/badge/latest_DOI-10.5281%2Fzenodo.23333656-1682D4?style=flat-square)](https://doi.org/10.5281/zenodo.23333656)
[![v0.2.0 DOI](https://img.shields.io/badge/v0.2.0_DOI-10.5281%2Fzenodo.23335204-555555?style=flat-square)](https://doi.org/10.5281/zenodo.23335204)
[![text: CC BY 4.0](https://img.shields.io/badge/text-CC%20BY%204.0-111111?style=flat-square&logo=creativecommons&logoColor=white)](#licence)
[![code: AGPL-3.0](https://img.shields.io/badge/code-AGPL--3.0-111111?style=flat-square&logo=gnu&logoColor=white)](#licence)

the first paper made with **paper fabric**, an open, self-improving pipeline for technical papers
in the [ouroboric](https://github.com/ouroboric-dev/ouroboric) style. markdown in, PDF out, every
reference checked, every release citable.

**read the paper:** [the PDF](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source.pdf) ·
[in simplified technical english](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source-ste.pdf) ·
[em português](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source-pt-BR.pdf)

</div>

> closed source asked researchers to trust that secrecy would protect their work. between 2024 and
> 2026 that trust failed in public. if anyone can reverse engineer anything, the honest course is
> to publish the method, mint an identifier, and cite whatever you use, and to require the same
> of the agents that now do much of the reading and writing.

**author:** mr. nobody on the cover; written in the first person by matheus hoffmann, of the
escola politécnica of UFRJ. the ouroboric ideas are bruno valério's
([ouroboric](https://github.com/ouroboric-dev/ouroboric)).
other citable work by the writer, each with its latest DOI:
[marola](https://github.com/marola-dev/marola) ([10.5281/zenodo.23224155](https://doi.org/10.5281/zenodo.23224155)),
[ww3-gpu](https://github.com/h0ffmann/ww3-gpu) ([10.5281/zenodo.23221351](https://doi.org/10.5281/zenodo.23221351)) and
[picasso](https://github.com/h0ffmann/picasso) ([10.5281/zenodo.23311208](https://doi.org/10.5281/zenodo.23311208)).

**status:** v0.2.0 is live ([releases](RELEASES.md)). a v0 preprint, not peer reviewed. see the [readiness assessment](docs/1-product/readiness/2026-10-12-ready-to-promote.md)
for what must change before v1 and before this repository moves to the `ouroboric-dev`
organisation.

**where the PDF is.** the three links above always open the PDFs of the latest release, from
its github release. the DOI opens the zenodo record, which holds the source archive and links
back to the PDF. the [site](https://h0ffmann.github.io/closed-source/) has the PDFs built from
`main`.

**style.** this page is in lower case, except acronyms such as UFRJ, DOI and PDF, code, and the
generated citation block. the layout follows [picasso's README](https://github.com/h0ffmann/picasso/blob/29eb385/README.md).
[`README.easy.pt-BR.md`](README.easy.pt-BR.md) is the same page in easy brazilian portuguese; it
is made from this file with the [`easy-pt-br`](.claude/skills/easy-pt-br/SKILL.md) skill, and
`just check` fails when it is older than this file.

## build the PDF

on any ubuntu, you need only nix and just. nothing else is installed on the machine. nix comes
from the official installer at [nixos.org](https://nixos.org/download/):

```sh
curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon        # Nix, once; then open a new shell
echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf   # flakes on, once
sudo apt install just                                               # just 1.21 on 24.04
just paper     # the PDFs, in picasso's paper lab -> pdf/
just book      # the PDFs and the book's checks (50 thinkers, cite lines, references, STE)
```

the tools (pandoc 3.7, pandoc-crossref, xelatex, pdflatex, gleam, erlang, just, gh) come from the
`paper` lab of [h0ffmann/picasso](https://github.com/h0ffmann/picasso/tree/main/labs/paper),
pinned by `flake.lock`. `just paper` and `just book` turn flakes on for themselves; the commands
below need the `nix.conf` line above.

```sh
nix develop            # or `just shell`: every tool on PATH
just                   # every paper -> pdf/<slug>.pdf, pdf/<slug>-ste.pdf and pdf/<slug>-pt-BR.pdf
just build closed-source
just check             # build, then the reference-log and STE checks (what CI runs)
just arxiv             # arXiv source bundles, checked with pdfLaTeX, in build/arxiv/
just --list            # every recipe
```

**tooling.** the checks and generators are one gleam project (erlang target) in `tools/`. run
them as `tools/fabric <command>` from the repository root, in `nix develop`. the commands are
`arxiv`, `book-check`, `citation`, `cite-check`, `content`, `logos`, `notes-check`, `ouroboric`,
`refs-check`, `ste-check` and `zenodo-upload`. `just` calls them for you. `cd tools && gleam test`
runs their tests.

each paper builds twice: `pdf/<slug>.pdf` from `prose/`, and `pdf/<slug>-ste.pdf` from `prose-ste/`,
the same paper in ASD-STE100 simplified technical english (after h0ffmann/picasso's
`WHITEPAPER.md`). `/ste100` ([`.claude/commands/ste100.md`](.claude/commands/ste100.md)) makes the
STE text; `tools/fabric ste-check`, run by `just check`, fails if it changes a citation, quotation,
number or marker. the passes are logged in `papers/<slug>/STE100.md`. a paper with `prose-pt-BR/`
also builds `pdf/<slug>-pt-BR.pdf`, the printed edition in brazilian portuguese; `just check` runs
`tools/fabric ste-check --translation` on it, so it keeps every citation, number and quotation.

the toolchain follows sandy maguire's books ([isovector/thinking-with-types](https://github.com/isovector/thinking-with-types)):
markdown prose, pandoc with pandoc-crossref and citeproc, a hand-written latex template, xelatex,
and the git revision stamped on every page.

## website

`site/` is the paper's website: a [lustre](https://lustre.build) application in gleam, in the
style of [picasso's site](https://h0ffmann.github.io/picasso/). the title, abstract (original and
ASD-STE100), authors, contents, counts and citations come from the paper and this README
(`tools/fabric content`), so the site never repeats a fact by hand. the PDFs ship with it.

```sh
just site-build        # PDFs, then site/dist/; needs only Nix and just
just site-serve        # the same, served on http://localhost:8000
```

each half runs in its own toolchain from picasso: the `paper` lab for the PDFs and the
`gleam-website` lab for the site (`nix develop .#site`). the `site` workflow builds it on every
pull request and publishes `site/dist` to github pages from `main`. turn that on once in
github → settings → pages → source: **github actions**. pages needs no secret.

the cover carries a stamp for marola and one for ouroboric, after the logo band of picasso's site:
each links its project and loads the project's logo from its own repository, at the commit the
paper's title page pins (`logos:` in the paper's `metadata.md`). no logo is copied here
([`TRADEMARKS.md`](TRADEMARKS.md)).

the front page opens with the 50 thinkers and the second brain (`notes/`). the site is set like a
book cover, after the colour scheme and type of the cover of

> hoppe, hans-hermann. *democracy—the god that failed: the economics and politics of monarchy,
> democracy, and natural order*. new brunswick, NJ: transaction publishers, 2001. ISBN 0-7658-0088-8.

the identity is black and red, as on that cover, with the title in yellow letters; the owner set
it on 13 october 2026. the colours are choices, not samples. the book is under copyright
(© 2001), so the site copies no cover art and no text from it. the motion follows anthropic's
[frontend-design skill](https://github.com/anthropics/skills) (apache-2.0): one entrance, and
nothing moves when the reader asks for reduced motion. hoppe
argues that ideas should not be property; the law still gives the copyright. [`BOOKS.md`](BOOKS.md)
says more, with the other books behind this repository.

## layout

| path | what's there |
|---|---|
| [`papers/closed-source/`](papers/closed-source/) | the paper: `metadata.md`, `prose/NN-*.md`, `refs.bib`, and the reference log `REFERENCES.md` |
| [`format/`](format/) | the latex template and pandoc-crossref settings shared by every paper |
| [`justfile`](justfile), [`flake.nix`](flake.nix) | the build recipes, and the toolchain pins (picasso's `paper` and `gleam-website` labs) |
| [`site/`](site/) | the website: gleam + lustre, `tools/fabric content` reads the paper |
| [`tools/`](tools/) | the checks and generators, one gleam project: reference check, STE check, arxiv bundle, citation metadata, site content and zenodo upload |
| [`scripts/`](scripts/) | `release.sh`, which tags a release, `readme.sh`, which checks this page's style and its easy version, and `citation-score.sh`, which scores how much of a text is cited |
| [`README.easy.pt-BR.md`](README.easy.pt-BR.md) | this page in easy brazilian portuguese, made from it by the `easy-pt-br` skill; `scripts/readme.sh` checks that it is current |
| [`.claude/skills/`](.claude/skills/README.md) | the agent skills written for this repository, pinned in `skills.lock`: `readme-style`, `easy-pt-br`, `card-style` and `citation-score` |
| [`docs/`](docs/README.md) | paper fabric's charter, ways of working, journal and readiness |
| [`.claude/`](.claude/README.md) | the exported claude project configuration that produced this repository |
| [`TRADEMARKS.md`](TRADEMARKS.md), [`SECURITY.md`](SECURITY.md) | the names the licences do not cover; how to report a vulnerability |
| [`50THINKERS.md`](50THINKERS.md) | the book's roster: 50 thinkers, two pages each, 100 pages (the hard rule in AGENTS.md) |
| [`500AUTHORS.md`](500AUTHORS.md) | the long list the 50 thinkers are chosen from: up to 500 authors the book reads |
| [`RELEASES.md`](RELEASES.md) | each release with its date, its permanent DOI and what changed; v0.2.0 is the latest |
| [`KEYWORDS.md`](KEYWORDS.md), [`RELATED_WORK.md`](RELATED_WORK.md), [`GITHUB_REPO_TOPICS.md`](GITHUB_REPO_TOPICS.md) | how a reader finds this work: the zenodo keywords, the works this one is tied to in zenodo and datacite, and the github topics, each with its counts and its date of record |
| [`CITATION_SCORES.md`](CITATION_SCORES.md) | how much of five READMEs is cited (this one, marola, ouroboric-dev, h0ffmann, picasso), measured by the `citation-score` skill; `just citation-board` writes it and the website shows it |
| [`BOOKS.md`](BOOKS.md) | the books behind the paper: pirsig, hoppe, kinsella, boldrin and levine |
| [`OUROBORIC.md`](OUROBORIC.md), [`OUROBORIC_RESEARCH.md`](OUROBORIC_RESEARCH.md) | one-note digest of the public ouroboric-dev repositories, ethics included, and an index of their research material; refresh with `just ouroboric-sources` then `/update-ouroboric` |
| [`SMART_NOTE_POLICY.md`](SMART_NOTE_POLICY.md), [`notes/`](notes/index.md) | the slip box: zettelkasten notes for the book, obsidian readable; `/note` makes one |
| [`DESCRIPTION.md`](DESCRIPTION.md), [`QUOTES.md`](QUOTES.md), [`ACRONYMOUS.md`](ACRONYMOUS.md), [`INDEX_REMISS.md`](INDEX_REMISS.md) | the one-paragraph description, the quotations with their sources, the acronyms, and the index of cross-references; skeletons until the ingest |
| [`NAGORI.md`](NAGORI.md) | the partial snapshot of the private `h0ffmann/nagori` after the 100 pages; written by the owner by hand, never by an agent or automation (hard rule) |
| [`forks/`](forks/README.md) | the owner's forks as shallow git submodules: rea, ouroboric, ouroboric-dev/.github, WW4, picasso, h0ffmann, ww3-gpu and marola |
| [`PERSONAS.md`](PERSONAS.md) | the personas that every markdown file cites as its main and last author (hard rule) |
| [`AGENTS.md`](AGENTS.md) | the rules every agent follows here, including borrow, cite, propagate |

## secrets and keys

nothing secret is in this repository. a release needs these, and only these:

| what | where it lives | needed for | how to get it |
|---|---|---|---|
| github account with **2FA** on | you | pushing, `just release` | github.com → settings → password and authentication |
| SSH key (or `gh auth login`) that can push to this repository | your machine | `just release` pushes a tag | `ssh-keygen -t ed25519-sk` makes a key that stays on a FIDO security key; add it in github → settings → SSH and GPG keys |
| signing key (optional, recommended) | your machine, `git config user.signingkey` | `just release` signs the tag when it is set | the same SSH key: `git config gpg.format ssh`, `git config user.signingkey ~/.ssh/id_ed25519_sk.pub`, and add it again in github as a **signing key** |
| zenodo account linked to github, with this repository switched on | zenodo.org → your account menu → github | the DOI that zenodo mints for each release | log in to zenodo.org with github, then flip the switch beside `h0ffmann/closed-source`; no token is stored anywhere |
| `ZENODO_SANDBOX_TOKEN` (optional) | your shell, never in a file in the repository | `just zenodo-sandbox`, a rehearsal of a hand-made deposit | sandbox.zenodo.org, a separate account → applications → personal access tokens |
| arxiv account, with an endorsement for `cs.CY` | arxiv.org | the arxiv submission | arxiv.org → register; a first submission to a category needs an endorsement |

the `release` workflow also uses `GITHUB_TOKEN`, which github gives every run; you do not set it.
**never** commit a token, paste it in an issue or pull request, or put it in `.zenodo.json`. if a
token leaks, delete it where it was made at once and make a new one.

once per repository: on zenodo.org → github, turn the switch for this repository **on**. zenodo
then archives each release and mints its DOI ([release](#release-a-new-zenodo-version-and-a-new-arxiv-pdf)).

## release: a new zenodo version and a new arxiv PDF

a release is a git tag on `main`. one command makes it; CI publishes it; zenodo mints its DOI.
no secret is in the chain, as in [marola](https://github.com/marola-dev/marola/blob/cf7bd4f/scripts/release.sh).

1. **merge** the pull request. check that the `pdf` and `citation` workflows pass on `main`.
2. **rehearse**: `just release minor --dry-run` runs every check and tags nothing. there are no
   `-rc` tags: each release is a permanent DOI.
3. **tag**:

   ```sh
   git switch main && git pull
   just release                   # lists what is unreleased and suggests patch, minor or major
   just release minor --dry-run   # shows the tag it will make (or name it: just release 0.2.0)
   just release minor             # tags it (signed if you set a signing key) and pushes it
   just releases                  # the release tags, newest first
   ```

   the script refuses unless main is clean and level with `origin/main`, the version goes up,
   `CITATION.cff` matches `.zenodo.json`, and something changed outside the `forks/` submodule
   pointers since the last tag. a `feat` pull request suggests a minor bump, a breaking
   change (`!`) a major bump (a minor bump before 1.0.0), anything else a patch.

4. **CI** (the `release` workflow) reruns the checks, builds the PDFs and the arxiv bundle, and
   publishes the github release with `pdf/*.pdf` and `build/arxiv/*` attached.
5. **zenodo** archives the published release a few minutes later, through its github webhook
   (switched on once at zenodo.org → your account menu → github). it reads `.zenodo.json` from the
   tagged commit and mints a version DOI under the concept DOI,
   [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656). the record holds the
   source tree at the tag; the PDFs are on the github release. **caution:** a DOI is permanent,
   and you cannot delete a published record yourself.
6. **check** the new version on zenodo.org: the title, the authors with their ORCIDs and the
   licence. then open a pull request that adds the release's row, with its DOI, to
   [`RELEASES.md`](RELEASES.md) and updates this page's badge and table. an edit to `.zenodo.json` reaches zenodo only with the next release.
7. **arxiv** (manual, in the browser): download `<slug>.tar.gz` and `<slug>.txt` from the
   github release, or run `just arxiv` (`build/arxiv/`).
   - a **new paper**: arxiv.org → start new submission. licence CC BY 4.0, upload the tarball,
     paste the title, authors, abstract, comments and categories from the `.txt` file.
   - a **new version** of a paper already on arxiv: open it in your arxiv user page →
     **replace**, and upload the new tarball. arxiv makes it `v2`, `v3`, ….
   - check arxiv's compiled preview against `pdf/<slug>.pdf` before you submit.
   - after the announcement, add `https://arxiv.org/abs/<id>` to `.zenodo.json` as a related
     identifier (relation `isVariantFormOf`, scheme `url`), run `just citation`, and open a
     pull request.

**caution, arxiv:** since 31 october 2025, arxiv's computer-science categories accept review
articles and position papers only after peer review at a journal or conference
([arxiv blog](https://blog.arxiv.org/?p=1740)). arxiv will hold this v0 position paper. submit
it after a venue accepts it. details: [releasing](docs/4-ways-of-working/releasing.md).

## cite

### two DOIs: the latest and the permanent

a DOI is an identifier that keeps resolving when a URL moves. zenodo gives this work two kinds,
and each answers a different question.

| | latest DOI (concept DOI) | permanent DOI (version DOI) |
|---|---|---|
| this work | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) | v0.2.0: [10.5281/zenodo.23335204](https://doi.org/10.5281/zenodo.23335204); v0.1.0: [10.5281/zenodo.23333657](https://doi.org/10.5281/zenodo.23333657) |
| resolves to | the newest release, whichever it is on the day you click | one release, the same bytes forever |
| how many | one for the whole work | one for each release |
| changes when a release is made | no; it starts to point at the new release | no; the new release gets its own |
| use it to | cite the work: "closed source: the god that failed" | say exactly which text you read, quoted or reproduced |

- **cite the latest DOI** in a reference list. a reader then gets the corrected text, and all
  citations count for one work.
- **add the permanent DOI** when the exact wording matters: a quotation, a reproduction, a
  review. version v0.2.0 will always be the source archive of its tag, and v0.1.0 of its own.
- neither can be deleted. a wrong release stays on zenodo; a new release replaces it only as the
  latest.

`just release` makes a new permanent DOI: zenodo archives the release and mints it a few minutes
after the tag ([release](#release-a-new-zenodo-version-and-a-new-arxiv-pdf)). so a release cannot
print its own permanent DOI; [zenodo's page for the latest DOI](https://zenodo.org/doi/10.5281/zenodo.23333656)
lists every version with its DOI, and so does [`RELEASES.md`](RELEASES.md). the block below uses
the latest DOI.

### how a reader finds this work

you only need to be seen by the right people
([note](notes/202610130845-seen-by-the-right-people.md)). for this paper they are reverse
engineers first, then the people who work on research software. three kinds of word lead a
reader here. each has its own page, with the counts and the day they were read.

| | what it is | where a reader meets it | page |
|---|---|---|---|
| keywords | 21 phrases on the zenodo record, such as "reverse engineering" and "decompilation" | on any zenodo record, a keyword is a link to every record with the same keyword | [`KEYWORDS.md`](KEYWORDS.md) |
| related work | the works this one cites, by DOI: three by other people, three by the writer | zenodo's "related works" box; zenodo sends the ties to datacite, which counts them in both directions | [`RELATED_WORK.md`](RELATED_WORK.md) |
| topics | 20 words on the github repository, such as `reverse-engineering` | github's topic pages and its search | [`GITHUB_REPO_TOPICS.md`](GITHUB_REPO_TOPICS.md) |

- **a keyword must be written as the reader writes it.** zenodo has no fixed list, so "trade
  secret" and "trade secrets" are two different rooms.
- **a tie counts only when it is a DOI.** a link to a URL is kept, and not counted.
- **both change only with a release.** a published version keeps the words and the ties it had.
- **a word is kept when the right reader would type it and the paper is about it.** a word that
  only brings more visitors is left out.

<!-- citation:start -->

BibTeX:

```bibtex
@misc{hoffmann_2026_closedsource,
  author    = {Hoffmann, Matheus},
  title     = {{Closed Source: The God that Failed}},
  year      = {2026},
  publisher = {Zenodo},
  doi       = {10.5281/zenodo.23333656},
  url       = {https://github.com/h0ffmann/closed-source}
}
```

APA:

> Hoffmann, M. (2026). *Closed Source: The God that Failed* [Preprint]. Zenodo. https://doi.org/10.5281/zenodo.23333656

ABNT (NBR 6023):

> HOFFMANN, Matheus. **Closed Source**: The God that Failed. [S. l.]: Zenodo, 2026. DOI 10.5281/zenodo.23333656.

<!-- citation:end -->

## licence

- paper text, docs and figures: [CC BY 4.0](LICENSE).
- scripts, workflows, build files and the website (`scripts/`, `.github/`, `justfile`, `flake.nix`, `site/`): [AGPL-3.0-only](LICENSES/AGPL-3.0-only.txt).
- latex template (`format/`), which other papers copy: [MIT](LICENSES/MIT.txt).
- ouroboric's names and logos are not licensed here; see ouroboric's
  [trademark policy](https://github.com/ouroboric-dev/ouroboric/blob/main/TRADEMARKS.md).
- the website's footer shows gleam's lucy ([gleam-lang/branding](https://github.com/gleam-lang/branding)) and
  the claude code icon. both load from their owners' sites, and neither is licensed here.

each file's licence is recorded in [`REUSE.toml`](REUSE.toml).
