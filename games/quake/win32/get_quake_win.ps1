<#
Gets and Runs Quake for Windows
#>



function DownloadFile($url, $targetFile)

{

   $uri = New-Object "System.Uri" "$url"

   $request = [System.Net.HttpWebRequest]::Create($uri)

   $request.set_Timeout(15000) #15 second timeout

   $response = $request.GetResponse()

   $totalLength = [System.Math]::Floor($response.get_ContentLength()/1024)

   $responseStream = $response.GetResponseStream()

   $targetStream = New-Object -TypeName System.IO.FileStream -ArgumentList $targetFile, Create

   $buffer = new-object byte[] 10KB

   $count = $responseStream.Read($buffer,0,$buffer.length)

   $downloadedBytes = $count

   while ($count -gt 0)

   {

       $targetStream.Write($buffer, 0, $count)

       $count = $responseStream.Read($buffer,0,$buffer.length)

       $downloadedBytes = $downloadedBytes + $count

       Write-Progress -activity "Downloading file '$($url.split('/') | Select -Last 1)'" -status "Downloaded ($([System.Math]::Floor($downloadedBytes/1024))K of $($totalLength)K): " -PercentComplete ((([System.Math]::Floor($downloadedBytes/1024)) / $totalLength)  * 100)

   }

   #Write-Progress -activity "Finished downloading file '$($url.split('/') | Select -Last 1)'"

   $targetStream.Flush()

   $targetStream.Close()

   $targetStream.Dispose()

   $responseStream.Dispose()

}

cls
Write-Output "Creating Directory for Quake..."
New-Item -ItemType directory -Path Quake
###########################get webQuakequake######################
Write-Output "Downloading Quake for Windows..."

$storageDir = "$pwd"

$url = "https://dl.dropbox.com/s/wtbq73nmtuon56i/wq100.zip"
$file = "$storageDir\Quake\wq100.zip"
DownloadFile $url $file 

Write-Output "Unzipping Quake for Windows"
$shell = new-object -com shell.application
$zip = $shell.NameSpace("$storageDir\Quake\wq100.zip")

foreach($item in $zip.items())
{
	$shell.Namespace("$storageDir\Quake\").copyhere($item)
}


###########################get quake######################
Write-Output "Downloading Quake Files..."

$webclient = New-Object System.Net.WebClient
$url = "https://dl.dropbox.com/s/yu3ceyo42ny5h49/quake.zip"
$file = "$storageDir\Quake\quake.zip"

DownloadFile $url $file

Write-Output "Unzipping Quake"
$shell = new-object -com shell.application
$zip = $shell.NameSpace("$storageDir\Quake\quake.zip")
foreach($item in $zip.items())
{
	$shell.Namespace("$storageDir\Quake\").copyhere($item)
}

Write-Output "Starting Quake"
cd Quake
cmd /c winquake.exe
Write-Output "Exiting Quake"
