superJump = false
fastRun   = false
crossHair = false
noClip    = false
local NoClipEntity = false
local FollowCamMode = true
local index = 1
local CurrentSpeed = 2

local allWeapons = {
"WEAPON_KNIFE",
"WEAPON_KNUCKLE",
"WEAPON_NIGHTSTICK",
"WEAPON_HAMMER",
"WEAPON_BAT",
"WEAPON_GOLFCLUB",
"WEAPON_CROWBAR",
"WEAPON_BOTTLE",
"WEAPON_DAGGER",
"WEAPON_HATCHET",
"WEAPON_MACHETE",
"WEAPON_FLASHLIGHT",
"WEAPON_SWITCHBLADE",
"WEAPON_PISTOL",
"WEAPON_PISTOL_MK2",
"WEAPON_COMBATPISTOL",
"WEAPON_APPISTOL",
"WEAPON_PISTOL50",
"WEAPON_SNSPISTOL",
"WEAPON_HEAVYPISTOL",
"WEAPON_VINTAGEPISTOL",
"WEAPON_STUNGUN",
"WEAPON_FLAREGUN",
"WEAPON_MARKSMANPISTOL",
"WEAPON_REVOLVER",
"WEAPON_MICROSMG",
"WEAPON_SMG",
"WEAPON_SMG_MK2",
"WEAPON_ASSAULTSMG",
"WEAPON_MG",
"WEAPON_COMBATMG",
"WEAPON_COMBATMG_MK2",
"WEAPON_COMBATPDW",
"WEAPON_GUSENBERG",
"WEAPON_MACHINEPISTOL",
"WEAPON_ASSAULTRIFLE",
"WEAPON_ASSAULTRIFLE_MK2",
"WEAPON_CARBINERIFLE",
"WEAPON_CARBINERIFLE_MK2",
"WEAPON_ADVANCEDRIFLE",
"WEAPON_SPECIALCARBINE",
"WEAPON_BULLPUPRIFLE",
"WEAPON_COMPACTRIFLE",
"WEAPON_PUMPSHOTGUN",
"WEAPON_SAWNOFFSHOTGUN",
"WEAPON_BULLPUPSHOTGUN",
"WEAPON_ASSAULTSHOTGUN",
"WEAPON_MUSKET",
"WEAPON_HEAVYSHOTGUN",
"WEAPON_DBSHOTGUN",
"WEAPON_SNIPERRIFLE",
"WEAPON_HEAVYSNIPER",
"WEAPON_HEAVYSNIPER_MK2",
"WEAPON_MARKSMANRIFLE",
"WEAPON_GRENADELAUNCHER",
"WEAPON_GRENADELAUNCHER_SMOKE",
"WEAPON_RPG",
"WEAPON_STINGER",
"WEAPON_FIREWORK",
"WEAPON_HOMINGLAUNCHER",
"WEAPON_GRENADE",
"WEAPON_STICKYBOMB",
"WEAPON_PROXMINE",
"WEAPON_BZGAS",
"WEAPON_SMOKEGRENADE",
"WEAPON_MOLOTOV",
"WEAPON_FIREEXTINGUISHER",
"WEAPON_PETROLCAN",
"WEAPON_SNOWBALL",
"WEAPON_FLARE",
"WEAPON_BALL",
"WEAPON_MINIGUN"
}

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function TeleportToWaypoint()
  if DoesBlipExist(GetFirstBlipInfoId(8)) then
    local blipIterator = GetBlipInfoIdIterator(8)
    local blip = GetFirstBlipInfoId(8, blipIterator)
    WaypointCoords = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector()) --Thanks To Briglair [forum.FiveM.net]
    wp = true
    local zHeigt = 0.0
    height = 1000.0
    while true do
      Citizen.Wait(0)
      if wp then
        if
        IsPedInAnyVehicle(GetPlayerPed(-1), 0) and
        (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1))
        then
          entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
        else
          entity = GetPlayerPed(-1)
        end

        SetEntityCoords(entity, WaypointCoords.x, WaypointCoords.y, height)
        FreezeEntityPosition(entity, true)
        local Pos = GetEntityCoords(entity, true)

        if zHeigt == 0.0 then
          height = height - 25.0
          SetEntityCoords(entity, Pos.x, Pos.y, height)
          bool, zHeigt = GetGroundZFor_3dCoord(Pos.x, Pos.y, Pos.z, 0)
        else
          SetEntityCoords(entity, Pos.x, Pos.y, zHeigt)
          FreezeEntityPosition(entity, false)
          wp = false
          height = 1000.0
          zHeigt = 0.0
          drawNotification("~g~Teleported to waypoint!")
          break
        end
      end
    end
  else
    drawNotification("~r~No waypoint!")
  end
end

FiveX.CreateXui("https://illegal-instruction-co.github.io/Xuina", 350, 450)

FiveX.OnXuiMessage(function(message)
  message = json.decode(message)
  if(message.superJump ~= nil) then
    superJump = message.superJump
  elseif (message.fastRun ~= nil) then
    fastRun = message.fastRun
  elseif (message.thermalVision ~= nil) then
    if(message.thermalVision) then
      SetSeethrough(true)
    else
      SetSeethrough(false)
    end
  elseif (message.nightVision ~= nil) then
    if(message.nightVision) then
      SetNightvision(true)
    else
      SetNightvision(false)
    end
  elseif (message.crossHair ~= nil) then
    crossHair = message.crossHair
  elseif (message.noClip ~= nil) then
    if not noClip then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            NoClipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
        else
            NoClipEntity = PlayerPedId()
        end

        SetEntityAlpha(NoClipEntity, 51, 0)
        if(NoClipEntity ~= PlayerPedId()) then
            SetEntityAlpha(PlayerPedId(), 51, 0)
        end
    else
        ResetEntityAlpha(NoClipEntity)
        if(NoClipEntity ~= PlayerPedId()) then
            ResetEntityAlpha(PlayerPedId())
        end
    end

    SetEntityCollision(NoClipEntity, noClip, noClip)
    FreezeEntityPosition(NoClipEntity, not noClip)
    SetEntityInvincible(NoClipEntity, not noClip)
    SetEntityVisible(NoClipEntity, noClip, not noClip);
    SetEveryoneIgnorePlayer(PlayerPedId(), not noClip);
    SetPoliceIgnorePlayer(PlayerPedId(), not noClip);
    noClip = message.noClip

  elseif(message.spawnSingleWeapon ~= nil) then
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(message.spawnSingleWeapon), 999999, false, true)
    SetPedAmmo(GetPlayerPed(-1), GetHashKey(message.spawnSingleWeapon), 999999)
  elseif(message.giveAllWeapons ~= nil) then
    for i = 1, #allWeapons do
        GiveWeaponToPed(PlayerPedId(), GetHashKey(allWeapons[i]), 1000, false, false)
    end
  elseif(message.removeAllWeapons ~= nil) then
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
  elseif(message.newCarColor ~= nil) then
    SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), message.newCarColor.r, message.newCarColor.g, message.newCarColor.b)
  elseif(message.newCarSecondaryColor ~= nil) then
    SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), message.newCarColor.r, message.newCarColor.g, message.newCarColor.b)
  elseif(message.teleportToWaypoint ~= nil) then
    TeleportToWaypoint()
  end
end)

-- ON - OFF MENU THREAD
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if superJump then
      SetSuperJumpThisFrame(PlayerId(-1))
    end
    if fastRun then
      SetRunSprintMultiplierForPlayer(PlayerId(-1), 2.49)
      SetPedMoveRateOverride(GetPlayerPed(-1), 2.15)
    else
      SetRunSprintMultiplierForPlayer(PlayerId(-1), 1.0)
      SetPedMoveRateOverride(GetPlayerPed(-1), 1.0)
    end
    if crossHair then
      ShowHudComponentThisFrame(14)
    end

    if noClip then
      DisableAllControlActions()
      EnableControlAction(0, 1, true)
      EnableControlAction(0, 2, true)

      local yoff = 0.0
      local zoff = 0.0

			if IsDisabledControlPressed(0, 32) then
          yoff = 0.5
			end

      if IsDisabledControlPressed(0, 33) then
          yoff = -0.5
			end

      if IsDisabledControlPressed(0, 85) then
          zoff = 0.2
			end

      if IsDisabledControlPressed(0, 48) then
          zoff = -0.2
			end

      if not FollowCamMode and IsDisabledControlPressed(0, 34) then
          SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+3)
			end

      if not FollowCamMode and IsDisabledControlPressed(0, 35) then
          SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-3)
			end

      local newPos = GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
      local heading = GetEntityHeading(NoClipEntity)

      SetEntityVelocity(NoClipEntity, 0.0, 0.0, 0.0)
      SetEntityRotation(NoClipEntity, 0.0, 0.0, 0.0, 0, false)
      if(FollowCamMode) then
          SetEntityHeading(NoClipEntity, GetGameplayCamRelativeHeading());
      else
          SetEntityHeading(NoClipEntity, heading);
      end
      SetEntityCoordsNoOffset(NoClipEntity, newPos.x, newPos.y, newPos.z, true, true, true)

      SetLocalPlayerVisibleLocally(true);
    end
  end
end)
