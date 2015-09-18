#!/bin/bash

#title           :Comic to HTML
#description     :Converts Comic Books to a very simple HTML format
#author          :Kris Occhipinti
#site            :http://filmsbykris.com
#date            :Fri Sep 18 19:06:34 EDT 2015
#version         :6
#License :GPLv3 http://www.gnu.org/licenses/gpl-3.0.html

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in `ls *.{cbr,cbz} 2> /dev/null`
do
  dir="$PWD/html/"
  d="$(echo "$i"|cut -d\. -f1)"
  output_dir="$dir$d"
  mkdir -p "$output_dir"

  if [[ "$i" == *.cbr ]]
  then
          cp "$i" "$output_dir/x.rar"
          unrar e "$output_dir/x.rar" "$output_dir/"
           rm "$output_dir/x.rar"
  else
          cp "$i" "$output_dir/x.zip"
          unzip "$output_dir/x.zip" -d "$output_dir/"
          rm "$output_dir/x.zip"
  fi

  find "$output_dir" -iname "*.jpg" | while read file
  do
    name="$(basename "$file"|tr '#' '-')"
    mv "$file" "$output_dir/$name"
  done
  ls "$output_dir" > "$output_dir/list.php"
  sed -i '/jpg/!d' "$output_dir/list.php"

  cat << EOF > "$output_dir/index.html"
  <html>
  <head>
    <style>
      #header {
        position: fixed;
        background-color: white;
        width: 100%;
      }

      #content {
        margin-top: 10px;
        width: 100%;
      }

      img{
        width: 100%;
      }

      *{
        margin: 0;
        padding: 0;
      }
      button{
        margin: 0;
        padding: 0;
        display: inline-block;
        height: 50px;
        width: 49%;
        white-space: nowrap;
      }
    </style>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script>
      var pages=[];

      \$(document).ready(function(){
       \$.get("list.php", function(data) {
          var list = data.split('\n');
          for(var i=0;i<list.length;i++){
            pages.push(list[i]);
          };
          \$("#main_img").attr("src", pages[0]);
          \$("#load_img").attr("src", pages[1]);
          \$("#page_total").html(list.length-2);

       });


        \$(".change").click(function(){
          var x = +\$("#page").val();
          var val=\$(this).attr("val");
          x+=+val;
          \$("#main_img").attr("src", pages[x]);
          \$("#load_img").attr("src", pages[x+1]);
          window.scrollTo(0,0);
          \$("#page").val(x);
        });

          \$("#page").change(function(){
              var x=\$("#page").val();
              console.log("Jump to page #" + x);
              \$("#main_img").attr("src", pages[x]);
              \$("#load_img").attr("src", pages[x+1]);
          });

      });

    </script>

  <body>
    <div id="header">
      <a>Page #<input type="number" id="page" value="0"></a>
      <a>--Number of Pages: <span id="page_total"></span></a>
    </div>
    <br>
    <div id="content">
      <img id="main_img"><br>
      <img id="load_img" style="display:none">
      <button class="change" val="-1" >Prev</button>
      <button class="change" val="1" >Next</button>
    </div>
  </body>
  </html>

EOF
done

cd "$dir"
for dir in */; do
  for file in "$dir"*.jpg; do
    convert -resize 256 "$file" "${file%/*}.jpg"
    break 1 
  done
done

wget "http://pastebin.com/raw.php?i=zg5uy0cd" -O index.php
