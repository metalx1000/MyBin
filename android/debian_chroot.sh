#!/system/bin/sh

perm=$(id|busybox cut -b 5)

if [ "$perm" != "0" ]; then
  echo "This Script Needs Root! Type : su"
  exit
fi

folder="/sdcard/ext_sd"
img="${folder}/debian_arm.img"
mount="${folder}/debian"

#make sure mount is created
busybox mkdir -p $mount

echo "loading Debian"

if [ -b /dev/loop2 ]; then
    echo "Loop device exists"
else
    busybox mknod /dev/loop2 b 7 0
fi

mount -o loop=/dev/block/loop2 -t ext4 $img $mount
export bin=/system/bin
export PATH=$bin:/usr/bin:/usr/local/bin:/usr/sbin:/bin:/usr/local/sbin:/usr/games:$PATH
export HOME=/root

cd $mount
busybox mount --bind /dev dev
mount -t devpts devpts dev/pts
mount -t proc proc proc
mount -t sysfs sysfs sys
busybox chroot . /bin/bash
