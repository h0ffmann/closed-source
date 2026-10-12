#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""book_check — the book's hard rule (AGENTS.md): 50 thinkers, two pages each, 100 pages.

Checks papers/<slug>/THINKERS.md: rows numbered 1 to 50 in order, no thinker named twice, and a
known status. Open rows (thinker "—") are allowed while the roster is a draft; the script says how
many are left.

    scripts/book_check.py closed-source
    scripts/book_check.py --self-test
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
THINKERS = 50
STATUSES = {"open", "proposed", "chosen", "written"}
ROW_RE = re.compile(r"^\|\s*(\d+)\s*\|\s*([^|]*?)\s*\|\s*([^|]*?)\s*\|\s*([^|]*?)\s*\|\s*$")


def check(text: str) -> tuple[list[str], int]:
    rows = [m.groups() for m in map(ROW_RE.match, text.splitlines()) if m]
    errs = []
    if [int(r[0]) for r in rows] != list(range(1, THINKERS + 1)):
        errs.append(f"the table must have rows numbered 1 to {THINKERS} in order; it has {len(rows)} rows")
    names = [r[1] for r in rows if r[1] not in ("—", "-", "")]
    errs += [f"{n} is named twice" for n in sorted({n for n in names if names.count(n) > 1})]
    errs += [f"row {r[0]}: status {r[3]!r} is not one of {sorted(STATUSES)}" for r in rows if r[3] not in STATUSES]
    return errs, THINKERS - len(names)


def self_test() -> int:
    table = "\n".join(f"| {i} | T{i} | why | proposed |" for i in range(1, 51))
    assert check(table) == ([], 0)
    assert check(table.replace("| T2 |", "| T1 |"))[0] == ["T1 is named twice"]
    assert check(table.replace("| 50 | T50 | why | proposed |", ""))[0]
    assert check(table.replace("| T3 |", "| — |")) == ([], 1)
    print("book_check: self-test passed", file=sys.stderr)
    return 0


def main() -> int:
    if sys.argv[1:] == ["--self-test"]:
        return self_test()
    bad = 0
    for slug in sys.argv[1:]:
        path = ROOT / "papers" / slug / "THINKERS.md"
        if not path.exists():
            continue
        errs, left = check(path.read_text())
        for e in errs:
            print(f"book_check: {path.relative_to(ROOT)}: {e}", file=sys.stderr)
        bad += len(errs)
        if not errs:
            print(f"book_check: {slug}: {THINKERS} rows, {left} still open", file=sys.stderr)
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
