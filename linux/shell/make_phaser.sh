#!/bin/bash

browser="google-chrome"

if [ "$1" != "" ]
then
  mkdir "$1"
  cd "$1"
fi

mkdir -p js css res/sounds res/sprites res/images res/music

#get phaser
wget "https://raw.githubusercontent.com/photonstorm/phaser/master/build/phaser.js" -O "js/phaser.js"

#get some resources
wget "http://files.gamebanana.com/img/ico/sprays/mario_tux_3.png" -O res/images/image1.png
#music by http://multi8it.blogspot.com/
wget "https://github.com/metalx1000/Phaser_Game_Template/blob/master/res/music/music.mp3?raw=true" -O res/music/music1.mp3

ffmpeg -i res/music/music1.mp3 res/music/music1.ogg

#create index
cat << EOF > index.html
<!DOCTYPE html>
<html>
<head>
  <!-- Include stylesheets -->
  <link rel="stylesheet" href="css/main.css">
  <!-- Include Phaser library -->
  <script src="js/phaser.js"></script>
  <!-- Include the Game libraries -->
  <script src="js/main.js"></script>
</head>
<body>
</body>
</html>
EOF

#create basic CSS
cat << EOC > css/main.css
body{
  width: 800px;
  margin: 0px auto; 
  background-color:black;
}
EOC

#create main JS
cat << EOJ > js/main.js
var game = new Phaser.Game(1280, 720, Phaser.AUTO, 'phaser-example', { preload: preload, create: create, update: update});
var centerx = game.width / 2;
var centery = game.height / 2;

function preload() {

  //  You can fill the preloader with as many assets as your game requires

  //  Here we are loading an image. The first parameter is the unique
  //  string by which we'll identify the image later in our code.

  //  The second parameter is the URL of the image (relative)
  game.load.image('image1', 'res/images/image1.png');

  game.load.audio('music', ['res/music/music1.ogg', 'res/music/music1.mp3']);
}

function create() {

  //  This creates a simple sprite that is using our loaded image and
  //  displays it on-screen

  image = game.add.sprite(centerx, centery, 'image1');
  image.scale.setTo(0.5,0.5);
  image.anchor.setTo(0.5, 0.5);
  

  //  Play some music
  music = game.add.audio('music');
  music.play('',0,1,true);

  // start fullscreen on click
  game.input.onDown.add(go_fullscreen, this);
}

function update(){
  //this is where things are updated
}

function go_fullscreen(){
  game.scale.fullScreenScaleMode = Phaser.ScaleManager.SHOW_ALL;
  game.scale.startFullScreen();
}

EOJ

#$browser localhost
