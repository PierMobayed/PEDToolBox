#ver-1.0.2.4
#24/02/15/11:05
$fileLinkID = "https://rebrand.ly/pedboxbat"
#https://raw.githubusercontent.com/PierMobayed/PEDToolBox/main/PED-ToolBox.bat
$nameFile = "PED-ToolBox.bat"
#$filePath = Join-Path -Path $PWD -ChildPath $nameFile
$filePath = Join-Path -Path $env:TEMP -ChildPath $nameFile

# Download the script
(New-Object System.Net.WebClient).DownloadFile($fileLinkID, $filePath)

# Start the downloaded script
Start-Process -FilePath $filePath

#exit

#https://raw.githubusercontent.com/PierMobayed/PEDToolBox/main/PED.ps1
#irm https://raw.githubusercontent.com/PierMobayed/PEDToolBox/main/ped.ps1 | iex
#https://rebrand.ly/pedbox

#iex(irm rebrand.ly/pedbox)
