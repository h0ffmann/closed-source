# The coordinator's brief

The project's coordinator session started a thread session on the request and gave it this
brief. Verbatim.

```text
Do the user's request in the root message: set up Paper Fabric in h0ffmann/closed-source (attach with add_repo, push access) and open a PR with the first paper "Closed Source: The God that Failed", covering all ten points they listed.

Defaults where the ask forks:
- Toolchain: mirror Sandy Maguire's (isovector) book/paper setup: Markdown sources built to PDF with pandoc + LaTeX, Makefile-driven, BibTeX citations. Check his public repos to confirm the actual tooling before copying.
- Zenodo citation tooling: copy from h0ffmann/ww3-gpu, picasso or marola (whichever has it; attach read access). V0 release ships only the rendered PDF to Zenodo; do not actually publish a Zenodo deposit, just wire the tooling (CITATION.cff, .zenodo.json, release workflow).
- Ouroboric-dev patterns: read the ouroboric-dev repo/org to learn its conventions and apply them. Project memory is off, so record those patterns in a file in the repo (e.g. docs/) instead.
- "REA" is ambiguous; interpret it as reverse engineering (AI-assisted) unless the repos say otherwise, and state the interpretation in the PR.
- References must be real and verified (fetch each DOI/URL); never invent citations. For the 2026 OpenAI espionage case, use only verifiable sources and flag anything you can't confirm. Leave clearly marked placeholders for the author's personal chemo-RX anecdotes rather than fabricating them.
- Authors: Rob Kler, Bruno Valério, Hoffmann, affiliation Ouroboric DEV.
- Point 10: export the Claude project config (project instructions, thread brief, tools/skills used) into the PR, e.g. .claude/ folder.
Reply with the draft PR link and the list of issues blocking promotion to the ouroboric-dev org.
```
