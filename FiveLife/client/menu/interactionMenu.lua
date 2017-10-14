--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local amenu = {show = 0, input = 'none', row = 0, page = 0, player = false, pvehicle = false, playerID = 0, playerServerID = 0, vehicleID = 0, occupied = false, backseat = false, name = "none", title = 'none', field = 0, title2 = 'none'}
local giveItem = {item = 'Empty', amount = 0}
local giveCashAmount = 0
local giveItemAmount = 0
local trunk = false
local lastX = 0.0
local lastY = 0.0

-- ============================================== INTERACTION MENU ==============================================
function showInteractionMenu()
	if amenu.page ~= 0 then
		RequestStreamedTextureDict("commonmenu", true)
		while not HasStreamedTextureDictLoaded("commonmenu") do
			Citizen.Wait(1)
		end
		DrawSprite("commonmenu", "gradient_bgd", 0.5, 0.5, 0.16, 0.3, 0.0, 255, 255, 255, 255)
		DrawRect(0.5, 0.355, 0.16, 0.034, 0, 0, 0, 255)
		drawTxt(0.425, 0.335, 0.0, 0.0, 0.4, "" .. amenu.title,30,88,162,255)
	end

	if amenu.page == 0 then
		ShowCursorThisFrame()
		RequestStreamedTextureDict("interact", true)
		while not HasStreamedTextureDictLoaded("interact") do
			Citizen.Wait(1)
		end
		SetPlayerControl(PlayerId(), 0, 0)
		if debugMode then
			drawTexts(0.8, 0.8, 0.35, "X: " .. mouseX, 255,255,255,255, 1)
			drawTexts(0.8, 0.83, 0.35, "Y: " .. mouseY, 255,255,255,255, 1)
		end
		drawTexts(0.5, 0.45, 0.3, "" .. amenu.title2, 255,255,255,255, 1)

		DrawSprite("interact", "base", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
		if amenu.player == true then
			DrawSprite("interact", "icons_player", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
		elseif pvehicle == true then
			DrawSprite("interact", "icons_vehicle", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
		else
			DrawSprite("interact", "icons_vehicle2", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
		end
		if amenu.field == 0 then
			DrawSprite("interact", "area0", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			if amenu.player == true then amenu.title2 = "Identify" else amenu.title2 = "Repair" end
		elseif amenu.field == 1 then
			DrawSprite("interact", "area1", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			if amenu.player == true then amenu.title2 = "Give Cash" elseif pvehicle then amenu.title2 = "Place Item" else amenu.title2 = " " end
		elseif amenu.field == 2 then
			DrawSprite("interact", "area2", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			if amenu.player == true then amenu.title2 = "Give Item" elseif pvehicle then amenu.title2 = "Remove Item" else amenu.title2 = " " end
		elseif amenu.field == 3 then
			DrawSprite("interact", "area3", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			amenu.title2 = " "
		elseif amenu.field == 4 then
			DrawSprite("interact", "area4", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			amenu.title2 = " "
		elseif amenu.field == 5 then
			DrawSprite("interact", "area5", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			amenu.title2 = " "
		elseif amenu.field == 6 then
			DrawSprite("interact", "area6", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			amenu.title2 = " "
		elseif amenu.field == 7 then
			DrawSprite("interact", "area7", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			if amenu.player == true then amenu.title2 = "Give Keys" else amenu.title2 = "Get Plate" end
		end

	elseif amenu.page == 1 then -- Give Cash
		amenu.title = 'Give Cash'
		if amenu.row == 1 then DrawRect(0.5, 0.47, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.5, 0.51, 0.16, 0.034, 255, 255, 255, 255) end
		drawTxt(0.425, 0.37, 0.0, 0.0, 0.35, "You have ~g~$" .. getBank('cash'),255,255,255,255)
		drawTxt(0.425, 0.45, 0.0, 0.0, 0.35, "Amount: ~g~$" .. giveCashAmount,255,255,255,255)
		drawTxt(0.425, 0.49, 0.0, 0.0, 0.35, "Give to Player",255,255,255,255)

	elseif amenu.page == 2 then -- Give Item 1
		amenu.title = 'Give Item'
		if amenu.row == 1 then DrawRect(0.5, 0.39, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.5, 0.43, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 3 then DrawRect(0.5, 0.47, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 4 then DrawRect(0.5, 0.51, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 5 then DrawRect(0.5, 0.55, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 6 then DrawRect(0.5, 0.59, 0.16, 0.034, 255, 255, 255, 255) end
		drawItems(1)
	elseif amenu.page == 3 then -- Give Item 2
		amenu.title = 'Give Item'
		if amenu.row == 1 then DrawRect(0.5, 0.39, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.5, 0.43, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 3 then DrawRect(0.5, 0.47, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 4 then DrawRect(0.5, 0.51, 0.16, 0.034, 255, 255, 255, 255) end
		drawItems(2)
	elseif amenu.page == 4 then -- Give Item 3
		amenu.title = 'Give Item'
		if amenu.row == 1 then DrawRect(0.5, 0.47, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.5, 0.51, 0.16, 0.034, 255, 255, 255, 255) end
		--drawTxt(0.425, 0.37, 0.0, 0.0, 0.4, "" .. giveItem.item,255,255,255,255)
		drawTxt(0.425, 0.37, 0.0, 0.0, 0.35, "You have " .. giveItem.amount .. " " .. giveItem.item,255,255,255,255)
		drawTxt(0.425, 0.45, 0.0, 0.0, 0.35, "Amount: " .. giveItemAmount,255,255,255,255)
		if amenu.player == true then drawTxt(0.425, 0.49, 0.0, 0.0, 0.35, "Give to Player",255,255,255,255)
		else drawTxt(0.425, 0.49, 0.0, 0.0, 0.35, "Place in Vehicle",255,255,255,255) end

	elseif amenu.page == 5 then -- Reserved
		amenu.title = ' '
	elseif amenu.page == 6 then -- REMOVE ITEM
		amenu.title = 'Remove Item'
		drawTxt(0.425, 0.37, 0.0, 0.0, 0.4, "Coming Soon",114,114,114,255)
	end
end

function showPoliceMenu()
	if amenu.page ~= 0 then
		RequestStreamedTextureDict("commonmenu", true)
		while not HasStreamedTextureDictLoaded("commonmenu") do
			Citizen.Wait(1)
		end
		DrawSprite("commonmenu", "gradient_bgd", 0.5, 0.5, 0.16, 0.3, 0.0, 255, 255, 255, 255)
		DrawRect(0.5, 0.355, 0.16, 0.034, 0, 0, 0, 255)
		drawTxt(0.425, 0.335, 0.0, 0.0, 0.4, "" .. amenu.title,30,88,162,255)
	end

	if amenu.page == 0 then
		ShowCursorThisFrame()
		RequestStreamedTextureDict("interact", true)
		while not HasStreamedTextureDictLoaded("interact") do
			Citizen.Wait(1)
		end
		SetPlayerControl(PlayerId(), 0, 0)
		if debugMode then
			drawTexts(0.8, 0.8, 0.35, "X: " .. mouseX, 255,255,255,255, 1)
			drawTexts(0.8, 0.83, 0.35, "Y: " .. mouseY, 255,255,255,255, 1)
		end
		drawTexts(0.5, 0.45, 0.3, "" .. amenu.title2, 255,255,255,255, 1)

		DrawSprite("interact", "base", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
		if amenu.player == true then
			DrawSprite("interact", "icons_police_player", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			DrawSprite("interact", "icons_police_extra_door", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
		elseif amenu.occupied then
			DrawSprite("interact", "icons_police_vehicle", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
		else
			DrawSprite("interact", "icons_vehicle2", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
		end
		if amenu.field == 0 then
			DrawSprite("interact", "area0", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			if amenu.player == true then amenu.title2 = "Identify" elseif amenu.occupied then amenu.title2 = "Get Plate" else amenu.title2 = "Repair" end
		elseif amenu.field == 1 then
			DrawSprite("interact", "area1", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			if amenu.player == true then amenu.title2 = "Search" elseif amenu.occupied then amenu.title2 = "Identify" else amenu.title2 = " " end
		elseif amenu.field == 2 then
			DrawSprite("interact", "area2", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			if amenu.player == true then amenu.title2 = "Grab" else amenu.title2 = " " end
		elseif amenu.field == 3 then
			DrawSprite("interact", "area3", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			if amenu.player == true then amenu.title2 = "Seat" else amenu.title2 = " " end
		elseif amenu.field == 4 then
			DrawSprite("interact", "area4", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			amenu.title2 = " "
		elseif amenu.field == 5 then
			DrawSprite("interact", "area5", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			amenu.title2 = " "
		elseif amenu.field == 6 then
			DrawSprite("interact", "area6", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			if amenu.player == true then amenu.title2 = "Ticket" else amenu.title2 = " " end
		elseif amenu.field == 7 then
			DrawSprite("interact", "area7", 0.5,0.5, 0.5,0.7, 0.0, 255, 255, 255, 255)
			if amenu.player == true then amenu.title2 = "Arrest" elseif amenu.occupied then amenu.title2 = "Pull out" else amenu.title2 = "Get Plate" end
		end
	end
end

function startInteractionMenu(level)
	amenu.show = level+1
	amenu.row = 1
	amenu.page = 0
	phone('disable')
	if amenu.show == 5 then
		amenu.show = 1
	end
end

local grabbing = 0
local debugPed = 0
local debugPlayerID = 0
local debugServerID = 0
-- ============================================== KEY PRESSES ==============================================
Citizen.CreateThread(function()
	DisableControlAction(0, 38, true)
	while true do
		Wait(0)
		if amenu.input ~= 'none' then checkInteractionKeyboard() end
		if debugMode then
			if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
				if GetClosestPlayerPed() ~= false and GetClosestPlayerPed() ~= nil then
					debugPed = GetClosestPlayerPed()
					debugPlayerID = GetLocalPlayerId(debugPed)
					debugServerID = GetPlayerServerId(debugPlayerID)
				else
					debugPed = 0
					debugServerID = 0
				end
				--drawTxt(0.7, 0.81, 0.0, 0.0, 0.35, "Local Ped ID: " .. debugPed,255,255,255,255)
				--drawTxt(0.7, 0.84, 0.0, 0.0, 0.35, "Server ID: " .. debugServerID,255,255,255,255)
			end
		end

		if amenu.show == 1 then
			showInteractionMenu()
		elseif amenu.show == 2 or amenu.show == 3 or amenu.show == 4 then
			showPoliceMenu()
		elseif amenu.show == 5 then
			-- showMedicMenu()
			showInteractionMenu()
		end

		if IsDisabledControlJustPressed(1, 38) and keyboardOpen == false and stance.type ~= "CUFFED" then -- E
			if stance.type == "GRABBING" then
				TriggerServerEvent("interact:grab", stance.grabbing)
				changeStance("STANDING")
				stance.grabbing = 0
			else
				if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
					if amenu.show ~= 0 then
						amenu.show = 0
						amenu.row = 1
						amenu.page = 0
						phone('enable')
						SetPlayerControl(PlayerId(), 1, 0)
					else
						if GetClosestPlayerPed() ~= false then
							amenu.playerID = GetLocalPlayerId(GetClosestPlayerPed())
							amenu.playerServerID = GetPlayerServerId(amenu.playerID)
							amenu.player = true
							TriggerServerEvent("getRoleplayName", amenu.playerServerID)
							amenu.title = "Player"
							startInteractionMenu(onDuty)
						elseif GetClosestVeh() ~= false then
							amenu.vehicleID = GetClosestVeh()
							amenu.player = false
							amenu.title = GetDisplayNameFromVehicleModel(GetEntityModel(amenu.vehicleID))
							local plate = GetVehicleNumberPlateText(amenu.vehicleID)
							local plateSub = plate:sub(1,1)
							if plateSub == 'P' or plateSub == 'G' or plateSub == 'E' then pvehicle = true else pvehicle = false end
							if not IsVehicleSeatFree(amenu.vehicleID, -1) then
								amenu.occupied = true
								amenu.playerID = GetLocalPlayerId(GetPedInVehicleSeat(amenu.vehicleID, -1))
								amenu.playerServerID = GetPlayerServerId(amenu.playerID)
								TriggerServerEvent("getRoleplayName", amenu.playerServerID)
							elseif not IsVehicleSeatFree(amenu.vehicleID, 1) then
								amenu.occupied = true
								amenu.playerID = GetLocalPlayerId(GetPedInVehicleSeat(amenu.vehicleID, 1))
								amenu.playerServerID = GetPlayerServerId(amenu.playerID)
								TriggerServerEvent("getRoleplayName", amenu.playerServerID)
							elseif not IsVehicleSeatFree(amenu.vehicleID, 2) then
								amenu.occupied = true
								amenu.playerID = GetLocalPlayerId(GetPedInVehicleSeat(amenu.vehicleID, 2))
								amenu.playerServerID = GetPlayerServerId(amenu.playerID)
								TriggerServerEvent("getRoleplayName", amenu.playerServerID)
							else
								amenu.occupied = false
							end
							startInteractionMenu(onDuty)
						end
					end
				end
			end
		end

		if GetClosestPlayerPed() == false and GetClosestVeh() == false and trunk == false then
			amenu.show = 0
			amenu.row = 1
			amenu.page = 0
			phone('enable')
			SetPlayerControl(PlayerId(), 1, 0)
		elseif GetClosestPlayerPed() == false and GetClosestVeh() == false and trunk == true then
			Wait(750)
			if GetClosestPlayerPed() == false and GetClosestVeh() == false then
				amenu.show = 0
				amenu.row = 1
				amenu.page = 0
				phone('enable')
				SetPlayerControl(PlayerId(), 1, 0)
				SetVehicleDoorShut(amenu.vehicleID, 5, false)
				trunk = false
			end
		end

		if amenu.page == 0 then
			if mouseX>0.437 and mouseX<0.555 and mouseY<0.333 and mouseY>0.21 then
				amenu.field = 0
			elseif mouseX>0.555 and mouseX<0.672 and mouseY<0.406 and mouseY>0.243 then
				amenu.field = 1
			elseif mouseX>0.606 and mouseX<0.686 and mouseY>0.406 and mouseY<0.568 then
				amenu.field = 2
			elseif mouseX>0.555 and mouseX<0.672 and mouseY>0.568 and mouseY<0.734 then
				amenu.field = 3
			elseif mouseX>0.437 and mouseX<0.555 and mouseY>0.638 and mouseY<0.754 then
				amenu.field = 4
			elseif mouseX<0.437 and mouseX>0.322 and mouseY>0.568 and mouseY<0.734 then
				amenu.field = 5
			elseif mouseX<0.389 and mouseX>0.306 and mouseY<0.568 and mouseY>0.406 then
				amenu.field = 6
			elseif mouseX<0.452 and mouseX>0.323 and mouseY<0.406 and mouseY>0.243 then
				amenu.field = 7
			end
		end

		if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then -- Mouse1
			if amenu.show == 1 then
				if amenu.field == 0 then
					if amenu.player == true then
						ShowNotification("You identified " .. amenu.name .. " (" .. amenu.playerServerID .. ")")
					else
						if GetVehicleEngineHealth(amenu.vehicleID) < 700.0 then
							if hasItem("Repair-Kit") then
								TriggerServerEvent("removeFromInventory", 0, 'Repair-Kit', 1)
								fixCarManual(amenu.vehicleID)
							elseif hasItem("Engine-Kit") then
								TriggerServerEvent("removeFromInventory", 0, 'Engine-Kit', 1)
								fixCarManual(amenu.vehicleID)
							else
								ShowNotification("~r~You need an ~b~Engine Kit~r~!")
							end
						else
							if hasItem("Body-Kit") then
								TriggerServerEvent("removeFromInventory", 0, 'Body-Kit', 1)
								fixCarManual(amenu.vehicleID)
							else
								ShowNotification("~r~You need a ~b~Body Kit~r~!")
							end
						end
					end
				elseif amenu.field == 1 then
					if amenu.player == true then
						amenu.page = 1
						amenu.row = 1
					elseif pvehicle == true then
						amenu.page = 2
						amenu.row = 1
						trunk = true
						SetVehicleDoorOpen(amenu.vehicleID, 5, false, false)
					end
				elseif amenu.field == 2 then
					if amenu.player == true then
						amenu.page = 2
						amenu.row = 1
					elseif pvehicle == true then
						amenu.page = 6
						amenu.row = 1
						trunk = true
						SetVehicleDoorOpen(amenu.vehicleID, 5, false, false)
					end
				elseif amenu.field == 3 then

				elseif amenu.field == 4 then

				elseif amenu.field == 5 then

				elseif amenu.field == 6 then

				elseif amenu.field == 7 then
					if amenu.player == true then
						TriggerEvent("giveAllKeys", amenu.playerServerID)
					else
						if GetClosestVeh() ~= false then
							ShowNotification("Plate: " .. GetVehicleNumberPlateText(GetClosestVeh()))
						end
					end
				end
			elseif amenu.show < 5 and amenu.show ~= 0 then
				if amenu.field == 0 then
					if amenu.player then
						ShowNotification("You identified " .. amenu.name .. " (" .. amenu.playerServerID .. ")")
					elseif amenu.occupied or amenu.backseat then
						ShowNotification("Plate: " .. GetVehicleNumberPlateText(GetClosestVeh()))
					else
						if GetVehicleEngineHealth(amenu.vehicleID) < 700.0 then
							if hasItem("Repair-Kit") then
								TriggerServerEvent("removeFromInventory", 0, 'Repair-Kit', 1)
								fixCarManual(amenu.vehicleID)
							elseif hasItem("Engine-Kit") then
								TriggerServerEvent("removeFromInventory", 0, 'Engine-Kit', 1)
								fixCarManual(amenu.vehicleID)
							else
								ShowNotification("~r~You need an ~b~Engine Kit~r~!")
							end
						else
							if hasItem("Body-Kit") then
								TriggerServerEvent("removeFromInventory", 0, 'Body-Kit', 1)
								fixCarManual(amenu.vehicleID)
							else
								ShowNotification("~r~You need a ~b~Body Kit~r~!")
							end
						end
					end
				elseif amenu.field == 1 then
					if amenu.player then
						TriggerServerEvent("interact:search", amenu.playerServerID)
					elseif amenu.occupied then
						ShowNotification("You identified " .. amenu.name .. " (" .. amenu.playerServerID .. ")")
					end
				elseif amenu.field == 2 then
					if amenu.player then
						TriggerServerEvent("interact:grab", amenu.playerServerID)
						changeStance("GRABBING")
						stance.grabbing = amenu.playerServerID
					end
				elseif amenu.field == 3 then
					if amenu.player then
						TriggerServerEvent("interact:seat", amenu.playerServerID)
					end
				elseif amenu.field == 6 then
					if amenu.player or amenu.occupied then
						DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
						amenu.input = 'ticket'
						keyboardOpen = true
					end
				elseif amenu.field == 7 then
					if amenu.player then
						TriggerServerEvent("interact:cuff", amenu.playerServerID)
					elseif amenu.occupied then
						TriggerServerEvent("interact:unseat", amenu.playerServerID)
					else
						ShowNotification("Plate: " .. GetVehicleNumberPlateText(GetClosestVeh()))
					end
				end
			end
		end

		if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
			if amenu.show == 1 then
				if amenu.page == 2 then
					if invItem.slot7 ~= 'Empty' then
						amenu.page = 3
					end
				elseif amenu.page == 3 then
					amenu.page = 2
				end
			end
		elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
			if amenu.show == 1 then
				if amenu.page == 2 then
					if invItem.slot7 ~= 'Empty' then
						amenu.page = 3
					end
				elseif amenu.page == 3 then
					amenu.page = 2
				end
			end
		elseif IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
			if amenu.row > 1 then
				amenu.row = amenu.row-1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
			if amenu.show == 1 then
				if amenu.page == 1 or amenu.page == 4 then
					if amenu.row < 2 then
						amenu.row = amenu.row+1
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					end
				elseif amenu.page == 2 then
					if amenu.row < 6 then
						amenu.row = amenu.row+1
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					end
				elseif amenu.page == 3 then
					if amenu.row < 4 then
						amenu.row = amenu.row+1
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					end
				end
			end
		elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
			if amenu.show == 1 then
				if amenu.page == 1 and keyboardOpen == false then
					if amenu.row == 1 then
						DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
						amenu.input = 'cash'
						keyboardOpen = true
					elseif amenu.row == 2 then
						local pCash = getBank('cash')
						if giveCashAmount > 0 and pCash >= giveCashAmount then
							TriggerServerEvent("deductMoney", 0, giveCashAmount)
							TriggerServerEvent("givePlayerCash", amenu.playerServerID, giveCashAmount)
							PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							giveCashAmount = 0
							amenu.page = 0
						end
					end
				elseif amenu.page == 2 then
					if amenu.row == 1 then
						if invItem.slot1 ~= 'Empty' then
							amenu.page = 4
							amenu.row = 1
							giveItem.item = invItem.slot1
							giveItem.amount = invAmount.slot1
						end
					elseif amenu.row == 2 then
						if invItem.slot2 ~= 'Empty' then
							amenu.page = 4
							amenu.row = 1
							giveItem.item = invItem.slot2
							giveItem.amount = invAmount.slot2
						end
					elseif amenu.row == 3 then
						if invItem.slot3 ~= 'Empty' then
							amenu.page = 4
							amenu.row = 1
							giveItem.item = invItem.slot3
							giveItem.amount = invAmount.slot3
						end
					elseif amenu.row == 4 then
						if invItem.slot4 ~= 'Empty' then
							amenu.page = 4
							amenu.row = 1
							giveItem.item = invItem.slot4
							giveItem.amount = invAmount.slot4
						end
					elseif amenu.row == 5 then
						if invItem.slot5 ~= 'Empty' then
							amenu.page = 4
							amenu.row = 1
							giveItem.item = invItem.slot5
							giveItem.amount = invAmount.slot5
						end
					elseif amenu.row == 6 then
						if invItem.slot6 ~= 'Empty' then
							amenu.page = 4
							amenu.row = 1
							giveItem.item = invItem.slot6
							giveItem.amount = invAmount.slot6
						end
					end
				elseif amenu.page == 3 then
					if amenu.row == 1 then
						if invItem.slot7 ~= 'Empty' then
							amenu.page = 4
							amenu.row = 1
							giveItem.item = invItem.slot7
							giveItem.amount = invAmount.slot7
						end
					elseif amenu.row == 2 then
						if invItem.slot8 ~= 'Empty' then
							amenu.page = 4
							amenu.row = 1
							giveItem.item = invItem.slot8
							giveItem.amount = invAmount.slot8
						end
					elseif amenu.row == 3 then
						if invItem.slot9 ~= 'Empty' then
							amenu.page = 4
							amenu.row = 1
							giveItem.item = invItem.slot9
							giveItem.amount = invAmount.slot9
						end
					elseif amenu.row == 4 then
						if invItem.slot10 ~= 'Empty' then
							amenu.page = 4
							amenu.row = 1
							giveItem.item = invItem.slot10
							giveItem.amount = invAmount.slot10
						end
					end
				elseif amenu.page == 4 then
					if amenu.row == 1 and keyboardOpen == false then
						DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
						amenu.input = 'item'
						keyboardOpen = true
					elseif amenu.row == 2 then
						if giveItemAmount > 0 then
							TriggerServerEvent("removeFromInventory", 0, giveItem.Item, giveItemAmount)
							TriggerServerEvent("addToPlayerInventory", amenu.playerServerID, giveItem.Item, giveItemAmount)
							PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							giveItemAmount = 0
							amenu.page = 0
						end
					end
				end
			end
		elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
			if keyboardOpen == false then
				if amenu.show == 1 then
					if amenu.page == 0 then
						PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						amenu.show = 0
						amenu.player = false
						amenu.playerID = 0
						amenu.vehicleID = 0
						phone('enable')
						SetPlayerControl(PlayerId(), 1, 0)
					elseif amenu.page == 1 or amenu.page == 2 or amenu.page == 3 or amenu.page == 6 then
						PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if amenu.player == false then
							SetVehicleDoorShut(amenu.vehicleID, 5, false)
							trunk = false
						end
						Wait(100)
						amenu.page = 0
						amenu.row = 1
					elseif amenu.page == 4 then
						PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						giveItemAmount = 0
						amenu.page = 2
					end
				elseif amenu.show < 5 and amenu.show ~= 0 then
					if amenu.page == 0 then
						PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						amenu.show = 0
						amenu.player = false
						amenu.occupied = false
						amenu.playerID = 0
						amenu.vehicleID = 0
						phone('enable')
						SetPlayerControl(PlayerId(), 1, 0)
					end
				end
			end
		end
	end
end)

-- ============================================== CLIENT EVENTS ==============================================



-- ============================================== HELPER FUNCTIONS ==============================================

function drawItems(num)
	if num == 1 then
		drawTxt(0.425, 0.37, 0.0, 0.0, 0.35, invItem.slot1 .. "",255,255,255,255)
		drawTxt(0.425, 0.41, 0.0, 0.0, 0.35, invItem.slot2 .. "",255,255,255,255)
		drawTxt(0.425, 0.45, 0.0, 0.0, 0.35, invItem.slot3 .. "",255,255,255,255)
		drawTxt(0.425, 0.49, 0.0, 0.0, 0.35, invItem.slot4 .. "",255,255,255,255)
		drawTxt(0.425, 0.53, 0.0, 0.0, 0.35, invItem.slot5 .. "",255,255,255,255)
		drawTxt(0.425, 0.57, 0.0, 0.0, 0.35, invItem.slot6 .. "",255,255,255,255)
	elseif num == 2 then
		drawTxt(0.425, 0.37, 0.0, 0.0, 0.35, invItem.slot7 .. "",255,255,255,255)
		drawTxt(0.425, 0.41, 0.0, 0.0, 0.35, invItem.slot8 .. "",255,255,255,255)
		drawTxt(0.425, 0.45, 0.0, 0.0, 0.35, invItem.slot9 .. "",255,255,255,255)
		drawTxt(0.425, 0.49, 0.0, 0.0, 0.35, invItem.slot10 .. "",255,255,255,255)
	end
end

function GetClosestPlayerPed()
	local myPed = GetPlayerPed(-1)
	local myPos = GetEntityCoords(myPed, 1)
	local frontOfPlayer = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 3.0, 0.0)
	local closePlayer = GetEntityInDirection(myPos, frontOfPlayer, 4)
	local closePlayerOnGround = GetEntityInDirectionOnGround(myPos, frontOfPlayer, 4)
	if DoesEntityExist(closePlayer) then
		if IsPedAPlayer(closePlayer) then
			return closePlayer
		else
			return false
		end
	elseif DoesEntityExist(closePlayerOnGround) then
		if IsPedAPlayer(closePlayerOnGround) then
			return closePlayerOnGround
		else
			return false
		end
	else
		return false
	end
end

function GetClosestVeh()
	local myPed = GetPlayerPed(-1)
	local myPos = GetEntityCoords(myPed, 1)
	local frontOfPlayer = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 3.0, 0.0)
	local closeVehicle = GetEntityInDirection(myPos, frontOfPlayer, 2)
	local closeVehicleOnGround = GetEntityInDirectionOnGround(myPos, frontOfPlayer, 2)
	if DoesEntityExist(closeVehicle) then
		return closeVehicle
	elseif DoesEntityExist(closeVehicleOnGround) then
		return closeVehicleOnGround
	else
		return false
	end
end

function GetLocalPlayerId(ped)
	local playerNum = 0
	for i=1, 64 do
		if NetworkIsPlayerActive(i) then
			if GetPlayerPed(i) == ped and GetPlayerPed(i) ~= GetPlayerPed(-1) then
				playerNum = i
			end
		end
	end
	return playerNum
end

RegisterNetEvent("interact:updateName")
AddEventHandler('interact:updateName', function(name)
	amenu.name = name
end)

function GetEntityInDirection(coordFrom, coordTo, flag)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, flag, GetPlayerPed(-1), 0)
    local _, _, _, _, entity = GetShapeTestResult(rayHandle)
    return entity
end

function GetEntityInDirectionOnGround(coordFrom, coordTo, flag)
	local bool, groundZ = GetGroundZFor_3dCoord(coordTo.x, coordTo.y, coordTo.z, 0)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, groundZ, flag, GetPlayerPed(-1), 0)
    local _, _, _, _, entity = GetShapeTestResult(rayHandle)
    return entity
end

function checkInteractionKeyboard()
	HideHudAndRadarThisFrame()
	if UpdateOnscreenKeyboard() == 3 then
		keyboardOpen = false
		amenu.input = 'none'
	elseif UpdateOnscreenKeyboard() == 1 then
		local inputText = GetOnscreenKeyboardResult()
		if string.len(inputText) > 0 then
			local amount = tonumber(inputText)
			if amount ~= nil then
				if amenu.input == 'item' then
					giveItemAmount = amount
				elseif amenu.input == 'cash' then
					giveCashAmount = amount
				elseif amenu.input == 'ticket' then
					TriggerServerEvent("ticketPlayer", amenu.playerServerID, amount)
				end
				keyboardOpen = false
				amenu.input = 'none'
			else
				DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8F", "", "", "", "", "", 64)
			end
		else
			DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
		end
	elseif UpdateOnscreenKeyboard() == 2 then
		keyboardOpen = false
		amenu.input = 'none'
	end
end

function fixCarManual(car)
	local vehCoords = GetOffsetFromEntityInWorldCoords(car, 0.0, 3.0, 0.0)
	SetVehicleDoorOpen(car, 4, false, false)

	SetEntityCoords(GetPlayerPed(-1), vehCoords.x, vehCoords.y, vehCoords.z-1.0, false, false, false, false)
	SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(car)-180.0)

	RequestAnimDict("mp_fm_intro_cut")
	while not HasAnimDictLoaded("mp_fm_intro_cut") do
		Citizen.Wait(0)
	end
	TaskPlayAnim(GetPlayerPed(-1), "mp_fm_intro_cut", "fixing_a_ped", 8.0, -8, -1, 17, 0, 0, 0, 0)

	Wait(10000)

	ClearPedTasks(GetPlayerPed(-1))

	SetVehicleDoorShut(car, 4, false)
	local gas = GetVehiclePetrolTankHealth(car)
	SetVehicleFixed(car)
	SetVehicleDeformationFixed(car)
	ResetVehicleWheels(car, true)
	SetVehicleEngineHealth(car, 1000.0)
	SetVehiclePetrolTankHealth(car, gas)
end

function drawBox(num)
	if num == 0 then
		DrawRect(0.87, 0.465, 0.16, 0.034, 0, 0, 0, 200)
		drawTxt(0.795, 0.445, 0.0, 0.0, 0.35, "Only two genders..",255,255,255,255)
	elseif num == 1 then
		DrawRect(0.87, 0.50, 0.16, 0.102, 0, 0, 0, 200)
		drawTxt(0.795, 0.45, 0.0, 0.0, 0.35, "0-20 Regular Males",255,255,255,255)
		drawTxt(0.795, 0.48, 0.0, 0.0, 0.35, "21-41 Regular Females",255,255,255,255)
		drawTxt(0.795, 0.51, 0.0, 0.0, 0.35, "42-45 Special",255,255,255,255)
	end
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
