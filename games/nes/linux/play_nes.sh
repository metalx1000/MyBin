#!/bin/bash

if [ "$1" = "list" ]
then
    echo "Getting list of Roms..."
    echo "This could take some time."

    for i in {A..Z};do
        #echo "Adding http://www.freeroms.com/nes_roms_$i.htm";
        page="http://www.freeroms.com/nes_roms_$i.htm";
        url="$(wget -q "$page" -O-|sed 's/href="/\n/g'|grep '/nes/'|cut -d\" -f1)"
        echo "$url"|while read line
        do
            #echo "$line"
            #wget -q "$line" -O-|grep zip|head -n1|cut -d\" -f2,4|sed 's/"//g'
            data="$(wget -q "$line" -O-|grep zip|head -n1)"
            address="$(echo $data|cut -d\" -f2)"
            file1="$(echo $data|cut -d\" -f4)"
            file2="$(echo $data|cut -d\" -f6)"

            if [[ $file1 == *.zip ]]
            then
                zip="${address}${file1}"
            else
                zip="${address}${file2}"
            fi
            
            echo "$zip"
            echo "$zip" >> rom.lst
        done
    done

    echo "Sorting ROM list..."
    sort -u rom.lst -o rom.lst
    
    echo "ROM list complete."
    exit
fi

if [ -f "/usr/games/fceux" ];
then
   echo "Emulator is installed."
else
   echo "Installing Emulator."
   sudo aptitude install fceu
fi

if [ "$1" = "local" ]
then
    rm /tmp/rom.zip
    clear
    echo "Getting Random Game..."
    wget "$(sort -R rom.lst|head -n1)" -O /tmp/rom.zip && fceux /tmp/rom.zip
    rm /tmp/rom.zip
else
    rm /tmp/rom.zip
    clear
    echo "Getting Game List..."
    url="$(wget -q "http://tinyurl.com/n4pgleb" -O- | sort -R|head -n1)"
    echo "Getting Random Game..."
    wget "$url" -O /tmp/rom.zip && fceux /tmp/rom.zip
    rm /tmp/rom.zip
fi

echo "Thanks for playing!!!"
echo "Good Bye!!!"
