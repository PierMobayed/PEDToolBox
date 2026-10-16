# Shared fleet project list (dot-source from scripts/*.ps1).
# ASCII-only. No secrets.

$RepoRulesRoot = 'C:\Pier\repo-rules'

# name -> Path, Branch ('' = detect from origin/HEAD)
$FleetProjects = [ordered]@{
    'nachas'  = @{ Path = 'C:\Pier\bestSmartPrice'; Branch = '' }
    'vesitv'  = @{ Path = 'C:\Pier\tv'; Branch = '' }
    'liko'    = @{ Path = 'C:\Pier\likotv'; Branch = '' }
    'vaya'    = @{ Path = 'C:\Pier\vaya.bg'; Branch = '' }
    'setupai' = @{ Path = 'C:\Pier\setupAI'; Branch = '' }
    'bridge'  = @{ Path = 'C:\Pier\pm-bridge-system'; Branch = '' }
    'ped'     = @{ Path = 'C:\Pier\PEDToolBox'; Branch = 'v3' }
    'rules'   = @{ Path = $RepoRulesRoot; Branch = 'main' }
}

# start-workers.ps1: name -> folder path
$WorkerDirs = [ordered]@{}
foreach ($name in $FleetProjects.Keys) {
    $WorkerDirs[$name] = $FleetProjects[$name].Path
}

function Get-FleetProjectDefaultBranch {
    param(
        [string]$ProjectPath,
        [string]$ConfiguredBranch
    )
    if ($ConfiguredBranch) {
        return $ConfiguredBranch
    }
    if (-not (Test-Path -LiteralPath $ProjectPath)) {
        return 'main'
    }
    $gitDir = Join-Path $ProjectPath '.git'
    if (-not (Test-Path -LiteralPath $gitDir)) {
        return 'main'
    }
    $sym = & git -C $ProjectPath symbolic-ref refs/remotes/origin/HEAD 2>$null
    if ($LASTEXITCODE -eq 0 -and $sym) {
        $ref = $sym.Trim()
        if ($ref -match 'refs/remotes/origin/(.+)$') {
            return $Matches[1]
        }
    }
    return 'main'
}
