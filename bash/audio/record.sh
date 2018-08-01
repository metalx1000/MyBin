#!/bin/bash
###################################################################### 
#Copyright (C) 2018  Kris Occhipinti
#https://filmsbykris.com

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.
###################################################################### 

tmp="/tmp/rec.wav"

function main(){
  recorder
  sleep 1
  while [ 1 ];do menu;done
}

function clean(){
  rm "$tmp"
  clear
}

function recorder(){
  arecord -vv -fdat "$tmp" &
  pid=$!
  read
  kill $pid
  clear
}

function menu(){
  OPTION=$(whiptail --title "Play Back Options" --menu "Choose your option" 15 60 4 \
    "1" "Play" \
    "2" "Echo" \
    "3" "Chorus" \
    "4" "Reverse"  3>&1 1>&2 2>&3)

  exitstatus=$?
  if [ $exitstatus = 0 ]; then
    play_wav $OPTION
  else
    echo "You chose Cancel."
    exit 0
  fi
}

function play_wav(){
  if [ "$1" = "1" ]
  then
    play "$tmp"
  elif [ "$1" = "2" ]
  then
    play "$tmp" echos 0.4 1 500.0 0.25 1000.0 0.3 
  elif [ "$1" = "3" ]
  then
    play "$tmp" chorus 0.6 0.9 50.0 0.4 0.25 2.0 -t 60.0 0.32 0.4 1.3 -s
  elif [ "$1" = "4" ]
  then
    play "$tmp" reverse 
  fi
}


main
