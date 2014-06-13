#!/bin/bash

#title           :Comic to HTML
#description     :Converts Comic Books to a very simple HTML format
#author		       :Kris Occhipinti
#site            :http://filmsbykris.com
#date            :Tue Jun  3 12:23:23 EDT 2014
#version         :3    
#usage		       :comic2html file.cbr
#notes           :To convert a bunch of files 'for i in *;do comic2html "$i";done'
#License :GPLv3 http://www.gnu.org/licenses/gpl-3.0.html

rm -fr /tmp/comic
mkdir -p /tmp/comic

dir="/media/tb/comics/"
mkdir -p "$dir"

cp "$1" /tmp/comic/
cd /tmp/comic/

if [[ "$1" == *.cbr ]]
then
        mv "$1" x.rar
        unrar e x.rar
        rm x.rar
else
        mv "$1" x.zip
        unzip x.zip
        rm x.zip
fi

let x=100
find -iname "*.jpg"|sort|while read i
do
        echo "$i" 
        convert -resize x1400 "$i" "$x.png"
        #convert -resize x100 "$i" "thumb/$x.png"
        rm "$i"
        let x+=1
done

let x=$(ls | wc -w)
let x=$x-1

cat << EOF > index.html
<html>
<head>
        <script>
                x=100;
                
                function next(){
                        x+=1;
                        document.getElementById('main_img').src=x + ".png";
                        z=x-100;
                        document.getElementById('page').value=z;
                        window.scrollTo(0,0);
                        document.getElementById('load_img').src=x + 1 + ".png";
                }

                function prev(){
                        x-=1;
                        document.getElementById('main_img').src=x + ".png";
                        z=x-100;
                        document.getElementById('page').value=z;
                }

                function set_page(){
                        x=document.getElementById('page').value;
                        x=parseInt(x);
                        x+=100;
                        document.getElementById('main_img').src=x + ".png";
                }
        </script>
</head>

<body>
   <div id="pagenum" style="position:fixed;top:0px;left:0px;background-color:white">
        <a>Page #<input type="number" id="page" min="1" max="100" onChange="set_page()"></a>
        <a>--Number of Pages: $x</a>
        <br>
   </div>
   <div id="main" style="top:20px">
        <img src="100.png" id="main_img"><br>
        <img src="101.png" id="load_img" style="display:none">
        <button onclick="prev()" style="width:25%;height:50px">Prev</button>
        <button onclick="next()" style="width:50%;height:50px">Next</button>
   </div>
</body>
</html>
EOF

d="$(echo "$1"|cut -d\. -f1)"
mkdir -p "$dir$d"
cp * "$dir$d/"
