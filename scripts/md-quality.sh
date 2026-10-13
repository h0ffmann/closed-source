#!/usr/bin/env bash
# md-quality: three analysers over the Markdown files, each for one kind of fault.
#   - markdownlint-cli2: the structure (.markdownlint-cli2.jsonc)
#   - Vale: the prose rules of AGENTS.md (.vale.ini, .vale/styles/fabric/)
#   - lychee: links to files and headings that do not exist; with --online, dead web links too
# The tools come from the flake's `md` shell (`just md-quality` enters it), pinned by flake.lock.
# docs/4-ways-of-working/md-quality.md says what each rule is, where it comes from and what the
# three do not check.
#
#   scripts/md-quality.sh              # what CI runs: structure, prose, local links
#   scripts/md-quality.sh --online     # the same, and lychee fetches every web link, the website's too
#   scripts/md-quality.sh --self-test  # each analyser must refuse a bad file
#   scripts/md-quality.sh --count      # JSON: how many different links go to GitHub and to Zenodo
#                                      # (git and grep only; `just site-build` publishes it as
#                                      # links.json, and two badges in README.md read it)
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

# Not checked by any of the three: other people's text, generated files, and the two files with
# their own hard rule (no agent reads CLAUDE_PROJECT.md; only the owner writes NAGORI.md).
skip='^(forks/|LICENSES/|docs/4-ways-of-working/ouroboric/|CLAUDE_PROJECT\.md$|NAGORI\.md$|OUROBORIC(_RESEARCH)?\.md$)'
# The paper's sources are pandoc's Markdown, and `tools/fabric ste-check` is their check.
paper='^papers/[^/]+/(prose[^/]*/|metadata\.md$)'
# Vale's rules are for English that this repository writes. Not for Portuguese, not for the
# owner's requests kept word for word, and not for notes, which keep an idea as it came.
not_prose='(pt-BR|^\.claude/project/request\.md$|^notes/)'

files() { git ls-files '*.md' | grep -Ev "$skip" | grep -Ev "$paper"; }

self_test() {
  local d; d="$(mktemp -d)"; trap 'rm -rf "$d"' RETURN
  fail() { echo "md-quality: self-test: $1" >&2; exit 1; }
  printf '# A page\n## No blank line above\n\n\n\nTwo blank lines above.\n' > "$d/structure.md"
  ! markdownlint-cli2 --config .markdownlint-cli2.jsonc "$d/structure.md" >/dev/null 2>&1 \
    || fail "markdownlint passed a heading with no blank line"
  printf '# A page\n\nWe utilize a very robust tool.\n' > "$d/prose.md"
  ! vale --config .vale.ini --no-wrap "$d/prose.md" >/dev/null 2>&1 \
    || fail "Vale passed 'utilize' and 'very'"
  printf '# A page\n\nA plain sentence with a number: 3 tools.\n' > "$d/good.md"
  vale --config .vale.ini --no-wrap "$d/good.md" >/dev/null 2>&1 || fail "Vale refused a plain sentence"
  printf '# A page\n\n[a file that is not there](not-there.md)\n' > "$d/link.md"
  ! lychee --offline --no-progress "$d/link.md" >/dev/null 2>&1 \
    || fail "lychee passed a link to a file that does not exist"
  count | grep -qE '^\{"files": [0-9]+, "links": [0-9]+, "github": [0-9]+, "zenodo": [0-9]+\}$' \
    || fail "--count did not print its four numbers"
  echo "md-quality: self-test ok: each of the three refused a bad file" >&2
}

# The website, as published: `--online` also checks every link on its page.
site=https://h0ffmann.github.io/closed-source/
# Different web links in the checked files, by where they go. A Zenodo link is zenodo.org or a
# DOI that Zenodo minted (10.5281/zenodo.N), through doi.org or DataCite's API.
urls() { files | xargs grep -ohE 'https?://[^][ )>"`|<]+' | sed -E 's/[.,;:*]+$//' | sort -u; }
count() {
  local all gh zen
  all="$(urls)"
  gh="$(grep -cE '^https?://(www\.)?github\.com/' <<<"$all" || true)"
  zen="$(grep -cE '^https?://((www\.)?zenodo\.org/|(dx\.)?doi\.org/10\.5281/zenodo\.|api\.datacite\.org/dois/10\.5281/zenodo\.)' <<<"$all" || true)"
  printf '{"files": %s, "links": %s, "github": %s, "zenodo": %s}\n' "$(files | wc -l)" "$(wc -l <<<"$all")" "$gh" "$zen"
}

online=0
case "${1:-}" in
  --self-test) self_test; exit 0 ;;
  --count) count; exit 0 ;;
  --online) online=1 ;;
  "") ;;
  *) echo "md-quality: usage: scripts/md-quality.sh [--online | --self-test | --count]" >&2; exit 1 ;;
esac

mapfile -t all < <(files)
mapfile -t prose < <(files | grep -Ev "$not_prose")
bad=0

echo "md-quality: structure: markdownlint-cli2 on ${#all[@]} files" >&2
markdownlint-cli2 "${all[@]}" >/dev/null 2>"${TMPDIR:-/tmp}/md-quality.$$" \
  || { grep -E ' (error|warning) ' "${TMPDIR:-/tmp}/md-quality.$$" >&2 || cat "${TMPDIR:-/tmp}/md-quality.$$" >&2; bad=1; }
rm -f "${TMPDIR:-/tmp}/md-quality.$$"

echo "md-quality: prose: Vale on ${#prose[@]} files (an error fails; a warning is advice)" >&2
vale --no-wrap --output=line "${prose[@]}" >&2 || bad=1

if [ "$online" = 1 ]; then
  echo "md-quality: links: lychee on ${#all[@]} files and $site, web links too" >&2
  lychee --no-progress --include-fragments --max-concurrency 8 --accept 200,403,429 "${all[@]}" "$site" >&2 || bad=1
else
  echo "md-quality: links: lychee on ${#all[@]} files, local links (run --online for the web)" >&2
  lychee --offline --no-progress --include-fragments "${all[@]}" >&2 || bad=1
fi

[ "$bad" = 0 ] || { echo "md-quality: failed" >&2; exit 1; }
echo "md-quality: ok" >&2
