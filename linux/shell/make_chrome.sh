#!/bin/bash

echo "What is the extension's name?"
read name

if [ $name = "" ]
then
  echo "I need a name!!!"
  echo "Good Bye."
  exit 1
else
  dir="$name"
  mkdir "$dir" 
fi

echo "What is the URL that will be accessed?"
read site

if [ $site = "" ]
then
  echo "I need a URL!!!"
  echo "Good Bye."
  exit 1
fi

echo "What is the URL of the icon image?"
read icon

if [ $icon = "" ]
then
  echo "I need a URL!!!"
  echo "Good Bye."
  exit 1
else
  wget "$icon" -O "$dir/icon" 
  icon_size=(256 128 48 16)
  for i in "${icon_size[@]}"
  do
    echo "$i"
    convert -resize $i "$dir/icon" "$dir/icon${i}.png"
  done
fi

echo "Getting jQuery"
wget "http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js" -O "$dir/jquery.js"


cat << EOF > "$dir/manifest.json"
{
   "manifest_version": 2,
   "name": "$name",
   "permissions": [ "$site/*" ],
   "version": "1",
   "web_accessible_resources": [ "html_code.js" ],

   "description": "Description",
   "content_scripts": [ {
      "js": [ "jquery.js", "main.js" ],
      "matches": [ "$site/*" ]
   } ],
   "icons": {
      "128": "icon128.png",
      "16": "icon16.png",
      "48": "icon48.png"
   }
}

EOF

cat << EOM > "$dir/main.js"
var s = document.createElement('script');
// TODO: add "script.js" to web_accessible_resources in manifest.json
s.src = chrome.extension.getURL('html_code.js');
s.onload = function() {
      this.parentNode.removeChild(this);
};
(document.head||document.documentElement).appendChild(s);
\$(document).ready(function(){
  console.log("Script Running");
}); 
EOM

echo "console.log('html JS code running.');" > "$dir/html_code.js"

