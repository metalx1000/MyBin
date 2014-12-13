<?php
$source = "http://filmsbykris.com/site_data/video.lst";
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $source);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
$data = curl_exec ($ch);
$error = curl_error($ch); 
curl_close ($ch);

//print $data;

$destination = "./video.lst";
$file = fopen($destination, "w");
fputs($file, $data);
fclose($file);
?>
