#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-only
# readme: the checks that keep README.md in its style and README.easy.pt-BR.md current.
#   - README.md and README.easy.pt-BR.md are in lower case. An acronym (UFRJ, DOI, PDFs) keeps its
#     capitals; code, link targets, HTML and the generated citation block are not read.
#   - README.easy.pt-BR.md carries the sha256 of the README.md it was made from, keeps every DOI
#     and has the same number of sections. A translation cannot be checked by a script, so the
#     stamp is the contract: the easy-pt-br skill translates, then `--stamp` signs.
#   - .claude/skills/skills.lock pins every skill file by sha256, after marola's skills.lock.
# The shape (a bash script with --self-test, run by `just` and by CI) is scripts/release.sh's.
#   scripts/readme.sh --check       # what `just check` and the pre-commit hook run
#   scripts/readme.sh --stamp       # after the easy-pt-br skill updated the easy version
#   scripts/readme.sh --lock        # after a skill file changed on purpose
#   scripts/readme.sh --hook        # Claude Code hook: reads the hook's JSON on stdin
#   scripts/readme.sh --self-test
set -euo pipefail

readme=README.md
easy=README.easy.pt-BR.md
lock=.claude/skills/skills.lock

# Words on stdin's Markdown that have a capital and are not an acronym, one per line.
capitals() {
  perl -CSD -0777 -ne '
    s/```.*?```//gs; s/<!-- citation:start -->.*?<!-- citation:end -->//gs; s/<!--.*?-->//gs;
    s/`[^`\n]+`//g; s/\]\([^)]*\)/]/g; s/<[^>\n]+>//g; s{https?://[^\s)>\]]+}{}g;
    while (/([\p{L}\p{N}]*\p{Lu}[\p{L}\p{N}]*)/g) {
      my $w = $1; my $c = $w; $c =~ s/s$// if length($w) > 2;
      my $n = () = $c =~ /\p{Lu}/g;
      print "$w\n" unless $n >= 2 && $c eq uc($c);
    }'
}

sha() { sha256sum "$1" | cut -d' ' -f1; }
stamp_of() { grep -oE '^<!-- easy: source="README\.md"; sha256="[0-9a-f]{64}" -->$' "$1" | grep -oE '[0-9a-f]{64}' || true; }
dois() { grep -oE '10\.[0-9]{4,9}/zenodo\.[0-9]+' "$1" | sort -u; }
sections() { grep -cE '^## ' "$1" || true; }
stale() { [ ! -f "$easy" ] || [ "$(stamp_of "$easy")" != "$(sha "$readme")" ]; }

lock_entries() { grep -oE '"[^"]+": "[0-9a-f]{64}"' "$lock" | sed -E 's/^"([^"]+)": "([0-9a-f]{64})"$/\2  \1/'; }
skill_files() { find .claude/skills -type f ! -name skills.lock | LC_ALL=C sort; }

check() {
  local bad=0 words missing
  for f in "$readme" "$easy"; do
    [ -f "$f" ] || { echo "readme: $f is missing" >&2; bad=1; continue; }
    words="$(capitals <"$f" | sort -u | tr '\n' ' ')"
    if [ -n "$words" ]; then
      echo "readme: $f is in lower case, except acronyms; found: $words" >&2
      bad=1
    fi
  done
  if [ -f "$easy" ]; then
    if stale; then
      echo "readme: $easy was made from another $readme; run the easy-pt-br skill, then scripts/readme.sh --stamp" >&2
      bad=1
    fi
    missing="$(comm -23 <(dois "$readme") <(dois "$easy") | tr '\n' ' ')"
    [ -z "$missing" ] || { echo "readme: $easy lost a DOI: $missing" >&2; bad=1; }
    [ "$(sections "$readme")" = "$(sections "$easy")" ] \
      || { echo "readme: $easy has $(sections "$easy") sections, $readme has $(sections "$readme")" >&2; bad=1; }
  fi
  if ! diff <(lock_entries | LC_ALL=C sort -k2) <(skill_files | while read -r f; do echo "$(sha "$f")  ${f#.claude/skills/}"; done | LC_ALL=C sort -k2) >/dev/null; then
    echo "readme: $lock does not match the files in .claude/skills/; if the change is meant, run scripts/readme.sh --lock" >&2
    bad=1
  fi
  [ "$bad" -eq 0 ] || exit 1
  echo "readme: lower case, $easy current ($(sections "$easy") sections, $(dois "$easy" | wc -l) DOIs), $(skill_files | wc -l) skill files locked" >&2
}

case "${1:-}" in
  --check) cd "$(git rev-parse --show-toplevel)"; check ;;
  --stamp)
    cd "$(git rev-parse --show-toplevel)"
    [ -n "$(grep -cE '^<!-- easy: source="README\.md"; sha256="[0-9a-f]*" -->$' "$easy" | grep -v '^0$')" ] \
      || { echo "readme: $easy has no '<!-- easy: source=\"README.md\"; sha256=\"...\" -->' line" >&2; exit 1; }
    sed -i -E "s/^<!-- easy: source=\"README\\.md\"; sha256=\"[0-9a-f]*\" -->\$/<!-- easy: source=\"README.md\"; sha256=\"$(sha "$readme")\" -->/" "$easy"
    echo "readme: stamped $easy with the sha256 of $readme" >&2
    ;;
  --lock)
    cd "$(git rev-parse --show-toplevel)"
    {
      echo '{'
      echo '  "version": 1,'
      echo '  "note": "every skill here was written for this repository; none is a copy. SOURCES in each SKILL.md and in README.md say what each one read. sha256 of each file, checked by scripts/readme.sh --check.",'
      echo '  "files": {'
      skill_files | while read -r f; do echo "    \"${f#.claude/skills/}\": \"$(sha "$f")\","; done | sed '$ s/,$//'
      echo '  }'
      echo '}'
    } >"$lock"
    echo "readme: wrote $lock" >&2
    ;;
  --hook)
    # PostToolUse on an edit of README.md, and Stop: tell the agent to translate before it ends.
    # Exit 2 gives the message back to the agent. A Stop hook that already fired once lets go.
    input="$(cat)"
    cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}"
    msg="README.md changed after README.easy.pt-BR.md was made. Use the easy-pt-br skill (.claude/skills/easy-pt-br/SKILL.md) to bring the easy version up to date, then run scripts/readme.sh --stamp and scripts/readme.sh --check."
    if grep -Eq '"hook_event_name" *: *"Stop"' <<<"$input"; then
      grep -Eq '"stop_hook_active" *: *true' <<<"$input" && exit 0
      if stale; then echo "$msg" >&2; exit 2; fi
    elif grep -Eq '"file_path" *: *"([^"]*/)?README\.md"' <<<"$input"; then
      if stale; then echo "$msg" >&2; exit 2; fi
    fi
    exit 0
    ;;
  --self-test)
    fail() { echo "readme: self-test: $*" >&2; exit 1; }
    t() { printf '%s' "$1" | capitals | tr '\n' ' '; }
    [ -z "$(t 'the PDFs of UFRJ and the IFS, ASD-STE100, CC BY 4.0, 2FA and a DOI.')" ] || fail "an acronym was refused: $(t 'the PDFs of UFRJ and the IFS, ASD-STE100, CC BY 4.0, 2FA and a DOI.')"
    [ "$(t 'Closed source by Matheus, a I, GitHub and Às vezes')" = "Closed Matheus I GitHub Às " ] || fail "a capital passed: $(t 'Closed source by Matheus, a I, GitHub and Às vezes')"
    [ -z "$(t 'see `AGENTS.md` and [x](https://X.org/Y) <a href="Z">z</a> https://Q.org/W')" ] || fail "code, a link target or HTML was read"
    [ -z "$(t $'a\n```sh\nNix Just\n```\n<!-- citation:start -->\nBibTeX Hoffmann\n<!-- citation:end -->\nb')" ] || fail "a code block or the citation block was read"
    d="$(mktemp -d)"; trap 'rm -rf "$d"' EXIT
    printf 'x 10.5281/zenodo.1 and 10.5281/zenodo.2 and 10.5281/zenodo.1\n' >"$d/a"
    [ "$(dois "$d/a" | wc -l)" = 2 ] || fail "dois"
    printf '<!-- easy: source="README.md"; sha256="%s" -->\n' "$(printf a | sha256sum | cut -d" " -f1)" >"$d/e"
    [ "$(stamp_of "$d/e")" = "$(printf a | sha256sum | cut -d' ' -f1)" ] || fail "stamp_of"
    [ -z "$(stamp_of "$d/a")" ] || fail "a stamp was found where there is none"
    echo "readme: self-test ok" >&2
    ;;
  *) echo "readme: usage: scripts/readme.sh --check | --stamp | --lock | --hook | --self-test" >&2; exit 1 ;;
esac
