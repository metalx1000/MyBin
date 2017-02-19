<#
Gets and Runs Shadow Warrior in Dosbox
PowerShell -ExecutionPolicy Bypass .\sw.ps1
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
    
    $folder = "sw"
    $storageDir = "$pwd"
    
    if(!(Test-Path -Path $folder )){
        Write-Output "Downloading Shadow Worrior..."
        Start-Sleep -seconds 2
    
        $url = "https://dl.dropbox.com/s/0veq6iq6n6qyujw/shawdo_warrior.zip"
        $file = "$storageDir\sw.zip"
        DownloadFile $url $file 
    
        Write-Output "Unzipping Shadow Warrior..."
        Start-Sleep -seconds 2
        
        $shell = new-object -com shell.application
        $zip = $shell.NameSpace("$file")
    
        foreach($item in $zip.items())
        {
            $shell.Namespace("$storageDir\").copyhere($item)
        }
        Remove-Item $file -Force -Recurse
    }else{
        Write-Output "Shadow Warrior is Already Installed";
        Start-Sleep -seconds 2
    }
    
    

    
    Write-Output "Starting Shadow Warrior!!!"
    
  $mediaPlayer.Stop()
    
    cd $folder
    cmd /c sw.bat
    cd ../
    
    $del = Read-Host 'Do you want to remove Shadow Warrior? (Y/n)'
    
    if(($del -eq "Y" ) -or ( $del -eq "")){
        Write-Output "Removing Game"
        Remove-Item $folder -Force -Recurse
    }
    
    write-output "Thank you for playing"
}

Main
