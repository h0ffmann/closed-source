#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-only
# citation-board: score the READMEs listed in scripts/citation-board.tsv with
# scripts/citation-score.sh and write CITATION_SCORES.md. Each file is read from GitHub at the
# commit its default branch has now, so each row names the exact text that was scored. This
# repository's own README.md is read from the working tree, because a commit cannot name itself.
# It needs the network; it is a record made on a date, not a check, and CI does not run it.
#   just citation-board
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
out=CITATION_SCORES.md
self="$(git remote get-url origin | sed -E 's#(git@github.com:|https://github.com/)##; s#\.git$##')"
rows="" tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
while IFS=$'\t' read -r name repo path; do
  case "$name" in '' | '#'*) continue ;; esac
  if [ "$repo" = "$self" ]; then
    cp "$path" "$tmp"
    at="working tree" link="$path"
  else
    sha="$(git ls-remote "https://github.com/$repo" HEAD | cut -c1-7)"
    [ -n "$sha" ] || { echo "citation-board: no HEAD for $repo" >&2; exit 1; }
    curl -fsSL --max-time 30 "https://raw.githubusercontent.com/$repo/$sha/$path" -o "$tmp"
    at="\`$sha\`" link="https://github.com/$repo/blob/$sha/$path"
  fi
  IFS=$'\t' read -r pct cited total verdict <<<"$(scripts/citation-score.sh --tsv "$tmp")"
  rows+="| $name | [$repo \`$path\`]($link) | $at | $cited | $total | $pct% | $verdict |"$'\n'
  echo "citation-board: $name $pct% ($cited of $total)" >&2
done <scripts/citation-board.tsv

{
  printf '%s\n' '---' 'title: "Citation scores of five READMEs"' 'status: draft' "date: $(date -u +%F)" \
    'related: [.claude/skills/citation-score/SKILL.md, scripts/citation-score.sh, scripts/citation-board.sh]' \
    'style: reference' '---' '<!-- cite: main="Claude"; last="Matheus Hoffmann" -->' '' '# Citation scores' ''
  printf '%s\n' \
    "How much of each README is cited, measured with [\`scripts/citation-score.sh\`](scripts/citation-score.sh)" \
    "on $(date -u +'%-d %B %Y'). The score is the share of sentences that carry a citation mark: a" \
    'link, a DOI, a pandoc key, a footnote or an author and a year. `just citation-board` writes this' \
    'file from [`scripts/citation-board.tsv`](scripts/citation-board.tsv); do not edit the table by' \
    'hand. The website shows the same table.' '' \
    '<!-- citation-board:start -->' \
    '| README | File | At commit | Cited sentences | Sentences | Score | Verdict |' \
    '|---|---|---|---:|---:|---:|---|'
  printf '%s' "$rows"
  printf '%s\n' '<!-- citation-board:end -->' '' '## How to read it' '' \
    '- **A README is not a paper.** Most of its marks are links to its own files and to the projects' \
    '  it names. A link shows where a thing is; it does not always show where an idea came from.' \
    '- **A low score is not a fault.** A page that says what its author built, in the author'"'"'s own' \
    '  words, has little to cite. The score says how much of a text points at something else.' \
    '- **The verdicts are a scale for texts, set by the owner of this repository**' \
    '  ([the `citation-score` skill](.claude/skills/citation-score/SKILL.md)). They are not a' \
    '  judgement of the people or the projects behind the other READMEs.' \
    '- **The numbers are approximate.** The skill lists what the script cannot tell.' \
    '- **Each row names the commit** that was scored, so a reader can run the script on the same text.'
} >"$out"
echo "citation-board: wrote $out" >&2
