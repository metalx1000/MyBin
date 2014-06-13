<#
Get's the base file name of a file
#>
$url = "http://test.com/folder/file.png"
Write-Host "The URL is $url"
$base = [io.path]::GetFileNameWithoutExtension("$url")
Write-Host "The Base File Name is $base"
$file = [io.path]::GetFileName("$url")
Write-Host "The File Names is $file"
