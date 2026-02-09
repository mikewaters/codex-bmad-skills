---
layout: default
title: "Codex Workflows"
description: "BMAD workflow phases and intent routing in OpenAI Codex."
keywords: "workflow, intents, bmad"
---

# Codex Workflows

## Phase Model

1. Analysis
2. Planning
3. Solutioning
4. Implementation

State source of truth: `bmad/workflow-status.yaml`.

## Recommended Progression

1. `bmad:init`
2. `bmad:status`
3. `bmad:next`
4. Run recommended phase intent
5. Update status via shared/orchestrator scripts

## Level Rules

- Level 0-1: `tech_spec` required
- Level 2-4: `prd` + `architecture` required

## Main Intents By Phase

### Analysis

- `bmad:product-brief`
- `bmad:research`
- `bmad:brainstorm`

### Planning

- `bmad:prd`
- `bmad:tech-spec`
- `bmad:prioritize`
- `bmad:ux-design`

### Solutioning

- `bmad:architecture`
- `bmad:gate-check`

### Implementation

- `bmad:sprint-plan`
- `bmad:create-story`
- `bmad:dev-story`
- `bmad:code-review`

## Script Entry Points

- `skills/bmad-orchestrator/scripts/init-project.sh`
- `skills/bmad-orchestrator/scripts/show-status.sh`
- `skills/bmad-orchestrator/scripts/recommend-next.sh`
- `skills/bmad-shared/scripts/update-workflow-status.sh`
