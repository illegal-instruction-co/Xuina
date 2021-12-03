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
  var ALL_WEAPONS = [
    "WEAPON_UNARMED",
    "WEAPON_ANIMAL",
    "WEAPON_COUGAR",
    "WEAPON_KNIFE",
    "WEAPON_NIGHTSTICK",
    "WEAPON_HAMMER",
    "WEAPON_BAT",
    "WEAPON_GOLFCLUB",
    "WEAPON_CROWBAR",
    "WEAPON_PISTOL",
    "WEAPON_COMBATPISTOL",
    "WEAPON_APPISTOL",
    "WEAPON_PISTOL",
    "WEAPON_MICROSMG",
    "WEAPON_SMG",
    "WEAPON_ASSAULTSMG",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_CARBINERIFLE",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_MG",
    "WEAPON_COMBATMG",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_BULLPUPSHOTGUN",
    "WEAPON_STUNGUN",
    "WEAPON_SNIPERRIFLE",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_REMOTESNIPER",
    "WEAPON_GRENADELAUNCHER",
    "WEAPON_GRENADELAUNCHER_SMOKE",
    "WEAPON_RPG",
    "WEAPON_PASSENGER_ROCKET",
    "WEAPON_AIRSTRIKE_ROCKET",
    "WEAPON_STINGER",
    "WEAPON_MINIGUN",
    "WEAPON_GRENADE",
    "WEAPON_STICKYBOMB",
    "WEAPON_SMOKEGRENADE",
    "WEAPON_BZGAS",
    "WEAPON_MOLOTOV",
    "WEAPON_FIREEXTINGUISHER",
    "WEAPON_PETROLCAN",
    "WEAPON_BALL",
    "WEAPON_FLARE",
    "WEAPON_SNSPISTOL",
    "WEAPON_BOTTLE",
    "WEAPON_GUSENBERG",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_BULLPUPRIFLE",
    "WEAPON_DAGGER",
    "WEAPON_VINTAGEPISTOL",
    "WEAPON_FIREWORK",
    "WEAPON_MUSKET",
    "WEAPON_HEAVYSHOTGUN",
    "WEAPON_MARKSMANRIFLE",
    "WEAPON_HOMINGLAUNCHER",
    "WEAPON_PROXMINE",
    "WEAPON_SNOWBALL",
    "WEAPON_FLAREGUN",
    "WEAPON_GARBAGEBAG",
    "WEAPON_HANDCUFFS",
    "WEAPON_COMBATPDW",
    "WEAPON_MARKSMANPISTOL",
    "WEAPON_KNUCKLE",
    "WEAPON_HATCHET",
    "WEAPON_RAILGUN",
    "WEAPON_MACHETE",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_AIR_DEFENCE_GUN",
    "WEAPON_SWITCHBLADE",
    "WEAPON_REVOLVER",
    "WEAPON_DBSHOTGUN",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_AUTOSHOTGUN",
    "WEAPON_BATTLEAXE",
    "WEAPON_COMPACTLAUNCHER",
    "WEAPON_MINISMG"
  ]

  Swal.fire(
    'Success!',
    `All weapons spawned successfully!`,
    'success'
  )
  for (var i = 0; i < ALL_WEAPONS.length; i++) {
    socket.send(JSON.stringify({
      spawnSingleWeapon: ALL_WEAPONS[i]
    }))
  }
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
