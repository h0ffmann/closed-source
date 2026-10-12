#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""zenodo_upload — put one rendered PDF, and nothing else, into a Zenodo deposit.

Paper Fabric's v0 release policy archives only the PDF. Zenodo's GitHub integration would archive
the whole source tree, so it stays switched off for this repository; this script uses Zenodo's
deposit API instead, with the metadata in .zenodo.json.

By default it creates a **draft**: nothing is public and no DOI is registered until a person
reviews the draft on zenodo.org and presses Publish (Ouroboric principle: humans steer; a DOI is
permanent). --publish publishes straight away and is meant for a human at a terminal, not CI.

    scripts/zenodo_upload.py pdf/closed-source.pdf --version v0.1.0 --dry-run
    ZENODO_TOKEN=... scripts/zenodo_upload.py pdf/closed-source.pdf --version v0.1.0
    ZENODO_TOKEN=... scripts/zenodo_upload.py pdf/closed-source.pdf --version v0.2.0 --concept-recid 123
    scripts/zenodo_upload.py --self-test

Environment: ZENODO_TOKEN (scope deposit:write, plus deposit:actions for --publish);
ZENODO_URL (default https://zenodo.org; use https://sandbox.zenodo.org to rehearse).
"""

from __future__ import annotations

import argparse
import json
import os
import sys
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ZENODO_JSON = ROOT / ".zenodo.json"
# Keys the deposit API accepts from .zenodo.json as they are.
KEEP = (
    "title", "upload_type", "publication_type", "description", "creators", "contributors",
    "license", "access_right", "language", "keywords", "related_identifiers", "notes",
)  # fmt: skip


def deposit_metadata(meta: dict, version: str) -> dict:
    out = {k: meta[k] for k in KEEP if k in meta}
    out["version"] = version
    return {"metadata": out}


def _call(method: str, url: str, token: str, body: bytes | None = None, ctype: str = "application/json"):
    req = urllib.request.Request(url, data=body, method=method)
    req.add_header("Authorization", f"Bearer {token}")
    if body is not None:
        req.add_header("Content-Type", ctype)
    with urllib.request.urlopen(req, timeout=120) as resp:
        raw = resp.read()
    return json.loads(raw) if raw else {}


def upload(pdf: Path, version: str, concept_recid: str | None, publish: bool, base: str, token: str) -> dict:
    api = f"{base.rstrip('/')}/api/deposit/depositions"
    if concept_recid:
        # A new version of an existing record: Zenodo copies the previous files; remove them so
        # the new version holds only this PDF.
        # The concept record id resolves to the latest published version, which is the one
        # Zenodo accepts a newversion action on.
        latest = _call("GET", f"{base.rstrip('/')}/api/records/{concept_recid}", token)["id"]
        draft = _call("POST", f"{api}/{latest}/actions/newversion", token)
        draft = _call("GET", draft["links"]["latest_draft"], token)
        for f in draft.get("files", []):
            _call("DELETE", f["links"]["self"], token)
    else:
        draft = _call("POST", api, token, b"{}")
    bucket = draft["links"]["bucket"]
    with pdf.open("rb") as fh:
        _call("PUT", f"{bucket}/{pdf.name}", token, fh.read(), "application/octet-stream")
    meta = deposit_metadata(json.loads(ZENODO_JSON.read_text()), version)
    draft = _call("PUT", draft["links"]["self"], token, json.dumps(meta).encode())
    if publish:
        draft = _call("POST", draft["links"]["publish"], token)
    return draft


def self_test() -> int:
    meta = {"title": "t", "upload_type": "publication", "publication_type": "preprint", "x": 1}
    got = deposit_metadata(meta, "v0.1.0")["metadata"]
    assert got == {"title": "t", "upload_type": "publication", "publication_type": "preprint",
                   "version": "v0.1.0"}, got  # fmt: skip
    real = deposit_metadata(json.loads(ZENODO_JSON.read_text()), "v0.0.0")["metadata"]
    assert real["upload_type"] == "publication" and "doi" not in real
    print("zenodo_upload: self-test ok", file=sys.stderr)
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawTextHelpFormatter)
    ap.add_argument("pdf", nargs="?", type=Path)
    ap.add_argument("--version")
    ap.add_argument("--concept-recid", help="concept record id of the paper, to add a new version")
    ap.add_argument("--publish", action="store_true", help="publish now (mints a permanent DOI)")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--self-test", action="store_true")
    args = ap.parse_args()
    if args.self_test:
        return self_test()
    if not args.pdf or not args.version:
        ap.error("a PDF and --version are required")
    if args.pdf.suffix.lower() != ".pdf" or not args.pdf.is_file():
        ap.error(f"{args.pdf} is not a PDF file; v0 archives the rendered PDF only")
    base = os.environ.get("ZENODO_URL", "https://zenodo.org")
    if args.dry_run:
        meta = deposit_metadata(json.loads(ZENODO_JSON.read_text()), args.version)
        action = "publish" if args.publish else "leave as draft"
        print(f"zenodo_upload: would upload {args.pdf} ({args.pdf.stat().st_size} bytes) to {base},"
              f" {'new version of ' + args.concept_recid if args.concept_recid else 'new record'},"
              f" then {action}", file=sys.stderr)  # fmt: skip
        print(json.dumps(meta, indent=2, ensure_ascii=False))
        return 0
    token = os.environ.get("ZENODO_TOKEN")
    if not token:
        print("zenodo_upload: ZENODO_TOKEN is not set; nothing uploaded", file=sys.stderr)
        return 1
    dep = upload(args.pdf, args.version, args.concept_recid, args.publish, base, token)
    state = "published" if dep.get("submitted") else "draft, waiting for a human to publish"
    print(f"zenodo_upload: {state}: {dep['links'].get('html', dep['links'].get('self'))}", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
