<!DOCTYPE html>
<html lang="en">
<head>
  <title>Comics</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container-fluid">
  <h1>Issues!</h1>
  <div class="row">
<?php
  $directory = './';
  $files = array_diff(scandir($directory), array('..', '.','.jpg'));
  foreach ($files as $file) {
    if(is_dir($file)){
      print "<a href='$file'>\n";
      print "<div class='col-sm-2' style='height:225px'>\n";
      print "<div style='background-image:url(\"$file.jpg\"); background-size: cover; background-position: 50%; height:200px;'></div>\n";
      print "<div>$file</div>\n";
      print "</div></a>\n";
    }
  }  
?>
      
  </div>
</div>

</body>
</html>
