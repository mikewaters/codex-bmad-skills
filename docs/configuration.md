---
layout: default
title: "Configuration"
description: "Configuration model for BMAD on OpenAI Codex."
keywords: "BMAD config, YAML, yq"
---

# Configuration

## Configuration Layers

1. Skill install location (`~/.agents/skills` or `<project>/.agents/skills`)
2. Project YAML state in `<project>/bmad/`

## Project YAML Files

### `bmad/project.yaml`

Contains project metadata and path conventions.

Core keys:

- `project.name`
- `project.type`
- `project.level`
- `paths.output_folder`
- `paths.status_file`
- `paths.sprint_file`

### `bmad/workflow-status.yaml`

Source of truth for phase/workflow completion and progress metrics.

### `bmad/sprint-status.yaml`

Sprint-level plan, story metrics, and velocity-related state.

## Tooling Contract

- use `yq` v4+ for YAML reads and updates
- do not parse YAML with ad-hoc grep/sed logic in new scripts
- Python utilities may be used where already stable

## Scripted Access

- read project config:
  - `bash skills/bmad-shared/scripts/load-project-config.sh`
- get recommendation:
  - `bash skills/bmad-shared/scripts/next-workflow.sh bmad/workflow-status.yaml`
- update workflow completion:
  - `bash skills/bmad-shared/scripts/update-workflow-status.sh --workflow <id> --output <path>`

## Installer Flags

- `--scope global|local`
- `--dest <path>`
- `--project-root <path>` (for local scope)
- no `both` mode
