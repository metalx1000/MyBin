#!/bin/bash

path="/tmp/roms"
zip="pcm.zip"
rom="pacman.zip"
url="https://dl.dropbox.com/s/83iksnd2ocmsgqk/pcm.zip?dl=0"
if [ ! -f "/usr/games/mame" ]
then
  sudo apt-get install mame -y
fi

mkdir "$path"
cd "$path"

wget -c "$url" -O "$zip"
unzip -o "$zip"

mame "$rom" -rompath "$path"
