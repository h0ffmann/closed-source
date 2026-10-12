<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Closed Source: The God that Failed

The first paper made with **Paper Fabric**, an open, self-improving pipeline for technical papers
in the [Ouroboric](https://github.com/ouroboric-dev/ouroboric) style. Markdown in, PDF out, every
reference checked, every release citable.

> Closed source asked researchers to trust that secrecy would protect their work. Between 2024 and
> 2026 that trust failed in public. If anyone can reverse engineer anything, the honest course is
> to publish the method, mint an identifier, and cite whatever you use, and to require the same
> of the agents that now do much of the reading and writing.

**Author:** Mr. Nobody on the cover; written in the first person by Matheus Hoffmann. The ouroboric
ideas are Bruno Valério's ([Ouroboric](https://github.com/ouroboric-dev/ouroboric)).
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

The tools (pandoc 3.7, pandoc-crossref, XeLaTeX, pdfLaTeX, python, just, gh) come from the
`paper` lab of [h0ffmann/picasso](https://github.com/h0ffmann/picasso/tree/main/labs/paper),
pinned by `flake.lock`. `just paper` and `just book` turn flakes on for themselves; the commands
below need the `nix.conf` line above.

```sh
nix develop            # or `just shell`: every tool on PATH
just                   # every paper -> pdf/<slug>.pdf and pdf/<slug>-ste.pdf
just build closed-source
just check             # build, then the reference-log and STE checks (what CI runs)
just arxiv             # arXiv source bundles, checked with pdfLaTeX, in build/arxiv/
just --list            # every recipe
```

Each paper builds twice: `pdf/<slug>.pdf` from `prose/`, and `pdf/<slug>-ste.pdf` from `prose-ste/`,
the same paper in ASD-STE100 Simplified Technical English (after h0ffmann/picasso's
`WHITEPAPER.md`). `/ste100` ([`.claude/commands/ste100.md`](.claude/commands/ste100.md)) makes the
STE text; `scripts/ste_check.py`, run by `just check`, fails if it changes a citation, quotation,
number or marker. The passes are logged in `papers/<slug>/STE100.md`.

The toolchain follows Sandy Maguire's books ([isovector/thinking-with-types](https://github.com/isovector/thinking-with-types)):
Markdown prose, pandoc with pandoc-crossref and citeproc, a hand-written LaTeX template, XeLaTeX,
and the Git revision stamped on every page.

## Website

`site/` is the paper's website: a [Lustre](https://lustre.build) application in Gleam, in the
style of [picasso's site](https://h0ffmann.github.io/picasso/). The title, abstract (original and
ASD-STE100), authors, contents, counts and citations come from the paper and this README
(`site/content.py`), so the site never repeats a fact by hand. The PDFs ship with it.

```sh
just site-build        # PDFs, then site/dist/; needs only Nix and just
just site-serve        # the same, served on http://localhost:8000
```

Each half runs in its own toolchain from picasso: the `paper` lab for the PDFs and the
`gleam-website` lab for the site (`nix develop .#site`). The `site` workflow builds it on every
pull request and publishes `site/dist` to GitHub Pages from `main`. Turn that on once in
GitHub → Settings → Pages → Source: **GitHub Actions**. Pages needs no secret.

The header's jacket sets the title after the title formula and book-jacket typography of

> Hoppe, Hans-Hermann. *Democracy—The God That Failed: The Economics and Politics of Monarchy,
> Democracy, and Natural Order*. New Brunswick, NJ: Transaction Publishers, 2001. ISBN 0-7658-0088-8.

The book is under copyright (© 2001), so the site copies no cover art and no text from it. Hoppe
argues that ideas should not be property; the law still gives the copyright. [`BOOKS.md`](BOOKS.md)
says more, with the other books behind this repository.

## Layout

| Path | What's there |
|---|---|
| [`papers/closed-source/`](papers/closed-source/) | the paper: `metadata.md`, `prose/NN-*.md`, `refs.bib`, and the reference log `REFERENCES.md` |
| [`format/`](format/) | the LaTeX template and pandoc-crossref settings shared by every paper |
| [`justfile`](justfile), [`flake.nix`](flake.nix) | the build recipes, and the toolchain pins (picasso's `paper` and `gleam-website` labs) |
| [`site/`](site/) | the website: Gleam + Lustre, `site/content.py` reads the paper |
| [`scripts/`](scripts/) | reference check, STE check, arXiv bundle, citation metadata, release and Zenodo upload |
| [`docs/`](docs/README.md) | Paper Fabric's charter, ways of working, journal and readiness |
| [`.claude/`](.claude/README.md) | the exported Claude project configuration that produced this repository |
| [`papers/closed-source/THINKERS.md`](papers/closed-source/THINKERS.md) | the book's roster: 50 thinkers, two pages each, 100 pages (the hard rule in AGENTS.md) |
| [`BOOKS.md`](BOOKS.md) | the books behind the paper: Pirsig, Hoppe, Kinsella, Boldrin and Levine |
| [`OUROBORIC.md`](OUROBORIC.md), [`OUROBORIC_RESEARCH.md`](OUROBORIC_RESEARCH.md) | one-note digest of the public ouroboric-dev repositories, ethics included, and an index of their research material; refresh with `just ouroboric-sources` then `/update-ouroboric` |
| [`PERSONAS.md`](PERSONAS.md) | the personas that every Markdown file cites as its main and last author (hard rule) |
| [`AGENTS.md`](AGENTS.md) | the rules every agent follows here, including borrow, cite, propagate |

## Secrets and keys

Nothing secret is in this repository. A release needs these, and only these:

| What | Where it lives | Needed for | How to get it |
|---|---|---|---|
| GitHub account with **2FA** on | you | pushing, `just release` | github.com → Settings → Password and authentication |
| SSH key (or `gh auth login`) that can push to this repository | your machine | `just release` pushes a tag | `ssh-keygen -t ed25519-sk` makes a key that stays on a FIDO security key; add it in GitHub → Settings → SSH and GPG keys |
| Signing key (optional, recommended) | your machine, `git config user.signingkey` | `just release` signs the tag when it is set | the same SSH key: `git config gpg.format ssh`, `git config user.signingkey ~/.ssh/id_ed25519_sk.pub`, and add it again in GitHub as a **Signing key** |
| `ZENODO_TOKEN` | GitHub → Settings → Secrets and variables → Actions → **Secrets** (or `gh secret set ZENODO_TOKEN`) | the Zenodo draft that the `release` workflow makes | zenodo.org → your account menu → Applications → Personal access tokens → New token, scopes `deposit:write` and `deposit:actions` |
| `ZENODO_TOKEN` in your shell (optional) | `export ZENODO_TOKEN=...`, never in a file in the repository | `just zenodo-draft` from your machine | the same token |
| `ZENODO_SANDBOX_TOKEN` (optional) | your shell | `just zenodo-sandbox`, a rehearsal | the same steps on sandbox.zenodo.org, a separate account |
| `ZENODO_CONCEPT_RECID` | GitHub → Settings → Secrets and variables → Actions → **Variables** (or `gh variable set ZENODO_CONCEPT_RECID --body <id>`); not a secret | makes later releases new versions of the same record | the number in the concept DOI, after the first publication |
| arXiv account, with an endorsement for `cs.CY` | arxiv.org | the arXiv submission | arxiv.org → Register; a first submission to a category needs an endorsement |

The `release` workflow also uses `GITHUB_TOKEN`, which GitHub gives every run; you do not set it.
**Never** commit a token, paste it in an issue or pull request, or put it in `.zenodo.json`. If a
token leaks, delete it on zenodo.org at once and make a new one.

Once per repository: on zenodo.org → GitHub, keep the switch for this repository **off**. The
Zenodo GitHub integration archives the source tree, not the PDF.

## Release: a new Zenodo record and a new arXiv PDF

A release is a Git tag on `main`. One command makes it; CI does the rest; a person publishes.

1. **Merge** the pull request. Check that the `pdf` and `citation` workflows pass on `main`.
2. **Rehearse** (optional): `just zenodo-dry-run 0.1.0` prints the Zenodo metadata, with no network.
   `just zenodo-sandbox 0.1.0` makes a draft on sandbox.zenodo.org.
3. **Tag**:

   ```sh
   git switch main && git pull
   just release 0.1.0 --dry-run   # shows the tag it will make
   just release 0.1.0             # tags v0.1.0 (signed if you set a signing key) and pushes it
   ```

4. **CI** (the `release` workflow) builds both PDFs and the arXiv bundle, makes the GitHub release
   with `pdf/*.pdf` and `build/arxiv/*` attached and, when `ZENODO_TOKEN` is set, uploads the
   PDFs, and nothing else, to a Zenodo **draft**.
   - With **no** `ZENODO_CONCEPT_RECID` variable, the draft is a **new Zenodo record**. Publishing
     it mints a new concept DOI (all versions) and a version DOI (this one).
   - With `ZENODO_CONCEPT_RECID` set, the draft is a **new version of that record**: a new version
     DOI under the same concept DOI.
   - Without `ZENODO_TOKEN`, use `just zenodo-draft 0.1.0` on your machine with the token in your
     shell. It does the same upload.
5. **Publish on Zenodo**: open the draft on zenodo.org (Uploads). Check the title, the three
   authors with their ORCIDs, the licence, and that the files are only the PDFs. Press
   **Publish**. **Caution:** a DOI is permanent, and you cannot delete a published record yourself.
6. **After the first publication only**: put the concept DOI in `scripts/citation.py`
   (`CONCEPT_DOI`), run `just citation`, and set the `ZENODO_CONCEPT_RECID` variable. Open a pull
   request with the result.
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

<!-- citation:start -->

BibTeX:

```bibtex
@misc{hoffmann_2026_closedsource,
  author    = {Hoffmann, Matheus},
  title     = {{Closed Source: The God that Failed}},
  year      = {2026},
  url       = {https://github.com/h0ffmann/closed-source}
}
```

APA:

> Hoffmann, M. (2026). *Closed Source: The God that Failed* [Preprint]. https://github.com/h0ffmann/closed-source

ABNT (NBR 6023):

> HOFFMANN, Matheus. **Closed Source**: The God that Failed. [S. l.]: GitHub, 2026. Disponível em: https://github.com/h0ffmann/closed-source.

<!-- citation:end -->

## Licence

- Paper text, docs and figures: [CC BY 4.0](LICENSE).
- Scripts, workflows, build files and the website (`scripts/`, `.github/`, `justfile`, `flake.nix`, `site/`): [AGPL-3.0-only](LICENSES/AGPL-3.0-only.txt).
- LaTeX template (`format/`), which other papers copy: [MIT](LICENSES/MIT.txt).
- Ouroboric's names and logos are not licensed here; see Ouroboric's
  [trademark policy](https://github.com/ouroboric-dev/ouroboric/blob/main/TRADEMARKS.md).

Each file's licence is recorded in [`REUSE.toml`](REUSE.toml).
