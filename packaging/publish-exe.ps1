#Requires -Version 5.1
param(
    [switch] $SelfContained,
    [switch] $StoreSku,
    [string] $Runtime = "win-x64"
)

$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
$out = Join-Path $root "artifacts\exe"
$proj = Join-Path $root "src\PedToolbox.App\PedToolbox.App.csproj"

if (Test-Path $out) { Remove-Item $out -Recurse -Force }
New-Item -ItemType Directory -Force -Path $out | Out-Null

$args = @(
    "publish", $proj,
    "-c", "Release",
    "-r", $Runtime,
    "-o", $out,
    "--nologo",
    "-p:DebugType=None",
    "-p:DebugSymbols=false",
    "-p:StoreSku=$($StoreSku.IsPresent.ToString().ToLowerInvariant())"
)

if ($SelfContained) {
    $args += @("--self-contained", "true", "-p:PublishSingleFile=true", "-p:IncludeNativeLibrariesForSelfExtract=true")
} else {
    $args += @("--self-contained", "false")
}

Write-Host "dotnet $($args -join ' ')"
& dotnet @args
if ($LASTEXITCODE -ne 0) { throw "publish failed" }

Write-Host "Published to $out"
Get-ChildItem $out | Select-Object Name, Length
