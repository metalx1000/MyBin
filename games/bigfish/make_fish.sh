#!/bin/bash

echo 'id ICON "res/icon.ico"' > ico.rc
i586-mingw32msvc-windres -o ico.o ico.rc
i586-mingw32msvc-gcc freefish.c ico.o -o bin/freefish.exe
