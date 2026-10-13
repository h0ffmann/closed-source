#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""content — write src/closed_source_site/content.gleam from the papers, so the site never
repeats a fact by hand. Runs in the paper toolchain (pandoc reads the YAML, pdfinfo counts pages).

    python3 site/content.py              # from the repository root, after `just build`
    python3 site/content.py --self-test
"""

from __future__ import annotations

import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "site" / "src" / "closed_source_site" / "content.gleam"
REPO = "https://github.com/h0ffmann/closed-source"


def meta(*files: Path) -> dict:
    """The merged YAML metadata of the files (later files win), as pandoc reads it."""
    with tempfile.NamedTemporaryFile("w", suffix=".tpl", delete=False) as t:
        t.write("$meta-json$")
    out = subprocess.run(
        ["pandoc", *map(str, files), f"--template={t.name}", "-t", "plain", "--wrap=none"],
        check=True, capture_output=True, text=True,
    ).stdout  # fmt: skip
    Path(t.name).unlink()
    return json.loads(out)


def sections(prose: Path) -> list[str]:
    titles = []
    for f in sorted(prose.glob("*.md")):
        for line in f.read_text().splitlines():
            m = re.match(r"^# (.+?)(\s*\{[^}]*\})?\s*$", line)
            if m and "unnumbered" not in (m.group(2) or ""):
                titles.append(m.group(1))
    return titles


def citations(readme: str) -> list[tuple[str, str]]:
    """(label, text) for each style in the README's generated citation block."""
    block = readme.split("<!-- citation:start -->")[1].split("<!-- citation:end -->")[0]
    out = []
    for label, body in re.findall(r"^(\w[\w ()0-9]*?):\n\n(.*?)(?=\n\n\w[\w ()0-9]*?:\n\n|\Z)", block.strip(), re.S | re.M):
        body = body.strip()
        body = re.sub(r"^```\w*\n|\n```$", "", body)
        body = "\n".join(l[2:] if l.startswith("> ") else l for l in body.splitlines())
        if not label.startswith("BibTeX"):
            body = re.sub(r"\*\*?([^*]+)\*\*?", r"\1", body)  # Markdown emphasis: plain text here
        out.append((label.strip(), body.strip()))
    return out


def thinkers(roster: str) -> list[tuple[int, str, str, str]]:
    """(number, thinker, why, status) for each row of 50THINKERS.md's table."""
    rows = re.findall(r"^\|\s*(\d+)\s*\|([^|]*)\|([^|]*)\|([^|]*)\|\s*$", roster, re.M)
    return [(int(n), t.strip(), w.strip(), st.strip()) for n, t, w, st in rows]


def notes(folder: Path) -> list[tuple[str, str, str, str]]:
    """(file stem, title, type, status) for each note in notes/, newest first."""
    out = []
    for f in sorted(folder.glob("*.md"), reverse=True):
        if f.name == "index.md":
            continue
        fm = f.read_text().split("\n---\n", 1)[0]
        get = lambda k: (re.search(rf"^{k}:\s*\"?(.*?)\"?\s*$", fm, re.M) or [None, ""])[1]
        out.append((f.stem, get("title"), get("type"), get("status")))
    return out


def pages(pdf: Path) -> int:
    if not pdf.exists():
        return 0
    info = subprocess.run(["pdfinfo", str(pdf)], capture_output=True, text=True).stdout
    m = re.search(r"^Pages:\s+(\d+)", info, re.M)
    return int(m.group(1)) if m else 0


def gleam_string(s: str) -> str:
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n") + '"'


def gleam_list(items: list[str]) -> str:
    return "[\n" + "".join(f"  {i},\n" for i in items) + "]"


def render(slug: str) -> str:
    paper = ROOT / "papers" / slug
    m = meta(paper / "metadata.md")
    ste = meta(paper / "metadata.md", paper / "prose-ste" / "00-metadata.md") if (paper / "prose-ste").is_dir() else m
    bib = (paper / "refs.bib").read_text()
    refs = len(re.findall(r"^@\w+\{", bib, re.M))
    log = (paper / "REFERENCES.md").read_text() if (paper / "REFERENCES.md").exists() else ""
    verified = len(re.findall(r"\|\s*verified\s*\|", log))
    def author(a: dict) -> str:
        return f"Author(name: {gleam_string(a['name'])}, orcid: {gleam_string(a.get('orcid', ''))}, affiliation: {gleam_string(a.get('affiliation', ''))})"

    authors = [author(a) for a in m["author"]]
    # `writer`: who wrote a paper whose cover carries a pen name; the cover's author otherwise.
    writer = author(m.get("writer") or m["author"][0])
    logos = [f"#({gleam_string(Path(l['file']).stem)}, {gleam_string(l['svg'])})" for l in m.get("logos", [])]
    cites = [f"#({gleam_string(l)}, {gleam_string(t)})" for l, t in citations((ROOT / "README.md").read_text())]
    keywords = [gleam_string(k) for k in m.get("keywords", [])]
    secs = [gleam_string(t) for t in sections(paper / "prose")]
    roster = thinkers((ROOT / "50THINKERS.md").read_text()) if (ROOT / "50THINKERS.md").exists() else []
    thinker_rows = [f"Thinker(n: {n}, name: {gleam_string(t)}, why: {gleam_string(w)}, status: {gleam_string(st)})" for n, t, w, st in roster]
    note_rows = [f"Note(file: {gleam_string(f)}, title: {gleam_string(t)}, kind: {gleam_string(k)}, status: {gleam_string(st)})" for f, t, k, st in notes(ROOT / "notes")]
    rev = subprocess.run(["git", "rev-parse", "--short", "HEAD"], capture_output=True, text=True, cwd=ROOT).stdout.strip()
    return f"""//// Generated by site/content.py from papers/{slug}/ and README.md; do not edit.

pub type Author {{
  Author(name: String, orcid: String, affiliation: String)
}}

pub type Thinker {{
  Thinker(n: Int, name: String, why: String, status: String)
}}

pub type Note {{
  Note(file: String, title: String, kind: String, status: String)
}}

pub const slug = {gleam_string(slug)}

pub const repo = {gleam_string(REPO)}

pub const revision = {gleam_string(rev or "unversioned")}

pub const title = {gleam_string(m["title"])}

pub const subtitle = {gleam_string(m.get("subtitle", ""))}

pub const version = {gleam_string(m.get("version", ""))}

pub const date = {gleam_string(m.get("date", ""))}

pub const abstract = {gleam_string(m["abstract"].strip())}

pub const abstract_ste = {gleam_string(ste["abstract"].strip())}

pub const pages = {pages(ROOT / "pdf" / f"{slug}.pdf")}

pub const pages_pt_br = {pages(ROOT / "pdf" / f"{slug}-pt-BR.pdf")}

pub const references = {refs}

pub const verified = {verified}

pub const authors = {gleam_list(authors)}

pub const writer = {writer}

pub const logos = {gleam_list(logos)}

pub const keywords = {gleam_list(keywords)}

pub const sections = {gleam_list(secs)}

pub const citations = {gleam_list(cites)}

pub const thinkers = {gleam_list(thinker_rows)}

pub const notes = {gleam_list(note_rows)}
"""


def self_test() -> int:
    assert gleam_string('a"b\\c\nd') == '"a\\"b\\\\c\\nd"'
    readme = "x\n<!-- citation:start -->\n\nBibTeX:\n\n```bibtex\n@misc{k,\n}\n```\n\nAPA:\n\n> A. (2026). *T*.\n\n<!-- citation:end -->\n"
    assert citations(readme) == [("BibTeX", "@misc{k,\n}"), ("APA", "A. (2026). T.")], citations(readme)
    roster = "| # | Thinker | Why | Status |\n|---:|---|---|---|\n| 1 | Linus Torvalds | Linux | proposed |\n| 2 | — | — | open |\n"
    assert thinkers(roster) == [(1, "Linus Torvalds", "Linux", "proposed"), (2, "—", "—", "open")], thinkers(roster)
    print("content: self-test ok")
    return 0


def main() -> int:
    if "--self-test" in sys.argv:
        return self_test()
    slug = "closed-source"
    OUT.write_text(render(slug))
    print(f"content: wrote {OUT.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
