--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local garageSpawning = { {-216.423, 6251.898, 31.490}, {188.268, 2786.999, 45.6103}, {-800.4753, 332.6402, 85.6085}, {820.2119, -921.4106, 25.86252}, {-667.9269, -2378.026, 13.97956}, {-3184.276, 1268.703, 12.449} }
local garageSpawnHeading = {45.0, 275.0, 180.0, 14.0, 50.0, 275.0}
local vehiclesInGarage = {slot1 = "none", slot2 = "none", slot3 = "none", slot4 = "none", slot5 = "none", slot6 = "none", slot7 = "none", slot8 = "none", slot9 = "none", slot10 = "none", plate1 = "null", plate2 = "null", plate3 = "null", plate4 = "null", plate5 = "null", plate6 = "null", plate7 = "null", plate8 = "null", plate9 = "null", plate10 = "null"}

function showGarageMenu()
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Garage",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	
	showNormalSelection()
	if amenu.page == 0 then 
		amenu.title = "SELECT VEHICLE (PAGE 1)"
		if vehiclesInGarage.slot1 == 'none' then
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "None",255,255,255,255)
		elseif vehiclesInGarage.slot1 ~= 'none' then
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "" .. firstToUpper(vehiclesInGarage.slot1),255,255,255,255)
			if vehiclesInGarage.slot2 ~= 'none' then
				drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "" .. firstToUpper(vehiclesInGarage.slot2),255,255,255,255)
				if vehiclesInGarage.slot3 ~= 'none' then
					drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "" .. firstToUpper(vehiclesInGarage.slot3),255,255,255,255)
					if vehiclesInGarage.slot4 ~= 'none' then
						drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "" .. firstToUpper(vehiclesInGarage.slot4),255,255,255,255)
						if vehiclesInGarage.slot5 ~= 'none' then
							drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "" .. firstToUpper(vehiclesInGarage.slot5),255,255,255,255)
						end
					end
				end
			end
		end
	elseif amenu.page == 1 then
		amenu.title = "SELECT VEHICLE (PAGE 2)"
		if vehiclesInGarage.slot6 == 'none' then
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "None",255,255,255,255)
		elseif vehiclesInGarage.slot6 ~= 'none' then
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "" .. firstToUpper(vehiclesInGarage.slot6),255,255,255,255)
			if vehiclesInGarage.slot7 ~= 'none' then
				drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "" .. firstToUpper(vehiclesInGarage.slot7),255,255,255,255)
				if vehiclesInGarage.slot8 ~= 'none' then
					drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "" .. firstToUpper(vehiclesInGarage.slot8),255,255,255,255)
					if vehiclesInGarage.slot9 ~= 'none' then
						drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "" .. firstToUpper(vehiclesInGarage.slot9),255,255,255,255)
						if vehiclesInGarage.slot10 ~= 'none' then
							drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "" .. firstToUpper(vehiclesInGarage.slot10),255,255,255,255)
						end
					end
				end
			end
		end
	end
	
	
	
	
	
	-- ============================== KEY PRESSES ==============================
	
	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		if amenu.row > 1 then 
			amenu.row = amenu.row-1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		local maxLines = 0
		if amenu.page == 0 then
			if vehiclesInGarage.slot5 ~= 'none' then
				maxLines = 5
			elseif vehiclesInGarage.slot4 ~= 'none' then
				maxLines = 4
			elseif vehiclesInGarage.slot3 ~= 'none' then
				maxLines = 3
			elseif vehiclesInGarage.slot2 ~= 'none' then
				maxLines = 2
			else
				maxLines = 1
			end
		elseif amenu.page == 1 then
			if vehiclesInGarage.slot10 ~= 'none' then
				maxLines = 5
			elseif vehiclesInGarage.slot9 ~= 'none' then
				maxLines = 4
			elseif vehiclesInGarage.slot8 ~= 'none' then
				maxLines = 3
			elseif vehiclesInGarage.slot7 ~= 'none' then
				maxLines = 2
			elseif vehiclesInGarage.slot6 ~= 'none' then
				maxLines = 1
			else
				maxLines = 0
			end
		end
		if amenu.row < maxLines then
			amenu.row = amenu.row+1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		if vehiclesInGarage.slot6 ~= 'none' then
			if amenu.page == 0 then amenu.page = 1 else amenu.page = 0 end
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
		if vehiclesInGarage.slot6 ~= 'none' then
			if amenu.page == 0 then amenu.page = 1 else amenu.page = 0 end
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 then
			if amenu.row == 1 then
				if vehiclesInGarage.slot1 ~= 'none' then
					TakeOutOfGarage(vehiclesInGarage.slot1, vehiclesInGarage.plate1)
				end
			elseif amenu.row == 2 then
				if vehiclesInGarage.slot2 ~= 'none' then
					TakeOutOfGarage(vehiclesInGarage.slot2, vehiclesInGarage.plate2)
				end
			elseif amenu.row == 3 then
				if vehiclesInGarage.slot3 ~= 'none' then
					TakeOutOfGarage(vehiclesInGarage.slot3, vehiclesInGarage.plate3)
				end
			elseif amenu.row == 4 then
				if vehiclesInGarage.slot4 ~= 'none' then
					TakeOutOfGarage(vehiclesInGarage.slot4, vehiclesInGarage.plate4)
				end
			elseif amenu.row == 5 then
				if vehiclesInGarage.slot5 ~= 'none' then
					TakeOutOfGarage(vehiclesInGarage.slot5, vehiclesInGarage.plate5)
				end
			end
		elseif amenu.page == 1 then
			if amenu.row == 1 then
				if vehiclesInGarage.slot6 ~= 'none' then
					TakeOutOfGarage(vehiclesInGarage.slot6, vehiclesInGarage.plate6)
				end
			elseif amenu.row == 2 then
				if vehiclesInGarage.slot7 ~= 'none' then
					TakeOutOfGarage(vehiclesInGarage.slot7, vehiclesInGarage.plate7)
				end
			elseif amenu.row == 3 then
				if vehiclesInGarage.slot8 ~= 'none' then
					TakeOutOfGarage(vehiclesInGarage.slot8, vehiclesInGarage.plate8)
				end
			elseif amenu.row == 4 then
				if vehiclesInGarage.slot9 ~= 'none' then
					TakeOutOfGarage(vehiclesInGarage.slot9, vehiclesInGarage.plate9)
				end
			elseif amenu.row == 5 then
				if vehiclesInGarage.slot10 ~= 'none' then
					TakeOutOfGarage(vehiclesInGarage.slot10, vehiclesInGarage.plate10)
				end
			end
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		amenu.show = 0
		phone('enable')
		TriggerEvent("AwesomeFreeze", false)
	end
end






	-- ============================== MENU FUNCTIONS ==============================

RegisterNetEvent("LoadGarage")
AddEventHandler("LoadGarage", function(veh1, plate1, veh2, plate2, veh3, plate3, veh4, plate4, veh5, plate5, veh6, plate6, veh7, plate7, veh8, plate8, veh9, plate9, veh10, plate10)
	if veh1 == 'none' then
		vehiclesInGarage.slot1 = 'none'
	else
		vehiclesInGarage.slot1 = veh1
		vehiclesInGarage.slot2 = veh2
		vehiclesInGarage.slot3 = veh3
		vehiclesInGarage.slot4 = veh4
		vehiclesInGarage.slot5 = veh5
		vehiclesInGarage.slot6 = veh6
		vehiclesInGarage.slot7 = veh7
		vehiclesInGarage.slot8 = veh8
		vehiclesInGarage.slot9 = veh9
		vehiclesInGarage.slot10 = veh10
		vehiclesInGarage.plate1 = plate1
		vehiclesInGarage.plate2 = plate2
		vehiclesInGarage.plate3 = plate3
		vehiclesInGarage.plate4 = plate4
		vehiclesInGarage.plate5 = plate5
		vehiclesInGarage.plate6 = plate6
		vehiclesInGarage.plate7 = plate7
		vehiclesInGarage.plate8 = plate8
		vehiclesInGarage.plate9 = plate9
		vehiclesInGarage.plate10 = plate10
	end
end)

function TakeOutOfGarage(vehicle, plate)
	if IsAnyVehicleNearPoint(garageSpawning[location][1], garageSpawning[location][2], garageSpawning[location][3], 5.0) == false then
		TriggerServerEvent("GetVehicleInfo", vehicle, plate)
		vehicleInfo.vehicle = vehicle
		Wait(500)
		amenu.show = 0
		phone('enable')
		TriggerEvent("AwesomeFreeze", false)
		local carHash = GetHashKey(vehicleInfo.vehicle)
		RequestModel(carHash)
		while not HasModelLoaded(carHash) do
			Citizen.Wait(0)
			drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
		end
		local newVeh = CreateVehicle(carHash, garageSpawning[location][1], garageSpawning[location][2], garageSpawning[location][3], garageSpawnHeading[location], true, false)
		SetVehicleOnGroundProperly(newVeh)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), newVeh, -1)
		for i = 0,24 do
			SetVehicleModKit(newVeh, 0)
			RemoveVehicleMod(newVeh, i)
		end
		while not DoesEntityExist(newVeh) do
			Citizen.Wait(0)
			drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
		end
		if vehicleInfo.vehicle == "rumpo" then SetVehicleLivery(newVeh, 1) end
		SetVehicleNumberPlateText(newVeh, "" .. vehicleInfo.plate)
		SetVehicleColours(newVeh, vehicleInfo.color1, vehicleInfo.color2)
		SetVehicleExtraColours(newVeh, vehicleInfo.color1, 4)
		if vehicleInfo.engine ~= -1 then SetVehicleMod(newVeh, 11, vehicleInfo.engine, false) end
		if vehicleInfo.trans ~= -1 then SetVehicleMod(newVeh, 13, vehicleInfo.trans, false) end
		if vehicleInfo.brakes ~= -1 then SetVehicleMod(newVeh, 12, vehicleInfo.brakes, false) end
		if vehicleInfo.tint ~= -1 then SetVehicleWindowTint(newVeh, vehicleInfo.tint) end
		if vehicleInfo.wheelType ~= 0 then SetVehicleWheelType(newVeh, vehicleInfo.wheelType) end
		if vehicleInfo.wheel ~= -1 then SetVehicleMod(newVeh, 23, vehicleInfo.wheel, false) end
		if vehicleInfo.spoiler ~= -1 then SetVehicleMod(newVeh, 0, vehicleInfo.spoiler, false) end
		if vehicleInfo.fbump ~= -1 then SetVehicleMod(newVeh, 1, vehicleInfo.fbump, false) end
		if vehicleInfo.rbump ~= -1 then SetVehicleMod(newVeh, 2, vehicleInfo.rbump, false) end
		if vehicleInfo.skirt ~= -1 then SetVehicleMod(newVeh, 3, vehicleInfo.skirt, false) end
		if vehicleInfo.grille ~= -1 then SetVehicleMod(newVeh, 6, vehicleInfo.grille, false) end
		if vehicleInfo.hood ~= -1 then SetVehicleMod(newVeh, 7, vehicleInfo.hood, false) end
		if vehicleInfo.roof ~= -1 then SetVehicleMod(newVeh, 10, vehicleInfo.roof, false) end
		SetEntityAsMissionEntity(newVeh, true, true)
		TriggerEvent("addKey", plate)
		TriggerServerEvent("RemoveFromGarage", plate)
	else
		ShowNotification("~r~Spawn area is full!")
	end
end