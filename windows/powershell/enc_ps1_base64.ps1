<#
encodes all ps1 files in a folder
#>

$files = Get-ChildItem -include *.ps1
foreach($file in $files) 
{ 
    $code = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Content $file.fullname |%{$_}|out-string)))
    $bat = "powershell -encodedcommand $code"
    $bat |set-content $file.BaseName,.bat
}
