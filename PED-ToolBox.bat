@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::short link: irm t.ly/ped | iex

:m0a.x
::================================
echo Welcome to PED Tool Box
::================================
echo.
::========
:m0a.x0.Version
::================================
:: Set version
set "versionTool=PED-ToolBox-1.263.230816"

:: Portable type: 1
:: Installing type: 0 (or any different than 1)
set portableSwitch=0
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:m0a.x01.DirectoryPED
::================================
::Check if the source file is the same as the destination file
setlocal

rem Define source and destination paths
set "destinationDir=C:\ProgramData\PEDToolBox\"


set "newName=PED-ToolBox.bat"
if /I "%~nx0" NEQ "%newName%" (
    start /w /min cmd /c "ren "%~f0" "%newName%""
	start cmd /c "%~dp0%newName%"
	exit
)


rem Function:
if %portableSwitch% == 1 (
	set "destinationDir=%~dp0"
)

set "sourceFile=%~f0"
set "destinationFile=%destinationDir%PED-ToolBox.bat"

if /I "%sourceFile%" NEQ "%destinationFile%" (
	
	echo Please wait to loading....
	echo.
	echo Please use shortcut on Desktop next time.
	echo Thank you
	timeout 15 
    rem Check if the destination directory exists
    if not exist "%destinationDir%" (
        echo Destination directory does not exist. Creating directory...
        mkdir "%destinationDir%"
    )

    rem Check if the destination file exists
    if exist "%destinationFile%" (
        echo Old file exists. Deleting old file...
        del "%destinationFile%"
    )
	echo.
	echo ...[10%]...
    rem Copy the script to the destination
    echo Copying itself to destination...
    copy "%sourceFile%" "%destinationFile%"
	
	if not exist "%destinationFile%" (
		copy "%sourceFile%" "%destinationFile%"
		
		if not exist "%destinationFile%" (
			echo Failed...
			pause
			exit
		)
	)
	
    ::rem Create a shortcut on the desktop
	echo Creating desktop shortcut...
	set "shortcutToLocation=desktop"
	call :m0a.x12.variableMain
	call :m1a.x02.1.3.createShotcut
    
    rem Start the new version and close this one
    start "" "%destinationFile%"
	cls
    exit
)
endlocal
 

:m0a.x02.getAdmin
::================================
:::::::::::::::::::::::::::::::::::::::::::
:: Automatically check & get admin rights V2
::::::::::::::::::::::::::::::::::::::::::::
CLS
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

NET FILE 1>NUL 2>NUL

if %errorlevel% == 0 goto m0a.x02.gotPrivileges

:m0a.x02.init
::================================
set "vbsGetPrivileges=%temp%\OEgetPriv.vbs"
echo.
echo ...[70%]...

:m0a.x02.getPrivileges
::================================
echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
echo UAC.ShellExecute "%~f0", "max", "", "runas", 3 >> "%vbsGetPrivileges%"
start /w "%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%"
del "%vbsGetPrivileges%" 2>nul
exit

:m0a.x02.gotPrivileges
::================================
setlocal & pushd .
cd /d %~dp0
echo.
echo ...[80%]...
::Max screen
if not "%1"=="max" start /MAX cmd /c %0 max & exit

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::START
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::=======================================
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:m0a.x1
::================================
echo Main Variables
::================================
echo.
::========
:m0a.x11.variable
::================================
set "shortcutToLocation=0"
set "timestamp=0"
set "PEDRecoveryFolder=%SYSTEMDRIVE%\PED-Recovery"
set "fileFunctionDir="
set "fileStart="

:m0a.x12.variableMain
::================================

if %shortcutToLocation% == desktop (
	echo.
	echo ...[20%]...
	set "destinationMain=C:\ProgramData\PEDToolBox"
) else (
	echo.
	echo ...[90%]...
	set "destinationMain=%cd%"
)

set "destinationPD=%destinationMain%\pedDownload"
if not exist "%destinationPD%\." (
	mkdir "%destinationPD%"
)

cd %destinationPD%

call :r3a.x12.downLoadF-files
if %shortcutToLocation% == desktop (
	echo.
	echo ...[30%]...
) else (
	cd files
)

set "startOneClick=0"
set "startOneClickTwo=0"
set "psP=Powershell.exe Set-ExecutionPolicy Bypass -Scope Process -Force;"
set "psC=powershell.exe -ExecutionPolicy Bypass -Command"
set "timeoutA=timeout 2 /nobreak>nul"

if %shortcutToLocation% == desktop (
	echo.
	echo ...[35%]...
	exit /b
)

if exist "c1.txt" (goto m2a.x5.Oneclick5)
echo.
echo.
echo ...[99%]...


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:m0a.x2
::================================
echo First Menu - Permission:
::================================
echo.
::========
:m0a.x21.firstMenu
::================================
cls
set menu=m0a.x21.firstMenu

::Logon Trusted Installer
set "loc=%destinationPD%\Data\0.Drivers\0.2.advancedrun-x64\e1.txt"
if exist "%loc%" (
	del "%loc%"
	goto startPED
)

::Check menu exist
if not exist "%destinationPD%\files\cmdMenuSel.exe" (
	call :r3a.x12.001.downLoadF-filesCMDMenu
)

::=================
::Menu
cls

title Power Every Day
echo.
echo.
echo ========== Account permission ========== 
echo.

set mm=
set mm= %mm% "[ ] Administrator: %username%"
set mm= %mm% "[ ] Trusted Installer"
set mm= %mm% ""
set mm= %mm% "[ ] Download files"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto startPED
if %ERRORLEVEL% == 2 goto m0a.x22.TrustedInstaller
if %ERRORLEVEL% == 3 goto %menu%
if %ERRORLEVEL% == 4 goto r3a.x10.0.downloadList

exit

::=======================================
::=================
:m0a.x22.TrustedInstaller
::================================
call :r3a.x11.0.2.downLoadF-0.2.advancedrun-x64
set "loc=%destinationPD%\Data\0.Drivers\0.2.advancedrun-x64"

echo 1 > "%loc%\e1.txt"
"%loc%\AdvancedRun.exe" /Clear /EXEFilename "%destinationMain%\PED-ToolBox.bat" /RunAs 8 /Run
exit

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:r3a.x
::================================
echo Download_Resources
::================================
pause
::========
:r3a.x01.0.downloadFunction
::================================

if %startOneClick% == 0 (cls)
set "discriptionD1=%fileLocation%"
set "fileLocation=%destination%\%fileLocation%"

if not exist "%fileLocation%" (

	if %startOneClick% == 0 (
		echo.
		echo 	App: %discriptionD1% NOT EXIST
		echo.
	)
	
	if %isItZip% == y (
		echo 	Please wait to DOWNLOAD and Extract %discriptionD1%...
		start /w /min cmd /c powershell.exe -ExecutionPolicy Bypass -Command ^
		"(New-Object System.Net.WebClient).DownloadFile('%fileLinkID%', '%fileLocation%');" ^
		"tar -xf '%fileLocation%' -C '%destination%'"
	) else (
		echo 	Please wait to DOWNLOAD %discriptionD1%...
		start /w /min cmd /c powershell.exe -ExecutionPolicy Bypass -Command ^
		"(New-Object System.Net.WebClient).DownloadFile('%fileLinkID%', '%fileLocation%');" ^
	)

) else (

	if not exist "%startFiles%" (
		echo 	Please wait to Extract %discriptionD1%...
		start /w /min cmd /c powershell.exe -ExecutionPolicy Bypass -Command ^
		"tar -xf '%fileLocation%' -C '%destination%'" 
	)
)

exit /b

::=======================================

:r3a.x10.0.downloadList
::================================

call :r3a.x11.downLoadF-Data
call :r3a.x11.0.downLoadF-0.Drivers
call :r3a.x11.0.1.downLoadF-0.1.Drivers-SDI_R2111
call :r3a.x11.0.2.downLoadF-0.2.advancedrun-x64
call :r3a.x11.0.3.downLoadF-0.3.update
call :r3a.x11.0.3.1.downLoadF-0.3.1.wushowhide
call :r3a.x11.0.3.2.downLoadF-0.3.2.wumt
call :r3a.x11.0.3.3.downLoadF-0.3.3.WAUManager
call :r3a.x11.0.3.4.downLoadF-0.3.4.win10AssistantUpgrade
call :r3a.x11.0.4.downLoadF-0.4.CrystalDiskInfoPortable
call :r3a.x11.1.downLoadF-1.Optimizer
call :r3a.x11.1.1.downLoadF-1.1.Eso
call :r3a.x11.1.2.downLoadF-1.2.ReduceMemory
call :r3a.x11.1.3.downLoadF-1.3.Optimizer
call :r3a.x11.1.4.downLoadF-1.4.OOSU10
call :r3a.x11.1.5.downLoadF-1.5.taskschedulerview
call :r3a.x11.2.downLoadF-2.1.CleanUp-Portable
call :r3a.x11.2.1.downLoadF-2.1.BleachBit-4.4.2-portable
call :r3a.x11.2.2.downLoadF-2.2.OOappBuster
call :r3a.x11.2.3.downLoadF-2.3.GlaryUtilities_Portable
call :r3a.x11.2.4.downLoadF-2.4.RevoUninstaller_Portable
call :r3a.x11.2.5.downLoadF-2.5.WRCFree_10.8.3.704
call :r3a.x11.3.downLoadF-3.Scripts
call :r3a.x11.3.1.downLoadF-3.1.WingetScript
call :r3a.x11.3.2.downLoadF-3.2.speedTest
call :r3a.x12.downLoadF-files
call :r3a.x12.1.downLoadF-bootTimer
call :r3a.x12.2.downLoadF-deleteCmdBloatware
call :r3a.x12.3.downLoadF-taskCommand
call :r3a.x12.4.downLoadF-cpuRam

goto %menu%


::=======================================

:r3a.x11.downLoadF-Data
::================================
set createFolder=Data
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b
::=======================================

:r3a.x11.0.downLoadF-0.Drivers
::================================
set nameFolder=0.Drivers

set "createFolder=Data\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b
::=================

:r3a.x11.0.1.downLoadF-0.1.Drivers-SDI_R2111
::================================
set nameFolder=0.1.Drivers-SDI_R2111

set "createFolder=Data\0.Drivers\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"

set "fileLocation=SDIO_1.12.13.754.zip"
set "isItZip=y"

set "fileLinkID=https://www.glenn.delahoy.com/downloads/sdio/SDIO_1.12.13.754.zip"
call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.0.2.downLoadF-0.2.advancedrun-x64
::================================
set "nameFolder=0.2.advancedrun-x64"
set "createFolder=Data\0.Drivers\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"

set "fileLocation=advancedrun-x64.zip"
set isItZip=y

set "fileLinkID=https://www.nirsoft.net/utils/advancedrun-x64.zip"

call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.0.3.downLoadF-0.3.update
::================================
set "nameFolder=0.3.update"
set "createFolder=Data\0.Drivers\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b
::=================

:r3a.x11.0.3.1.downLoadF-0.3.1.wushowhide
::================================
call :r3a.x11.0.3.downLoadF-0.3.update
set "fileLocation=wushowhide.diagcab"
set isItZip=n

set "fileLinkID=https://download.microsoft.com/download/f/2/2/f22d5fdb-59cd-4275-8c95-1be17bf70b21/wushowhide.diagcab"

call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.0.3.2.downLoadF-0.3.2.wumt
::================================
call :r3a.x11.0.3.downLoadF-0.3.update
set "fileLocation=wumt.zip"
set isItZip=y

set "fileLinkID=https://drive.google.com/u/0/uc?id=0BwJH2CazcjsINFZFc1pVdk9mNHM&export=download&resourcekey=0-LD-TdjUx1rNekTXsKfDCPw"

call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.0.3.3.downLoadF-0.3.3.WAUManager
::================================
call :r3a.x11.0.3.downLoadF-0.3.update
set "fileLocation=WAU Manager.exe"
set isItZip=n

set "fileLinkID=https://www.carifred.com/wau_manager/WAU%%20Manager.exe"

call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.0.3.4.downLoadF-0.3.4.win10AssistantUpgrade
::================================
call :r3a.x11.0.3.downLoadF-0.3.update
set "fileLocation=Windows10Upgrade9252.exe"
set isItZip=n

set "fileLinkID=https://go.microsoft.com/fwlink/?LinkID=799445"

call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.0.4.downLoadF-0.4.CrystalDiskInfoPortable
::================================
set "nameFolder=0.4.CrystalDiskInfoPortable"
set "createFolder=Data\0.Drivers\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"

set "fileLocation=CrystalDiskInfo9_1_1.zip"
set isItZip=y

set "fileLinkID=https://crystalmark.info/redirect.php?product=CrystalDiskInfo"
::https://osdn.net/projects/crystaldiskinfo/downloads/78836/CrystalDiskInfo9_0_1a.zip/
::https://crystalmark.info/en/download/

call :r3a.x01.0.downloadFunction
exit /b
::=================

::=======================================
:r3a.x11.1.downLoadF-1.Optimizer
::================================
set "nameFolder=1.Optimizer"
set "createFolder=Data\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b
::=================

:r3a.x11.1.1.downLoadF-1.1.Eso
::================================
set "nameFolder=1.1.Eso"
set "createFolder=Data\1.Optimizer\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist ("%destination%\.") (
	mkdir "%destination%"
)
set "fileLocation=eso.zip"
set isItZip=y

set "fileLinkID=https://www.sordum.org/files/downloads.php?easy-service-optimizer"
call :r3a.x01.0.downloadFunction


set "destination=%destination%\Eso\"
set "fileLocation=20220525.ini"
set isItZip=n
set "fileLinkID=https://bit.ly/pedbox20220525"
call :r3a.x01.0.downloadFunction


set "fileLocation=20220525-updates.ini"
set isItZip=n
set "fileLinkID=https://bit.ly/3Yt6lqz"
call :r3a.x01.0.downloadFunction


set "fileLocation=eso.ini"
set isItZip=n
set "fileLinkID=https://bit.ly/45cMjCJ"
if exist "%destination%\%fileLocation%" (del "%destination%\%fileLocation%")
call :r3a.x01.0.downloadFunction

exit /b
::=================

:r3a.x11.1.2.downLoadF-1.2.ReduceMemory
::================================
set "nameFolder=1.2.ReduceMemory"
set "createFolder=Data\1.Optimizer\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"

set "fileLocation=ReduceMemory.zip"
set isItZip=y

set "fileLinkID=https://www.sordum.org/files/downloads.php?st-reduce-memory"
call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.1.3.downLoadF-1.3.Optimizer
::================================
set "nameFolder=1.3.Optimizer"
set "createFolder=Data\1.Optimizer\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"

set "fileLocation=Optimizer-15.4.exe"
set isItZip=n

set "fileLinkID=https://github.com/hellzerg/optimizer/releases/download/15.4/Optimizer-15.4.exe"
call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.1.4.downLoadF-1.4.OOSU10
::================================
set "nameFolder=1.4.OOSU10"
set "createFolder=Data\1.Optimizer\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"

set "fileLocation=OOSU10.exe"
set isItZip=n

set "fileLinkID=https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe"
call :r3a.x01.0.downloadFunction

:: config
set "fileLocation=oosu10-default.cfg.file"
set isItZip=n
set "fileLinkID=https://bit.ly/44TKg73"
call :r3a.x01.0.downloadFunction
ren "%destination%\oosu10-default.cfg.file" "oosu10-default.cfg"

set "fileLocation=oosu10-Safe-2205.cfg.file"
set isItZip=n
set "fileLinkID=https://bit.ly/3qiaNvH"
call :r3a.x01.0.downloadFunction
ren "%destination%\oosu10-Safe-2205.cfg.file" "oosu10-Safe-2205.cfg"

exit /b
::=================

:r3a.x11.1.5.downLoadF-1.5.taskschedulerview
::================================
set "nameFolder=1.5.taskschedulerview"
set "createFolder=Data\1.Optimizer\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"

set "fileLocation=taskschedulerview-x64.zip"
set isItZip=y

set "fileLinkID=https://www.nirsoft.net/utils/taskschedulerview-x64.zip"
call :r3a.x01.0.downloadFunction

::Config

set "fileLocation=TaskSchedulerView.cfg.file"
set isItZip=n

set "fileLinkID=https://bit.ly/3QqTsLH"
call :r3a.x01.0.downloadFunction
if exist "%destination%\%fileLocation%" (del "%destination%\%fileLocation%")
ren "%destination%\TaskSchedulerView.cfg.file" "TaskSchedulerView.cfg"

exit /b
::=================

::=======================================
:r3a.x11.2.downLoadF-2.1.CleanUp-Portable
::================================
set "nameFolder=2.1.CleanUp-Portable"
set "createFolder=Data\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b
::=================

:r3a.x11.2.1.downLoadF-2.1.BleachBit-4.4.2-portable
::================================
set "nameFolder=2.1.BleachBit-4.4.2-portable"
set "createFolder=Data\2.1.CleanUp-Portable\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"

set "fileLocation=BleachBit-4.4.2-portable.zip"
set isItZip=y

set "fileLinkID=https://download.bleachbit.org/BleachBit-4.4.2-portable.zip"
call :r3a.x01.0.downloadFunction

::config
set "destination=%destination%\BleachBit-Portable"
set "fileLocation=BleachBit.ini"
set isItZip=n
set "fileLinkID=https://bit.ly/3OGhDoe"
if exist "%destination%\%fileLocation%" (del "%destination%\%fileLocation%")
call :r3a.x01.0.downloadFunction

exit /b
::=================

:r3a.x11.2.2.downLoadF-2.2.OOappBuster
::================================
set "nameFolder=2.2.OOappBuster"
set "createFolder=Data\2.1.CleanUp-Portable\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"


set "fileLocation=OOAPB.exe"
set "fileLinkID=https://dl5.oo-software.com/files/ooappbuster/OOAPB.exe"
set isItZip=n

call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.2.3.downLoadF-2.3.GlaryUtilities_Portable
::================================
set "nameFolder=2.3.GlaryUtilities_Portable"
set "createFolder=Data\2.1.CleanUp-Portable\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
set "fileLocation=guportable.zip"
set "fileLinkID=https://download.glarysoft.com/guportable.zip"
set isItZip=y

call :r3a.x01.0.downloadFunction

REM apply config file
set "destination=%destination%\Portable\data"

set "fileLocation=glaryConfig.guc"
set "fileLinkID=https://bit.ly/3QoTEei"
set isItZip=n
call :r3a.x01.0.downloadFunction

set "fileLocation=rule.ini"
set "fileLinkID=https://bit.ly/3QmCluB"
set isItZip=n
if exist "%destination%\%fileLocation%" (del "%destination%\%fileLocation%")
call :r3a.x01.0.downloadFunction

REM rename config
call :r5a.x2.1.renameGlaryConfig

if exist "%destinationMain%\addCode.bat" (
	CALL %destinationMain%\addCode.bat GUP
)
exit /b
::=================

:r3a.x11.2.4.downLoadF-2.4.RevoUninstaller_Portable
::================================
set "nameFolder=2.4.RevoUninstaller_Portable"
set "createFolder=Data\2.1.CleanUp-Portable\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
set "fileLocation=RevoUninstaller_Portable.zip"
set "fileLinkID=https://download.revouninstaller.com/download/RevoUninstaller_Portable.zip"
set isItZip=y
::pro - RevoUninProSetup.exe - https://download.revouninstaller.com/download/RevoUninProSetup.exe
::proPortList - https://www.revouninstaller.com/revo-uninstaller-pro-full-version-history/
::proPort - revouninproport.zip - https://ed56ffc7823a4332c6e4-21f96328d5ce866ee3a8df01cd3235d5.ssl.cf1.rackcdn.com/revouninproport.zip
if exist "%destinationMain%\addCode.bat" (
	CALL %destinationMain%\addCode.bat RUP
) else (
	call :r3a.x01.0.downloadFunction
)

exit /b
::=================

:r3a.x11.2.5.downLoadF-2.5.WRCFree
::================================
set "nameFolder=2.5.WRCFree"
set "createFolder=Data\2.1.CleanUp-Portable\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"


set "fileLocation=WRCFree_11.0.2.712.zip"
set "fileLinkID=https://downloads.wisecleaner.com/soft/WRCFree_11.0.2.712.zip"
set isItZip=y
::https://www.wisecleaner.com/download.html
call :r3a.x01.0.downloadFunction
exit /b
::=================

::=======================================
:r3a.x11.3.downLoadF-3.Scripts
::================================
set "nameFolder=3.Scripts"
set "createFolder=Data\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b
::=================


:r3a.x11.3.1.downLoadF-3.1.WingetScript
::================================

echo Please wait ...
set "psC=powershell.exe -ExecutionPolicy Bypass -Command"
REM Check if Winget is installed using PowerShell
%psC% "if (-Not (Get-Command winget -ErrorAction SilentlyContinue)) { exit 1 }"

REM Check the exit code of the PowerShell command
if %ERRORLEVEL% equ 1 (
    echo Winget is not installed. Installing...
    
    REM Install Winget using the official installer
    %psC% "iex ((New-Object System.Net.WebClient).DownloadString('https://winget.azureedge.net/releases/winget-cli-latest.msi'))"
    
    echo Winget has been installed successfully.
) else (
    echo Winget is already installed.
)
exit /b
::=================

:r3a.x11.3.2.downLoadF-3.2.speedTest
::================================

::Location
set "nameFolder=speedTest"
set "createFolder=Data\3.Scripts\%nameFolder%"

set "destination=%destinationPD%\%createFolder%"
if not exist "%destination%\." mkdir "%destination%"

::File information
set "fileLocation=ookla-speedtest-1.2.0-win64.zip"
set "fileLinkID=https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip"
set isItZip=y

::Download file
call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.4.01.downLoadF-4.01.norton
::================================
set "nameFolder=01.norton"
set "createFolder=Data\4.Anti-virus\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"


set "fileLocation=NPE.exe"
set "fileLinkID=https://www.norton.com/npe_latest"
set isItZip=n

call :r3a.x01.0.downloadFunction
exit /b
::=================

:r3a.x11.4.02.downLoadF-4.02.kaspersky
::================================
set "nameFolder=02.kaspersky"
set "createFolder=Data\4.Anti-virus\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"


set "fileLocation=KVRT.exe"
set "fileLinkID=https://click.kaspersky.com/?hl=en&version=20.0&pid=kvrt&link=kvrtexe"
set isItZip=n

call :r3a.x01.0.downloadFunction
exit /b
::=================

::================================
:r3a.x12.downLoadF-files
::================================
set "createFolder=files"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b
::=================

:r3a.x12.001.downLoadF-filesCMDMenu
::================================

::Location
call :r3a.x12.downLoadF-files

::File information
set "fileLocation=cmdMenuSel.exe"
set isItZip=n

set "fileLinkID=https://drive.google.com/u/0/uc?id=1Q_fszGnCHXNzgJiSgpDJSvhLrJRjJ8Sl&export=download&confirm=t&uuid=f74c976e-3faf-4cad-bfb0-4a40da99637e&at=ALt4Tm2w_TJAvnfc1XkATAngyMV4:1691166353159"

::Download file
call :r3a.x01.0.downloadFunction
::====
exit /b
::set "fileLinkID=https://github.com/TheBATeam/CmdMenuSel-by-Judago/raw/master/Source%%20Code/Files/cmdmenusel.exe"
::=================

:r3a.x12.002.downLoadF-filesIcons
::================================

::Location
call :r3a.x12.downLoadF-files

::File information
set "fileLocation=shell32_337.ico"
set isItZip=n

set "fileLinkID=https://drive.google.com/u/0/uc?id=13CSuy4zWnlhdHrcKpUB9RNO0cCvCEOYX&export=download"

::Download file
call :r3a.x01.0.downloadFunction

exit /b
::=================

:r3a.x12.1.downLoadF-bootTimer
::================================
set "nameFolder=bootTimer"
set "createFolder=files\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b
::=================

:r3a.x12.2.downLoadF-deleteCmdBloatware
::================================
set "nameFolder=debloatBloatware"
set "createFolder=files\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b
::=================

:r3a.x12.3.downLoadF-taskCommand
::================================
set "nameFolder=taskCommand"
set "createFolder=files\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b
::=======================================

:r3a.x12.4.downLoadF-cpuRam
::================================
set "nameFolder=cpuRam"
set "createFolder=files\%nameFolder%"
set "destination=%destinationPD%\%createFolder%"

if not exist "%destination%\." mkdir "%destination%"
exit /b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:r4a.x
::================================
echo Step 0 : Resources
::================================
pause
::========
:r4a.xPrograms
::========
set menu=r4a.xPrograms

set "menuA=MAIN MENU"
set "menuB=Step 0 : Resource- 1. Programs:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 0.Drivers & Run & More"
set mm= %mm% "-|BACK|- MAIN MENU"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[+] 0.Drivers & Run & More"
set mm= %mm% "[+] 1.Optimizer"
set mm= %mm% "[+] 2.1.CleanUp-Portable"
set mm= %mm% "[+] 3.Uninstaller"
set mm= %mm% "[+] 3.Debloat Windows 10"

cmdmenusel e370 %mm%
   
if %ERRORLEVEL% == 1 goto r4a.x0.Drivers
if %ERRORLEVEL% == 2 goto mainMenu
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto r4a.x0.Drivers
if %ERRORLEVEL% == 7 (
	set menuA=1. Programs
	set menuB=1. Optimizer
	set menuNextName=CleanUp-Portable
	set menuNextGoto=r4a.x2.CleanUp-Portable
	set menuBackName=Programs
	set menuBackGoto=r4a.xPrograms
	goto r4a.x1.Optimizer
)
if %ERRORLEVEL% == 8 (
	set menu1=r4a.x2.CleanUp-Portable
	set menuA=1. Programs
	set menuB=2.1. CleanUp-Portable
	set menuNextName=3.Uninstaller
	set menuNextGoto=r4a.x3.Uninstaller
	set menuBackName=Programs
	set menuBackGoto=r4a.xPrograms
	goto r4a.x2.CleanUp-Portable
)
if %ERRORLEVEL% == 9 (
	set menu1=r4a.x3.Uninstaller
	set menuA=1. Programs:
	set menuB=3.Uninstaller
	set menuNextName=4. Debloat Windows 10
	set menuNextGoto=r4a.x4.DebloatWindows
	set menuBackName=Programs
	set menuBackGoto=r4a.xPrograms
	goto r4a.x3.Uninstaller
)
if %ERRORLEVEL% == 10 (
	set menuA=1. Programs
	set menuB=3. Debloat Windows 10
	set menuNextName=Accounts and Users
	set menuNextGoto=m1a.x02.4.AccountsUsers
	set menuBackName=Programs
	set menuBackGoto=r4a.xPrograms
	goto r4a.x4.DebloatWindows
)

:r4a.x0.Drivers
::================================
set menu=r4a.x0.Drivers

set "menuA=1. Programs:"
set "menuB=0.Drivers - Run - More:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Optimizer"
set mm= %mm% "-|BACK|- Programs"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] r4a.xSnappy driver installer"
set mm= %mm% "[ ] m1a.x02.4.advancedrun-x64"
set mm= %mm% "[ p ] 0.3.Back up Drivers"
set mm= %mm% "[ ] 0.4.CrystalDiskInfoPortable"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 (
	set menuA=1. Programs
	set menuB=1. Optimizer
	set menuNextName=CleanUp-Portable
	set menuNextGoto=r4a.x2.CleanUp-Portable
	set menuBackName=Programs
	set menuBackGoto=r4a.xPrograms
	goto r4a.x1.Optimizer
)
if %ERRORLEVEL% == 2 goto r4a.xPrograms
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%
if %ERRORLEVEL% == 6 goto r4a.x0.1.SDI
if %ERRORLEVEL% == 7 goto r4a.x0.2.advRun
if %ERRORLEVEL% == 8 goto r4a.x0.3.1.backUpDriversGlaryUtilities
if %ERRORLEVEL% == 9 goto r4a.x0.4.CrystalDiskInfoPortable

:r4a.x0.1.SDI
::================================
cls
set "downloadFiles=:r3a.x11.0.1.downLoadF-0.1.Drivers-SDI_R2111"
set "directoryFiles=Data\0.Drivers\0.1.Drivers-SDI_R2111"
set "nameFiles=SDIO_auto.bat"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)
start cmd /c %startFiles%

goto %menu%

:r4a.x0.2.advRun
::================================
cls
set "downloadFiles=:r3a.x11.0.2.downLoadF-0.2.advancedrun-x64"
set "directoryFiles=Data\0.Drivers\0.2.advancedrun-x64"
set "nameFiles=AdvancedRun.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist %startFiles% (
	call %downloadFiles%
)
start %startFiles%

goto %menu%

:r4a.x0.3.1.backUpDriversGlaryUtilities
::================================
cls
set "downloadFiles=:r3a.x11.2.3.downLoadF-2.3.GlaryUtilities_Portable"
set "directoryFiles=Data\2.1.CleanUp-Portable\2.3.GlaryUtilities_Portable\Portable"
set "nameFiles=DriverBackup.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)
start %startFiles%

goto %menu%

:r4a.x0.3.2.startupManagerGlaryUtility
::================================
if startOneClick == 0 (cls)

set "downloadFiles=:r3a.x11.2.3.downLoadF-2.3.GlaryUtilities_Portable"
set "directoryFiles=Data\2.1.CleanUp-Portable\2.3.GlaryUtilities_Portable\Portable"
set "nameFiles=StartupManager.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)
start /w %startFiles%

if startOneClick == 1 (
	exit /b
)
goto %menu%


:r4a.x0.4.CrystalDiskInfoPortable
::================================

cls
set "downloadFiles=:r3a.x11.0.4.downLoadF-0.4.CrystalDiskInfoPortable"
set "directoryFiles=Data\0.Drivers\0.4.CrystalDiskInfoPortable"
set "nameFiles=DiskInfo64.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)
IF %PROCESSOR_ARCHITECTURE% == x86 (
	start cmd /c %destinationPD%\%directoryFiles%\DiskInfo32.exe
) else (
	start cmd /c %destinationPD%\%directoryFiles%\DiskInfo64.exe
)

goto %menu%


:r4a.x0.5.1.startUpdates
::================================
call :r3a.x11.1.1.downLoadF-1.1.Eso
start %destinationPD%\Data\1.Optimizer\1.1.Eso\Eso\eso.exe /A /G=2 20220525-updates.ini
exit /b

:r4a.x0.5.2.showHideUpdates
::================================
call :r3a.x11.0.3.1.downLoadF-0.3.1.wushowhide
start %destinationPD%\Data\0.Drivers\0.3.update\wushowhide.diagcab
goto %menu%

:r4a.x0.5.3.windowsUpdateTool
::================================
call :r3a.x11.0.3.4.downLoadF-0.3.4.win10AssistantUpgrade
start %destinationPD%\Data\0.Drivers\0.3.update\Windows10Upgrade9252.exe
goto %menu%

:r4a.x0.5.4.windowsAutomaticUpdatesManager
::================================
call :r3a.x11.0.3.3.downLoadF-0.3.3.WAUManager
start %destinationPD%\Data\0.Drivers\0.3.update\WAUManager.exe
goto %menu%

:r4a.x0.5.5.windowsUpdateMiniTool
::================================
call :r3a.x11.0.3.2.downLoadF-0.3.2.wumt
start %destinationPD%\Data\0.Drivers\0.3.update\wumt_x64.exe
goto %menu%

:r4a.x0.6.speedTest
::================================
cls
set "downloadFiles=:r3a.x11.3.2.downLoadF-3.2.speedTest"
set "directoryFiles=Data\3.Scripts\speedTest"
set "nameFiles=speedtest.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)

start cmd /c "%startFiles% -%speedTestFile% && pause"

goto %menu%

::start cmd /c "%startFiles% -b && pause"
::start cmd /c "%startFiles% -B && pause"
::start cmd /c "%startFiles% -a && pause"
::start cmd /c "%startFiles% -A && pause"

:r4a.x1.Optimizer
::================================
set menu=r4a.x1.Optimizer

call :mStyle

set mm=
set mm= %mm% "------- Config Optimize programs -------"
set mm= %mm% "[ p ] 1.Easy Services Optimizer"
set mm= %mm% "[ p ] 2.O&O Shutup - Privacy Blocker "
set mm= %mm% "[ p ] 3.Reduce Memory"
set mm= %mm% ""
set mm= %mm% "------- More: -------"
set mm= %mm% "[ p ] Optimizer.exe"
set mm= %mm% "[ p ] TaskSchedulerView.exe"

cmdmenusel e370 "-|NEXT|- %menuNextName%" "-|BACK|- %menuBackName%" "-|MAIN MENU|- " "========== Select an option ==========" "" %mm%

if %ERRORLEVEL% == 1 (
	if %menuBackGoto% == r4a.xPrograms (
		set menu1=r4a.x2.CleanUp-Portable
		set menuA=1. Programs
		set menuB=2.1. CleanUp-Portable
		set menuNextName=3.Uninstaller
		set menuNextGoto=r4a.x3.Uninstaller
		set menuBackName=Programs
		set menuBackGoto=r4a.xPrograms
	)
	goto %menuNextGoto%
)
if %ERRORLEVEL% == 2 goto %menuBackGoto%
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto %menu%
if %ERRORLEVEL% == 7 goto r4a.x1.1.eso
if %ERRORLEVEL% == 8 goto r4a.x1.4.OOSU10
if %ERRORLEVEL% == 9 goto r4a.x1.2.reduceMemory
if %ERRORLEVEL% == 10 goto %menu%
if %ERRORLEVEL% == 11 goto %menu%
if %ERRORLEVEL% == 12 goto r4a.x1.3.Optimizer
if %ERRORLEVEL% == 13 goto r4a.x1.5.taskschedulerview

goto %menu%
:r4a.x1.1.eso
::================================
if %startOneClick% == 0 (cls)

set "downloadFiles=:r3a.x11.1.1.downLoadF-1.1.Eso"
set "directoryFiles=Data\1.Optimizer\1.1.Eso\Eso"
set "nameFiles=eso.exe"

::Function
set startFiles=%destinationPD%\%directoryFiles%\%nameFiles%
if not exist %startFiles% (
	call %downloadFiles%
)

if %startOneClick% == 1 (
	if %optimizeP% == 1 (
		%startFiles% /A /G=2 20220525.ini
	) else (
		%startFiles% /A /G=1 20220525.ini
	)
	exit /b
) else (
	start %startFiles%
)

goto %menu%

:r4a.x1.2.reduceMemory
::================================
if %startOneClick% == 0 (cls)
set "downloadFiles=:r3a.x11.1.2.downLoadF-1.2.ReduceMemory"
set "directoryFiles=Data\1.Optimizer\1.2.ReduceMemory\ReduceMemory"
set "nameFiles=reduceMemory_x64.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)

set "startFiles=%destinationPD%\%directoryFiles%"
if %startOneClick% == 1 (
	IF %PROCESSOR_ARCHITECTURE% == x86 (
		%startFiles%\reduceMemory.exe /O
	) else (
		%startFiles%\reduceMemory_x64.exe /O
	)
	exit /b
) else (
	IF %PROCESSOR_ARCHITECTURE% == x86 (
		start %startFiles%\ReduceMemory.exe
	) else (
		start %startFiles%\ReduceMemory_x64.exe
	)
)

goto %menu%

:r4a.x1.3.Optimizer
::================================
cls
set "downloadFiles=:r3a.x11.1.3.downLoadF-1.3.Optimizer"
set "directoryFiles=Data\1.Optimizer\1.3.Optimizer"
set "nameFiles=Optimizer-15.4.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)
start cmd /c %startFiles%

goto %menu%

:r4a.x1.4.OOSU10
::================================
if %startOneClick% == 0 (cls)
set "downloadFiles=:r3a.x11.1.4.downLoadF-1.4.OOSU10"
set "directoryFiles=Data\1.Optimizer\1.4.OOSU10"
set "nameFiles=OOSU10.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)

if %startOneClick% == 1 (
	
	if %optimizeP% == 1 (
		echo cd %destinationPD%\%directoryFiles% > %destinationPD%\%directoryFiles%\OOSU10S.bat
		echo OOSU10.exe oosu10-Safe-2205.cfg /quiet >> %destinationPD%\%directoryFiles%\OOSU10S.bat
		start /w /min cmd /c "%destinationPD%\%directoryFiles%\OOSU10S.bat"
	) else (
		echo cd %destinationPD%\%directoryFiles% > %destinationPD%\%directoryFiles%\OOSU10D.bat
		echo OOSU10.exe oosu10-default.cfg /quiet >> %destinationPD%\%directoryFiles%\OOSU10D.bat
		start /w /min cmd /c "%destinationPD%\%directoryFiles%\OOSU10D.bat"
	)

	exit /b
) else (
	start cmd /c %startFiles%
)

goto %menu%

:r4a.x1.5.taskschedulerview
::================================
cls
set "downloadFiles=:r3a.x11.1.5.downLoadF-1.5.taskschedulerview"
set "directoryFiles=Data\1.Optimizer\1.5.taskschedulerview"
set "nameFiles=TaskSchedulerView.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
call %downloadFiles%
)
start cmd /c %startFiles%

goto %menu%

:r4a.x2.CleanUp-Portable
::================================
set menu=%menu1%

set "menuA= %menuA%:"
set "menuB= %menuB%:"

call :mStyle

set mm=
set mm= %mm% "-|NEXT|- %menuNextName%"
set mm= %mm% "-|BACK|- %menuBackName%"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 2.1.Bleachbit"
set mm= %mm% "[ p ] 2.2.Disk Cleanup"
set mm= %mm% "[ p ] 2.3.GlaryUtilities_Portable"
set mm= %mm% "[ p ] 2.4.wiseRegCleaner"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 (
	if %menu% == m1a.x6.cleanUpJunkfiles (
		goto %menuNextGoto%
	) else (
	set menu1=r4a.x3.Uninstaller
	set menuA=1. Programs:
	set menuB=3.Uninstaller:
	set menuNextName=4. Debloat Windows 10
	set menuNextGoto=r4a.x4.DebloatWindows
	set menuBackName=Programs
	set menuBackGoto=r4a.xPrograms
	goto r4a.x3.Uninstaller
	)
)
if %ERRORLEVEL% == 2 goto %menuBackGoto%
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto r4a.x2.1.Bleachbit
if %ERRORLEVEL% == 7 goto r4a.x2.2.DiskCleanup
if %ERRORLEVEL% == 8 goto r4a.x2.3.GlaryUtilitiesPortable
if %ERRORLEVEL% == 9 goto r4a.x2.4.wiseRegCleaner

goto %menu%

:r4a.x2.1.Bleachbit
::================================
if %startOneClick% == 0 (cls)
set "downloadFiles=:r3a.x11.2.1.downLoadF-2.1.BleachBit-4.4.2-portable"
set "directoryFiles=Data\2.1.CleanUp-Portable\2.1.BleachBit-4.4.2-portable\BleachBit-Portable"
set "nameFiles=bleachbit.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)

if %startOneClick% == 1 (
	call :r4a.x2.1.1.BleachbitOneClick
	exit /b
) else (
	echo Please wait bleachbit will start after 20 seconds ...
	start %startFiles%
	%timeoutA%
)

goto %menu%

:r4a.x2.1.1.BleachbitOneClick
set "directoryFiles=Data\2.1.CleanUp-Portable\2.1.BleachBit-4.4.2-portable\BleachBit-Portable"
set "configFile=BleachBit.ini"
set "consoleFile=bleachbit_console.exe"

::Function
set "startConfigFile=%destinationPD%\%directoryFiles%\%configFile%"
for /f "delims=:" %%A in ('findstr /n "tree" %startConfigFile%') do set "lineNo=%%A"

set "startConsoleFile=%destinationPD%\%directoryFiles%\%consoleFile%"
start /w /min cmd /c "echo off && for /f "usebackq skip=%lineNo% tokens=1,2 delims== " %%G IN ("%startConfigFile%") DO (if "%%H"=="True" (Echo.%%G | findstr /C:".">nul && (if not errorlevel 1 (%startConsoleFile% -c %%G))))"

::start /w /min cmd /c "echo off && FOR /F "usebackq skip=%lineNo% tokens=1 delims= " %%G IN ("%startConfigFile%") DO (Echo.%%G | findstr /C:".">nul && (%startConsoleFile% -c %%G))"
exit /b

:r4a.x2.2.DiskCleanup
::================================
cls
echo.
start cleanmgr.exe 
cmdmenusel e370 "Clean - all -fast " "BACK" 
if %ERRORLEVEL% == 1 cmd /c cleanmgr.exe /d C: /VERYLOWDISK
goto %menu%

:r4a.x2.3.GlaryUtilitiesPortable
::================================
if %startOneClick% == 0 (cls)
set "downloadFiles=:r3a.x11.2.3.downLoadF-2.3.GlaryUtilities_Portable"
set "directoryFiles=Data\2.1.CleanUp-Portable\2.3.GlaryUtilities_Portable"
set "nameFiles=Integrator_Portable.exe"
set "nameComand=OneClickMaintenance.exe /schedulestart"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)

set "startComand=%destinationPD%\%directoryFiles%\Portable\%nameComand%"
if %startOneClick% == 1 (
	start /w %startComand%
	exit /b
) else (
	start cmd /c %startFiles%
)

goto %menu%

:r4a.x2.4.wiseRegCleaner
::================================
if %startOneClick% == 0 (cls)
set "downloadFiles=:r3a.x11.2.5.downLoadF-2.5.WRCFree"
set "directoryFiles=Data\2.1.CleanUp-Portable\2.5.WRCFree\WRCFree_11.0.2.712"
set "nameFiles=WiseRegCleaner.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
)

if %startOneClick% == 1 (
	start /w %startFiles% -a
	exit /b
) else (
	start %startFiles%
)

goto %menu%

:r4a.x3.Uninstaller
::================================
set menu=%menu1%

call :mStyle

set mm=
set mm= %mm% "-|NEXT|- %menuNextName%"
set mm= %mm% "-|BACK|- %menuBackName%"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Revo Uninstaller Portable"
set mm= %mm% "[ p ] 2.OOappBuster"
set mm= %mm% ""
set mm= %mm% "[+] PED:Debloat -Delete unwanted Bloatware:"
set mm= %mm% ""
set mm= %mm% "[ ] GridView | Remove-AppxPackage"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 (
	set menuA=1. Programs
	set menuB=3. Debloat Windows 10
	set menuNextName=Accounts and Users
	set menuNextGoto=m1a.x02.4.AccountsUsers
	set menuBackName=Programs
	set menuBackGoto=r4a.xPrograms
	goto %menuNextGoto%
)
if %ERRORLEVEL% == 2 goto %menuBackGoto%
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto r4a.x3.1.RevoUninstallerPortable
if %ERRORLEVEL% == 7 goto r4a.x3.2.OOappBuster
if %ERRORLEVEL% == 8 goto %menu%

if %ERRORLEVEL% == 9 goto m1a.x3.2.1.debloat
if %ERRORLEVEL% == 10 goto %menu%
if %ERRORLEVEL% == 11 %psP% "Get-AppxPackage | Select Name, InstallLocation | Out-GridView -PassThru | Remove-AppxPackage"

goto %menu%

:r4a.x3.1.RevoUninstallerPortable
::================================
cls
set "downloadFiles=:r3a.x11.2.4.downLoadF-2.4.RevoUninstaller_Portable"
set "directoryFiles=Data\2.1.CleanUp-Portable\2.4.RevoUninstaller_Portable\RevoUninstaller_Portable"
set "nameFiles=RevoUPort.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
call %downloadFiles%
)
start %startFiles%

goto %menu%

:r4a.x3.2.OOappBuster
::================================
cls
set "downloadFiles=:r3a.x11.2.2.downLoadF-2.2.OOappBuster"
set "directoryFiles=Data\2.1.CleanUp-Portable\2.2.OOappBuster"
set "nameFiles=OOAPB.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
call %downloadFiles%
)
start %startFiles%

goto %menu%

:r4a.x4.DebloatWindows
::================================
set menu=r4a.x4.DebloatWindows

call :mStyle

set mm=
set mm= %mm% "-|NEXT|- %menuNextName%"
set mm= %mm% "-|BACK|- %menuBackName%"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[+] 3.1.Win10Debloater-master"
set mm= %mm% "[+] 3.2.ChrisTitusTech Win10script"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto %menuNextGoto%
if %ERRORLEVEL% == 2 goto %menuBackGoto%
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%
if %ERRORLEVEL% == 6 powershell "& "iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/debloat'))""
if %ERRORLEVEL% == 7 powershell "& "iex ((New-Object System.Net.WebClient).DownloadString('https://christitus.com/win'))""

goto %menu%

::"[+] 3.1.Win10Debloater-master" "[+] 3.2.ChrisTitusTech Win10script" "[ ] 3.3.FULL Win10 Debloat" "[ ] 3.4.Sophia.Script.Win10.v5.12.5" "[ ] 3.5.beta- for check - Windows-10-batch-optimizer-master" "[ ] 3.6.Windows10DebloaterV18" "[ ] 3.7.Windows10NetworkandOptimizerV11" "[ ] 3.8.Reg & ,Bat"


:r4a.x5.01.norton
::================================
cls

set "nameFiles=NPE.exe"
set "directoryFiles=Data\4.Anti-virus\01.norton"
set "downloadFiles=:r3a.x11.4.01.downLoadF-4.01.norton"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
call %downloadFiles%
)
start %startFiles%

goto %menu%

:r4a.x5.02.kaspersky
::================================
cls
set "downloadFiles=:r3a.x11.4.02.downLoadF-4.02.kaspersky"
set "directoryFiles=Data\4.Anti-virus\02.kaspersky"
set "nameFiles=KVRT.exe"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
call %downloadFiles%
)
start %startFiles%

goto %menu%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:startPED
::================================
set menu=startPED

set "destination=C:\ProgramData\PEDToolBox"
if not exist "%destination%\." mkdir "%destination%"

goto SetTitle

::::::::::::::::::::::::::::
:mStyle
if %menuC% == onlyB goto mStyleB
:mStyleA
cls
%menuD1%
echo ====================================================
echo =========[-] %menuA%
echo.	  ^|
echo 	   =========^>^>^> %menuB%: ^<^<^<=========
%menuD2%
if %menuC% == onlyA goto mStyleC
:mStyleB
echo.
echo ----------------------------------------------------
echo [^+] -Options ^|  [p] -Preferred choice - [d] -Defaut
echo ----------------------------------------------------
:mStyleC
echo ======================= Menu =======================
echo.
set menuC=A
exit /b
::::::::::::::::::::::::::::

:SetTitle
::================================
set title=title Power Every Day - ToolBox
%title%

:SetColor
::================================
cls
set color1=COLOR 0A
%color1%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:m1a.x
::================================
echo Main Menu
::================================
echo.
::========
:mainMenu
::========
set menu=mainMenu
set startOneClick=0
set optimizeP=2
set "loc=0"

cls
echo Account: %username%
echo.
echo ========== Power Every Day - ToolBox
echo.
echo version: %versionTool%

set menuC=onlyB
call :mStyle

if not exist "%UserProfile%\Desktop\PED-ToolBox.lnk" (set "loc=1")
set mm=
set mm= %mm% "[+] ------ : Create a restore point:"
set mm= %mm% "[+] Step 0 : Test and Diagnostic:"
set mm= %mm% ""
set mm= %mm% "[+] Step 1 : System Check -Update/Repair/Scan:"
set mm= %mm% "[+] Step 2 : Privacy Settings"
set mm= %mm% "[+] Step 3 : Programs -Install/Uninstall/Update"
set mm= %mm% "[+] Step 4 : Clean Up -StartUp/StartMenu/Explorer"
set mm= %mm% "[+] Step 5 : Optimizing Programs"
set mm= %mm% "[+] Step 6 : Clean Up Junk files "
set mm= %mm% ""
set mm= %mm% "[+] Step 7 : Turn on\off apps"
set mm= %mm% ""
set mm= %mm% "[+] Power Menu"
set mm= %mm% ""
set mm= %mm% "[ ] One Click Maintenance and Clean"
if %loc% == 1 (set mm= %mm% "")
if %loc% == 1 (set mm= %mm% "[ p ] Create Shortcut to Desktop")

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x01.restorePoint
if %ERRORLEVEL% == 2 goto m1a.x02.testDiagnostic

if %ERRORLEVEL% == 3 goto %menu%
if %ERRORLEVEL% == 4 set menuBackName=Main Menu && set menuBackGoto=mainMenu && goto m1a.x1.systemCheck
if %ERRORLEVEL% == 5 goto m1a.x2.settings
if %ERRORLEVEL% == 6 goto m1a.x3.installUninstallUpdate
if %ERRORLEVEL% == 7 goto m1a.x4.cleanUp
if %ERRORLEVEL% == 8 goto m1a.x5.optimizingPrograms
if %ERRORLEVEL% == 9 goto m1a.x6.cleanUpJunkfiles
if %ERRORLEVEL% == 10 goto %menu%
if %ERRORLEVEL% == 11 set menuBackName=Main Menu && set menuBackGoto=mainMenu && goto m1a.x7.turnApps
if %ERRORLEVEL% == 12 goto %menu%
if %ERRORLEVEL% == 13 goto m9a.x0.Restart
if %ERRORLEVEL% == 14 goto %menu%
if %ERRORLEVEL% == 15 goto m2a.x01.Oneclick
if %loc% == 1 (
	if %ERRORLEVEL% == 16 goto %menu%
	)
if %loc% == 1 (
	if %ERRORLEVEL% == 17 (
		set "shortcutToLocation=desktop"
		call :m1a.x02.1.3.createShotcut
		set "shortcutToLocation=0"
	)
)

goto %menu%


:m1a.x01.restorePoint
::================================
set menu=m1a.x01.restorePoint

if not exist "%PEDRecoveryFolder%\." mkdir "%PEDRecoveryFolder%"

set "menuA= Main Menu:"
set "menuB= Create a restore point:"
call :mStyle

set mm= "-|NEXT|- Step 0 : Test and Diagnostic:" 
set mm= %mm% "-|BACK|- Main Menu:"
set mm= %mm% "-|MAIN MENU|- " "========== Select an option ==========" ""
set mm= %mm% "---------- Create a restore point ----------"
set mm= %mm% "[ p ] 1. View Configurations"
set mm= %mm% ""
set mm= %mm% "[ p ] 2. Create point (CMD fast)"
set mm= %mm% "[ ] 2. Create point(Powershell with loading bar)"
set mm= %mm% ""
set mm= %mm% "[ p ] 3. View point by PowerShell"
set mm= %mm% "[ p ] 3. View point and Restore"
set mm= %mm% ""
set mm= %mm% "---------- PED backup (CMD)----------"
set mm= %mm% "[ p ] Registry backup "
set mm= %mm% "[ p ] Scheduled Tasks backup "
set mm= %mm% "[ p ] Services backup "
set mm= %mm% "[ p ] WinKey backup "
set mm= %mm% "[ p ] Start Menu layout backup "
set mm= %mm% ""
set mm= %mm% "[ p ] Open PED-Recovery Folder"

cmdmenusel e370 %mm%    
if %ERRORLEVEL% == 1 goto m1a.x02.testDiagnostic
if %ERRORLEVEL% == 2 goto mainMenu
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto %menu%
if %ERRORLEVEL% == 7 start SystemPropertiesProtection.exe
if %ERRORLEVEL% == 8 goto %menu%
if %ERRORLEVEL% == 9 start cmd.exe /c "wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "PED-RestorePoint-cmd", 100, 7" 
if %ERRORLEVEL% == 10 powershell.exe -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'PED-Restore Point' -RestorePointType 'MODIFY_SETTINGS'"
if %ERRORLEVEL% == 11 goto %menu%
if %ERRORLEVEL% == 12 (
	powershell "Get-ComputerRestorePoint | Format-Table -Property Description, SequenceNumber, CreationTime"
	goto m1a.x02.1.3.0.end
)
if %ERRORLEVEL% == 13 start rstrui.exe
if %ERRORLEVEL% == 14 goto %menu%
if %ERRORLEVEL% == 15 goto %menu%
if %ERRORLEVEL% == 16 goto m1a.x01.1.registryBackup
if %ERRORLEVEL% == 17 (
	call :r5a.x3.1.tasksBackup
)
if %ERRORLEVEL% == 18 (
	call :r5a.x3.2.servicesBackup
)
if %ERRORLEVEL% == 19 (
	call :m1a.x01.2.WinKeyBackup
)
if %ERRORLEVEL% == 20 %psP% "Export-StartLayout -Path "%PEDRecoveryFolder%\StartMenuBackup.xml""
if %ERRORLEVEL% == 21 goto %menu%
if %ERRORLEVEL% == 22 start %windir%\explorer.exe "%PEDRecoveryFolder%"


goto %menu%
pause
exit
:m1a.x01.0.timestamp
::================================
:: Initialize variables

REM Get the current date and time using WMIC
for /f "delims=" %%a in ('wmic os get LocalDateTime ^| find "."') do set datetime=%%a

REM Extract date and time components from the LocalDateTime
set "year=%datetime:~0,4%"
set "month=%datetime:~4,2%"
set "day=%datetime:~6,2%"
set "hour=%datetime:~8,2%"
set "minute=%datetime:~10,2%"
set "second=%datetime:~12,2%"

REM Display the date and time components
::echo Year: %year%
::echo Month: %month%
::echo Day: %day%
::echo Hour: %hour%
::echo Minute: %minute%
::echo Second: %second%

REM You can use these variables as needed in your script
REM For example, to create a custom formatted timestamp
set "timestamp=%year%%month%%day%_%hour%%minute%%second%"
::echo Current Time: %timestamp%

exit /b

:m1a.x01.1.registryBackup
::================================
cls

call :m1a.x01.0.timestamp
echo Current Time: %timestamp%

setlocal
echo.
set registryFileName=regBackup_%timestamp%.reg
set RegBackup=%PEDRecoveryFolder%

echo.
ECHO ********** Regystry backup COPY to %RegBackup%\%registryFileName%.reg 
echo.
ECHO ********** Please wait....
echo.

IF NOT EXIST "%RegBackup%" md "%RegBackup%"
IF EXIST "%RegBackup%\HKLM.reg" DEL "%RegBackup%\HKLM.reg"
REG export HKLM "%RegBackup%\HKLM.reg"
IF EXIST "%RegBackup%\HKCU.reg" DEL "%RegBackup%\HKCU.reg"
REG export HKCU "%RegBackup%\HKCU.reg"
IF EXIST "%RegBackup%\HKCR.reg" DEL "%RegBackup%\HKCR.reg"
REG export HKCR "%RegBackup%\HKCR.reg"
IF EXIST "%RegBackup%\HKU.reg" DEL "%RegBackup%\HKU.reg"
REG export HKU "%RegBackup%\HKU.reg"
IF EXIST "%RegBackup%\HKCC.reg" DEL "%RegBackup%\HKCC.reg"
REG export HKCC "%RegBackup%\HKCC.reg"
IF EXIST "%RegBackup%\%registryFileName%.reg" DEL "%RegBackup%\%registryFileName%.reg"
COPY "%RegBackup%\HKLM.reg"+"%RegBackup%\HKCU.reg"+"%RegBackup%\HKCR.reg"+"%RegBackup%\HKU.reg"+"%RegBackup%\HKCC.reg" "%RegBackup%\%registryFileName%.reg"
DEL "%RegBackup%\HKLM.reg"
DEL "%RegBackup%\HKCU.reg"
DEL "%RegBackup%\HKCR.reg"
DEL "%RegBackup%\HKU.reg"
DEL "%RegBackup%\HKCC.reg"
ENDLOCAL
start %windir%\explorer.exe "C:/%RegBackup%"
pause
goto %menu%

:m1a.x01.2.WinKeyBackup
::================================
CLS

::========================
REM Add Rest Function code here
::========================

set "winKeyDir=C:\PED-Recovery\winKey.bat"

::if exist "%winKeyDir%" ()

set "KeyPath=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"

for /f "usebackq tokens=2*" %%a in (`reg query "%KeyPath%" /v "BackupProductKeyDefault" ^| find "BackupProductKeyDefault"`) do (
    set "KeyValue=%%b"
)

if defined KeyValue (
    echo @echo off >> "%winKeyDir%"
    echo reg add "%KeyPath%" /v "BackupProductKeyDefault" /t REG_SZ /d "%KeyValue%" /f >> "%winKeyDir%"
) else (
    echo BackupProductKeyDefault value not found.
)


setlocal enabledelayedexpansion

for /f "tokens=2 delims==" %%a in ('wmic path softwarelicensingservice get OA3xOriginalProductKey /value ^| find /i "OA3xOriginalProductKey"') do (
    set "productKey=%%a"
)

for /f "tokens=* delims=" %%b in ("!productKey!") do (
    set "cleanedKey=%%b"
)

if defined cleanedKey (
    echo slmgr /ipk !cleanedKey! >> "%winKeyDir%"
) else (
    echo Product key not found or in an unexpected format.
)

endlocal
exit /b
::%psP% 
::%psP% Import-StartLayout -LayoutPath "C:\PED-Recovery\StartMenuBackup.xml" -MountPath "C:\"


::================================
:m1a.x02.testDiagnostic
::================================
set menu=m1a.x02.testDiagnostic

set "menuA= Main Menu:"
set "menuB= Step 0 : Test and Diagnostic:"
call :mStyle

set mm=
set mm= %mm% "[+] Test boot time run"
set mm= %mm% ""
set mm= %mm% "[ ] Show CPU/RAM usage"
set mm= %mm% ""
set mm= %mm% "[+] Test internet speed"
set mm= %mm% ""
set mm= %mm% "---------- Configurations / Diagnostic ----------"
set mm= %mm% ""
set mm= %mm% "[+] Execution Policy configuration"
set mm= %mm% "[+] User account control"
set mm= %mm% ""
set mm= %mm% "[+] Accounts & Users "
set mm= %mm% ""
set mm= %mm% "[+] Control Panel "
set mm= %mm% ""
set mm= %mm% "---------- CMD ----------"
set mm= %mm% ""
set mm= %mm% "[ ] Start CMD"
set mm= %mm% ""
set mm= %mm% "[ ] Copy -RoboCopy cmd"

cmdmenusel e370 "-|NEXT|- Step 1 : System Check -Update/Repair/Scan:" "-|BACK|- Main Menu" "-|MAIN MENU|- " "================= Select an option =================" "" %mm%
if %ERRORLEVEL% == 1 set "menuBackName=Step 0 : Test and Diagnostic:" && set "menuBackGoto=m1a.x02.testDiagnostic" && goto m1a.x1.systemCheck
if %ERRORLEVEL% == 2 goto mainMenu
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto m1a.x02.1.bootTime
if %ERRORLEVEL% == 7 goto %menu%
if %ERRORLEVEL% == 8 goto m1a.x02.8.cpuRamUsage
if %ERRORLEVEL% == 9 goto %menu%
if %ERRORLEVEL% == 10 goto m1a.x02.6.speedTest
if %ERRORLEVEL% == 11 goto %menu%

if %ERRORLEVEL% == 12 goto %menu%
if %ERRORLEVEL% == 13 goto %menu%
if %ERRORLEVEL% == 14 goto m1a.x02.2.ExecutionPolicy
if %ERRORLEVEL% == 15 goto m1a.x02.3.UserAccountControl

if %ERRORLEVEL% == 16 goto %menu%
if %ERRORLEVEL% == 17 goto m1a.x02.4.AccountsUsers

if %ERRORLEVEL% == 18 goto %menu%
if %ERRORLEVEL% == 19 goto m1a.x02.5.controlPanelView
if %ERRORLEVEL% == 20 goto %menu%

if %ERRORLEVEL% == 21 goto %menu%
if %ERRORLEVEL% == 22 goto %menu%
if %ERRORLEVEL% == 23 start %windir%\system32\cmd.exe
if %ERRORLEVEL% == 24 goto %menu%
if %ERRORLEVEL% == 25 goto m1a.x02.7.roboCopy

goto %menu%

:m1a.x02.1.bootTime
::================================
set menu=m1a.x02.1.bootTime
set "startBoot=PED-BootTimer.bat"

set "menuA= Step 0 : Test and Diagnostic:"
set "menuB= 3. Test boot time :"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Step 0 : Test and Diagnostic:"
set mm= %mm% "-|BACK|- Step 0 : Test and Diagnostic:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1. Create Boot Folder"
set mm= %mm% "------"
set mm= %mm% "[ p ] 2.Create Start Up file to Registry "
set mm= %mm% "[ ] 2.Create shortcut to Start Up"
set mm= %mm% "------"
set mm= %mm% "[ p ] 3.Restart PC to Test"
set mm= %mm% ""
set mm= %mm% "[ ] Log: boot timer"
set mm= %mm% "[ ] Log: boot info"

cmdmenusel e370 %mm%
cls
if %ERRORLEVEL% == 1 goto m1a.x02.testDiagnostic:
if %ERRORLEVEL% == 2 goto m1a.x02.testDiagnostic:
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto m1a.x02.1.1.createInstall-BT
if %ERRORLEVEL% == 7 goto %menu%
if %ERRORLEVEL% == 8 goto m1a.x02.1.2.createReg
if %ERRORLEVEL% == 9 goto m1a.x02.1.3.createShotcut
if %ERRORLEVEL% == 10 goto %menu%
if %ERRORLEVEL% == 11 goto m9a.x0.Restart
if %ERRORLEVEL% == 12 goto %menu%
if %ERRORLEVEL% == 13 start cmd /c "type %destinationPD%\files\bootTimer\0.bootTimer.txt && echo. && cmdmenusel e370 "Press ENTER to continue..." "
if %ERRORLEVEL% == 14 start cmd /c "type %destinationPD%\files\bootTimer\0.bootLog.txt && echo. && cmdmenusel e370 "Press ENTER to continue..." "

goto %menu%

:m1a.x02.1.1.createInstall-BT
::================================
echo Please wait...

::set "downloadFiles=:r5a.x1.6.Create-PED-BootTimer"

set "directoryFiles=files\bootTimer"
set "nameFiles=PED-BootTimer.bat"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"

if exist "%startFiles%" del "%startFiles%"
if not exist "%startFiles%" (
	call :m1a.x02.1.1.1.createInstall-BT-Menu
)
if not exist "%startFiles%" (
	call %downloadFiles%
	set "downloadFiles="
)

set "destination=%destinationPD%\%directoryFiles%"

if exist "%startFiles%" (
	start %windir%\explorer.exe "%destination%"
	echo ========== File Create Successful ===
) else (echo ========== File Unsuccessful ===) 

goto m1a.x02.1.3.0.end

:m1a.x02.1.1.1.createInstall-BT-Menu
echo.
echo Choice from two Options
echo 1. CMD view    1.30.Create-PED-BootTimer
echo 2. Pop message 1.31.Create-PED-BootTimerMessage
echo.
cmdmenusel e370 "[ ] 1.30.Create-PED-BootTimer" "[ ] 1.31.Create-PED-BootTimerMessage"
if %ERRORLEVEL% == 1 set "downloadFiles=:r5a.x1.6.Create-PED-BootTimer"
if %ERRORLEVEL% == 2 set "downloadFiles=:r5a.x1.7.Create-PED-BootTimerMessage"
%timeoutA%
exit /b

:m1a.x02.1.2.createReg
::================================
setlocal
set LinkName=PED-BootTimer
set keyReg=""%destinationPD%\files\bootTimer\%startBoot%""
set typeReg=REG_SZ

REM Check if the registry value exists
set "key=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
set "value=%LinkName%"

reg query "%key%" /v "%value%" >nul 2>&1
if %errorlevel% equ 0 (
	echo Status: Exists, so delete it
    reg delete "%key%" /v "%value%" /f
    if %errorlevel% equ 0 (
        echo Registry value deleted successfully.
    ) else (
        echo Failed to delete the registry value.
    )
) else (
    echo Registry value does not exist.
)

timeout 2 /nobreak>nul
echo Status: Add new Registry value
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "%LinkName%" /t %typeReg% /d "%keyReg%" /f

set keyReg=Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /d "%keyReg%" /f & regedit

endlocal
goto %menu%

:m1a.x02.1.3.createShotcut
::================================
setlocal

::Variables
if %shortcutToLocation% == desktop (
		echo.
		echo ...[40%]...
		set "LinkName=PED-ToolBox"
		set "destination=%destinationMain%"
		set "startBoot=%~n0.bat"
		set shortcutStyle=7
) else (
	if %startOneClick% == 1 (
		set "LinkName=OneClickDeep"
		set "destination=%destinationMain%"
		set "startBoot=%~n0.bat"
		set shortcutStyle=7
	) else (
		set "LinkName=PED-bootTimer"
		set "destination=%destinationPD%\files\bootTimer"
		set "startBoot=%startBoot%"
		set shortcutStyle=1
	)
)

set "iconN=shell32_337.ico"

::Function
set wd=%destination%
set TARGET=%destination%\%startBoot%

if %shortcutToLocation% == desktop (
	set "shortcut=%userprofile%\Desktop\%LinkName%.lnk"
) else (
	set "shortcut=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\%LinkName%.lnk"
)

IF EXIST "%shortcut%" (
	if %startOneClick% == 1 (
		DEL "%shortcut%"
		endlocal
		exit /b
	) else ( if %shortcutToLocation% == desktop (
		echo Shortcut exist on Desktop
	) else (
		DEL "%shortcut%"
	)
	)
)

:: Check if icon exist
if not exist "%destinationPD%\files\%iconN%" (
	echo.
	echo ...[50%]...
	call :r3a.x12.002.downLoadF-filesIcons
)

::Create Shortcut Function
set "shortcutCommand=%psP% "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%shortcut%'); $s.TargetPath = '%TARGET%'; $s.WorkingDirectory = '%wd%'; $s.IconLocation = '%destinationPD%\files\%iconN%'; $s.WindowStyle = %shortcutStyle%; $s.Save()""

if %shortcutToLocation% == desktop (
	if not exist %shortcut% (
	%shortcutCommand%
	)
) else (
	%shortcutCommand%
)



if %startOneClick% == 1 (endlocal && exit /b)

if %shortcutToLocation% == desktop (
	echo.
	echo ...[60%]...
	set "shortcutToLocation=0"
) else (
	start %windir%\explorer.exe "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
)

cls
echo.

if exist "%SHORTCUT%" (
	echo ========== Shortcut Create Successful ===
) else (
	echo ========== Shortcut Unsuccessful ---
)

endlocal
if %shortcutToLocation% == desktop (endlocal && exit /b)

:m1a.x02.1.3.0.end
echo.
cmdmenusel e370 "Press ENTER to go back "
goto %menu%

REM Numeric values for the WindowStyle property in batch scripts
REM ---------------------------------------------------------

REM 0: Hides the window and activates another window.
REM 1: Activates and displays a window in its most recent size and position.
REM 2: Activates the window and displays it as a minimized window.
REM 3: Activates the window and displays it as a maximized window.
REM 4: Displays a window in its most recent size and position. The active window remains active.
REM 5: Activates the window and displays it in its current size and position.
REM 6: Minimizes the specified window and activates the next top-level window in the Z order.
REM 7: Displays the window as a minimized window. The active window remains active.
REM 8: Displays the window in its current state. The active window remains active.
REM 9: Activates and displays the window. If the window is minimized or maximized, Windows restores it to its original size and position.
REM 10: Sets the show-state based on the state of the program that started the application.

REM ---------------------------------------------------------

::set shortcut=C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\%LinkName%.lnk
::41 ,43,
::42 ,44,337
::set "PWS=powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile"
::%PWS% -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%shortcut%'); $s.TargetPath = '%TARGET%'; $s.WorkingDirectory = '%wd%'; $s.IconLocation = '%SystemRoot%\System32\SHELL32.dll,%iconT%'; $s.Save()"
::%SystemRoot%\System32\SHELL32.dll,%iconT%
::set "iconT=41"



:m1a.x02.2.ExecutionPolicy
set menu=m1a.x02.2.ExecutionPolicy

set "menuA= Step 0 : Test and Diagnostic:"
set "menuB= Execution Policy:"
call :mStyle

set mm= "-|NEXT|- 2. User account control:" 
set mm= %mm% "-|BACK|- Step 0 : Test and Diagnostic:"
set mm= %mm% "-|MAIN MENU|- " "================= Select an option ================="
set mm= %mm% ""

set mm= %mm% "[p] 1.List"   
set mm= %mm% ""
set mm= %mm% "[ p ] 2.Unrestricted"
set mm= %mm% "[ d ] 2.Restricted"

cmdmenusel e370 %mm%
cls
if %ERRORLEVEL% == 1 goto m1a.x02.3.UserAccountControl
if %ERRORLEVEL% == 2 goto m1a.x02.testDiagnostic:
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 powershell "Get-ExecutionPolicy -List"
if %ERRORLEVEL% == 7 goto %menu%
if %ERRORLEVEL% == 8 start /min powershell "Set-ExecutionPolicy Unrestricted -Force" && start /min powershell "Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force"
if %ERRORLEVEL% == 9 start /min powershell "Set-ExecutionPolicy Restricted -Force" && start /min powershell "Set-ExecutionPolicy Restricted -Scope CurrentUser -Force"

echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

Get-ExecutionPolicy -List
"Set-ExecutionPolicy Unrestricted -Force && Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force"
Powershell.exe Set-ExecutionPolicy Bypass -Scope Process -Force;
start /min powershell Unblock-File -Path $PWD\PED.bat

:m1a.x02.3.UserAccountControl
set menu=m1a.x02.3.UserAccountControl


set "menuA= Step 0 : Test and Diagnostic:"
set "menuB= User account control:"
call :mStyle

cmdmenusel e370 "-|NEXT|- Accounts and Users:" "-|BACK|- Step 0 : Test and Diagnostic:" "-|MAIN MENU|- " "========== Select an option ==========" "" "[ p ] 1.Never notify" "[ ] 1.Notify me only when app try to make changes(do not dim my desktop)" "[ ] 1.Notify me only when app try to make changes(default)" "[ d ] 1.Always notify" 
if %ERRORLEVEL% == 1 goto m1a.x02.4.AccountsUsers
if %ERRORLEVEL% == 2 goto m1a.x02.testDiagnostic:
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 Set cpba=0 && set posd=0
if %ERRORLEVEL% == 7 Set cpba=5 && set posd=0
if %ERRORLEVEL% == 8 Set cpba=5 && set posd=1
if %ERRORLEVEL% == 9 Set cpba=2 && set posd=1

REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d %cpba% /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d %posd% /f

goto %menu%

:m1a.x02.4.AccountsUsers
::========
set menu=m1a.x02.4.AccountsUsers


set "menuA= Step 0 : Test and Diagnostic:"
set "menuB= Accounts and Users:"
call :mStyle

cmdmenusel e370 "-|NEXT|- Control Panel:" "-|BACK|- Programs" "-|MAIN MENU|- " "========== Select an option ==========" "" "[+] 1.Account Password Reset" "[+] 2.Activate Administrator account" "[+] 3.add account" "[+] 4.Local Users and Groups(Local)"
if %ERRORLEVEL% == 1 goto m1a.x02.5.controlPanelView
if %ERRORLEVEL% == 2 goto r4a.xPrograms
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%
if %ERRORLEVEL% == 6 goto m1a.x02.4.1.AccountPasswordReset
if %ERRORLEVEL% == 7 goto m1a.x02.4.2.ActiveAdministrator
if %ERRORLEVEL% == 8 goto m1a.x02.4.3.addAccount
if %ERRORLEVEL% == 9 goto m1a.x02.4.4.LocalUsersAndGroups

:m1a.x02.4.1.AccountPasswordReset
::================================
set "menuD2=echo."
set "menuD2=%menuD2% && echo ===================================================="
set "menuD2=%menuD2% && echo Description:"
set "menuD2=%menuD2% && echo -System CMD Boot"
set "menuD2=%menuD2% && echo copy c:\windows\system32\sethc.exe c:\"
set "menuD2=%menuD2% && echo copy c:\windows\system32\cmd.exe c:\windows\system32\sethc.exe"
set "menuD2=%menuD2% && echo -shift 5 times:"
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo ===================================================="
set menuA= Accounts and Users:
set menuB= 1. Account Password Reset:
set menuC= onlyA
call :mStyle
rem Check if the variable is empty
if "%add1%"=="" (
    echo ^+
) else (
    echo Variable still has a value: %add1%
)
set menuD2= 
set menuC=mStyleA

echo Are you sure you want to continue?

set /p "add1=Type [yes] or [no]: "

if "%add1%"=="yes" (
	set "add1="
	goto m1a.x02.4.1.1.AccountPasswordResetYes
) else (
rem Clear the variable
set "add1="
pause
goto %menu%
)
:m1a.x02.4.1.1.AccountPasswordResetYes
::================================
copy c:\windows\system32\sethc.exe c:\
copy c:\windows\system32\cmd.exe c:\windows\system32\sethc.exe
echo Go to account home screen and PRESS shift 5 times:
pause
goto %menu%

:m1a.x02.4.2.ActiveAdministrator
::================================

set menu=m1a.x02.4.2.ActiveAdministrator
set menuD1=net user administrator
set "menuD2=echo - Activate or DeActivate Administrator account?"
set "menuD2=%menuD2% && echo - Change administrator Password"

set "menuA= Accounts and Users:"
set "menuB= 2. Active Administrator:"

call :mStyle

set menuD1= 
set menuD2= 

set mm=
set mm= %mm% "-|NEXT|- Add Account"
set mm= %mm% "-|BACK|- Accounts and Users"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ ] Activete"
set mm= %mm% "[ d ] DeActivete "
set mm= %mm% "[ ] Change administrator Password"

cmdmenusel e370        
if %ERRORLEVEL% == 1 goto m1a.x02.4.3.addAccount
if %ERRORLEVEL% == 2 goto m1a.x02.4.AccountsUsers
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%
if %ERRORLEVEL% == 6 net user administrator /active:yes
if %ERRORLEVEL% == 7 net user administrator /active:no
if %ERRORLEVEL% == 8 net user administrator *

:m1a.x02.4.3.addAccount
::================================
set menu=m1a.x02.4.3.addAccount
cls

set menuD1=net localgroup

set "menuA= Accounts and Users:"
set "menuB= 3. Add Account:"
call :mStyle
set add1=
set /p "add1= Write account name: "
set menuD1= 
echo Account type :(%add1%)
echo.
set "add2==set "add1=""

set mm=
set mm= %mm% "-|NEXT|- Local Users and Groups(Local) "
set mm= %mm% "-|BACK|- Accounts and Users"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "user"
set mm= %mm% "administrator"
set mm= %mm% "Write account name again"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 %add2% && goto m1a.x02.4.4.LocalUsersAndGroups
if %ERRORLEVEL% == 2 %add2% && goto m1a.x02.4.AccountsUsers
if %ERRORLEVEL% == 3 %add2% && goto mainMenu
if %ERRORLEVEL% == 4 %add2% && goto %menu%
if %ERRORLEVEL% == 5 %add2% && goto %menu%
if %ERRORLEVEL% == 6 start /w net user %add1% /add
if %ERRORLEVEL% == 7 start /w /min net user %add1% /add && start /w /min net localgroup Administrators %add1% /add && start /w /min net localgroup Users %add1% /remove
if %ERRORLEVEL% == 8 %add2% && goto m1a.x02.4.3.addAccount

set "add1="
goto m1a.x02.4.4.LocalUsersAndGroups

:m1a.x02.4.4.LocalUsersAndGroups
::================================
set menu=m1a.x02.4.4.LocalUsersAndGroups

set "menuA= Accounts and Users:"
set "menuB= 4. Local Users and Groups(Local) :"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Step 1 : System Check -Update/Repair/Scan"
set mm= %mm% "-|BACK|- Accounts and Users"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ ] lusrmgr.msc"
set mm= %mm% "[ ] Control panel/User accounts"
set mm= %mm% "[ p ] User accounts panel 2"

cmdmenusel e370       
if %ERRORLEVEL% == 1 set menuBackName=Local Users and Groups(Local) && set menuBackGoto=m1a.x02.4.4.LocalUsersAndGroups && goto m1a.x1.systemCheck
if %ERRORLEVEL% == 2 goto m1a.x02.4.AccountsUsers
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%
if %ERRORLEVEL% == 6 start lusrmgr.msc && goto m1a.x02.4.4.1.LocalUsersAndGroups
if %ERRORLEVEL% == 7 start control userpasswords
if %ERRORLEVEL% == 8 start control userpasswords2 && goto m1a.x02.4.4.3.UserAccountsPanel
goto %menu%

:m1a.x02.4.4.1.LocalUsersAndGroups 
::================================
cls
echo.
echo Instructions:
echo -advaced
echo -advanced user management - advanced
echo -user - new user
echo -admin
echo -property - member of - add
echo -admin
echo change preview user from admin to user

cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x02.4.4.3.UserAccountsPanel
::================================
cls
echo.
echo Instructions:
echo - Properties
echo - Group Membership

cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x02.5.controlPanelView
::================================
set menu=m1a.x02.5.controlPanelView

set "menuA= Step 0 : Test and Diagnostic:"
set "menuB= 5. Control Panel:"
call :mStyle


set mm=
set mm= %mm% "-|NEXT|- Step 0 : Test and Diagnostic:"
set mm= %mm% "-|BACK|- Step 0 : Test and Diagnostic:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ ] Control Panel (icons view)"
set mm= %mm% "[ ] Control panel :All Tasks -shortcuts"
set mm= %mm% ""
set mm= %mm% "[ ] Device Manager"
set mm= %mm% "[ ] Memory Diagnostic"
set mm= %mm% "[+] Troubleshooting"
set mm= %mm% ""
set mm= %mm% "[ ] Hard drive test: CrystalDiskInfoPortable"
set mm= %mm% "[ ] Disk Defragmenter"
set mm= %mm% "[ ] Check for errors"
set mm= %mm% "[ ] Disk Management"
        
cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x02.testDiagnostic:
if %ERRORLEVEL% == 2 goto m1a.x02.testDiagnostic:
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 start %WinDir%\explorer.exe "shell:::{21EC2020-3AEA-1069-A2DD-08002B30309D}"
if %ERRORLEVEL% == 7 start %WinDir%\explorer.exe shell:::{ED7BA470-8E54-465E-825C-99712043E01C}
if %ERRORLEVEL% == 8 goto %menu%
if %ERRORLEVEL% == 9 start devmgmt.msc
if %ERRORLEVEL% == 10 start MdSched.exe
if %ERRORLEVEL% == 11 goto m1a.x02.5.1.troubleshooting
if %ERRORLEVEL% == 12 goto %menu%
if %ERRORLEVEL% == 13 goto r4a.x0.4.CrystalDiskInfoPortable
if %ERRORLEVEL% == 14 start dfrgui.exe
if %ERRORLEVEL% == 15 start cmd /c "chkdsk && echo. && cmdmenusel e370 "Press ENTER to continue..." "
if %ERRORLEVEL% == 16 start diskmgmt.msc

goto %menu%

:m1a.x02.5.1.troubleshooting
::================================
set menu=m1a.x02.5.1.troubleshooting

set "menuA= 5. Control Panel (icons view):"
set "menuB= Troubleshooting:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 5. Control Panel:"
set mm= %mm% "-|BACK|- 5. Control Panel:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ ] Troubleshooting (Settings)"
set mm= %mm% "[ ] Troubleshooting (Control Panel)"
set mm= %mm% "--[ ] Troubleshooting (All Categories)"
set mm= %mm% "[ ] Hardware and Sound"
set mm= %mm% "[ ] Network and Internet"
set mm= %mm% "--[ ] Troubleshooting Network adapter"
set mm= %mm% "[ ] System and Security"
set mm= %mm% "--[ ] Troubleshooting System Maintenance"
 
cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x02.5.controlPanelView
if %ERRORLEVEL% == 2 goto m1a.x02.5.controlPanelView
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 start control.exe /name Microsoft.Troubleshooting
if %ERRORLEVEL% == 7 start explorer shell:::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}
if %ERRORLEVEL% == 8 start explorer "shell:::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\listAllPage"
if %ERRORLEVEL% == 9 start explorer "shell:::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\devices"
if %ERRORLEVEL% == 10 start explorer "shell:::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\network"
if %ERRORLEVEL% == 11 start msdt.exe -id NetworkDiagnosticsNetworkAdapter
if %ERRORLEVEL% == 12 start explorer "shell:::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\system"
if %ERRORLEVEL% == 13 start msdt.exe -id MaintenanceDiagnostic

goto %menu%

:m1a.x02.6.speedTest
::================================
set menu=m1a.x02.6.speedTest

set "menuA= Step 0 : Test and Diagnostic:"
set "menuB= [-] Test internet speed:"
call :mStyle

set "speedTestFile=0"

set mm=
set mm= %mm% "-|NEXT|- Step 0 : Test and Diagnostic:"
set mm= %mm% "-|BACK|- Step 0 : Test and Diagnostic:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] Test Speed [Mbps] [megabits per second]"
set mm= %mm% "[ p ] Test Speed [MB/s] [megabytes per second]"
set mm= %mm% ""
set mm= %mm% "[ p ] Check IP Address"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x02.testDiagnostic:

if %ERRORLEVEL% == 2 goto m1a.x02.testDiagnostic:
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 (
	set "speedTestFile=a"
	goto r4a.x0.6.speedTest
)
if %ERRORLEVEL% == 7 (
	set "speedTestFile=A"
	goto r4a.x0.6.speedTest
)
if %ERRORLEVEL% == 8 goto %menu%
if %ERRORLEVEL% == 9 goto m1a.x02.6.2.speedTestIPAddress

goto %menu%

:m1a.x02.6.1.speedTestCheckInternetConnection
::================================

set "server=8.8.8.8"   REM Google's DNS server
set "timeout=3"        REM Timeout value in seconds

ping %server% -n 1 -w %timeout% >nul
if %errorlevel% equ 0 (
    echo Internet connection is available.
	exit /b
) else (
    echo No internet connection.
	%timeoutA%
)
if %menu% == m1a.x02.6.speedTest (
	goto %menu%
)
goto m1a.x02.6.1.speedTestCheckInternetConnection


:m1a.x02.6.2.speedTestIPAddress
::================================
cls
for /f %%i in ('curl ifconfig.me 2^>nul') do set "PublicIP=%%i"
echo.
echo ====================================================
echo =================== IP ADDRESS : =================== 
echo.
echo Your public IP address is:
echo  %PublicIP%
echo.
echo Your private IP address is:
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4 Address"') do (
    echo %%a
)
echo.
echo ====================================================
echo.
echo.
pause
set "loc="
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x02.7.roboCopy
::================================
set "menuD2=echo."
set "menuD2=%menuD2% && echo ===================================================="
set "menuD2=%menuD2% && echo ==================== ROBOCOPY: ==================== "
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo Description:"
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo 	- Copy one Folder to another place"
set "menuD2=%menuD2% && echo 	- Command: /e /w:5 /r:2 /COPY:DATSOU /DCOPY:DAT /MT /LOG+:C:\robocopy.log /TEE"
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo 	- Example:"
set "menuD2=%menuD2% && echo 	"C:\Users\%username%\Desktop\source""
set "menuD2=%menuD2% && echo 	"C:\Users\%username%\Desktop\destination""
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo ===================================================="


set "menuA= Step 0 : Test and Diagnostic:"
set "menuB= [-] RoboCopy:"
set "menuC=onlyA"
call :mStyle
set "menuD2= "

set /p source=Type source:
set /p destination=Type destination:

robocopy "%source%" "%destination%" /e /w:5 /r:2 /COPY:DATSOU /DCOPY:DAT /MT /LOG+:C:\robocopy.log /TEE

set source=
set destination=

echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%


:m1a.x02.8.cpuRamUsage
::================================
cls
set "downloadFiles=:r5a.x1.5.Create-PEDcpuRamV12"
set "directoryFiles=files\cpuRam"
set "nameFiles=PEDcpuRamV12.bat"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist %startFiles% (
	call %downloadFiles%
)
start cmd /c %startFiles%

goto %menu%

::----------------------------------------------------------------------------
::---------------------------------------------------------------------------


::================================
::Step 1 : System Check -Update/Repair/Scan
::================================

:m1a.x1.systemCheck
::================================
set menu=m1a.x1.systemCheck

set "menuA=Main Menu:"
set "menuB=Step 1 : System Check -Update/Repair/Scan:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 1. Create a restore point:"
set mm= %mm% "-|BACK|- %menuBackName%"
set mm= %mm% "-|MAIN MENU|- "   
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[+] 1. Create a restore point"
set mm= %mm% "[+] 2. Check for Updates"
set mm= %mm% "[+] 3. Drivers"
set mm= %mm% "[+] 4. Check Security and Maintenance"
set mm= %mm% "[+] 5. Check Windows Defender"
set mm= %mm% "[+] 6. Check for corrupt files"

cmdmenusel e370 %mm%
  
if %ERRORLEVEL% == 1 goto m1a.x1.1.restorePoint
if %ERRORLEVEL% == 2 goto %menuBackGoto%
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto m1a.x1.1.restorePoint
if %ERRORLEVEL% == 7 goto m1a.x1.2.checkForUpdates
if %ERRORLEVEL% == 8 goto m1a.x1.3.drivers
if %ERRORLEVEL% == 9 goto m1a.x1.4.checkSecurityAndMaintenance
if %ERRORLEVEL% == 10 goto m1a.x1.5.checkWindowsDefender
if %ERRORLEVEL% == 11 goto m1a.x1.6.checkCorruptFiles


:m1a.x1.1.restorePoint
::================================
set menu=m1a.x1.1.restorePoint

set "menuA= Step 1 : System Check -Update/Repair/Scan:"
set "menuB= 1. Create a restore point:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 2. Check For Updates:" 
set mm= %mm% "-|BACK|- Step 1 : System Check -Update/Repair/Scan"
set mm= %mm% "-|MAIN MENU|- " "========== Select an option ==========" ""
set mm= %mm% "---------- Create a restore point ----------"
set mm= %mm% "[ p ] 1. View Configurations"
set mm= %mm% ""
set mm= %mm% "[ p ] 2. Create point (CMD fast)"
set mm= %mm% "[ ] 2. Create point(Powershell with loading bar)"
set mm= %mm% ""
set mm= %mm% "[ p ] 3. View and Restore"
set mm= %mm% ""
set mm= %mm% "---------- Registry backup ----------"
set mm= %mm% "[ p ] Registry backup (CMD)"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x1.2.checkForUpdates
if %ERRORLEVEL% == 2 goto m1a.x1.systemCheck
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto %menu%
if %ERRORLEVEL% == 7 start SystemPropertiesProtection.exe
if %ERRORLEVEL% == 8 goto %menu%
if %ERRORLEVEL% == 9 start cmd.exe /c "wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "PED-RestorePoint-cmd", 100, 7" 
if %ERRORLEVEL% == 10 powershell.exe -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'PED-Restore Point' -RestorePointType 'MODIFY_SETTINGS'"
if %ERRORLEVEL% == 11 goto %menu%
if %ERRORLEVEL% == 12 start rstrui.exe
if %ERRORLEVEL% == 13 goto %menu%
if %ERRORLEVEL% == 14 goto %menu%
if %ERRORLEVEL% == 15 goto m1a.x01.1.registryBackup

goto %menu%


:m1a.x1.1.5.registryBackup
::================================
cls

SETLOCAL
echo.
echo Write Registry File Name
set /p registryFileName=
echo.
ECHO ********** Regystry backup COPY to C:/RegBackup/%registryFileName%.reg 
echo.
ECHO ********** Please wait....
echo.
SET RegBackup=%SYSTEMDRIVE%\RegBackup
IF NOT EXIST "%RegBackup%" md "%RegBackup%"
IF EXIST "%RegBackup%\HKLM.reg" DEL "%RegBackup%\HKLM.reg"
REG export HKLM "%RegBackup%\HKLM.reg"
IF EXIST "%RegBackup%\HKCU.reg" DEL "%RegBackup%\HKCU.reg"
REG export HKCU "%RegBackup%\HKCU.reg"
IF EXIST "%RegBackup%\HKCR.reg" DEL "%RegBackup%\HKCR.reg"
REG export HKCR "%RegBackup%\HKCR.reg"
IF EXIST "%RegBackup%\HKU.reg" DEL "%RegBackup%\HKU.reg"
REG export HKU "%RegBackup%\HKU.reg"
IF EXIST "%RegBackup%\HKCC.reg" DEL "%RegBackup%\HKCC.reg"
REG export HKCC "%RegBackup%\HKCC.reg"
IF EXIST "%RegBackup%\%registryFileName%.reg" DEL "%RegBackup%\%registryFileName%.reg"
COPY "%RegBackup%\HKLM.reg"+"%RegBackup%\HKCU.reg"+"%RegBackup%\HKCR.reg"+"%RegBackup%\HKU.reg"+"%RegBackup%\HKCC.reg" "%RegBackup%\%registryFileName%.reg"
DEL "%RegBackup%\HKLM.reg"
DEL "%RegBackup%\HKCU.reg"
DEL "%RegBackup%\HKCR.reg"
DEL "%RegBackup%\HKU.reg"
DEL "%RegBackup%\HKCC.reg"
ENDLOCAL
start %windir%\explorer.exe "C:/RegBackup"
pause
goto %menu%


:m1a.x1.2.checkForUpdates
::================================
set menu=m1a.x1.2.checkForUpdates

set "menuA= Step 1 : System Check -Update/Repair/Scan:"
set "menuB= 2. Check For Updates:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 3. Check Drivers:"
set mm= %mm% "-|BACK|- Step 1 : System Check -Update/Repair/Scan:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""       
set mm= %mm% "[ p ] 0. Start Update Services"
set mm= %mm% ""
set mm= %mm% "---------- Windows update app ----------"
set mm= %mm% "[ p ] 1. Show/hide Updates"
set mm= %mm% "[ p ] 2. Windows Update Settings"
set mm= %mm% "[ p ] 3. Display Installed Updates"
set mm= %mm% ""
set mm= %mm% "[ ] Windows Update Assistant - download/repair all updates automatically - slow "
set mm= %mm% ""
set mm= %mm% " ---------- Power shell (fast)----------"
set mm= %mm% "[ p ] 0. Install the Windows Update module in PowerShell"
set mm= %mm% "[ p ] 1. Check for updates" "[ ] 2. Installing manually updates "
set mm= %mm% "[ p ] 2. Installing all the updates automatically(fast)"
set mm= %mm% ""
set mm= %mm% "---------- More - third party software ----------"
set mm= %mm% "[ p ] (WUMT) Windows Update MiniTool(fast)"
set mm= %mm% "[ ] (WAUM) Windows Automatic Updates Manager "
set mm= %mm% ""
set mm= %mm% "[ ] Restart PC"

cmdmenusel e370 %mm%

cls
echo Please wait...
if %ERRORLEVEL% == 1 goto m1a.x1.3.drivers
if %ERRORLEVEL% == 2 set menuBackName=Main Menu && set menuBackGoto=mainMenu && goto m1a.x1.systemCheck
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 call :r4a.x0.5.1.startUpdates
if %ERRORLEVEL% == 7 goto %menu%
if %ERRORLEVEL% == 8 goto %menu%
if %ERRORLEVEL% == 9 goto r4a.x0.5.2.showHideUpdates
if %ERRORLEVEL% == 10 start ms-settings:windowsupdate
if %ERRORLEVEL% == 11 start shell:AppUpdatesFolder
if %ERRORLEVEL% == 12 goto %menu%
if %ERRORLEVEL% == 13 goto r4a.x0.5.3.windowsUpdateTool
if %ERRORLEVEL% == 14 goto %menu%

if %ERRORLEVEL% == 15 goto %menu%
if %ERRORLEVEL% == 16 call :m1a.x1.2.1.checkForPS-Module
if %ERRORLEVEL% == 17 start cmd /c "%psP% "Get-WindowsUpdate -MicrosoftUpdate" && pause"
if %ERRORLEVEL% == 18 start cmd /c "%psP% "Install-WindowsUpdate -MicrosoftUpdate" && pause"
if %ERRORLEVEL% == 19 call :m1a.x1.2.2.PS-ModuleInstallAll
if %ERRORLEVEL% == 20 goto %menu%

if %ERRORLEVEL% == 21 goto %menu%
if %ERRORLEVEL% == 22 goto r4a.x0.5.5.windowsUpdateMiniTool
if %ERRORLEVEL% == 23 goto r4a.x0.5.4.windowsAutomaticUpdatesManager


if %ERRORLEVEL% == 24 goto %menu%
if %ERRORLEVEL% == 25 goto m9a.x0.Restart

goto %menu%

echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%
::"powershell.exe -NoProfile -ExecutionPolicy Bypass -File """C:\ProgramData\Winget-AutoUpdate\user-run.ps1""

:m1a.x1.2.1.checkForPS-Module
::================================
::set menu=m1a.x1.2.1.checkForPS-Module
call :r4a.x0.5.1.startUpdates
set "moduleName=PSWindowsUpdate"

REM Run PowerShell command and capture the output
for /f "delims=" %%I in ('%psP% "Get-Module -Name %moduleName%"') do set "moduleOutput=%%I"

REM Check if the output contains information about the module
if "%moduleOutput%" == "" (
    echo %moduleName% module is NOT installed.
	%psP% "Install-Module PSWindowsUpdate -Force"
) else (
    echo %moduleName% module is installed.
)
%timeoutA%
exit /b

:m1a.x1.2.2.PS-ModuleInstallAll
::================================

if startOneClick == 0 (
	start cmd /c "%psP% "Install-WindowsUpdate -MicrosoftUpdate -AcceptAll" && pause"
) else (%psP% "Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot")

exit/b
:m1a.x1.3.drivers
::================================
set menu=m1a.x1.3.drivers

set "menuA= Step 1 : System Check -Update/Repair/Scan:"
set "menuB= 3. Check Drivers:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 4. Check Security And Maintenance:"
set mm= %mm% "-|BACK|- Step 1 : System Check -Update/Repair/Scan:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.BackUp/Restore Drivers"
set mm= %mm% "[ p ] 2.SDI drivers"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto m1a.x1.4.checkSecurityAndMaintenance
if %ERRORLEVEL% == 2 set menuBackName=Main Menu && set menuBackGoto=mainMenu && goto m1a.x1.systemCheck
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto r4a.x0.3.1.backUpDriversGlaryUtilities
if %ERRORLEVEL% == 7 goto r4a.x0.1.SDI


:m1a.x1.4.checkSecurityAndMaintenance
::================================
set menu=m1a.x1.4.checkSecurityAndMaintenance

set "menuA= Step 1 : System Check -Update/Repair/Scan:"
set "menuB= 4. Check Security And Maintenance:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 5. Check Windows Defender:"
set mm= %mm% "-|BACK|- Step 1 : System Check -Update/Repair/Scan:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Open Security And Maintenance"
set mm= %mm% "[ ] 2.Start Maintenance"
set mm= %mm% "[ ] 3.Stop Maintenance"
set mm= %mm% "[ ] 4.Restart PC"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto m1a.x1.5.checkWindowsDefender
if %ERRORLEVEL% == 2 set menuBackName=Main Menu && set menuBackGoto=mainMenu && goto m1a.x1.systemCheck
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%
if %ERRORLEVEL% == 6 start control wscui.cpl
if %ERRORLEVEL% == 7 MSchedExe.exe Start
if %ERRORLEVEL% == 8 MSchedExe.exe Stop
if %ERRORLEVEL% == 9 goto m9a.x0.Restart
goto %menu%


:m1a.x1.5.checkWindowsDefender
::================================
set menu=m1a.x1.5.checkWindowsDefender

set "menuA= Step 1 : System Check -Update/Repair/Scan:"
set "menuB= 5. Check Windows Defender:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 6. Check Windows System folder for corrupt files:"
set mm= %mm% "-|BACK|- Step 1 : System Check -Update/Repair/Scan:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Open Microsoft Defender"
set mm= %mm% "[ p ] 2.Check for updates on Defender"
set mm= %mm% "---------"
set mm= %mm% "[ p ] 1.quick virus scan"
set mm= %mm% "[ ] 2.full virus scan"
set mm= %mm% "[ ] 3.offline virus scan"
set mm= %mm% "[ ] 4.boot sector malware scan"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto m1a.x1.6.checkCorruptFiles
if %ERRORLEVEL% == 2 set menuBackName=Main Menu && set menuBackGoto=mainMenu && goto m1a.x1.systemCheck
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 start ms-settings:windowsdefender
if %ERRORLEVEL% == 7 powershell "& "Update-MpSignature""
if %ERRORLEVEL% == 8 goto %menu%
if %ERRORLEVEL% == 9 powershell "& "Start-MpScan -ScanType QuickScan""
if %ERRORLEVEL% == 10 powershell "& "Start-MpScan -ScanType FullScan""
if %ERRORLEVEL% == 11 powershell "& "Start-MpWDOScan""
if %ERRORLEVEL% == 12 cd C:\ProgramData\Microsoft\Windows Defender\Platform\4.18* && MpCmdRun -Scan -ScanType -BootSectorScan
echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%


:m1a.x1.6.checkCorruptFiles
::================================
set menu=m1a.x1.6.checkCorruptFiles

set "menuA= Step 1 : System Check -Update/Repair/Scan:"
set "menuB= 6. Check Windows System folder for corrupt files:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Step 2 : Privacy Settings:"
set mm= %mm% "-|BACK|- Step 1 : System Check -Update/Repair/Scan:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Run a SFC /Scan now"
set mm= %mm% "[ p ] 2.Run a DISM command"
set mm= %mm% ""
set mm= %mm% "[ ] Auto Scan - SFC-DISM-SFC"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto m1a.x2.settings 
if %ERRORLEVEL% == 2 set menuBackName=Main Menu && set menuBackGoto=mainMenu && goto m1a.x1.systemCheck
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 sfc /scannow
if %ERRORLEVEL% == 7 dism.exe /Online /Cleanup-image /Restorehealth 
if %ERRORLEVEL% == 8 goto %menu%
if %ERRORLEVEL% == 9 sfc /scannow && dism.exe /Online /Cleanup-image /Restorehealth && sfc /scannow

pause
goto %menu%

:m1a.x2.settings
::================================
set menu=m1a.x2.settings
set "menuA=Main Menu:"
set "menuB=Step 2 : Privacy Settings:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Step 3 : Programs -Install/Uninstall/Update"
set mm= %mm% "-|BACK|- Step 1 : System Check -Update/Repair/Scan"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] Create a restore point"
set mm= %mm% "[ p ] Startup Apps"
set mm= %mm% "[ p ] Add or remove programs"
set mm= %mm% "--[ p ] Windows Features"
set mm= %mm% "--[ p ] Optional features"
set mm= %mm% "[ p ] Privacy Settings"
set mm= %mm% "[ p ] Storage settings"
set mm= %mm% "[ p ] Power Options"
set mm= %mm% "--[ p ] Power Options -Buttons settings"
set mm= %mm% "--[ p ] Power Options -Display and Sleep time settings"
set mm= %mm% "[ p ] Background apps"
set mm= %mm% "[ p ] View advanced system settings"
set mm= %mm% "[ p ] System configuration"
set mm= %mm% ""
set mm= %mm% "[ ] Reset this pc"
set mm= %mm% ""
set mm= %mm% "[+] More: Page 2:"
          
cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x3.installUninstallUpdate
if %ERRORLEVEL% == 2 set menuBackName=Main Menu && set menuBackGoto=mainMenu && goto m1a.x1.systemCheck
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 start SystemPropertiesProtection.exe
if %ERRORLEVEL% == 7 start ms-settings:startupapps
if %ERRORLEVEL% == 8 start ms-settings:appsfeatures
if %ERRORLEVEL% == 9 start %windir%\System32\OptionalFeatures.exe
if %ERRORLEVEL% == 10 start ms-settings:optionalfeatures

if %ERRORLEVEL% == 11 start ms-settings:privacy
if %ERRORLEVEL% == 12 start ms-settings:storagesense
if %ERRORLEVEL% == 13 start control /name Microsoft.PowerOptions
if %ERRORLEVEL% == 14 start control /name Microsoft.PowerOptions /page pageGlobalSettings
if %ERRORLEVEL% == 15 start control /name Microsoft.PowerOptions /page pagePlanSettings

if %ERRORLEVEL% == 16 start ms-settings:privacy-backgroundapps
if %ERRORLEVEL% == 17 start SystemPropertiesAdvanced.exe
if %ERRORLEVEL% == 18 start msconfig.exe
if %ERRORLEVEL% == 19 goto %menu%
if %ERRORLEVEL% == 20 start ms-settings:recovery
if %ERRORLEVEL% == 21 goto %menu%
if %ERRORLEVEL% == 22 goto m1a.x2.1.settingsMore

goto %menu%

:m1a.x2.1.settingsMore
::================================
set menu=m1a.x2.1.settingsMore
set "menuA=Step 2 : Privacy Settings:"
set "menuB=More: Page 2:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Step 2 : Privacy Settings:"
set mm= %mm% "-|BACK|- Step 2 : Privacy Settings:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ ] Security and Maintenance"
set mm= %mm% "[ ] Windows Security (Defender)"
set mm= %mm% "[ ] Adjust the appearance and performance of Windows"
set mm= %mm% "[ ] Show transparency in Windows"
set mm= %mm% "[ ] Graphics settings"
set mm= %mm% "[ ] Indexing Options"
set mm= %mm% "[ ] Time -Region"
set mm= %mm% "[ ] Set up Sticky Keys"
set mm= %mm% "[ ] Taskbar settings"
set mm= %mm% ""
set mm= %mm% "[ ] About - System properties"
set mm= %mm% "[ ] About - Control panel"
set mm= %mm% "[ ] About - Windows"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x2.settings
if %ERRORLEVEL% == 2 goto m1a.x2.settings
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 start control wscui.cpl
if %ERRORLEVEL% == 7 start ms-settings:windowsdefender
if %ERRORLEVEL% == 8 start SystemPropertiesPerformance.exe
if %ERRORLEVEL% == 9 start ms-settings:colors
if %ERRORLEVEL% == 10 start ms-settings:display-advancedgraphics
if %ERRORLEVEL% == 11 start control /name Microsoft.IndexingOptions
if %ERRORLEVEL% == 12 start control intl.cpl
if %ERRORLEVEL% == 13 start explorer "shell:::{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageStickyKeysSettings"
if %ERRORLEVEL% == 14 start ms-settings:taskbar

if %ERRORLEVEL% == 15 goto %menu%
if %ERRORLEVEL% == 16 start ms-settings:about
if %ERRORLEVEL% == 17 start explorer "shell:::{BB06C0E4-D293-4f75-8A90-CB05B6477EEE}"
if %ERRORLEVEL% == 18 start winver.exe

goto %menu%

::================================
::Step 3 : Programs -Install/Uninstall/Update
::================================

:m1a.x3.installUninstallUpdate
::================================
set menu=m1a.x3.installUninstallUpdate

set "menuA= Main Menu:"
set "menuB= Step 3 : Programs -Install/Uninstall/Update:"
call :mStyle
set mm=
set mm= %mm% "-|NEXT|- Step 4 : Clean Up -StartUp/StartMenu/Explorer"
set mm= %mm% "-|BACK|- Step 2 : Privacy Settings"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[+] 1.Install app/program:"
set mm= %mm% "[+] 2.Uninstall app/program:"
set mm= %mm% "[+] 3.Update all app/program:"
set mm= %mm% ""
set mm= %mm% "[+] More: Github Scripts:


cmdmenusel e370 %mm% 
if %ERRORLEVEL% == 1 goto m1a.x4.cleanUp
if %ERRORLEVEL% == 2 goto m1a.x2.settings
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto m1a.x3.1.install
if %ERRORLEVEL% == 7 (
	set menu1=r4a.x3.Uninstaller
	set menuA=Step 3 : Programs -Install/Uninstall/Update:
	set menuB=2.Uninstaller
	set menuNextName=Step 3 : Programs -Install/Uninstall/Update:
	set menuNextGoto=m1a.x3.installUninstallUpdate
	set menuBackName=Step 3 : Programs -Install/Uninstall/Update:
	set menuBackGoto=m1a.x3.installUninstallUpdate
	goto r4a.x3.Uninstaller
)
if %ERRORLEVEL% == 8 goto m1a.x3.3.updateApps

if %ERRORLEVEL% == 9 goto %menu%
if %ERRORLEVEL% == 10 goto m1a.x3.4.GithubScripts


goto %menu%

:m1a.x3.1.install
::================================
set menu=m1a.x3.1.install

set "menuA= Step 3 : Programs -Install/Uninstall/Update:"
set "menuB= 1. Install -programs:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Step 3 : Programs -Install/Uninstall/Update:"
set mm= %mm% "-|BACK|- Step 3 : Programs -Install/Uninstall/Update:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ ] Script: Winget GUI Installer"
set mm= %mm% ""
set mm= %mm% "[+] PED: App installer links"
set mm= %mm% ""
set mm= %mm% "[ ] Web: winstall.app"
set mm= %mm% "[ ] Web: Ninite.com"
set mm= %mm% "[ ] Web: Portableapps.com"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x3.installUninstallUpdate
if %ERRORLEVEL% == 2 goto m1a.x3.installUninstallUpdate
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 %psP% iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Romanitho/Winget-Install-GUI/main/Sources/Winget-Install-GUI.ps1'))
if %ERRORLEVEL% == 7 goto %menu%
if %ERRORLEVEL% == 8 (
	cls
	echo.
	call :r3a.x11.3.1.downLoadF-3.1.WingetScript
	%timeoutA%
	goto m1a.x3.1.1.pedAppInstallerLinks
)
if %ERRORLEVEL% == 9 goto %menu%
if %ERRORLEVEL% == 10 start https://www.winstall.app/apps
if %ERRORLEVEL% == 11 start https://www.ninite.com
if %ERRORLEVEL% == 12 start https://portableapps.com/apps

goto %menu%

:m1a.x3.1.1.pedAppInstallerLinks
::================================
set menu=m1a.x3.1.1.pedAppInstallerLinks
set "menuA= 1. Install -programs:"
set "menuB= PED: App Installer links (winget)"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 1. Install -programs:"
set mm= %mm% "-|BACK|- 1. Install -programs:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "--- Install by WinGet: ---"
set mm= %mm% "[ ] Browsers: Google.Chrome"
set mm= %mm% "[ ] Archiver: 7zip.7zip"
set mm= %mm% "[ ] Archiver: RARLab.WinRAR"
set mm= %mm% "[ ] Remote: Datronicsoft.SpacedeskDriver.Server"
set mm= %mm% "[ ] Remote: Google.ChromeRemoteDesktop"
set mm= %mm% "[ ] Code: GitHub.GitHubDesktop"
set mm= %mm% "[ ] Code: Microsoft.VisualStudioCode"
set mm= %mm% "[ ] Code: OpenJS.NodeJS.LTS"
set mm= %mm% "[ ] DataRecovery: EaseUS.DataRecovery"
set mm= %mm% "[ ] Partition: MiniTool.PartitionWizard.Free"
set mm= %mm% "[ ] Social: Facebook.Messenger"
set mm= %mm% "[ ] Social: WhatsApp.WhatsApp"
set mm= %mm% "[ ] Storage: Google.Drive"
set mm= %mm% "[ ] Storage: Microsoft.OneDrive"
set mm= %mm% "[ ] Note: Notepad++.Notepad++"
set mm= %mm% "[ ] Note: Apache.OpenOffice"
set mm= %mm% "[ ] Test: PrimateLabs.Geekbench.5"
set mm= %mm% "[ ] Downloader: qBittorrent.qBittorrent"
set mm= %mm% "[ ] Video: VideoLAN.VLC"
set mm= %mm% "[ ] Uninstaller: RevoUninstaller.RevoUninstallerPro"
set mm= %mm% "[ ] Cleaner: Glarysoft.GlaryUtilities"
set mm= %mm% ""
set mm= %mm% "--- MS Store: ---"
set mm= %mm% "[ ] Note: Free Office Mobile"
set mm= %mm% ""
set mm= %mm% "--- Anti-virus-portable: ---"
set mm= %mm% "[ ] Anti-virus: Norton"
set mm= %mm% "[ ] Anti-virus: Kaspersky"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x3.1.install
if %ERRORLEVEL% == 2 goto m1a.x3.1.install
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto %menu%
if %ERRORLEVEL% == 7 set "appIns=Google.Chrome"
if %ERRORLEVEL% == 8 set "appIns=7zip.7zip"
if %ERRORLEVEL% == 9 set "appIns=RARLab.WinRAR"
if %ERRORLEVEL% == 10 set "appIns=Datronicsoft.SpacedeskDriver.Server"
if %ERRORLEVEL% == 11 set "appIns=Google.ChromeRemoteDesktop"
if %ERRORLEVEL% == 12 set "appIns=GitHub.GitHubDesktop
if %ERRORLEVEL% == 13 set "appIns=Microsoft.VisualStudioCode"
if %ERRORLEVEL% == 14 set "appIns=OpenJS.NodeJS.LTS"
if %ERRORLEVEL% == 15 set "appIns=EaseUS.DataRecovery"
if %ERRORLEVEL% == 16 set "appIns=MiniTool.PartitionWizard.Free"
if %ERRORLEVEL% == 17 set "appIns=Facebook.Messenger"
if %ERRORLEVEL% == 18 set "appIns=WhatsApp.WhatsApp"
if %ERRORLEVEL% == 19 set "appIns=Google.Drive"
if %ERRORLEVEL% == 20 set "appIns=Microsoft.OneDrive"
if %ERRORLEVEL% == 21 set "appIns=Notepad++.Notepad++"
if %ERRORLEVEL% == 22 set "appIns=Apache.OpenOffice"
if %ERRORLEVEL% == 23 set "appIns=PrimateLabs.Geekbench.5"
if %ERRORLEVEL% == 24 set "appIns=qBittorrent.qBittorrent"
if %ERRORLEVEL% == 25 set "appIns=VideoLAN.VLC"
if %ERRORLEVEL% == 26 set "appIns=RevoUninstaller.RevoUninstallerPro"
if %ERRORLEVEL% == 27 set "appIns=Glarysoft.GlaryUtilities"

if %ERRORLEVEL% == 28 goto %menu%
if %ERRORLEVEL% == 29 goto %menu%
if %ERRORLEVEL% == 30 (
	start https://www.microsoft.com/store/productid/9WZDNCRFJB9S?ocid=pdpshare
	start https://www.microsoft.com/store/productid/9WZDNCRFJBH3?ocid=pdpshare
	goto %menu%
)
if %ERRORLEVEL% == 31 goto %menu%
if %ERRORLEVEL% == 32 goto %menu%
if %ERRORLEVEL% == 33 (goto r4a.x5.01.norton)
if %ERRORLEVEL% == 34 (goto r4a.x5.02.kaspersky)

:m1a.x3.1.1.1.appInstaller
cls
echo.
Echo Install %appIns%

start cmd /c "winget install %appIns% -h && pause"
::echo. && if %ERRORLEVEL% EQU 0 (Echo %appIns% installed successfully.) else (Echo %appIns% installed Unsuccessfully.)
set "appIns="

%color1%
goto %menu%

:m1a.x3.2.1.debloat
::================================
set menu=m1a.x3.2.1.debloat

set "menuA= 2. Uninstall app/program:"
set "menuB= PED:Debloat Delete unwanted Bloatware:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Step 3 : Programs -Install/Uninstall/Update:"
set mm= %mm% "-|BACK|- 2.Uninstaller"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "---------- NEW Bloatware app ----------"
set mm= %mm% "[ p ] PED-Delete_Bloatware app"
set mm= %mm% ""
set mm= %mm% "---------- cmd Delete by Location folder (old)----------"
set mm= %mm% "[ ] 1.Open files for corrections"
set mm= %mm% "[ ] 2.Delete"
set mm= %mm% ""
set mm= %mm% "---------- User folder ----------"
set mm= %mm% "[ p ] User folder - delete unwanted/empty folders"

cmdmenusel e370 %mm%        

if %ERRORLEVEL% == 1 goto m1a.x3.installUninstallUpdate
if %ERRORLEVEL% == 2 (
	set menu1=r4a.x3.Uninstaller 
	set menuA=Step 3 : Programs -Install/Uninstall/Update:
	set menuB=2.Uninstaller
	set menuNextName=Step 3 : Programs -Install/Uninstall/Update:
	set menuNextGoto=m1a.x3.installUninstallUpdate
	set menuBackName=Step 3 : Programs -Install/Uninstall/Update:
	set menuBackGoto=m1a.x3.installUninstallUpdate
	goto r4a.x3.Uninstaller
)
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto %menu%
if %ERRORLEVEL% == 7 goto m1a.x3.2.1.0.delete_Bloatware
if %ERRORLEVEL% == 8 goto %menu%

if %ERRORLEVEL% == 9 goto %menu%
if %ERRORLEVEL% == 10 goto m1a.x3.2.1.1.openDebloat
if %ERRORLEVEL% == 11 goto m1a.x3.2.1.2.debloatDel
if %ERRORLEVEL% == 12 goto %menu%
if %ERRORLEVEL% == 13 goto %menu%
if %ERRORLEVEL% == 14 goto m1a.x3.2.1.3.UserFolderDeleteUnwantedFolders
goto %menu%

:m1a.x3.2.1.0.delete_Bloatware
cls
set "downloadFiles=:r5a.x1.4.2.Create-Delete_Bloatware"
set "directoryFiles=files\debloatBloatware"
set "nameFiles=deleteBloatware.ps1"


::Function
set startFiles=%destinationPD%\%directoryFiles%\%nameFiles%
if not exist %startFiles% (
	call %downloadFiles%
)
echo Please wait...
%psP% %startFiles%

goto %menu%

:m1a.x3.2.1.1.openDebloat
cls
set "downloadFiles=:r5a.x1.4.Create-deleteCmdBloatware"
set "directoryFiles=files\debloatBloatware"
set "nameFiles=debloatBloatware.txt"


::Function
set startFiles=%destinationPD%\%directoryFiles%\%nameFiles%
if not exist %startFiles% (
	call %downloadFiles%
)
start cmd /c %startFiles%

goto %menu%

:m1a.x3.2.1.2.debloatDel

set "directoryFiles=files\debloatBloatware"
set "nameFiles=debloatBloatware.txt"
set "commandFiles=debloatBloatware1.bat"


::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist %startFiles% (
	echo %nameFiles% not exist
	timeout 2 /nobreak>nul
	goto m1a.x3.2.1.1.openDebloat
)
set "startCommand=%destinationPD%\%directoryFiles%\%commandFiles%"
copy %startFiles% %startCommand%
start /w %startCommand%
timeout 1 /nobreak>nul
del %startCommand%

echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x3.2.1.3.UserFolderDeleteUnwantedFolders
cls
echo.

IF EXIST "%UserProfile%\3D Objects" start %windir%\explorer.exe %UserProfile%\3D Objects
IF EXIST "%UserProfile%\Contacts" start %windir%\explorer.exe %UserProfile%\Contacts
IF EXIST "%UserProfile%\Favorites" start %windir%\explorer.exe %UserProfile%\Favorites
IF EXIST "%UserProfile%\Links" start %windir%\explorer.exe %UserProfile%\Links
IF EXIST "%UserProfile%\Saved" start %windir%\explorer.exe %UserProfile%\Saved Games
IF EXIST "%UserProfile%\Searches" start %windir%\explorer.exe %UserProfile%\Searches

echo.
cmdmenusel e370 "Continue without changes" "Delete" 

if %ERRORLEVEL% == 1 goto %menu%
IF EXIST "%UserProfile%\3D Objects" rmdir /s /q "%UserProfile%\3D Objects" && Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f && Reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
IF EXIST "%UserProfile%\Contacts" rmdir /s /q "%UserProfile%\Contacts"
IF EXIST "%UserProfile%\Favorites" rmdir /s /q "%UserProfile%\Favorites"
IF EXIST "%UserProfile%\Links" rmdir /s /q "%UserProfile%\Links"
IF EXIST "%UserProfile%\Saved Games" rmdir /s /q "%UserProfile%\Saved Games"
IF EXIST "%UserProfile%\Searches" rmdir /s /q "%UserProfile%\Searches"


echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x3.3.updateApps
::================================
set menu=m1a.x3.3.updateApps

set "menuA= Step 3 : Programs -Install/Uninstall/Update:"
set "menuB= 3.Update all app/program:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Step 3 : Programs -Install/Uninstall/Update:"
set mm= %mm% "-|BACK|- Step 3 : Programs -Install/Uninstall/Update:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] List with updates all apps/programs:"
set mm= %mm% "[ p ] Updates ALL:"
set mm= %mm% "[ ] Updates Manual:"

cmdmenusel e370 %mm%
cls
if %ERRORLEVEL% == 1 goto m1a.x3.installUninstallUpdate
if %ERRORLEVEL% == 2 goto m1a.x3.installUninstallUpdate
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto m1a.x3.3.1.updateAppsList
if %ERRORLEVEL% == 7 goto m1a.x3.3.2.updateAppsAll
if %ERRORLEVEL% == 8 goto m1a.x3.3.3.updateAppsManual

goto %menu%

:m1a.x3.3.1.updateAppsList
::================================
winget upgrade
%color1%
echo.
cmdmenusel e370 "Press ENTER to continue..."

goto %menu%
::winget upgrade -h --id APP-ID

:m1a.x3.3.2.updateAppsAll
::================================
start cmd /c "winget upgrade -h --all && echo. && cmdmenusel e370 "Press ENTER to continue...""

%color1%

goto %menu%

:m1a.x3.3.3.updateAppsManual
::================================
set menu=m1a.x3.3.3.updateAppsManual

winget upgrade 
%color1% 
echo. 
set /p "winG1=Type ID: " 
cls
echo.
cmdmenusel e370 "Update app: %winG1%" "Type Again" "BACK"
cls
if %ERRORLEVEL% == 1 start cmd /c "winget upgrade -h --id %winG1% && pause"
set "winG1="
if %ERRORLEVEL% == 2 goto %menu%

%color1%
goto m1a.x3.3.updateApps

:m1a.x3.4.GithubScripts
::================================
::set menu=m1a.x3.4.GithubScripts

set "menuA= Step 3 : Programs -Install/Uninstall/Update:"
set "menuB= More: Github Scripts:"

set menuNextName=Step 3 : Programs -Install/Uninstall/Update:
set menuNextGoto=m1a.x3.installUninstallUpdate
set menuBackName=Step 3 : Programs -Install/Uninstall/Update:
set menuBackGoto=m1a.x3.installUninstallUpdate

goto r4a.x4.DebloatWindows


::================================
::Step 4 : Clean Up -StartUp/StartMenu/Explorer
::================================

:m1a.x4.cleanUp
::================================
set menu=m1a.x4.cleanUp

set "menuA= Main Menu:"
set "menuB= Step 4 : Clean Up -StartUp/StartMenu/Explorer:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 1.StartUp"
set mm= %mm% "-|BACK|- Step 3 : Programs -Install/Uninstall/Update"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[+] 1.StartUp"
set mm= %mm% "[+] 2.StartMenu"
set mm= %mm% "[+] 3.Windows Explorer"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x4.1.startUp
if %ERRORLEVEL% == 2 goto m1a.x3.installUninstallUpdate
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto m1a.x4.1.startUp
if %ERRORLEVEL% == 7 goto m1a.x4.2.startMenu
if %ERRORLEVEL% == 8 goto m1a.x4.3.winExplorer


goto %menu%

:m1a.x4.1.startUp
::================================
set menu=m1a.x4.1.startUp

set "menuA= Step 4 : Clean Up -StartUp/StartMenu/Explorer:"
set "menuB= 1. Clean StartUp apps:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 2.Clean Start Menu"
set mm= %mm% "-|BACK|- Step 4 : Clean Up -StartUp/StartMenu/Explorer:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Startup -Apps settings"
set mm= %mm% "[+] 2.Startup -Tasks"
set mm= %mm% "[ p ] 3.Startup -Task Manager"
set mm= %mm% "[ p ] 4.Startup -Folders "
set mm= %mm% "[+] 5.Startup -Registry editor"
set mm= %mm% ""
set mm= %mm% "[ ] 6.Startup manager (GlaryUtility)"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto m1a.x4.2.startMenu
if %ERRORLEVEL% == 2 goto m1a.x4.cleanUp
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 start ms-settings:startupapps && goto m1a.x4.1.1.StartupApps
if %ERRORLEVEL% == 7 goto m1a.x4.1.2.startupTasks
if %ERRORLEVEL% == 8 start %windir%\System32\Taskmgr.exe /0 /startup
if %ERRORLEVEL% == 9 goto m1a.x4.1.4.StartupFolders
if %ERRORLEVEL% == 10 goto m1a.x4.1.5.RegistryEditor
if %ERRORLEVEL% == 11 goto %menu%
if %ERRORLEVEL% == 12 goto r4a.x0.3.2.startupManagerGlaryUtility

goto %menu%

:m1a.x4.1.1.StartupApps
cls
echo.
echo Instructions:
echo.
echo 1. -Stop unwanted apps
echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x4.1.2.startupTasks
set menu=m1a.x4.1.2.startupTasks

set "menuA= 1. Clean StartUp apps:"
set "menuB= 2. StartUp Tasks: -GridView"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 1.Clean StartUp apps:"
set mm= %mm% "-|BACK|- 1.Clean StartUp apps:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Disable startup Tasks"
set mm= %mm% "[ ] 2.Enable startup Tasks"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x4.1.startUp
if %ERRORLEVEL% == 2 goto m1a.x4.1.startUp
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 powershell "Get-ScheduledTask -TaskPath '\'  | Out-GridView -PassThru | Disable-ScheduledTask"
if %ERRORLEVEL% == 7 powershell "Get-ScheduledTask -TaskPath '\'  | Out-GridView -PassThru | ENABLE-ScheduledTask"

echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:::4.1.3.taskmgr
::cls
::REG export "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\TaskManager\StartUpTab" "B.reg" /y
::reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\TaskManager" /v "StartUpTab" /t "REG_DWORD" /d "3" /f
::cls
::echo.
::echo Instructions:
::echo.
::echo -Stop unwanted apps
::echo.
::
::start /w taskmgr
::REG import "%cd%\B.reg"
::DEL B.reg
::
::cmdmenusel e370 "Press ENTER to continue..." 
::if %ERRORLEVEL% == 1 goto %menu%

:m1a.x4.1.4.StartupFolders

start %windir%\explorer.exe shell:startup
start %windir%\explorer.exe "shell:common startup"
cls
echo.
echo Instructions:
echo.
echo 2. Delete unwanted startup programs
echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x4.1.5.RegistryEditor
set menu=m1a.x4.1.5.RegistryEditor

set "menuA= 1. Clean StartUp apps:"
set "menuB= 3. Registry Editor:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 1.Clean StartUp apps:"
set mm= %mm% "-|BACK|- 1.Clean StartUp apps:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.CURRENT_USER\\Run"
set mm= %mm% "[ p ] 2.CURRENT_USER\\RunOnce"
set mm= %mm% "[ p ] 3.LOCAL_MACHINE\\Run"
set mm= %mm% "[ p ] 4.LOCAL_MACHINE\\RunOnce"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto m1a.x4.1.startUp
if %ERRORLEVEL% == 2 goto m1a.x4.1.startUp
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 set keyReg=Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
if %ERRORLEVEL% == 7 set keyReg=Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
if %ERRORLEVEL% == 8 set keyReg=Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
if %ERRORLEVEL% == 9 set keyReg=Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /d "%keyReg%" /f & regedit
goto %menu%

:m1a.x4.2.startMenu
::================================
set menu=m1a.x4.2.startMenu

set "menuA= Step 4 : Clean Up -StartUp/StartMenu/Explorer:"
set "menuB= 2. Clean Start Menu:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 3.Clean Windows Explorer"
set mm= %mm% "-|BACK|- Step 4 : Clean Up -StartUp/StartMenu/Explorer:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Start Menu:"
set mm= %mm% "[ p ] 2.Apps:"
set mm= %mm% "[ p ] 3.Folders appear to start menu"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto m1a.x4.3.winExplorer
if %ERRORLEVEL% == 2 goto m1a.x4.cleanUp
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 start %windir%\explorer.exe "shell:Programs" && start %windir%\explorer.exe "shell:Common Programs"
if %ERRORLEVEL% == 7 start shell:AppsFolder
if %ERRORLEVEL% == 8 start ms-settings:personalization-start-places

goto %menu%

:m1a.x4.3.winExplorer
::================================
set menu=m1a.x4.3.winExplorer

set "menuA= Step 4 : Clean Up -StartUp/StartMenu/Explorer:"
set "menuB= 3.Clean Windows Explorer:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Step 5 : Optimizing Programs"
set mm= %mm% "-|BACK|- Step 4 : Clean Up -StartUp/StartMenu/Explorer:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Desktop icon settings"
set mm= %mm% "[ p ] 2.Icons - Notification Area and System Tray-Icons"
set mm= %mm% ""
set mm= %mm% "[+] 3.File Options"
set mm= %mm% ""
set mm= %mm% "[ ] TEMP folder [windows]"
set mm= %mm% "[ ] TEMP folder [User]"
set mm= %mm% "[ ] Prefetch folder"
set mm= %mm% "[ ] Recent folder"
set mm= %mm% "[ ] Recent Items Instance Folder"
set mm= %mm% ""
set mm= %mm% "[ ] Restart explorer"

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto m1a.x5.optimizingPrograms
if %ERRORLEVEL% == 2 goto m1a.x4.cleanUp
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 start rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0
if %ERRORLEVEL% == 7 (
	start explorer shell:::{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9} \SystemIcons,,0
	start explorer shell:::{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}
)
if %ERRORLEVEL% == 8 goto %menu%
if %ERRORLEVEL% == 9 goto m1a.x4.3.3.winExplorerThisPC
if %ERRORLEVEL% == 10 goto %menu%

if %ERRORLEVEL% == 11 start c:\windows\temp
if %ERRORLEVEL% == 12 start %TEMP%
if %ERRORLEVEL% == 13 start %SystemRoot%\explorer.exe C:\Windows\prefetch\
if %ERRORLEVEL% == 14 start explorer "shell:::{22877a6d-37a1-461a-91b0-dbda5aaebc99}"
if %ERRORLEVEL% == 15 start explorer "shell:::{4564b25e-30cd-4787-82ba-39e73a750b14}"

if %ERRORLEVEL% == 16 goto %menu%
if %ERRORLEVEL% == 17 goto m1a.x4.3.4.winExplorerRestart

goto %menu%

:m1a.x4.3.3.winExplorerThisPC
::================================
set menu=m1a.x4.3.3.winExplorerThisPC

set "menuA= 3.Clean Windows Explorer:"
set "menuB= 4.File options - This PC -Launch to"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 3.Clean Windows Explorer:"
set mm= %mm% "-|BACK|- 3.Clean Windows Explorer:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ ] File Options"
set mm= %mm% ""
set mm= %mm% "---------- Open file explorer to: ----------"
set mm= %mm% "[ p ] This PC"
set mm= %mm% "[ d ] Quick access"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x4.3.winExplorer
if %ERRORLEVEL% == 2 goto m1a.x4.3.winExplorer
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 start control folders
if %ERRORLEVEL% == 7 goto %menu%
if %ERRORLEVEL% == 8 goto %menu%
if %ERRORLEVEL% == 9 (
	set "thisPc=1"
	call :m1a.x4.3.3.1.winExplorerThisPC
)
if %ERRORLEVEL% == 10 (
	set "thisPc=2"
	call :m1a.x4.3.3.1.winExplorerThisPC
)
echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x4.3.3.1.winExplorerThisPC
::================================
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t "REG_DWORD" /d "%thisPc%" /f
set "thisPc="
exit /b

:m1a.x4.3.4.winExplorerRestart
taskkill /f /IM explorer.exe
start explorer.exe
goto %menu%

::================================
::Step 5 : Optimizing Programs 
::================================

:m1a.x5.optimizingPrograms
::================================
set menu=m1a.x5.optimizingPrograms

set "menuD2=echo."
set "menuD2=%menuD2% && echo ===================================================="
set "menuD2=%menuD2% && echo ============== PED EveryDayOptimizer: ============== "
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo Description:"
set "menuD2=%menuD2% && echo - Choose the configuration you want to optimize."
set "menuD2=%menuD2% && echo - Auto complete - One for all proceses"
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo ===================================================="

set "menuA= Main Menu:"
set "menuB= Step 5 : Optimizing Programs:"
call :mStyle
set "menuD2= "

set mm=
set mm= %mm% "-|NEXT|- Step 6 : Clean Up Junk files  "
set mm= %mm% "-|BACK|- Step 4 : Clean Up -StartUp/StartMenu/Explorer"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "------- Optimize Services/Settings -------"
set mm= %mm% "[ p ] 1.Turbo mode \ Safe configurations"
set mm= %mm% "[ d ] 1.Default configurations"
set mm= %mm% ""
set mm= %mm% "[+] Config Optimize programs"
set mm= %mm% "[+] Services with GridView:"
set mm= %mm% ""
set mm= %mm% "------- Optimize TaskScheduler -------"
set mm= %mm% "[ p ] 2.TaskScheduler -Auto config"
set mm= %mm% "[ d ] 2.TaskScheduler -Default config"
set mm= %mm% ""
set mm= %mm% "[+] Task Scheduler with GridView:"
set mm= %mm% ""
set mm= %mm% "------- More Options -------"
set mm= %mm% "[ p ] Administrative Tools"


cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x6.cleanUpJunkfiles  
if %ERRORLEVEL% == 2 goto m1a.x4.cleanUp
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto %menu%
if %ERRORLEVEL% == 7 set optimizeP=1 && goto m1a.x5.1.debloatS
if %ERRORLEVEL% == 8 set optimizeP=0 && goto m1a.x5.1.debloatS
if %ERRORLEVEL% == 9 goto %menu%
if %ERRORLEVEL% == 10 (
	set menuA=Step 5 : Optimizing Programs
	set menuB=Config Optimize programs
	set menuNextName=Step 5 : Optimizing Programs
	set menuNextGoto=m1a.x5.optimizingPrograms
	set menuBackName=Step 5 : Optimizing Programs
	set menuBackGoto=m1a.x5.optimizingPrograms
	goto r4a.x1.Optimizer
	)
if %ERRORLEVEL% == 11 goto m1a.x5.5.servicesGrid
if %ERRORLEVEL% == 12 goto %menu%

if %ERRORLEVEL% == 13 goto %menu%
if %ERRORLEVEL% == 14 goto m1a.x5.4.1.startUpTaskSchedulerAuto
if %ERRORLEVEL% == 15 goto m1a.x5.4.2.startUpTaskSchedulerDefault
if %ERRORLEVEL% == 16 goto %menu%
if %ERRORLEVEL% == 17 goto m1a.x5.4.startUpTaskScheduler
if %ERRORLEVEL% == 18 goto %menu%

if %ERRORLEVEL% == 19 goto %menu%
if %ERRORLEVEL% == 20 start control admintools

goto %menu%

:m1a.x5.0.debloatCounter
%psC% ^
	"Write-Host Process: (Get-Process).Count;" ^
	"$memoryAvailable = '{0:N0}' -f [math]::Round((wmic OS get FreePhysicalMemory)[2] / 1024);" ^
	"Write-Host ('Physical Memory: Available ' + $memoryAvailable + ' MB');"

exit /b

:m1a.x5.1.debloatS

set startOneClick=1

cls
call :m1a.x5.0.debloatCounter

echo.
echo ********** Easy Services Optimization 
::=================
call :r4a.x1.1.eso

echo ********** OOSU10 Config
::=================
call :r4a.x1.4.OOSU10

echo ********** Reduce Memory
::=================
call :r4a.x1.2.reduceMemory

::================================
echo.

set startOneClick=0
set "optimizeP=no"

call :m1a.x5.0.debloatCounter

echo.
ECHO -
ECHO *********************************************
ECHO ********** Optimization complete ! **********
ECHO *********************************************
echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%


:m1a.x5.4.startUpTaskScheduler
::================================
set menu=m1a.x5.4.startUpTaskScheduler

set "menuA= Step 5 : Optimizing Programs:"
set "menuB= Task Scheduler with GridView::"
call :mStyle
  

set mm=
set mm= %mm% "-|NEXT|- Step 5 : Optimizing Programs"
set mm= %mm% "-|BACK|- Step 5 : Optimizing Programs"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] Open - Task Scheduler settings"
set mm= %mm% ""
set mm= %mm% "------- GridView -------"
set mm= %mm% "[ ] Disable-ScheduledTask"
set mm= %mm% "[ ] Stop-ScheduledTask"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x5.optimizingPrograms
if %ERRORLEVEL% == 2 goto m1a.x5.optimizingPrograms
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 start taskschd.msc
if %ERRORLEVEL% == 7 goto %menu%
if %ERRORLEVEL% == 8 goto %menu%
if %ERRORLEVEL% == 9 powershell "Get-ScheduledTask | Out-GridView -PassThru | Disable-ScheduledTask"
if %ERRORLEVEL% == 10 powershell "Get-ScheduledTask | Out-GridView -PassThru | Stop-ScheduledTask"

echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x5.4.1.startUpTaskSchedulerAuto
if %startOneClick% == 0 (cls)
set "downloadFiles=:r5a.x1.Create-TaskSchedulerAuto"
set "directoryFiles=files\taskCommand"
set "nameFiles=taskSchedular.bat"

::Function
set startFiles=%destinationPD%\%directoryFiles%\%nameFiles%
if not exist %startFiles% (
	call %downloadFiles%
	timeout 2 /nobreak>nul
)

if %startOneClick% == 1 (
	start /w /min CMD /c "%startFiles%"
	exit /b
) else (
	start cmd /c "%startFiles%"
)

goto %menu%

:m1a.x5.4.2.startUpTaskSchedulerDefault
if %startOneClick% == 0 (cls)
set "downloadFiles=:r5a.x1.2.Create-taskSchedularDefault"
set "directoryFiles=files\taskCommand"
set "nameFiles=taskSchedularDefault.bat"

::Function
set startFiles=%destinationPD%\%directoryFiles%\%nameFiles%
if not exist %startFiles% (
	call %downloadFiles%
)

if %startOneClick% == 1 (
	start /w /min CMD /c %startFiles%
	exit /b
) else (
	start cmd /c %startFiles%
)

goto %menu%

:m1a.x5.5.servicesGrid
::================================
set menu=m1a.x5.5.servicesGrid

set "menuD2= echo ========== - Stop or disable services"

set "menuA= Step 5 : Optimizing Programs:"
set "menuB= Services with GridView:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- Step 5 : Optimizing Programs"
set mm= %mm% "-|BACK|- Step 5 : Optimizing Programs"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ ] Stop"
set mm= %mm% "[ ] StartupType Disabled"
set mm= %mm% "[ ] Restart-service" 

cmdmenusel e370 %mm%
 
if %ERRORLEVEL% == 1 goto m1a.x5.optimizingPrograms
if %ERRORLEVEL% == 2 goto m1a.x5.optimizingPrograms
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 powershell "Get-Service | Out-GridView -PassThru | Stop-Service"
if %ERRORLEVEL% == 7 powershell "Get-Service | Out-GridView -PassThru | Set-Service -StartupType Disabled"
if %ERRORLEVEL% == 8 powershell "Get-Service | Where-Object {$_.status -eq 'running'}| Out-GridView -PassThru | Restart-service -verbose"

cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

::================================
::Step 6 : Clean Up Junk files
::================================

:m1a.x6.cleanUpJunkfiles
::================================
set menu=m1a.x6.cleanUpJunkfiles
cls

set menu1=m1a.x6.cleanUpJunkfiles
set menuA=Main Menu:
set menuB=Step 6 : Clean Up Junk files
set menuNextName=Step 7 : Turn on\off apps:
set menuNextGoto=m1a.x7.turnApps
set menuBackName=Step 5 : Optimizing Programs
set menuBackGoto=m1a.x5.optimizingPrograms
goto r4a.x2.CleanUp-Portable

::========
:m1a.x7.turnApps
::========

if %menu% == m1a.x6.cleanUpJunkfiles (
	set menuBackName=Step 6 : Clean Up Junk files
	set menuBackGoto=m1a.x6.cleanUpJunkfiles
)

set menu=m1a.x7.turnApps


set "menuA= Main Menu:"
set "menuB= Step 7 : Turn on\off apps:"
call :mStyle
set mm= 
set mm= %mm% "-|NEXT|- 1. Windows Updates:"
set mm= %mm% "-|BACK|- %menuBackName%"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[+] 1. Windows Updates:"       
set mm= %mm% "[+] 2. Security and Maintenance:"
set mm= %mm% "[+] 3. Microsoft Defender Application:"
set mm= %mm% "[+] 4. Power Plan -Ultimate Performance:"
set mm= %mm% "[+] 5. Ram Reducer:"
set mm= %mm% "[+] 6. Indexing:"
set mm= %mm% "[+] 7. Hibernate:"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x7.1.WindowsUpdate
if %ERRORLEVEL% == 2 goto %menuBackGoto%
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto m1a.x7.1.WindowsUpdate
if %ERRORLEVEL% == 7 goto m1a.x7.2.securityMaintenance
if %ERRORLEVEL% == 8 goto m1a.x7.3.wDefender
if %ERRORLEVEL% == 9 goto m1a.x7.4.UltimatePerformance
if %ERRORLEVEL% == 10 goto m1a.x7.5.ramReducer
if %ERRORLEVEL% == 11 goto m1a.x7.6.indexing
if %ERRORLEVEL% == 12 goto m1a.x7.7.hibernate
if %ERRORLEVEL% == 13 goto m1a.x5.5.servicesGrid
if %ERRORLEVEL% == 14 goto m1a.x3.2.1.debloat

goto %menu%



:m1a.x7.1.WindowsUpdate
set menu=m1a.x7.1.WindowsUpdate

set "menuA= Step 7 : Turn on\off apps:"
set "menuB= 1. Windows Updates:"
call :mStyle
      

set mm=
set mm= %mm% "-|NEXT|- 1. WU Configuration:"
set mm= %mm% "-|BACK|- Step 7 : Turn on\off apps"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[+] 1. WU Configuration:"
set mm= %mm% "[+] 2. WU Tasks:"
set mm= %mm% "[+] 3. WU Services:"
set mm= %mm% "[+] 4. WU Pause :"
set mm= %mm% "[+] 5. WU Pause next update till:"
set mm= %mm% ""
set mm= %mm% "[ d ] default Settings"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x7.1.1.winUpdateMod
if %ERRORLEVEL% == 2 goto m1a.x7.turnApps
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto m1a.x7.1.1.winUpdateMod
if %ERRORLEVEL% == 7 goto m1a.x7.1.2.winUpdateModTasks
if %ERRORLEVEL% == 8 goto m1a.x7.1.3.winUpdateModServices
if %ERRORLEVEL% == 9 goto m1a.x7.1.4.WinUpdadePause
if %ERRORLEVEL% == 10 goto m1a.x7.1.4.WinUpdadePause
if %ERRORLEVEL% == 11 goto %menu%
if %ERRORLEVEL% == 12 goto m1a.x7.1.6.winUpdadeDefaut
goto %menu%

:m1a.x7.1.1.winUpdateMod
set menu=m1a.x7.1.1.winUpdateMod

set "menuA= 1. Windows Updates:"
set "menuB= 1. WU Configuration:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|-  2. WU Tasks:"
set mm= %mm% "-|BACK|- Windows Update Main:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ ] 1.Disable - AutoUpdate"
set mm= %mm% "[ p ] 1.Enable - Ask for download and install"
set mm= %mm% "[ ] 1.Enable - ask for reboot"
set mm= %mm% "[ d ] 1.Enable - Automatic Update"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x7.1.2.winUpdateModTasks
if %ERRORLEVEL% == 2 goto m1a.x7.1.WindowsUpdate
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 SET AutoUpdateN=1
if %ERRORLEVEL% == 7 SET AutoUpdateN=2
if %ERRORLEVEL% == 8 SET AutoUpdateN=3
if %ERRORLEVEL% == 9 SET AutoUpdateN=4

:m1a.x7.1.1.1.winUpdateModCode
ECHO ********** Windows Update - only directly from Microsoft
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f

ECHO ********** Windows Update
NET STOP wuauserv
REG add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "AllowAutoWindowsUpdateDownloadOverMeteredNetwork" /t REG_DWORD /d "0" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d %AutoUpdateN% /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v "AUOptions" /t REG_DWORD /d %AutoUpdateN% /f
NET START wuauserv

ECHO ********** Configure privacy
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgrade" /t REG_DWORD /d 0 /f

SET "AutoUpdateN="
if %startOneClick% == 1 (exit /b)

echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto m1a.x7.1.2.winUpdateModTasks

:m1a.x7.1.2.winUpdateModTasks
set menu=m1a.x7.1.2.winUpdateModTasks

set "menuA= 1. Windows Updates:"
set "menuB= 2. WU Tasks:"
call :mStyle

set mm= 
set mm= %mm% "-|NEXT|- 3. WU Services:"
set mm= %mm% "-|BACK|- Windows Update Main:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Disable"
set mm= %mm% "[ d ] 1.Enable"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x7.1.3.winUpdateModServices
if %ERRORLEVEL% == 2 goto m1a.x7.1.WindowsUpdate
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 SET autoUpdateP=DISABLE
if %ERRORLEVEL% == 7 SET autoUpdateP=ENABLE

::SCHTASKS /Change /TN "" /DISABLE
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\ScanForUpdates" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\SmartRetry" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UNP\RunUpdateNotificationMgr" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsUpdate\RUXIM\PLUGScheduler" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\MusUx_UpdateInterval" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Reboot_AC" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Reboot_Battery" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Report policies" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Work" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\WaaSMedic\PerformRemediation" /%autoUpdateP%
SCHTASKS /Change /TN "\Microsoft\Windows\WaaSMedic\MaintenanceWork" /%autoUpdateP%

cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto m1a.x7.1.3.winUpdateModServices

:m1a.x7.1.3.winUpdateModServices
set menu=m1a.x7.1.3.winUpdateModServices

set "menuA= 1. Windows Updates:"
set "menuB= 3. WU Services:"
call :mStyle

set mm= 
set mm= %mm% "-|NEXT|- 4. WU Pause :"
set mm= %mm% "-|BACK|- Windows Update Main:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Manual" "[ ] 1.Disable"
set mm= %mm% "[ d ] 1.Enable" 

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x7.1.4.WinUpdadePause
if %ERRORLEVEL% == 2 goto m1a.x7.1.WindowsUpdate
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 SET autoUpdateP=DEMAND && SET AutoUpdateN=stop
if %ERRORLEVEL% == 7 SET autoUpdateP=DISABLED && SET AutoUpdateN=stop
if %ERRORLEVEL% == 8 SET autoUpdateP=DELAYED-AUTO && SET AutoUpdateN=start

sc config wuauserv start= %autoUpdateP%
NET %AutoUpdateN% wuauserv
sc config dosvc start= %autoUpdateP%
NET %AutoUpdateN% dosvc
sc config waasmedicsvc start= %autoUpdateP%
NET %AutoUpdateN% waasmedicsvc
sc config usosvc start= %autoUpdateP%
NET %AutoUpdateN% usosvc
sc config bits start= %autoUpdateP%
NET %AutoUpdateN% bits

cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto m1a.x7.1.4.WinUpdadePause

:m1a.x7.1.4.WinUpdadePause
set menu=m1a.x7.1.4.WinUpdadePause

set "menuD2=echo."
set "menuD2=%menuD2% && echo ===================================================="
set "menuD2=%menuD2% && echo ============ PED Windwos updates pause: ============ "
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo Description: "
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo [[Apply -Auto]]"
set "menuD2=%menuD2% && echo - Updates Pause till: 2030-10-10"
set "menuD2=%menuD2% && echo - QualityUpdates:     30 days
set "menuD2=%menuD2% && echo - FeatureUpdates:     180 days"
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo ===================================================="

set "menuA= 1. Windows Updates:"
set "menuB= 4. WU Pause :"
call :mStyle
set "menuD2= "
::::
set mm=
set mm= %mm% "-|NEXT|- 2. Security and Maintenance:"
set mm= %mm% "-|BACK|- Windows Update Main:"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] [[Apply -Auto]]"
set mm= %mm% ""
set mm= %mm% "[ ] SET manually -Next update date"
set mm= %mm% ""
set mm= %mm% "[ ] Modify Driver Updates"

cmdmenusel e370 %mm% 
if %ERRORLEVEL% == 1 goto m1a.x7.2.securityMaintenance
if %ERRORLEVEL% == 2 goto m1a.x7.1.WindowsUpdate
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 (
set startOneClick=1
call :m1a.x7.1.4.1.WinUpdadePause
set startOneClick=0
)
if %ERRORLEVEL% == 7 goto %menu%
if %ERRORLEVEL% == 8 goto m1a.x7.1.4.1.WinUpdadePause
if %ERRORLEVEL% == 9 goto %menu%
if %ERRORLEVEL% == 10 goto m1a.x7.1.4.4.WinUpdadeDriversUpdates
goto %menu%

:::m1a.x7.1.4.1.winUpdateSecurityApply
::cd %systemroot%\system32
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ActiveHoursEnd" /t REG_DWORD /d "2" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ActiveHoursStart" /t REG_DWORD /d "8" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "AllowAutoWindowsUpdateDownloadOverMeteredNetwork" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "FlightCommitted" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "IsExpedited" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "LastToastAction" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "UxOption" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "InsiderProgramEnabled" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "SmartActiveHoursSuggestionState" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "BranchReadinessLevel" /t REG_DWORD /d "20" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings\ModelState" /v "SignalRegistered" /t REG_SZ /d "::2F08BEBA97" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "SmartActiveHoursTimestamp" /t REG_QWORD /d "33fb120ebfa5d601" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "LastToastAction" /t REG_DWORD /d "70" /f
::
::goto m1a.x7.1.4.3.winUpdateSecurityNext
::
:::m1a.x7.1.4.2.winUpdateSecurityReverse
::cd %systemroot%\system32
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ActiveHoursEnd" /t REG_DWORD /d "2" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ActiveHoursStart" /t REG_DWORD /d "8" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "AllowAutoWindowsUpdateDownloadOverMeteredNetwork" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "FlightCommitted" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "IsExpedited" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "LastToastAction" /t REG_DWORD /d "70" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "UxOption" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "InsiderProgramEnabled" /t REG_DWORD /d "0" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "SmartActiveHoursSuggestionState" /t REG_DWORD /d "0" /f
::Reg.exe delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "BranchReadinessLevel" /t REG_DWORD /d "20" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings\ModelState" /v "SignalRegistered" /t REG_SZ /d "::2F0E3B2CBC" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "SmartActiveHoursTimestamp" /t REG_QWORD /d "1d7a241f86e9738" /f
::Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "LastToastAction" /t REG_DWORD /d "70" /f
::
::goto m1a.x7.1.4.3.winUpdateSecurityNext
::
:::m1a.x7.1.4.3.winUpdateSecurityNext
::cmdmenusel e370 "Press ENTER to continue..." 
::if %ERRORLEVEL% == 1 goto m1a.x7.1.4.WinUpdadePause

:::m1a.x7.1.4.WinUpdadePause
::set menu=m1a.x7.1.4.WinUpdadePause
::
::set "menuA= 1. Windows Updates:"
::set "menuB= 5. WU Pause next update till:"
::call :mStyle
::
::set mm=
::set mm= %mm% "-|NEXT|- 2. Security and Maintenance:"
::set mm= %mm% "-|BACK|- Windows Update Main:"
::set mm= %mm% "-|MAIN MENU|- "
::set mm= %mm% "========== Select an option =========="
::set mm= %mm% ""
::set mm= %mm% "[ p ] SET manually -Next update date"
::
::cmdmenusel e370 %mm%
::if %ERRORLEVEL% == 1 goto m1a.x7.2.securityMaintenance
::if %ERRORLEVEL% == 2 goto m1a.x7.1.WindowsUpdate
::if %ERRORLEVEL% == 3 goto mainMenu
::if %ERRORLEVEL% == 4 goto %menu%
::if %ERRORLEVEL% == 5 goto %menu%
::
::if %ERRORLEVEL% == 6 goto m1a.x7.1.4.1.WinUpdadePause
::
:m1a.x7.1.4.1.WinUpdadePause
if %startOneClick% == 0 (
	cls
	echo.
	echo SET Next update :
	echo.
	echo example : 
	echo 2030-06-26
)
if %startOneClick% == 1 (
	set "winUpdatesPauseTime=2030-10-10"
) else (
	set /p winUpdatesPauseTime=
)
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "%winUpdatesPauseTime%T14:25:30Z" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /t REG_SZ /d "%winUpdatesPauseTime%T14:25:30Z" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /t REG_SZ /d "%winUpdatesPauseTime%T14:25:30Z" /f

:m1a.x7.1.4.2.WinUpdadeQualityUpdates
if %startOneClick% == 0 (
	cls
	echo.
	echo Quality Updates -Period In Days :
	echo.
	echo example : 
	echo 30
)
if %startOneClick% == 1 (
	set "winUpdatesQualityUpdates=30"
) else (
	set /p winUpdatesQualityUpdates=
)
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "DeferQualityUpdatesPeriodInDays" /t REG_DWORD /d "%winUpdatesQualityUpdates%" /f

:m1a.x7.1.4.3.WinUpdadeFeatureUpdates
if %startOneClick% == 0 (
	cls
	echo.
	echo Feature Updates -Period In Days:
	echo.
	echo example : 
	echo 180
)
if %startOneClick% == 1 (
	set "winUpdatesFeatureUpdates=180"
) else (
	set /p winUpdatesFeatureUpdates=
)
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "DeferFeatureUpdatesPeriodInDays" /t REG_DWORD /d "%winUpdatesFeatureUpdates%" /f

if %startOneClick% == 1 (exit /b)
goto %menu%

:m1a.x7.1.4.4.WinUpdadeDriversUpdates
cls
echo.
echo Drivers Updates:
echo.

cmdmenusel e370 "Yes - Enable" "No - Disable" "" "BACK"
if %ERRORLEVEL% == 1 set winUpdatesPauseTime=0
if %ERRORLEVEL% == 2 set winUpdatesPauseTime=1
if %ERRORLEVEL% == 3 goto m1a.x7.1.4.4.WinUpdadeDriversUpdates
if %ERRORLEVEL% == 4 goto %menu%

Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Update" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "%winUpdatesPauseTime%" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "%winUpdatesPauseTime%" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "%winUpdatesPauseTime%" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Update" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "%winUpdatesPauseTime%" /f

::set keyReg=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings
::reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /d "%keyReg%" /f & regedit
goto %menu%

:m1a.x7.1.6.winUpdadeDefaut
cls
echo.
echo ========== Windows Update - Default Settings
echo.
echo ========== Are you sure you want to continue?
echo.

cmdmenusel e370 "Yes" "No"
if %ERRORLEVEL% == 1 goto m1a.x7.1.6.1.winUpdadeDefautApply
if %ERRORLEVEL% == 2 goto %menu%
goto %menu%

:m1a.x7.1.6.1.winUpdadeDefautApply
cls
net stop bits
net stop wuauserv
net stop appidsvc
net stop cryptsvc
Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\*.*" 
rmdir %systemroot%\SoftwareDistribution /S /Q
rmdir %systemroot%\system32\catroot2 /S /Q
sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
cd /d %windir%\system32
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll
net start bits
net start wuauserv
net start appidsvc
net start cryptsvc

pause
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x7.2.securityMaintenance
::================================
set menu=m1a.x7.2.securityMaintenance

set "menuA= Step 7 : Turn on\off apps:"
set "menuB= 2. Security and Maintenance:"
call :mStyle
 
set mm=
set mm= %mm% "-|NEXT|- 3. Microsoft Defender Application:"
set mm= %mm% "-|BACK|- Step 7 : Turn on\off apps"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "------- Application -------"
set mm= %mm% ""
set mm= %mm% "[ p ] 1.Disable"
set mm= %mm% "[ d ] 1.Enable"
set mm= %mm% ""
set mm= %mm% "------- Tasks - Auto Configurations -------"
set mm= %mm% ""
set mm= %mm% "[ p ] 2.Safe config"
set mm= %mm% "[ d ] 2.Default"
set mm= %mm% ""
set mm= %mm% "------- Tasks - Manual - GridView -------"
set mm= %mm% ""
set mm= %mm% "[ ] 2.Disable"
set mm= %mm% "[ ] 2.Enable"

cmdmenusel e370 %mm%
CLS
if %ERRORLEVEL% == 1 goto m1a.x7.3.wDefender
if %ERRORLEVEL% == 2 goto m1a.x7.turnApps
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto %menu%
if %ERRORLEVEL% == 7 goto %menu%
if %ERRORLEVEL% == 8 (
	SET mainP=DISABLE
	goto m1a.x7.2.1.securityMaintenanceApp
	)
if %ERRORLEVEL% == 9 (
	SET mainP=ENABLE
	goto m1a.x7.2.1.securityMaintenanceApp
)

if %ERRORLEVEL% == 10 goto %menu%

if %ERRORLEVEL% == 11 goto %menu%
if %ERRORLEVEL% == 12 goto %menu%
if %ERRORLEVEL% == 13 goto m1a.x7.2.2.securityMaintenanceTasksAuto
if %ERRORLEVEL% == 14 goto %menu%
if %ERRORLEVEL% == 15 goto %menu%

if %ERRORLEVEL% == 16 goto %menu%
if %ERRORLEVEL% == 17 goto %menu%
if %ERRORLEVEL% == 18 powershell "Get-ScheduledTask | ? {$_.Settings.MaintenanceSettings} | Out-GridView -PassThru | Disable-ScheduledTask"
if %ERRORLEVEL% == 19 powershell "Get-ScheduledTask | ? {$_.Settings.MaintenanceSettings} | Out-GridView -PassThru | Enable-ScheduledTask"

echo.
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x7.2.1.securityMaintenanceApp

if "%mainP%"=="DISABLE" (
	Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f
)
if "%mainP%"=="ENABLE" (
	Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f
	Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /f
)
SCHTASKS /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /%mainP%
SCHTASKS /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /%mainP%
SCHTASKS /Change /TN "\Microsoft\Windows\StateRepository\MaintenanceTasks" /%mainP%
SET mainP=

goto %menu%

:m1a.x7.2.2.securityMaintenanceTasksAuto
cls
set "downloadFiles=:r5a.x1.3.Create-tasks-SM"
set "directoryFiles=files\taskCommand"
set "nameFiles=tasks-SM.bat"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"
if not exist "%startFiles%" (
	call %downloadFiles%
	timeout 2 /nobreak>nul
)

start /w CMD /c "tasks-SM.bat"

goto %menu%

:m1a.x7.3.wDefender
set menu=m1a.x7.3.wDefender

set "menuA= Step 7 : Turn on\off apps:"
set "menuB= 3. Microsoft Defender Application:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 4. Power Plan -Ultimate Performance:"
set mm= %mm% "-|BACK|- Step 7 : Turn on\off apps"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "------- Tasks -------"
set mm= %mm% ""
set mm= %mm% "[ p ] Disable tasks"
set mm= %mm% "[ d ] Enable tasks"
set mm= %mm% ""
set mm= %mm% "------- Application -------"
set mm= %mm% ""
set mm= %mm% "[ ] Disable app"
set mm= %mm% "[ d ] Enable app"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x7.4.UltimatePerformance
if %ERRORLEVEL% == 2 goto m1a.x7.turnApps
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto %menu%
if %ERRORLEVEL% == 7 goto %menu%
if %ERRORLEVEL% == 8 SET defP=DISABLE && goto m1a.x7.3.1.wDefenderTasks
if %ERRORLEVEL% == 9 SET defP=ENABLE && goto m1a.x7.3.1.wDefenderTasks
if %ERRORLEVEL% == 10 goto %menu%

if %ERRORLEVEL% == 11 goto %menu%
if %ERRORLEVEL% == 12 goto %menu%
if %ERRORLEVEL% == 13 (
	set defp1=0
	set defp2=1
	goto m1a.x7.3.2.wDefenderApp
)
if %ERRORLEVEL% == 14 (
	set defp1=1
	set defp2=0
	goto m1a.x7.3.2.wDefenderApp
)

goto %menu%

:m1a.x7.3.1.wDefenderTasks

SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /%defP%
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /%defP%
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /%defP%
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /%defP%
timeout 2 /nobreak>nul
goto %menu%

:m1a.x7.3.2.wDefenderApp

Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "%defp1%" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "%defp2%" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "%defp2%" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "%defp2%" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "%defp2%" /f
REG add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "%defp2%" /f
REG add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "%defp2%" /f
REG add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\Policy Manager" /f
REG add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "%defp2%" /f
REG add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "%defp2%" /f
set defp1=
set defp2=
goto %menu%

:m1a.x7.4.UltimatePerformance
::================================
set menu=m1a.x7.4.UltimatePerformance

set "menuA= Step 7 : Turn on\off apps:"
set "menuB= 4. Power Plan -Ultimate Performance:"
call :mStyle

set mm= 
set mm= %mm% "-|NEXT|- 5. Ram Reducer:"
set mm= %mm% "-|BACK|- Step 7 : Turn on\off apps"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] Add now"
set mm= %mm% "[ p ] Open Power Plan settings"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto m1a.x7.5.ramReducer
if %ERRORLEVEL% == 2 goto m1a.x7.turnApps
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto m1a.x7.4.1.UltimatePerformanceApply
if %ERRORLEVEL% == 7 start ms-settings:powersleep
goto %menu%

:m1a.x7.4.1.UltimatePerformanceApply
cls
echo.
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
echo Ultimate Performance Plan added successfully!
echo.
start control /name Microsoft.PowerOptions
start control powercfg.cpl,,1

echo  - Drop menu:
echo 	-1.On battery: -2.Plugged in: --Both:
echo.
echo  - Hard disk - Turn off hard disk after:
echo    -- Never
echo  - Desktop background settings - Slide show
echo    -1.Paused -2.Available
echo  - Wireless.. - Power Saving Mode
echo    -1.Medium... -2.Maximum...
echo  - Sleep - Sleep after
echo    -- 15 Minutes
echo  - Sleep - Allow wake timers
echo    --Disable
echo  - USB settings - USB...
echo    --ENABLE
echo  - Intel(R) Graphics ... - Intel...
echo    -1.Balanced -2.Maximum...
echo  - PCI Express - Link ...
echo    -1.Maximum... -2.Off
echo  - Processor power management
echo   - Minimum processor state
echo    -1. "5" -2. "100"
echo   - Processor performance core...
echo    -1. "85" -2. "60"
echo   - System colling policy
echo    -- Active
echo   - Maximum processor state
echo    -- "100"
echo  - Display - Turn off display after
echo    -- 5 Minutes
echo  - Multimedia settings
echo   - When sharing media
echo    -1.Allow... -2. Prevent...
echo   - Video ...
echo    -1. Video playback powerSaving bias -2. ...performance bias
echo   - When playing video
echo    -1. Balanced -2. Optimise video quality
echo  - Battery
echo   - Critical battery notification
echo    -- On
echo   - Critical battery action
echo    -- Shut down
echo   - Low battery level
echo    -- "10"
echo   - Critical battery level
echo    -- "5"
echo   - Low battery notification
echo    -- On
echo   - Low battery action
echo    -- Sleep
echo   - Reserve battery level
echo    -- "7"

cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x7.5.ramReducer
::================================
set menu=m1a.x7.5.ramReducer

set "menuA= Step 7 : Turn on\off apps:"
set "menuB= 5. Ram Reducer:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- 6. Indexing:"
set mm= %mm% "-|BACK|- Step 7 : Turn on\off apps"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] Reduce now"

cmdmenusel e370 %mm%
 
if %ERRORLEVEL% == 1 goto m1a.x7.6.indexing 
if %ERRORLEVEL% == 2 goto m1a.x7.turnApps
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 goto m1a.x7.5.1.ramReducerApply
goto %menu%

:m1a.x7.5.1.ramReducerApply
REM ; lowers ram usage and process count by a lot

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "67108864" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Affinity" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Background Only" /t REG_SZ /d "True" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Clock Rate" /t REG_DWORD /d "10000" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "GPU Priority" /t REG_DWORD /d "8" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d "6" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "Medium" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "Normal" /f > nul
if %startOneClick% == 0 (cls && echo. && echo 	10%[+---------])
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Affinity" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Background Only" /t REG_SZ /d "True" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Clock Rate" /t REG_DWORD /d "10000" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "GPU Priority" /t REG_DWORD /d "8" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Priority" /t REG_DWORD /d "5" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Scheduling Category" /t REG_SZ /d "Medium" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "SFIO Priority" /t REG_SZ /d "Normal" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Affinity" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Background Only" /t REG_SZ /d "True" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "BackgroundPriority" /t REG_DWORD /d "8" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Clock Rate" /t REG_DWORD /d "10000" /f > nul
if %startOneClick% == 0 (cls && echo. && echo 	20%[++--------])
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "GPU Priority" /t REG_DWORD /d "8" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Priority" /t REG_DWORD /d "8" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Scheduling Category" /t REG_SZ /d "High" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "SFIO Priority" /t REG_SZ /d "Normal" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Affinity" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Background Only" /t REG_SZ /d "True" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Clock Rate" /t REG_DWORD /d "10000" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "GPU Priority" /t REG_DWORD /d "8" /f > nul
if %startOneClick% == 0 (cls && echo. && echo 	30%[+++-------])
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Priority" /t REG_DWORD /d "4" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Scheduling Category" /t REG_SZ /d "Medium" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "SFIO Priority" /t REG_SZ /d "Normal" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f > nul
if %startOneClick% == 0 (cls && echo. && echo 	40%[++++------])
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Affinity" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Background Only" /t REG_SZ /d "False" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "BackgroundPriority" /t REG_DWORD /d "4" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Clock Rate" /t REG_DWORD /d "10000" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "GPU Priority" /t REG_DWORD /d "8" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Priority" /t REG_DWORD /d "3" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Scheduling Category" /t REG_SZ /d "Medium" /f > nul
if %startOneClick% == 0 (cls && echo. && echo 	50%[+++++-----])
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "SFIO Priority" /t REG_SZ /d "Normal" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Affinity" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Background Only" /t REG_SZ /d "False" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Clock Rate" /t REG_DWORD /d "10000" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "GPU Priority" /t REG_DWORD /d "8" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Priority" /t REG_DWORD /d "1" /f > nul
if %startOneClick% == 0 (cls && echo. && echo 	60%[++++++----])
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "SFIO Priority" /t REG_SZ /d "Normal" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Affinity" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Background Only" /t REG_SZ /d "True" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Clock Rate" /t REG_DWORD /d "10000" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "GPU Priority" /t REG_DWORD /d "8" /f > nul
if %startOneClick% == 0 (cls && echo. && echo 	70%[+++++++---])
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Priority" /t REG_DWORD /d "5" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Scheduling Category" /t REG_SZ /d "Medium" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "SFIO Priority" /t REG_SZ /d "Normal" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f > nul
if %startOneClick% == 0 (cls && echo. && echo 	80%[++++++++--])
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKCU\System\GameConfigStore" /v "Win32_AutoGameModeDefaultProfile" /t REG_BINARY /d "01000100000000000000000000000000000000000000000000000000000000000000000000000000" /f > nul
Reg.exe add "HKCU\System\GameConfigStore" /v "Win32_GameModeRelatedProcesses" /t REG_BINARY /d "010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f > nul
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabledDefault" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f > nul
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "5000" /f > nul
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "4000" /f > nul
Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f > nul
if %startOneClick% == 0 (cls && echo. && echo 	90%[+++++++++-])
Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_DWORD /d "4096" /f > nul
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillServiceTimeout" /t REG_DWORD /d "8192" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" /v "Attributes" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "ACSettingIndex" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "DCSettingIndex" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" /v "ACSettingIndex" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "ACSettingIndex" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "DCSettingIndex" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" /v "ACSettingIndex" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f > nul
if %startOneClick% == 0 (cls && echo. && echo 	100%[++++++++++])

if %startOneClick% == 1 (exit /b)
echo. 
cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto %menu%

:m1a.x7.6.indexing
::================================
set menu=m1a.x7.6.indexing
set "menuD2= echo."
set "menuD2=%menuD2% && echo Good CPU with an HDD = Keep indexing on"
set "menuD2=%menuD2% && echo Slow CPU             = Turn indexing off"
set "menuD2=%menuD2% && echo Any CPU with an SSD  = Turn indexing off"
set "menuD2=%menuD2% && echo."
set "menuD2=%menuD2% && echo *Tip 2 - Manual - Disable "Allow files on this drive to have contents indexed in addition to file properties"

set "menuA= Step 7 : Turn on\off apps:"
set "menuB= 6. Indexing:"
call :mStyle
set menuD2=

set mm=
set mm= %mm% "-|NEXT|- 7. Hibernate:"
set mm= %mm% "-|BACK|- Step 7 : Turn on\off apps"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] Disable service"
set mm= %mm% "[ d ] Enable service" 

cmdmenusel e370 %mm% 
 
if %ERRORLEVEL% == 1 goto m1a.x7.7.hibernate
if %ERRORLEVEL% == 2 goto m1a.x7.turnApps
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 sc stop “wsearch” && sc config “wsearch” start=disabled
if %ERRORLEVEL% == 7 sc start “wsearch” && sc sc config “wsearch” start=delayed-auto

goto %menu%

:m1a.x7.7.hibernate
::================================
set menu=m1a.x7.7.hibernate

set "menuA= Step 7 : Turn on\off apps:"
set "menuB= 7. Hibernate:"
call :mStyle

set mm=
set mm= %mm% "-|NEXT|- END "
set mm= %mm% "-|BACK|- Step 7 : Turn on\off apps"
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ p ] Disable"
set mm= %mm% "[ d ] Enable" 

cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto m1a.x7.0.endProg
if %ERRORLEVEL% == 2 goto m1a.x7.turnApps
if %ERRORLEVEL% == 3 goto mainMenu
if %ERRORLEVEL% == 4 goto %menu%
if %ERRORLEVEL% == 5 goto %menu%

if %ERRORLEVEL% == 6 powershell "powercfg /hibernate off"
if %ERRORLEVEL% == 7 powershell "powercfg /hibernate on"

goto %menu%

:m1a.x7.0.endProg
cls
ECHO -
ECHO *********************************************
ECHO ********** Optimization complete ! **********
ECHO *********************************************

cmdmenusel e370 "Press ENTER to continue..." 
if %ERRORLEVEL% == 1 goto mainMenu


:m2a.x01.Oneclick
@echo off 
cls
:m2a.x02.OneclickA
set esoMM=0
set oosu10MM=0
set rmMM=0
set tsoMM=0
set bbMM=0
set dcMM=0
set guMM=0
set wrcMM=0
set fdcMM=0
set durMM=0
set optimizeP=2

:m2a.x11.OneClick-Menu
set menu=m2a.x11.OneClick-Menu
cls

set "menuA= Main Menu:"
set "menuB= One click maintenance:"
call :mStyle

if %optimizeP% == 1 (set optimizePStatus=Optimize
) else (
	if %optimizeP% == 0 (set optimizePStatus=Default
	) else (set optimizePStatus=SelectAuto)
)

set mm=
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "================= Select an option ================="
set mm= %mm% ""

if not %optimizePStatus% == SelectAuto (
	set mm= %mm% "  [[  Action  ]]  Status: %optimizePStatus%"
) else (set mm= %mm% "  Status: %optimizePStatus%")
set mm= %mm% ""
set mm= %mm% "================= Select Auto ================="
set mm= %mm% "[ p ] LITE - Optimize and clean "
set mm= %mm% "[   ] FULL - Optimize and clean "
set mm= %mm% ""
set mm= %mm% "[ d ] Default settings and clean"
set mm= %mm% ""
set mm= %mm% "[   ] CLEAR"

if not %optimizePStatus% == SelectAuto (set mm= %mm% "") else (goto m2a.x12.OneClick-Menu2)

set mm= %mm% "================= Select manual ================="
if %esoMM% == 1 (set mm= %mm% "[X] Easy Services Optimization "
) else (set mm= %mm% "[ ] Easy Services Optimization ")
if %oosu10MM% == 1 (set mm= %mm% "[X] O&O ShutUp10 "
) else (set mm= %mm% "[ ] O&O ShutUp10 ")
if %rmMM% == 1 (set mm= %mm% "[X] Reduce Memory "
) else (set mm= %mm% "[ ] Reduce Memory ")
if %tsoMM% == 1 (set mm= %mm% "[X] Tasks Schedular Optimization "
) else (set mm= %mm% "[ ] Tasks Schedular Optimization ")
if %bbMM% == 1 (set mm= %mm% "[X] Bleachbit "
) else (set mm= %mm% "[ ] Bleachbit ")
if %dcMM% == 1 (set mm= %mm% "[X] Disk Cleanup "
) else (set mm= %mm% "[ ] Disk Cleanup ")
if %guMM% == 1 (set mm= %mm% "[X] Glary Utilities "
) else (set mm= %mm% "[ ] Glary Utilities ")
if %wrcMM% == 1 (set mm= %mm% "[X] Wise Reg Cleaner "
) else (set mm= %mm% "[ ] Wise Reg Cleaner ")
if %fdcMM% == 1 (set mm= %mm% "[X] Flush DNS Cache "
) else (set mm= %mm% "[ ] Flush DNS Cache ")
set mm= %mm% "================================================="
if %durMM% == 1 (set mm= %mm% "[X] Deep / Update / Repair"
) else (set mm= %mm% "[ ] Deep / Update / Repair")

:m2a.x12.OneClick-Menu2
cmdmenusel e370 %mm%

if %ERRORLEVEL% == 1 goto mainMenu
if %ERRORLEVEL% == 2 goto %menu%
if %ERRORLEVEL% == 3 goto %menu%

if %ERRORLEVEL% == 4 if %durMM% == 1 (
	goto m2a.x5.Oneclick5
) else (
	if not %optimizePStatus% == SelectAuto (goto m2a.x3.OneclickC) else (goto %menu%)
)

if %ERRORLEVEL% == 5 goto %menu%
if %ERRORLEVEL% == 6 goto %menu%

if %ERRORLEVEL% == 7 set optimizeP=1 && goto m2a.x2.1.OneclickLITE
if %ERRORLEVEL% == 8 set optimizeP=1 && goto m2a.x2.2.OneclickFULL
if %ERRORLEVEL% == 9 goto %menu%
if %ERRORLEVEL% == 10 set optimizeP=0 && goto m2a.x2.1.OneclickLITE
if %ERRORLEVEL% == 11 goto %menu%
if %ERRORLEVEL% == 12 goto m2a.x02.OneclickA
if %ERRORLEVEL% == 13 goto %menu%

if %ERRORLEVEL% == 14 goto %menu%
if %ERRORLEVEL% == 15 if %esoMM% == 1 (set esoMM=0) else (set esoMM=1)
if %ERRORLEVEL% == 16 if %oosu10MM% == 1 (set oosu10MM=0) else (set oosu10MM=1)
if %ERRORLEVEL% == 17 if %rmMM% == 1 (set rmMM=0) else (set rmMM=1)
if %ERRORLEVEL% == 18 if %tsoMM% == 1 (set tsoMM=0) else (set tsoMM=1)
if %ERRORLEVEL% == 19 if %bbMM% == 1 (set bbMM=0) else (set bbMM=1)
if %ERRORLEVEL% == 20 if %dcMM% == 1 (set dcMM=0) else (set dcMM=1)
if %ERRORLEVEL% == 21 if %guMM% == 1 (set guMM=0) else (set guMM=1)
if %ERRORLEVEL% == 22 if %wrcMM% == 1 (set wrcMM=0) else (set wrcMM=1)
if %ERRORLEVEL% == 23 if %fdcMM% == 1 (set fdcMM=0) else (set fdcMM=1)
if %ERRORLEVEL% == 24 goto %menu%
if %ERRORLEVEL% == 25 if %durMM% == 1 (set durMM=0) else (set durMM=1)

goto %menu%

:m2a.x2.1.OneclickLITE
set esoMM=1
set oosu10MM=1
set rmMM=1
set tsoMM=1
set bbMM=0
set dcMM=1
set guMM=1
set wrcMM=0
set fdcMM=0
set durMM=0
goto %menu%

:m2a.x2.2.OneclickFULL
set esoMM=1
set oosu10MM=1
set rmMM=1
set tsoMM=1
set bbMM=1
set dcMM=1
set guMM=1
set wrcMM=1
set fdcMM=1
set durMM=0
if %startOneClick% == 2 (goto m2a.x3.OneclickC)
goto %menu%

:m2a.x3.OneclickC
cls
::================================
if %esoMM% == 0 (
	if %oosu10MM% == 0 (
		if %rmMM% == 0 ( goto m2a.x4.1.OneclickC1
)))

call :m1a.x5.0.debloatCounter
::================================

:m2a.x4.1.OneclickC1
echo.
if %esoMM% == 1 (
echo ********** Easy Services Optimization 
::=================
set startOneClick=1
call :r4a.x1.1.eso
set startOneClick=0
)
::================================
if %oosu10MM% == 1 (
echo ********** OOSU10 Config
::=================
set startOneClick=1
call :r4a.x1.4.OOSU10
set startOneClick=0
)
::================================
if %rmMM% == 1 (
echo ********** Reduce Memory
::=================
set startOneClick=1
call :r4a.x1.2.reduceMemory
set startOneClick=0
)
::================================
if %esoMM% == 0 (
	if %oosu10MM% == 0 (
		if %rmMM% == 0 ( goto m2a.x4.2.OneclickC2
		)))
echo.
call :m1a.x5.0.debloatCounter
::================================

:m2a.x4.2.OneclickC2
::tasks
if %tsoMM% == 1 (
	echo.
	echo ********** Tasks Schedular Optimization
::=================
	set startOneClick=1
	if %optimizeP% == 1 (
		call :m1a.x5.4.1.startUpTaskSchedulerAuto
	) else (
		call :m1a.x5.4.2.startUpTaskSchedulerDefault
	)
	set startOneClick=0
)
::================================
if %bbMM% == 0 (
	if %dcMM% == 0 (
		if %guMM% == 0 ( goto m2a.x4.3.OneclickC3
		)))
echo.
powershell "Write-Host Free space: ('{0:N0}' -f [math]::truncate(((Get-WmiObject Win32_LogicalDisk).FreeSpace)[0] / 1MB)) MB"
::================================
:m2a.x4.3.OneclickC3

if not %bbMM% == 1 (goto m2a.x4.4.OneclickC32)
echo.
echo ********** Bleachbit
::=================
set startOneClick=1
call :r4a.x2.1.Bleachbit
set startOneClick=0

::start /w "" CMD /c "bleachBitClean.bat"
::================================
:m2a.x4.4.OneclickC32
if not %dcMM% == 1 (goto m2a.x4.5.OneclickC33)

echo ********** Disk Cleanup
::=================
start /w cleanmgr.exe /d C: /VERYLOWDISK

::logFiles
::C:\Windows\System32\LogFiles\setupcln\setupact.log
::C:\Windows\System32\LogFiles\setupcln\setuperr.log
::================================
:m2a.x4.5.OneclickC33

if %guMM% == 1 (
echo ********** Glary Utilities
::=================
set startOneClick=1
call :r4a.x2.3.GlaryUtilitiesPortable
set startOneClick=0
)
::================================
if %wrcMM% == 1 (
echo ********** Wise Reg Cleaner
::=================
set startOneClick=1
call :r4a.x2.4.wiseRegCleaner
set startOneClick=0
)
::================================
if %fdcMM% == 1 (
echo ********** Flush DNS Cache
::=================
start /w /min cmd /c "ipconfig /release && ipconfig /renew && arp -d * && nbtstat -R && nbtstat -RR && ipconfig /flushdns && ipconfig /registerdns"
)

::================================================================

if %bbMM% == 0 (
	if %dcMM% == 0 (
		if %guMM% == 0 ( goto m2a.x4.0.OneclickC4
		)))
echo.
powershell "Write-Host Free space: ('{0:N0}' -f [math]::truncate(((Get-WmiObject Win32_LogicalDisk).FreeSpace)[0] / 1MB)) MB"

if %startOneClickTwo% == 1 (
	set startOneClickTwo=0
	exit /b
)
:m2a.x4.0.OneclickC4
echo.
%title%
ECHO -
ECHO *********************************************
ECHO ********** Optimization complete ! **********
ECHO *********************************************
echo.

pause
goto mainMenu


:m2a.x5.Oneclick5
::================================

rem add timeout question do you want to Continue

	rem if exist file c5.txt goto t5
if exist c5.txt (goto m2a.x5.5.Oneclick55)
	rem if exist file c4.txt goto t4
if exist c4.txt (goto m2a.x5.4.Oneclick54)
	rem if exist file c3.txt goto t3
if exist c3.txt (goto m2a.x5.3.Oneclick53)
	rem if exist file c2.txt goto t2
if exist c2.txt (goto m2a.x5.2.Oneclick52)
	rem if exist file c1.txt goto t1
if exist c1.txt (goto m2a.x5.1.Oneclick51)

rem create file c1.txt
echo set esoMM=%esoMM% > c1.txt
echo set oosu10MM=%oosu10MM% >> c1.txt
echo set rmMM=%rmMM% >> c1.txt
echo set tsoMM=%tsoMM% >> c1.txt
echo set bbMM=%bbMM% >> c1.txt
echo set dcMM=%dcMM% >> c1.txt
echo set guMM=%guMM% >> c1.txt
echo set wrcMM=%wrcMM% >> c1.txt
echo set fdcMM=%fdcMM% >> c1.txt
echo set optimizeP=%optimizeP% >> c1.txt

set startOneClick=1
call :m1a.x02.1.3.createShotcut

timeout 5 /nobreak>nul
Shutdown -r -f -t 00
exit
rem t1
:m2a.x5.1.Oneclick51

set startOneClick=1

powershell.exe -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'PED-Restore Point1' -RestorePointType 'MODIFY_SETTINGS'"

call :m1a.x02.6.1.speedTestCheckInternetConnection

call :m1a.x1.2.1.checkForPS-Module
timeout 2 /nobreak>c2.txt
 rem create file c2.txt
 
call :m1a.x1.2.2.PS-ModuleInstallAll
timeout 10 /nobreak>nul
Shutdown -r -f -t 00
exit
rem t2
:m2a.x5.2.Oneclick52

call :m1a.x02.6.1.speedTestCheckInternetConnection
chkdsk
sfc /scannow && dism.exe /Online /Cleanup-image /Restorehealth && sfc /scannow
rem create file c3.txt
timeout 5 /nobreak>c3.txt
del c2.txt
Shutdown -r -f -t 00
exit
rem t3
:m2a.x5.3.Oneclick53

powershell.exe -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'PED-Restore Point2' -RestorePointType 'MODIFY_SETTINGS'"

call :m1a.x02.6.1.speedTestCheckInternetConnection

call :r3a.x11.3.1.downLoadF-3.1.WingetScript
timeout 2 /nobreak>nul
winget upgrade -h --all
rem create file c4.txt
timeout 2 /nobreak>c4.txt
del c3.txt
Shutdown -r -f -t 00
exit
rem t4
:m2a.x5.4.Oneclick54

call :m1a.x02.6.1.speedTestCheckInternetConnection

set thisPc=1
call :m1a.x4.3.3.1.winExplorerThisPC

::repair

set startOneClick=1
set startOneClickTwo=1
copy c1.txt cc1.bat
call cc1.bat
call :m2a.x3.OneclickC
::call :m2a.x2.2.OneclickFULL

rem settings updates
set startOneClick=1
SET AutoUpdateN=2
call :m1a.x7.1.1.1.winUpdateModCode

call :m1a.x7.1.4.1.WinUpdadePause

rem Ram reduce
call :m1a.x7.5.1.ramReducerApply


rem Start up
call :r4a.x0.3.2.startupManagerGlaryUtility
rem create file c5.txt
timeout 2 /nobreak>c5.txt
del c4.txt
Shutdown -r -f -t 00
exit
rem t5
:m2a.x5.5.Oneclick55
del c5.txt
del c1.txt
del cc1.bat
call :m1a.x02.1.3.createShotcut
rem message complete

REM Set your one-line message here
set "message=Hello! One click Deep repair is done."

REM Show the pop-up message using VBScript
echo msgbox "%message%">"%temp%\popup_message.vbs"
cscript /nologo "%temp%\popup_message.vbs"

REM Clean up the temporary VBScript file
del "%temp%\popup_message.vbs" /q

goto mainMenu

:m9a.x0.Restart
::================================
set menu=m9a.x0.Restart

set "menuA= Main Menu:"
set "menuB= Power Menu:"
call :mStyle

set mm=
set mm= %mm% "-|MAIN MENU|- "
set mm= %mm% "========== Select an option =========="
set mm= %mm% ""
set mm= %mm% "[ ] Restart"
set mm= %mm% "[ ] Restart with Boot Options Menu"
set mm= %mm% "[ ] Sleep"
set mm= %mm% "[ ] Shut Down"
set mm= %mm% "[ ] Switch User"
set mm= %mm% "[ ] Log Off"
set mm= %mm% "[ ] Lock"

cmdmenusel e370 %mm%
if %ERRORLEVEL% == 1 goto mainMenu
if %ERRORLEVEL% == 2 goto %menu%
if %ERRORLEVEL% == 3 goto %menu%

if %ERRORLEVEL% == 4 Shutdown -r -f -t 00
if %ERRORLEVEL% == 5 Shutdown -r -o -f -t 00
if %ERRORLEVEL% == 6 rundll32.exe powrprof.dll,SetSuspendState Sleep
if %ERRORLEVEL% == 7 Shutdown -s -f -t 00
if %ERRORLEVEL% == 8 tsdiscon.exe
if %ERRORLEVEL% == 9 "Shutdown -l"
if %ERRORLEVEL% == 10 Rundll32 User32.dll,LockWorkStation
exit



::================================
:r5a.x
::================================

:r5a.x0.1.variableFunction
::================================
CLS
::::========================
::::Variables for copy
::::========================
REM Extract Function variables name
set "fileFuntionName=#NAME"
set "fileFuntionFolder=files"

REM Extract Marks
set "startMark=# StartExtract#CODE"
set "endMark=# EndExtract#CODE"

REM Delete existing Function
set "deleteExistingFunction=1"

REM Starting Function after Creation
set "fileStart=START %fileFunctionDir%"

REM Pause after CreateFunction complete
REM 0-continue, 1-pause, 2-timeOut 15 Seconds,
set pauseCreteFunction=1

::========================
REM Add Functions Before callFun
::========================
REM add Functions HERE...
REM code HERE...

::========================
REM call Function
set "callFun=:r5a.x0.2.CreateFunction"
call %callFun%

set "fileFunctionDir="

::========================
REM Add Rest Function code here
::========================
REM add Rest Code HERE...
REM code HERE...

::========================
REM Your EXTRACT code starts here
::========================
# StartExtract#CODE
REM CODE HERE...
# EndExtract#CODE

Pause
::::========================


:r5a.x0.2.CreateFunction
::================================
CLS
::========================
::Display progress
::========================
set "fileFunctionDir=%destinationPD%\%fileFuntionFolder%\%fileFuntionName%"

SETLOCAL

REM START Time Stamp
echo Please wait...
call :m1a.x01.0.timestamp
echo.
echo Current Time: %timestamp%

REM check to delete existing Function
if %deleteExistingFunction% == 1 (
	if exist %fileFunctionDir% (
		del %fileFunctionDir% >nul
	)
)

REM Creating Function
call :r5a.x0.2.1.ExtractFunction

REM Check if exist
if exist "%fileFunctionDir%" (
	echo ========== %fileFunctionDir% Create Successful ===
) else (
	echo ========== %fileFunctionDir% Unsuccessful ---
)

rem Check if Starting Function is empty
if not "%fileStart%"=="" (
	%fileStart% "%fileFunctionDir%"
	set "fileStart="
)


REM END Time Stamp
echo.
call :m1a.x01.0.timestamp
echo Current Time: %timestamp%

ENDLOCAL
::====



REM Pause after CreateFunction complete
echo.
if %pauseCreteFunction% == 1 (
	cmdmenusel e370 "Press ENTER to go back "
) else ( if %pauseCreteFunction% == 2 (
	timeout 15 
	)
)

::====
exit /b

::========================
::Extract Function
::========================
:r5a.x0.2.1.ExtractFunction
::========================
setlocal
REM Set the filename for the extracted code
set "output_file=%fileFunctionDir%"

REM Find the line number where the code block starts
for /f "delims=:" %%i in ('findstr /n /c:"%startMark%" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "delims=:" %%i in ('findstr /n /c:"%endMark%" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) >> "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"

endlocal
::====
exit /b
exit
:r5a.x1.Create-TaskSchedulerAuto
::================================
call :r3a.x12.3.downLoadF-taskCommand

set "directoryFiles=files\taskCommand"
set "nameFiles=taskSchedular.bat"

::========================
::Function
::========================
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"

REM Set the filename for the extracted code
set "output_file=%startFiles%"

REM Find the line number where the code block starts
for /f "delims=:" %%i in ('findstr /n /c:"REM # StartExtractD1" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "delims=:" %%i in ('findstr /n /c:"REM # EndExtractD1" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) > "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"
exit /b

::========================
REM Your code starts here
::========================
REM # StartExtractD1
@echo off
SCHTASKS /Change /TN "\Microsoft\Windows\Multimedia\SystemSoundsService" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Wininet\CacheTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\AppID\EDP Policy Manager" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\AppID\VerifiedPublisherCertStoreCheck" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\appuriverifierinstall" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\CleanupTemporaryState" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\DsSvcCleanup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\AppListBackup\Backup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\BitLocker\BitLocker Encrypt All Drives" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\BitLocker\BitLocker MDM policy Refresh" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Bluetooth\UninstallDeviceTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\AikCertEnrollTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\CryptoPolicyTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\KeyPreGenTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\SystemTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\UserTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Chkdsk\SyspartRepair" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Device Setup\Metadata Refresh" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\HandleCommand" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\HandleWnsCommand" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\LocateCommandUserSession" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDevicePolicyChange" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceProtectionStateChanged" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceSettingChange" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceWnsFallback" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DirectX\DXGIAdapterCache" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskCleanup\SilentCleanup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskFootprint\StorageSense" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DUSM\dusmtask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\EDP\EDP App Launch Task" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\EDP\EDP Auth Task" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\EDP\EDP Inaccessible Credentials Task" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\EDP\StorageCardEncryption Task" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Input\LocalUserSyncDataAvailable" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Input\MouseSyncDataAvailable" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Input\PenSyncDataAvailable" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Input\TouchpadSyncDataAvailable" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\International\Synchronize Language Settings" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\LanguageComponentsInstaller\Installation" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Management\Provisioning\Cellular" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Management\Provisioning\Logon" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\NlaSvc\WiFiTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\PI\Secure-Boot-Update" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Plug and Play\Device Install Group Policy" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Plug and Play\Device Install Reboot Required" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Plug and Play\Sysprep Generalize Drivers" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Printing\EduPrintProv" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\PushToInstall\Registration" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Ras\MobilityManager" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SettingSync\BackgroundUploadTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SettingSync\NetworkStateChangeTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\UpdateUserPictureTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTaskLogon" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTaskNetwork" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SpacePort\SpaceAgentTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SpacePort\SpaceManagerTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Speech\SpeechModelDownloadTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Subscription\EnableLicenseAcquisition" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SystemRestore\SR" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Task Manager\Interactive" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\TextServicesFramework\MsCtfMonitor" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Time Zone\SynchronizeTimeZone" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\TPM\Tpm-HASCertRetr" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\TPM\Tpm-Maintenance" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\UPnP\UPnPHostConfig" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\USB\Usb-Notifications" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WaaSMedic\PerformRemediation" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WCM\WiFiTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WDI\ResolutionHost" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsColorSystem\Calibration Loader" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WlanSvc\CDSSync" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WwanSvc\NotificationTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WwanSvc\OobeDiscovery" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64 Critical" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 Critical" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\appuriverifierdaily" /Enable
SCHTASKS /Change /TN "\ASCU_PerformanceMonitor" /Disable
SCHTASKS /Change /TN "\ASCU_SkipUac_pierm" /Disable
SCHTASKS /Change /TN "\CCleaner Update" /Disable
SCHTASKS /Change /TN "\CCleanerSkipUAC - pierm" /Disable
SCHTASKS /Change /TN "\GlaryInitialize 5" /Disable
SCHTASKS /Change /TN "\GlaryUpdate 5" /Disable
SCHTASKS /Change /TN "\GoogleUpdateTaskMachineCore{5C89F06A-2B4E-4120-816B-D5A5B8CFE877}" /Disable
SCHTASKS /Change /TN "\GoogleUpdateTaskMachineUA{B21A185B-5C26-4A5A-97BA-351AAC8C302A}" /Disable
SCHTASKS /Change /TN "\iTop Screen Recorder SkipUAC (pierm)" /Disable
SCHTASKS /Change /TN "\iTop Screen Recorder UAC" /Disable
SCHTASKS /Change /TN "\iTop Screenshot SkipUAC (pierm)" /Disable
SCHTASKS /Change /TN "\OneDrive Reporting Task-S-1-5-21-3399936061-3770417940-3892648164-1001" /Disable
SCHTASKS /Change /TN "\OneDrive Reporting Task-S-1-5-21-3399936061-3770417940-3892648164-1015" /Disable
SCHTASKS /Change /TN "\OneDrive Standalone Update Task-S-1-5-21-3399936061-3770417940-3892648164-1001" /Disable
SCHTASKS /Change /TN "\OneDrive Standalone Update Task-S-1-5-21-3399936061-3770417940-3892648164-1015" /Disable
SCHTASKS /Change /TN "\OneDrive Standalone Update Task-S-1-5-21-3399936061-3770417940-3892648164-500" /Disable
SCHTASKS /Change /TN "\Uninstaller_SkipUac_pierm" /Disable
SCHTASKS /Change /TN "\Hewlett-Packard\HP Support Assistant\HP Support Solutions Framework Report" /Disable
SCHTASKS /Change /TN "\Hewlett-Packard\HP Support Assistant\HP Support Solutions Framework Updater" /Disable
SCHTASKS /Change /TN "\Hewlett-Packard\HP Support Assistant\HP Support Solutions Framework Updater � Install HPSA" /Disable
SCHTASKS /Change /TN "\Microsoft\Office\Office Automatic Updates 2.0" /Disable
SCHTASKS /Change /TN "\Microsoft\Office\Office ClickToRun Service Monitor" /Disable
SCHTASKS /Change /TN "\Microsoft\Office\Office Feature Updates" /Disable
SCHTASKS /Change /TN "\Microsoft\Office\Office Feature Updates Logon" /Disable
SCHTASKS /Change /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable
SCHTASKS /Change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Automated)" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Manual)" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\AppID\PolicyConverter" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Autochk\Proxy" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\UserTask-Roam" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Chkdsk\ProactiveScan" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Clip\License Validation" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Check And Scan" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan for Crash Recovery" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Device Information\Device" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Device Information\Device User" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\IntegrityCheck" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceAccountChange" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceLocationRightsChange" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDevicePeriodic24" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterUserDevice" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DirectX\DirectXDatabaseUpdater" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskFootprint\Diagnostics" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Flighting\OneSettings\RefreshCache" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\HelloFace\FODCleanupTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\ScanForUpdates" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\SmartRetry" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\License Manager\TempSignedLicenseExchange" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Location\Notifications" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Location\WindowsActionDialog" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Management\Provisioning\Retry" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Management\Provisioning\RunOnReboot" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Maps\MapsToastTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\MUI\LPRemove" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\PI\Sqm-Tasks" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\PushToInstall\LoginCheck" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\RecoveryEnvironment\VerifyWinRE" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Registry\RegIdleBackup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Servicing\StartComponentCleanup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\SharedPC\Account Cleanup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\CreateObjectTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\FamilySafetyRefreshTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\IndexerAutomaticMaintenance" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\StateRepository\MaintenanceTasks" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Storage Tiers Management\Storage Tiers Optimization" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Subscription\LicenseAcquisition" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\HybridDriveCachePrepopulate" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\HybridDriveCacheRebalance" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\ResPriStaticDbSync" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UNP\RunUpdateNotificationMgr" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\MusUx_UpdateInterval" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Reboot_AC" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Reboot_Battery" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Report policies" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Work" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\User Profile Service\HiveUploadTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\WaaSMedic\MaintenanceWork" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Media Sharing\UpdateLibrary" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsUpdate\RUXIM\PLUGScheduler" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\WOF\WIM-Hash-Management" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\WOF\WIM-Hash-Validation" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Workplace Join\Automatic-Device-Join" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Workplace Join\Device-Sync" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Workplace Join\Recovery-Check" /Disable
SCHTASKS /Change /TN "\Microsoft\XblGameSave\XblGameSaveTask" /Disable
REM # EndExtractD1

::================================
::================================
:r5a.x1.2.Create-taskSchedularDefault
call :r3a.x12.3.downLoadF-taskCommand

set "directoryFiles=files\taskCommand"
set "nameFiles=taskSchedularDefault.bat"

::========================
::Function
::========================
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"

REM Set the filename for the extracted code
set "output_file=%startFiles%"

REM Find the line number where the code block starts
for /f "delims=:" %%i in ('findstr /n /c:"REM # StartExtractD2" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "delims=:" %%i in ('findstr /n /c:"REM # EndExtractD2" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) > "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"
exit /b

::========================
REM Your code starts here
::========================
REM # StartExtractD2
@echo off
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64 Critical	Running
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 Critical	Running
SCHTASKS /Change /TN "\Microsoft\Windows\Multimedia\SystemSoundsService	Running
SCHTASKS /Change /TN "\Microsoft\Windows\Wininet\CacheTask	Running
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Manual)" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\AppID\EDP Policy Manager" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\appuriverifierdaily" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\appuriverifierinstall" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\CleanupTemporaryState" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\DsSvcCleanup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\BitLocker\BitLocker Encrypt All Drives" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\BitLocker\BitLocker MDM policy Refresh" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Bluetooth\UninstallDeviceTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\AikCertEnrollTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\CryptoPolicyTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\KeyPreGenTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\SystemTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\UserTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CertificateServicesClient\UserTask-Roam" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Chkdsk\ProactiveScan" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Chkdsk\SyspartRepair" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Check And Scan" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan for Crash Recovery" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Device Information\Device" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Device Information\Device User" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Device Setup\Metadata Refresh" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\HandleCommand" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\HandleWnsCommand" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\IntegrityCheck" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\LocateCommandUserSession" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceAccountChange" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDevicePolicyChange" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceProtectionStateChanged" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceSettingChange" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceWnsFallback" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterUserDevice" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DirectX\DirectXDatabaseUpdater" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DirectX\DXGIAdapterCache" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskCleanup\SilentCleanup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskFootprint\Diagnostics" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskFootprint\StorageSense" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DUSM\dusmtask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\EDP\EDP App Launch Task" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\EDP\EDP Auth Task" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\EDP\EDP Inaccessible Credentials Task" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\EDP\StorageCardEncryption Task" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\EnterpriseMgmt\MDMMaintenenceTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Flighting\OneSettings\RefreshCache" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\HelloFace\FODCleanupTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Input\LocalUserSyncDataAvailable" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Input\MouseSyncDataAvailable" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Input\PenSyncDataAvailable" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Input\TouchpadSyncDataAvailable" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\ScanForUpdates" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\SmartRetry" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\International\Synchronize Language Settings" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\LanguageComponentsInstaller\Installation" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\License Manager\TempSignedLicenseExchange" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Location\Notifications" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Location\WindowsActionDialog" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Management\Provisioning\Cellular" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Management\Provisioning\Logon" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Maps\MapsToastTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\MUI\LPRemove" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\NlaSvc\WiFiTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\PI\Secure-Boot-Update" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\PI\Sqm-Tasks" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Plug and Play\Device Install Group Policy" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Plug and Play\Device Install Reboot Required" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Plug and Play\Sysprep Generalize Drivers" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Printing\EduPrintProv" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\PushToInstall\Registration" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Ras\MobilityManager" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\RecoveryEnvironment\VerifyWinRE" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Registry\RegIdleBackup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\RemovalTools\MRT_ERROR_HB" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Servicing\StartComponentCleanup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SettingSync\BackgroundUploadTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SettingSync\NetworkStateChangeTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\CreateObjectTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitor" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\FamilySafetyRefreshTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\IndexerAutomaticMaintenance" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\UpdateUserPictureTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SpacePort\SpaceAgentTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SpacePort\SpaceManagerTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Speech\HeadsetButtonPress" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Speech\SpeechModelDownloadTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\StateRepository\MaintenanceTasks" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Subscription\EnableLicenseAcquisition" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\ResPriStaticDbSync" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SystemRestore\SR" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Task Manager\Interactive" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\TextServicesFramework\MsCtfMonitor" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Time Zone\SynchronizeTimeZone" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\TPM\Tpm-HASCertRetr" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\TPM\Tpm-Maintenance" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Backup Scan" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\MusUx_UpdateInterval" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Report policies" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Start" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\UPnP\UPnPHostConfig" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\USB\Usb-Notifications" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WaaSMedic\PerformRemediation" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WCM\WiFiTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WDI\ResolutionHost" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Media Sharing\UpdateLibrary" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsColorSystem\Calibration Loader" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsUpdate\sihpostreboot" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WlanSvc\CDSSync" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WOF\WIM-Hash-Management" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WOF\WIM-Hash-Validation" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\WwanSvc\NotificationTask" /Enable
SCHTASKS /Change /TN "\Microsoft\XblGameSave\XblGameSaveTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Automated)" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\AppID\PolicyConverter" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\AppID\VerifiedPublisherCertStoreCheck" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Autochk\Proxy" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Clip\License Validation" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceLocationRightsChange" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDevicePeriodic24" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\File Classification Infrastructure\Property Definition Sync" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Management\Provisioning\Retry" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Management\Provisioning\RunOnReboot" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Offline Files\Background Synchronization" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Offline Files\Logon Synchronization" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\PushToInstall\LoginCheck" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\SharedPC\Account Cleanup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTaskLogon" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTaskNetwork" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Storage Tiers Management\Storage Tiers Optimization" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Subscription\LicenseAcquisition" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\HybridDriveCachePrepopulate" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\HybridDriveCacheRebalance" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UNP\RunUpdateNotificationMgr" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Maintenance Install" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Reboot_AC" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Reboot_Battery" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Work" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\User Profile Service\HiveUploadTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Workplace Join\Automatic-Device-Join" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Workplace Join\Device-Sync" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Workplace Join\Recovery-Check" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\WwanSvc\OobeDiscovery" /Disable
REM # EndExtractD2
::================================
::================================
:r5a.x1.3.Create-tasks-SM
call :r3a.x12.3.downLoadF-taskCommand

set "directoryFiles=files\taskCommand"
set "nameFiles=tasks-SM.bat"

::========================
::Function
::========================
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"

REM Set the filename for the extracted code
set "output_file=%startFiles%"

REM Find the line number where the code block starts
for /f "delims=:" %%i in ('findstr /n /c:"REM # StartExtractD3" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "delims=:" %%i in ('findstr /n /c:"REM # EndExtractD3" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) > "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"
exit /b

::========================
REM Your code starts here
::========================
REM # StartExtractD3
@echo off
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\CleanupTemporaryState" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\DsSvcCleanup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\AppListBackup\Backup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Device Setup\Metadata Refresh" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskCleanup\SilentCleanup" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskFootprint\StorageSense" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SettingSync\BackgroundUploadTask" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\SystemRestore\SR" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Time Zone\SynchronizeTimeZone" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64 Critical" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 Critical" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\ApplicationData\appuriverifierdaily" /Enable
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Chkdsk\ProactiveScan" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\DiskFootprint\Diagnostics" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\HelloFace\FODCleanupTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\License Manager\TempSignedLicenseExchange" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\MUI\LPRemove" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\PI\Sqm-Tasks" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\RecoveryEnvironment\VerifyWinRE" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Registry\RegIdleBackup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Servicing\StartComponentCleanup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\SharedPC\Account Cleanup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Shell\IndexerAutomaticMaintenance" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\StateRepository\MaintenanceTasks" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\HybridDriveCachePrepopulate" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\HybridDriveCacheRebalance" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\ResPriStaticDbSync" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Report policies" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\WOF\WIM-Hash-Validation" /Disable
SCHTASKS /Change /TN "\Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /Disable

REM # EndExtractD3
::================================
::================================
:r5a.x1.4.Create-deleteCmdBloatware
call :r3a.x12.2.downLoadF-deleteCmdBloatware

set "directoryFiles=files\debloatBloatware"
set "nameFiles=debloatBloatware.txt"

::========================
::Function
::========================
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"

REM Set the filename for the extracted code
set "output_file=%startFiles%"

REM Find the line number where the code block starts
for /f "delims=:" %%i in ('findstr /n /c:"REM # StartExtractD4" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "delims=:" %%i in ('findstr /n /c:"REM # EndExtractD4" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) > "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"
exit /b

::========================
REM Your code starts here
::========================
 REM # StartExtractD4
 @echo off
 
 set loc="%cd%"
 
 ::=========================================================
 c:
 cd "C:\Program Files\WindowsApps"
 
 rmdir /s /q Microsoft.MixedReality.Portal_2000.19081.1301.0_neutral_split.scale-100_8wekyb3d8bbwe
 rmdir /s /q Microsoft.MixedReality.Portal_2000.19081.1301.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.Office.OneNote_16001.12026.20112.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.People_10.1902.633.0_neutral_split.scale-100_8wekyb3d8bbwe
 rmdir /s /q Microsoft.People_2019.305.632.0_neutral_~_8wekyb3d8bbwe
 
 rmdir /s /q Microsoft.SkypeApp_14.53.77.0_neutral_split.scale-100_kzf8qxf38zg5c
 rmdir /s /q Microsoft.SkypeApp_14.53.77.0_neutral_~_kzf8qxf38zg5c
 
 rmdir /s /q Microsoft.Wallet_2.4.18324.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.WebMediaExtensions_1.0.20875.0_neutral_split.scale-100_8wekyb3d8bbwe
 rmdir /s /q Microsoft.WebMediaExtensions_1.0.20875.0_neutral_~_8wekyb3d8bbwe
 
 rmdir /s /q Microsoft.WindowsFeedbackHub_1.1907.3152.0_neutral_split.scale-100_8wekyb3d8bbwe
 rmdir /s /q Microsoft.WindowsFeedbackHub_2019.1111.2029.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.WindowsMaps_2019.716.2316.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.WindowsMaps_5.1906.1972.0_neutral_split.scale-100_8wekyb3d8bbwe
 rmdir /s /q Microsoft.Xbox.TCUI_1.23.28002.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.XboxApp_48.49.31001.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.XboxGameOverlay_1.46.11001.0_neutral_split.scale-100_8wekyb3d8bbwe
 rmdir /s /q Microsoft.XboxGameOverlay_1.46.11001.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.XboxGamingOverlay_2.34.28001.0_neutral_split.scale-100_8wekyb3d8bbwe
 rmdir /s /q Microsoft.XboxGamingOverlay_2.34.28001.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.XboxIdentityProvider_12.50.6001.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.XboxSpeechToTextOverlay_1.17.29001.0_neutral_split.scale-100_8wekyb3d8bbwe
 rmdir /s /q Microsoft.XboxSpeechToTextOverlay_1.17.29001.0_neutral_~_8wekyb3d8bbwe
 
 rmdir /s /q Microsoft.GetHelp_10.1706.13331.0_neutral_split.scale-100_8wekyb3d8bbwe
 rmdir /s /q Microsoft.GetHelp_10.1706.13331.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.Getstarted_8.2.22942.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.Microsoft3DViewer_6.1908.2042.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.Microsoft3DViewer_6.1908.2042.0_x64__8wekyb3d8bbwe
 rmdir /s /q Microsoft.MicrosoftOfficeHub_18.1903.1152.0_neutral_split.scale-100_8wekyb3d8bbwe
 rmdir /s /q Microsoft.MicrosoftOfficeHub_18.1903.1152.0_neutral_~_8wekyb3d8bbwe
 rmdir /s /q Microsoft.MicrosoftOfficeHub_18.1903.1152.0_x64__8wekyb3d8bbwe
 rmdir /s /q Microsoft.MicrosoftSolitaireCollection_4.4.8204.0_neutral_~_8wekyb3d8bbwe
 
 rmdir /s /q Deleted
 rmdir /s /q DeletedAllUserPackages
 rmdir /s /q movedpackages
 rmdir /s /q mutable
 rmdir /s /q MutableBackup
 
 ::DolbyLaboratories.DolbyAccess_3.10.188.0_x64__rz1tebttyb220
 ::Microsoft.DesktopAppInstaller_1.0.30251.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.DesktopAppInstaller_1.0.30251.0_x64__8wekyb3d8bbwe
 ::Microsoft.DesktopAppInstaller_2019.125.2243.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.HEIFImageExtension_1.0.22742.0_x64__8wekyb3d8bbwe
 ::Microsoft.LanguageExperiencePacken-GB_19041.22.57.0_neutral__8wekyb3d8bbwe
 ::Microsoft.MicrosoftStickyNotes_3.6.73.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.MicrosoftStickyNotes_3.6.73.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.MSPaint_2019.729.2301.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.MSPaint_6.1907.29027.0_x64__8wekyb3d8bbwe
 ::Microsoft.NET.Native.Framework.1.7_1.7.25531.0_x64__8wekyb3d8bbwe
 ::Microsoft.NET.Native.Framework.2.2_2.2.27405.0_x64__8wekyb3d8bbwe
 ::Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe
 ::Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x86__8wekyb3d8bbwe
 ::Microsoft.NET.Native.Runtime.1.7_1.7.25531.0_x64__8wekyb3d8bbwe
 ::Microsoft.NET.Native.Runtime.2.2_2.2.27328.0_x64__8wekyb3d8bbwe
 ::Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe
 ::Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x86__8wekyb3d8bbwe
 ::Microsoft.ScreenSketch_10.1907.2471.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.ScreenSketch_2019.904.1644.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.Windows.Photos_2019.19071.12548.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.Windows.Photos_2019.19071.12548.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.Windows.Photos_2019.19071.12548.0_x64__8wekyb3d8bbwe
 ::Microsoft.WindowsAlarms_10.1906.2182.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.WindowsAlarms_2019.807.41.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.WindowsCalculator_10.1906.55.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.WindowsCalculator_10.1906.55.0_x64__8wekyb3d8bbwe
 ::Microsoft.WindowsCalculator_2020.1906.55.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.WindowsCamera_2018.826.98.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.WindowsCamera_2018.826.98.0_x64__8wekyb3d8bbwe
 ::Microsoft.WindowsSoundRecorder_10.1906.1972.0_x64__8wekyb3d8bbwe
 ::Microsoft.WindowsSoundRecorder_2019.716.2313.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.WindowsStore_11910.1002.5.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.WindowsStore_11910.1002.5.0_x64__8wekyb3d8bbwe
 ::Microsoft.WindowsStore_11910.1002.513.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.YourPhone_0.19051.7.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.YourPhone_0.19051.7.0_x64__8wekyb3d8bbwe
 ::Microsoft.YourPhone_2019.430.2026.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.UI.Xaml.2.0_2.1810.18004.0_x64__8wekyb3d8bbwe
 ::Microsoft.VCLibs.140.00.UWPDesktop_14.0.27629.0_x64__8wekyb3d8bbwe
 ::Microsoft.VCLibs.140.00_14.0.27323.0_x64__8wekyb3d8bbwe
 ::Microsoft.VCLibs.140.00_14.0.30035.0_x64__8wekyb3d8bbwe
 ::Microsoft.VCLibs.140.00_14.0.30035.0_x86__8wekyb3d8bbwe
 ::Microsoft.Services.Store.Engagement_10.0.19011.0_x64__8wekyb3d8bbwe
 ::Microsoft.Services.Store.Engagement_10.0.19011.0_x86__8wekyb3d8bbwe
 ::Microsoft.StorePurchaseApp_11811.1001.18.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.StorePurchaseApp_11811.1001.18.0_x64__8wekyb3d8bbwe
 ::Microsoft.StorePurchaseApp_11811.1001.1813.0_neutral_~_8wekyb3d8bbwe
 ::microsoft.windowscommunicationsapps_16005.11629.20316.0_neutral_~_8wekyb3d8bbwe
 ::microsoft.windowscommunicationsapps_16005.11629.20316.0_x64__8wekyb3d8bbwe
 ::Microsoft.549981C3F5F10_1.1911.21713.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.BingWeather_4.25.20211.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.BingWeather_4.25.20211.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.BingWeather_4.25.20211.0_x64__8wekyb3d8bbwe
 ::Microsoft.ZuneMusic_10.19071.19011.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.ZuneMusic_10.19071.19011.0_x64__8wekyb3d8bbwe
 ::Microsoft.ZuneMusic_2019.19071.19011.0_neutral_~_8wekyb3d8bbwe
 ::Microsoft.ZuneVideo_10.19071.19011.0_neutral_split.scale-100_8wekyb3d8bbwe
 ::Microsoft.ZuneVideo_10.19071.19011.0_x64__8wekyb3d8bbwe
 ::Microsoft.ZuneVideo_2019.19071.19011.0_neutral_~_8wekyb3d8bbwe
 
 ::38 dir left
 
 ::==========================
 cd "c:\windows\systemapps"
 
 rmdir /s /q Windows.CBSPreview_cw5n1h2txyewy
 rmdir /s /q Microsoft.XboxGameCallableUI_cw5n1h2txyewy
 rmdir /s /q Microsoft.Advertising.Xaml_10.1808.3.0_x64__8wekyb3d8bbwe
 rmdir /s /q microsoft.microsoftedge_8wekyb3d8bbwe
 rmdir /s /q Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe
 
 ::34 Dir(s) left
 
 ::==========================
 cd "C:\ProgramData\Microsoft"
 
 rmdir /s /q EdgeUpdate
 
 ::==========================
 cd "C:\Program Files (x86)"
 rmdir /s /q "Internet Explorer"
 
 ::===========================
 cd "%userprofile%\AppData\Local\Microsoft"
 rmdir /s /q Edge
 rmdir /s /q EdgeUpdater
 rmdir /s /q "Internet Explorer"
 
 ::============================
 set "delLnk=c:\windows\system32\config\systemprofile\appdata\roaming\microsoft\internet explorer\quick launch\microsoft edge.lnk"
 IF EXIST "%delLnk%" del "%delLnk%"
 
 
 ::=========================================
 cd "%loc%"
 
 pause 
 exit
REM # EndExtractD4
::================================
::================================
:r5a.x1.4.2.Create-Delete_Bloatware
call :r3a.x12.2.downLoadF-deleteCmdBloatware

set "directoryFiles=files\debloatBloatware"
set "nameFiles=deleteBloatware.ps1"

::Function
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"

REM Set the filename for the extracted code
set "output_file=%startFiles%"

REM Find the line number where the code block starts
for /f "delims=:" %%i in ('findstr /n /c:"# StartExtractF42" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "delims=:" %%i in ('findstr /n /c:"# EndExtractF42" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) > "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"
exit /b

REM Your code starts here
# StartExtractF42
#ver:1.2

#============
#Check debloatBloatware folder exist.
#============
if (Test-Path -Path $PWD\debloatBloatware) {
    cd debloatBloatware
}
Add-Type -AssemblyName System.Windows.Forms

#============
# Check if appsBloatwareList.txt exists
#============
if (-not (Test-Path -Path "$PWD\appsBloatwareList.txt")) {
    Write-Host "appsBloatwareList.txt does not exist."

    # Set the filename for the extracted code
$output_file = "$PWD\appsBloatwareList.txt"

# Find the line number where the code block starts
$start_line = Select-String -Pattern "[startDeleteApps]" -Path $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty LineNumber

# Find the line number where the code block ends
$end_line = Select-String -Pattern "[endDeleteApps]" -Path $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty LineNumber

# Use the starting and ending lines to extract the desired code
$codeExtracted = Get-Content -Path $MyInvocation.MyCommand.Path | ForEach-Object -Begin {
    $extracting = $false
} -Process {
    if ($_.Trim() -eq "[startDeleteApps]") {
        $extracting = $true
    }
    if ($extracting) {
        $_
    }
    if ($_.Trim() -eq "[endDeleteApps]") {
        $extracting = $false
    }
}

$codeExtracted | Set-Content -Path $output_file
}

$appsToDelete = @(Get-Content -Path "$PWD\appsBloatwareList.txt" )

#============
# Check if appsWhiteList.txt exists
#============
if (-not (Test-Path -Path "$PWD\appsWhiteList.txt")) {
    Write-Host "appsWhiteList.txt does not exist."

    # Set the filename for the extracted code
$output_file = "$PWD\appsWhiteList.txt"

# Find the line number where the code block starts
$start_line = Select-String -Pattern "[startWhiteList]" -Path $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty LineNumber

# Find the line number where the code block ends
$end_line = Select-String -Pattern "[endWhiteList]" -Path $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty LineNumber

# Use the starting and ending lines to extract the desired code
$codeExtracted = Get-Content -Path $MyInvocation.MyCommand.Path | ForEach-Object -Begin {
    $extracting = $false
} -Process {
    if ($_.Trim() -eq "[startWhiteList]") {
        $extracting = $true
    }
    if ($extracting) {
        $_
    }
    if ($_.Trim() -eq "[endWhiteList]") {
        $extracting = $false
    }
}

$codeExtracted | Set-Content -Path $output_file
}

$appsWhiteListAdvanced = @(Get-Content -Path "$PWD\appsWhiteList.txt")

#============
#Exclusion list
#============
$appNamesToExclude = $appsToDelete + $appsWhiteListAdvanced


# Get the list of all installed apps excluding the ones from the exclusion list
$appsRemainingListA = Get-AppxPackage | Where-Object { $appNamesToExclude -notcontains $_.Name }

$appsRemainingList = $appsRemainingListA.Name

#$appsRemainingList | Select Name, InstallLocation | Out-GridView

#========================
#Create PED Tool Box Debloat Bloatware Function
#========================
cls

#main(
# Function to create a Windows Forms checkbox
function New-CheckBox($text, $x, $y, $width, $height) {
    $checkBox = New-Object Windows.Forms.CheckBox
    $checkBox.Text = $text
    $checkBox.Location = New-Object Drawing.Point($x, $y)
    $checkBox.Width = $width
    $checkBox.Height = $height
    $checkBox.Checked = $false
    return $checkBox
}
#main)

#advanced(
function New-CheckBoxAdvanced($text, $x, $y, $width, $height) {
    $checkBoxAdvanced = New-Object Windows.Forms.CheckBox
    $checkBoxAdvanced.Text = $text
    $checkBoxAdvanced.Location = New-Object Drawing.Point($x, $y)
    $checkBoxAdvanced.Width = $width
    $checkBoxAdvanced.Height = $height
    $checkBoxAdvanced.Checked = $false
    return $checkBoxAdvanced
}
#advanced)

#Remaining(
function New-CheckBoxRemaining($text, $x, $y, $width, $height) {
    $checkBoxRemaining = New-Object Windows.Forms.CheckBox
    $checkBoxRemaining.Text = $text
    $checkBoxRemaining.Location = New-Object Drawing.Point($x, $y)
    $checkBoxRemaining.Width = $width
    $checkBoxRemaining.Height = $height
    $checkBoxRemaining.Checked = $false
    return $checkBoxRemaining
}
#Remaining)


# Create the Windows Forms GUI
$form = New-Object Windows.Forms.Form
$form.Text = "      PED Tool Box Debloat Bloatware      "
$form.Width = 1200
$form.Height = 750

# Create a TabControl
$tabControl = New-Object Windows.Forms.TabControl
$tabControl.Dock = [System.Windows.Forms.DockStyle]::Fill

# Tab 1 - Main tab
$tabMain = New-Object Windows.Forms.TabPage
$tabMain.Text = "      Delete Bloatware      "
$tabMain.Size = New-Object Drawing.Size(700, 400)
$tabControl.TabPages.Add($tabMain)


# Tab 2 - Advanced tab
$tabAdvanced = New-Object Windows.Forms.TabPage
$tabAdvanced.Text = "      White List (Do not delete)      "
$tabMain.Size = New-Object Drawing.Size(600, 400)
$tabControl.TabPages.Add($tabAdvanced)

# Tab 3 - Custom tab
$tabRemaining = New-Object Windows.Forms.TabPage
$tabRemaining.Text = "      Remaining Apps (Advanced)      "
$tabMain.Size = New-Object Drawing.Size(600, 400)
$tabControl.TabPages.Add($tabRemaining)

# Tab 4 - Settings tab
#$tabSettings = New-Object Windows.Forms.TabPage
#$tabSettings.Text = "Settings"
#$tabControl.TabPages.Add($tabSettings)



#main(
# Create a FlowLayoutPanel for buttons and separator
$buttonsPanel = New-Object Windows.Forms.FlowLayoutPanel
$buttonsPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::LeftToRight
$buttonsPanel.Dock = [System.Windows.Forms.DockStyle]::Top
$buttonsPanel.WrapContents = $false
#main)

#advanced(
# Create a FlowLayoutPanelAdvanced for buttons and separator
$buttonsPanelAdvanced = New-Object Windows.Forms.FlowLayoutPanel
$buttonsPanelAdvanced.FlowDirection = [System.Windows.Forms.FlowDirection]::LeftToRight
$buttonsPanelAdvanced.Dock = [System.Windows.Forms.DockStyle]::Top
$buttonsPanelAdvanced.WrapContents = $false
#advanced)

#Remaining(
# Create a FlowLayoutPanelRemaining for buttons and separator
$buttonsPanelRemaining = New-Object Windows.Forms.FlowLayoutPanel
$buttonsPanelRemaining.FlowDirection = [System.Windows.Forms.FlowDirection]::LeftToRight
$buttonsPanelRemaining.Dock = [System.Windows.Forms.DockStyle]::Top
$buttonsPanelRemaining.WrapContents = $false
#Remaining)

#main(
# Create a separator line
$line = New-Object Windows.Forms.Label
$line.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$line.Height = 2
#main)

#advanced(
# Create a separator lineAdvanced
$lineAdvanced = New-Object Windows.Forms.Label
$lineAdvanced.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$lineAdvanced.Height = 2
#advanced)

#Remaining(
# Create a separator lineRemaining
$lineRemaining = New-Object Windows.Forms.Label
$lineRemaining.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$lineRemaining.Height = 2
#Remaining)

#main(
# Create a FlowLayoutPanel for the button panel (Select All, Clear, Delete)
$buttonsFlowPanel = New-Object Windows.Forms.FlowLayoutPanel
$buttonsFlowPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::LeftToRight
$buttonsFlowPanel.Dock = [System.Windows.Forms.DockStyle]::Top
$buttonsFlowPanel.WrapContents = $false
#main)

#advanced(
# Create a FlowLayoutPanelAdvanced for the button panel (Select All, Clear, Delete)
$buttonsFlowPanelAdvanced = New-Object Windows.Forms.FlowLayoutPanel
$buttonsFlowPanelAdvanced.FlowDirection = [System.Windows.Forms.FlowDirection]::LeftToRight
$buttonsFlowPanelAdvanced.Dock = [System.Windows.Forms.DockStyle]::Top
$buttonsFlowPanelAdvanced.WrapContents = $false
#advanced)

#Remaining(
# Create a FlowLayoutPanel for the button panel (Select All, Clear, Delete)
$buttonsFlowPanelRemaining = New-Object Windows.Forms.FlowLayoutPanel
$buttonsFlowPanelRemaining.FlowDirection = [System.Windows.Forms.FlowDirection]::LeftToRight
$buttonsFlowPanelRemaining.Dock = [System.Windows.Forms.DockStyle]::Top
$buttonsFlowPanelRemaining.WrapContents = $false
#Remaining)

#main(
# Create the buttons
$btnSelectAll = New-Object Windows.Forms.Button
$btnSelectAll.Text = "Select All"
$btnSelectAll.Width = 200

$btnClear = New-Object Windows.Forms.Button
$btnClear.Text = "Clear"
$btnClear.Width = 100

$btnDelete = New-Object Windows.Forms.Button
$btnDelete.Text = "Delete"
$btnDelete.Width = 100
#main)

#advanced(
# Create the buttons
$btnSelectAllAdvanced = New-Object Windows.Forms.Button
$btnSelectAllAdvanced.Text = "Select All"
$btnSelectAllAdvanced.Width = 100

$btnClearAdvanced = New-Object Windows.Forms.Button
$btnClearAdvanced.Text = "Clear"
$btnClearAdvanced.Width = 100

$btnDeleteAdvanced = New-Object Windows.Forms.Button
$btnDeleteAdvanced.Text = "Delete"
$btnDeleteAdvanced.Width = 100
#advanced)

#Remaining(
# Create the buttons
$btnSelectAllRemaining = New-Object Windows.Forms.Button
$btnSelectAllRemaining.Text = "Select All"
$btnSelectAllRemaining.Width = 100

$btnClearRemaining = New-Object Windows.Forms.Button
$btnClearRemaining.Text = "Clear"
$btnClearRemaining.Width = 100

$btnDeleteRemaining = New-Object Windows.Forms.Button
$btnDeleteRemaining.Text = "Delete"
$btnDeleteRemaining.Width = 100
#Remaining)

#main(
# Add buttons to the buttonsFlowPanel
$buttonsFlowPanel.Controls.Add($btnSelectAll)
$buttonsFlowPanel.Controls.Add($btnClear)
$buttonsFlowPanel.Controls.Add($btnDelete)
#main)

#advanced(
# Add buttons to the buttonsFlowPaneAdvanced
$buttonsFlowPanelAdvanced.Controls.Add($btnSelectAllAdvanced)
$buttonsFlowPanelAdvanced.Controls.Add($btnClearAdvanced)
$buttonsFlowPanelAdvanced.Controls.Add($btnDeleteAdvanced)
#advanced)

#Remaining(
# Add buttons to the buttonsFlowPaneRemaining
$buttonsFlowPanelRemaining.Controls.Add($btnSelectAllRemaining)
$buttonsFlowPanelRemaining.Controls.Add($btnClearRemaining)
$buttonsFlowPanelRemaining.Controls.Add($btnDeleteRemaining)
#Remaining)

#main(
# Create a FlowLayoutPanel for the scrollable panel
$scrollablePanel = New-Object Windows.Forms.FlowLayoutPanel
$scrollablePanel.FlowDirection = [System.Windows.Forms.FlowDirection]::TopDown
$scrollablePanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$scrollablePanel.AutoScroll = $true
#main)

#advanced(
# Create a FlowLayoutPanel for the scrollable panel
$scrollablePanelAdvanced = New-Object Windows.Forms.FlowLayoutPanel
$scrollablePanelAdvanced.FlowDirection = [System.Windows.Forms.FlowDirection]::TopDown
$scrollablePanelAdvanced.Dock = [System.Windows.Forms.DockStyle]::Fill
$scrollablePanelAdvanced.AutoScroll = $true
#advanced)

#Remaining(
# Create a FlowLayoutPanel for the scrollable panel
$scrollablePanelRemaining = New-Object Windows.Forms.FlowLayoutPanel
$scrollablePanelRemaining.FlowDirection = [System.Windows.Forms.FlowDirection]::TopDown
$scrollablePanelRemaining.Dock = [System.Windows.Forms.DockStyle]::Fill
$scrollablePanelRemaining.AutoScroll = $true
#Remaining)

#System.Windows.Forms.FlowLayoutPanel, BorderStyle: System.Windows.Forms.BorderStyle.None
#main(
$checkBoxes = @()
$yPos = 10

# Create checkboxes for each app in the list if found
foreach ($appNameM in $appsToDelete) {
    $app = Get-AppxPackage | Where-Object { $_.Name -eq $appNameM }
    if ($app) {
        $checkBox = New-CheckBox $appNameM 10 $yPos 300 20
        $checkBoxes += $checkBox
        $scrollablePanel.Controls.Add($checkBox)
        $yPos += 30
    }
}

#main)

#Advanced(
$checkBoxesAdvanced = @()
$yPosAdvanced = 10

# Create checkBoxesAdvanced for each app in the list if found
foreach ($appNameA in $appsWhiteListAdvanced) {
	
    $app = Get-AppxPackage | Where-Object { $_.Name -eq $appNameA }
	
    if ($app) {
        $checkBoxAdvanced = New-checkBox $appNameA 10 $yPosAdvanced 300 20
        $checkBoxesAdvanced += $checkBoxAdvanced
        $scrollablePanelAdvanced.Controls.Add($checkBoxAdvanced)
        $yPosAdvanced += 30
    }
}
#Advanced)

#Remaining(
$checkBoxesRemaining = @()
$yPosRemaining = 10

# Create checkBoxesRemaining for each app in the list if found
foreach ($appNameR in $appsRemainingList) {
    $app = Get-AppxPackage | Where-Object { $_.Name -eq $appNameR }
    if ($app) {
		$checkBoxRemaining = New-checkBox $appNameR 10 $yPosRemaining 300 20
        $checkBoxesRemaining += $checkBoxRemaining
        $scrollablePanelRemaining.Controls.Add($checkBoxRemaining)
		$yPosRemaining += 30
    }
}
#Remaining)

#main(
# Add controls to the main tab
$tabMain.Controls.Add($buttonsFlowPanel)
$tabMain.Controls.Add($line)
$tabMain.Controls.Add($scrollablePanel)
#main)

#advanced(
# Add controls to the Advanced tab
$tabAdvanced.Controls.Add($buttonsFlowPanelAdvanced)
$tabAdvanced.Controls.Add($lineAdvanced)
$tabAdvanced.Controls.Add($scrollablePanelAdvanced)
#advanced)

#Remaining(
# Add controls to the Remaining tab
$tabRemaining.Controls.Add($buttonsFlowPanelRemaining)
$tabRemaining.Controls.Add($lineRemaining)
$tabRemaining.Controls.Add($scrollablePanelRemaining)
#Remaining)

#main(
# Event handler for Select All button
$btnSelectAll.Add_Click({
    foreach ($checkBox in $checkBoxes) {
        $checkBox.Checked = $true
    }
})

# Event handler for Clear button
$btnClear.Add_Click({
    foreach ($checkBox in $checkBoxes) {
        $checkBox.Checked = $false
    }
})

# Event handler for Delete button
$btnDelete.Add_Click({
    foreach ($checkBox in $checkBoxes) {
        if ($checkBox.Checked) {
            $appName = $checkBox.Text
            $app = Get-AppxPackage | Where-Object { $_.Name -eq $appName }
            if ($app) {
                Write-Host "Deleting $($app.Name)..."
                Remove-AppxPackage -Package $app.PackageFullName
                Write-Host "Successfully deleted $($app.Name)."
            } else {
                Write-Host "App with the name '$appName' was not found."
            }
        }
    }
    $form.Close()
})
#main)

#Advanced(
# Event handler for Select All button
$btnSelectAllAdvanced.Add_Click({
    foreach ($checkBoxAdvanced in $checkBoxesAdvanced) {
        $checkBoxAdvanced.Checked = $true
    }
})

# Event handler for Clear button
$btnClearAdvanced.Add_Click({
    foreach ($checkBoxAdvanced in $checkBoxesAdvanced) {
        $checkBoxAdvanced.Checked = $false
    }
})

# Event handler for Delete button
$btnDeleteAdvanced.Add_Click({
    foreach ($checkBoxAdvanced in $checkBoxesAdvanced) {
        if ($checkBoxAdvanced.Checked) {
            $appName = $checkBoxAdvanced.Text
            $app = Get-AppxPackage | Where-Object { $_.Name -eq $appName }
            if ($app) {
                Write-Host "Deleting $($app.Name)..."
                Remove-AppxPackage -Package $app.PackageFullName
                Write-Host "Successfully deleted $($app.Name)."
            } else {
                Write-Host "App with the name '$appName' was not found."
            }
        }
    }
    $form.Close()
})
#Advanced)

#Remaining(
# Event handler for Select All button
$btnSelectAllRemaining.Add_Click({
    foreach ($checkBoxRemaining in $checkBoxesRemaining) {
        $checkBoxRemaining.Checked = $true
    }
})

# Event handler for Clear button
$btnClearRemaining.Add_Click({
    foreach ($checkBoxRemaining in $checkBoxesRemaining) {
        $checkBoxRemaining.Checked = $false
    }
})

# Event handler for Delete button
$btnDeleteRemaining.Add_Click({
    foreach ($checkBoxRemaining in $checkBoxesRemaining) {
        if ($checkBoxRemaining.Checked) {
            $appName = $checkBoxRemaining.Text
            $app = Get-AppxPackage | Where-Object { $_.Name -eq $appName }
            if ($app) {
                Write-Host "Deleting $($app.Name)..."
                Remove-AppxPackage -Package $app.PackageFullName
                Write-Host "Successfully deleted $($app.Name)."
            } else {
                Write-Host "App with the name '$appName' was not found."
            }
        }
    }
    $form.Close()
})
#Remaining)

#(
# If no checkboxes were added, show a message
if ($checkBoxes.Count -eq 0) {
	Write-Host "No apps to delete."
}

$form.Controls.Add($tabControl)
$form.Add_Shown({ $form.Activate() })
    
# Show the form
$result = $form.ShowDialog()

if ($result -eq [Windows.Forms.DialogResult]::OK) {
	# OK button was clicked
	Write-Host "Deletion process completed."
} else {
        # The form was closed or canceled
        Write-Host "Deletion was canceled."
}
$pp=timeout /t 2;

#)


exit

#========================
#appsBloatwareList.txt
#========================
[startDeleteApps]
Microsoft.MixedReality.Portal
Microsoft.Office.OneNote
Microsoft.People
Microsoft.SkypeApp
Microsoft.Wallet
Microsoft.WebMediaExtensions
Microsoft.WindowsFeedbackHub
Microsoft.WindowsMaps
Microsoft.Xbox.TCUI
Microsoft.XboxApp
Microsoft.XboxGameOverlay
Microsoft.XboxGamingOverlay
Microsoft.XboxIdentityProvider
Microsoft.XboxSpeechToTextOverlay
Microsoft.GetHelp
Microsoft.Getstarted
Microsoft.Microsoft3DViewer
Microsoft.MicrosoftOfficeHub
Microsoft.MicrosoftSolitaireCollection
Windows.CBSPreview
Microsoft.XboxGameCallableUI
Microsoft.Advertising.Xaml
microsoft.microsoftedge
Microsoft.MicrosoftEdgeDevToolsClient
[endDeleteApps]

#========================
appsWhiteList.txt
#========================

[startWhiteList]
Microsoft.BingWeather
Microsoft.DesktopAppInstaller
Microsoft.MicrosoftStickyNotes
Microsoft.MSPaint
Microsoft.ScreenSketch
Microsoft.Windows.Photos
Microsoft.WindowsAlarms
Microsoft.WindowsCalculator
Microsoft.WindowsCamera
Microsoft.WindowsSoundRecorder
Microsoft.WindowsStore
Microsoft.YourPhone
Microsoft.ZuneMusic
Microsoft.ZuneVideo
Microsoft.Winget.Source
Microsoft.NET.Native.Framework.1.7
Microsoft.NET.Native.Runtime.1.7
microsoft.windowscommunicationsapps
Microsoft.HEIFImageExtension
AmazonMobileLLC.AmazonMusic
Microsoft.Office.Word
Microsoft.Office.Excel
Microsoft.WebMediaExtensions
Microsoft.LanguageExperiencePacken-GB

DolbyLaboratories.DolbyAccess
windows.immersivecontrolpanel
Windows.PrintDialog
Microsoft.Windows.CloudExperienceHost
Microsoft.BioEnrollment
Microsoft.Windows.OOBENetworkConnectionFlow
Microsoft.AAD.BrokerPlugin
MicrosoftWindows.UndockedDevKit
Microsoft.Windows.OOBENetworkCaptivePortal
Microsoft.Windows.StartMenuExperienceHost
Microsoft.Windows.ContentDeliveryManager
Windows.CBSPreview
NcsiUwpApp
Microsoft.Windows.XGpuEjectDialog
Microsoft.Windows.PinningConfirmationDialog
Microsoft.Windows.PeopleExperienceHost
Microsoft.Windows.ParentalControls
Microsoft.Windows.NarratorQuickStart
Microsoft.Windows.CapturePicker
Microsoft.Windows.CallingShellApp
Microsoft.Windows.Apprep.ChxApp
Microsoft.Win32WebViewHost
Microsoft.LockApp
Microsoft.ECApp
Microsoft.CredDialogHost
Microsoft.AsyncTextService
Microsoft.AccountsControl
F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE
E2A4F912-2574-4A75-9BB0-0D023378592B
1527c705-839a-4832-9118-54d4Bd6a0c89
Microsoft.NET.Native.Runtime.2.2
Microsoft.NET.Native.Runtime.2.2
Microsoft.Services.Store.Engagement
Microsoft.Services.Store.Engagement
Microsoft.NET.Native.Framework.2.2
Microsoft.NET.Native.Framework.2.2
Microsoft.VCLibs.140.00
Microsoft.UI.Xaml.2.4
Microsoft.UI.Xaml.2.4
Microsoft.VCLibs.140.00
Microsoft.UI.Xaml.2.0
Microsoft.StorePurchaseApp
Microsoft.UI.Xaml.2.7
Microsoft.Windows.ShellExperienceHost
Microsoft.Windows.SecHealthUI
c5e2524a-ea46-4f67-841f-6a9465d9d515
Microsoft.PPIProjection
Microsoft.UI.Xaml.2.7
Microsoft.UI.Xaml.2.7
Microsoft.NET.CoreRuntime.2.2
Microsoft.NET.CoreFramework.Debug.2.2
Microsoft.VCLibs.140.00.Debug
Microsoft.VCLibs.120.00.Debug.Universal
Microsoft.VCLibs.120.00.Universal
f7fa72ea-82e5-4c39-a599-61b99a44fa42
Microsoft.Windows.Search
MicrosoftWindows.Client.CBS
Microsoft.VCLibs.140.00
Microsoft.VCLibs.140.00
Microsoft.VCLibs.140.00.UWPDesktop
Microsoft.VCLibs.140.00.UWPDesktop
Microsoft.UI.Xaml.2.8
Microsoft.UI.Xaml.2.8
[endWhiteList]


#========================
more:
C:\ProgramData\Microsoft\EdgeUpdate
C:\Program Files\Internet Explorer
%userprofile%\AppData\Local\Microsoft\
%userprofile%\AppData\Local\Microsoft\Edge
%userprofile%\AppData\Local\Microsoft\ EdgeUpdater
%userprofile%\AppData\Local\Microsoft\Internet Explorer

# EndExtractF42
::================================
::================================
:r5a.x1.5.Create-PEDcpuRamV12
call :r3a.x12.4.downLoadF-cpuRam

set "directoryFiles=files\cpuRam"
set "nameFiles=PEDcpuRamV12.bat"

::========================
::Function
::========================
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"

REM Set the filename for the extracted code
set "output_file=%startFiles%"

REM Find the line number where the code block starts
for /f "tokens=1 delims=:" %%i in ('findstr /n /c:"REM # StartExtractD5" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "tokens=1 delims=:" %%i in ('findstr /n /c:"REM # EndExtractD5" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) > "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"
exit /b

::========================
:: Your code starts here
::========================

REM # StartExtractD5
@echo off
 ::V-pedCpuRam-1.2.23.06.08(3)
mode con: cols=37 lines=4

powershell.exe -ExecutionPolicy Bypass -Command ^
"Write-Host ''; ^
$bootTime = ''; ^
while (^!$bootTime) { ^^
    $cpuPro = (Get-Process).Count; ^
	$memoryTotal = '{0:N0}' -f ((Get-WMIObject Win32_PhysicalMemory ^| Measure-Object Capacity -Sum).sum/1048576); ^
	$memoryAvailable = '{0:N0}' -f [math]::Round((wmic OS get FreePhysicalMemory)[2] / 1024); ^
	$memoryInUse = '{0:N0}' -f ($memoryTotal-$memoryAvailable); ^
	cls;^
	Write-Host ''; ^
	Write-Host (' Processes running     :   '  + $cpuPro); ^
	Write-Host (' Physical Memory In Use:   ' + $memoryInUse + ' MB'); ^
	$pp=timeout /t 2;^
}; ^
"


REM # EndExtractD5
::================================
::================================
:r5a.x1.6.Create-PED-BootTimer
call :r3a.x12.1.downLoadF-bootTimer

set "directoryFiles=files\bootTimer"
set "nameFiles=PED-BootTimer.bat"

::========================
::Function
::========================

set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"

REM Set the filename for the extracted code
set "output_file=%startFiles%"

REM Find the line number where the code block starts
for /f "delims=:" %%i in ('findstr /n /c:"REM # StartExtractD6" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "delims=:" %%i in ('findstr /n /c:"REM # EndExtractD6" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) > "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"

exit /b

::========================
:: Your code starts here
::========================
REM # StartExtractD6
@echo off
cls
COLOR 0A
mode con: cols=52 lines=27
set "ver=PED ToolBox - BootTimer V1.30.230608.3"
cd C:\ProgramData\PEDToolBox\pedDownload\files\bootTimer
title	%ver%
echo 	[%ver%]
echo.
echo.
echo.
echo ...................[Please wait]...................
echo.
echo.
echo.

powershell.exe -ExecutionPolicy Bypass -Command ^
"Write-Host ''; ^

$bootTime = ''; ^
while (^!$bootTime) { ^^
    $bootTime = (([string] ((Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime)) -split '\.')[0]; ^
}; ^

$virtualMemory = systeminfo; ^
$systemBootTime = ((Get-CimInstance Win32_OperatingSystem).LastBootUpTime).ToString('MM/dd/yyyy, HH:mm:ss'); ^
$cpuPro = (Get-Process).Count; ^
$cpuThreads = (Get-Process ^| Select-Object -ExpandProperty Threads).Count; ^
$memoryTotal = '{0:N0}' -f ((Get-WMIObject Win32_PhysicalMemory ^| Measure-Object Capacity -Sum).sum/1048576); ^
$memoryAvailable = '{0:N0}' -f [math]::Round((wmic OS get FreePhysicalMemory)[2] / 1024); ^
$memoryInUse = '{0:N0}' -f ($memoryTotal-$memoryAvailable); ^

Write-Host '===================================================='; ^
Write-Host (' Boot Time:                 ' + $bootTime); ^
Write-Host '===================================================='; ^
Write-Host (' System Boot Time:          ' + $systemBootTime); ^
Write-Host '_________________________'; ^
Write-Host '********* CPU ***********'; ^
Write-Host ''; ^
Write-Host (' Processes running:         '  + $cpuPro); ^
Write-Host (' Threads running:           ' + $cpuThreads); ^
Write-Host '_________________________'; ^
Write-Host '********* RAM ***********'; ^
Write-Host ''; ^
Write-Host (' Physical Memory: Max Size  ' + $memoryTotal + ' MB'); ^
Write-Host (' Physical Memory: Available ' + $memoryAvailable + ' MB'); ^
Write-Host (' Physical Memory: In Use    ' + $memoryInUse + ' MB'); ^
Write-Host ''; ^
Write-Host ''($virtualMemory ^| find /i 'Virtual Memory: Max Size'); ^
Write-Host ''($virtualMemory ^| find /i 'Virtual Memory: Available:'); ^
Write-Host ''($virtualMemory ^| find /i 'Virtual Memory: In Use:'); ^

$finalBootTime = ''; ^
while (^!$finalBootTime) { ^^
    $finalBootTime = (([string] ((Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime)) -split '\.')[0]; ^
}; ^
Write-Host '===================================================='; ^
Write-Host (' Final Boot Time:           ' + $finalBootTime); ^
Write-Host '===================================================='; ^
$finalBootTime ^> a3.txt; ^
" > a1.txt
cls
type a1.txt
type a1.txt >> 0.bootLog.txt
type a3.txt >> 0.bootTimer.txt
del a3.txt
del a1.txt
echo 		PC is ready to use.
echo ====================================================
echo 	Press any key to clean TEMP folder
pause >nul

cls
del /s /f /q c:\windows\temp\*.* 
del /s /f /q c:\WINDOWS\Prefetch\*.* 
del /s /f /q %temp%\*.* 

for /f "tokens=1,2*" %%V IN ('bcdedit') do set adminTest=%%V
if (%adminTest%)==(Access) exit
for /f "tokens=*" %%G in ('wevtutil.exe el') do (call :r5a.x1.6.1.wevtutil "%%G")

 :r5a.x1.6.1.wevtutil
echo clearing %1
wevtutil.exe cl %1
exit
REM # EndExtractD6
::================================
::================================
:r5a.x1.7.Create-PED-BootTimerMessage
call :r3a.x12.1.downLoadF-bootTimer

set "directoryFiles=files\bootTimer"
set "nameFiles=PED-BootTimer.bat"

::========================
::Function
::========================
set "startFiles=%destinationPD%\%directoryFiles%\%nameFiles%"

REM Set the filename for the extracted code
set "output_file=%startFiles%"

REM Find the line number where the code block starts
for /f "delims=:" %%i in ('findstr /n /c:"REM # StartExtractD7" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "delims=:" %%i in ('findstr /n /c:"REM # EndExtractD7" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) > "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"
exit /b

::========================
REM Your code starts here
::========================
REM # StartExtractD7
@echo off
cls
COLOR 0A

if not "%1"=="min" start /min cmd /c %0 min & exit/b
set "ver=PED-Toolbox-BootTimer-V1.31.230802"
cd C:\ProgramData\PEDToolBox\pedDownload\files\bootTimer
title	%ver%
echo 	[%ver%]
echo.
echo.
echo.
echo ...................[Please wait]....................
echo.
echo.
echo.

powershell.exe -ExecutionPolicy Bypass -Command ^
"Write-Host ''; ^

$bootTime = ''; ^
while (^!$bootTime) { ^^
    $bootTime = (([string] ((Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime)) -split '\.')[0]; ^
}; ^

$virtualMemory = systeminfo; ^
$systemBootTime = ((Get-CimInstance Win32_OperatingSystem).LastBootUpTime).ToString('MM/dd/yyyy, HH:mm:ss'); ^
$cpuPro = (Get-Process).Count; ^
$cpuThreads = (Get-Process ^| Select-Object -ExpandProperty Threads).Count; ^
$memoryTotal = '{0:N0}' -f ((Get-WMIObject Win32_PhysicalMemory ^| Measure-Object Capacity -Sum).sum/1048576); ^
$memoryAvailable = '{0:N0}' -f [math]::Round((wmic OS get FreePhysicalMemory)[2] / 1024); ^
$memoryInUse = '{0:N0}' -f ($memoryTotal-$memoryAvailable); ^

Write-Host '=============================================='; ^
Write-Host (' Boot Time:		' + $bootTime); ^
Write-Host '=============================================='; ^
Write-Host (' System Boot Time:		' + $systemBootTime); ^
Write-Host '_________________________'; ^
Write-Host '********* CPU ***********'; ^
Write-Host ''; ^
Write-Host (' Processes running:	'  + $cpuPro); ^
Write-Host (' Threads running:		' + $cpuThreads); ^
Write-Host '_________________________'; ^
Write-Host '********* RAM ***********'; ^
Write-Host ''; ^
Write-Host (' Physical Memory: Max Size  ' + $memoryTotal + ' MB'); ^
Write-Host (' Physical Memory: Available ' + $memoryAvailable + ' MB'); ^
Write-Host (' Physical Memory: In Use     ' + $memoryInUse + ' MB'); ^
Write-Host ''; ^
Write-Host ''($virtualMemory ^| find /i 'Virtual Memory: Max Size'); ^
Write-Host ''($virtualMemory ^| find /i 'Virtual Memory: Available:'); ^
Write-Host ' '($virtualMemory ^| find /i 'Virtual Memory: In Use:'); ^

$finalBootTime = ''; ^
while (^!$finalBootTime) { ^^
    $finalBootTime = (([string] ((Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime)) -split '\.')[0]; ^
}; ^
Write-Host '=============================================='; ^
Write-Host (' Final Boot Time:                  ' + $finalBootTime); ^
Write-Host '=============================================='; ^
$finalBootTime ^> a3.txt; ^
" > a1.txt
cls
call :r5a.x1.7.2.messageFunction

::type a1.txt
type a1.txt >> 0.bootLog.txt
type a3.txt >> 0.bootTimer.txt
del a3.txt
del a1.txt
echo 		PC is ready to use.
echo ====================================================
echo 	Press any key to clean TEMP folders
::pause >nul

cls
del /s /f /q c:\windows\temp\*.* 
del /s /f /q c:\WINDOWS\Prefetch\*.* 
del /s /f /q %temp%\*.* 

for /f "tokens=1,2*" %%V IN ('bcdedit') do set adminTest=%%V
if (%adminTest%)==(Access) exit
for /f "tokens=*" %%G in ('wevtutil.exe el') do (call :80a.6.1.wevtutil "%%G")

 :r5a.x1.7.1.wevtutil
echo clearing %1
wevtutil.exe cl %1
exit

 :r5a.x1.7.2.messageFunction
set "messageFile=a1.txt"

REM Check if the message file exists
if not exist "%messageFile%" (
    echo Error: The specified text file does not exist.
    pause
    exit /b 1
)

REM Read the content of the text file into a variable
set "message="
for /f "usebackq delims=" %%i in ("%messageFile%") do set "message=!message! %%i"

REM Create a temporary VBScript file
echo Set objArgs = WScript.Arguments>"%temp%\popup_message.vbs"
echo messageFile = objArgs(0)>>"%temp%\popup_message.vbs"
echo.>>"%temp%\popup_message.vbs"
echo Set objFSO = CreateObject("Scripting.FileSystemObject")>>"%temp%\popup_message.vbs"
echo Set objFile = objFSO.OpenTextFile(messageFile, 1)>>"%temp%\popup_message.vbs"
echo.>>"%temp%\popup_message.vbs"
echo message = objFile.ReadAll>>"%temp%\popup_message.vbs"
echo objFile.Close>>"%temp%\popup_message.vbs"
echo.>>"%temp%\popup_message.vbs"
echo MsgBox message>>"%temp%\popup_message.vbs"

REM Show the pop-up message using the temporary VBScript
cscript /nologo "%temp%\popup_message.vbs" "%messageFile%"

REM Clean up the temporary VBScript file
del "%temp%\popup_message.vbs" /q
exit /b
REM # EndExtractD7
::================================
::================================
:r5a.x2.1.renameGlaryConfig

setlocal

REM Get the computer name and user name
set "computer_name=%COMPUTERNAME%"
set "user_name=%USERNAME%"

REM Set the source file name and extension
set "source_file=%destination%\glaryConfig.guc"

REM Extract the file extension from the source file
for %%F in ("%source_file%") do (
    set "file_name=%%~nF"
    set "file_extension=%%~xF"
)

REM Set the new file name using the computer name and user name
set "new_file_name=%computer_name%_%user_name%%file_extension%"

REM Rename the file
if exist "%destination%\%new_file_name%" del "%destination%\%new_file_name%"
ren "%source_file%" "%new_file_name%"

exit /b

::================================
:r5a.x3.1.tasksBackup
::================================
CLS
SETLOCAL
::========================
::Variable
::========================
set "fileBackupName=taskBackup"
set "fileBackupPath=%PEDRecoveryFolder%"

REM Extract Function variables name
set "fileFuntionName=TaskBackupFunction.ps1"
set "fileFuntionFolder=files"

REM Extract Marks
set "startMark=# StartExtractF1"
set "endMark=# EndExtractF1"
set "callFun=:r5a.x3.1.1.tasksBackupFunction"

::========================
::Function
::========================
set "fileBackupDir=%fileBackupPath%\%fileBackupName%"
set "fileFunctionDir=%destinationPD%\%fileFuntionFolder%\%fileFuntionName%"

echo Please wait...
call :m1a.x01.0.timestamp
echo.
echo Current Time: %timestamp%

REM Creating Function
echo $FilePathDir = "%fileBackupDir%.txt" > %fileFunctionDir%
call %callFun%

REM Starting Function
Powershell.exe Set-ExecutionPolicy Bypass -Scope Process -Force; "%fileFunctionDir%" >nul
del "%fileFunctionDir%" >nul

REM Replace txt with bat executable
type %fileBackupDir%.txt > %fileBackupDir%.bat
del %fileBackupDir%.txt >nul

REM Check if exist Backup
set "fileBackupDir=%fileBackupDir%.bat
if exist "%fileBackupDir%" (
	echo ========== %fileBackupDir% Create Successful ===
) else (
	echo ========== %fileBackupDir% Unsuccessful ---
)

echo.
call :m1a.x01.0.timestamp
echo Current Time: %timestamp%
ENDLOCAL

echo.
cmdmenusel e370 "Press ENTER to go back "
exit /b

:r5a.x3.1.1.tasksBackupFunction
::========================
::Function
::========================

REM Set the filename for the extracted code
set "output_file=%fileFunctionDir%"

REM Find the line number where the code block starts
for /f "delims=:" %%i in ('findstr /n /c:"%startMark%" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "delims=:" %%i in ('findstr /n /c:"%endMark%" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) >> "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"
exit /b

::========================
REM Your code starts here
::========================
# StartExtractF1
# $FilePathDir = "$env:SystemDrive\PED-Recovery\taskBackup.txt"
# Get scheduled tasks
$scheduledTasks = Get-ScheduledTask

# Create a StringBuilder to store formatted output
$outputStringBuilder = [System.Text.StringBuilder]::new()

# Iterate through each task and format the output
foreach ($task in $scheduledTasks) {
    # Determine if the task should be enabled or disabled
    $status = if ($task.State -match "Ready|Queued") { "/Enable" } else { "/Disable" }

    # Combine the TaskPath and TaskName
    $taskFullName = $task.TaskPath + "\" + $task.TaskName

    # Replace any double backslashes with a single backslash
    $formattedTaskPath = $taskFullName.Replace("\\", "\")

    # Format the SCHTASKS command
    $formattedTask = "SCHTASKS /Change /TN ""$($formattedTaskPath)"" $status"
    $outputStringBuilder.AppendLine($formattedTask)
}

# Convert the StringBuilder content to a string and export to a file
$outputString = $outputStringBuilder.ToString()
$outputString | Out-File -FilePath "$FilePathDir"
# EndExtractF1

::END Script
::================================

:r5a.x3.2.servicesBackup
::================================
CLS
SETLOCAL
::========================
::Variable
::========================
set "fileBackupName=servicesBackup"
set "fileBackupPath=%PEDRecoveryFolder%"

REM Extract Function variables name
set "fileFuntionName=ServicesBackupFunction.ps1"
set "fileFuntionFolder=files"

REM Extract Marks
set "startMark=# StartExtractF2"
set "endMark=# EndExtractF2"
set "callFun=:r5a.x3.2.1.servicesBackupFunction"

::========================
::Function
::========================
set "fileBackupDir=%fileBackupPath%\%fileBackupName%"
set "fileFunctionDir=%destinationPD%\%fileFuntionFolder%\%fileFuntionName%"

echo Please wait...
call :m1a.x01.0.timestamp
echo.
echo Current Time: %timestamp%

REM Creating Function
echo $FilePathDir = "%fileBackupDir%.txt" > %fileFunctionDir%
call %callFun%

REM Starting Function
Powershell.exe Set-ExecutionPolicy Bypass -Scope Process -Force; "%fileFunctionDir%" >nul
del "%fileFunctionDir%" >nul

REM Replace txt with bat executable
type %fileBackupDir%.txt > %fileBackupDir%.bat
del %fileBackupDir%.txt

REM Check if exist Backup
set "fileBackupDir=%fileBackupDir%.bat
if exist "%fileBackupDir%" (
	echo ========== %fileBackupDir% Create Successful ===
) else (
	echo ========== %fileBackupDir% Unsuccessful ---
)

echo.
call :m1a.x01.0.timestamp
echo Current Time: %timestamp%
ENDLOCAL

echo.
cmdmenusel e370 "Press ENTER to go back "
exit /b

:r5a.x3.2.1.servicesBackupFunction
::========================
::Function
::========================

REM Set the filename for the extracted code
set "output_file=%fileFunctionDir%"

REM Find the line number where the code block starts
for /f "delims=:" %%i in ('findstr /n /c:"%startMark%" "%~f0"') do set "start_line=%%i"

REM Find the line number where the code block ends
for /f "delims=:" %%i in ('findstr /n /c:"%endMark%" "%~f0"') do set "end_line=%%i"

REM Use the starting and ending lines to extract the desired code
setlocal enabledelayedexpansion
(for /f "tokens=1,* delims=:" %%a in ('findstr /n "^" "%~f0"') do (
    set "line=%%b"
    if %%a geq %start_line% (
        echo(!line!
    )
    if %%a equ %end_line% (
        exit /b
    )
)) >> "%output_file%"

REM Display a message indicating successful extraction
echo The code has been extracted to "%output_file%"
exit /b

::========================
REM Your code starts here
::========================
# StartExtractF2
# $FilePathDir = "$env:SystemDrive\PED-Recovery\servicesBackup.txt"

# Get services
$services = Get-Service

# Create the output directory if it doesn't exist
if (-not (Test-Path -Path $outputDirectory)) {
    New-Item -Path $outputDirectory -ItemType Directory
}

# Create a list to store formatted output
$outputList = @()

# Iterate through each service and format the output for startup settings
foreach ($service in $services) {
    # Determine the desired startup type for each service
    $startupType = switch ($service.StartType) {
        "Automatic" { "auto" }
        "Manual"    { "demand" }
        "Disabled"  { "disabled" }
    }

    # Format the sc command to change the startup type
    $formattedStartup = "sc config $($service.Name) start=$startupType"
    
    # Add service information to the output list
    $outputList += [PSCustomObject]@{
        ServiceName = $service.Name
        StartupType = $startupType
        Command     = $formattedStartup
    }
}

# Sort the output list by StartupType and then by ServiceName
$outputListSorted = $outputList | Sort-Object StartupType, ServiceName

# Create a StringBuilder to store formatted output
$outputStringBuilder = [System.Text.StringBuilder]::new()

# Iterate through the sorted output list and append to the StringBuilder
$outputListSorted | ForEach-Object {
    $outputStringBuilder.AppendLine($_.Command)
}

# Convert the StringBuilder content to a string and export to a file
$outputString = $outputStringBuilder.ToString()
$outputString | Out-File -FilePath "$FilePathDir"

# EndExtractF2

::END Script
::================================

::================================
::configurations 
::services
::schtasks
::
::

::more:
:: history
::1.042.23.07.10
:: new m2a.x01.Oneclick		
		
:notes
::=======================================================================
rem 	m/r		-menu/resources
rem 	0a-9a	-group
rem		x		-step

rem m0a.x first permision menu
rem m1a.x main menu with links
rem m2a.x oneClick menu
rem r3a.x download Resources
rem r4a.x Resources
rem r5a.x create files
rem m9a.x power menu

::=======================================================================
rem History:

REM 1.everyDay-PM-opti-Auto.bat
REM Create 12-04-2022 00:48:06

REM boot.bat
REM Create 19-04-2022 03:00:06

REM steps.1.01.txt
REM Create 15-11-2021 13:52:45
::=======================================================================

rem PED Folder
rem https://drive.google.com/drive/folders/1gOiYbhFK026D9MHRrErm_BhWvAHsRM2z

rem DigiCertUtil
rem https://digicert.com/StaticFiles/DigiCertUtil.zip

::=======================================================================
::Check this create Shortcut
::@echo off
::setlocal
::
:::: Set your desired parameters
::set TargetPath="C:\Path\to\your\Target.exe"  :: Change this to your desired target path
::set ShortcutPath="C:\Path\to\save\Shortcut.lnk" :: Change this to your desired shortcut path
::set IconFile="%SystemRoot%\System32\SHELL32.dll"
::set IconIndex=123  :: Change this to the desired icon index from SHELL32.dll
::
:::: Create the shortcut
::echo [InternetShortcut] > "%ShortcutPath%"
::echo URL=file://%TargetPath% >> "%ShortcutPath%"
::echo IconFile=%IconFile% >> "%ShortcutPath%"
::echo IconIndex=%IconIndex% >> "%ShortcutPath%"
::
::endlocal
::=======================================================================
::=======================================================================
:: iskarva celiq dir plus imeto na faila 
:: %~f0
:: C:\Users\pierm\Desktop\PED-ToolBox.bat
:: 
:: iskarva samo imeto na faila
:: %~nx0
:: PED-ToolBox.bat
:: 
:: imeto na file bez okonchanieto
:: %~n0
:: %%~nk
:: PED-ToolBox

::=======================================================================

::set "destinationDir=C:\ProgramData\PEDToolBox"
::set "destinationFile=%destinationDir%\%~nx0"

::set "desktopShortcut=%userprofile%\Desktop\%~n0.lnk"
	::mklink "%desktopShortcut%" "%destinationFile%"
	
::=======================================================================