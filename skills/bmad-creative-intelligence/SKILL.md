---
name: bmad-creative-intelligence
description: Ideation and deep research skill for BMAD. Use for bmad:ideate and bmad:research-deep to generate options and structured insight.
---

# BMAD Creative Intelligence

## Trigger Intents

- `bmad:ideate`
- `bmad:research-deep`

## Workflow Variants

1. `ideate`
- Generate and prioritize option sets for a defined problem.

2. `research-deep`
- Produce evidence-backed analysis with sources and recommendations.

## Inputs

- problem statement and constraints
- existing BMAD artifacts in `docs/bmad/`
- target market or technical domain

## Mandatory Reference Load

Before executing `ideate` or `research-deep`, read `REFERENCE.md` first.
Treat `REFERENCE.md` as required context for method selection and output quality.

## Output Contract

- ideation output -> `docs/bmad/brainstorm.md`
- deep research output -> `docs/bmad/research-deep.md`
- optional option memo -> `docs/bmad/options.md`

## Core Workflow

1. Select method based on uncertainty and decision type.
2. Generate options or gather evidence.
3. Evaluate impact, effort, risk, and confidence.
4. Produce ranked recommendations.
5. Suggest concrete next BMAD intent.

## Script Selection

- SCAMPER prompts:
  ```bash
  bash scripts/scamper-prompts.sh
  ```
- SWOT structure:
  ```bash
  bash scripts/swot-template.sh
  ```
- Research source collection:
  ```bash
  bash scripts/research-sources.sh
  ```

## Template Map

- `templates/brainstorm-session.template.md`
- Why: structure ideation sessions and ranking output.

- `templates/research-report.template.md`
- Why: structure evidence collection and recommendations.

## Reference Map

- `REFERENCE.md`
- Must read first for method selection and workflow guidance.

- `resources/brainstorming-techniques.md`
- Use for ideation frameworks and facilitation patterns.

- `resources/research-methods.md`
- Use for deep research design and evidence quality.

## Quality Gates

- alternatives are concrete and comparable
- assumptions and confidence levels are explicit
- major claims include source context or uncertainty notes
- final recommendation is actionable
