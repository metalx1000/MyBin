<#
encodes all ps1 files in a folder
#>

$files = Get-ChildItem -path $pwd -filter "*.ps1"

foreach($file in $files) 
{ 
    write-output "Encoding $file"
    $code = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Content $file |%{$_}|out-string)))
    
    $bat = "powershell -encodedcommand $code"
    $base = [io.path]::GetFileNameWithoutExtension("$file")
    $batfile = $base + ".bat"
    $bat |set-content $batfile
}
