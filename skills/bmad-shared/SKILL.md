---
name: bmad-shared
description: Shared state and template helper skill for BMAD. Provides reusable YAML contracts and deterministic scripts used by orchestrator and phase skills.
---

# BMAD Shared

## Purpose

Provide shared workflow state contracts and helper scripts for all BMAD skills.

## Mandatory Reference Load

Before executing shared helper workflows, read `REFERENCE.md` first.
Treat `REFERENCE.md` as required context for state semantics and update rules.

## Workflow Variants

1. `config-read`
- Read project or global configuration safely.

2. `status-update`
- Update workflow state after completion.

3. `next-recommendation`
- Compute next intent from workflow state.

## YAML Contract Files

- `config.template.yaml`
- `workflow-status.template.yaml`
- `sprint-status.template.yaml`
- `workflows.registry.yaml`
- `REFERENCE.md`
- Shared script semantics and state rules.

- `helpers.md`
- Shared implementation conventions and migration notes.

## Script Selection

Current scripts:

- Read project config:
  ```bash
  bash scripts/load-project-config.sh bmad/project.yaml
  ```
- Read global config:
  ```bash
  bash scripts/load-global-config.sh
  ```
- Update workflow state:
  ```bash
  bash scripts/update-workflow-status.sh --workflow product_brief --status-file bmad/workflow-status.yaml
  ```
- Recommend next workflow:
  ```bash
  bash scripts/next-workflow.sh bmad/workflow-status.yaml
  ```

Compatibility wrappers:

- `scripts/load-config.sh` -> wrapper to `load-project-config.sh`
- `scripts/update-status.sh` -> wrapper to `update-workflow-status.sh`
- `scripts/check-phase.sh` -> wrapper to `next-workflow.sh`

## Usage Rules

- prefer `yq` v4+ for all YAML reads and writes
- keep updates deterministic and idempotent where possible
- avoid ad-hoc parsing for nested YAML values

## Quality Gates

- YAML contract files remain backward-compatible within this branch
- scripts return explicit errors for missing files or tools
- state transitions update metrics and phase status consistently
