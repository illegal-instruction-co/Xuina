var superJumpToggle = false
var fastRunToggle = false
var thermalVisionToggle = false
var nightVisionToggle = false
var crossHairToggle = false
var noClipToggle = false

// Connect to XUI backend
const socket = new WebSocket('ws://localhost:3724');

// Connection ready
socket.addEventListener('open', function (event) {

});

// Listen for messages
socket.addEventListener('message', function (event) {
    if(JSON.parse(event.data)) {
      //setMessageDiv(JSON.parse(event.data).randomMsg)
    }
});

/*
  ON - OFF MENU
*/
function superJump() {
  superJumpToggle = !superJumpToggle
  socket.send(JSON.stringify({
    superJump: superJumpToggle
  }))
  document.getElementById("superJumpToggle").innerHTML = superJumpToggle
}
function fastRun() {
  fastRunToggle = !fastRunToggle
  socket.send(JSON.stringify({
    fastRun: fastRunToggle
  }))
  document.getElementById("fastRunToggle").innerHTML = fastRunToggle
}
function thermalVision() {
  thermalVisionToggle = !thermalVisionToggle
  socket.send(JSON.stringify({
    thermalVision: thermalVisionToggle
  }))
  document.getElementById("thermalVisionToggle").innerHTML = thermalVisionToggle
}
function nightVision() {
  nightVisionToggle = !nightVisionToggle
  socket.send(JSON.stringify({
    nightVision: nightVisionToggle
  }))
  document.getElementById("nightVisionToggle").innerHTML = nightVisionToggle
}
function crossHair() {
  crossHairToggle = !crossHairToggle
  socket.send(JSON.stringify({
    crossHair: crossHairToggle
  }))
  document.getElementById("crossHairToggle").innerHTML = crossHairToggle
}
function noClip() {
  noClipToggle = !noClipToggle
  socket.send(JSON.stringify({
    noClip: noClipToggle
  }))
  document.getElementById("noClipToggle").innerHTML = noClipToggle
}

/*
  Maybe keyboard navigation later ?
*/
document.onkeydown = function(e) {

    e = e || window.event;

    if (e.keyCode == '38') {
        // up arrow
    }
    else if (e.keyCode == '40') {
        // down arrow
    }
    else if (e.keyCode == '37') {
       // left arrow
    }
    else if (e.keyCode == '39') {
       // right arrow
    }

}
