#!/bin/bash

zip_url="https://dl.dropbox.com/s/0veq6iq6n6qyujw/shawdo_warrior.zip"
folder="$HOME/.sw"
zip_file="$folder/sw.zip"
bat="$folder/go.bat"
dosbox="/usr/bin/dosbox"

if [ ! -f $dosbox ]
then
  echo "Dosbox does not seem to be installed on your system."
  echo "Now attempting to install Dosbox."
  sudo apt-get install dosbox -y
fi

if [ ! -f $bat ]
then
  rm "$zip_file"
  mkdir -p "$folder"
  cd "$folder"
  wget -c "$zip_url" -O "$zip_file"
  unzip "$zip_file"
fi

killall mplayer
dosbox "$bat"
