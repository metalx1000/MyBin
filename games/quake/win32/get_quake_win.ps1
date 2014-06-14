<#
Gets and Runs Quake for Windows
#>
function GetQuake{
    cls
    Write-Output "Creating Directory for Quake..."
    New-Item -ItemType directory -Path Quake
    ###########################get webQuakequake######################
    Write-Output "Downloading Quake for Windows..."
    
    $storageDir = "$pwd"
    $webclient = New-Object System.Net.WebClient
    $url = "https://dl.dropbox.com/s/wtbq73nmtuon56i/wq100.zip"
    $file = "$storageDir\Quake\wq100.zip"
    $webclient.DownloadFile($url,$file)
    
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
    
    $webclient.DownloadFile($url,$file)
    
    Write-Output "Unzipping Quake"
    $shell = new-object -com shell.application
    $zip = $shell.NameSpace("$storageDir\Quake\quake.zip")
    foreach($item in $zip.items())
    {
        $shell.Namespace("$storageDir\Quake\").copyhere($item)
    }
    
    cd Quake
    cmd /c winquake.exe
}
