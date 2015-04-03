#!/bin/bash

browser="google-chrome"
editor="vim"

if [ "$1" = "" ]
then
  echo "What do you want to call your project?"
  read dir
else
  dir="$1"
fi

echo "Creating Directory for $dir"
mkdir $dir
cd $dir

echo "Getting Package..."
wget "https://github.com/metalx1000/PHP-Image-Uploader/blob/master/ajax_uploader/packaged.zip?raw=true" -O "package.zip"
unzip package.zip
rm package.zip

$browser localhost

