---
layout: default
title: "BMAD for OpenAI Codex"
description: "Codex-first BMAD skills: installation, workflow intents, and YAML state model."
keywords: "OpenAI Codex, BMAD, skills, AGENTS.md, yq"
---

# BMAD for OpenAI Codex

This documentation tracks the Codex-first migration path.

## Start Here

- [Getting Started](./getting-started)
- [Codex Skills](./codex-skills)
- [Codex Workflows](./codex-workflows)
- [Configuration](./configuration)
- [Troubleshooting](./troubleshooting)

## Runtime Contract

- Global skills root: `~/.agents/skills`
- Project skills root: `<project>/.agents/skills`
- Project state: YAML files in `<project>/bmad/`
- Required tooling: `yq` v4+ and `python3`

## Current Migration Decisions

- Codex-only branch (no dual-runtime support)
- no compatibility layer via deprecated custom prompts
- installer mode is explicit: `--scope global|local` + `--dest`
- canonical skill namespace: `skills/bmad-*`

## Core Intents

- `bmad:init`, `bmad:status`, `bmad:next`
- `bmad:product-brief`, `bmad:research`, `bmad:brainstorm`
- `bmad:prd`, `bmad:tech-spec`, `bmad:prioritize`
- `bmad:architecture`, `bmad:gate-check`
- `bmad:sprint-plan`, `bmad:create-story`, `bmad:dev-story`, `bmad:code-review`
- `bmad:ux-design`, `bmad:user-flow`
- `bmad:ideate`, `bmad:research-deep`
- `bmad:create-skill`, `bmad:create-workflow`
