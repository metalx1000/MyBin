<?php
$log=$_POST['log'];
$myfile = fopen("log.txt", "a") or die("Unable to open file!");
fwrite($myfile, $log);
fwrite($myfile, "\n");
fclose($myfile);
?>
