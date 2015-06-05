<#
Check Deskop Wallpaper
PowerShell -ExecutionPolicy Bypass .\wallpaper.ps1
#>

$url="http://69.65.44.235/images/wallpapers/biggunpunisher-9625.jpeg"
$file = "paper.jpg"

function Set-WallPaper(){
 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $file
 rundll32.exe user32.dll, UpdatePerUserSystemParameters
 
 #Remove-Item $file
}

function Get-WallPaper(){
    Write-Output "Downloading Wallpaper to $file..."

    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($url,$file)
    Write-Output "File Downloaded"
    
    Set-WallPaper
}


Get-WallPaper
