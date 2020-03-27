///////////////////////////////////////////////////////////
//IMPORTS
import css from "../css/app.css"
import "phoenix_html"
import socket from "./socket"
///////////////////////////////////////////////////////////
//MAIN CHANNEL INIT
let channel = socket.channel('main:lobby', {})
//MAIN CHANNEL LISTENER
channel.on('shout', function (payload) { 
  let div = document.createElement("div");
  let name = payload.name;
  div.innerHTML = name + ': ' + payload.message;
  ul.appendChild(div);
  let uri = payload.cont_card;
  if(uri != undefined){
    console.log(uri);
    if(uri[0].includes("https")){
      let img = document.createElement("img");
      console.log("img link:" + uri);
      img.src = uri;
      //img.style.color = "red";
      img.style.width = "21vw";
      img.style.height = "29vw";
      img.style.borderRadius = "5px";
      img.style.border = "2px solid white";
      img.style.color = "red";
      img.alt = "CARD NOT FOUND";
      ul.appendChild(img);
    }
  }
  ul.scrollTop = ul.scrollHeight - ul.clientHeight; 
});
//MAIN CHANNEL JOIN
channel.join();
///////////////////////////////////////////////////////////
//VARIABLES FROM INDEX.HTML
let ul = document.getElementById('msg-list');
let msg = document.getElementById('msg');
//let aic = document.getElementById('active_in_channel');
//NAME HIDDEN VALUE
//let name = document.getElementById('name');
//UID HIDDEN VALUE
//let uid = document.getElementById('uid');
//ON ENTER KEY PRESS LISTENER
msg.addEventListener('keypress', function (event) {
  if (event.keyCode == 13 && msg.value.length > 0) {
    var matches = msg.value.match(/\[\[(.*?)\]\]/);
    console.log(matches);
    var card = "nil";
    if(matches != null){
      card = matches[1];
    }
    channel.push('shout', {
      name: username(),
      message: msg.value,
      uid: uid(),
      cont_card: card
    });
    msg.value = '';
  }
});
/////////////////////////////////////////////////////////