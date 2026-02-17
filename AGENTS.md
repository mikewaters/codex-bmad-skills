# BMAD for OpenAI Codex

This repository provides BMAD skills natively for OpenAI Codex.

## Runtime Contract

- Target runtime: OpenAI Codex.
- Skill install roots:
  - Global: `~/.agents/skills`
  - Project: `<project>/.agents/skills`
- State/config format: YAML files edited by `yq` (v4+).

## Skill Sources in This Repository

- Canonical source during migration: `skills/*`

## Trigger Intents

Use these intent IDs in prompts:

- `bmad:init`, `bmad:status`, `bmad:next`
- `bmad:product-brief`, `bmad:research`, `bmad:brainstorm`
- `bmad:prd`, `bmad:tech-spec`, `bmad:prioritize`
- `bmad:architecture`, `bmad:gate-check`
- `bmad:sprint-plan`, `bmad:create-story`
- `bmad:dev-story`, `bmad:code-review`
- `bmad:ux-design`, `bmad:user-flow`
- `bmad:ideate`, `bmad:research-deep`
- `bmad:create-skill`, `bmad:create-workflow`

## Migration Safety Rules

- Do not use deprecated custom prompts as a compatibility layer.
- Prefer project-local skills over global when names collide.
- Keep workflow state explicit in YAML files under `<project>/bmad/`.
- Enforce skills path isolation: any script, template, or referenced resource used by `skills/*` must remain within the `skills/` tree.
- Skills under `skills/*` must not read, import, execute, or reference paths outside `skills/` (for example `../installers`, `../docs`, or any parent path escape).

## Language Settings

When `bmad/project.yaml` is present, apply:

- `language.communication_language` for assistant communication.
- `language.document_output_language` for generated BMAD documents.

Fallback order:

1. `language.document_output_language`
2. `language.communication_language`
3. `"English"`
