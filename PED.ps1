#ver-1.0.2.5
#24/05/30/14:00
$fileLinkID = "https://raw.githubusercontent.com/PierMobayed/PEDToolBox/main/PED-ToolBox.bat"
#$fileLinkID = "https://rebrand.ly/pedboxbat"
#https://raw.githubusercontent.com/PierMobayed/PEDToolBox/main/PED-ToolBox.bat
$nameFile = "PED-ToolBox.bat"
#$filePath = Join-Path -Path $PWD -ChildPath $nameFile
$filePath = Join-Path -Path $env:TEMP -ChildPath $nameFile

# Download the script
(New-Object System.Net.WebClient).DownloadFile($fileLinkID, $filePath)

# Start the downloaded script
Start-Process -FilePath $filePath

#exit

#Notes.
#web link:
#https://raw.githubusercontent.com/PierMobayed/PEDToolBox/main/PED.ps1
#https://rebrand.ly/pedbox

#powershell link:
#irm https://raw.githubusercontent.com/PierMobayed/PEDToolBox/main/ped.ps1 | iex
#iex(irm rebrand.ly/pedbox)
