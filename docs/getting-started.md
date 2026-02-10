---
layout: default
title: "Getting Started (OpenAI Codex)"
description: "Install BMAD skills into OpenAI Codex and initialize project YAML artifacts."
keywords: "OpenAI Codex, BMAD install, .agents/skills, yq"
---

# Getting Started (OpenAI Codex)

## Prerequisites

- OpenAI Codex installed
- `yq` v4+
- `python3` (or `python`)

The installer checks these dependencies during run.

## 1. Clone and Open

```bash
git clone https://github.com/YOUR-USERNAME/codex-bmad-skills.git
cd codex-bmad-skills
```

## 2. Install Skills

### Install to default global path

```bash
codex-bmad-skills/installers/install-codex.sh
```

### Install to custom path (example: project-local)

```bash
codex-bmad-skills/installers/install-codex.sh \
  --dest "<project>/.agents/skills"
```

PowerShell equivalents:

```powershell
codex-bmad-skills/installers/install-codex.ps1
codex-bmad-skills/installers/install-codex.ps1 -Dest "<project>\.agents\skills"
```

## 3. Initialize BMAD Artifacts

```bash
bash skills/bmad-orchestrator/scripts/init-project.sh \
  --name "My Project" \
  --type web-app \
  --level 2
```

Generated files:

- `bmad/project.yaml`
- `bmad/workflow-status.yaml`
- `bmad/sprint-status.yaml`

## 4. Check Status

```bash
bash skills/bmad-orchestrator/scripts/show-status.sh bmad/workflow-status.yaml
bash skills/bmad-orchestrator/scripts/recommend-next.sh bmad/workflow-status.yaml
```

## 5. Run Phase Intents

Start with recommended intent from status, then continue by phase:

- discovery: `bmad:product-brief` / `bmad:research`
- planning: `bmad:prd` or `bmad:tech-spec`
- solutioning: `bmad:architecture`
- implementation: `bmad:sprint-plan` -> `bmad:create-story` -> `bmad:dev-story`

## Installer Parameters

- `--dest` / `-Dest` is optional
- default destination is `$HOME/.agents/skills`
- example custom destination: `<project>/.agents/skills`
- if same skill exists globally and locally, prefer project-local in this project
