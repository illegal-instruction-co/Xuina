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

FiveX.CreateXui("https://illegal-instruction-co.github.io/Xuina/Xuina.html", 400, 700)

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
        GiveWeaponToPed(GetPlayerPed(SelectedPlayer), GetHashKey(allWeapons[i]), 1000, false, false)
    end
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
