# Paper Fabric. `just` builds every paper; `just --list` shows the recipes.
# Markdown prose -> pandoc (pandoc-crossref, citeproc, BibTeX) -> LaTeX -> XeLaTeX, after Sandy
# Maguire's book builds (isovector/thinking-with-types). The tools come from picasso's paper lab:
# `nix develop` (flake.nix) or `just shell`. Runs with the just 1.21 of Ubuntu 24.04.
#
# A paper is papers/<slug>/ with metadata.md, prose/NN-*.md and refs.bib. A paper with a
# prose-ste/ directory (its ASD-STE100 text) also builds pdf/<slug>-ste.pdf, and one with a
# prose-pt-BR/ directory (the printed Brazilian Portuguese edition) builds pdf/<slug>-pt-BR.pdf; the
# 00-metadata.md in either directory overrides metadata.md keys such as the abstract and the language.
set shell := ["bash", "-euo", "pipefail", "-c"]
set positional-arguments

pandoc_opts := "--from markdown+fancy_lists+raw_tex -F pandoc-crossref --citeproc --metadata link-citations=true --number-sections --top-level-division=section --fail-if-warnings -s --template format/tex/template.tex -t latex --metadata-file format/crossref.yaml"

# Build every paper, or the papers named: pdf/<slug>.pdf (and pdf/<slug>-ste.pdf, pdf/<slug>-pt-BR.pdf).
build *slugs:
    #!/usr/bin/env bash
    set -euo pipefail
    slugs="{{slugs}}"
    [ -n "$slugs" ] || slugs="$(ls papers)"
    mkdir -p build/tex pdf
    # The revision stamped on every page: short hash + commit count.
    printf '%s+%s' "$(git rev-parse --short HEAD)" "$(git rev-list --count HEAD)" > build/.current-revision
    for p in $slugs; do
      [ -d "papers/$p" ] || { echo "build: no paper papers/$p" >&2; exit 1; }
      python3 scripts/logos.py "$p"
      just _pdf "$p" prose "$p"
      if [ -d "papers/$p/prose-ste" ]; then just _pdf "$p" prose-ste "$p-ste"; fi
      if [ -d "papers/$p/prose-pt-BR" ]; then just _pdf "$p" prose-pt-BR "$p-pt-BR"; fi
    done

# One PDF: papers/<slug>/<dir>/*.md -> build/tex/<out>.tex -> pdf/<out>.pdf (XeLaTeX twice).
_pdf slug dir out:
    pandoc {{pandoc_opts}} --bibliography papers/{{slug}}/refs.bib -o build/tex/{{out}}.tex \
      papers/{{slug}}/metadata.md papers/{{slug}}/{{dir}}/*.md
    cd build && for _ in 1 2; do \
      xelatex -interaction=nonstopmode -halt-on-error tex/{{out}}.tex > /dev/null \
        || { tail -n 30 {{out}}.log >&2; exit 1; }; \
    done
    cp build/{{out}}.pdf pdf/{{out}}.pdf
    @echo "build: pdf/{{out}}.pdf"

# Build, then check the reference logs and that each STE text and translation keeps its citations
# and numbers.
check: build
    python3 scripts/refs_check.py papers/*/refs.bib
    for p in papers/*/prose-ste; do p="${p#papers/}"; python3 scripts/ste_check.py "${p%/prose-ste}"; done
    for p in papers/*/prose-pt-BR; do p="${p#papers/}"; python3 scripts/ste_check.py --translation "${p%/prose-pt-BR}"; done
    python3 scripts/book_check.py
    python3 scripts/cite_check.py
    python3 scripts/notes_check.py

# Build, then write the arXiv source bundles (checked with pdfLaTeX) to build/arxiv/.
arxiv: build
    for p in $(ls papers); do python3 scripts/arxiv.py "$p"; done

# Every script's --self-test (what CI runs before the build).
self-test:
    python3 scripts/refs_check.py --self-test
    python3 scripts/arxiv.py --self-test
    python3 scripts/zenodo_upload.py --self-test
    python3 scripts/logos.py --self-test
    python3 scripts/book_check.py --self-test
    python3 scripts/ouroboric.py --self-test
    python3 scripts/cite_check.py --self-test
    python3 scripts/notes_check.py --self-test
    scripts/release.sh --self-test

# Fetch the public ouroboric-dev repositories into build/ouroboric/ and list what changed since
# OUROBORIC.md recorded them. `/update-ouroboric` (a Claude Code command) then updates the digests.
ouroboric-sources:
    python3 scripts/ouroboric.py

# Regenerate CITATION.cff and the README citation block from .zenodo.json.
citation:
    python3 scripts/citation.py

# Remove every build output.
clean:
    rm -rf build pdf site/build site/dist

# Enter the toolchain: pandoc, pandoc-crossref, XeLaTeX, pdfLaTeX, python, just, gh (Nix).
shell:
    nix develop

# Tag main and publish: `just release` lists what is unreleased and suggests a bump, then
# `just release minor|patch|major|X.Y.Z [--dry-run]` (scripts/release.sh, as in picasso).
release *args:
    scripts/release.sh {{args}}

# The release tags, newest first.
releases:
    git fetch -q --tags origin && git tag -l 'v*' --sort=-v:refname --format='%(refname:short)  %(creatordate:short)  %(subject)'

# Upload pdf/*.pdf from this machine to a Zenodo draft (needs ZENODO_TOKEN; CI does this on a tag).
zenodo-draft version: check
    @[ -n "${ZENODO_TOKEN:-}" ] || { echo "zenodo-draft: export ZENODO_TOKEN first (README, Secrets)" >&2; exit 1; }
    python3 scripts/zenodo_upload.py pdf/*.pdf --version {{version}} \
      ${ZENODO_CONCEPT_RECID:+--concept-recid "$ZENODO_CONCEPT_RECID"}

# The same against sandbox.zenodo.org, to rehearse (needs ZENODO_SANDBOX_TOKEN).
zenodo-sandbox version: check
    @[ -n "${ZENODO_SANDBOX_TOKEN:-}" ] || { echo "zenodo-sandbox: export ZENODO_SANDBOX_TOKEN first (README, Secrets)" >&2; exit 1; }
    ZENODO_URL=https://sandbox.zenodo.org ZENODO_TOKEN="$ZENODO_SANDBOX_TOKEN" \
      python3 scripts/zenodo_upload.py pdf/*.pdf --version {{version}}

# What a Zenodo draft would contain, with no network and no token.
zenodo-dry-run version: build
    python3 scripts/zenodo_upload.py pdf/*.pdf --version {{version}} --dry-run

# Build the website into site/dist/: the PDFs, the site's content from the papers, then the Gleam
# app. Needs only Nix and just: each half runs in its own toolchain from picasso's labs.
site-build:
    nix develop --no-update-lock-file --command just build
    nix develop --no-update-lock-file --command python3 site/content.py
    nix develop --no-update-lock-file .#site --command bash -c 'cd site && just ci'

# On any Ubuntu with only Nix and `apt install just`: render the paper's PDFs in picasso's paper lab.
paper:
    nix develop --extra-experimental-features 'nix-command flakes' --no-update-lock-file --command just build

# The same for the book: its PDFs, then its hard-rule checks (roster, cite lines, references, STE).
book:
    nix develop --extra-experimental-features 'nix-command flakes' --no-update-lock-file --command just check

# Build the website and serve it on http://localhost:8000
site-serve: site-build
    nix develop --no-update-lock-file .#site --command python3 -m http.server -d site/dist 8000

# The code graph of this repository with picasso's viz lab (graphify: code only, no key, no model),
# from the forks/picasso submodule: `just viz` builds it and prints the path of graph.html, then
# `just viz query "<q>"`, `just viz path <a> <b>`, `just viz explain <x>`. MEMORY.md has the rules.
viz *args:
    #!/usr/bin/env bash
    set -euo pipefail
    lab=forks/picasso/labs/viz
    [ -f "$lab/flake.nix" ] || git submodule update --init --depth 1 forks/picasso
    nix --extra-experimental-features 'nix-command flakes' run "path:$PWD/$lab" -- "$@"
