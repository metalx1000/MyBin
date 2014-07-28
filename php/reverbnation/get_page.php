<?php
$rev_url=$_GET['rev_url'];

if($rev_url == ""){
    header( 'Location: index.php' ) ;
}

$rev_url="http://www.reverbnation.com/$rev_url";
/* gets the data from a URL */
function get_data($url) {
    $ch = curl_init();
    $timeout = 15;
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
    $data = curl_exec($ch);
    curl_close($ch);
    return $data;
}

$page=get_data($rev_url);
$page=explode("\n", $page);


foreach ($page as $line) {
        $pos = strpos($line,"page_object_photos");
        if ($pos == true) {
            $artist=explode("/", $line);
            $artist=explode("?", $artist[3]);
            $artist="$artist[0]";
            break;
        }
}

foreach ($page as $line) {
        $pos = strpos($line,"artist_song_row_");
        if ($pos == true) {
            $song=explode("_", $line);
            $song=explode("\"", $song[3]);
            $song="$song[0]";
            $url="http://www.reverbnation.com/audio_player/add_to_beginning/$song?from_page_object=$artist";

            $page=get_data($url);
            $page=explode("\"", $page);

            foreach ($page as $line) {
                    $pos = strpos($line,"audio_player");
                    $noid = strpos($line,"song.id");
                    if ($pos == true && $noid != true) {
                        echo "<a href='$line'>$line</a><br>";
                        break;
                    }
            }
        }
}

?>
