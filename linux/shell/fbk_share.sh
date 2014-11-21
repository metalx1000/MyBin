#!/bin/bash
#Share a Random http://filmsbykris.com video 
browser="google-chrome"
info="$(wget "http://filmsbykris.com/site_data/video.lst" -q -O-|shuf|head -n1)"
title="$(echo -n "$info"|cut -d\| -f1|tr '#' '-')"
id="$(echo -n "$info"|cut -d\| -f2)"

echo "$title https://www.youtube.com/watch?v=$id=en"|xclip
echo "$title https://www.youtube.com/watch?v=$id=en"

$browser "https://plus.google.com/share?url=https://www.youtube.com/watch?v=$id=en"
$browser "https://twitter.com/intent/tweet?url=https://www.youtube.com/watch?v=$id&text=$title:&via=YouTube&related=YouTube,YouTubeTrends,YTCreators"
$browser "https://www.blogger.com/blog-this.g?n=$title&source=youtube&b=%3Ciframe+width=%22480%22+height=%22270%22+src=%22https://www.youtube.com/embed/$id%22+frameborder=%220%22+allowfullscreen%3E%3C/iframe%3E&eurl=https://i.ytimg.com/vi/$id/hqdefault.jpg"
#$browser "http://www.reddit.com/submit?url=http%3A%2F%2Fwww.youtube.com%2Fattribution_link%3Fa%3DMBqOP7rBrbo%26u%3D%252Fwatch%253Fv%253D$id%2526feature%253Dshare&title=$title"
$browser "https://www.facebook.com/pages/Films-By-Kris/225113590836253"
