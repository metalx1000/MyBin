sudo aptitude install nasm

nasm boot.asm -f bin -o boot.bin
dd if=boot.bin bs=512 of=boot.img
qemu -fda boot.img
#qemu-system-x86_64 -fda boot.img
