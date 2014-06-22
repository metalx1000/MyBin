#!/system/bin/sh
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

if [ "$1" = "kill" ]
then
    echo "Killing Kiosk"
    pm enable com.android.launcher
    am startservice -n com.android.systemui/.SystemUIService    
else

    #disable launcher (desktop/home screen and menu buttons)
    pm disable com.android.launcher
    
    #kill system tool bar
    busybox killall com.android.systemui && service call activity 79 s16 com.android.systemui
    
    #launch kiosk
    am start -n com.phonegap.www/.MKInventory
fi

