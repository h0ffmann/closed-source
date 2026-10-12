#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-only
# setup-toolchain — install the pinned build toolchain on Debian or Ubuntu (CI uses this too):
# pandoc 3.1.3 and pandoc-crossref 0.3.16.0 (built for pandoc 3.1.x), and XeLaTeX from TeX Live.
# Pinning matters: pandoc-crossref is tied to the pandoc version it was built with.
set -euo pipefail
PANDOC=3.1.3
CROSSREF=0.3.16.0
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
sudo apt-get update -q
sudo apt-get install -y -q --no-install-recommends \
  texlive-xetex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended lmodern make
if ! pandoc --version 2>/dev/null | head -1 | grep -qx "pandoc $PANDOC"; then
  curl -fsSL -o "$tmp/pandoc.deb" \
    "https://github.com/jgm/pandoc/releases/download/$PANDOC/pandoc-$PANDOC-1-amd64.deb"
  sudo dpkg -i "$tmp/pandoc.deb"
fi
curl -fsSL -o "$tmp/crossref.tar.xz" \
  "https://github.com/lierdakil/pandoc-crossref/releases/download/v$CROSSREF/pandoc-crossref-Linux.tar.xz"
tar -C "$tmp" -xf "$tmp/crossref.tar.xz" pandoc-crossref
sudo install -m 0755 "$tmp/pandoc-crossref" /usr/local/bin/pandoc-crossref
pandoc --version | head -1
pandoc-crossref --version | head -1
