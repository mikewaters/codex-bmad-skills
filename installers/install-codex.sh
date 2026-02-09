#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Install BMAD skills for OpenAI Codex.

Usage:
  ./installers/install-codex.sh --scope global|local --dest <path> [--project-root <path>] [--force] [--dry-run]

Required:
  --scope         global or local
  --dest          destination skills directory (for example ~/.agents/skills or ./.agents/skills)

Optional:
  --project-root  project root for local scope (default: current directory)
  --force         overwrite existing installed skill directories
  --dry-run       print operations without copying files
  -h, --help      show this help

Runtime requirements:
  - yq v4+
  - python3 (or python)
USAGE
}

log() {
  printf '[%s] %s\n' "$1" "$2"
}

die() {
  log ERROR "$1"
  exit 1
}

check_runtime_requirements() {
  local yq_version
  local python_version

  if ! command -v yq >/dev/null 2>&1; then
    die "yq not found in PATH. Install yq v4+ before running installer."
  fi

  if command -v python3 >/dev/null 2>&1; then
    PYTHON_BIN="python3"
  elif command -v python >/dev/null 2>&1; then
    PYTHON_BIN="python"
  else
    die "python not found in PATH. Install python3 before running installer."
  fi

  yq_version="$(yq --version 2>/dev/null | head -1 || true)"
  python_version="$("$PYTHON_BIN" --version 2>&1 | head -1 || true)"

  log OK "Runtime check: ${yq_version:-yq detected}, ${python_version:-$PYTHON_BIN detected}"
}

SCOPE=""
DEST=""
PROJECT_ROOT=""
FORCE=0
DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --scope)
      [[ $# -ge 2 ]] || die "Missing value for --scope"
      SCOPE="$2"
      shift 2
      ;;
    --dest)
      [[ $# -ge 2 ]] || die "Missing value for --dest"
      DEST="$2"
      shift 2
      ;;
    --project-root)
      [[ $# -ge 2 ]] || die "Missing value for --project-root"
      PROJECT_ROOT="$2"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "Unknown argument: $1"
      ;;
  esac
done

[[ "$SCOPE" == "global" || "$SCOPE" == "local" ]] || die "--scope must be global or local"
[[ -n "$DEST" ]] || die "--dest is required"

if [[ -z "$PROJECT_ROOT" ]]; then
  PROJECT_ROOT="$(pwd)"
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
check_runtime_requirements

if [[ -d "$REPO_ROOT/skills" ]]; then
  SOURCE_ROOT="$REPO_ROOT/skills"
else
  die "No skill source directory found (expected skills/)"
fi

SKILL_DIRS=()
for d in "$SOURCE_ROOT"/*; do
  if [[ -d "$d" && -f "$d/SKILL.md" ]]; then
    SKILL_DIRS+=("$d")
  fi
done

if [[ ${#SKILL_DIRS[@]} -gt 1 ]]; then
  IFS=$'\n' SKILL_DIRS=($(printf '%s\n' "${SKILL_DIRS[@]}" | sort))
  unset IFS
fi

[[ ${#SKILL_DIRS[@]} -gt 0 ]] || die "No installable skills were found in $SOURCE_ROOT"

if [[ "$DRY_RUN" -eq 0 ]]; then
  mkdir -p "$DEST"
fi

INSTALLED=0
SKIPPED=0

for skill_dir in "${SKILL_DIRS[@]}"; do
  skill_name="$(basename "$skill_dir")"
  target_dir="$DEST/$skill_name"

  if [[ -e "$target_dir" && "$FORCE" -ne 1 ]]; then
    log WARN "Skill exists, skipping: $target_dir"
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    log INFO "Would install $skill_name -> $target_dir"
    INSTALLED=$((INSTALLED + 1))
    continue
  fi

  if [[ -e "$target_dir" ]]; then
    rm -rf "$target_dir"
  fi

  cp -R "$skill_dir" "$target_dir"
  log OK "Installed $skill_name"
  INSTALLED=$((INSTALLED + 1))
done

if [[ "$SCOPE" == "local" ]]; then
  template="$REPO_ROOT/templates/project-AGENTS.template.md"
  project_agents="$PROJECT_ROOT/AGENTS.md"

  if [[ -f "$template" ]]; then
    if [[ -f "$project_agents" && "$FORCE" -ne 1 ]]; then
      log WARN "AGENTS.md already exists, skipping: $project_agents"
    elif [[ "$DRY_RUN" -eq 1 ]]; then
      log INFO "Would write local AGENTS.md -> $project_agents"
    else
      mkdir -p "$PROJECT_ROOT"
      cp "$template" "$project_agents"
      log OK "Wrote local AGENTS.md"
    fi
  else
    log WARN "Template not found: $template"
  fi
fi

log OK "Done. scope=$SCOPE source=$SOURCE_ROOT dest=$DEST installed=$INSTALLED skipped=$SKIPPED"
