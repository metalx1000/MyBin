#!/bin/bash
###################################################################### 
#Copyright (C) 2018  Kris Occhipinti
#https://filmsbykris.com

#Detects when headphones are plugged/unplugged into sound card

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

acpi_listen|while read j;
do 
  if [[ $j = *"HEADPHONE plug"* ]];
  then 
    notify-send -t 3000 "Head Phones" "Enabled";
  else 
    notify-send -t 3000 "Head Phones" "Diabled";
  fi;
done
