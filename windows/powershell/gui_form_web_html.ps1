<#
Basic Web Browser in PowerShell
you need to start power shell like this:
PowerShell -ExecutionPolicy Bypass -STA
#>

$URL = "http://www.filmsbykris.com"	

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

$Form = New-Object System.Windows.Forms.Form
$Form.FormBorderStyle = "None" 
$Form.Text = "www.FilmsByKris.com"
$Form.Size = New-Object System.Drawing.Size(800,600) 
$Form.StartPosition = "CenterScreen"

#$Form.AutoSize = $True
#$Form.AutoSizeMode = "GrowAndShrink"


# Main Browser
$webBrowser = New-Object System.Windows.Forms.WebBrowser
$webBrowser.IsWebBrowserContextMenuEnabled = $true
$webBrowser.ScrollBarsEnabled = $false
$webBrowser.URL = $URL
$webBrowser.Width = 800
$webBrowser.Height = 600
$webBrowser.Location = "0, 0"
$webBrowser.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor 
	[System.Windows.Forms.AnchorStyles]::Right -bor 
	[System.Windows.Forms.AnchorStyles]::Top -bor 
	[System.Windows.Forms.AnchorStyles]::Left 
$Form.Controls.Add($webBrowser)

# Display Form
[void] $Form.ShowDialog()
