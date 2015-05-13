#!/bin/bash

path="/tmp/roms"
zip="pun.zip"
rom="punisher.zip"

if [ ! -f "/usr/games/mame" ]
then
  sudo apt-get install mame -y
fi

mkdir "$path"
cd "$path"

wget -c "https://dl.dropbox.com/s/3owjju70mjv2kda/punrom.zip" -O "$zip"
unzip -o "$zip"

mame "$rom" -rompath "$path"
