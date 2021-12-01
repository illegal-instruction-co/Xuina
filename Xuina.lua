superJump = false
crossHair = false

FiveX.CreateXui("https://htmlpreview.github.io/?https://raw.githubusercontent.com/illegal-instruction-co/Xuina/main/Xuina.html", 250, 500)

FiveX.OnXuiMessage(function(message)
  message = json.decode(message)
  if(message.superJump ~= nil) then
    superJump = message.superJump
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
  end
end)

-- Main Thread
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if superJump then
      SetSuperJumpThisFrame(PlayerId(-1))
    end
    if crossHair then
      ShowHudComponentThisFrame(14)
    end
  end
end)
