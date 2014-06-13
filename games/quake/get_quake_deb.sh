#!/bin/bash
#Installs Quake

clear

if [ "$(id -u)" != "0" ]; then
    echo "Sorry, you are not root or sudo."
    echo "Restarting as sudo."
    sleep 3
    
    sudo $0
    exit 1
fi

echo "Warning, please be sure own a copy of quake when using this script"
echo -n "do you want to continue? (Y/n):"
read go

if [ "$go" = "y" ] || [ "$go" = "Y" ] || [ "$go" = "" ]
then
  cd /tmp
  mkdir quake
  cd quake
  
  wget -c "https://dl.dropbox.com/s/yu3ceyo42ny5h49/quake.zip" -O quake.zip &&
  unzip quake.zip &&
  cd id1 &&
  mkdir -p /usr/share/games/quake/id1/ &&
  cp *.pak /usr/share/games/quake/id1/
  
  apt-get install quake
  
  echo "======================================"
  echo "Please run the command 'quake' to play"
  echo "======================================"
  sleep 3
fi

echo "Would you like to install the"
echo "X-Men: The Ravages of Apocalypse"
echo "A total Quake convertion?"
echo "--you must install quake first--"
read xmen

if [ "$xmen" = "y" ] || [ "$xmen" = "Y" ] || [ "$xmen" = "" ]
then
    wget -c "https://dl.dropbox.com/s/cfk0f5pnfrmyqtr/xmen_quake.zip" -O "/tmp/xmen_quake.zip" &&
    unzip "/tmp/xmen_quake.zip" -d /usr/share/games/quake/
    echo "cd /usr/share/games/quake" > /usr/bin/xmenq &&
    echo "quakespasm -game xmen" >> /usr/bin/xmenq &&
    chmod +x /usr/bin/xmenq

    echo "======================================="
    echo "To run Xmen Mod run the command 'xmenq'"    
    echo "======================================="
    sleep 3 
fi

echo "Good Bye."
