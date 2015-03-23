#!/bin/bash

music="http://s.myfreemp3.biz/p.php?q=14213921_70701238_fcd48a9f10_/"
voice1="http://www.soundboard.com/mediafiles/mj/MjcyMjExMTAzMjcyMjQ1_i05IZmuT0TQ.mp3"
zip_url="https://dl.dropbox.com/s/ttczgxr10wb00my/duke3d.zip?dl=0"
folder="$HOME/.duke3d"
zip_file="$folder/duke3d.zip"
bat="$folder/go.bat"
dosbox="/usr/bin/dosbox"

mplayer "$music" 2> /dev/null &
mplayer "$voice1" 2> /dev/null &

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
