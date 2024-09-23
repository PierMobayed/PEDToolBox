#ver-1.0.2.6
#24/09/23/12:45
$fileLinkID = "https://raw.githubusercontent.com/PierMobayed/PEDToolBox/main/PED-ToolBox.bat"
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

#powershell link:
#irm https://raw.githubusercontent.com/PierMobayed/PEDToolBox/main/ped.ps1 | iex
#iex(irm ped.run)
#irm ped.run | iex
