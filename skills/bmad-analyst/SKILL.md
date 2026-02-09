---
name: bmad-analyst
description: Product discovery and analysis skill for BMAD. Use for bmad:product-brief, bmad:research, and bmad:brainstorm to clarify user needs, market context, and problem scope.
---

# BMAD Analyst

## Trigger Intents

- `bmad:product-brief`
- `bmad:research`
- `bmad:brainstorm`

## Workflow Variants

1. `product-brief`
- Use when a project or feature needs a discovery brief before planning.

2. `research`
- Use when decisions need market, competitor, or technical evidence.

3. `brainstorm`
- Use when exploring solution options and narrowing concepts.

If the request is ambiguous, ask:

- "Do you want product-brief, research, or brainstorm mode?"

## Inputs

- `bmad/project.yaml` if available
- existing notes in `docs/bmad/`
- stakeholder assumptions, constraints, and goals

## Mandatory Reference Load

Before executing any workflow variant, read `REFERENCE.md` first.
Treat `REFERENCE.md` as required context, then load only relevant supporting files.

## Output Contract

- `product-brief` -> `docs/bmad/product-brief.md`
- `research` -> `docs/bmad/research-report.md`
- `brainstorm` -> `docs/bmad/brainstorm.md`

Always finish with a recommended next intent (`bmad:prd` or `bmad:tech-spec` in most cases).

## Core Workflow

1. Identify problem, user segment, impact, urgency, and constraints.
2. Apply discovery methods (5 Whys, JTBD, SMART).
3. Build the selected artifact with clear assumptions and measurable outcomes.
4. Validate artifact completeness and decision readiness.
5. Provide explicit handoff notes for the next BMAD phase.

## Script Selection

- Discovery question flow (interactive TTY):
  ```bash
  bash scripts/discovery-checklist.sh
  ```
- Product brief completeness check:
  ```bash
  bash scripts/validate-brief.sh docs/bmad/product-brief.md
  ```

If the shell is non-interactive, ask structured questions directly instead of running the checklist script.

## Template Map

- `templates/product-brief.template.md`
- Why: structured discovery output for PM handoff.

- `templates/research-report.template.md`
- Why: evidence-based research output with findings and recommendations.

For `brainstorm`, use this compact structure:

- problem frame
- idea list (10-20)
- ranked shortlist (top 3-5)
- risks and assumptions
- recommendation

## Reference Map

- `REFERENCE.md`
- Must read first for interview frameworks and discovery process details.

- `resources/interview-frameworks.md`
- Use as a focused question bank for interviews.

Load only relevant sections to keep context lean.

## Quality Gates

- problem statement is explicit and testable
- target users and pain points are concrete
- success criteria are measurable
- assumptions and risks are visible
- next intent is clearly stated

## Handoff Criteria

Ready for `bmad-product-manager` when the discovery artifact defines:

- validated problem and user scope
- prioritized opportunities
- measurable outcomes
- constraints and dependencies
