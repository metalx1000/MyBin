#!/bin/bash

zip="/tmp/rom_sf2.zip"
dir="/tmp/sf2"
rom="${dir}/ssf2t.zip"

mkdir -p "$dir"

if [ ! -f "/usr/games/mame" ]
then
  sudo apt-get install mame -y
fi

wget -c "https://dl.dropbox.com/s/d1n98wb8p5gpj1w/sf2.zip?dl=0" -O "$zip"
unzip -o "$zip" -d "$dir"
rm "$zip"

mame "$rom" -rompath "$dir"
