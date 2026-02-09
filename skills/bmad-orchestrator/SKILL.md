---
name: bmad-orchestrator
description: Orchestrates Codex BMAD workflows. Use for bmad:init, bmad:status, and bmad:next to manage project setup, state tracking, and phase routing.
---

# BMAD Orchestrator

## Trigger Intents

- `bmad:init`
- `bmad:status`
- `bmad:next`

## Workflow Variants

1. `init`
- Initialize project BMAD artifacts and baseline state.

2. `status`
- Summarize workflow progress and current phase readiness.

3. `next`
- Recommend the next workflow intent from current state.

## Inputs

- repository root and target project root
- existing BMAD files under `bmad/`
- project level and phase state from YAML artifacts

## Mandatory Reference Load

Before executing `init`, `status`, or `next`, read `REFERENCE.md` first.
Treat `REFERENCE.md` as required context for routing, sequencing, and state handling.

## Output Contract

- `bmad/project.yaml`
- `bmad/workflow-status.yaml`
- `bmad/sprint-status.yaml`
- status summary and next-intent recommendation

## Core Workflow

1. Initialize state files and directories (`init`).
2. Read YAML state and show completion by phase (`status`).
3. Compute next recommended intent by project level and completion (`next`).
4. Route to phase skill with explicit handoff context.

## Script Selection

Primary scripts:

- Init project:
  ```bash
  bash scripts/init-project.sh --name "MyApp" --type web-app --level 2
  ```
- Show status:
  ```bash
  bash scripts/show-status.sh bmad/workflow-status.yaml
  ```
- Recommend next:
  ```bash
  bash scripts/recommend-next.sh bmad/workflow-status.yaml
  ```

Compatibility wrappers:

- `scripts/check-status.sh` -> wrapper to `show-status.sh`
- `scripts/validate-config.sh` -> project config structural validation

Shared state helpers are in `../bmad-shared/scripts/`.

## Template Map

- `templates/config.template.yaml`
- Why: orchestrator-level config compatibility template.

- `templates/workflow-status.template.yaml`
- Why: orchestrator workflow status compatibility template.

Source-of-truth shared templates live in `../bmad-shared/`.

## Reference Map

- `REFERENCE.md`
- Must read first for routing logic and orchestration heuristics.

- `resources/workflow-phases.md`
- Use for phase-level guidance and sequencing.

- `../bmad-shared/workflows.registry.yaml`
- Use for intent mapping and level-based routing rules.

## Error Handling

- Missing `bmad/workflow-status.yaml` -> recommend `bmad:init`
- Invalid YAML or missing required fields -> report exact file and key
- State mismatch across files -> normalize via shared update script

## Handoff Rules

When routing to another skill, include:

- project level
- current phase
- completed and required workflows
- expected output artifact path
