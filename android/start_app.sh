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


#Start the program on the phone and use ps to get the programs name
busybox ps|busybox awk '{print $4}'

echo "Which Package (example: com.google.android.youtube): "
read package
 
#now check the log file to get the program’s activity name
#find the programs activity name
app=`logcat -d|busybox grep "$package"|busybox grep cmp|busybox head -n1|busybox tr '=' '\n'|busybox grep ^com|busybox cut -d\} -f1|busybox head -n1`

#start program
echo "starting $app"
am start -n $app

#EXAMPLES
#am start -n com.tmobile.vvm.application/.activity.setup.WelcomeActivity
#am start -n org.mozilla.firefox/.App http://google.com
