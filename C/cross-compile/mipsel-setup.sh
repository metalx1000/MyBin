#!/bin/sh

arch="mipsel"
static="/usr/bin/qemu-$arch-static"
native="native-compiler-$arch"
rootfs="root-filesystem-$arch"
url="http://www.landley.net/code/aboriginal/downloads/binaries/root-filesystem/"

if [ ! -f "$static" ]
then
  sudo apt-get install qemu-user-static
fi

mkdir "$arch"
cd "$arch"

echo "Getting ${url}${native}.tar.gz"
wget -c "${url}${native}.tar.gz"
echo "Getting ${url}${rootfs}.tar.gz"
wget -c "${url}${rootfs}.tar.gz"

tar xvzf ${native}.tar.gz
tar xvzf ${rootfs}.tar.gz

cd "$rootfs"
sudo cp -r ../${native}/* ./
#rm ../${native}* -fr
#rm ../${rootfs}.tar.gz

cp "$static" bin

cat << EOF > hello.c
#include<stdio.h>

main()
{   
    printf("Hello World\n");

}
EOF

echo "Entering mipsel chroot environment..."
echo "Run the following to test compiler:"
echo "gcc -static hello.c -o hello"
sudo chroot . sh

