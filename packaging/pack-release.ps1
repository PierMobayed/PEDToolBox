#Requires -Version 5.1
param(
    [switch] $SelfContained,
    [switch] $StoreSku,
    [string] $Runtime = "win-x64"
)

$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
& (Join-Path $PSScriptRoot "publish-exe.ps1") -SelfContained:$SelfContained -Runtime $Runtime -StoreSku:$StoreSku

$exeDir = Join-Path $root "artifacts\exe"
$zipName = if ($StoreSku) { "PEDToolbox-3.1.0-$Runtime-store.zip" } else { "PEDToolbox-3.1.0-$Runtime.zip" }
$zip = Join-Path $root "artifacts\$zipName"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path (Join-Path $exeDir "*") -DestinationPath $zip -Force
$hash = (Get-FileHash $zip -Algorithm SHA256).Hash
$hash | Set-Content (Join-Path $root "artifacts\SHA256.txt")
Write-Host "ZIP  $zip"
Write-Host "SHA256  $hash"
Write-Host "Paste the hash into packaging\winget\PED.Toolbox.installer.yaml after you host this zip."
