#!/usr/bin/env bash
# print: one essay to one printed page, as a PDF whose text cannot be selected (PRINTING.md).
#   scripts/print.sh essays/2026-peer-reviewing-the-god-that-failed.md   # -> pdf/essays/<name>.pdf
#   scripts/print.sh --all                                               # every essay of essays/
# The tools are the paper lab's (flake.nix): pandoc, XeLaTeX, pdftocairo, rsvg-convert, pdftotext.
# Steps: the essay's own text (no front matter, no comment, no Sources) -> pandoc + XeLaTeX on an
# A5 page -> it must be one page -> each letter becomes a drawn shape (PDF -> SVG -> PDF), so a
# reader cannot select or copy the words -> pdftotext must find no word in the result.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

one() {
  local src="$1" name tmp out pages left want n svgs
  name="$(basename "$src" .md)"; out="pdf/essays/$name.pdf"
  tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' RETURN
  # The essay's own text: after the front matter, without HTML comments, up to "## Sources".
  awk 'BEGIN{fm=0} /^---$/ && fm<2 {fm++; next} fm==2' "$src" | grep -v '^<!--' | awk '/^## Sources/{exit} {print}' \
    | sed -E 's/\[`?([^]`]*)`?\]\([^)]*\)/\1/g' > "$tmp/body.md"
  cat > "$tmp/head.tex" <<'TEX'
\usepackage{fancyhdr}
\pagestyle{fancy}\fancyhf{}\renewcommand{\headrulewidth}{0pt}
\fancyfoot[C]{\scriptsize\itshape Closed Source: The God that Failed. doi:10.5281/zenodo.23333656. Printed from its own text; cite it, do not copy it.}
\setlength{\parindent}{0pt}\setlength{\parskip}{5pt}
TEX
  pandoc "$tmp/body.md" --from markdown --pdf-engine=xelatex -H "$tmp/head.tex" \
    -V documentclass=article -V papersize=a5 -V fontsize=10pt -V geometry:margin=16mm -V geometry:bottom=20mm \
    -V colorlinks=false -o "$tmp/text.pdf"
  pages="$(pdfinfo "$tmp/text.pdf" | awk '/^Pages/ {print $2}')"
  # An essay is one page, unless its front matter says `pages: 2` (PRINTING.md, rule 2).
  want="$(grep -m1 -E '^pages:' "$src" | sed 's/^pages: *//' || true)"; want="${want:-1}"
  [ "$pages" = "$want" ] || { echo "print: $src makes $pages pages and must make $want (PRINTING.md, rule 2)" >&2; return 1; }
  # Letters to shapes: cairo writes each glyph of the SVG as a path, and the PDF made from that
  # SVG has no text in it. One SVG for each page.
  svgs=()
  for n in $(seq 1 "$pages"); do pdftocairo -svg -f "$n" -l "$n" "$tmp/text.pdf" "$tmp/page-$n.svg"; svgs+=("$tmp/page-$n.svg"); done
  mkdir -p pdf/essays
  rsvg-convert -f pdf -o "$out" "${svgs[@]}"
  left="$(pdftotext "$out" - | tr -d '[:space:]' | wc -c)"
  [ "$left" = 0 ] || { echo "print: $out still has $left characters that can be selected" >&2; return 1; }
  echo "print: $out ($pages page(s), no text that can be selected)"
}

case "${1:-}" in
  --all) for e in essays/*.md; do [ "$e" = essays/index.md ] || one "$e"; done ;;
  "") echo "print: usage: scripts/print.sh <essay.md> | --all" >&2; exit 1 ;;
  *) [ -f "$1" ] || { echo "print: no file $1" >&2; exit 1; }; one "$1" ;;
esac
