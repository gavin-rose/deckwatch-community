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
  let li = document.createElement("li");
  //let name = new Date().getTime();
  let name = username();
  li.innerHTML = '<b>' + name + '</b>: ' + payload.message;
  ul.appendChild(li);
  ul.scrollTop = ul.scrollHeight - ul.clientHeight; 
});
//MAIN CHANNEL JOIN
channel.join();
///////////////////////////////////////////////////////////
//VARIABLES FROM INDEX.HTML
let ul = document.getElementById('msg-list');
let msg = document.getElementById('msg');
//let aic = document.getElementById('active_in_channel');
//let name = document.getElementById('name').value;
//ON ENTER KEY PRESS LISTENER
msg.addEventListener('keypress', function (event) {
  if (event.keyCode == 13 && msg.value.length > 0) {
    channel.push('shout', {
      name: name.value,
      message: msg.value
    });
    msg.value = '';
  }
});
/////////////////////////////////////////////////////////