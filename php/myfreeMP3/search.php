<?php
$q = $_GET['q'];

print <<< END
    <form action="#" method="get">
        <input type="text" name='q' style="font-size:50px;width:100%">
        <input type="submit" value="Search" style="font-size:50px;width:100%">
    </form>
END;
print "<h1>$q</h1><hr>";

/* gets the data from a URL */
function get_data($url) {
    $ch = curl_init();
    $timeout = 5;
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
    $data = curl_exec($ch);
    curl_close($ch);
    return $data;
}

$q=str_replace(" ","+",$q);

$content = get_data("http://www.myfreemp3.cc/mp3/$q");
$content = explode("<a", $content);
foreach ($content as $item){
    if(strpos($item,'data-aid=') !== false) {
        $id = explode('"', $item);
        $id = $id[3];

        $title = explode('>', $item); 
        $title = $title[1];
        $title = explode('<', $title);
        $title = $title[0];

        print "<a href='http://93.174.93.26/pl.php?q=";
        print $id . "_654c90ed9d_/' style='font-size:50px'>$title</a><br>";
    }
}

?>
