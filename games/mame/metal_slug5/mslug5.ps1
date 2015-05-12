<#
Gets and Runs Metal Slug 5 MAME ROM
PowerShell -ExecutionPolicy Bypass .\mslug5.ps1
#>
function Main(){
    Add-Type -AssemblyName presentationCore 
    $url = "https://dl.dropbox.com/s/5jcka430xcbgo1i/mslug5.zip"
    $mediaPlayer = New-Object system.windows.media.mediaplayer
    $music = "http://216.227.134.162/ost/metal-slug/rxgakwrpvq/03-stage-2.mp3"
    $mediaPlayer.open($music) 
    $mediaPlayer.Play() 
    
    $msg="Get Ready to Sling Some Lead!!!"
    $folder = "mslug5"
    $storageDir = "$pwd"
    $zipfile = "mslug5.zip"
    
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
    
           Write-Progress -activity "Downloading file '$($url.split('/') | Select -Last 1)'" -status "Downloaded ($([System.Math]::Floor

($downloadedBytes/1024))K of $($totalLength)K): " -PercentComplete ((([System.Math]::Floor($downloadedBytes/1024)) / $totalLength)  * 100)
    
       }
    
       #Write-Progress -activity "Finished downloading file '$($url.split('/') | Select -Last 1)'"
    
       $targetStream.Flush()
    
       $targetStream.Close()
    
       $targetStream.Dispose()
    
       $responseStream.Dispose()
    
    }
    
    cls
    Write-Output "$msg"
    
    
    if(!(Test-Path -Path $folder )){
        Write-Output "Downloading Emulator for Windows..."

        $file = "$storageDir\$zipfile"
        DownloadFile $url $file 
    
        Write-Output "Unzipping Emulator for Windows"
        
        $shell = new-object -com shell.application
        $zip = $shell.NameSpace("$file")
    
        foreach($item in $zip.items())
        {
            $shell.Namespace("$storageDir\").copyhere($item)
        }
        Remove-Item $file -Force -Recurse
    }else{
        Write-Output "Emulator Already Installed";
        Start-Sleep -seconds 2
    }
    
    


    $file = "$zipfile"
    $rom = "$folder\roms\$file"
    
    Write-Output "Starting Game!!!"
    
    $mediaPlayer.Stop()

    write-output $pwd\$folder
    cd $pwd\$folder
    cmd /c mame $rom
    cd $storageDir
    
    $del = Read-Host 'Do you want to remove the emulator and roms? (Y/n)'
    
    if(($del -eq "Y" ) -or ( $del -eq "")){
        Write-Output "Removing Emulator and ROMS"
        Remove-Item $folder -Force -Recurse
    }
    
    write-output "Thank you for playing"
}

Main
