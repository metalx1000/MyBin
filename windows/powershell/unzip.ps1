cls
$dir = "$pwd\tmp"
$file = "c:\test.zip"

Write-Output "Creating Directory to Unzip to..."
New-Item -ItemType directory -Path $dir

Write-Output "Unzipping $file to $dir..."
$shell = new-object -com shell.application
$zip = $shell.NameSpace("$file")


foreach($item in $zip.items())
{
    $shell.Namespace("$dir").copyhere($item)
}
