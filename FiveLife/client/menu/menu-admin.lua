--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================
local count1 = 1
local count2 = 1

function showAdminMenu()
	local myPed = GetPlayerPed(-1)
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.155, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Admin Mode",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	
	showNormalSelection()
	if amenu.page == 0 then
		amenu.title = "MAIN MENU"
		menuItems("Refresh Players", "Teleport", "nil", "nil", "nil", "nil")
	elseif amenu.page == 1 then
		amenu.title = "TELEPORT"
		menuItems("Teleport to " .. GetPlayerName(currentPlayers[count1]), "Bring " .. GetPlayerName(currentPlayers[count2]), "nil", "nil", "nil", "nil")
	end
	
	DisablePlayerFiring(myPed, true)
	HideHudAndRadarThisFrame()
	DisableControlAction(0, 24, 1)
	DisableControlAction(0, 25, 1)
	DisableControlAction(0, 140, 1)
	DisableControlAction(0, 141, 1)
	DisableControlAction(0, 142, 1)
	
	
	-- ============================== KEY PRESSES ==============================
	
	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		if amenu.row > 1 then 
			amenu.row = amenu.row-1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		if amenu.page == 0 then
			if amenu.row < 2 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 1  then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		end
	elseif IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
		if amenu.page == 0 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if count1 < #currentPlayers then count1 = count1 + 1 else count1 = 1 end
			end
		elseif amenu.page == 1 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if count1 < #currentPlayers then count1 = count1 + 1 else count1 = 1 end
			elseif amenu.row == 2 then
				if count2 < #currentPlayers then count2 = count2 + 1 else count2 = 1 end
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		if amenu.page == 0 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if count1 > 1 then count1 = count1 - 1 else count1 = #currentPlayers end
			end
		elseif amenu.page == 1 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if count1 > 1 then count1 = count1 - 1 else count1 = #currentPlayers end
			elseif amenu.row == 2 then
				if count2 > 1 then count2 = count2 - 1 else count2 = #currentPlayers end
			end
		end
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		if amenu.page == 0 then
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				getCurrentPlayersActive()
			elseif amenu.row == 2 then
				amenu.page = 1
			end
		elseif amenu.page == 1 then
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if IsPedInAnyVehicle(GetPlayerPed(currentPlayers[count1]), false) then
					local vehicle = GetVehiclePedIsIn(GetPlayerPed(currentPlayers[count1]), false)
					local target = GetEntityCoords(vehicle, false)
					RequestCollisionAtCoord(target.x, target.y, target.z)
					SetEntityCoords(myPed, target.x, target.y, target.z + 2.0)
					SetPedIntoVehicle(myPed, vehicle, -2)
				else
					local target = GetEntityCoords(GetPlayerPed(currentPlayers[count1]), true)
					RequestCollisionAtCoord(target.x, target.y, target.z)
					SetEntityCoords(myPed, target.x, target.y, target.z + 2.0)
				end
			elseif amenu.row == 2 then
				-- Bring player
			end
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 then
			amenu.show = 0
			amenu.row = 1
			phone('enable')
			RequestCollisionAtCoord(admin_lastLocation.x, admin_lastLocation.y, admin_lastLocation.z)
			SetEntityCoords(myPed, admin_lastLocation.x, admin_lastLocation.y, admin_lastLocation.z)
			SetEntityVisible(myPed, true)
			TriggerEvent("AwesomeGod", false)
		elseif amenu.page == 1 then
			amenu.page = 0
			amenu.row = 2
		end
	end
end


