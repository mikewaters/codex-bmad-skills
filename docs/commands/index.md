---
layout: default
title: "Intents Reference"
description: "Reference of BMAD intent IDs for OpenAI Codex workflows."
keywords: "BMAD intents, OpenAI Codex, workflow routing"
---

# Intents Reference

BMAD for OpenAI Codex uses **intent IDs** instead of slash commands.

## Orchestration

- `bmad:init` - initialize project artifacts
- `bmad:status` - show current phase and completion
- `bmad:next` - recommend next workflow

## Phase 1: Analysis

- `bmad:product-brief`
- `bmad:research`
- `bmad:brainstorm`

## Phase 2: Planning

- `bmad:prd`
- `bmad:tech-spec`
- `bmad:prioritize`
- `bmad:ux-design`

## Phase 3: Solutioning

- `bmad:architecture`
- `bmad:gate-check`

## Phase 4: Implementation

- `bmad:sprint-plan`
- `bmad:create-story`
- `bmad:dev-story`
- `bmad:code-review`

## Extension / Innovation

- `bmad:create-skill`
- `bmad:create-workflow`
- `bmad:ideate`
- `bmad:research-deep`

## Operational Scripts

- `bash skills/bmad-orchestrator/scripts/init-project.sh ...`
- `bash skills/bmad-orchestrator/scripts/show-status.sh bmad/workflow-status.yaml`
- `bash skills/bmad-orchestrator/scripts/recommend-next.sh bmad/workflow-status.yaml`
- `bash skills/bmad-shared/scripts/update-workflow-status.sh --workflow <id>`
