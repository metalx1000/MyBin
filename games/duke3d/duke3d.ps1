<#
Gets and Runs Duke Nuke 3D in Dosbox
PowerShell -ExecutionPolicy Bypass .\duke3d.ps1
#>
function Main(){
    Add-Type -AssemblyName presentationCore 
    $mediaPlayer = New-Object system.windows.media.mediaplayer
    $music = "http://s.myfreemp3.biz/p.php?q=14213921_70701238_fcd48a9f10_/"
    $mediaPlayer.open($music) 
    $mediaPlayer.Play() 
    
    
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
    Write-Output "Welcome!!!"
    Start-Sleep -seconds 2
    
    $folder = "duke3d"
    $storageDir = "$pwd"
    
    if(!(Test-Path -Path $folder )){
        Write-Output "Downloading Duke Nukem 3d..."
        Start-Sleep -seconds 2
    
        $url = "https://dl.dropbox.com/s/cieku4bthq2mqu6/duke3d.zip?dl=0"
        $file = "$storageDir\duke3d.zip"
        DownloadFile $url $file 
    
        Write-Output "Unzipping Duke Nukem 3D..."
        Start-Sleep -seconds 2
        
        $shell = new-object -com shell.application
        $zip = $shell.NameSpace("$file")
    
        foreach($item in $zip.items())
        {
            $shell.Namespace("$storageDir\").copyhere($item)
        }
        Remove-Item $file -Force -Recurse
    }else{
        Write-Output "Duke is Already Installed";
        Start-Sleep -seconds 2
    }
    
    

    
    Write-Output "Starting Duke 3D!!!"
    
  $mediaPlayer.Stop()
    
    cd $folder
    cmd /c duke.bat
    cd ../
    
    $del = Read-Host 'Do you want to remove the Duke Nukem 3D? (Y/n)'
    
    if(($del -eq "Y" ) -or ( $del -eq "")){
        Write-Output "Removing Duke Nukem"
        Remove-Item $folder -Force -Recurse
    }
    
    write-output "Thank you for playing"
}

Main
