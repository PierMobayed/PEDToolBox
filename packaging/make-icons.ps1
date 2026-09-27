#Requires -Version 5.1
param(
    [string] $SourcePng = ""
)

$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
$appAssets = Join-Path $root "src\PedToolbox.App\Assets"
$msixAssets = Join-Path $root "packaging\msix\Assets"
New-Item -ItemType Directory -Force -Path $appAssets, $msixAssets | Out-Null

if (-not $SourcePng) {
    $candidates = @(
        (Join-Path $appAssets "icon-source.png"),
        "$env:USERPROFILE\.cursor\projects\c-Users-PierM-OneDrive-PED-v3\assets\ped-icon-source.png"
    )
    $SourcePng = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
}

if (-not $SourcePng -or -not (Test-Path $SourcePng)) {
    throw "icon-source.png not found. Place it at src\PedToolbox.App\Assets\icon-source.png"
}

Add-Type -AssemblyName System.Drawing

function Save-Png([System.Drawing.Image]$src, [string]$dest, [int]$w, [int]$h, [bool]$letterbox) {
    $bmp = New-Object System.Drawing.Bitmap $w, $h
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::FromArgb(255, 11, 18, 32))
    if ($letterbox) {
        $scale = [Math]::Min($w / [double]$src.Width, $h / [double]$src.Height)
        $dw = [int]($src.Width * $scale)
        $dh = [int]($src.Height * $scale)
        $x = [int](($w - $dw) / 2)
        $y = [int](($h - $dh) / 2)
        $g.DrawImage($src, $x, $y, $dw, $dh)
    } else {
        $g.DrawImage($src, 0, 0, $w, $h)
    }
    $g.Dispose()
    $bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

$destSource = Join-Path $appAssets "icon-source.png"
if ((Resolve-Path $SourcePng).Path -ne (Resolve-Path $destSource -ErrorAction SilentlyContinue).Path) {
    Copy-Item $SourcePng $destSource -Force
}
$src = [System.Drawing.Image]::FromFile($destSource)

Save-Png $src (Join-Path $msixAssets "StoreLogo.png") 50 50 $false
Save-Png $src (Join-Path $msixAssets "Square44x44Logo.png") 44 44 $false
Save-Png $src (Join-Path $msixAssets "Square150x150Logo.png") 150 150 $false
Save-Png $src (Join-Path $msixAssets "Wide310x150Logo.png") 310 150 $true
Save-Png $src (Join-Path $msixAssets "SplashScreen.png") 620 300 $true
Copy-Item (Join-Path $msixAssets "Square150x150Logo.png") (Join-Path $appAssets "app.png") -Force

$tmp32 = Join-Path $env:TEMP "ped-ico-32.png"
Save-Png $src $tmp32 32 32 $false
$loaded = [System.Drawing.Image]::FromFile($tmp32)
$bmp = New-Object System.Drawing.Bitmap $loaded
$loaded.Dispose()
$icoPath = Join-Path $appAssets "app.ico"
$h = $bmp.GetHicon()
$icon = [System.Drawing.Icon]::FromHandle($h)
$fs = [IO.File]::Create($icoPath)
$icon.Save($fs)
$fs.Dispose()
$icon.Dispose()
$bmp.Dispose()
$src.Dispose()

Write-Host "Wrote $icoPath ($((Get-Item $icoPath).Length) bytes) and $msixAssets"
