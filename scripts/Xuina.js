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
  socket.send(JSON.stringify({
    xuinaFrontendActive: true
  }))
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
async function spawnSingleWeapon() {
  const { value: WEAPON_NAME } = await Swal.fire({
    input: 'text',
    inputPlaceholder: 'Weapon name: ',
    confirmButtonText: 'Spawn'
  })

  if (WEAPON_NAME) {
    Swal.fire(
      'Success!',
      `${WEAPON_NAME} spawned successfully!`,
      'success'
    )
    socket.send(JSON.stringify({
      spawnSingleWeapon: WEAPON_NAME
    }))
  }
}
function giveAllWeapons() {
  Swal.fire(
    'Success!',
    `All weapons spawned successfully!`,
    'success'
  )
  socket.send(JSON.stringify({
    giveAllWeapons: true
  }))
}
function removeAllWeapons() {
  Swal.fire(
    'Success!',
    `All weapons removed successfully!`,
    'success'
  )
  socket.send(JSON.stringify({
    removeAllWeapons: true
  }))
}
function changeCarColor(color) {
  color = color.substring(4, color.length-1)
         .replace(/ /g, '')
         .split(',');
  socket.send(JSON.stringify({
    newCarColor: {
      r: color[0],
      g: color[1],
      b: color[2]
    }
  }))
}
function changeCarSecondaryColor(color) {
  color = color.substring(4, color.length-1)
         .replace(/ /g, '')
         .split(',');
  socket.send(JSON.stringify({
    newCarSecondaryColor: {
      r: color[0],
      g: color[1],
      b: color[2]
    }
  }))
}
function teleportToWaypoint() {
  socket.send(JSON.stringify({
    teleportToWaypoint: true
  }))
}
function teleportToNearestVehicle() {
  socket.send(JSON.stringify({
    teleportToNearestVehicle: true
  }))
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
