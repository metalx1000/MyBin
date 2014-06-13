<#
From "http://obscuresecurity.blogspot.com/2014/05/dirty-powershell-webserver.html"
Webserver on port 8000
will serve up a file if you request it by name
example: "http://localhost:8000/index.html"

you will need to change the content type for different files.
example "Content-Type","text/pain"
#>

$Hso = New-Object Net.HttpListener
$Hso.Prefixes.Add("http://+:8000/")
$Hso.Start()
While ($Hso.IsListening) {
    $HC = $Hso.GetContext()
    $HRes = $HC.Response
    $HRes.Headers.Add("Content-Type","text/html")
    $Buf = [Text.Encoding]::UTF8.GetBytes((GC (Join-Path $Pwd ($HC.Request).RawUrl)))
    $HRes.ContentLength64 = $Buf.Length
    $HRes.OutputStream.Write($Buf,0,$Buf.Length)
    $HRes.Close()
}
$Hso.Stop()
