<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
<div align="center">

<img alt="the site's icon: an open letter c with a dot, on a dark square" src="site/static/icons/favicon.svg" width="96"/>

# closed source: the god that failed

<sub>since 2026 · <a href="https://h0ffmann.github.io/closed-source/paper.pdf">read the paper (PDF)</a> · <a href="https://h0ffmann.github.io/closed-source/">the site</a> · <a href="#build-it">build</a> · <a href="#release-it">release</a> · <a href="#cite">cite</a> · <a href="#licence">licence</a> · <a href="README.easy.pt-BR.md">🇧🇷 versão fácil</a></sub>

[![h0ffmann/closed-source on github: star the repository](https://img.shields.io/github/stars/h0ffmann/closed-source?style=for-the-badge&logo=github&logoColor=white&label=h0ffmann%2Fclosed-source&labelColor=111111&color=A3201C)](https://github.com/h0ffmann/closed-source)

[![release](https://img.shields.io/github/v/tag/h0ffmann/closed-source?sort=semver&filter=v*&label=release&style=flat-square&color=A3201C)](#release-it)
[![pdf](https://github.com/h0ffmann/closed-source/actions/workflows/pdf.yml/badge.svg)](https://github.com/h0ffmann/closed-source/actions/workflows/pdf.yml)
[![site](https://github.com/h0ffmann/closed-source/actions/workflows/site.yml/badge.svg)](https://github.com/h0ffmann/closed-source/actions/workflows/site.yml)
[![.md quality](https://img.shields.io/github/actions/workflow/status/h0ffmann/closed-source/md.yml?branch=main&label=.md%20quality&style=flat-square)](docs/4-ways-of-working/md-quality.md)
[![live links: green when 100% of the links of the website and the markdown files answer](https://img.shields.io/github/actions/workflow/status/h0ffmann/closed-source/links.yml?branch=main&label=live%20links&style=flat-square)](https://github.com/h0ffmann/closed-source/actions/workflows/links.yml)
[![github links](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fh0ffmann.github.io%2Fclosed-source%2Flinks.json&query=%24.github&label=github%20links&style=flat-square&color=111111)](docs/4-ways-of-working/md-quality.md#the-link-counters)
[![zenodo links](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fh0ffmann.github.io%2Fclosed-source%2Flinks.json&query=%24.zenodo&label=zenodo%20links&style=flat-square&color=1682D4)](docs/4-ways-of-working/md-quality.md#the-link-counters)
[![latest DOI](https://img.shields.io/badge/latest_DOI-10.5281%2Fzenodo.23333656-1682D4?style=flat-square)](https://doi.org/10.5281/zenodo.23333656)
[![v0.4.0 DOI](https://img.shields.io/badge/v0.4.0_DOI-10.5281%2Fzenodo.24182034-555555?style=flat-square)](https://doi.org/10.5281/zenodo.24182034)
[![versão fácil em português: click to read this page in easy brazilian portuguese](https://img.shields.io/badge/%F0%9F%87%A7%F0%9F%87%B7_vers%C3%A3o_f%C3%A1cil-em_portugu%C3%AAs-FFD400?style=flat-square&labelColor=111111)](README.easy.pt-BR.md)
[![text: CC BY 4.0](https://img.shields.io/badge/text-CC%20BY%204.0-111111?style=flat-square&logo=creativecommons&logoColor=white)](#licence)
[![code: AGPL-3.0](https://img.shields.io/badge/code-AGPL--3.0-111111?style=flat-square&logo=gnu&logoColor=white)](#licence)

a book that says hiding your code no longer keeps science safe. so share how you work, give it a
name that never changes, and say who helped you. it is made with **paper fabric**: markdown in,
PDF out, every reference checked.

**read it:** [in the browser](https://h0ffmann.github.io/closed-source/paper.pdf) ·
[the PDF](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source.pdf) ·
[in simplified technical english](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source-ste.pdf) ·
[em português](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source-pt-BR.pdf)

</div>

## the idea, in five lines

1. you build a toy and hide how it works.
2. since 2024, AI agents can take programs apart and copy models. hiding no longer protects the toy.
3. so show how you made it, give it a DOI (a name that never changes), and cite what you used.
4. the book stands on robert m. pirsig's *zen and the art of motorcycle maintenance* (1974): science
   never closes, so a method only its owner can open is one nobody else can test
   ([the note](notes/202610181353-pirsig-infinite-hypotheses-science-does-not-close.md)).
5. 66 pages: 33 thinkers, two pages each ([`33THINKERS.md`](33THINKERS.md)), in english and in
   brazilian portuguese.

the writer is matheus hoffmann, of the escola politécnica of UFRJ. the idea of a self-improving
factory is bruno valério's. the partners are [piabrota](https://github.com/piabrota) and
[marola-dev](https://github.com/marola-dev).

**status:** v0.4.0 is live ([releases](RELEASES.md)). it is a book on zenodo; it is not peer reviewed.

## build it

on any ubuntu, you need only nix and just:

```sh
curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon        # Nix, once; then open a new shell
echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf   # flakes on, once
sudo apt install just                                               # just 1.21 on 24.04
just paper     # the PDFs -> pdf/
just book      # the PDFs and the book's checks
```

more: [building](docs/4-ways-of-working/building.md) (the toolchain, the three editions, the site, the layout).

## release it

a release is a git tag on `main`. `just release` makes it, CI publishes it, zenodo gives it a DOI.
a DOI is permanent, so humans release; agents only prepare the pull request. the steps and the
keys: [releasing](docs/4-ways-of-working/releasing.md).

## cite

cite the latest DOI. add the version's DOI when the exact words matter.

| | latest DOI (always the newest release) | permanent DOI (one release, forever) |
|---|---|---|
| this work | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) | v0.4.0: [10.5281/zenodo.24182034](https://doi.org/10.5281/zenodo.24182034); earlier versions: [`RELEASES.md`](RELEASES.md) |

<!-- citation:start -->

BibTeX:

```bibtex
@book{hoffmann_2026_closedsource,
  author    = {Hoffmann, Matheus},
  title     = {{Closed Source: The God that Failed}},
  year      = {2026},
  publisher = {Zenodo},
  doi       = {10.5281/zenodo.23333656},
  url       = {https://github.com/h0ffmann/closed-source}
}
```

APA:

> Hoffmann, M. (2026). *Closed Source: The God that Failed* [Book]. Zenodo. https://doi.org/10.5281/zenodo.23333656

ABNT (NBR 6023):

> HOFFMANN, Matheus. **Closed Source**: The God that Failed. [S. l.]: Zenodo, 2026. DOI 10.5281/zenodo.23333656.

<!-- citation:end -->

## learn more

| if you want | go to |
|---|---|
| the book's story, its big references, its licence research and how readers find it | [the book](docs/1-product/the-book.md) |
| the books behind it | [`BOOKS.md`](BOOKS.md) |
| the writer's other open works | [`WORKS.md`](WORKS.md) |
| the notes and the essays | [`notes/`](notes/index.md), [`essays/`](essays/index.md) |
| to work here with a coding agent | [`AGENTS.md`](AGENTS.md) |
| this page in easy brazilian portuguese | [`README.easy.pt-BR.md`](README.easy.pt-BR.md) |

## licence

- paper text, docs and figures: [CC BY 4.0](LICENSE).
- scripts, workflows, build files and the website (`scripts/`, `.github/`, `justfile`, `flake.nix`, `site/`): [AGPL-3.0-only](LICENSES/AGPL-3.0-only.txt).
- latex template (`format/`), which other papers copy: [MIT](LICENSES/MIT.txt).
- the website's footer shows gleam's lucy ([gleam-lang/branding](https://github.com/gleam-lang/branding)) and
  the claude code icon. both load from their owners' sites, and neither is licensed here.

each file's licence is recorded in [`REUSE.toml`](REUSE.toml).
