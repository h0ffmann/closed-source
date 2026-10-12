---
title: "Ouroboric research index"
status: draft
date: 2026-10-12
related: [AGENTS.md, .claude/commands/update-ouroboric.md, scripts/ouroboric.py]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# OUROBORIC RESEARCH

An index of the curated lists, research briefs, source lists, borrowed-idea records, name checks, benchmarks and external references in the public ouroboric-dev repositories, for Paper Fabric. Ouroboric's own repositories are the source of truth. The digest of everything else is in `OUROBORIC.md`.

| Repository | Commit (full hash) | Commit date | Date read |
|---|---|---|---|
| `ouroboric-dev/ouroboric` | `b355b1d52d6906f80447fe84283f705403533d0b` | 2026-10-12 | 2026-10-12 |
| `ouroboric-dev/yggdrasil` | `ffedea7c476d10c04498d5db74596a72a5ab0cbb` | 2026-10-12 | 2026-10-12 |
| `ouroboric-dev/asgard` | `1acab205610d3c9d816076bf83baa0b333c4dd08` | 2026-10-12 | 2026-10-12 |
| `ouroboric-dev/.github` | `b799793319aaf4138e9733bcdda63b7a31cd7eb4` | 2026-10-12 | 2026-10-12 |
| `ouroboric-dev/ouroboric-packages` | `fb4ae8402835bee6291bf708c9b1dca99503b405` | 2026-10-12 | 2026-10-12 |

- `ouroboric-dev/contact` is private. This index does not cover it.
- Ouroboric's names and logos are trademarks. They are not licensed here.
- Every link below is pinned to the commit in the table. The "Notable items" are copied from the file with the URL the file gives. When the file gives no URL, the item has none here. This index adds no URLs of its own.
- Facts in these files are as of their research dates (2026-10-10 to 2026-10-12): star counts, versions and prices change.
- The private benchmark repo (frozen brief and hidden suite) is deliberately private and is not indexed.

## Contents

1. [Curated source lists](#1-curated-source-lists)
2. [Research briefs (Yggdrasil)](#2-research-briefs-yggdrasil)
3. [Company research: name checks](#3-company-research-name-checks)
4. [Borrowed-idea records and prior art](#4-borrowed-idea-records-and-prior-art)
5. [Vendored skills and tool lists](#5-vendored-skills-and-tool-lists)
6. [Benchmarks, checklists and assessments](#6-benchmarks-checklists-and-assessments)
7. [Licence and legal references](#7-licence-and-legal-references)
8. [Brand and design research](#8-brand-and-design-research)
9. [Reviews and audits](#9-reviews-and-audits)
10. [Research folders (indexes)](#10-research-folders-indexes)

---

## 1. Curated source lists

### 1.1 Yggdrasil learning sources: curated list

- **File:** [yggdrasil:docs/5-research/curation.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/5-research/curation.md)
- **What it is:** about 110 open-source repositories checked live on GitHub on 2026-10-11 (stars, activity, licence, archived or not), sorted into ten categories with a tier (MUST, WATCH, SKIP) and "what to borrow" for each Yggdrasil layer. It also has a close evaluation of super-board, a top-10 reading order, eight non-OSS readings and a licence quick-reference. Tiers and borrow notes are marked **[ANALYSIS]**. It warns that 2026 star counts "are inflated and tell you little about quality."

**Section 1, evaluation of super-board:** [EricTechPro/super-board](https://github.com/EricTechPro/super-board) (MIT). Verdict: "worth watching ... Do not adopt it as a dependency." Ideas borrowed: the merge gate in a lock pinned to the reviewed SHA; one worker per lane; "Review remembers" (findings with stable ids and file:line proof); fail closed on missing evidence; behavioural evals for the harness; preflight guards from incidents; a cheap difficulty router.

**MUST-tier items, by category** (name and URL as in the file):

| Category | MUST items |
|---|---|
| 2.1 Orchestrators over CLIs | [gastownhall/gastown](https://github.com/gastownhall/gastown), [gastownhall/gascity](https://github.com/gastownhall/gascity), [gastownhall/beads](https://github.com/gastownhall/beads), [OpenHands/OpenHands](https://github.com/OpenHands/OpenHands) (read), [SWE-agent/mini-swe-agent](https://github.com/SWE-agent/mini-swe-agent) (control baseline), [Aider-AI/aider](https://github.com/Aider-AI/aider) (repo-map only), [anomalyco/opencode](https://github.com/anomalyco/opencode), [openai/codex](https://github.com/openai/codex), [agentclientprotocol/agent-client-protocol](https://github.com/agentclientprotocol/agent-client-protocol) |
| 2.2 Harness-engineering learning | [walkinglabs/learn-harness-engineering](https://github.com/walkinglabs/learn-harness-engineering), [humanlayer/12-factor-agents](https://github.com/humanlayer/12-factor-agents), [anthropics/claude-code](https://github.com/anthropics/claude-code) (read only; no OSS licence), [anthropics/claude-agent-sdk-python](https://github.com/anthropics/claude-agent-sdk-python) / [-typescript](https://github.com/anthropics/claude-agent-sdk-typescript), [obra/superpowers](https://github.com/obra/superpowers) |
| 2.3 Spec-driven development | [github/spec-kit](https://github.com/github/spec-kit), [Fission-AI/OpenSpec](https://github.com/Fission-AI/OpenSpec) |
| 2.4 Sandboxing | [devcontainers/cli](https://github.com/devcontainers/cli), [podman-container-tools/podman](https://github.com/podman-container-tools/podman), [anthropics/sandbox-runtime](https://github.com/anthropics/sandbox-runtime) |
| 2.5 Evals and benchmarks | [harbor-framework/harbor](https://github.com/harbor-framework/harbor), [harbor-framework/terminal-bench-2](https://github.com/harbor-framework/terminal-bench-2), [SWE-bench/SWE-bench](https://github.com/SWE-bench/SWE-bench) (concepts), [vercel/next-evals-oss](https://github.com/vercel/next-evals-oss), [UKGovernmentBEIS/inspect_ai](https://github.com/UKGovernmentBEIS/inspect_ai), [microsoft/playwright](https://github.com/microsoft/playwright) / [playwright-mcp](https://github.com/microsoft/playwright-mcp) |
| 2.6 Observability | [open-telemetry/semantic-conventions-genai](https://github.com/open-telemetry/semantic-conventions-genai), [langfuse/langfuse](https://github.com/langfuse/langfuse) |
| 2.7 Code-graph routing | [Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify), [DeusData/codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp) (with [preprint](https://arxiv.org/abs/2603.27277)), [Aider repo-map](https://github.com/Aider-AI/aider), [tree-sitter/tree-sitter](https://github.com/tree-sitter/tree-sitter) / [go-tree-sitter](https://github.com/tree-sitter/go-tree-sitter) |
| 2.8 Durable workflow engines | [temporalio/temporal](https://github.com/temporalio/temporal) (concepts), [dbos-inc/dbos-transact-golang](https://github.com/dbos-inc/dbos-transact-golang), [langchain-ai/langgraph](https://github.com/langchain-ai/langgraph) (concepts) |
| 2.9 Go agent libraries | [modelcontextprotocol/go-sdk](https://github.com/modelcontextprotocol/go-sdk), [anthropics/anthropic-sdk-go](https://github.com/anthropics/anthropic-sdk-go), [charmbracelet/bubbletea](https://github.com/charmbracelet/bubbletea) (when the UI is built) |
| 2.10 Game-dev tooling | [phaserjs/phaser](https://github.com/phaserjs/phaser) (for the game realm); [hi-godot/godot-ai](https://github.com/hi-godot/godot-ai) (WATCH, MUST when the realm starts) |

**Selected WATCH and SKIP items with a stated lesson:** [smtg-ai/claude-squad](https://github.com/smtg-ai/claude-squad) (AGPL-3.0: read, do not copy); [charmbracelet/crush](https://github.com/charmbracelet/crush) (FSL: read only); [coder/agentapi](https://github.com/coder/agentapi) (archived; "Read *why* TTY-scraping was abandoned"); [BloopAI/vibe-kanban](https://github.com/BloopAI/vibe-kanban) (sunsetting; [post](https://www.vibekanban.com/blog/shutdown)); [dagger/container-use](https://github.com/dagger/container-use) (borrow the idea, not the dependency); [eyaltoledano/claude-task-master](https://github.com/eyaltoledano/claude-task-master) (Commons Clause: do not vendor); [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) (CC BY-NC-ND: do not copy); [ruvnet/ruflo](https://github.com/ruvnet/ruflo) ("Hype is higher than substance"); [Arize-ai/phoenix](https://github.com/Arize-ai/phoenix) (ELv2); [restatedev/restate](https://github.com/restatedev/restate) (BSL 1.1); [inngest/inngest](https://github.com/inngest/inngest) (SSPL); [oraios/serena](https://github.com/oraios/serena) (GPL app, MIT SolidLSP); [anthropics/claude-code ralph-wiggum plugin](https://github.com/anthropics/claude-code/tree/main/plugins); [kubernetes-sigs/agent-sandbox](https://github.com/kubernetes-sigs/agent-sandbox); [e2b-dev/E2B](https://github.com/e2b-dev/E2B).

**Awesome-style lists it points to:** [walkinglabs/awesome-harness-engineering](https://github.com/walkinglabs/awesome-harness-engineering) (CC0), [ai-boost/awesome-harness-engineering](https://github.com/ai-boost/awesome-harness-engineering) (CC0), [bradAGI/awesome-cli-coding-agents](https://github.com/bradAGI/awesome-cli-coding-agents) (no licence stated), [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) (CC BY-NC-ND 4.0).

**Section 4, key non-OSS reading (8):** Anthropic, [Building effective agents](https://www.anthropic.com/research/building-effective-agents) (2024-12-19); Anthropic, [Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) (2025-09-29); Anthropic, [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) (2025-11-26); Anthropic, [Harness design for long-running application development](https://www.anthropic.com/engineering/harness-design-long-running-apps) (2026-03-24); Anthropic, [Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents) (2026-01-09); OpenAI, [Harness engineering](https://openai.com/index/harness-engineering/) (2026); Geoffrey Huntley, [Ralph Wiggum as a "software engineer"](https://ghuntley.com/ralph/) (2025-07-14); Steve Yegge's Gas Town series on [Medium](https://steve-yegge.medium.com/) (2026).

**Section 3, top 10 in order:** learn-harness-engineering (L13, L14); the two Anthropic harness posts; mini-swe-agent; openai/codex crates; gascity then gastown; harbor plus terminal-bench-2; Temporal concepts plus dbos-transact-golang; Aider repo-map, graphify, codebase-memory-mcp; spec-kit compared with OpenSpec; super-board's merge gate plus sandbox-runtime.

**Section 5, licence quick-reference:** see [7.3](#73-licence-quick-reference-for-borrowing).

---

## 2. Research briefs (Yggdrasil)

Six briefs in `yggdrasil:docs/5-research/`, style `research`, status `draft`. The readiness assessment cites them as "six briefs, cited" (RB-16).

### 2.1 Harness engineering

- **File:** [yggdrasil:docs/5-research/research-harness.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/5-research/research-harness.md) (2026-10-10)
- **What it is:** definition of harness engineering; 15 core patterns (initializer vs coding agent, JSON feature list, progress files, browser end-to-end checks, `init.sh`, AGENTS.md as a map, mechanical enforcement, garbage collection, context resets vs compaction, maker–checker, parallel agents, test-harness design, tools/ACI, runtime middleware, Claude Code building blocks); proven vs speculative claims; a failure-mode table; security risks with real incidents; a minimum security baseline; a source index. openai.com was read through a text-extraction proxy because of HTTP 403.
- **Notable items:** [walkinglabs/learn-harness-engineering](https://github.com/walkinglabs/learn-harness-engineering); [anthropics/cwc-long-running-agents](https://github.com/anthropics/cwc-long-running-agents); Anthropic engineering posts: [effective harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents), [harness design](https://www.anthropic.com/engineering/harness-design-long-running-apps), [building a C compiler](https://www.anthropic.com/engineering/building-c-compiler), [managed agents](https://www.anthropic.com/engineering/managed-agents), [April 23 postmortem](https://www.anthropic.com/engineering/april-23-postmortem), [auto mode](https://www.anthropic.com/engineering/claude-code-auto-mode), [how we contain Claude](https://www.anthropic.com/engineering/how-we-contain-claude), [sandboxing](https://www.anthropic.com/engineering/claude-code-sandboxing), [demystifying evals](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents), [context engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents), [writing tools](https://www.anthropic.com/engineering/writing-tools-for-agents), [multi-agent research](https://www.anthropic.com/engineering/multi-agent-research-system), [building effective agents](https://www.anthropic.com/engineering/building-effective-agents); Claude Code docs: [best practices](https://code.claude.com/docs/en/best-practices), [hooks](https://code.claude.com/docs/en/hooks), [subagents](https://code.claude.com/docs/en/sub-agents), [skills](https://code.claude.com/docs/en/skills), [headless](https://code.claude.com/docs/en/headless); [OpenAI, Harness engineering](https://openai.com/index/harness-engineering/); [Fowler/Böckeler, Harness engineering](https://martinfowler.com/articles/harness-engineering.html); [LangChain](https://www.langchain.com/blog/improving-deep-agents-with-harness-engineering); [Cursor](https://cursor.com/blog/continually-improving-agent-harness); security: [Willison, lethal trifecta](https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/), [Invariant Labs, GitHub MCP](https://invariantlabs.ai/blog/mcp-github-vulnerability), [GitGuardian, s1ngularity](https://blog.gitguardian.com/the-nx-s1ngularity-attack-inside-the-credential-leak/), [Wiz, s1ngularity](https://www.wiz.io/de-de/blog/s1ngularitys-aftermath), [eWeek, Replit](https://www.eweek.com/news/replit-ai-coding-assistant-failure/).

### 2.2 Loop engineering, graph engineering and software factories

- **File:** [yggdrasil:docs/5-research/research-loops-graphs.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/5-research/research-loops-graphs.md) (2026-10-10)
- **What it is:** a brief with evidence labels ([PROVEN], [CREDIBLE], [EARLY / HYPE], [ANALYSIS]). Covers loop engineering (Ralph loop, Claude Code loop primitives, evaluator-optimizer, backpressure, stop conditions), graph engineering (Anthropic patterns, Stripe blueprints, LangGraph, Claude Code orchestration), a table of real software factories, SDD tooling with a critical evaluation, a maturity framing, genericity per domain (web, games, mobile) and a "core plus domain packs" recommendation, and a 10-item reading order.
- **Notable items:** [Osmani, Loop engineering](https://addyosmani.com/blog/loop-engineering/); [Macedo, arXiv 2607.00038](https://huggingface.co/papers/2607.00038); [Huntley, Ralph](https://ghuntley.com/ralph/); [Thoughtworks Radar, Ralph loop](https://www.thoughtworks.com/radar/techniques/ralph-loop); [Claude Code ralph-wiggum plugin](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum); Claude Code docs ([goal](https://code.claude.com/docs/en/goal), [scheduled tasks](https://code.claude.com/docs/en/scheduled-tasks), [agent loop](https://code.claude.com/docs/en/agent-sdk/agent-loop), [routines](https://code.claude.com/docs/en/routines), [agents](https://code.claude.com/docs/en/agents), [agent teams](https://code.claude.com/docs/en/agent-teams), [workflows](https://code.claude.com/docs/en/workflows), [checkpointing](https://code.claude.com/docs/en/checkpointing), [Agent SDK overview](https://code.claude.com/docs/en/agent-sdk/overview)); [Building agents with the Claude Agent SDK](https://claude.com/blog/building-agents-with-the-claude-agent-sdk); [Spotify Honk, part 3](https://engineering.atspotify.com/2025/12/feedback-loops-background-coding-agents-part-3); [Stripe Minions part 2](https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents-part-2) and [part 1](https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents); [aman.ai loop and graph primer](https://aman.ai/primers/ai/loop-and-graph-engineering/); [arXiv 2604.11378](https://arxiv.org/pdf/2604.11378); LangGraph docs ([workflows](https://docs.langchain.com/oss/python/langgraph/workflows-agents), [durable execution](https://docs.langchain.com/oss/python/langgraph/durable-execution), [interrupts](https://docs.langchain.com/oss/python/langgraph/interrupts)); [langchain-ai/deepagents](https://github.com/langchain-ai/deepagents); [Kiro specs](https://kiro.dev/docs/specs/); [StrongDM factory](https://factory.strongdm.ai/) and [Willison on it](https://simonwillison.net/2026/Feb/7/software-factory/); [InfoQ on OpenAI harness engineering](https://www.infoq.com/news/2026/02/openai-harness-engineering-codex); [Böckeler memo](https://www.martinfowler.com/articles/exploring-gen-ai/harness-engineering-memo.html); [Böckeler on SDD tools](https://www.martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html); [anthropics/claudes-c-compiler](https://github.com/anthropics/claudes-c-compiler); [Phaser Game Agent](https://phaser.io/news/2026/06/phaser-game-agent); [Willison, five levels](https://simonwillison.net/2026/Jan/28/the-five-levels/); [METR RCT via TechCrunch](https://techcrunch.com/2025/07/11/ai-coding-tools-may-not-speed-up-every-developer-study-shows); [GameGen-Verifier, arXiv 2605.07442](https://arxiv.org/abs/2605.07442); [TITAN, arXiv 2509.22170](https://arxiv.org/abs/2509.22170); [Playwright test agents](https://playwright.dev/docs/test-agents); [XcodeBuildMCP workshop](https://sentry.io/resources/xcodebuildmcp-workshop/); [Maestro and coding agents](https://maestro.dev/blog/mobile-ui-testing-with-coding-agents); [Expo MCP](https://expo.dev/changelog/mcp-build-and-workflows).

### 2.3 Orchestrator language and stack

- **File:** [yggdrasil:docs/5-research/research-stack.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/5-research/research-stack.md) (2026-10-10)
- **What it is:** what real agent tools are written in (with verified languages); SDK availability per language (Claude Agent SDK, Anthropic, OpenAI, OpenRouter, MCP, Temporal, container clients, TUIs); a scored comparison of Go, TypeScript, Python, Rust, Elixir/BEAM and Java + Pekko; a Go + workflow-engine variant; per-option detail including the Akka licence change to BSL and Pekko as the Apache fork; security notes for the design. Bottom line [ANALYSIS]: Go.
- **Notable items:** [Pragmatic Engineer, how Claude Code is built](https://newsletter.pragmaticengineer.com/p/how-claude-code-is-built); [codex discussion #1174](https://github.com/openai/codex/discussions/1174); [OpenCode CLI docs](https://opencode.ai/docs/cli/); [strongdm/attractor](https://github.com/strongdm/attractor); [Ronacher, agentic coding](https://lucumr.pocoo.org/2025/6/12/agentic-coding/); [AutoCodeBench, arXiv 2508.09101](https://arxiv.org/html/2508.09101); [Valim, why Elixir](https://dashbit.co/blog/why-elixir-best-language-for-ai); [Akka BSL FAQ](https://akka.io/bsl-license-faq); [apache/pekko](https://github.com/apache/pekko); [JetBrains/koog](https://github.com/JetBrains/koog); [langchain4j](https://github.com/langchain4j/langchain4j); [MCP SDK tiers](https://modelcontextprotocol.io/docs/sdk); [Temporal SDKs](https://docs.temporal.io/encyclopedia/temporal-sdks); [Temporal dev server](https://docs.temporal.io/cli/server); [Podman system service](https://docs.podman.io/en/latest/markdown/podman-system-service.1.html); [Bun executables](https://bun.com/docs/bundler/executables); [Go os/exec](https://pkg.go.dev/os/exec); [MuonTrap](https://github.com/fhunleth/muontrap).

### 2.4 Web SaaS stack for the web realm

- **File:** [yggdrasil:docs/5-research/research-web-stack.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/5-research/research-web-stack.md) (2026-10-11)
- **What it is:** what AI app builders generate by default; evidence on agent proficiency per framework; a scored comparison of seven options for client gallery lite; storage and image pipeline (uploads, thumbnails, download-all, local S3 options); the security track record of Next.js and others and why it matters for a factory that pins versions; npm versions on 2026-10-11; a list of unverified items. Recommendation [ANALYSIS]: React + Vite + TanStack SPA with a Go API; Next.js as a control pack; do not use MinIO (archived); use SeaweedFS locally.
- **Notable items:** [Lovable FAQ](https://docs.lovable.dev/introduction/faq); [Lovable on TanStack Start](https://lovable.dev/blog/building-apps-using-tanstack-start); [v0 FAQ](https://v0.app/docs/faqs); [Amplifying, coding agents by framework](https://s.amplifying.ai/coding-agents/frameworks); [Next.js agent evals](https://nextjs.org/evals); [Next.js AI agents guide](https://nextjs.org/docs/app/guides/ai-agents); [Next.js MCP guide](https://nextjs.org/docs/app/guides/mcp); [TanStack MCP](https://tanstack.com/mcp/latest/docs); [Svelte AI tools](https://svelte.dev/docs/ai/tools); [Laravel Boost](https://laravel.com/docs/13.x/boost); [shadcn MCP](https://ui.shadcn.com/docs/mcp); [State of JS 2025 via InfoQ](https://www.infoq.com/news/2026/03/state-of-js-survey-2025); [Stack Overflow 2025](https://survey.stackoverflow.co/2025/technology); [Pixieset Client Gallery](https://pixieset.com/client-gallery/); [Uppy AWS S3](https://uppy.io/docs/aws-s3/); [imgproxy](https://github.com/imgproxy/imgproxy); [vipsgen](https://github.com/cshum/vipsgen); [minio/minio](https://github.com/minio/minio); [SeaweedFS S3 API](https://github.com/seaweedfs/seaweedfs/wiki/Amazon-S3-API); [Garage S3 compatibility](https://garagehq.deuxfleurs.fr/documentation/reference-manual/s3-compatibility/); [GHSA-f82v-jwr5-mffw (CVE-2025-29927)](https://github.com/vercel/next.js/security/advisories/GHSA-f82v-jwr5-mffw); [discoverer write-up](https://zhero-web-sec.github.io/research-and-things/nextjs-and-the-corrupt-middleware); [React2Shell advisory](https://react.dev/blog/2025/12/03/critical-security-vulnerability-in-react-server-components); [Next.js CVE-2025-66478](https://nextjs.org/blog/CVE-2025-66478); [AWS on React2Shell exploitation](https://aws.amazon.com/blogs/security/china-nexus-cyber-threat-groups-rapidly-exploit-react2shell-vulnerability-cve-2025-55182/); [Next.js security release program](https://nextjs.org/blog/next-security-release-program); [Next.js advisories](https://github.com/vercel/next.js/security/advisories); [sharp advisories](https://github.com/lovell/sharp/security/advisories); [Supabase image transformations](https://supabase.com/docs/guides/storage/serving/image-transformations); [CVE-2025-48757 record](https://cvemon.intruder.io/cves/CVE-2025-48757).

### 2.5 Low-cost hosting

- **File:** [yggdrasil:docs/5-research/research-hosting.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/5-research/research-hosting.md) (2026-10-11)
- **What it is:** free tiers and prices for databases, object storage, compute and static hosts; image-resizing options; worked monthly cost estimates for two scenarios and three setups; gotchas (free tiers that pause or delete data, commercial-use limits, egress surprise bills, spending caps per provider); items to re-check. Each figure is marked verified [V] or unverified [U]. Conclusion [ANALYSIS]: "Egress decides everything".
- **Notable items (pricing and policy pages as listed):** https://neon.com/pricing · https://supabase.com/pricing · https://supabase.com/docs/guides/platform/free-project-pausing · https://turso.tech/pricing · https://developers.cloudflare.com/d1/platform/pricing/ · https://www.prisma.io/pricing · https://xata.io/pricing · https://aiven.io/free-postgresql-database · https://developers.cloudflare.com/r2/pricing/ · https://www.backblaze.com/cloud-storage/pricing · https://wasabi.com/pricing · https://aws.amazon.com/s3/pricing/ · https://www.hetzner.com/storage/object-storage · https://cloud.google.com/run/pricing · https://docs.fly.io/about/pricing · https://render.com/docs/free · https://railway.com/pricing · https://www.koyeb.com/pricing · https://www.hetzner.com/cloud/cost-optimized · https://developers.cloudflare.com/containers/pricing/ · https://developers.cloudflare.com/pages/platform/limits/ · https://www.netlify.com/pricing/ · https://vercel.com/docs/limits/fair-use-guidelines · https://developers.cloudflare.com/images/pricing/

---

## 3. Company research: name checks

- **File:** [ouroboric:docs/5-research/2026-10-12-name-checks.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/5-research/2026-10-12-name-checks.md)
- **What it is:** checks for readiness item RB-06 on 2026-10-12: the domain (RDAP), package registries (npm, PyPI, crates.io, Docker Hub, Homebrew), GitHub, and a trademark web screening ("not a clearance search") for Ouroboric, Yggdrasil, Asgard, `ygg` and the module names; a correction about the Docker Hub method; analysis; four decisions.
- **Notable items (as named; the file gives no URLs):** the `.dev` registry's RDAP service, `pubapi.registry.google`; Justia's trademark index (OROBOROUS, US serial 87605000; ASGARD SOFTWARE, US 1901503, cancelled); UK IPO Trade Mark Journal 2025/029 (Asgard Analytics, UK00004230292); IP Australia (Asgard Capital Management); USPTO and EUIPO through TMview (for the formal search before launch); the Yggdrasil Network (name collision).

---

## 4. Borrowed-idea records and prior art

### 4.1 Journal: curating sources and borrowed ideas

- **File:** [ouroboric:docs/6-journal/2026-10-11-curating-sources-and-borrowed-ideas.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-curating-sources-and-borrowed-ideas.md)
- **What it is:** the decision record behind `curation.md`: judge by substance, treat stars as reach; do not depend on super-board, but take its merge gate and review design. Four ideas went into the v0 spec: the merge gate; typed findings; Harbor-compatible benchmarks; native headless protocols (codex app-server, ACP next) and routing edges tagged `extracted` vs `inferred`. Lesson: "Licences decide what you can borrow."
- **Notable items:** super-board; links to [curation.md](https://github.com/ouroboric-dev/yggdrasil/blob/main/docs/5-research/curation.md) and spec sections (as given in the file, on `main`).

### 4.2 v0 spec §17 prior art and §18 decision log

- **File:** [yggdrasil:docs/2-engineering/specs/2026-10-11-yggdrasil-v0-spec.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/2-engineering/specs/2026-10-11-yggdrasil-v0-spec.md) (§17, §18; also §8 and §10.4)
- **What it is:** §17 is a table of "what we take" from each prior project, plus the licence rule for borrowing. §18 is the decision log with the alternatives considered (orchestrator, language, frameworks, sandbox, topology, autonomy, stack, hosting, names, merge safety, findings, benchmark format, process, skills and more).
- **Notable items:** Anthropic long-running agent harnesses; OpenAI harness engineering; StrongDM software factory; Stripe blueprints; Gas Town (and its Refinery); MetaGPT, ChatDev; Spec Kit; Superpowers; container-use; OpenHands; marola (MIP-0063, 0070, 0076, 0084, 0085); super-board; Harbor / Terminal-Bench 2; graphify, codebase-memory-mcp; openai/codex. URLs given in the spec: [MIP-0084](https://github.com/marola-dev/marola/blob/main/docs/MIPs/MIP-0084-zero-setup-routing.md), [MIP-0085](https://github.com/marola-dev/marola/blob/main/docs/MIPs/MIP-0085-routing-index-family.md), [MIP-0063](https://github.com/marola-dev/marola/blob/main/docs/MIPs/MIP-0063-github-issue-tracking-standard.md).

### 4.3 Journal entries that record borrowed or rejected ideas

| File | What it records | External references given |
|---|---|---|
| [2026-10-10-what-harness-loop-graph-mean.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-10-what-harness-loop-graph-mean.md) | working definitions of harness, loop, graph; two findings that shaped the design | walkinglabs/learn-harness-engineering; Anthropic, OpenAI, Thoughtworks, StrongDM, Stripe (no URLs) |
| [2026-10-10-spec-kit-and-superpowers.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-10-spec-kit-and-superpowers.md) | "Borrow, then plug in" | Spec Kit, Superpowers |
| [2026-10-10-own-orchestrator-not-a-framework.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-10-own-orchestrator-not-a-framework.md) | own orchestrator; frameworks rejected | LangGraph.js, CrewAI, AutoGen, ADK, Mastra; prior art Gas Town, MetaGPT, ChatDev; OpenHands; container-use |
| [2026-10-10-go-vs-pekko.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-10-go-vs-pekko.md) | Go chosen | Gas Town, Beads, Claude Squad, Crush, Dagger, container-use; Akka/Pekko |
| [2026-10-11-progress-tracking.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-progress-tracking.md) | MIP-0063 model as a one-way projection; Beads rejected | [MIP-0063](https://github.com/marola-dev/marola/blob/main/docs/MIPs/MIP-0063-github-issue-tracking-standard.md) |
| [2026-10-11-routing-needs-a-bench.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-routing-needs-a-bench.md) | routing bundles, measured by a bench | [MIP-0084](https://github.com/marola-dev/marola/blob/main/docs/MIPs/MIP-0084-zero-setup-routing.md), [MIP-0085](https://github.com/marola-dev/marola/blob/main/docs/MIPs/MIP-0085-routing-index-family.md) |
| [2026-10-11-identities-orgs-and-open-source.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-identities-orgs-and-open-source.md) | PR bot and merge bot split | marola's MIP-0086 (no URL) |
| [2026-10-11-umbrella-tree-and-git-hooks.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-umbrella-tree-and-git-hooks.md) | recursive tree inspired by marola's umbrella repo | marola (no URL) |
| [2026-10-11-diagrams-as-code.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-diagrams-as-code.md) | diagrams rendered through a self-hosted Kroki, as in marola | marola (no URL) |
| [2026-10-11-sdd-process-and-docs-standard.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-sdd-process-and-docs-standard.md) | tool-agnostic SDD; Ponytail; renderer choice | Spec Kit, OpenSpec, Superpowers, BMAD; Material for MkDocs, Zensical, Starlight, Docusaurus; an independent JetBrains test (no URL) |
| [2026-10-11-web-stack-react-go-vs-nextjs.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-web-stack-react-go-vs-nextjs.md) | React + Go chosen | CVE-2025-29927 (no URL) |
| [2026-10-11-choosing-a-licence.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-choosing-a-licence.md) | licence survey of agent tools | OpenHands, OpenCode, Codex CLI, Goose, Aider, Spec Kit (MIT/Apache); Claude Squad, Grafana (AGPL); Crush (FSL) |

### 4.4 Ways-of-working docs that borrow from outside

| File | Borrowed from | URLs given |
|---|---|---|
| [ouroboric:docs/4-ways-of-working/diagrams.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/4-ways-of-working/diagrams.md) | marola's diagram pattern; Kroki | [Kroki](https://kroki.io), [marola DIAGRAMS.md](https://github.com/marola-dev/marola/blob/main/docs/3-Ways-of-working/DIAGRAMS.md) |
| [ouroboric:docs/4-ways-of-working/docs-standard.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/4-ways-of-working/docs-standard.md) | Diátaxis; marola's `prepare-docs.sh` aggregation; Zensical | [Diátaxis](https://diataxis.fr/) |
| [ouroboric:docs/4-ways-of-working/spec-driven-development.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/4-ways-of-working/spec-driven-development.md) | OpenSpec-style change proposals; Spec Kit, OpenSpec, BMAD, Superpowers as strategies; Ponytail | none external |
| [ouroboric:docs/4-ways-of-working/writing-styles.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/4-ways-of-working/writing-styles.md) | ASD-STE100, Google developer style, GOV.UK, AP, Orwell, RFC 2119, Diátaxis; marola's MIP-0080 for `skills.lock` | [Vale](https://vale.sh/) |

---

## 5. Vendored skills and tool lists

- **File:** [ouroboric:docs/4-ways-of-working/writing-styles.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/4-ways-of-working/writing-styles.md) (§5)
- **What it is:** the list of skills the factory vendors (pinned copies in Havamal, recorded in `skills.lock`), with upstream, licence and the styles that use them, and the rules for vendoring.
- **Notable items (the file gives no URLs):** `asd-ste100`, `business-writing`, `google-dev-docs`, `gov-uk-style`, `journalism-ap`, `orwells-rules`, `plain-language`, `scott-adams` from "writing-skills (Surendran B), v0.6.0", MIT; humanizer ("to be confirmed when vendored"); Ponytail (`ponytail-review`, `ponytail-audit`) from "DietrichGebert/ponytail", MIT.

Related: the v0 plan's pinned tools list `gitleaks` v8.30.1, `reuse==5.0.2`, Kroki 0.32.1, the devcontainer CLI (0.89.0 noted as latest on 2026-10-12) and Claude Code CLI (2.1.296 noted as latest on 2026-10-12), with the rule that a version "must be at least two weeks old when pinned": [yggdrasil:docs/2-engineering/plans/2026-10-12-yggdrasil-v0/tasks.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/2-engineering/plans/2026-10-12-yggdrasil-v0/tasks.md).

---

## 6. Benchmarks, checklists and assessments

| File | What it is |
|---|---|
| [yggdrasil:docs/2-engineering/specs/2026-10-11-yggdrasil-v0-spec.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/2-engineering/specs/2026-10-11-yggdrasil-v0-spec.md) §11 | the benchmark format: Harbor task layout (used by Terminal-Bench 2), SWE-bench-style fail-to-pass and pass-to-pass scoring, isolated grading, black-box only, hidden suites private |
| [yggdrasil:docs/1-product/design/2026-10-11-yggdrasil-v0-design.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/1-product/design/2026-10-11-yggdrasil-v0-design.md) §2.3, §4 | benchmark brief #1 (client gallery lite) and the seven v0 success criteria |
| [asgard:templates/readiness/checklist.md](https://github.com/ouroboric-dev/asgard/blob/1acab205610d3c9d816076bf83baa0b333c4dd08/templates/readiness/checklist.md) | the readiness checklist: 21 ready-to-build items, 8 ready-to-launch items, 4 ready-to-promote items |
| [ouroboric:docs/1-company/readiness/2026-10-11-ready-to-build.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/1-company/readiness/2026-10-11-ready-to-build.md) | the first readiness assessment of Ouroboric and Yggdrasil v0, with evidence per item (some rows lag the repos; see `OUROBORIC.md` §13) |
| [yggdrasil:docs/2-engineering/plans/2026-10-12-yggdrasil-v0/plan.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/2-engineering/plans/2026-10-12-yggdrasil-v0/plan.md) | maps each success criterion to a phase; the readiness gate; risks |

External benchmark references named in these files: Harbor, Terminal-Bench 2, SWE-bench (URLs in `curation.md` §2.5, listed in [1.1](#11-yggdrasil-learning-sources-curated-list)).

---

## 7. Licence and legal references

### 7.1 Licence map and options considered

- **File:** [ouroboric:docs/1-company/legal/README.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/1-company/legal/README.md)
- **What it is:** the licence map and the alternatives considered: Apache-2.0 everywhere; source-available licences such as FSL and PolyForm Shield. Contributor Covenant 2.1. No URLs.

### 7.2 Trademark policy

- **Files:** [ouroboric:TRADEMARKS.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/TRADEMARKS.md), [ouroboric:LICENSES/LicenseRef-Ouroboric-Trademark.txt](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/LICENSES/LicenseRef-Ouroboric-Trademark.txt)
- **What it is:** what you may and may not do with the names and logos.

### 7.3 Licence quick-reference for borrowing

- **File:** [yggdrasil:docs/5-research/curation.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/5-research/curation.md) §5
- **What it is:** which listed projects are safe to copy (MIT, Apache-2.0, CC0), read only (claude-squad AGPL-3.0, serena app GPL-3.0+, cmux GPL-3.0+, Daytona AGPL-3.0), source-available (crush FSL-1.1, Phoenix ELv2, Restate BSL 1.1, Inngest SSPL, claude-task-master Commons Clause, langfuse `ee/`), unlicensed (anthropics/claude-code, disler repos, polyglot-benchmark, Gut), or not adaptable (awesome-claude-code, CC BY-NC-ND). All [ANALYSIS].

### 7.4 Legal references in other files

| File | Reference |
|---|---|
| [ouroboric:docs/4-ways-of-working/writing-styles.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/4-ways-of-working/writing-styles.md) | GDPR Article 12 (quoted, no URL) |
| [ouroboric:docs/7-branding/identity/README.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/7-branding/identity/README.md) | LG München I, 3 O 17493/20 (January 2022, Google Fonts and the GDPR; no URL); SIL Open Font License 1.1 |
| [.github:CODE_OF_CONDUCT.md](https://github.com/ouroboric-dev/.github/blob/b799793319aaf4138e9733bcdda63b7a31cd7eb4/CODE_OF_CONDUCT.md) | [Contributor Covenant](https://www.contributor-covenant.org), [version 2.1](https://www.contributor-covenant.org/version/2/1/code_of_conduct.html), [Mozilla CoC enforcement ladder](https://github.com/mozilla/diversity), [FAQ](https://www.contributor-covenant.org/faq), [translations](https://www.contributor-covenant.org/translations) |

---

## 8. Brand and design research

| File | What it is | Notable items (as given) |
|---|---|---|
| [ouroboric:docs/7-branding/story/naming-and-mythology.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/7-branding/story/naming-and-mythology.md) | the naming record: the story, adversaries, glossary, unused names, naming rules, collision notes | Yggdrasil (Go mesh network), Ouroboros (Cardano's consensus protocol), Odin (programming language); no URLs |
| [ouroboric:docs/6-journal/2026-10-11-naming-the-tree.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-naming-the-tree.md) | how the Norse set was chosen over a Greek set and Vitruvius | Daedalus, Labyrinth, Ariadne, Mnemosyne (rejected set); "Askr" rejected |
| [ouroboric:docs/6-journal/2026-10-11-choosing-the-palette.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-choosing-the-palette.md) | four rounds of palette exploration with live WCAG checks | five candidate palettes: Midnight Ember, Fjord, Aurora, Frost and Iron, Asgard Gold |
| [ouroboric:docs/6-journal/2026-10-11-choosing-the-typography.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-choosing-the-typography.md) | five rounds of font exploration (all OFL) | Schibsted Grotesk, Chakra Petch, Cinzel, Uncial Antiqua, Jost, Barlow Condensed, Tektur, Jacquard 24, Grenze Gotisch, New Rocker, Fjalla One, Fjord One, Elder Futhark runes |
| [ouroboric:docs/7-branding/identity/README.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/7-branding/identity/README.md) | palette, contrast table, typography, type scale, logo summary | Cinzel, Fjalla One, Literata, Inter, JetBrains Mono, Noto Sans Runic |
| [ouroboric:docs/7-branding/identity/logo/README.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/7-branding/identity/logo/README.md) | logo files, usage rules, how each was made | potrace 1.16; Cinzel from the Google Fonts repository (commit `3dd78844`); HarfBuzz; Noto Sans Runic (commit `8b0a1d0f`); headless Chrome; Pillow |
| [ouroboric:docs/7-branding/identity/logo/concepts/README.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/7-branding/identity/logo/concepts/README.md) | three logo proposals and nine favicon explorations, with why each moved on | — |
| [ouroboric:docs/6-journal/2026-10-12-designing-the-logo.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-12-designing-the-logo.md) | how the logo, wordmark and favicon were made and measured | — |
| [ouroboric:docs/7-branding/prompts/nano-banana-logo-prompts.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/7-branding/prompts/nano-banana-logo-prompts.md) | image-generation prompts (style `prompt`) and a closing checklist: check names and reverse-image-search the icon | Nano Banana (no URL) |
| [ouroboric:docs/6-journal/2026-10-11-diagrams-in-the-design-language.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-diagrams-in-the-design-language.md) | three options for themed diagrams and lessons on fonts in SVG | — |

---

## 9. Reviews and audits

| File | What it is |
|---|---|
| [yggdrasil:docs/2-engineering/specs/2026-10-11-yggdrasil-v0-spec-wording-review.md](https://github.com/ouroboric-dev/yggdrasil/blob/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/2-engineering/specs/2026-10-11-yggdrasil-v0-spec-wording-review.md) | status `superseded`, kept as a record. The style pass on the spec: 58 requirements whose meaning might have shifted, the founder's resolution of each, and three spec changes it caused (#20 own-skill evals MUST show a gain; #29 only `extracted` or `oasdiff` evidence triggers `pointer-contract`; #37 a failing canary blocks a bump) |
| [ouroboric:docs/6-journal/2026-10-11-the-style-guide-applied-to-itself.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-the-style-guide-applied-to-itself.md) | the measured result of that pass: spec sentences over the limit fell from 51 of 258 to 16 of 412; 168 RFC 2119 keywords; 58 requirements listed for review |
| [ouroboric:docs/6-journal/2026-10-11-first-publish.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/2026-10-11-first-publish.md) | the pre-publish secret and private-data scan of full history, and what did not go as planned |

---

## 10. Research folders (indexes)

| File | What it is |
|---|---|
| [ouroboric:docs/5-research/README.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/5-research/README.md) | company-level research (markets, other factories, organisation); points to Yggdrasil's research |
| [yggdrasil:docs/5-research/](https://github.com/ouroboric-dev/yggdrasil/tree/ffedea7c476d10c04498d5db74596a72a5ab0cbb/docs/5-research) | the six product research files indexed in sections 1 and 2 |
| [ouroboric:docs/6-journal/README.md](https://github.com/ouroboric-dev/ouroboric/blob/b355b1d52d6906f80447fe84283f705403533d0b/docs/6-journal/README.md) | the journal index (30 entries with tags, status and post-candidate flag); the journal itself is digested in `OUROBORIC.md` §10 |

`asgard`, `.github` and `ouroboric-packages` hold no research files or curated lists at the commits read.
