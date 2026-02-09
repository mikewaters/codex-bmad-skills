---
layout: default
title: "Skills Reference"
description: "Skill catalog for BMAD on OpenAI Codex."
keywords: "BMAD skills, Codex skills"
---

# Skills Reference

## Core

### `bmad-orchestrator`

- role: lifecycle orchestration
- intents: `bmad:init`, `bmad:status`, `bmad:next`
- key scripts:
  - `skills/bmad-orchestrator/scripts/init-project.sh`
  - `skills/bmad-orchestrator/scripts/show-status.sh`
  - `skills/bmad-orchestrator/scripts/recommend-next.sh`

### `bmad-shared`

- role: shared YAML templates/state helpers
- used by other BMAD skills
- key scripts:
  - `skills/bmad-shared/scripts/load-project-config.sh`
  - `skills/bmad-shared/scripts/update-workflow-status.sh`
  - `skills/bmad-shared/scripts/next-workflow.sh`

## Delivery Skills

### `bmad-analyst`

- intents: `bmad:product-brief`, `bmad:research`, `bmad:brainstorm`
- outputs: discovery docs in `docs/bmad/`

### `bmad-product-manager`

- intents: `bmad:prd`, `bmad:tech-spec`, `bmad:prioritize`
- outputs: planning artifacts in `docs/bmad/`

### `bmad-architect`

- intents: `bmad:architecture`, `bmad:gate-check`
- outputs: architecture and gate docs

### `bmad-scrum-master`

- intents: `bmad:sprint-plan`, `bmad:create-story`
- outputs: sprint plan + `docs/stories/STORY-*.md`

### `bmad-developer`

- intents: `bmad:dev-story`, `bmad:code-review`
- outputs: implementation and review artifacts

### `bmad-ux-designer`

- intents: `bmad:ux-design`, `bmad:user-flow`
- outputs: UX artifacts in `docs/bmad/`

### `bmad-creative-intelligence`

- intents: `bmad:ideate`, `bmad:research-deep`
- outputs: ideation/research artifacts

### `bmad-builder`

- intents: `bmad:create-skill`, `bmad:create-workflow`
- outputs: scaffolded BMAD capabilities

## Installation Roots

- global: `~/.agents/skills`
- project: `<project>/.agents/skills`

If identical names exist in both, use project-local behavior for the project.
