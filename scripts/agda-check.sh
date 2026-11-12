#!/usr/bin/env bash
# agda-check: the Agda of this repository (agda/), in the flake's `agda` shell (`just agda`,
# .github/workflows/agda.yml). docs/4-ways-of-working/agda.md says what each module backs.
#   1. Every module checks under --safe (agda/closed-source.agda-lib), from agda/Everything.agda.
#   2. Self-test: each file in agda/SelfTest/ must fail (a postulate; a sentence over the limit).
#   3. Vale and Agda agree: the limits and the phrasal-verb table of .vale/styles/ste/ are the
#      ones that agda/ClosedSource/STE/ proves things about.
#
#   scripts/agda-check.sh
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
export LC_ALL=C.UTF-8
fail() { echo "agda-check: $1" >&2; exit 1; }

# Each module is listed in Everything.agda, so a module that is not there is not checked.
for f in $(cd agda && git ls-files 'ClosedSource/*.agda'); do
  m="${f%.agda}"; m="${m//\//.}"
  grep -qx "import $m" agda/Everything.agda || fail "$f is not imported by agda/Everything.agda"
done

echo "agda-check: type-checking agda/Everything.agda under --safe" >&2
(cd agda && agda Everything.agda) >&2 || fail "a module does not check"

for t in agda/SelfTest/*.agda; do
  ! (cd agda && agda "${t#agda/}") >/dev/null 2>&1 || fail "self-test: ${t} checked, and it must not"
done
echo "agda-check: self-test ok: Agda refused each file of agda/SelfTest/" >&2

# Vale and Agda agree.
rules=agda/ClosedSource/STE/Rules.agda
vmax() { sed -nE 's/^max: ([0-9]+)$/\1/p' ".vale/styles/ste/$1.yml"; }
[ "$(vmax SentenceLength)" = "$(sed -nE 's/^limit descriptive = ([0-9]+)$/\1/p' "$rules")" ] \
  || fail "the sentence limit of SentenceLength.yml is not 'limit descriptive' of $rules"
[ "$(vmax ParagraphLength)" = "$(sed -nE 's/^maxSentences = ([0-9]+)$/\1/p' "$rules")" ] \
  || fail "the paragraph limit of ParagraphLength.yml is not 'maxSentences' of $rules"
yaml_swaps() { sed -nE 's/^  ([a-z ]+): ([a-z ]+)$/\1 -> \2/p' .vale/styles/ste/PhrasalVerbs.yml | sort; }
agda_swaps() { grep -oE '\("[a-z ]+" , "[a-z ]+"\)' agda/ClosedSource/STE/PhrasalVerbs.agda \
  | sed -E 's/\("([a-z ]+)" , "([a-z ]+)"\)/\1 -> \2/' | sort; }
diff <(yaml_swaps) <(agda_swaps) >&2 \
  || fail "the table of PhrasalVerbs.yml (<) and of PhrasalVerbs.agda (>) differ"
[ "$(yaml_swaps | wc -l)" -gt 0 ] || fail "read no swap from PhrasalVerbs.yml"
echo "agda-check: Vale and Agda agree: 2 limits, $(yaml_swaps | wc -l) phrasal verbs" >&2
echo "agda-check: ok" >&2
