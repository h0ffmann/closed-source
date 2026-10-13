#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-only
# minted: after a release, write the release into the repository. A release cannot name its own
# DOI: Zenodo mints it a few minutes after the tag. So every release is followed by one pull
# request that says "vX.Y.Z is live" and puts the new DOI wherever the latest release is named.
# This script makes that pull request's changes, the same way each time:
#   - RELEASES.md: the "is live" line and the table of every release, from the Git tags, Zenodo's
#     version DOIs and the pull requests merged between the tags; the "Next: vX.Y.Z" section of a
#     version that is now released is removed;
#   - README.md and README.easy.pt-BR.md: the version DOI badge, the status line, the row of the
#     two-DOI table, then scripts/readme.sh --stamp (the same change went into both);
#   - docs/4-ways-of-working/releasing.md: the paragraph that names the latest release;
#   - docs/social/*/README*.md that are drafts: the previous version's name becomes the new one.
# It asks Zenodo's public API and needs no token. It changes files and commits nothing: read the
# diff, then open the pull request (`--pr-body` prints a body for it).
# The shape (bash with --self-test, run by `just`) is scripts/release.sh's; the loop is Ouroboric's
# "it documents itself as it documents its output" (docs/4-ways-of-working/ouroboric-patterns.md).
#   just minted                 # write the latest release into the repository
#   scripts/minted.sh --wait    # first wait, up to 20 minutes, until Zenodo has minted its DOI
#   scripts/minted.sh --pr-body # print the pull request's body for the latest release
#   scripts/minted.sh --self-test
set -euo pipefail

repo_url=https://github.com/h0ffmann/closed-source
zenodo="${ZENODO_URL:-https://zenodo.org}"

# rows: "<tag>\t<date>" on stdin and a file of "<tag>\t<doi>"; prints the table rows, newest first.
# changes <prev-or-empty> <tag>: the merged pull requests between two tags, as "title (#n); ...".
changes() {
  local range="${1:+$1..}$2" out="" n=0 sha subject title num
  for sha in $(git log --first-parent --format=%H "$range"); do
    subject="$(git log -1 --format=%s "$sha")"
    if [[ "$subject" =~ ^Merge\ pull\ request\ \#([0-9]+) ]]; then
      num="${BASH_REMATCH[1]}"
      title="$(git log -1 --format=%b "$sha" | grep -m1 -v '^[[:space:]]*$' || echo "$subject")"
      n=$((n + 1))
      if [ "$n" -le 6 ]; then out+="${out:+; }${title//|/\\|} (#$num)"; fi
    fi
  done
  if [ "$n" -gt 6 ]; then out+="; and $((n - 6)) more"; fi
  printf '%s' "${out:-no pull request}"
}

# The concept DOI, from CITATION.cff (generated from tools/src/fabric/citation.gleam).
concept() { grep -m1 -oE '^doi: 10\.5281/zenodo\.[0-9]+' CITATION.cff | cut -d' ' -f2; }

# "<version>\t<doi>" for every Zenodo record of the concept DOI.
version_dois() {
  local c="$1"
  curl -fsS --max-time 120 -A paper-fabric -H 'Accept: application/json' \
    "$zenodo/api/records?q=conceptrecid%3A${c##*zenodo.}&all_versions=true&sort=mostrecent&size=100" \
    | pick_versions "$c"
}

# Zenodo's reply on stdin -> "<version>\t<doi>" for the records of the concept DOI $1.
pick_versions() {
  C="$1" perl -MJSON::PP -0777 -ne '
    for my $h (@{ decode_json($_)->{hits}{hits} }) {
      next unless ($h->{conceptdoi} // "") eq $ENV{C} && $h->{metadata}{version} && $h->{doi};
      print "$h->{metadata}{version}\t$h->{doi}\n";
    }'
}

# replace_once <file> <perl regex> <replacement text>: exactly one line must match, or it stops.
replace_once() {
  local file="$1" n
  n="$(RX="$2" perl -CSD -ne 'BEGIN { $n = 0 } $n++ if /$ENV{RX}/; END { print $n }' "$file")"
  [ "$n" = 1 ] || { echo "minted: $file: expected one line that matches /$2/, found $n; the page changed shape, so update scripts/minted.sh with it" >&2; exit 1; }
  RX="$2" TO="$3" perl -CSD -i -pe 's/$ENV{RX}/$ENV{TO}/' "$file"
}

doi_link() { printf '[%s](https://doi.org/%s)' "$1" "$1"; }

case "${1:-}" in
  --self-test)
    fail() { echo "minted: self-test: $*" >&2; exit 1; }
    d="$(mktemp -d)"; trap 'rm -rf "$d"' EXIT
    printf 'a\n**status:** v0.1.0 is live (x).\nb\n' >"$d/f"
    replace_once "$d/f" '\*\*status:\*\* v\S+ is live' '**status:** v0.2.0 is live'
    [ "$(sed -n 2p "$d/f")" = '**status:** v0.2.0 is live (x).' ] || fail "replace_once: $(sed -n 2p "$d/f")"
    if (replace_once "$d/f" 'no such line' x) 2>/dev/null; then fail "a missing line was accepted"; fi
    printf 'x is live\nx is live\n' >"$d/g"
    if (replace_once "$d/g" 'is live' x) 2>/dev/null; then fail "two matching lines were accepted"; fi
    json='{"hits":{"hits":[{"doi":"10.5281/zenodo.9","conceptdoi":"10.5281/zenodo.8","metadata":{"version":"v0.1.1"}},{"doi":"10.5281/zenodo.7","conceptdoi":"10.5281/zenodo.6","metadata":{"version":"v9.9.9"}}]}}'
    got="$(printf '%s' "$json" | pick_versions 10.5281/zenodo.8)"
    [ "$got" = $'v0.1.1\t10.5281/zenodo.9' ] || fail "version_dois: $got"
    [ "$(doi_link 10.5281/zenodo.9)" = '[10.5281/zenodo.9](https://doi.org/10.5281/zenodo.9)' ] || fail "doi_link"
    echo "minted: self-test ok" >&2
    exit 0
    ;;
esac

cd "$(git rev-parse --show-toplevel)"
git fetch -q --tags origin
latest="$(git tag -l 'v*' --sort=-v:refname | head -1)"
[ -n "$latest" ] || { echo "minted: no release tag yet" >&2; exit 1; }
c="$(concept)"
[ -n "$c" ] || { echo "minted: no concept DOI in CITATION.cff; the first release sets it by hand (docs/4-ways-of-working/releasing.md)" >&2; exit 1; }

dois="$(mktemp)"; trap 'rm -f "$dois"' EXIT
tries=1
[ "${1:-}" = --wait ] && tries=40
for i in $(seq "$tries"); do
  version_dois "$c" >"$dois" || true
  grep -q "^$latest"$'\t' "$dois" && break
  if [ "$i" -lt "$tries" ]; then echo "minted: Zenodo has no DOI for $latest yet; waiting 30 s ($i of $tries)" >&2; sleep 30; fi
done
doi="$(grep "^$latest"$'\t' "$dois" | cut -f2 || true)"
[ -n "$doi" ] || { echo "minted: Zenodo has no DOI for $latest yet. Wait a few minutes (or run with --wait). If it never comes, check the webhook's deliveries: gh api repos/h0ffmann/closed-source/hooks" >&2; exit 1; }
date="$(git log -1 --format=%cs "$latest")"
long_date="$(date -u -d "$date" +'%-d %B %Y')"

if [ "${1:-}" = --pr-body ]; then
  prev="$(git tag -l 'v*' --sort=-v:refname | sed -n 2p)"
  cat <<EOF
## Task

The report that follows every release (\`docs/4-ways-of-working/releasing.md\`, step 6), written by \`just minted\`.

**$latest is live.**

- Tag: \`$latest\` at \`$(git rev-parse --short "$latest")\`, $long_date.
- GitHub release: $repo_url/releases/tag/$latest
- Permanent DOI of $latest: [$doi](https://doi.org/$doi)
- Latest DOI, unchanged: [$c](https://doi.org/$c). It now opens $latest.
- Since ${prev:-the first commit}: $(changes "$prev" "$latest")

\`scripts/minted.sh\` wrote the release into \`RELEASES.md\`, the README's badge, status line and DOI table, the easy version (restamped), \`releasing.md\` and the drafts in \`docs/social/\`. The website needs no change: its next build asks Zenodo for the version DOIs.

By hand, if they apply: the date of record in \`RELATED_WORK.md\` and \`KEYWORDS.md\`, read back from DataCite for the new DOI.

## Proof

- Zenodo's API lists \`$latest\` with the DOI above under the concept DOI.
- \`just check\` passes on this branch.

## Checklist

- [x] A fact changed in \`prose/\` is changed in \`prose-ste/\` and \`prose-pt-BR/\` too. (No prose changed.)
- [x] Every new Markdown file has its cite line (PERSONAS.md). (No new Markdown file.)
- [x] A change to a hard rule links its change proposal in \`docs/2-engineering/changes/\`. (No rule changed.)
- [ ] A journal entry is added if this change met a challenge worth recording.
EOF
  exit 0
fi

# --- RELEASES.md: the block between the markers, and the "Next" section of a released version.
rows=""
prev_of() { git tag -l 'v*' --sort=-v:refname | grep -A1 -x "$1" | sed -n 2p; }
for tag in $(git tag -l 'v*' --sort=-v:refname); do
  d="$(grep "^$tag"$'\t' "$dois" | cut -f2 || true)"
  cell="not minted"
  links="[GitHub]($repo_url/releases/tag/$tag)"
  if [ -n "$d" ]; then cell="$(doi_link "$d")"; links+=", [Zenodo]($zenodo/records/${d##*zenodo.})"; fi
  rows+="| $tag | $(git log -1 --format=%cs "$tag") | $cell | $links | $(changes "$(prev_of "$tag")" "$tag") |"$'\n'
done
block="<!-- releases:start -->
**$latest is live** ($long_date).

| Version | Date | Permanent DOI | Release | Pull requests merged since the version before |
|---|---|---|---|---|
$rows<!-- releases:end -->"
grep -q '^<!-- releases:start -->$' RELEASES.md && grep -q '^<!-- releases:end -->$' RELEASES.md \
  || { echo "minted: RELEASES.md has no <!-- releases:start --> ... <!-- releases:end --> block" >&2; exit 1; }
BLOCK="$block" perl -CSD -0777 -i -pe 's/<!-- releases:start -->.*?<!-- releases:end -->/$ENV{BLOCK}/s' RELEASES.md
TAG="$latest" perl -CSD -0777 -i -pe 's/^## Next: \Q$ENV{TAG}\E\b.*?(?=^## |\z)//ms' RELEASES.md

# --- The pages that name the latest release.
old="$(grep -oE '\*\*status:\*\* v[0-9]+\.[0-9]+\.[0-9]+ is live' README.md | grep -oE 'v[0-9.]+[0-9]' || true)"
badge="[![$latest DOI](https://img.shields.io/badge/${latest}_DOI-${doi/\//%2F}-555555?style=flat-square)](https://doi.org/$doi)"
replace_once README.md '^\[!\[v\S+ DOI\]\(.*$' "$badge"
replace_once README.md '\*\*status:\*\* v\S+ is live' "**status:** $latest is live"
replace_once README.md '^\| this work \| .*$' "| this work | $(doi_link "$c") | $latest: $(doi_link "$doi"); earlier versions: [\`RELEASES.md\`](RELEASES.md) |"
replace_once README.md '; v\S+ is the latest \|' "; $latest is the latest |"
replace_once README.easy.pt-BR.md 'a versão v\S+ está no ar' "a versão $latest está no ar"
replace_once README.easy.pt-BR.md '^\| deste trabalho \| .*$' "| deste trabalho | $(doi_link "$c") | $latest: $(doi_link "$doi"); versões anteriores: [\`RELEASES.md\`](RELEASES.md) |"
scripts/readme.sh --stamp

para="<!-- minted:start -->
The latest release is $latest, with the version DOI
$(doi_link "$doi"). The concept DOI, which always resolves to the latest version, is
$(doi_link "$c"). [\`RELEASES.md\`](../../RELEASES.md) lists every release.
<!-- minted:end -->"
grep -q '^<!-- minted:start -->$' docs/4-ways-of-working/releasing.md \
  || { echo "minted: releasing.md has no <!-- minted:start --> ... <!-- minted:end --> block" >&2; exit 1; }
BLOCK="$para" perl -CSD -0777 -i -pe 's/<!-- minted:start -->.*?<!-- minted:end -->/$ENV{BLOCK}/s' docs/4-ways-of-working/releasing.md

# --- Drafts of posts name the release they announce; a posted one is history and stays.
if [ -n "$old" ] && [ "$old" != "$latest" ]; then
  for f in docs/social/*/README*.md; do
    [ -f "$f" ] || continue
    grep -qE '^status: draft$' "$f" || continue
    OLD="$old" NEW="$latest" perl -CSD -i -pe 's/\Q$ENV{OLD}\E(?![0-9.])/$ENV{NEW}/g' "$f"
  done
fi

echo "minted: $latest is live, $doi. Wrote RELEASES.md, README.md, README.easy.pt-BR.md, releasing.md and the drafts in docs/social/." >&2
echo "minted: next: read \`git diff\`, set the date of record in RELATED_WORK.md and KEYWORDS.md if you read the indexes again, run \`just check\`, and open the pull request (\`scripts/minted.sh --pr-body\` prints its body)." >&2
