<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        input, body, button, label{
            width:90%;
            height:50px;
            font-size:150%;
        }
    </style>

    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script>
        function get_music(){
            var rev_url=$("#q").val();
            var name=rev_url.split('/').reverse()[0];;
            var rev_url = "get_page.php?rev_url=" + name;
            window.location.replace(rev_url);
        }
    </script>
</head>
<body>
    <label>Please Enter URL for the artist you want:</label><br>
    <input type=text placeholder="example: http://www.reverbnation.com/officialoutcome" id=q><br>
    <button id=search onclick="get_music()">Get Music</button>
</body>
</html>
