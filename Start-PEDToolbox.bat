@echo off
setlocal EnableExtensions
cd /d "%~dp0"

REM Double-click this file to build (if needed) and open PED Toolbox.
REM Incremental build is fast after the first run. Packaging is packaging\publish-exe.ps1 later.

where dotnet >nul 2>&1
if errorlevel 1 (
    echo.
    echo  .NET 8 SDK is not on PATH.
    echo  Install: https://dotnet.microsoft.com/download/dotnet/8.0
    echo  Choose the SDK, not only the runtime.
    echo.
    pause
    exit /b 1
)

echo.
echo  PED Toolbox v3  —  building...
echo.
dotnet build "src\PedToolbox.App\PedToolbox.App.csproj" -c Debug --nologo -v q
if errorlevel 1 (
    echo.
    echo  Build failed. Scroll up for errors.
    echo.
    pause
    exit /b 1
)

set "EXE=%~dp0src\PedToolbox.App\bin\Debug\net8.0-windows\PEDToolbox.exe"
if not exist "%EXE%" (
    echo  Built, but EXE is missing:
    echo  %EXE%
    pause
    exit /b 1
)

echo  Starting PED Toolbox...
start "" "%EXE%"
exit /b 0
