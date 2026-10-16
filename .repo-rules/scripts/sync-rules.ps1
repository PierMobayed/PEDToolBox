# Sync PierMobayed/repo-rules snapshot into each fleet project's .repo-rules/
# Windows PowerShell 5.1, ASCII-only. No secrets. Never --api-key on argv.
param(
    [switch]$DryRun,
    [string[]]$Only
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'projects.ps1')

function Write-Info([string]$Message) {
    Write-Host $Message
}

function Invoke-Git {
    param(
        [string]$RepoPath,
        [string[]]$GitArgs
    )
    $out = Invoke-GitCore -RepoPath $RepoPath -GitArgs $GitArgs
    if ($LASTEXITCODE -ne 0) {
        throw "git -C $RepoPath $($GitArgs -join ' ') failed: $out"
    }
    return $out
}

function Invoke-GitCore {
    param(
        [string]$RepoPath,
        [string[]]$GitArgs
    )
    $prev = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    $out = & git -C $RepoPath @GitArgs 2>&1
    $ErrorActionPreference = $prev
    if ($out -is [System.Array]) {
        return ($out | ForEach-Object { "$_" }) -join "`n"
    }
    return "$out"
}

function Test-RepoRulesPathExcluded {
    param([string]$RelativePath)
    $rel = $RelativePath -replace '\\', '/'
    $leaf = Split-Path -Leaf $rel
    $lower = $rel.ToLowerInvariant()
    if ($leaf -eq '.env') { return $true }
    if ($leaf -like '*.jks') { return $true }
    if ($leaf -like '*.keystore') { return $true }
    if ($leaf -like '*.pem') { return $true }
    if ($lower -match '(^|[/\\])(key|secret|pass)([/\\]|$)') { return $true }
    if ($lower -match '/(key|secret|pass)/') { return $true }
    return $false
}

function Get-RepoRulesSourceFiles {
    param([string]$SourceRoot)
    $files = @()
    $rootFull = (Resolve-Path -LiteralPath $SourceRoot).Path
    Get-ChildItem -LiteralPath $SourceRoot -Recurse -File -Force | ForEach-Object {
        $rel = $_.FullName.Substring($rootFull.Length).TrimStart('\')
        if ($rel -eq '.git' -or $rel.StartsWith('.git\')) { return }
        if (Test-RepoRulesPathExcluded $rel) { return }
        $files += $rel
    }
    return $files
}

function Sync-RepoRulesTree {
    param(
        [string]$SourceRoot,
        [string]$DestRoot,
        [string]$FullSha,
        [switch]$WhatIf
    )
    if (-not $WhatIf) {
        if (Test-Path -LiteralPath $DestRoot) {
            Remove-Item -LiteralPath $DestRoot -Recurse -Force
        }
        New-Item -ItemType Directory -Path $DestRoot -Force | Out-Null
    }
    $sourceFiles = Get-RepoRulesSourceFiles $SourceRoot
    foreach ($rel in $sourceFiles) {
        $src = Join-Path $SourceRoot $rel
        $dst = Join-Path $DestRoot $rel
        if ($WhatIf) {
            Write-Info "  [dry] copy $rel"
            continue
        }
        $parent = Split-Path -Parent $dst
        if (-not (Test-Path -LiteralPath $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        Copy-Item -LiteralPath $src -Destination $dst -Force
    }
    $gitNested = Join-Path $DestRoot '.git'
    if (-not $WhatIf -and (Test-Path -LiteralPath $gitNested)) {
        Remove-Item -LiteralPath $gitNested -Recurse -Force
    }
    $syncedFrom = Join-Path $DestRoot 'SYNCED_FROM'
    if ($WhatIf) {
        Write-Info "  [dry] write SYNCED_FROM = $FullSha"
    } else {
        Set-Content -LiteralPath $syncedFrom -Value $FullSha -Encoding ascii -NoNewline
    }
}

# Agent heuristic: process command line contains the project folder path, minus the
# long-running My Machines worker started by start-workers.ps1. That worker may appear
# as cmd.exe -> cursor-agent.cmd, powershell.exe -> cursor-agent.ps1, or node.exe -> index.js
# and often has no --name laptop on the visible command line. Treat as worker (not an
# active Code agent in that repo) when argv has 2+ --worker-dir, or cursor-agent + worker.
function Test-IsCursorFleetWorkerProcess {
    param([string]$CommandLine)
    if (-not $CommandLine) { return $false }
    $dirCount = ([regex]::Matches($CommandLine, '--worker-dir')).Count
    if ($dirCount -ge 2) { return $true }
    if ($CommandLine -match 'cursor-agent' -and $CommandLine -match ' worker ') {
        return $true
    }
    return $false
}

function Test-AgentActiveInFolder {
    param([string]$FolderPath)
    $norm = $FolderPath.TrimEnd('\')
    $escaped = [regex]::Escape($norm)
    $procs = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | Where-Object {
        if (-not $_.CommandLine) { return $false }
        if ($_.CommandLine -notmatch $escaped) { return $false }
        if (Test-IsCursorFleetWorkerProcess $_.CommandLine) { return $false }
        return $true
    }
    return [bool]$procs
}

function Test-GitWorkingTreeClean {
    param([string]$RepoPath)
    $status = Invoke-GitCore -RepoPath $RepoPath -GitArgs @('status', '--porcelain', '--untracked-files=no')
    if ($LASTEXITCODE -ne 0) {
        throw "git status failed in ${RepoPath}: $status"
    }
    return -not $status
}

function Test-BranchExists {
    param(
        [string]$RepoPath,
        [string]$BranchName,
        [switch]$LocalOnly
    )
    Invoke-GitCore -RepoPath $RepoPath -GitArgs @('rev-parse', '--verify', $BranchName) | Out-Null
    if ($LASTEXITCODE -eq 0) { return 'local' }
    if ($LocalOnly) { return $null }
    Invoke-GitCore -RepoPath $RepoPath -GitArgs @('fetch', 'origin', $BranchName) | Out-Null
    Invoke-GitCore -RepoPath $RepoPath -GitArgs @('rev-parse', '--verify', "origin/$BranchName") | Out-Null
    if ($LASTEXITCODE -eq 0) { return 'remote' }
    return $null
}

function Get-GitHubCompareUrl {
    param(
        [string]$RepoPath,
        [string]$BaseBranch,
        [string]$HeadBranch
    )
    $remote = (Invoke-Git $RepoPath @('remote', 'get-url', 'origin')).Trim()
    if ($remote -match 'github\.com[:/](.+?)(?:\.git)?$') {
        $slug = $Matches[1]
        return "https://github.com/$slug/compare/$BaseBranch...$HeadBranch?expand=1"
    }
    return $null
}

function Test-GhAvailable {
    $gh = Get-Command gh -ErrorAction SilentlyContinue
    if (-not $gh) { return $false }
    & gh auth status 2>&1 | Out-Null
    return ($LASTEXITCODE -eq 0)
}

$summary = @()

# Step 1: update canonical repo-rules on main
Write-Info "=== repo-rules canonical: $RepoRulesRoot ==="
if ($DryRun) {
    $fullSha = (Invoke-Git $RepoRulesRoot @('rev-parse', 'HEAD')).Trim()
    Write-Info "[dry] would: git -C $RepoRulesRoot checkout main; pull --ff-only"
} else {
    Invoke-Git $RepoRulesRoot @('checkout', 'main') | Out-Null
    Invoke-Git $RepoRulesRoot @('pull', '--ff-only') | Out-Null
    $fullSha = (Invoke-Git $RepoRulesRoot @('rev-parse', 'HEAD')).Trim()
}
$shortSha = $fullSha.Substring(0, 7)
Write-Info "SYNC source SHA: $fullSha ($shortSha)"

$branchName = "chore/sync-repo-rules-$shortSha"
$projectsToRun = @()
foreach ($name in $FleetProjects.Keys) {
    if ($name -eq 'rules') { continue }
    if ($Only -and ($Only.Count -gt 0) -and ($Only -notcontains $name)) { continue }
    $projectsToRun += $name
}

foreach ($name in $projectsToRun) {
    $def = $FleetProjects[$name]
    $folder = $def.Path
    $row = [ordered]@{
        Project = $name
        Updated = 'no'
        Skipped = ''
        PrUrl   = ''
    }

    Write-Info ""
    Write-Info "=== $name -> $folder ==="

    if (-not (Test-Path -LiteralPath $folder)) {
        $row.Skipped = 'folder missing'
        $summary += [pscustomobject]$row
        Write-Info "SKIP: folder missing"
        continue
    }

    $gitDir = Join-Path $folder '.git'
    if (-not (Test-Path -LiteralPath $gitDir)) {
        $row.Skipped = 'not a git repo'
        $summary += [pscustomobject]$row
        Write-Info "SKIP: not a git repo"
        continue
    }

    if (-not (Test-GitWorkingTreeClean $folder)) {
        $row.Skipped = 'dirty working tree (tracked changes)'
        $summary += [pscustomobject]$row
        Write-Info "SKIP: dirty working tree"
        continue
    }

    if (Test-AgentActiveInFolder $folder) {
        $row.Skipped = 'agent process may be active in folder'
        $summary += [pscustomobject]$row
        Write-Info "SKIP: agent may be active (see script header heuristic)"
        continue
    }

    $defaultBranch = Get-FleetProjectDefaultBranch $folder $def.Branch
    Write-Info "default branch: $defaultBranch"

    if ($DryRun) {
        $exists = Test-BranchExists $folder $branchName -LocalOnly
        if ($exists) {
            $row.Skipped = "branch $branchName exists ($exists)"
            $summary += [pscustomobject]$row
            Write-Info "SKIP [dry]: branch exists ($exists)"
            continue
        }
        Write-Info "[dry] would checkout $defaultBranch, pull --ff-only"
        Write-Info "[dry] would create branch $branchName"
        Write-Info "[dry] would replace .repo-rules/ from $RepoRulesRoot"
        Sync-RepoRulesTree -SourceRoot $RepoRulesRoot -DestRoot (Join-Path $folder '.repo-rules') `
            -FullSha $fullSha -WhatIf
        Write-Info "[dry] would commit, push, open PR if diff"
        $row.Updated = 'dry-run'
        $summary += [pscustomobject]$row
        continue
    }

    try {
        Invoke-Git $folder @('checkout', $defaultBranch) | Out-Null
        Invoke-Git $folder @('pull', '--ff-only') | Out-Null

        $exists = Test-BranchExists $folder $branchName
        if ($exists) {
            $row.Skipped = "branch $branchName exists ($exists)"
            $summary += [pscustomobject]$row
            Write-Info "SKIP: branch exists ($exists)"
            continue
        }

        Invoke-Git $folder @('checkout', '-b', $branchName) | Out-Null

        $destRules = Join-Path $folder '.repo-rules'
        Sync-RepoRulesTree -SourceRoot $RepoRulesRoot -DestRoot $destRules -FullSha $fullSha

        $diff = Invoke-GitCore -RepoPath $folder -GitArgs @('status', '--porcelain', '--', '.repo-rules')
        if (-not $diff) {
            Invoke-Git $folder @('checkout', $defaultBranch) | Out-Null
            Invoke-Git $folder @('branch', '-D', $branchName) | Out-Null
            $row.Skipped = 'up to date'
            $summary += [pscustomobject]$row
            Write-Info "up to date (no diff)"
            continue
        }

        Invoke-Git $folder @('add', '.repo-rules') | Out-Null
        $msg = "chore: sync repo-rules ($shortSha)"
        Invoke-Git $folder @('commit', '-m', $msg) | Out-Null
        Invoke-Git $folder @('push', '-u', 'origin', $branchName) | Out-Null

        $prUrl = $null
        if (Test-GhAvailable) {
            $title = "chore: sync repo-rules ($shortSha)"
            $body = "Sync .repo-rules/ from PierMobayed/repo-rules at $fullSha (SYNCED_FROM)."
            Push-Location -LiteralPath $folder
            try {
                $prOut = & gh pr create --base $defaultBranch --head $branchName `
                    --title $title --body $body 2>&1
                if ($LASTEXITCODE -eq 0) {
                    $prUrl = ($prOut | Select-Object -Last 1).ToString().Trim()
                }
            } finally {
                Pop-Location
            }
        }
        if (-not $prUrl) {
            $prUrl = Get-GitHubCompareUrl $folder $defaultBranch $branchName
            Write-Info "Open PR manually: $prUrl"
        } else {
            Write-Info "PR: $prUrl"
        }

        $row.Updated = 'yes'
        $row.PrUrl = $prUrl
        $summary += [pscustomobject]$row
    } catch {
        $row.Skipped = "error: $($_.Exception.Message)"
        $summary += [pscustomobject]$row
        Write-Info "ERROR: $($_.Exception.Message)"
    } finally {
        try {
            Invoke-Git $folder @('checkout', $defaultBranch) | Out-Null
        } catch {
            Write-Info "WARN: could not checkout $defaultBranch"
        }
    }
}

Write-Info ""
Write-Info "=== Summary ==="
$summary | Format-Table -AutoSize Project, Updated, Skipped, PrUrl | Out-String | Write-Host
