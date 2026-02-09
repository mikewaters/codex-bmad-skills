---
name: bmad-ux-designer
description: UX design skill for BMAD. Use for bmad:ux-design and bmad:user-flow to define interaction design and accessibility-ready UX artifacts.
---

# BMAD UX Designer

## Trigger Intents

- `bmad:ux-design`
- `bmad:user-flow`

## Workflow Variants

1. `ux-design`
- Create UX specification with states, constraints, and accessibility requirements.

2. `user-flow`
- Create end-to-end user flow for primary tasks and edge states.

## Inputs

- planning artifacts (`docs/bmad/prd.md` or `docs/bmad/tech-spec.md`)
- user roles, journeys, and platform constraints
- accessibility target (WCAG level)

## Mandatory Reference Load

Before executing `ux-design` or `user-flow`, read `REFERENCE.md` first.
Treat `REFERENCE.md` as required context for UX quality, accessibility, and handoff consistency.

## Output Contract

- UX spec -> `docs/bmad/ux-design.md`
- flow definition -> `docs/bmad/user-flow.md`

## Core Workflow

1. Define user goals and key journeys.
2. Map states, transitions, and interaction rules.
3. Document responsive behavior and failure states.
4. Validate accessibility and readability constraints.
5. Provide implementation handoff constraints.

## Script Selection

- Accessibility checklist:
  ```bash
  bash scripts/wcag-checklist.sh
  ```
- Responsive breakpoint reference:
  ```bash
  bash scripts/responsive-breakpoints.sh
  ```
- Color contrast check:
  ```bash
  python3 scripts/contrast-check.py '#000000' '#FFFFFF'
  ```

## Template Map

- `templates/ux-design.template.md`
- Why: complete UX artifact for implementation handoff.

- `templates/user-flow.template.md`
- Why: structured user path and decision states.

## Reference Map

- `REFERENCE.md`
- Must read first for UX workflow guidance and delivery quality.

- `resources/accessibility-guide.md`
- Use when validating accessibility and semantic behavior.

- `resources/design-patterns.md`
- Use for common interaction patterns and consistency.

- `resources/design-tokens.md`
- Use for spacing, typography, and component-level design constraints.

## Quality Gates

- key journeys and edge cases are captured
- accessibility constraints are explicit and testable
- responsive behavior is documented
- design output is directly implementable
