$Browser = New-Object -COM "InternetExplorer.Application"
$URL = "http://filmsbykris.com/v6/index.php"

$Browser.Navigate($URL)
While ($Browser.ReadyState -ne 4) { Start-Sleep -Seconds 1 }

$Divs = $Browser.Document.getElementsByTagName("DIV")

ForEach ($Div in $Divs)
{
	$DivText = $Div.InnerHTML.ToString()
	write-output $DivText
}
