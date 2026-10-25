#!/usr/bin/env bash
# essay-montaigne: does an essay keep what Montaigne asked of an essay? The countable part.
# The rules, each with the passage of the Essays it is derived from, are in
# .claude/skills/essay-montaigne/SKILL.md; the part that needs a reader is there too.
#   scripts/essay-montaigne.sh essays/2026-new-vs-better.md
#   scripts/essay-montaigne.sh --topics "AI,El Niño,social media,Bitcoin,privacy" <file>
#   scripts/essay-montaigne.sh --self-test
# An essay in Brazilian Portuguese (`lang: pt-BR` in its front matter, or a name that ends in
# .pt-BR.md) is checked with the Portuguese words of each rule; its last section is `## Fontes`.
# Exit 1 when a rule fails. An open [AUTHOR ANECDOTE] marker fails only an essay whose status is
# not "draft": a draft may wait for its writer, a finished essay may not.
set -euo pipefail

lang_of() { # lang_of <file>: en or pt-BR
  local l; l="$(awk 'BEGIN{fm=0} /^---$/ {fm++; if (fm==2) exit; next} fm==1 && /^lang:/ {sub(/^lang: */, ""); gsub(/"/, ""); print; exit}' "$1")"
  case "$1" in *.pt-BR.md) l="${l:-pt-BR}" ;; esac
  echo "${l:-en}"
}

body_of() { # body_of <file>: the text between the front matter and the sources, without comments
  awk 'BEGIN{fm=0} /^---$/ && fm<2 {fm++; next} fm!=1' "$1" | awk '/^## (Sources|Fontes)/{exit} {print}' | grep -v '^<!--' || true
}

quoted_words() { # words between straight or curly double quotation marks, taken in pairs, plus block quotes
  sed 's/[“”]/"/g' | awk -F'"' '
    /^>/ { n += split($0, w, " ") - 1; next }
    { line = line " " $0 }
    END { m = split(line, part, "\""); for (i = 2; i <= m; i += 2) n += split(part[i], w, " "); print n + 0 }'
}

first_paragraph() { # the first paragraph of prose: not a heading, a note in italics, a quote or a reading time
  awk 'BEGIN{RS=""} !/^(#|\*|<|>|\||Estimated reading time|Leitura estimada)/ {print; exit}'
}

numbers_of() { # numbers_of <body>: every number with its separators removed, one per line, sorted
  printf '%s\n' "$1" | grep -vE '^(Estimated reading time|Leitura estimada)' | grep -oE '[0-9][0-9.,]*[0-9]|[0-9]' | tr -d '.,' | sort || true
}

check() { # check <file> <topics, comma separated or empty>; prints one line per rule
  local f="$1" topics="$2" bad=0 body words lang
  lang="$(lang_of "$f")"
  body="$(body_of "$f")"
  words="$(printf '%s\n' "$body" | wc -w)"
  say() { printf '  %-4s %-12s %s\n' "$1" "$2" "$3"; [ "$1" = ok ] || [ "$1" = note ] || bad=1; }

  # The words that each rule looks for, in the essay's language.
  local me doubt order lesson sources
  if [ "$lang" = pt-BR ]; then
    me="eu|meu|minha|meus|minhas|mim|comigo"
    doubt="não sei|que sei eu|não tenho certeza|não consigo dizer|não posso dizer|posso estar errado|talvez eu esteja errado|posso me contradizer|eu não conferi"
    order="você (deve|precisa|tem que|tem de)|vocês (devem|precisam)"
    lesson="conclusão|lições|lição|pontos-chave|resumo"
    sources="Fontes"
  else
    me="I|my|me|myself|mine"
    doubt="I do not know|I don't know|I cannot say|I can not say|I am not sure|I have not done|I have not checked|What do I know|I may contradict|I may be wrong"
    order="you (should|must|need to|have to)"
    lesson="conclusion|lessons?|takeaways?|key points"
    sources="Sources"
  fi

  # M1. "myself am the matter of my book": the writer is in it.
  local i; i="$(printf '%s\n' "$body" | grep -oiE "(^|[^[:alpha:]])($me)([^[:alpha:]]|$)" | wc -l)"
  if [ "$i" -ge 10 ]; then say ok first-person "$i uses of the first person ($lang)"; else say FAIL first-person "$i uses of the first person ($lang); an essay has its writer in it (at least 10)"; fi

  # M2. "I do not paint its being, I paint its passage": it has a date, and says so.
  if grep -qE '^date: *[0-9]{4}-[0-9]{2}-[0-9]{2}' "$f" && grep -qE '\b(19|20)[0-9]{2}\b' <<<"$body"; then say ok dated "a date in the front matter and a year in the text"
  else say FAIL dated "no date in the front matter, or no year in the text"; fi

  # M3. "What do I know?": it doubts at least once.
  local d; d="$(printf '%s\n' "$body" | tr '\n' ' ' | grep -oiE "$doubt" | wc -l)"
  if [ "$d" -ge 1 ]; then say ok doubt "$d sentences of doubt"; else say FAIL doubt "no sentence of doubt ($lang: ${doubt%%|*}, ...)"; fi

  # M4. "I do not teach; I only relate": no order to the reader, no lesson for a heading.
  local t; t="$(printf '%s\n' "$body" | tr '\n' ' ' | grep -oiE "\b($order)\b" | wc -l)"
  if [ "$t" -eq 0 ] && ! grep -qiE "^#+ *($lesson)" <<<"$body"; then say ok no-lesson "no order to the reader, no heading of lessons"
  else say FAIL no-lesson "$t orders to the reader, or a heading of lessons"; fi

  # M5. "I do not number my borrowings, I weigh them", and "not before but after me": the
  # quoted words (between double quotation marks, taken in pairs, and in block quotes) are a small
  # part, and the first paragraph of prose is the writer's own.
  local q first; q="$(printf '%s\n' "$body" | quoted_words)"
  first="$(printf '%s\n' "$body" | first_paragraph)"
  if [ "$words" -gt 0 ] && [ $((q * 100 / words)) -le 20 ]; then say ok borrowings "$q of $words words are quoted ($((q * 100 / words))%)"
  else say FAIL borrowings "$q of $words words are quoted; more than 20% is a collection, not an essay"; fi
  if [ "$(printf '%s\n' "$first" | quoted_words)" -ge 5 ]; then say FAIL own-first "the first paragraph quotes somebody; the writer speaks first"; else say ok own-first "the first paragraph is the writer's own"; fi

  # M6. This repository's rule, not Montaigne's: what is borrowed is named.
  if grep -qE "^## $sources" "$f"; then say ok sources "a $sources section"; else say FAIL sources "no $sources section (AGENTS.md: cite at the point of use)"; fi

  # M7. The brief: each topic that was asked for is in the text. (A here-string, not a pipe: with
  # pipefail, `grep -q` closing a pipe early on a long essay would read as a missing topic.)
  if [ -n "$topics" ]; then
    local IFS=, miss=""
    for topic in $topics; do grep -qiF -- "$topic" <<<"$body" || miss="$miss $topic;"; done
    if [ -z "$miss" ]; then say ok topics "every topic of the brief is in the text"; else say FAIL topics "missing:$miss"; fi
  fi

  # M8. The writer's own experience is the writer's to write.
  local a status; a="$(printf '%s\n' "$body" | grep -o '\[AUTHOR ANECDOTE' | wc -l)"
  status="$(grep -m1 -E '^status:' "$f" | sed 's/^status: *//; s/"//g' || true)"
  if [ "$a" -eq 0 ]; then say ok anecdotes "no open marker"
  elif [ "$status" = draft ]; then say note anecdotes "$a open [AUTHOR ANECDOTE] markers; the essay is a draft until its writer fills them"
  else say FAIL anecdotes "$a open [AUTHOR ANECDOTE] markers in an essay whose status is \"$status\""; fi

  # M9. "myself am the matter of my book", at the start: the first paragraph of prose has the
  # writer in it. An essay opens on a case of the writer's, not on a definition (Montaigne; and
  # Dalrymple, who opens on what he saw; the skill, rule 14).
  if grep -qiE "(^|[^[:alpha:]])($me)([^[:alpha:]]|$)" <<<"$first"; then say ok case-first "the first paragraph has the writer in it"
  else say FAIL case-first "the first paragraph has no first person; open on the writer's case"; fi

  # M10. AGENTS.md, "Two languages": a translation says the same thing. When the front matter
  # names a `translation:`, that file exists, has as many open markers, and has the same numbers.
  local tr; tr="$(awk 'BEGIN{fm=0} /^---$/ {fm++; if (fm==2) exit; next} fm==1 && /^translation:/ {sub(/^translation: */, ""); gsub(/"/, ""); print; exit}' "$f")"
  if [ -n "$tr" ]; then
    local tf; tf="$(dirname "$f")/$tr"
    if [ ! -f "$tf" ]; then say FAIL translation "the translation $tr does not exist"
    else
      local tb ta diff; tb="$(body_of "$tf")"; ta="$(printf '%s\n' "$tb" | grep -o '\[AUTHOR ANECDOTE' | wc -l)"
      diff="$(comm -3 <(numbers_of "$body") <(numbers_of "$tb") | tr -d '\t' | sort -u | tr '\n' ' ')"
      if [ "$a" -ne "$ta" ]; then say FAIL translation "$a markers here, $ta in $tr"
      elif [ -n "$diff" ]; then say FAIL translation "numbers in one version only: $diff"
      else say ok translation "$tr has the same markers and the same numbers"; fi
    fi
  fi
  return "$bad"
}

self_test() {
  local d; d="$(mktemp -d)"; trap 'rm -rf "$d"' RETURN
  printf -- '---\ntitle: "x"\nstatus: draft\ndate: 2026-10-14\n---\n# Good\n\nIn 2026 I went to the sea and I saw my own doubt. I do not know why I went. My friend came with me, and I told him what I saw, and he told me what he saw, and I wrote it for myself.\n\n## Sources\n\n- none\n' >"$d/good.md"
  printf -- '---\ntitle: "x"\nstatus: final\n---\n# Bad\n\n"A long quotation of another person that opens the text before the writer." You should always do this. You must do that.\n\n## Conclusion\n\n**[AUTHOR ANECDOTE: x]**\n' >"$d/bad.md"
  printf -- '---\ntitle: "x"\nstatus: draft\ndate: 2026-10-25\nlang: pt-BR\ntranslation: good.md\n---\n# Bom\n\nEm 2026 eu fui ao mar e vi a minha própria dúvida. Eu não sei por que eu fui. Meu amigo foi comigo, e eu contei o que eu vi, e ele contou o que viu, e eu escrevi isso para mim, e para o meu caderno.\n\n## Fontes\n\n- nenhuma\n' >"$d/bom.pt-BR.md"
  printf -- '---\ntitle: "x"\nstatus: final\ndate: 2026-10-25\nlang: pt-BR\ntranslation: falta.md\n---\n# Ruim\n\n> Uma citação longa de outra pessoa que abre o texto antes de quem escreve.\n\nO mar é grande. Você deve ir ao mar. Você precisa ir em 2027.\n\n## Conclusão\n\n**[AUTHOR ANECDOTE: x]**\n' >"$d/ruim.pt-BR.md"
  check "$d/good.md" "sea" >/dev/null || { echo "essay-montaigne: self-test: a good essay was refused" >&2; exit 1; }
  check "$d/bom.pt-BR.md" "mar" >/dev/null || { echo "essay-montaigne: self-test: a good pt-BR essay was refused" >&2; check "$d/bom.pt-BR.md" "mar" >&2; exit 1; }
  local out rule; out="$(check "$d/bad.md" "sea" || true)"
  for rule in first-person dated doubt no-lesson own-first sources topics anecdotes case-first; do
    printf '%s\n' "$out" | grep -q "FAIL $rule" || { echo "essay-montaigne: self-test: the bad essay passed $rule" >&2; exit 1; }
  done
  out="$(check "$d/ruim.pt-BR.md" "praia" || true)"
  for rule in first-person doubt no-lesson sources topics anecdotes case-first translation; do
    printf '%s\n' "$out" | grep -q "FAIL $rule" || { echo "essay-montaigne: self-test: the bad pt-BR essay passed $rule" >&2; exit 1; }
  done
  echo "essay-montaigne: self-test ok: a good essay passes in each language, and a bad one fails nine rules in English and eight in pt-BR" >&2
}

topics=""
case "${1:-}" in
  --self-test) self_test; exit 0 ;;
  --topics) topics="${2:?essay-montaigne: --topics needs a list}"; shift 2 ;;
esac
# With no --topics, the brief is the essay's own: `topics: "a,b,c"` in its front matter.
[ -n "$topics" ] || [ ! -f "${1:-}" ] || topics="$(grep -m1 -E '^topics:' "$1" | sed 's/^topics: *//; s/^"//; s/"$//' || true)"
[ $# -eq 1 ] && [ -f "$1" ] || { echo "essay-montaigne: usage: scripts/essay-montaigne.sh [--topics a,b,c] <essay.md> | --self-test" >&2; exit 1; }
echo "essay-montaigne: $1 ($(lang_of "$1"))"
if check "$1" "$topics"; then echo "essay-montaigne: the countable rules hold. Now the reader's part: .claude/skills/essay-montaigne/SKILL.md"
else echo "essay-montaigne: failed" >&2; exit 1; fi
