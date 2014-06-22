#Creates direct links to Big Fish Games

function FreeFish(){
    write-host "Searching for Games..."
    #get directories
    $folders = Get-ChildItem -Path "c:\program files" -recurse -include *.bfg| select Directory
    
    #remove duplicates
    $folders = $folders|sort-object | Get-Unique -AsString
    
    foreach($folder in $folders){
        $f = $folder.Directory.FullName
        $file = Get-ChildItem $f -force| Where-Object {$_.mode -match "h"}
        
        write-host "Creating desktop shortcut for $file"
    
        #create desktop shortcut
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("$Home\Desktop\$file.lnk")
        $Shortcut.TargetPath = "$f\$file"
        $Shortcut.WorkingDirectory = "$f\"
        $Shortcut.Save()
    
    }
}   
