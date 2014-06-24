#!/bin/bash

if [ "$2" == "" ];
then
    echo "Useage: $0 '<img>' '<project folder>'"
    echo "example: $0 'icon.png' 'hello_world'"
    exit 1
fi

convert "$1" -resize 72x72 "$2/res/drawable-hdpi/ic_launcher.png"
convert "$1" -resize 32x32 "$2/res/drawable-ldpi/ic_launcher.png"
convert "$1" -resize 48x48 "$2/res/drawable-mdpi/ic_launcher.png"
convert "$1" -resize 96x96 "$2/res/drawable-xhdpi/ic_launcher.png"
