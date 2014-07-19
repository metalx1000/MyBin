#!/bin/bash

iso="openbsd.iso"
img="openbsd.img"

url="http://openbsd.mirrorcatalogs.com/pub/OpenBSD/5.5/i386/cd55.iso"

clear
echo "Getting install ISO..."

#get ISO http://www.openbsd.org/
wget -c "$url" -O $iso 

#create Empty IMG
if [ -a $img ]
then
    echo "$img image already exists"
else
    echo "Creating $img for install..."
    dd bs=512 count=5400000 if=/dev/zero of=$img
fi

#do install in qemu
qemu-system-i386 -boot d -cdrom $iso -hda $img

clear
###############NOTES##########
echo "
NOTES on Package manager for openBSD
http://www.cyberciti.biz/tips/openbsd-add-package-howto.html
http://bsdly.blogspot.com/2013/04/youve-installed-it-now-what-packages.html
# export PKG_PATH=ftp://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`uname -m`/
# pkg_add -v -i links
# pkg_info 

########Update existing package######
# pkg_add -u links

##########update all package######
# pkg_add
"

#run system in qemu
qemu-system-i386 -hda $img
