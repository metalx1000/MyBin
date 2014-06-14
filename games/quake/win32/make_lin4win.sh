#!/bin/bash

i586-mingw32msvc-windres -o ico.o quake.rc
i586-mingw32msvc-gcc get_quake.c ico.o -o bin/get_quake_win.exe
