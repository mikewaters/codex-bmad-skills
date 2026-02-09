---
name: bmad-scrum-master
description: Sprint planning skill for BMAD. Use for bmad:sprint-plan and bmad:create-story to build sprint scope and implementation-ready stories.
---

# BMAD Scrum Master

## Trigger Intents

- `bmad:sprint-plan`
- `bmad:create-story`

## Workflow Variants

1. `sprint-plan`
- Build sprint scope, sequencing, and capacity alignment.

2. `create-story`
- Generate implementation-ready story files with acceptance criteria.

## Inputs

- approved planning and architecture artifacts
- `bmad/workflow-status.yaml`
- `bmad/sprint-status.yaml`
- team capacity and timeline constraints

## Mandatory Reference Load

Before executing `sprint-plan` or `create-story`, read `REFERENCE.md` first.
Treat `REFERENCE.md` as required context for sprint decomposition and story quality.

## Output Contract

- sprint plan -> `docs/bmad/sprint-plan.md`
- story artifacts -> `docs/stories/STORY-*.md`
- updated sprint state -> `bmad/sprint-status.yaml`

## Core Workflow

1. Decompose epics into thin vertical stories.
2. Estimate size (prefer 1-8 points per story).
3. Plan sprint to match realistic capacity.
4. Generate stories with acceptance criteria and dependencies.
5. Update sprint status and hand off to developer.

## Script Selection

- Story ID generation:
  ```bash
  bash scripts/generate-story-id.sh
  ```
- Velocity support:
  ```bash
  python3 scripts/calculate-velocity.py
  ```
- Burndown support:
  ```bash
  python3 scripts/sprint-burndown.py
  ```

## Template Map

- `templates/sprint-plan.template.md`
- Why: sprint objective, scope, and sequencing.

- `templates/user-story.template.md`
- Why: story format with acceptance criteria.

- `templates/sprint-status.template.yaml`
- Why: machine-readable sprint tracking state.

## Reference Map

- `REFERENCE.md`
- Must read first for sprint workflow guidance and story quality expectations.

- `resources/story-sizing-guide.md`
- Use to keep estimates consistent and avoid oversized stories.

## Quality Gates

- sprint scope matches team capacity
- stories are independent and testable
- acceptance criteria and dependencies are explicit
- sprint status reflects planned work accurately
