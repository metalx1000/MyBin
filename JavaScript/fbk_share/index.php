<?php include('update.php');?>
<html>
<head>
    <script src="js/jquery-2.1.1.min.js"></script> 
    <script>
        list="video.lst";
        buttons="buttons.lst";

        var a=[];
        var b=[];

        function update_links(){
            title2 = $("#text").val();
            title2 = title2.replace(/#/g, '%23');
            var twitter = "https://twitter.com/intent/tweet?url=https://www.youtube.com/watch?v="+id+"&text="+title2+":&via=YouTube&related=YouTube,YouTubeTrends,YTCreators";
            $("#twitter").attr("href", twitter);

            var google = "https://plus.google.com/share?url=https://www.youtube.com/watch?v="+id+"#"+title2;
            $("#google").attr("href", google);

            var blogger = "https://www.blogger.com/blog-this.g?n="+title2+"&source=youtube&b=%3Ciframe+width=%22480%22+height=%22270%22+src=%22https://www.youtube.com/embed/"+id+"%22+frameborder=%220%22+allowfullscreen%3E%3C/iframe%3E&eurl=https://i.ytimg.com/vi/"+id+"/hqdefault.jpg";
            $("#blogger").attr("href", blogger);

            var facebook = "https://www.facebook.com/pages/Films-By-Kris/225113590836253#"+title2;
            $("#facebook").attr("href", facebook);
        }

        $(document).ready(function(){
            //Get Button List
            $.get( buttons, function( data ) {
                var b = data.split('\n');
                b.forEach(function(button){
                    $("#buttons").append("<button class='tag' style='font-size:25px'>" + button + "</button>");        
                });
            });

            $("body").on('click','.tag',function(){
                var tag = $(this).html();
                //console.log(tag);
                var val = $("#text").val();
                $("#text").val(val + " " + tag);
                update_links();
            });
            


            //Get list of video
            function get_list(){
                $.get( list, function( data ) {
                    var lines = data.split('\n');
                    var r = Math.floor( Math.random() * lines.length );
                    var line = lines[r].split('|');
                    title = line[0];
                    title = title.replace("#", "-");

                    //var a = ["linux", "bash", "python", "programming", "tutorial","shell","gtk","qt", "grep","awk","blender", "ThreeJS", "HTML5", "BabylonJS", "Kdenlive","Imagemagick","GIMP","Ardour","hydrogen","pygame","slitaz","webkit","Windows","newcat","GUI"];
                    a.forEach(function(entry) {
                        if(entry != ""){
                         var regex = new RegExp( '(' + entry + ')', 'gi' );
                         title=title.replace( regex, "#$1" );
                        //title = title.replace("(" + entry + ")"gi, '#$1');
                        }
                    });
                    title2 = title.replace(/#/g, '%23');
                    id = line[1];
                    text = title + " https://www.youtube.com/watch?v=" + id;
                    $("#result").html( "<a href='https://www.youtube.com/watch?v="+id+"' target='_blank'><h1>" + title + "</h1></a>" );
                    $("#result").append("<img id='go' src=http://i3.ytimg.com/vi/" + id + "/hqdefault.jpg><br>");
                    $("#result").append("<input id='text' onClick='this.select();' style='width:100%;font-size:25px' value='"+text+" via @youtube'>" ); 
                    update_links();
                });
            }

            $.get( "replace.php", function( data ) {
                a=data.split("\n");
                get_list();
            }).done(function() {
            });


 
            $("#result").on('click', '#go', function(){
                title2 = $("#text").val();
                title2 = title2.replace(/#/g, '%23');
                window.open("https://plus.google.com/share?url=https://www.youtube.com/watch?v="+id+"#"+title2);
                window.open("https://twitter.com/intent/tweet?url=https://www.youtube.com/watch?v="+id+"&text="+title2+":&via=YouTube&related=YouTube,YouTubeTrends,YTCreators");
                window.open("https://www.blogger.com/blog-this.g?n="+title2+"&source=youtube&b=%3Ciframe+width=%22480%22+height=%22270%22+src=%22https://www.youtube.com/embed/"+id+"%22+frameborder=%220%22+allowfullscreen%3E%3C/iframe%3E&eurl=https://i.ytimg.com/vi/"+id+"/hqdefault.jpg");

                window.open("https://www.facebook.com/pages/Films-By-Kris/225113590836253#"+title2);
            });
        });

    </script>
</head>

<body>
    <div id="links">
        <a id="google" target="_blank"><button style='font-size:25px'>Google+</button></a>
        <a id="twitter" target="_blank"><button style='font-size:25px'>Twitter</button></a>
        <a id="blogger" target="_blank"><button style='font-size:25px'>Bloggler</button></a>
        <a id="facebook" target="_blank"><button style='font-size:25px'>FaceBook</button></a>
    </div>
    <div id="result"></div>
    <div id="buttons"></div>
</body>
</html>
