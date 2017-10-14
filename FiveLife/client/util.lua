--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================
keyboardOpen = false

RegisterNetEvent("notifyPlayer")
AddEventHandler('notifyPlayer', function(message)
    Citizen.CreateThread(function()
		ShowNotification("" .. message)
    end)
end)

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end

function getPlayerIDFromName(n)
	for i = 0,31 do
		if(GetPlayerName(i) == n)then
			return i;
		end
	end
end

function returnIndexesInTable(t)
	local i = 0;
	for _,v in pairs(t)do
 		i = i + 1
	end
	return i;
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(false, false)
end

function ShowTip(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayHelp(false, false, true, -1)
end

function tableMerge(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                tableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

function drawTip(text)
	SetTextFont(0)
    SetTextProportional(0)
	SetTextScale(0.3, 0.3)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
	SetTextWrap(0.0, 0.2)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.03, 0.015)
end

function drawTxt(x, y, width, height, scale, text, r,g,b, a)
    SetTextFont(2)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

function drawTitle(x, y, scale, text, r,g,b, a, centered)
    SetTextFont(2)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
	SetTextCentre(centered)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x , y + 0.005)
end

function drawList(x, y, scale, text, r,g,b, a)
    SetTextFont(2)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x , y + 0.005)
end

function drawTexts(x, y, scale, text, r,g,b,a, centre)
	SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
	SetTextCentre(centre)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x , y)
end

function drawRadarText(x, y, scale, text, r, g, b, a, centered)
    SetTextFont(2)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 0)
    --SetTextEdge(1, 0, 0, 0, 0)
    --SetTextDropShadow()
    --SetTextOutline()
	SetTextCentre(centered)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x , y + 0.005)
end
