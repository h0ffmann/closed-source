#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-only
# ouro-get: copy a Project Gutenberg eBook as is into works/<author>/, byte for byte, and print
# what works/index.md needs: the header fields, the sha256 and the lines of a work inside it.
#   scripts/ouro-get.sh <ebook-number> <author-slug> ["TITLE OF THE WORK"]
# shortcut: Project Gutenberg only; for Wikisource or Standard Ebooks copy the file by hand.
set -euo pipefail
id="${1:?ebook number}"; author="${2:?author slug}"; title="${3:-}"
case "$id" in *[!0-9]*) echo "ouro-get: the ebook number must be digits" >&2; exit 2;; esac
case "$author" in *[!a-z0-9-]*|'') echo "ouro-get: the author slug is lower case, digits and -" >&2; exit 2;; esac
url="https://www.gutenberg.org/cache/epub/$id/pg$id.txt"
out="works/$author/pg$id.txt"
mkdir -p "works/$author"
curl -fsSL -m 120 "$url" -o "$out"
echo "file:    $out"
echo "source:  $url"
echo "fetched: $(date -u +%Y-%m-%d)"
echo "sha256:  $(sha256sum "$out" | cut -d' ' -f1)"
grep -m6 -E '^(Title|Author|Translator|Editor|Release date|Language):' "$out" | tr -d '\r' || true
grep -n -E '^\*\*\* (START|END) OF' "$out" | tr -d '\r' || true
# The work's first line: the last line that is exactly its title (the first is often the contents).
if [ -n "$title" ]; then
  awk -v t="$title" '
    { sub(/\r$/, "") }
    $0 == t { start = NR }
    END { print (start ? "starts:  line " start : "starts:  title not found") }' "$out"
fi
