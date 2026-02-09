[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("global", "local")]
    [string]$Scope,

    [Parameter(Mandatory = $true)]
    [string]$Dest,

    [string]$ProjectRoot = (Get-Location).Path,

    [switch]$Force,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

function Write-Info([string]$Message) {
    Write-Host "[INFO] $Message" -ForegroundColor Cyan
}

function Write-Ok([string]$Message) {
    Write-Host "[OK] $Message" -ForegroundColor Green
}

function Write-Warn([string]$Message) {
    Write-Host "[WARN] $Message" -ForegroundColor Yellow
}

function Test-RuntimeRequirements {
    $yqCmd = Get-Command yq -ErrorAction SilentlyContinue
    if (-not $yqCmd) {
        throw "yq not found in PATH. Install yq v4+ before running installer."
    }

    $pythonCmd = Get-Command python3 -ErrorAction SilentlyContinue
    if (-not $pythonCmd) {
        $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
    }
    if (-not $pythonCmd) {
        throw "python not found in PATH. Install python3 before running installer."
    }

    $yqVersion = (& yq --version 2>$null)
    $pythonVersion = (& $pythonCmd.Source --version 2>&1)

    if (-not $yqVersion) {
        $yqVersion = "yq detected"
    }
    if (-not $pythonVersion) {
        $pythonVersion = "$($pythonCmd.Name) detected"
    }

    Write-Ok "Runtime check: $yqVersion, $pythonVersion"
}

$RepoRoot = Split-Path -Parent $PSScriptRoot
$SkillsSource = Join-Path $RepoRoot "skills"
Test-RuntimeRequirements

if (-not (Test-Path $SkillsSource)) {
    throw "No skill source directory found (expected skills/)"
}

$SkillDirs = Get-ChildItem -Path $SkillsSource -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") } |
    Sort-Object Name

if ($SkillDirs.Count -eq 0) {
    throw "No installable skills were found in $SkillsSource"
}

if (-not $DryRun) {
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
}

$Installed = 0
$Skipped = 0

foreach ($Skill in $SkillDirs) {
    $Target = Join-Path $Dest $Skill.Name

    if ((Test-Path $Target) -and (-not $Force)) {
        Write-Warn "Skill exists, skipping: $Target"
        $Skipped++
        continue
    }

    if ($DryRun) {
        Write-Info "Would install $($Skill.Name) -> $Target"
        $Installed++
        continue
    }

    if (Test-Path $Target) {
        Remove-Item -Path $Target -Recurse -Force
    }

    Copy-Item -Path $Skill.FullName -Destination $Target -Recurse
    Write-Ok "Installed $($Skill.Name)"
    $Installed++
}

if ($Scope -eq "local") {
    $TemplatePath = Join-Path $RepoRoot "templates/project-AGENTS.template.md"
    $ProjectAgentsPath = Join-Path $ProjectRoot "AGENTS.md"

    if (Test-Path $TemplatePath) {
        if ((Test-Path $ProjectAgentsPath) -and (-not $Force)) {
            Write-Warn "AGENTS.md already exists, skipping: $ProjectAgentsPath"
        }
        elseif ($DryRun) {
            Write-Info "Would write local AGENTS.md -> $ProjectAgentsPath"
        }
        else {
            New-Item -ItemType Directory -Force -Path $ProjectRoot | Out-Null
            Copy-Item -Path $TemplatePath -Destination $ProjectAgentsPath -Force
            Write-Ok "Wrote local AGENTS.md"
        }
    }
    else {
        Write-Warn "Template not found: $TemplatePath"
    }
}

Write-Ok "Done. scope=$Scope source=$SkillsSource dest=$Dest installed=$Installed skipped=$Skipped"
