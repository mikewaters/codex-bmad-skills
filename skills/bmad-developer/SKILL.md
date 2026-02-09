---
name: bmad-developer
description: Implementation skill for BMAD. Use for bmad:dev-story and bmad:code-review to deliver tested code from story specs.
---

# BMAD Developer

## Trigger Intents

- `bmad:dev-story`
- `bmad:code-review`

## Workflow Variants

1. `dev-story`
- Implement one story to completion with tests.

2. `code-review`
- Review implementation quality against story acceptance criteria.

## Inputs

- target story file `docs/stories/STORY-*.md`
- architecture constraints from `docs/bmad/architecture.md` when present
- repository coding and testing standards

## Mandatory Reference Load

Before executing `dev-story` or `code-review`, read `REFERENCE.md` first.
Treat `REFERENCE.md` as required context. Then load focused details from:
- `resources/clean-code-checklist.md`
- `resources/testing-standards.md`

## Output Contract

- code and test changes in repository
- optional review artifact `docs/bmad/code-review.md`
- clear pass/fail status against acceptance criteria

## Core Workflow

1. Read story scope and acceptance criteria.
2. Implement minimal complete solution.
3. Add or update tests.
4. Run quality checks and summarize outcomes.
5. Report residual risks and follow-up items.

## Implementation Approach

### 1. Understand Story and Constraints

- Parse acceptance criteria into explicit checks.
- Identify touched modules, dependencies, and data contracts.
- Load architecture constraints from `docs/bmad/architecture.md` when present.
- Flag ambiguities and assumptions before implementation.

### 2. Plan Before Coding

- Break work into small slices:
  - data and schema changes
  - business logic
  - interfaces and adapters
  - test updates
- Define edge cases, failure modes, and rollback-safe behavior.

### 3. Implement Incrementally

- Prefer small, reviewable changes over large rewrites.
- Preserve existing project conventions and architecture boundaries.
- Handle errors explicitly and keep behavior deterministic.
- Avoid hidden scope expansion; if scope grows, record it in the summary.

### 4. Test to Match Risk

- Add unit tests for new logic and edge cases.
- Add integration tests where component boundaries are crossed.
- Add end-to-end tests for critical user-facing flows when applicable.
- Verify acceptance criteria with test evidence, not assumptions.

### 5. Run Hard Quality Gates

- Run lint and static checks:
  ```bash
  bash scripts/lint-check.sh
  ```
- Run pre-commit checks:
  ```bash
  bash scripts/pre-commit-check.sh
  ```
- Run coverage validation (default 80% minimum unless project requires higher):
  ```bash
  bash scripts/check-coverage.sh
  ```
- Do not mark complete with unresolved failing checks unless explicitly approved.

### 6. Close with Traceable Outcome

- Map each acceptance criterion to code and test evidence.
- Summarize changed files, key decisions, and residual risks.
- For `code-review`, record findings using `templates/code-review.template.md`.

## Script Selection

- Lint checks:
  ```bash
  bash scripts/lint-check.sh
  ```
- Pre-commit quality checks:
  ```bash
  bash scripts/pre-commit-check.sh
  ```
- Coverage checks:
  ```bash
  bash scripts/check-coverage.sh
  ```

## Template Map

- `templates/code-review.template.md`
- Why: structured review output for quality and risk communication.

## Reference Map

- `REFERENCE.md`
- Must read first for developer workflow and implementation discipline.

- `resources/clean-code-checklist.md`
- Use when reviewing maintainability and readability.

- `resources/testing-standards.md`
- Use when validating test completeness and quality.

## Quality Gates

- acceptance criteria are explicitly verified
- tests and lint pass, or failures are reported clearly
- no hidden scope expansion without note
- implementation remains maintainable and reviewable
