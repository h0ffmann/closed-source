# Closed Source: The God that Failed

The first paper made with **Paper Fabric**, an open, self-improving pipeline for technical papers
in the [Ouroboric](https://github.com/ouroboric-dev/ouroboric) style. Markdown in, PDF out, every
reference checked, every release citable.

> Closed source asked researchers to trust that secrecy would protect their work. Between 2024 and
> 2026 that trust failed in public. If anyone can reverse engineer anything, the honest course is
> to publish the method, mint an identifier, and cite whatever you use, and to require the same
> of the agents that now do much of the reading and writing.

**Authors:** Rob Kler Soares da Silva Junior, Bruno Valério, Matheus Hoffmann (Ouroboric DEV).
**Status:** v0 preprint, not peer reviewed. See the [readiness assessment](docs/1-product/readiness/2026-10-12-ready-to-promote.md)
for what must change before v1 and before this repository moves to the `ouroboric-dev`
organisation.

## Build the PDF

```sh
scripts/setup-toolchain.sh   # pandoc 3.1.3, pandoc-crossref 0.3.16.0, XeLaTeX (Debian/Ubuntu)
make                         # every paper -> pdf/<slug>.pdf
make check                   # the same, plus the reference-log check
make arxiv                   # arXiv source bundles, checked with pdfLaTeX, in build/arxiv/
```

The toolchain follows Sandy Maguire's books ([isovector/thinking-with-types](https://github.com/isovector/thinking-with-types)):
Markdown prose, pandoc with pandoc-crossref and citeproc, a hand-written LaTeX template, XeLaTeX,
and the Git revision stamped on every page.

## Layout

| Path | What's there |
|---|---|
| [`papers/closed-source/`](papers/closed-source/) | the paper: `metadata.md`, `prose/NN-*.md`, `refs.bib`, and the reference log `REFERENCES.md` |
| [`format/`](format/) | the LaTeX template and pandoc-crossref settings shared by every paper |
| [`scripts/`](scripts/) | toolchain setup, reference check, citation metadata, release and Zenodo upload |
| [`docs/`](docs/README.md) | Paper Fabric's charter, ways of working, journal and readiness |
| [`.claude/`](.claude/README.md) | the exported Claude project configuration that produced this repository |
| [`AGENTS.md`](AGENTS.md) | the rules every agent follows here, including borrow, cite, propagate |

## Release and Zenodo

A release is a tag on `main` (`scripts/release.sh 0.1.0`). The release workflow builds the PDF,
attaches it to a GitHub release and, when the `ZENODO_TOKEN` secret is set, uploads **only the
PDF** to a Zenodo draft. A person publishes the draft on zenodo.org, which mints the DOI. See
[releasing](docs/4-ways-of-working/releasing.md).

arXiv gets the LaTeX source instead (`make arxiv`): a single `.tex` with citations rendered,
checked with pdfLaTeX, plus the form fields. Submission is manual, and arXiv's CS category
expects position papers to be peer reviewed first; see the same page.

## Cite

<!-- citation:start -->

BibTeX:

```bibtex
@misc{soaresdasilvajunior_2026_closedsource,
  author    = {Soares da Silva Junior, Rob Kler and Valério, Bruno and Hoffmann, Matheus},
  title     = {{Closed Source: The God that Failed}},
  year      = {2026},
  url       = {https://github.com/h0ffmann/closed-source}
}
```

APA:

> Soares da Silva Junior, R. K., Valério, B., & Hoffmann, M. (2026). *Closed Source: The God that Failed* [Preprint]. https://github.com/h0ffmann/closed-source

ABNT (NBR 6023):

> SOARES DA SILVA JUNIOR, Rob Kler; VALÉRIO, Bruno; HOFFMANN, Matheus. **Closed Source**: The God that Failed. [S. l.]: GitHub, 2026. Disponível em: https://github.com/h0ffmann/closed-source.

<!-- citation:end -->

## Licence

- Paper text, docs and figures: [CC BY 4.0](LICENSE).
- Scripts and workflows (`scripts/`, `.github/`, `Makefile`s): [AGPL-3.0-only](LICENSES/AGPL-3.0-only.txt).
- LaTeX template (`format/`), which other papers copy: [MIT](LICENSES/MIT.txt).
- Ouroboric's names and logos are not licensed here; see Ouroboric's
  [trademark policy](https://github.com/ouroboric-dev/ouroboric/blob/main/TRADEMARKS.md).

Each file's licence is recorded in [`REUSE.toml`](REUSE.toml).
