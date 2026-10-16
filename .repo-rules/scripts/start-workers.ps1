# Start ONE Cursor My Machines worker named 'laptop' with several --worker-dir.
# Concurrent agents: My Machines (no --pool) - https://cursor.com/docs/cloud-agent/self-hosted
# Never pass --api-key on the command line (visible in process list). Use $env:CURSOR_API_KEY.
# No secrets in this repo.

$ErrorActionPreference = 'Stop'
$WorkerName = 'laptop'
$StateDir = Join-Path $env:LOCALAPPDATA 'cursor-worker-laptop'
$PidFile = Join-Path $StateDir 'worker.pid'
$OutLog = Join-Path $StateDir 'worker.out.log'
$ErrLog = Join-Path $StateDir 'worker.err.log'
$DataDir = Join-Path $StateDir 'data'

# Editable list in projects.ps1. Missing folders are skipped.
. (Join-Path $PSScriptRoot 'projects.ps1')

function Get-BundledCursorAgentDir {
    $versions = Join-Path $env:APPDATA 'Cursor\User\globalStorage\anysphere.cursor-agent-worker\agent-cli\.local\share\cursor-agent\versions'
    if (-not (Test-Path -LiteralPath $versions)) {
        throw "Bundled CLI versions dir not found: $versions"
    }
    $latest = Get-ChildItem -LiteralPath $versions -Directory |
        Where-Object { $_.Name -match '^\d{4}\.\d{1,2}\.\d{1,2}-' } |
        Sort-Object Name -Descending |
        Select-Object -First 1
    if (-not $latest) { throw "No cursor-agent versions matching YYYY.M.D- under $versions" }
    $cmd = Join-Path $latest.FullName 'cursor-agent.cmd'
    if (-not (Test-Path -LiteralPath $cmd)) { throw "cursor-agent.cmd missing in $($latest.FullName)" }
    return $latest.FullName
}

function Test-SqliteLoad([string]$NodeExe, [string]$ModDir) {
    $modJs = ($ModDir -replace '\\', '/')
    $code = "new (require('$modJs'))(':memory:').close()"
    & $NodeExe -e $code
    return ($LASTEXITCODE -eq 0)
}

function Repair-BetterSqlite3([string]$VersionDir) {
    $node = Join-Path $VersionDir 'node.exe'
    $mod = Join-Path $VersionDir 'node_modules\better-sqlite3'
    if (-not (Test-Path -LiteralPath $node)) { throw "node.exe missing in $VersionDir" }
    if (-not (Test-Path -LiteralPath $mod)) {
        Write-Host "better-sqlite3: missing $mod (skip repair)"
        return
    }
    if (Test-SqliteLoad $node $mod) {
        Write-Host 'better-sqlite3: load ok'
        return
    }
    $pkgJson = Get-Content -LiteralPath (Join-Path $mod 'package.json') -Raw | ConvertFrom-Json
    $ver = [string]$pkgJson.version
    $abi = (& $node -p 'process.versions.modules').Trim()
    $asset = "better-sqlite3-v$ver-node-v$abi-win32-x64.tar.gz"
    $url = "https://github.com/WiseLibs/better-sqlite3/releases/download/v$ver/$asset"
    Write-Host "better-sqlite3: download $url"
    $tmp = Join-Path $env:TEMP "better-sqlite3-$ver-$abi"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Recurse -Force }
    New-Item -ItemType Directory -Path $tmp | Out-Null
    $gz = Join-Path $tmp $asset
    Invoke-WebRequest -Uri $url -OutFile $gz -UseBasicParsing
    tar -xzf $gz -C $tmp
    $newNode = Get-ChildItem -LiteralPath $tmp -Recurse -Filter 'better_sqlite3.node' | Select-Object -First 1
    if (-not $newNode) { throw "Downloaded archive has no better_sqlite3.node: $gz" }
    $destDir = Join-Path $mod 'build\Release'
    if (-not (Test-Path -LiteralPath $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
    $dest = Join-Path $destDir 'better_sqlite3.node'
    if (Test-Path -LiteralPath $dest) {
        Copy-Item -LiteralPath $dest -Destination "$dest.bak-abi-mismatch" -Force
    }
    Copy-Item -LiteralPath $newNode.FullName -Destination $dest -Force
    if (-not (Test-SqliteLoad $node $mod)) {
        throw 'better-sqlite3: load still fails after prebuild copy'
    }
    Write-Host 'better-sqlite3: prebuild installed and load ok'
}

function Test-WorkerPidAlive {
    if (-not (Test-Path -LiteralPath $PidFile)) { return $false }
    $raw = (Get-Content -LiteralPath $PidFile -ErrorAction SilentlyContinue | Select-Object -First 1)
    if (-not $raw) { return $false }
    $procId = 0
    if (-not [int]::TryParse($raw.Trim(), [ref]$procId)) { return $false }
    return [bool](Get-Process -Id $procId -ErrorAction SilentlyContinue)
}

function Test-WorkerCmdlineAlive {
    $hits = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | Where-Object {
        $_.CommandLine -and
        $_.CommandLine -match '\bworker\b' -and
        $_.CommandLine -match '--name\s+["'']?laptop["'']?(\s|$)'
    }
    return [bool]$hits
}

function Set-CursorApiKeyEnv {
    $keyFile = Join-Path $env:USERPROFILE '.cursor\cursor-api-key.txt'
    if (Test-Path -LiteralPath $keyFile) {
        $key = (Get-Content -LiteralPath $keyFile -Raw).Trim()
        if ($key) {
            $env:CURSOR_API_KEY = $key
            Write-Host 'CURSOR_API_KEY set from ~/.cursor/cursor-api-key.txt (not on argv)'
            return
        }
    }
    Remove-Item Env:CURSOR_API_KEY -ErrorAction SilentlyContinue
}

$existing = @()
foreach ($name in $WorkerDirs.Keys) {
    $folder = $WorkerDirs[$name]
    if (Test-Path -LiteralPath $folder) {
        $existing += $folder
        Write-Host "dir $name -> $folder"
    } else {
        Write-Host "skip $name - folder missing: $folder"
    }
}
if ($existing.Count -lt 1) { throw 'No worker-dir folders exist. Edit $WorkerDirs.' }

if ((Test-WorkerPidAlive) -or (Test-WorkerCmdlineAlive)) {
    Write-Host "skip start - worker '$WorkerName' already running"
    Write-Host 'Launch agents with worker=laptop (Cursor VM if offline).'
    exit 0
}

$versionDir = Get-BundledCursorAgentDir
$agent = Join-Path $versionDir 'cursor-agent.cmd'
Write-Host "CLI $agent"
Repair-BetterSqlite3 $versionDir

Set-CursorApiKeyEnv
if (-not $env:CURSOR_API_KEY) {
    $status = & $agent status 2>&1 | Out-String
    Write-Host $status
    if ($status -match 'Not logged in') {
        Write-Host 'status: Not logged in - running login'
        & $agent login
    }
}

$dirArgs = @()
foreach ($d in $existing) {
    $dirArgs += @('--worker-dir', $d)
}

if (-not (Test-Path -LiteralPath $StateDir)) {
    New-Item -ItemType Directory -Path $StateDir | Out-Null
}
if (-not (Test-Path -LiteralPath $DataDir)) {
    New-Item -ItemType Directory -Path $DataDir | Out-Null
}

$launchArgs = @('worker') + $dirArgs + @(
    '--name', $WorkerName,
    '--idle-release-timeout', '0',
    '--data-dir', $DataDir,
    'start'
)

Write-Host "start worker=$WorkerName with $($existing.Count) dirs (background)"
$p = Start-Process -FilePath $agent -ArgumentList $launchArgs -WorkingDirectory $existing[0] `
    -WindowStyle Minimized -RedirectStandardOutput $OutLog -RedirectStandardError $ErrLog -PassThru
$p.Id | Set-Content -LiteralPath $PidFile -Encoding ascii
Write-Host "pid $($p.Id) out $OutLog err $ErrLog"
Write-Host 'Launch Product/Code with worker=laptop (no --pool). Cursor VM if this worker is offline.'
