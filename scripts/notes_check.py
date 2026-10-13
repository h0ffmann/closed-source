#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""notes_check — the slip box follows SMART_NOTE_POLICY.md.

Every notes/<id>-<slug>.md has front matter with id, title, type, status, source and created; the
id matches the file name and is unique; type and status are known values; it links to at least one
other note; every [[link]] in notes/ resolves; and notes/index.md links to every note.

    scripts/notes_check.py
    scripts/notes_check.py --self-test
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TYPES = {"fleeting", "literature", "permanent"}
STATUSES = {"unverified", "partial", "verified", "open-question"}
FIELDS = ("id", "title", "type", "status", "source", "created")
NAME_RE = re.compile(r"^(\d{12})-[a-z0-9-]+$")
LINK_RE = re.compile(r"\[\[([^\]|#]+)(?:[|#][^\]]*)?\]\]")


def front(text: str) -> dict[str, str]:
    if not text.startswith("---\n"):
        return {}
    body = text[4 : text.index("\n---\n", 4)]
    return {k.strip(): v.strip().strip('"') for k, v in (l.split(":", 1) for l in body.splitlines() if ":" in l and not l.startswith(" "))}


def check(notes: dict[str, str], index: str) -> list[str]:
    errs = []
    for stem, text in notes.items():
        m = NAME_RE.match(stem)
        fm = front(text)
        if not m:
            errs.append(f"{stem}: name must be <YYYYMMDDHHMM>-<slug>")
        errs += [f"{stem}: front matter has no {f}" for f in FIELDS if not fm.get(f)]
        if m and fm.get("id") and fm["id"] != m.group(1):
            errs.append(f"{stem}: id {fm['id']} does not match the file name")
        if fm.get("type") and fm["type"] not in TYPES:
            errs.append(f"{stem}: type {fm['type']!r} is not one of {sorted(TYPES)}")
        if fm.get("status") and fm["status"] not in STATUSES:
            errs.append(f"{stem}: status {fm['status']!r} is not one of {sorted(STATUSES)}")
        links = set(LINK_RE.findall(text)) - {stem}
        if not links:
            errs.append(f"{stem}: links to no other note")
        errs += [f"{stem}: [[{l}]] does not resolve" for l in sorted(links) if l not in notes]
        if stem not in LINK_RE.findall(index):
            errs.append(f"{stem}: notes/index.md does not link to it")
    ids = [s[:12] for s in notes]
    errs += [f"id {i} is used twice" for i in sorted({i for i in ids if ids.count(i) > 1})]
    errs += [f"index.md: [[{l}]] does not resolve" for l in sorted(set(LINK_RE.findall(index))) if l not in notes]
    return errs


def self_test() -> int:
    def note(i, link):
        return f'---\nid: "{i}"\ntitle: t\ntype: fleeting\nstatus: unverified\nsource: s\ncreated: 2026-10-12\n---\n[[{link}]]\n'
    a, b = "202610122236-a", "202610122237-b"
    good = {a: note("202610122236", b), b: note("202610122237", a)}
    assert check(good, f"[[{a}]] [[{b}]]") == []
    assert check(good, f"[[{a}]]") == [f"{b}: notes/index.md does not link to it"]
    bad = {a: note("202610122236", "202610122299-x")}
    assert f"{a}: [[202610122299-x]] does not resolve" in check(bad, f"[[{a}]]")
    print("notes_check: self-test passed", file=sys.stderr)
    return 0


def main() -> int:
    if sys.argv[1:] == ["--self-test"]:
        return self_test()
    d = ROOT / "notes"
    notes = {p.stem: p.read_text() for p in sorted(d.glob("*.md")) if p.name != "index.md"}
    errs = check(notes, (d / "index.md").read_text() if (d / "index.md").exists() else "")
    for e in errs:
        print(f"notes_check: {e}", file=sys.stderr)
    if not errs:
        print(f"notes_check: {len(notes)} notes, all linked", file=sys.stderr)
    return 1 if errs else 0


if __name__ == "__main__":
    sys.exit(main())
