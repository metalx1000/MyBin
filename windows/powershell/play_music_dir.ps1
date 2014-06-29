Add-Type -AssemblyName presentationCore 
$mediaPlayer = New-Object system.windows.media.mediaplayer 
$path = "c:\mu\" 
$files = Get-ChildItem -path $path -include *.mp3,*.wma -recurse 
foreach($file in $files) 
{ 
 "Playing $($file.BaseName)" 
 $mediaPlayer.open([uri]"$($file.fullname)") 
 $mediaPlayer.Play() 
 Start-Sleep -seconds 2 # need to wait for mediaPlayer to determine file duration
 Start-Sleep -seconds $mediaPlayer.NaturalDuration.TimeSpan.TotalSeconds
 $mediaPlayer.Stop() 
}
