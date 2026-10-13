#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""cite_check — every Markdown file is cited (AGENTS.md hard rule).

Each git-tracked .md file carries one line, after its front matter or as its first line:

    <!-- cite: main="<persona>"; last="<persona>" -->

and both personas are rows of PERSONAS.md's table. GitHub and pandoc hide the line. A file copied
as is from another project cannot carry the line: the README.md beside it names it in its front
matter (`verbatim: [file.md, ...]`) and gives the citation instead.

    scripts/cite_check.py
    scripts/cite_check.py --self-test
"""

import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CITE_RE = re.compile(r'^<!-- cite: main="([^"]+)"; last="([^"]+)" -->$')
PERSONA_RE = re.compile(r"^\|\s*([^|]+?)\s*\|\s*(?:person|pen name|agent)\s*\|", re.M)


def personas(text: str) -> set[str]:
    return set(PERSONA_RE.findall(text))


def cite_line(text: str) -> str | None:
    lines = text.splitlines()
    i = 0
    if lines and lines[0] == "---":
        i = next((k + 1 for k in range(1, len(lines)) if lines[k] == "---"), len(lines))
    return lines[i] if i < len(lines) else None


def verbatim(readme: str) -> list[str]:
    m = re.search(r"^verbatim:\s*\[(.*?)\]\s*$", readme.split("\n---\n", 1)[0], re.M)
    return [f.strip() for f in m.group(1).split(",") if f.strip()] if m else []


def check(name: str, text: str, known: set[str]) -> list[str]:
    line = cite_line(text)
    m = CITE_RE.match(line or "")
    if not m:
        return [f"{name}: no cite line after the front matter (see PERSONAS.md)"]
    return [f"{name}: {role} author {p!r} is not in PERSONAS.md" for role, p in zip(("main", "last"), m.groups()) if p not in known]


def self_test() -> int:
    known = personas("| A | person | x | y |\n| B | agent | x | y |\n| Kind | x |")
    assert known == {"A", "B"}, known
    good = '<!-- cite: main="A"; last="B" -->\n# T\n'
    assert check("f", good, known) == []
    assert check("f", "---\nt: 1\n---\n" + good, known) == []
    assert check("f", "# T\n" + good, known)
    assert check("f", '<!-- cite: main="C"; last="B" -->\n', known) == ["f: main author 'C' is not in PERSONAS.md"]
    assert verbatim("---\ntitle: x\nverbatim: [a.md, b.md]\n---\n") == ["a.md", "b.md"]
    assert verbatim("---\ntitle: x\n---\nverbatim: [a.md]\n") == []
    print("cite_check: self-test passed", file=sys.stderr)
    return 0


def main() -> int:
    if sys.argv[1:] == ["--self-test"]:
        return self_test()
    known = personas((ROOT / "PERSONAS.md").read_text())
    files = subprocess.run(["git", "ls-files", "*.md"], cwd=ROOT, check=True, capture_output=True, text=True).stdout.split()
    skip = {str(Path(f).parent / v) for f in files if Path(f).name == "README.md" for v in verbatim((ROOT / f).read_text())}
    files = [f for f in files if f not in skip]
    errs = [e for f in files for e in check(f, (ROOT / f).read_text(), known)]
    for e in errs:
        print(f"cite_check: {e}", file=sys.stderr)
    if not errs:
        print(f"cite_check: {len(files)} Markdown files cited, {len(skip)} copied as is", file=sys.stderr)
    return 1 if errs else 0


if __name__ == "__main__":
    sys.exit(main())
