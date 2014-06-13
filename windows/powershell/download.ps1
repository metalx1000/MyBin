Write-Output "Downloading File..."

$storageDir = $pwd
$webclient = New-Object System.Net.WebClient
$url = "https://dl.dropbox.com/s/69s8hogh2sxcqrl/miniweb-win32-20130309.zip"
$file = "c:\test\miniweb.zip"
$webclient.DownloadFile($url,$file)

Write-Output "File Downloaded"
