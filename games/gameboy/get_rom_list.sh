#!/bin/bash

clear

dots(){
  x="0"
  while [ "$x" = "0" ]
  do
    sleep 1
    echo -n "."
  done
}
 
echo -n "Getting URLs of ROM pages."
dots&

for i in {A..Z};
do 
  wget -O- -q "http://www.freeroms.com/gameboy_color_roms_$i.htm"|\
  grep "game_id.value"|\
  sed 's/http/\nhttp/g'|\
  grep "^http"|\
  cut -d\" -f1|\
  grep htm
done > page.lst

echo ""
echo "Creating ROM list."
echo "This will take a while."
cat page.lst|while read line;do 
  wget "$line" -O- -q|\
  grep ".zip"|\
  grep "product_download_url"|\
  sed 's/http/\nhttp/g'|\
  grep "download.f"|\
  cut -d\" -f1;
done > rom.lst

x="1"
echo "ROM list complete!"
