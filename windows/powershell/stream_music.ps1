<#
PowerShell -ExecutionPolicy Bypass <script.ps1> -musicFile <file/url>
#>

Add-Type -AssemblyName presentationCore 
$mediaPlayer = New-Object system.windows.media.mediaplayer 

 param (
    [string]$musicFile = "http://static.echonest.com/audio2/1353978910554/06%20What%20If%20We%20Could%20.mp3"
 )


$mediaPlayer.open($musicFile) 
$mediaPlayer.Play() 
Start-Sleep -seconds 2 # need to wait for mediaPlayer to determine file duration
Start-Sleep -seconds $mediaPlayer.NaturalDuration.TimeSpan.TotalSeconds
$mediaPlayer.Stop()
