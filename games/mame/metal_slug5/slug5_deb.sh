#!/bin/bash

path="/tmp/roms"
zip="slug5.zip"
rom="mslug5.zip"

if [ ! -f "/usr/games/mame" ]
then
  sudo apt-get install mame -y
fi

mkdir "$path"
cd "$path"

wget -c "https://dl.dropbox.com/s/ibyg9cwt9ad7qm3/metalslug5.zip?dl=0" -O "$zip"
unzip -o "$zip"

mame "$rom" -rompath "$path"
