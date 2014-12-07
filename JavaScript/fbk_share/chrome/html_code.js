var url = document.URL;
url = url.split("#");
var title = decodeURIComponent(url[1]);
document.getElementById(":0.f").innerHTML = title;

//for facebook - not working right
/*
var box = document.getElementsByTagName("textarea")[0];
box.innerHTML = title;
box.placeholder = title;
box.title = title;
*/
