<#
    Not Really WGET
    This is my own powershell for basic file downloading.

    Script By Kris Occhipinti
    http://filmsbykris.com
    June 6th 2014
    GPLv3
    http://www.gnu.org/licenses/gpl.txt
#>

function WGET($url){
    $base = [io.path]::GetFileNameWithoutExtension("$url")
    $file = [io.path]::GetFileName("$url")
    Write-Output "Downloading $URL ..."
    
    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($url,$file)
    
    Write-Output "File Downloaded"
}

WGET("$args")
