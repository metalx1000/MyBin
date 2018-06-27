#!/usr/bin/env python

# Copyright Kris Occhipinti
# June 27th 2018
# https://filmsbykris.com
# Licensed under the GPLv3
# https://www.gnu.org/licenses/gpl-3.0.txt
#    
# Allows normal HID Keyboard like device to be read in background
# Install needed files
# sudo apt install xinput python-evdev
# 
# Disable device as HID in Xorg (Sycreader in my exmaple)
# xinput --disable "$(xinput|grep "Sycreader RFID Technology"|cut -d\= -f2|awk '{print $1}')"
#
# You will probably want to make the device readable rather then run this script as root
# sudo chmod +r /dev/input/by-id/usb-Sycreader_RFID_Technology_Co.__Ltd_SYC_ID_IC_USB_Reader_08FF20140315-event-kbd
# (again Sycreader_RFID is my device change to your device

import os
from evdev import InputDevice, categorize, ecodes

output = "" 

#set your device
dev = "/dev/input/by-id/usb-Sycreader_RFID_Technology_Co.__Ltd_SYC_ID_IC_USB_Reader_08FF20140315-event-kbd"
device = InputDevice(dev) # my keyboard
       
#check list of codes and run command if cound
def find_command(code):
    for line in open("codes.lst"):
        if code in line:
            command = line.split("|")[1].rstrip("\n\r") + " &"
            print(command)
            os.system(command)

#main loop
for event in device.read_loop():
    if event.type == ecodes.EV_KEY & event.value == 1:
        #print(categorize(event))
        # 28 is enter key.
        #so when "Enter" is pressed
        if event.code == 28:
            print(output)
            find_command(output)
#            if output == "2267233788":
#                os.system("/usr/games/minetest &")
            #clear Variable
            output = ""
        else:
            #if "Enter" is not pressed add last value to string
            output += str(event.code)

