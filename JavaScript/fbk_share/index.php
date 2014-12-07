<html>
<head>
    <script src="js/jquery-2.1.1.min.js"></script> 
    <script>
        list="video.lst";
        var a=[];
        $(document).ready(function(){
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
                    $("#result").html( "<h1>" + title + "</h1>" );
                    $("#result").append("<img id='go' src=http://i3.ytimg.com/vi/" + id + "/hqdefault.jpg><br>");
                    $("#result").append(title + " https://www.youtube.com/watch?v=" + id); 
                });
            }

            $.get( "replace.php", function( data ) {
                a=data.split("\n");
                get_list();
            }).done(function() {
            });


 
            $("#result").on('click', '#go', function(){
                window.open("https://plus.google.com/share?url=https://www.youtube.com/watch?v="+id+"#"+title2);
                window.open("https://twitter.com/intent/tweet?url=https://www.youtube.com/watch?v="+id+"&text="+title2+":&via=YouTube&related=YouTube,YouTubeTrends,YTCreators");
                window.open("https://www.blogger.com/blog-this.g?n="+title2+"&source=youtube&b=%3Ciframe+width=%22480%22+height=%22270%22+src=%22https://www.youtube.com/embed/"+id+"%22+frameborder=%220%22+allowfullscreen%3E%3C/iframe%3E&eurl=https://i.ytimg.com/vi/"+id+"/hqdefault.jpg");

                window.open("https://www.facebook.com/pages/Films-By-Kris/225113590836253");
            });
        });

        
    </script>
</head>

<body>
    <div id="result"></div>
</body>
</html>
