---
layout: default
title: "Troubleshooting"
description: "Common issues for BMAD OpenAI Codex setup and runtime."
keywords: "BMAD troubleshooting, OpenAI Codex"
---

# Troubleshooting

## Installer Fails: Missing `yq`

Symptom:

- installer exits with `yq not found in PATH`

Fix:

- install `yq` v4+
- re-run installer

## Installer Fails: Missing Python

Symptom:

- installer exits with `python not found in PATH`

Fix:

- install `python3`
- verify `python3 --version`
- re-run installer

## No Skills Loaded in Project

Checks:

- global path exists: `~/.agents/skills` (default installer destination)
- or project local path exists: `<project>/.agents/skills` (if custom `--dest` was used)
- installed skill folders contain `SKILL.md`
- restart Codex after installing skills

## Init Script Fails on Existing Files

Symptom:

- `init-project.sh` reports file already exists

Fix:

- re-run with `--force` only if overwrite is intended
- otherwise keep existing state and continue with `show-status.sh`

## Status Scripts Fail

Symptom:

- `show-status.sh` or `recommend-next.sh` fails

Checks:

- `bmad/workflow-status.yaml` exists
- YAML is valid (`yq eval '.' bmad/workflow-status.yaml`)

## Wrong Next Recommendation

Checks:

- verify `project.level` in `bmad/project.yaml`
- inspect required/recommended flags in `bmad/workflow-status.yaml`
- normalize with `update-workflow-status.sh` after completed workflows
