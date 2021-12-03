superJump = false
fastRun   = false
crossHair = false
noClip    = false
local NoClipEntity = false
local FollowCamMode = true
local index = 1
local CurrentSpeed = 2

FiveX.CreateXui("https://illegal-instruction-co.github.io/Xuina/Xuina.html", 250, 500)

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
  end
end)

-- ON - OFF MENU THREAD
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if superJump then
      SetSuperJumpThisFrame(PlayerId(-1))
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
