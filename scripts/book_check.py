#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""book_check — the book's hard rule (AGENTS.md): 50 thinkers, two pages each, 100 pages.

Checks 50THINKERS.md (columns # | Thinker | Area | Why | Cited | Status): rows numbered 1 to 50 in
order, no thinker named twice, a known status, and Cited is ☑ or ☐ on a named row. The order of the
names is shuffled on purpose (an essay, not a ranking), so the script does not check it. Open rows
(thinker "—") are allowed while the roster is a draft; the script says how many are left.
Checks 500AUTHORS.md, the long list the thinkers come from: at most 500 rows numbered from 1 in
order, no author named twice, and every named thinker listed.

    scripts/book_check.py
    scripts/book_check.py --self-test
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
THINKERS = 50
AUTHORS = 500
STATUSES = {"open", "proposed", "chosen", "written"}
ROW_RE = re.compile(r"^\|\s*(\d+)\s*\|\s*([^|]*?)\s*\|\s*([^|]*?)\s*\|\s*([^|]*?)\s*\|\s*$")
THINKER_RE = re.compile(r"^\|\s*(\d+)\s*\|" + r"\s*([^|]*?)\s*\|" * 5 + r"\s*$")
CITED = {"☑", "☐"}
OPEN = ("—", "-", "")


def check(text: str) -> tuple[list[str], int]:
    rows = [m.groups() for m in map(THINKER_RE.match, text.splitlines()) if m]
    errs = []
    if [int(r[0]) for r in rows] != list(range(1, THINKERS + 1)):
        errs.append(f"the table must have rows numbered 1 to {THINKERS} in order; it has {len(rows)} rows")
    names = [r[1] for r in rows if r[1] not in OPEN]
    errs += [f"{n} is named twice" for n in sorted({n for n in names if names.count(n) > 1})]
    errs += [f"row {r[0]}: status {r[5]!r} is not one of {sorted(STATUSES)}" for r in rows if r[5] not in STATUSES]
    errs += [f"row {r[0]}: Cited {r[4]!r} is not ☑ or ☐" for r in rows if r[1] not in OPEN and r[4] not in CITED]
    return errs, THINKERS - len(names)


def check_authors(text: str, thinkers: list[str]) -> list[str]:
    rows = [m.groups() for m in map(ROW_RE.match, text.splitlines()) if m]
    errs = []
    if [int(r[0]) for r in rows] != list(range(1, len(rows) + 1)):
        errs.append("the rows must be numbered from 1 in order")
    if len(rows) > AUTHORS:
        errs.append(f"the table has {len(rows)} rows; the long list holds at most {AUTHORS}")
    names = [r[1] for r in rows]
    errs += [f"{n} is named twice" for n in sorted({n for n in names if names.count(n) > 1})]
    errs += [f"thinker {t} has no row" for t in thinkers if t not in names]
    return errs


def named(text: str) -> list[str]:
    return [m.group(2) for m in map(THINKER_RE.match, text.splitlines()) if m and m.group(2) not in OPEN]


def self_test() -> int:
    table = "\n".join(f"| {i} | T{i} | area | why | ☐ | proposed |" for i in range(1, 51))
    assert check(table) == ([], 0)
    assert check(table.replace("| T2 |", "| T1 |"))[0] == ["T1 is named twice"]
    assert check(table.replace("| 50 | T50 | area | why | ☐ | proposed |", ""))[0]
    assert check(table.replace("| T3 | area | why | ☐ |", "| — | — | — | — |")) == ([], 1)
    assert check(table.replace("| T4 | area | why | ☐ |", "| T4 | area | why | x |"))[0] == ["row 4: Cited 'x' is not ☑ or ☐"]
    authors = "| 1 | T1 | `k` | 1 |\n| 2 | A | `k` | |"
    assert check_authors(authors, ["T1"]) == []
    assert check_authors(authors, ["T1", "T9"]) == ["thinker T9 has no row"]
    assert check_authors(authors.replace("| 2 |", "| 3 |"), [])
    assert named(table.replace("| T3 |", "| — |"))[:3] == ["T1", "T2", "T4"]
    assert named("| 1 | A | `k` | 1 |") == []
    print("book_check: self-test passed", file=sys.stderr)
    return 0


def main() -> int:
    if sys.argv[1:] == ["--self-test"]:
        return self_test()
    thinkers = (ROOT / "50THINKERS.md").read_text()
    errs, left = check(thinkers)
    errs = [f"50THINKERS.md: {e}" for e in errs]
    authors = ROOT / "500AUTHORS.md"
    n = 0
    if authors.exists():
        text = authors.read_text()
        n = sum(1 for _ in filter(None, map(ROW_RE.match, text.splitlines())))
        errs += [f"500AUTHORS.md: {e}" for e in check_authors(text, named(thinkers))]
    for e in errs:
        print(f"book_check: {e}", file=sys.stderr)
    if not errs:
        print(f"book_check: {THINKERS} thinkers, {left} still open; {n} of {AUTHORS} authors", file=sys.stderr)
    return 1 if errs else 0


if __name__ == "__main__":
    sys.exit(main())
