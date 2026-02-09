#!/usr/bin/env bash
set -euo pipefail

STATUS_FILE="${1:-bmad/workflow-status.yaml}"

usage() {
  cat <<USAGE
Usage: $(basename "$0") [status_file]

Default status_file: bmad/workflow-status.yaml
USAGE
}

if [[ "$STATUS_FILE" == "-h" || "$STATUS_FILE" == "--help" ]]; then
  usage
  exit 0
fi

if ! command -v yq >/dev/null 2>&1; then
  echo "ERROR: yq v4+ is required" >&2
  exit 1
fi

if [[ ! -f "$STATUS_FILE" ]]; then
  echo "ERROR: status file not found: $STATUS_FILE" >&2
  echo "Hint: run bmad:init first to create project artifacts."
  exit 1
fi

name=$(yq eval -r '.project.name // "unknown"' "$STATUS_FILE")
level=$(yq eval -r '.project.level // "unknown"' "$STATUS_FILE")
current_phase=$(yq eval -r '.current_phase // "unknown"' "$STATUS_FILE")
progress=$(yq eval -r '.metrics.progress_percentage // 0' "$STATUS_FILE")
completed=$(yq eval -r '.metrics.completed_workflows // 0' "$STATUS_FILE")
total=$(yq eval -r '.metrics.total_workflows // 0' "$STATUS_FILE")

print_workflow() {
  local phase_key="$1"
  local workflow_key="$2"
  local display="$3"

  local status
  local done
  status=$(yq eval -r ".phases.${phase_key}.workflows.${workflow_key}.status // \"n/a\"" "$STATUS_FILE")
  done=$(yq eval -r ".phases.${phase_key}.workflows.${workflow_key}.completed // \"\"" "$STATUS_FILE")

  if [[ "$done" == "true" ]]; then
    echo "  [x] ${display}"
  elif [[ "$status" == "required" ]]; then
    echo "  [!] ${display} (required)"
  elif [[ "$status" == "recommended" ]]; then
    echo "  [~] ${display} (recommended)"
  else
    echo "  [ ] ${display} (${status})"
  fi
}

echo "BMAD Workflow Status"
echo "project=${name}"
echo "level=${level}"
echo "current_phase=${current_phase}"
echo "progress=${progress}% (${completed}/${total})"
echo ""

echo "Phase 1: Analysis"
print_workflow phase_1_analysis product_brief "product_brief"
print_workflow phase_1_analysis research "research"
print_workflow phase_1_analysis brainstorm "brainstorm"
echo ""

echo "Phase 2: Planning"
print_workflow phase_2_planning prd "prd"
print_workflow phase_2_planning tech_spec "tech_spec"
print_workflow phase_2_planning ux_design "ux_design"
echo ""

echo "Phase 3: Solutioning"
print_workflow phase_3_solutioning architecture "architecture"
print_workflow phase_3_solutioning gate_check "gate_check"
echo ""

echo "Phase 4: Implementation"
print_workflow phase_4_implementation sprint_planning "sprint_planning"
stories_total=$(yq eval '.phases.phase_4_implementation.workflows.stories.total // 0' "$STATUS_FILE")
stories_done=$(yq eval '.phases.phase_4_implementation.workflows.stories.completed // 0' "$STATUS_FILE")
echo "  [ ] stories (${stories_done}/${stories_total} completed)"
echo ""

SHARED_SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/bmad-shared/scripts"
if [[ -x "$SHARED_SCRIPTS_DIR/next-workflow.sh" ]]; then
  next="$($SHARED_SCRIPTS_DIR/next-workflow.sh "$STATUS_FILE" text)"
  echo "$next"
fi
