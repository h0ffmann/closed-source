#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""logos — fetch the logos a paper's title page shows and convert them for XeLaTeX.

A paper's metadata.md lists them under `logos:`, each with the SVG's URL at a pinned commit and
its sha256. The logos are trademarks of their projects and are not licensed here, so they are
never committed: this script downloads each one at build time, checks the hash, and writes
build/<file> (a PDF, with rsvg-convert, since XeLaTeX cannot include an SVG).

    scripts/logos.py closed-source
    scripts/logos.py --self-test
"""

import hashlib
import json
import shutil
import subprocess
import sys
import tempfile
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def metadata(slug: str) -> dict:
    tpl = Path(tempfile.mkdtemp()) / "meta.tpl"
    tpl.write_text("$meta-json$")
    out = subprocess.run(
        ["pandoc", str(ROOT / "papers" / slug / "metadata.md"), "--template", str(tpl), "-t", "plain"],
        check=True, capture_output=True, text=True,
    ).stdout  # fmt: skip
    shutil.rmtree(tpl.parent)
    return json.loads(out)


def check(data: bytes, sha256: str, url: str) -> None:
    got = hashlib.sha256(data).hexdigest()
    if got != sha256:
        raise ValueError(f"{url}: sha256 is {got}, metadata.md pins {sha256}")


def fetch(logo: dict, build: Path) -> Path:
    out = build / logo["file"]
    if out.exists():
        return out
    with urllib.request.urlopen(logo["svg"], timeout=30) as r:
        data = r.read()
    check(data, logo["sha256"], logo["svg"])
    out.parent.mkdir(parents=True, exist_ok=True)
    svg = out.with_suffix(".svg")
    svg.write_bytes(data)
    subprocess.run(["rsvg-convert", "-f", "pdf", "-o", str(out), str(svg)], check=True)
    return out


def self_test() -> int:
    check(b"x", hashlib.sha256(b"x").hexdigest(), "u")
    try:
        check(b"x", "0" * 64, "u")
    except ValueError:
        pass
    else:
        raise AssertionError("a wrong hash must fail")
    print("logos: self-test passed", file=sys.stderr)
    return 0


def main() -> int:
    if sys.argv[1:] == ["--self-test"]:
        return self_test()
    for slug in sys.argv[1:]:
        for logo in metadata(slug).get("logos", []):
            print(f"logos: build/{fetch(logo, ROOT / 'build').relative_to(ROOT / 'build')}", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
