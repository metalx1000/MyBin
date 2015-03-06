#!/bin/bash


if [ ! -f "/usr/games/mame" ]
then
  sudo apt-get install mame -y
fi

cd /tmp
wget -c "https://dl.dropbox.com/s/wbbl6mz0t7extjp/mvsc.zip?dl=0" -O rom.zip
unzip -o rom.zip

mame /rom/mvsc.zip -rompath ./rom
