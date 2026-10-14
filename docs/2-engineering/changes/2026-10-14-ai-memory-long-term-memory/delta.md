---
title: "ai-memory as the long-term memory: delta"
status: draft
date: 2026-10-14
related: [proposal.md, tasks.md, ../../../../MEMORY.md, ../../../../AGENTS.md]
style: reference
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Delta

## Added

**`.claude/settings.json`, by the owner (tasks.md, step 2).** The marketplace and the plugin, merged
into the file's top-level object:

```json
"extraKnownMarketplaces": {
  "ai-memory": {
    "source": { "source": "github", "repo": "akitaonrails/ai-memory", "ref": "v3.0.0" }
  }
},
"enabledPlugins": { "ai-memory@ai-memory": true }
```

**`MEMORY.md`, a section "Long-term memory: ai-memory".** After "Where the memory is".

## Modified

**`MEMORY.md`, the first paragraph.**

- Was: "Project memory in Claude is off for this project, so what an agent must know in the next
  session is in files in the repository."
- Is: "Project memory in Claude is off for this project. The long-term memory is ai-memory
  (below), and what a reader or an agent must know is in files in the repository."

**`AGENTS.md`, the map.**

- Was: "Where the memory of this repository is, and the code graph (graphify): `MEMORY.md`."
- Is: "Where the memory of this repository is, the long-term memory (ai-memory) and the code
  graph (graphify): `MEMORY.md`."

## Removed

Nothing.
