---
layout: default
title: "Codex Skills"
description: "Skill catalog for BMAD Codex migration."
keywords: "skills, codex, bmad"
---

# Codex Skills

## Skill Catalog

- `bmad-orchestrator`: initialize/status/next and phase routing
- `bmad-analyst`: discovery, product brief, research
- `bmad-product-manager`: PRD, tech spec, prioritization
- `bmad-architect`: architecture and gate check
- `bmad-scrum-master`: sprint planning and story creation
- `bmad-developer`: implementation and code review
- `bmad-ux-designer`: UX design and user flow
- `bmad-creative-intelligence`: ideation and deep research
- `bmad-builder`: create skill/workflow scaffolds
- `bmad-shared`: shared YAML state scripts

## Skill Folder Contract

Each skill should contain:

- `SKILL.md`
- `agents/openai.yaml`
- optional `templates/`, `scripts/`, `resources/`

## Trigger Style

Use explicit BMAD intents (for example `bmad:prd`) or natural language prompts that map to those intents.

## Artifact Discipline

- project state lives in `bmad/*.yaml`
- documents in `docs/bmad/*.md`
- stories in `docs/stories/STORY-*.md`

## Runtime Notes

- YAML edits should go through `yq`
- Python scripts are allowed where they already exist and are stable
