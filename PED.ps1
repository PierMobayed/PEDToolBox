#ver-1.0.2.3
#06/11/23/16:28
$fileLinkID = "https://bit.ly/pedbox"
$nameFile = "PED-ToolBox.bat"
#$filePath = Join-Path -Path $PWD -ChildPath $nameFile
$filePath = Join-Path -Path $env:TEMP -ChildPath $nameFile

# Download the script
(New-Object System.Net.WebClient).DownloadFile($fileLinkID, $filePath)

# Start the downloaded script
Start-Process -FilePath $filePath

#exit
