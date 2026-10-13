<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Tools and skills used

## Tools

| Tool | Used for |
|---|---|
| `add_repo`, `list_repos` | attaching this repository with push access; read access to the reference repositories |
| Bash, Read, Write, Edit | cloning, reading conventions, writing the paper and tooling, building the PDF |
| WebSearch, WebFetch | finding and fetching every cited source |
| GitHub (pull request, issue tools) | opening the draft pull request, assigning it, requesting review |
| `subscribe_pr_activity` | watching the pull request's CI and reviews |
| Project thread tools (`update_status`, `reply`) | the progress checklist and the reply in the project thread |

## Skills

No skill was invoked. The skills available in the session (document, slide and spreadsheet
skills, research and review skills, and several repository-specific skills from the owner's other
projects) did not match a Markdown-to-PDF paper build. Ouroboric's vendored writing skills
(`journalism-ap` for the `research` style) were applied as house rules from the Ouroboric writing
styles document, not loaded as skills; vendoring them is issue N6 in the readiness assessment.

## Agents

The first pull request's initial commit came from one session. The ASD-STE100 pass used three
sub-agents of that session, following picasso's two-pass method: two rewrote the paper in halves
(pass 1), and one checked the whole text against the rules and the original and wrote the new
section's STE text (pass 2). `scripts/ste_check.py` then checked mechanically that no citation,
quotation, number or marker changed. That script was later ported to Gleam: it is now
`tools/fabric ste-check`.

## Commands

`.claude/commands/ste100.md` is the `/ste100` command, copied from h0ffmann/picasso and adapted
for papers.
