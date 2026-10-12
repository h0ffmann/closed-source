#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""refs_check — every reference a paper cites must have been fetched and logged.

For each papers/<slug>/refs.bib, the REFERENCES.md next to it must have one table row per BibTeX
key, with status verified or partial, and no row for a key that refs.bib lacks. Every entry must
carry a doi or url, so a reader can follow it. An `unverified` row fails the check: an agent that
could not fetch a source must not cite it (AGENTS.md).

    scripts/refs_check.py papers/*/refs.bib
    scripts/refs_check.py --self-test
"""

from __future__ import annotations

import re
import sys
import tempfile
from pathlib import Path

ENTRY_RE = re.compile(r"@(\w+)\s*\{\s*([^,\s]+)\s*,(.*?)\n\}", re.S)
ROW_RE = re.compile(r"^\|\s*([A-Za-z0-9_:-]+)\s*\|\s*(verified|partial|unverified)\s*\|", re.M)
OK = {"verified", "partial"}


def entries(bib: str) -> dict[str, str]:
    return {key: body for kind, key, body in ENTRY_RE.findall(bib) if kind.lower() != "comment"}


def check(bib_path: Path) -> list[str]:
    log = bib_path.with_name("REFERENCES.md")
    errs: list[str] = []
    bib = entries(bib_path.read_text())
    if not log.exists():
        return [f"{bib_path}: no REFERENCES.md next to it"]
    rows = dict(ROW_RE.findall(log.read_text()))
    for key, body in bib.items():
        if key not in rows:
            errs.append(f"{bib_path}: {key} has no row in REFERENCES.md")
        elif rows[key] not in OK:
            errs.append(f"{bib_path}: {key} is {rows[key]}; fetch and check it, or remove it")
        if not re.search(r"^\s*(doi|url)\s*=", body, re.M):
            errs.append(f"{bib_path}: {key} has neither doi nor url")
    errs += [f"{log}: row {k} is not in refs.bib" for k in rows if k not in bib]
    return errs


def self_test() -> int:
    with tempfile.TemporaryDirectory() as d:
        bib, log = Path(d, "refs.bib"), Path(d, "REFERENCES.md")
        bib.write_text("@misc{a,\n  url = {https://x}\n}\n@misc{b,\n  title = {t}\n}\n")
        log.write_text("| Key | Status |\n|---|---|\n| a | verified | x |\n| c | partial | y |\n")
        errs = check(bib)
        assert any("b has no row" in e for e in errs), errs
        assert any("b has neither doi nor url" in e for e in errs), errs
        assert any("row c is not in refs.bib" in e for e in errs), errs
        log.write_text("| a | unverified | x |\n")
        assert any("a is unverified" in e for e in check(bib))
    print("refs_check: self-test ok", file=sys.stderr)
    return 0


def main(argv: list[str]) -> int:
    if argv == ["--self-test"]:
        return self_test()
    if not argv:
        print(__doc__, file=sys.stderr)
        return 2
    errs = [e for p in argv for e in check(Path(p))]
    for e in errs:
        print(f"refs_check: {e}", file=sys.stderr)
    if not errs:
        print(f"refs_check: {len(argv)} bibliography file(s) ok", file=sys.stderr)
    return 1 if errs else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
