<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Closed Source: The God that Failed

The first paper made with **Paper Fabric**, an open, self-improving pipeline for technical papers
in the [Ouroboric](https://github.com/ouroboric-dev/ouroboric) style. Markdown in, PDF out, every
reference checked, every release citable.

> Closed source asked researchers to trust that secrecy would protect their work. Between 2024 and
> 2026 that trust failed in public. If anyone can reverse engineer anything, the honest course is
> to publish the method, mint an identifier, and cite whatever you use, and to require the same
> of the agents that now do much of the reading and writing.

[![latest DOI](https://img.shields.io/badge/latest_DOI-10.5281%2Fzenodo.23333656-1682D4?style=flat-square)](https://doi.org/10.5281/zenodo.23333656)
[![v0.1.0 DOI](https://img.shields.io/badge/v0.1.0_DOI-10.5281%2Fzenodo.23333657-555555?style=flat-square)](https://doi.org/10.5281/zenodo.23333657)

**Author:** Mr. Nobody on the cover; written in the first person by Matheus Hoffmann. The ouroboric
ideas are Bruno Valério's ([Ouroboric](https://github.com/ouroboric-dev/ouroboric)).
Other citable work by the writer, each with its latest DOI:
[marola](https://github.com/marola-dev/marola) ([10.5281/zenodo.23224155](https://doi.org/10.5281/zenodo.23224155)),
[ww3-gpu](https://github.com/h0ffmann/ww3-gpu) ([10.5281/zenodo.23221351](https://doi.org/10.5281/zenodo.23221351)) and
[picasso](https://github.com/h0ffmann/picasso) ([10.5281/zenodo.23311208](https://doi.org/10.5281/zenodo.23311208)).
**Status:** v0 preprint, not peer reviewed. See the [readiness assessment](docs/1-product/readiness/2026-10-12-ready-to-promote.md)
for what must change before v1 and before this repository moves to the `ouroboric-dev`
organisation.

## Build the PDF

On any Ubuntu, you need only Nix and just. Nothing else is installed on the machine. Nix comes
from the official installer at [nixos.org](https://nixos.org/download/):

```sh
curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon        # Nix, once; then open a new shell
echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf   # flakes on, once
sudo apt install just                                               # just 1.21 on 24.04
just paper     # the PDFs, in picasso's paper lab -> pdf/
just book      # the PDFs and the book's checks (50 thinkers, cite lines, references, STE)
```

The tools (pandoc 3.7, pandoc-crossref, XeLaTeX, pdfLaTeX, Gleam, Erlang, just, gh) come from the
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

**Tooling.** The checks and generators are one Gleam project (Erlang target) in `tools/`. Run
them as `tools/fabric <command>` from the repository root, in `nix develop`. The commands are
`arxiv`, `book-check`, `citation`, `cite-check`, `content`, `logos`, `notes-check`, `ouroboric`,
`refs-check`, `ste-check` and `zenodo-upload`. `just` calls them for you. `cd tools && gleam test`
runs their tests.

Each paper builds twice: `pdf/<slug>.pdf` from `prose/`, and `pdf/<slug>-ste.pdf` from `prose-ste/`,
the same paper in ASD-STE100 Simplified Technical English (after h0ffmann/picasso's
`WHITEPAPER.md`). `/ste100` ([`.claude/commands/ste100.md`](.claude/commands/ste100.md)) makes the
STE text; `tools/fabric ste-check`, run by `just check`, fails if it changes a citation, quotation,
number or marker. The passes are logged in `papers/<slug>/STE100.md`. A paper with `prose-pt-BR/`
also builds `pdf/<slug>-pt-BR.pdf`, the printed edition in Brazilian Portuguese; `just check` runs
`tools/fabric ste-check --translation` on it, so it keeps every citation, number and quotation.

The toolchain follows Sandy Maguire's books ([isovector/thinking-with-types](https://github.com/isovector/thinking-with-types)):
Markdown prose, pandoc with pandoc-crossref and citeproc, a hand-written LaTeX template, XeLaTeX,
and the Git revision stamped on every page.

## Website

`site/` is the paper's website: a [Lustre](https://lustre.build) application in Gleam, in the
style of [picasso's site](https://h0ffmann.github.io/picasso/). The title, abstract (original and
ASD-STE100), authors, contents, counts and citations come from the paper and this README
(`tools/fabric content`), so the site never repeats a fact by hand. The PDFs ship with it.

```sh
just site-build        # PDFs, then site/dist/; needs only Nix and just
just site-serve        # the same, served on http://localhost:8000
```

Each half runs in its own toolchain from picasso: the `paper` lab for the PDFs and the
`gleam-website` lab for the site (`nix develop .#site`). The `site` workflow builds it on every
pull request and publishes `site/dist` to GitHub Pages from `main`. Turn that on once in
GitHub → Settings → Pages → Source: **GitHub Actions**. Pages needs no secret.

The cover carries a stamp for Marola and one for Ouroboric, after the logo band of picasso's site:
each links its project and loads the project's logo from its own repository, at the commit the
paper's title page pins (`logos:` in the paper's `metadata.md`). No logo is copied here
([`TRADEMARKS.md`](TRADEMARKS.md)).

The front page opens with the 50 Thinkers and the second brain (`notes/`). The site is set like a
book cover, after the colour scheme and type of the cover of

> Hoppe, Hans-Hermann. *Democracy—The God That Failed: The Economics and Politics of Monarchy,
> Democracy, and Natural Order*. New Brunswick, NJ: Transaction Publishers, 2001. ISBN 0-7658-0088-8.

Its 2001 cover has a brown field, a white title, a red band and the rest of the title in black. The
site's colours are estimates from that description, not samples. The book is under copyright
(© 2001), so the site copies no cover art and no text from it. The motion follows Anthropic's
[frontend-design skill](https://github.com/anthropics/skills) (Apache-2.0): one entrance, and
nothing moves when the reader asks for reduced motion. Hoppe
argues that ideas should not be property; the law still gives the copyright. [`BOOKS.md`](BOOKS.md)
says more, with the other books behind this repository.

## Layout

| Path | What's there |
|---|---|
| [`papers/closed-source/`](papers/closed-source/) | the paper: `metadata.md`, `prose/NN-*.md`, `refs.bib`, and the reference log `REFERENCES.md` |
| [`format/`](format/) | the LaTeX template and pandoc-crossref settings shared by every paper |
| [`justfile`](justfile), [`flake.nix`](flake.nix) | the build recipes, and the toolchain pins (picasso's `paper` and `gleam-website` labs) |
| [`site/`](site/) | the website: Gleam + Lustre, `tools/fabric content` reads the paper |
| [`tools/`](tools/) | the checks and generators, one Gleam project: reference check, STE check, arXiv bundle, citation metadata, site content and Zenodo upload |
| [`scripts/`](scripts/) | `release.sh`, which tags a release |
| [`docs/`](docs/README.md) | Paper Fabric's charter, ways of working, journal and readiness |
| [`.claude/`](.claude/README.md) | the exported Claude project configuration that produced this repository |
| [`TRADEMARKS.md`](TRADEMARKS.md), [`SECURITY.md`](SECURITY.md) | the names the licences do not cover; how to report a vulnerability |
| [`50THINKERS.md`](50THINKERS.md) | the book's roster: 50 thinkers, two pages each, 100 pages (the hard rule in AGENTS.md) |
| [`500AUTHORS.md`](500AUTHORS.md) | the long list the 50 thinkers are chosen from: up to 500 authors the book reads |
| [`BOOKS.md`](BOOKS.md) | the books behind the paper: Pirsig, Hoppe, Kinsella, Boldrin and Levine |
| [`OUROBORIC.md`](OUROBORIC.md), [`OUROBORIC_RESEARCH.md`](OUROBORIC_RESEARCH.md) | one-note digest of the public ouroboric-dev repositories, ethics included, and an index of their research material; refresh with `just ouroboric-sources` then `/update-ouroboric` |
| [`SMART_NOTE_POLICY.md`](SMART_NOTE_POLICY.md), [`notes/`](notes/index.md) | the slip box: Zettelkasten notes for the book, Obsidian readable; `/note` makes one |
| [`DESCRIPTION.md`](DESCRIPTION.md), [`QUOTES.md`](QUOTES.md), [`ACRONYMOUS.md`](ACRONYMOUS.md), [`INDEX_REMISS.md`](INDEX_REMISS.md) | the one-paragraph description, the quotations with their sources, the acronyms, and the index of cross-references; skeletons until the ingest |
| [`NAGORI.md`](NAGORI.md) | the partial snapshot of the private `h0ffmann/nagori` after the 100 pages; written by the owner by hand, never by an agent or automation (hard rule) |
| [`forks/`](forks/README.md) | the owner's forks as shallow git submodules: rea, ouroboric, ouroboric-dev/.github, WW4, picasso, h0ffmann, ww3-gpu and marola |
| [`PERSONAS.md`](PERSONAS.md) | the personas that every Markdown file cites as its main and last author (hard rule) |
| [`AGENTS.md`](AGENTS.md) | the rules every agent follows here, including borrow, cite, propagate |

## Secrets and keys

Nothing secret is in this repository. A release needs these, and only these:

| What | Where it lives | Needed for | How to get it |
|---|---|---|---|
| GitHub account with **2FA** on | you | pushing, `just release` | github.com → Settings → Password and authentication |
| SSH key (or `gh auth login`) that can push to this repository | your machine | `just release` pushes a tag | `ssh-keygen -t ed25519-sk` makes a key that stays on a FIDO security key; add it in GitHub → Settings → SSH and GPG keys |
| Signing key (optional, recommended) | your machine, `git config user.signingkey` | `just release` signs the tag when it is set | the same SSH key: `git config gpg.format ssh`, `git config user.signingkey ~/.ssh/id_ed25519_sk.pub`, and add it again in GitHub as a **Signing key** |
| Zenodo account linked to GitHub, with this repository switched on | zenodo.org → your account menu → GitHub | the DOI that Zenodo mints for each release | log in to zenodo.org with GitHub, then flip the switch beside `h0ffmann/closed-source`; no token is stored anywhere |
| `ZENODO_SANDBOX_TOKEN` (optional) | your shell, never in a file in the repository | `just zenodo-sandbox`, a rehearsal of a hand-made deposit | sandbox.zenodo.org, a separate account → Applications → Personal access tokens |
| arXiv account, with an endorsement for `cs.CY` | arxiv.org | the arXiv submission | arxiv.org → Register; a first submission to a category needs an endorsement |

The `release` workflow also uses `GITHUB_TOKEN`, which GitHub gives every run; you do not set it.
**Never** commit a token, paste it in an issue or pull request, or put it in `.zenodo.json`. If a
token leaks, delete it on zenodo.org at once and make a new one.

Once per repository: on zenodo.org → GitHub, keep the switch for this repository **off**. The
Zenodo GitHub integration archives the source tree, not the PDF.

## Release: a new Zenodo version and a new arXiv PDF

A release is a Git tag on `main`. One command makes it; CI publishes it; Zenodo mints its DOI.
No secret is in the chain, as in [marola](https://github.com/marola-dev/marola/blob/cf7bd4f/scripts/release.sh).

1. **Merge** the pull request. Check that the `pdf` and `citation` workflows pass on `main`.
2. **Rehearse**: `just release minor --dry-run` runs every check and tags nothing. There are no
   `-rc` tags: each release is a permanent DOI.
3. **Tag**:

   ```sh
   git switch main && git pull
   just release                   # lists what is unreleased and suggests patch, minor or major
   just release minor --dry-run   # shows the tag it will make (or name it: just release 0.2.0)
   just release minor             # tags it (signed if you set a signing key) and pushes it
   just releases                  # the release tags, newest first
   ```

   The script refuses unless main is clean and level with `origin/main`, the version goes up,
   `CITATION.cff` matches `.zenodo.json`, and something changed outside the `forks/` submodule
   pointers since the last tag. A `feat` pull request suggests a minor bump, a breaking
   change (`!`) a major bump (a minor bump before 1.0.0), anything else a patch.

4. **CI** (the `release` workflow) reruns the checks, builds the PDFs and the arXiv bundle, and
   publishes the GitHub release with `pdf/*.pdf` and `build/arxiv/*` attached.
5. **Zenodo** archives the published release a few minutes later, through its GitHub webhook
   (switched on once at zenodo.org → your account menu → GitHub). It reads `.zenodo.json` from the
   tagged commit and mints a version DOI under the concept DOI,
   [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656). The record holds the
   source tree at the tag; the PDFs are on the GitHub release. **Caution:** a DOI is permanent,
   and you cannot delete a published record yourself.
6. **Check** the new version on zenodo.org: the title, the authors with their ORCIDs and the
   licence. An edit to `.zenodo.json` reaches Zenodo only with the next release.
7. **arXiv** (manual, in the browser): download `<slug>.tar.gz` and `<slug>.txt` from the
   GitHub release, or run `just arxiv` (`build/arxiv/`).
   - A **new paper**: arxiv.org → Start new submission. Licence CC BY 4.0, upload the tarball,
     paste the title, authors, abstract, comments and categories from the `.txt` file.
   - A **new version** of a paper already on arXiv: open it in your arXiv user page →
     **Replace**, and upload the new tarball. arXiv makes it `v2`, `v3`, ….
   - Check arXiv's compiled preview against `pdf/<slug>.pdf` before you submit.
   - After the announcement, add `https://arxiv.org/abs/<id>` to `.zenodo.json` as a related
     identifier (relation `isVariantFormOf`, scheme `url`), run `just citation`, and open a
     pull request.

**Caution, arXiv:** since 31 October 2025, arXiv's computer-science categories accept review
articles and position papers only after peer review at a journal or conference
([arXiv blog](https://blog.arxiv.org/?p=1740)). arXiv will hold this v0 position paper. Submit
it after a venue accepts it. Details: [releasing](docs/4-ways-of-working/releasing.md).

## Cite

### Two DOIs: the latest and the permanent

A DOI is an identifier that keeps resolving when a URL moves. Zenodo gives this work two kinds,
and each answers a different question.

| | Latest DOI (concept DOI) | Permanent DOI (version DOI) |
|---|---|---|
| This work | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) | v0.1.0: [10.5281/zenodo.23333657](https://doi.org/10.5281/zenodo.23333657) |
| Resolves to | the newest release, whichever it is on the day you click | one release, the same bytes forever |
| How many | one for the whole work | one for each release |
| Changes when a release is made | no; it starts to point at the new release | no; the new release gets its own |
| Use it to | cite the work: "Closed Source: The God that Failed" | say exactly which text you read, quoted or reproduced |

- **Cite the latest DOI** in a reference list. A reader then gets the corrected text, and all
  citations count for one work.
- **Add the permanent DOI** when the exact wording matters: a quotation, a reproduction, a
  review. Version v0.1.0 will always be the source archive of 13 October 2026.
- Neither can be deleted. A wrong release stays on Zenodo; a new release replaces it only as the
  latest.

`just release` makes a new permanent DOI: Zenodo archives the release and mints it a few minutes
after the tag ([Release](#release-a-new-zenodo-version-and-a-new-arxiv-pdf)). So a release cannot
print its own permanent DOI; [Zenodo's page for the latest DOI](https://zenodo.org/doi/10.5281/zenodo.23333656)
lists every version with its DOI. The block below uses the latest DOI.

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

## Licence

- Paper text, docs and figures: [CC BY 4.0](LICENSE).
- Scripts, workflows, build files and the website (`scripts/`, `.github/`, `justfile`, `flake.nix`, `site/`): [AGPL-3.0-only](LICENSES/AGPL-3.0-only.txt).
- LaTeX template (`format/`), which other papers copy: [MIT](LICENSES/MIT.txt).
- Ouroboric's names and logos are not licensed here; see Ouroboric's
  [trademark policy](https://github.com/ouroboric-dev/ouroboric/blob/main/TRADEMARKS.md).
- The website's footer shows Gleam's Lucy ([gleam-lang/branding](https://github.com/gleam-lang/branding)) and
  the Claude Code icon. Both load from their owners' sites, and neither is licensed here.

Each file's licence is recorded in [`REUSE.toml`](REUSE.toml).
