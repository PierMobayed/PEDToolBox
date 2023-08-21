#ver-1.0.2
#21/08/23/04:01
$fileLinkID = "https://t.ly/pedexe"
$nameFile = "PED-ToolBox.bat"
#$filePath = Join-Path -Path $PWD -ChildPath $nameFile
$tempPath = Join-Path -Path $env:TEMP -ChildPath $nameFile

# Download the script
(New-Object System.Net.WebClient).DownloadFile($fileLinkID, $filePath)

# Start the downloaded script
Start-Process -FilePath $filePath

#exit
