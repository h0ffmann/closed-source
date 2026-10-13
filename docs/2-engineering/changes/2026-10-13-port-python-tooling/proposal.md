---
title: "Port the Python tooling to Go, V or Gleam"
status: proposed
date: 2026-10-13
related: [../README.md, ../../../../justfile, ../../../../flake.nix]
style: research
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Port the Python tooling to Go, V or Gleam

**Decided 2026-10-13:** option B (Go for everything), then paused the same minute: the owner asked
first whether all of the Python can be ported to Gleam (option E below). `delta.md` and `tasks.md`
follow the final choice.

## Why

The owner asked for options to move this repository's Python tooling to Go, with the Go patterns
of ouroboric-dev, and to V (vlang) where a script is only scripting (Hoffmann, 13 October 2026).

## What there is today

1,570 lines of Python in 12 files, plus `scripts/release.sh` (bash, kept as is: it matches
picasso's). 28 call sites in the justfile and `.github/workflows/` run them with `python3`, which
comes from picasso's `paper` lab.

| File | Lines | What it does | Kind |
|---|---:|---|---|
| `scripts/book_check.py` | 96 | 50 thinkers, 500 authors | check (text) |
| `scripts/cite_check.py` | 82 | cite line in every Markdown file | check (text, `git ls-files`) |
| `scripts/notes_check.py` | 85 | the slip box's front matter and links | check (text) |
| `scripts/refs_check.py` | 78 | every cited key is logged | check (text) |
| `scripts/ste_check.py` | 150 | STE and pt-BR texts keep citations, numbers, markers | check (text) |
| `scripts/citation.py` | 410 | `.zenodo.json` to `CITATION.cff` | tool (JSON, YAML out); copied from picasso, from marola-dev/marola |
| `scripts/zenodo_upload.py` | 129 | PDFs to a Zenodo draft | tool (HTTP API, token) |
| `scripts/arxiv.py` | 179 | arXiv source bundle and form fields | tool (tar, subprocess) |
| `scripts/logos.py` | 79 | fetch and convert the title-page logos | tool (HTTP, SHA-256, rsvg-convert) |
| `scripts/ouroboric.py` | 87 | fetch ouroboric-dev repositories, list changes | tool (git) |
| `site/content.py` | 195 | write `content.gleam` from the papers | generator |

Every file has a `--self-test`; `just self-test` runs them all.

## The Go patterns of ouroboric-dev

ouroboric-dev has no Go code published yet: Yggdrasil v0 is "in design". The patterns are in its
spec and plan (yggdrasil `ffedea7`, `docs/2-engineering/specs/2026-10-11-yggdrasil-v0-spec.md` and
`plans/2026-10-12-yggdrasil-v0/tasks.md`):

- one module per repository, `module github.com/<org>/<repo>`, `go 1.26`; several modules
  develop together through a `go.work` in the umbrella;
- `go test ./...` builds and tests, `go vet ./...` lints; the static rung adds `gofmt` and
  `golangci-lint`, and dependencies are gated on `govulncheck`;
- the standard library first: a reuse review flags "new dependencies or abstractions where the
  standard library or existing code already does the job";
- each task has a named test that fails before the change, and a size (S under 100 changed lines,
  M 100 to 400, L split).

nixpkgs at the time of writing has Go 1.26.8 and V 0.5.2. V has not reached 1.0, so its language
and standard library can change between releases.

## Options

### A. Go for the tools, V for the checks (as asked)

- **Go:** `citation`, `zenodo_upload`, `arxiv`, `logos`, `ouroboric`, `content` as subcommands of
  one binary, `cmd/fabric/`, with packages under `internal/`. Standard library only (`net/http`,
  `archive/tar`, `encoding/json`, `os/exec`); `CITATION.cff` is written as text, so no YAML
  dependency.
- **V:** the five checks as `v run scripts/<name>.v`, each one file with its `--self-test`.
- **Cost:** two new toolchains in the `paper` lab (a picasso PR), two test styles, two linters.
  V 0.x may break a check on a nixpkgs update, against the hard rule that `just paper` renders on
  any Ubuntu with Nix and just.
- **Effort:** 11 files, each S or M; about 12 PRs.

### B. Go for everything (recommended)

- The same `cmd/fabric/` binary, with the five checks as subcommands too (`fabric check book`,
  `fabric check cite`, ...).
- **Why:** one toolchain, one test style (`go test`, table tests in place of `--self-test`), one
  lint path (`gofmt`, `go vet`, `golangci-lint`, `govulncheck`), and a stable language for a book
  that must still render years from now. The checks are short in Go too.
- **Cost:** one new toolchain in the `paper` lab; Go needs more lines than Python for the same check.
- **Effort:** 11 files, each S or M; about 12 PRs, or 4 if grouped (checks, citation, release
  path, site).

### C. Port only the tools that hold a secret or a permanent action

- Go for `zenodo_upload` and `arxiv` (the token and the DOI path); everything else stays Python.
- **Cost:** two languages for a long time. **Effort:** 2 PRs.

### D. `content.py` in Gleam (with A, B or C)

- The site is already Gleam: generating `content.gleam` from Gleam drops one language from the site
  path. Gleam reads the papers through its own `simplifile`; this needs a check that it is pinned
  in `site/manifest.toml`.

## What changes outside this repository

- **picasso:** `labs/paper` (or a new lab) gets `go`, and for option A `vlang`, in its tools.
  This is a picasso PR under picasso's lab contract; `flake.lock` here then updates.
- **marola and picasso:** `scripts/citation.py` is copied from picasso's, itself copied from
  marola-dev/marola's. A Go port here stops being a copy; either the port goes upstream too or this repository
  keeps its own.
- **CI:** the 28 `python3` call sites become `go run ./cmd/fabric ...` or a built binary; the
  `just 1.21` rule is unaffected.

## E. Gleam for everything (checked on 13 October 2026)

**Yes: every line of the 1,570 can be written in Gleam.** No Python feature in these files lacks a
Gleam equivalent. The table lists each capability the scripts use and what replaces it. Package
versions are the latest on Hex on 13 October 2026.

| Python | Used in | Gleam |
|---|---|---|
| `pathlib` read, write, glob, mkdir | all | `simplifile` 2.7.0 (both targets) |
| `re` | all | `gleam_regexp` 1.1.1; see the regex notes below |
| `json` | citation, zenodo_upload, logos, arxiv, content | `gleam_json` 3.1.0 with `gleam/dynamic/decode` |
| `subprocess` (git, pandoc, pdfinfo, pdflatex, rsvg-convert) | cite_check, ouroboric, arxiv, logos, content | `shellout` 1.8.0; the same external programs as today |
| `urllib.request` (GET, POST, PUT, DELETE, bearer token, binary body) | zenodo_upload, logos | Erlang: `gleam_httpc` 5.0.0 with `gleam_http` 4.5.0, synchronous. JavaScript: `gleam_fetch` 1.4.1, asynchronous (promises) |
| `hashlib.sha256` | logos | `gleam_crypto` 1.6.0 (both targets) |
| `tarfile` (write and extract `.tar.gz`) | arxiv | Erlang: OTP's `erl_tar` through a one-line FFI. JavaScript: node has no tar, so run `tar` with `shellout` |
| `os.environ` | zenodo_upload | `envoy` 1.2.0 |
| `sys.argv`, `argparse` | all | `argv` 1.1.0 and a hand-written flag parser (the flags are few) |
| `sys.exit(code)` | all | `shellout`'s exit, or a one-line FFI |
| `tempfile` | arxiv, logos, refs_check, citation, content | a directory under `build/`, or `mktemp -d` through `shellout` |
| `html.unescape` | citation | a small function: `.zenodo.json` holds no HTML entity today (checked); full HTML5 parity would need the entity table |
| `collections.Counter` | ste_check | `gleam/dict` |
| `--self-test` | all | `gleeunit` tests (`gleam test`), as `site/` already does |

**Regex notes.** `gleam_regexp` exposes only the case-insensitive and multi-line flags.

- No dot-all flag: the three patterns that use `re.S` (refs_check, ste_check, content) write
  `[\s\S]` for `.`.
- `\Z` (content) works on Erlang; on JavaScript it becomes `$(?![\s\S])`.
- Lookbehind (ste_check) works on both targets.
- `\w` and `\b`: Erlang compiles with `unicode` and `ucp`, so they match accented letters as Python
  does. JavaScript's `\w` is ASCII only even with the `u` flag, so ste_check's number rule could
  read pt-BR text differently from Python. This is the one place where the targets differ in
  meaning, not only in code.

**Target.** Two choices, the same code otherwise:

- **Erlang (recommended for the tooling):** the same regex meaning as Python, synchronous HTTP,
  `erl_tar` built in. It needs Erlang/OTP in the toolchain: picasso's `gleam-website` lab has
  gleam, node, esbuild, just and python, not Erlang (checked in its flake.nix). That is a picasso
  PR, or `erlang` added to this repository's own devShell.
- **JavaScript (as `site/`):** no new toolchain, but asynchronous HTTP, `tar` from the system, and
  the `\w` difference above.

**What stays outside Gleam.** The five external programs the scripts already call (git, pandoc,
pdfinfo, pdflatex, rsvg-convert), and `scripts/release.sh`, which is bash, not Python, and matches
picasso's.

**A bonus.** `site/content.py` writes `content.gleam`; in Gleam it can live in `site/` itself.
