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
  //let name = new Date().getTime();
  //let name = username();
  let name = payload.name;
  //UID HIDDEN VALUE
  //let uid = payload.uid;
  div.innerHTML = name + ': ' + payload.message;
  ul.appendChild(div);
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
    channel.push('shout', {
      name: username(),
      message: msg.value,
      uid: uid()
    });
    msg.value = '';
  }
});
/////////////////////////////////////////////////////////