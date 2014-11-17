$ie = New-Object -ComObject InternetExplorer.Application #background process
#$ie.Visible = $true #to make it visible
$ie.Navigate("http://google.com")
$html = $ie.Document.Body.InnerText
$ie.Quit()
Remove-Variable $ie
