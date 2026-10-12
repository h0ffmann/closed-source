#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-only
# release — cut a release from main in one command (after h0ffmann/ww3-gpu's scripts/release.sh):
#   1. refuse unless on main, clean, and level with origin/main
#   2. refuse a version that isn't vMAJOR.MINOR.PATCH, already exists, or releases nothing new
#   3. tag and push; .github/workflows/release.yml builds the PDF, attaches it to a GitHub release
#      and, if the ZENODO_TOKEN secret is set, uploads only the PDF to a Zenodo *draft*
#   4. sign the tag when Git has a signing key (git config user.signingkey), else annotate it
#   just release 0.1.0 [--dry-run]   (= scripts/release.sh 0.1.0 [--dry-run])
set -euo pipefail
dry_run=0 version=""
for a in "$@"; do
  case "$a" in
    --dry-run) dry_run=1 ;;
    *) version="$a" ;;
  esac
done
[ -n "$version" ] || { echo "release: name the version, e.g. just release 0.1.0" >&2; exit 1; }
[ "$(git branch --show-current)" = main ] || { echo "release: check out main first" >&2; exit 1; }
[ -z "$(git status --porcelain --untracked-files=no)" ] || { echo "release: working tree is dirty" >&2; exit 1; }
git fetch -q --tags origin main
[ "$(git rev-parse HEAD)" = "$(git rev-parse origin/main)" ] \
  || { echo "release: main is not level with origin/main" >&2; exit 1; }
tag="v${version#v}"
[[ "$tag" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "release: '$version' is not MAJOR.MINOR.PATCH" >&2; exit 1; }
prev="$(git tag -l 'v*' --sort=-v:refname | head -1)"
if [ -n "$prev" ] && [ "$(git rev-list --count "$prev..HEAD")" -eq 0 ]; then
  echo "release: nothing new since $prev; every published release can become a permanent DOI" >&2
  exit 1
fi
if git rev-parse -q --verify "refs/tags/$tag" >/dev/null; then
  echo "release: tag $tag already exists" >&2
  exit 1
fi
sign=-a
if [ -n "$(git config --get user.signingkey || true)" ]; then sign=-s; fi
echo "release: $tag at $(git log -1 --format='%h %s') (previous: ${prev:-none})"
if [ "$dry_run" -eq 1 ]; then
  echo "+ git tag $sign $tag -m 'closed-source $tag'"
  echo "+ git push origin $tag"
  exit 0
fi
git tag "$sign" "$tag" -m "closed-source $tag"
git push origin "$tag"
echo "release: pushed $tag. Review the Zenodo draft, then publish it there to mint the DOI."
