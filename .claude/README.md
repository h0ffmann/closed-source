<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Claude project configuration export

This folder publishes the configuration that produced this repository's first pull request, as
the Paper Fabric charter's *learn in public* principle and the paper's AI-use statement promise.
It is a record, not a live config: Claude Code reads only `settings.json`, `commands/` and
`skills/` here.

| File | What it is |
|---|---|
| [`project/project.md`](project/project.md) | the Claude project: name, topic, visibility, memory and instruction settings |
| [`project/request.md`](project/request.md) | the author's request that started the work, verbatim |
| [`project/brief.md`](project/brief.md) | the coordinator's brief to the thread that did the work, verbatim |
| [`project/session.md`](project/session.md) | the session: environment, model, toolchain installed, repositories read |
| [`project/tools-and-skills.md`](project/tools-and-skills.md) | the tools and skills used, and how |
| [`settings.json`](settings.json) | Claude Code permissions for working in this repository, and the hooks that keep `README.easy.pt-BR.md` current |
| [`skills/`](skills/README.md) | the skills written for this repository (`readme-style`, `easy-pt-br`, `card-style`), their sources and their lock |
| [`commands/ste100.md`](commands/ste100.md) | `/ste100`: rewrite prose to ASD-STE100 |
| [`commands/note.md`](commands/note.md) | `/note`: make Zettelkasten notes in `notes/` (SMART_NOTE_POLICY.md) |
| [`commands/update-ouroboric.md`](commands/update-ouroboric.md) | `/update-ouroboric`: refresh `OUROBORIC.md` and `OUROBORIC_RESEARCH.md` from the ouroboric-dev repositories |

Nothing here is secret. Tokens, e-mail addresses and the harness's own system prompt are left
out; the session summary describes the harness instead of quoting it.
