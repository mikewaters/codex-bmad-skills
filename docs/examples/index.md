---
layout: default
title: "Examples"
description: "Practical BMAD flow examples for OpenAI Codex."
keywords: "BMAD examples, Codex workflows"
---

# Examples

## Example 1: Level 1 Feature

Goal: add a small feature to an existing app.

1. Initialize:

```bash
bash skills/bmad-orchestrator/scripts/init-project.sh --name "Todo App" --type web-app --level 1
```

2. Check recommendation:

```bash
bash skills/bmad-orchestrator/scripts/recommend-next.sh bmad/workflow-status.yaml
```

3. Run planning path (`tech-spec` for level 1), then sprint and story implementation.

## Example 2: Level 2 Feature Set

Goal: multi-feature release.

1. Initialize with level 2.
2. Follow recommended order:
   - `bmad:product-brief`
   - `bmad:prd`
   - `bmad:architecture`
   - `bmad:sprint-plan`
   - `bmad:create-story` / `bmad:dev-story`

3. After each completed workflow, update status using shared script.

## Example 3: Skill Extension

Goal: add domain-specific BMAD skill.

- trigger `bmad:create-skill`
- scaffold with `skills/bmad-builder/scripts/scaffold-skill.sh`
- validate with `skills/bmad-builder/scripts/validate-skill.sh`
