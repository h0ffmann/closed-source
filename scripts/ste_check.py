#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""ste_check — the ASD-STE100 text of a paper keeps what the original says.

An STE pass may change words, never facts. This check compares papers/<slug>/prose-ste/ with
papers/<slug>/prose/, file by file, and fails when any of these differ: the citation markers (as
a multiset), the cross-reference and heading anchors, the quotations, the numbers, and the
[ANALYSIS] and [AUTHOR ...] markers. It also reports, without failing, sentences over 25 words
outside quotations, so the STE100.md log can list them.

With --translation it compares papers/<slug>/prose-pt-BR/ instead, the Brazilian Portuguese
edition: the same facts, except that numbers are compared without their separators (3,5 is 3.5),
the markers are read in Portuguese, and a quotation may gain a translation but never lose its
English original.

    scripts/ste_check.py closed-source
    scripts/ste_check.py --translation closed-source
    scripts/ste_check.py --self-test
"""

from __future__ import annotations

import re
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CITE_RE = re.compile(r"-?@[A-Za-z][\w:-]*")
ANCHOR_RE = re.compile(r"\{[#.][^}]*\}")
QUOTE_RE = re.compile(r"[\"“]([^\"”]{3,})[\"”]")
NUMBER_RE = re.compile(r"(?<![\w@:/.-])\d[\d,.]*\d|(?<![\w@:/.-])\d(?![\w-])")
MARKER_RE = re.compile(r"\*\*\[(ANALYSIS|AUTHOR ANECDOTE|AUTHORS TO CONFIRM)")
PT_MARKERS = {"ANÁLISE": "ANALYSIS", "RELATO DO AUTOR": "AUTHOR ANECDOTE", "AUTORES A CONFIRMAR": "AUTHORS TO CONFIRM"}
PT_MARKER_RE = re.compile(r"\*\*\[(" + "|".join(PT_MARKERS) + ")")
LONG = 25


def _strip_code_urls(text: str) -> str:
    text = re.sub(r"`[^`]*`", " ", text)
    text = re.sub(r"<https?://[^>]+>|https?://\S+", " ", text)
    return re.sub(r"^---\n.*?\n---\n", "", text, flags=re.S)


def facts(text: str, pt: bool = False) -> dict[str, Counter]:
    t = _strip_code_urls(text)
    numbers = [n.rstrip(".,") for n in NUMBER_RE.findall(t)]
    return {
        "citations": Counter(CITE_RE.findall(t)),
        "anchors": Counter(ANCHOR_RE.findall(t)),
        "quotations": Counter(" ".join(q.split()) for q in QUOTE_RE.findall(t)),
        "numbers": Counter(re.sub(r"[.,]", "", n) for n in numbers) if pt else Counter(numbers),
        "markers": Counter(PT_MARKERS[m] for m in PT_MARKER_RE.findall(t)) if pt else Counter(MARKER_RE.findall(t)),
    }


def long_sentences(text: str) -> list[str]:
    t = _strip_code_urls(text)
    t = re.sub(r"^#.*$|^\|.*$|^:::.*$", " ", t, flags=re.M)
    t = re.sub(r"\[@[^\]]*\]|\[-@[^\]]*\]", " ", t)
    t = QUOTE_RE.sub("Q", t)
    out = []
    for s in re.split(r"(?<=[.!?])\s+(?=[A-Z*\[(])", " ".join(t.split())):
        words = [w for w in s.split() if re.search(r"\w", w)]
        if len(words) > LONG:
            out.append(f"{len(words)} words: {s[:90]}…")
    return out


def compare(orig: str, ste: str, translation: bool = False) -> list[str]:
    a, b = facts(orig), facts(ste, pt=translation)
    if translation:
        a["numbers"] = Counter(re.sub(r"[.,]", "", n) for n in a["numbers"].elements())
    errs = []
    for kind in a:
        if a[kind] != b[kind]:
            lost, added = a[kind] - b[kind], b[kind] - a[kind]
            # Splitting an [ANALYSIS] paragraph in two (the six-sentence rule) repeats its marker;
            # that marks the same interpretation, so an added ANALYSIS marker is not a change.
            if kind == "markers":
                added = Counter({k: v for k, v in added.items() if k != "ANALYSIS"})
            # A translation may follow an English quotation with its Portuguese version.
            if kind == "quotations" and translation:
                added = Counter()
            if lost:
                errs.append(f"{kind} lost: {sorted(lost.elements())}")
            if added:
                errs.append(f"{kind} added: {sorted(added.elements())}")
    return errs


def check(slug: str, translation: bool = False) -> int:
    base = ROOT / "papers" / slug
    orig_dir, ste_dir = base / "prose", base / ("prose-pt-BR" if translation else "prose-ste")
    errs, longs = [], []
    for o in sorted(orig_dir.glob("*.md")):
        s = ste_dir / o.name
        if not s.exists():
            errs.append(f"{s.relative_to(ROOT)} is missing")
            continue
        errs += [f"{o.name}: {e}" for e in compare(o.read_text(), s.read_text(), translation)]
        if not translation:
            longs += [f"{o.name}: {l}" for l in long_sentences(s.read_text())]
    meta = ste_dir / "00-metadata.md"
    if meta.exists() and not translation:
        longs += [f"00-metadata.md: {l}" for l in long_sentences(meta.read_text().replace("abstract: |", ""))]
    for l in longs:
        print(f"ste_check: note: {l}", file=sys.stderr)
    for e in errs:
        print(f"ste_check: {e}", file=sys.stderr)
    if not errs and translation:
        print(f"ste_check: {slug} pt-BR: citations, anchors, quotations, numbers and markers kept", file=sys.stderr)
    elif not errs:
        print(f"ste_check: {slug}: citations, anchors, quotations, numbers and markers unchanged"
              f"; {len(longs)} sentence(s) over {LONG} words", file=sys.stderr)  # fmt: skip
    return 1 if errs else 0


def self_test() -> int:
    o = 'A claim [@a; @b]. He said "it is so" in 1991. **[ANALYSIS]** See Section [-@sec:x].'
    assert compare(o, 'A claim is true [@a; @b]. In 1991 he said "it is so". **[ANALYSIS]** See Section [-@sec:x].') == []
    errs = compare(o, 'A claim [@a]. He said "it is" in 1992. See Section [-@sec:x].')
    kinds = " ".join(errs)
    for k in ("citations lost", "quotations lost", "numbers lost", "numbers added", "markers lost"):
        assert k in kinds, errs
    assert compare("**[ANALYSIS]** a. b.", "**[ANALYSIS]** a.\n\n**[ANALYSIS]** b.") == []
    assert long_sentences(" ".join(["word"] * 30) + ".") and not long_sentences("Short one.")
    pt = 'Uma tese [@a; @b]. Ele disse "it is so" (em tradução livre: "é assim") em 1991. **[ANÁLISE]** Ver a Seção [-@sec:x].'
    assert compare(o, pt, translation=True) == []
    assert compare("Cost 3.5 and 1,000.", "Custo 3,5 e 1.000.", translation=True) == []
    errs = " ".join(compare(o, 'Uma tese [@a]. Ele disse "é assim" em 1991. Ver a Seção [-@sec:x].', translation=True))
    for k in ("citations lost", "quotations lost", "markers lost"):
        assert k in errs, errs
    print("ste_check: self-test ok", file=sys.stderr)
    return 0


def main(argv: list[str]) -> int:
    if argv == ["--self-test"]:
        return self_test()
    translation = argv[:1] == ["--translation"]
    argv = argv[1:] if translation else argv
    if len(argv) != 1:
        print(__doc__, file=sys.stderr)
        return 2
    return check(argv[0], translation)


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
