#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
"""ouroboric — fetch the public ouroboric-dev repositories and show what changed since OUROBORIC.md.

OUROBORIC.md and OUROBORIC_RESEARCH.md are digests that an agent writes (`/update-ouroboric`).
Their header tables record each repository at a full commit hash. This script clones or updates
each repository into build/ouroboric/<repo>, then prints, per repository, the recorded commit, the
current one and the files that changed between them, so the agent reads only what is new.

    scripts/ouroboric.py              # fetch, then report changes against OUROBORIC.md
    scripts/ouroboric.py --self-test

ouroboric-dev/contact is private, so it is not in REPOS. Add a repository here when the
organisation publishes a new one.
"""

import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
REPOS = ["ouroboric", "yggdrasil", "asgard", ".github", "ouroboric-packages"]
ROW_RE = re.compile(
    r"ouroboric-dev/(" + "|".join(re.escape(r) for r in sorted(REPOS, key=len, reverse=True))
    + r")(?![A-Za-z0-9._-]).*?\b([0-9a-f]{40})\b"
)


def recorded(text: str) -> dict[str, str]:
    """The first full commit hash on each line that names ouroboric-dev/<repo>."""
    out: dict[str, str] = {}
    for line in text.splitlines():
        m = ROW_RE.search(line)
        if m and m.group(1) not in out:
            out[m.group(1)] = m.group(2)
    return out


def git(*args: str, cwd: Path | None = None) -> str:
    return subprocess.run(["git", *args], cwd=cwd, check=True, capture_output=True, text=True).stdout.strip()


def sync(repo: str, base: Path) -> Path:
    path = base / repo
    if (path / ".git").is_dir():
        git("fetch", "-q", "origin", cwd=path)
        git("reset", "-q", "--hard", "origin/HEAD", cwd=path)
    else:
        base.mkdir(parents=True, exist_ok=True)
        git("clone", "-q", f"https://github.com/ouroboric-dev/{repo}", str(path))
    return path


def main() -> int:
    if sys.argv[1:] == ["--self-test"]:
        text = (
            "| [ouroboric-dev/ouroboric](x) | `" + "a" * 40 + "` |\n| ouroboric-dev/nope | " + "b" * 40
            + "\n| ouroboric-dev/.github | " + "c" * 40 + "\n| ouroboric-dev/ouroboric-packages | " + "d" * 40
        )
        want = {"ouroboric": "a" * 40, ".github": "c" * 40, "ouroboric-packages": "d" * 40}
        assert recorded(text) == want, recorded(text)
        print("ouroboric: self-test passed", file=sys.stderr)
        return 0
    digest = ROOT / "OUROBORIC.md"
    old = recorded(digest.read_text()) if digest.exists() else {}
    for repo in REPOS:
        path = sync(repo, ROOT / "build" / "ouroboric")
        head = git("rev-parse", "HEAD", cwd=path)
        date = git("log", "-1", "--format=%cs", cwd=path)
        print(f"## ouroboric-dev/{repo}  {head}  ({date})")
        if repo not in old:
            print("  not in OUROBORIC.md yet: read all of it")
        elif old[repo] == head:
            print("  unchanged")
        else:
            try:
                changed = git("diff", "--name-status", old[repo], head, cwd=path)
            except subprocess.CalledProcessError:
                changed = f"  recorded {old[repo]} is not in the history: read all of it"
            print(f"  since {old[repo][:12]}:")
            print("\n".join("  " + line for line in changed.splitlines()) or "  (no file changes)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
