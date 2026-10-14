#!/usr/bin/env bash
# essay-montaigne: does an essay keep what Montaigne asked of an essay? The countable part.
# The rules, each with the passage of the Essays it is derived from, are in
# .claude/skills/essay-montaigne/SKILL.md; the part that needs a reader is there too.
#   scripts/essay-montaigne.sh essays/2026-new-vs-better.md
#   scripts/essay-montaigne.sh --topics "AI,El Niño,social media,Bitcoin,privacy" <file>
#   scripts/essay-montaigne.sh --self-test
# Exit 1 when a rule fails. An open [AUTHOR ANECDOTE] marker fails only an essay whose status is
# not "draft": a draft may wait for its writer, a finished essay may not.
set -euo pipefail

check() { # check <file> <topics, comma separated or empty>; prints one line per rule
  local f="$1" topics="$2" bad=0 body words
  body="$(awk 'BEGIN{fm=0} /^---$/ && fm<2 {fm++; next} fm!=1' "$f" | awk '/^## Sources/{exit} {print}' | grep -v '^<!--' || true)"
  words="$(printf '%s\n' "$body" | wc -w)"
  say() { printf '  %-4s %-11s %s\n' "$1" "$2" "$3"; [ "$1" = ok ] || [ "$1" = note ] || bad=1; }

  # M1. "myself am the matter of my book": the writer is in it.
  local i; i="$(printf '%s\n' "$body" | grep -oE "(^|[^A-Za-z])(I|my|me|myself)([^A-Za-z]|$)" | wc -l)"
  if [ "$i" -ge 10 ]; then say ok first-person "$i uses of I, my, me"; else say FAIL first-person "$i uses of I, my, me; an essay has its writer in it (at least 10)"; fi

  # M2. "I do not paint its being, I paint its passage": it has a date, and says so.
  if grep -qE '^date: *[0-9]{4}-[0-9]{2}-[0-9]{2}' "$f" && printf '%s\n' "$body" | grep -qE '\b(19|20)[0-9]{2}\b'; then say ok dated "a date in the front matter and a year in the text"
  else say FAIL dated "no date in the front matter, or no year in the text"; fi

  # M3. "What do I know?": it doubts at least once.
  local d; d="$(printf '%s\n' "$body" | tr '\n' ' ' | grep -oiE "I do not know|I don't know|I cannot say|I can not say|I am not sure|I have not done|What do I know|I may contradict|I may be wrong" | wc -l)"
  if [ "$d" -ge 1 ]; then say ok doubt "$d sentences of doubt"; else say FAIL doubt "no sentence of doubt (I do not know, I cannot say, What do I know?)"; fi

  # M4. "I do not teach; I only relate": no order to the reader, no lesson for a heading.
  local t; t="$(printf '%s\n' "$body" | tr '\n' ' ' | grep -oiE "\byou (should|must|need to|have to)\b" | wc -l)"
  if [ "$t" -eq 0 ] && ! printf '%s\n' "$body" | grep -qiE '^#+ *(conclusion|lessons?|takeaways?|key points)'; then say ok no-lesson "no order to the reader, no heading of lessons"
  else say FAIL no-lesson "$t orders to the reader (you should, you must), or a heading of lessons"; fi

  # M5. "I do not number my borrowings, I weigh them", and "not before but after me": the
  # quoted words (those between double quotation marks, taken in pairs) are a small part, and the
  # first paragraph is the writer's own.
  local q first; q="$(printf '%s\n' "$body" | tr '\n' ' ' | awk -F'"' '{ n = 0; for (i = 2; i <= NF; i += 2) n += split($i, w, " "); print n }')"
  first="$(printf '%s\n' "$body" | awk 'NF && !/^#/ && !/^\*.*\*$/ {p=1} p && !NF {exit} p' | head -40)"
  if [ "$words" -gt 0 ] && [ $((q * 100 / words)) -le 20 ]; then say ok borrowings "$q of $words words are quoted ($((q * 100 / words))%)"
  else say FAIL borrowings "$q of $words words are quoted; more than 20% is a collection, not an essay"; fi
  if [ "$(printf '%s\n' "$first" | tr '\n' ' ' | awk -F'"' '{ n = 0; for (i = 2; i <= NF; i += 2) n += split($i, w, " "); print n }')" -ge 5 ]; then say FAIL own-first "the first paragraph quotes somebody; the writer speaks first"; else say ok own-first "the first paragraph is the writer's own"; fi

  # M6. This repository's rule, not Montaigne's: what is borrowed is named.
  if grep -q '^## Sources' "$f"; then say ok sources "a Sources section"; else say FAIL sources "no Sources section (AGENTS.md: cite at the point of use)"; fi

  # M7. The brief: each topic that was asked for is in the text.
  if [ -n "$topics" ]; then
    local IFS=, miss=""
    for topic in $topics; do printf '%s\n' "$body" | grep -qiF -- "$topic" || miss="$miss $topic;"; done
    if [ -z "$miss" ]; then say ok topics "every topic of the brief is in the text"; else say FAIL topics "missing:$miss"; fi
  fi

  # M8. The writer's own experience is the writer's to write.
  local a status; a="$(printf '%s\n' "$body" | grep -o '\[AUTHOR ANECDOTE' | wc -l)"
  status="$(grep -m1 -E '^status:' "$f" | sed 's/^status: *//; s/"//g' || true)"
  if [ "$a" -eq 0 ]; then say ok anecdotes "no open marker"
  elif [ "$status" = draft ]; then say note anecdotes "$a open [AUTHOR ANECDOTE] markers; the essay is a draft until its writer fills them"
  else say FAIL anecdotes "$a open [AUTHOR ANECDOTE] markers in an essay whose status is \"$status\""; fi
  return "$bad"
}

self_test() {
  local d; d="$(mktemp -d)"; trap 'rm -rf "$d"' RETURN
  printf -- '---\ntitle: "x"\nstatus: draft\ndate: 2026-10-14\n---\n# Good\n\nIn 2026 I went to the sea and I saw my own doubt. I do not know why I went. My friend came with me, and I told him what I saw, and he told me what he saw, and I wrote it for myself.\n\n## Sources\n\n- none\n' >"$d/good.md"
  printf -- '---\ntitle: "x"\nstatus: final\n---\n# Bad\n\n"A long quotation of another person that opens the text before the writer." You should always do this. You must do that.\n\n## Conclusion\n\n**[AUTHOR ANECDOTE: x]**\n' >"$d/bad.md"
  check "$d/good.md" "sea" >/dev/null || { echo "essay-montaigne: self-test: a good essay was refused" >&2; exit 1; }
  local out; out="$(check "$d/bad.md" "sea" || true)"
  for rule in first-person dated doubt no-lesson own-first sources topics anecdotes; do
    printf '%s\n' "$out" | grep -q "FAIL $rule" || { echo "essay-montaigne: self-test: the bad essay passed $rule" >&2; exit 1; }
  done
  echo "essay-montaigne: self-test ok: a good essay passes, and a bad one fails eight rules" >&2
}

topics=""
case "${1:-}" in
  --self-test) self_test; exit 0 ;;
  --topics) topics="${2:?essay-montaigne: --topics needs a list}"; shift 2 ;;
esac
# With no --topics, the brief is the essay's own: `topics: "a,b,c"` in its front matter.
[ -n "$topics" ] || [ ! -f "${1:-}" ] || topics="$(grep -m1 -E '^topics:' "$1" | sed 's/^topics: *//; s/^"//; s/"$//' || true)"
[ $# -eq 1 ] && [ -f "$1" ] || { echo "essay-montaigne: usage: scripts/essay-montaigne.sh [--topics a,b,c] <essay.md> | --self-test" >&2; exit 1; }
echo "essay-montaigne: $1"
if check "$1" "$topics"; then echo "essay-montaigne: the countable rules hold. Now the reader's part: .claude/skills/essay-montaigne/SKILL.md"
else echo "essay-montaigne: failed" >&2; exit 1; fi
