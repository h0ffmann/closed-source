#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""arxiv — package a paper's LaTeX source for arXiv and write its submission metadata.

arXiv compiles submitted TeX itself, with pdfLaTeX, and refuses PDFs that were produced from TeX.
So this script takes the .tex that `just build` generates (citations already rendered by citeproc, so no
.bbl is needed), freezes the Git revision into it, checks that it compiles with pdfLaTeX in a
clean directory holding only the bundle, and writes:

    build/arxiv/<slug>.tar.gz     the upload: <slug>.tex and the title-page logos, nothing else
    build/arxiv/<slug>.txt        the form fields: title, authors, abstract, comments, categories, licence

Submitting stays a human step on arxiv.org (endorsement, licence choice and the final preview are
the submitter's). Metadata comes from the paper's metadata.md, `arxiv:` block included.

    scripts/arxiv.py closed-source           # needs build/tex/closed-source.tex (just build closed-source)
    scripts/arxiv.py closed-source --no-compile
    scripts/arxiv.py --self-test
"""

from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
import tarfile
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
# arXiv's documented limits and category scheme (arxiv.org/help/prep, checked 2026-10-12).
ABSTRACT_MAX = 1920
TITLE_MAX = 240
CATEGORY_RE = re.compile(r"^[a-z-]+(\.[A-Za-z-]+)?$")
REVISION_RE = re.compile(r"\\newcommand\{\\revision\}\{.*\}")


def metadata(slug: str) -> dict:
    tpl = Path(tempfile.mkdtemp()) / "meta.tpl"
    tpl.write_text("$meta-json$")
    out = subprocess.run(
        ["pandoc", str(ROOT / "papers" / slug / "metadata.md"), "--template", str(tpl), "-t", "plain"],
        check=True, capture_output=True, text=True,
    ).stdout  # fmt: skip
    shutil.rmtree(tpl.parent)
    return json.loads(out)


def form_fields(meta: dict) -> tuple[str, list[str]]:
    ax = meta.get("arxiv", {})
    errs = []
    title = meta.get("title", "")
    abstract = " ".join(meta.get("abstract", "").split())
    if not title or len(title) > TITLE_MAX:
        errs.append(f"title must be 1..{TITLE_MAX} characters")
    if not abstract or len(abstract) > ABSTRACT_MAX:
        errs.append(f"abstract is {len(abstract)} characters; arXiv allows {ABSTRACT_MAX}")
    cats = [ax.get("primary", "")] + list(ax.get("cross-list", []))
    errs += [f"category {c!r} is not an arXiv category id" for c in cats if not CATEGORY_RE.match(c)]
    if not ax.get("license"):
        errs.append("arxiv.license is missing")
    # The cover may carry a pen name (`author`); arXiv gets the writer's name when one is given.
    people = [meta["writer"]] if meta.get("writer") else meta.get("author", [])
    authors = ", ".join(a["name"] for a in people)
    text = "\n".join(
        [
            f"Title: {title}",
            f"Authors: {authors}",
            f"Primary category: {ax.get('primary', '')}",
            f"Cross-lists: {' '.join(ax.get('cross-list', []))}",
            f"Licence: {ax.get('license', '')}",
            f"Comments: {ax.get('comments', '')}",
            "",
            "Abstract:",
            abstract,
            "",
        ]
    )
    return text, errs


def freeze_revision(tex: str, revision: str) -> str:
    if not REVISION_RE.search(tex):
        raise ValueError("no \\newcommand{\\revision}{...} line in the generated .tex")
    return REVISION_RE.sub(lambda _: f"\\newcommand{{\\revision}}{{{revision}}}", tex, count=1)


def revision() -> str:
    def git(*a: str) -> str:
        return subprocess.run(["git", *a], cwd=ROOT, check=True, capture_output=True, text=True).stdout.strip()

    return f"{git('rev-parse', '--short', 'HEAD')}+{git('rev-list', '--count', 'HEAD')}"


def compile_check(tarball: Path, slug: str) -> None:
    with tempfile.TemporaryDirectory() as d:
        with tarfile.open(tarball) as tf:
            tf.extractall(d, filter="data")
        for _ in range(2):
            r = subprocess.run(
                ["pdflatex", "-interaction=nonstopmode", "-halt-on-error", f"{slug}.tex"],
                cwd=d, capture_output=True, text=True,
            )  # fmt: skip
            if r.returncode:
                tail = "\n".join(r.stdout.splitlines()[-15:])
                raise RuntimeError(f"pdflatex failed on the arXiv bundle:\n{tail}")
        log = Path(d, f"{slug}.log").read_text(errors="replace")
        if "Missing character" in log:
            raise RuntimeError("pdflatex dropped characters (Missing character in the log)")


def package(slug: str, compile_: bool) -> int:
    src = ROOT / "build" / "tex" / f"{slug}.tex"
    if not src.exists():
        print(f"arxiv: {src.relative_to(ROOT)} is missing; run `just build {slug}` first", file=sys.stderr)
        return 1
    text, errs = form_fields(metadata(slug))
    if errs:
        print("arxiv: metadata.md is not ready for arXiv:", *errs, sep="\n  ", file=sys.stderr)
        return 1
    out = ROOT / "build" / "arxiv"
    out.mkdir(parents=True, exist_ok=True)
    stage = Path(tempfile.mkdtemp())
    (stage / f"{slug}.tex").write_text(freeze_revision(src.read_text(), revision()))
    tarball = out / f"{slug}.tar.gz"
    with tarfile.open(tarball, "w:gz") as tf:
        tf.add(stage / f"{slug}.tex", arcname=f"{slug}.tex")
        for logo in metadata(slug).get("logos", []):  # scripts/logos.py wrote them for the build
            tf.add(ROOT / "build" / logo["file"], arcname=logo["file"])
    shutil.rmtree(stage)
    (out / f"{slug}.txt").write_text(text)
    if compile_:
        compile_check(tarball, slug)
    print(f"arxiv: wrote {tarball.relative_to(ROOT)} and {slug}.txt"
          f"{' (pdfLaTeX check passed)' if compile_ else ''}", file=sys.stderr)  # fmt: skip
    return 0


def self_test() -> int:
    good = {
        "title": "t",
        "abstract": "a  b\nc",
        "author": [{"name": "A B"}, {"name": "C D"}],
        "arxiv": {"primary": "cs.CY", "cross-list": ["cs.SE"], "license": "x", "comments": "c"},
    }
    text, errs = form_fields(good)
    assert errs == [] and "Authors: A B, C D" in text and "\na b c\n" in text, (text, errs)
    bad = dict(good, abstract="x" * (ABSTRACT_MAX + 1), arxiv={"primary": "CS CY"})
    _, errs = form_fields(bad)
    assert len(errs) == 3, errs
    tex = "a\n\\newcommand{\\revision}{\\IfFileExists{.current-revision}{x}{y}}\nb"
    assert "\\newcommand{\\revision}{abc+3}" in freeze_revision(tex, "abc+3")
    try:
        freeze_revision("no macro", "x")
        raise AssertionError("missing macro accepted")
    except ValueError:
        pass
    print("arxiv: self-test ok", file=sys.stderr)
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawTextHelpFormatter)
    ap.add_argument("slug", nargs="?")
    ap.add_argument("--no-compile", action="store_true")
    ap.add_argument("--self-test", action="store_true")
    args = ap.parse_args()
    if args.self_test:
        return self_test()
    if not args.slug:
        ap.error("name a paper, e.g. closed-source")
    return package(args.slug, not args.no_compile)


if __name__ == "__main__":
    sys.exit(main())
