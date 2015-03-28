#!/bin/bash

wad_dir="/usr/share/games/doom"
doom_path="/usr/games/prboom"
doom="prboom"
wad_urls=(\
'https://dl.dropbox.com/s/dexn9tm0k5wsny5/doom.wad?dl=0' \
'https://dl.dropbox.com/s/2eqyfd1h9j0fq8i/doom2.wad?dl=0' \
'https://dl.dropbox.com/s/a035a6pfyjpb3fv/plutonia.wad?dl=0' \
'https://dl.dropbox.com/s/ukoj6bqfbsldhgo/tnt.wad?dl=0' \
'https://dl.dropbox.com/s/w3diao08tuxo9kp/prboom.wad?dl=0' \
)
function logo(){
cat << "EOF"
=================     ===============     ===============   ========  ========
\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
||   .=='    _-'          `-__\._-'         `-_./__-'         `' |. /|  |   ||
||.=='    _-'                                                     `' |  /==.||
=='    _-'                                                            \/   `==
\   _-'                                                                `-_   /
 `''                                                                      ``'
EOF
}

logo

if [ ! -f $doom_path ]
then
  echo "Doom does not seem to be installed on your system."
  echo "Now attempting to install Doom."
  sudo apt-get install $doom -y && echo "Doom installed"||exit 1
fi

echo "Downloading WAD files..."
echo "Password maybe required for write permissions."
for i in "${wad_urls[@]}"
do
  file="$(basename "$i"|cut -d\? -f1)"
  output="$wad_dir/$file"
  if [ ! -f "$output" ]
  then
    sudo wget -c "$i" -O "$output"
  else
    echo "$output Already Exists"
  fi
done

clear
echo "Starting Random Doom Game..."
#files=($wad_dir/*)
#random_wad="$(printf "%s\n" "${files[RANDOM % ${#files[@]}]}"|head -n1)"
#$doom -iwad $random_wad
doom
