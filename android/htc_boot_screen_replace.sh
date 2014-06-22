#!/bin/bash
#    !!!Designed for HTC Amaze!!!
#    !!!to be run from your desktop hooked to device!!!
# Copyright 2014 Kris Occhipinti  <http://filmsbykris.com>.
# 
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation version 3.
# 
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this software; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
# 
# http://www.gnu.org/licenses/gpl-3.0.txt


dir="aniboot_$(date +%s)"
phone_dir="/system/customize/resource/"
zip="TMOUS_bootanimation.zip"
clear

echo "Backup is recommended!"
sleep 2
mkdir "$dir"
cd "$dir"

#pull original animation from phone
adb pull $phone_dir$zip
unzip "$zip"
clear

rm "$zip"

echo "When Ready Press Enter to Repackage and Put Onto Phone."
echo "'q' and enter to quit"
read go

if [ "$go" == "q" ]
then
    exit 0
fi

zip -0 "$zip" desc.txt TMOUS/* android/*

echo "putting zip file onto phone..."
adb push "$zip" /sdcard/

echo "Remounting /system as read/write"
adb shell su -c "mount -o remount,rw -t yaffs2 /dev/block/mmcblk0p29 /system"
echo "Moving $zip tp $phone_dir..."
adb shell su -c "cp /sdcard/$zip $phone_dir$zip"
echo "Changing Permissions of $zip"
adb shell su -c "chmod 644 $phone_dir$zip"

echo "Would you like to reboot the phone? (y/N)"
read reboot

if [ "$reboot" == "y" ]
then
    echo "Phone is Rebooting..."
    adb shell su -c "reboot"
    sleep 3
fi

echo "Thank you."
sleep 3
echo "Goodbye."



