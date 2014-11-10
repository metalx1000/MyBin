<#
Creates new icon for Windows Taskbar - pins program to taskbar
PowerShell -ExecutionPolicy Bypass .\note_icon.ps1
#>

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Windows')    
$item = $folder.Parsename('notepad.exe')
$item.invokeverb('taskbarpin')
