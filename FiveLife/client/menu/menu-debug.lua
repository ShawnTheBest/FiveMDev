--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local propNum = {1, 1, 1, 1, 1, 1}
local weedPlants = {"prop_weed_01", "prop_weed_02", "bkr_prop_weed_01_small_01b", "bkr_prop_weed_med_01b", "bkr_prop_weed_lrg_01b", "bkr_prop_weed_bud_01a", "bkr_prop_weed_bud_01b", "bkr_prop_weed_bud_02a", "bkr_prop_weed_bud_02b"}
local weedItems = {"prop_weed_block_01", "prop_weed_pallet", "bkr_prop_weed_smallbag_01a", "bkr_prop_weed_bigbag_01a", "bkr_prop_weed_table_01a"}
local methMats = {"bkr_prop_meth_acetone", "bkr_prop_meth_ammonia", "bkr_prop_meth_hcacid", "bkr_prop_meth_lithium", "bkr_prop_meth_phosphorus", "bkr_prop_meth_pseudoephedrine", "bkr_prop_meth_sacid", "bkr_prop_meth_sodium", "bkr_prop_meth_toulene"}
local methItems = {"bkr_prop_meth_smallbag_01a", "bkr_prop_meth_bigbag_01a", "bkr_prop_meth_pallet_01a", "bkr_prop_meth_table01a"}
local crops = {"prop_bush_grape_01", "prop_tree_birch_05", "prop_veg_crop_orange", "prop_veg_crop_02", "prop_veg_crop_03_cab", "prop_veg_crop_04", "prop_veg_crop_05", "prop_veg_crop_06", "prop_veg_crop_tr_01", "prop_veg_crop_tr_02"}
local randomProps = {"prop_lev_crate_01", "prop_ballistic_shield", "prop_riot_shield", "prop_mp_cone_02", "prop_mp_barrier_01", "prop_mp_barrier_02b"}
local spawnedObject = 0
local shield = 0

local unitNum = 1
local unitNum2 = 1
local unitNum3 = 1
local mousePressed = "NO"
local mouseReleased = "NO"
local mouseJustPressed = "NO"
local currentObject = "Base"
local cObject = {}
cObject["Base"] = {} -- Title - 0.43, 0.298, 0.4
cObject["Base"].locX = 0.5
cObject["Base"].locY = 0.505
cObject["Base"].sizeX = 0.15
cObject["Base"].sizeY = 0.41
cObject["Button"] = {}
cObject["Button"].locX = 0.5
cObject["Button"].locY = 0.36 -- 0.40, 0.44, 0.48, 0.52, 0.56, 0.60, 0.64, 0.68 etc
cObject["Button"].sizeX = 0.15
cObject["Button"].sizeY = 0.3
cObject["Text"] = {}
cObject["Text"].locX = 0.44
cObject["Text"].locY = 0.34 --0.38, 0.42, etc
cObject["Text"].sizeX = 0.35
cObject["Text"].sizeY = 0.4

function showDebugMenu()
	local myPed = GetPlayerPed(-1)
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Debug Mode",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)

	showNormalSelection()
	if amenu.page == 0 then
		amenu.title = "SELECT JOB"
		menuItems("Player", "Vehicle", "World", "Feature Test", "Unit Info", "Test Info")
	elseif amenu.page == 1 then
		amenu.title = "PLAYER"
		local pCoord = GetEntityCoords(myPed, true)
		menuItems("Heading: " .. math.floor(GetEntityHeading(myPed)), "Pos X: " .. math.floor(pCoord.x), "Pos Y: " .. math.floor(pCoord.y), "Pos Z: " .. math.floor(pCoord.z), "Blood: " ..  math.floor(myPlayer.blood), "Bleed Rate: " .. myPlayer.bleedRate)
	elseif amenu.page == 2 then
		amenu.title = "VEHICLE"
		if GetVehiclePedIsIn(myPed, false) ~= nil then
			local veh = GetVehiclePedIsIn(myPed, false)
			menuItems("Engine: " .. math.floor(GetVehicleEngineHealth(veh)), "FX_Steering: " .. GetVehicleSteeringAngle(veh), "FX_Fuel: " .. math.floor(GetVehicleFuelLevel(veh)), "Petrol: " .. math.floor(GetVehiclePetrolTankHealth(veh)), "FX_Oil: " .. math.floor(GetVehicleOilLevel(veh)), "nil")
		end
	elseif amenu.page == 3 then
		amenu.title = "WORLD"
		menuItems("Gas Total: " .. totalFuelLevel, "MousePressed: " .. mousePressed, "MouseReleaseed: " .. mouseReleased, "JustPressed: " .. mouseJustPressed, "Spawn Objects", "Test Shield")
	elseif amenu.page == 4 then
		amenu.title = "FEATURE TEST"
		menuItems("Give Key", "Hotwire", "PTFX1", "InvincibleOn", "InvincibleOff", "Update Player")
	elseif amenu.page == 5 then
		amenu.title = "UNIT INFO"
		menuItems("PoliceCount: " .. policeCount, "MedicCount: " .. medicCount, "View SASP Info: " .. unitNum, "View LSPD Info: " .. unitNum2, "View EMS Info: " .. unitNum3, "nil")
	elseif amenu.page == 6 then
		amenu.title = "TEST INFO"
		menuItems("< " .. currentObject .. " >" , "PosX: " .. cObject[currentObject].locX, "PosY: " .. cObject[currentObject].locY, "SizeX: " .. cObject[currentObject].sizeX, "SizeY: " .. cObject[currentObject].sizeY, "nil")
		RequestStreamedTextureDict('interact') while not HasStreamedTextureDictLoaded('interact') do Citizen.Wait(0) end
		DrawSprite("interact", "bgd_0", cObject["Base"].locX, cObject["Base"].locY, cObject["Base"].sizeX, cObject["Base"].sizeY, 0.0, 255, 255, 255, 255)
		DrawSprite("interact", "button_orange", cObject["Button"].locX, cObject["Button"].locY, cObject["Button"].sizeX, cObject["Button"].sizeY, 0.0, 255, 255, 255, 255)
		drawTxt(cObject["Text"].locX, cObject["Text"].locY, 0.0, 0.0, cObject["Text"].sizeX, "Test Text",255,255,255,255)
	elseif amenu.page == 7 then
		menuItems("< " .. weedPlants[propNum[1]] .. " >", "< " .. weedItems[propNum[2]] .. " >", "< " .. methMats[propNum[3]] .. " >", "< " .. methItems[propNum[4]] .. " >", "< " .. crops[propNum[5]] .. " >", "< " .. randomProps[propNum[6]] .. " >")
	end

	-- ============================== KEY PRESSES ==============================

	if IsControlJustPressed(1, 24) then
		mouseJustPressed = "YES"
	end

	if IsControlPressed(1, 24) then
		mousePressed = "YES"
		mouseReleased = "NO"
	else
		mousePressed = "NO"
	end

	if IsControlJustReleased(1, 24) or IsDisabledControlJustReleased(1, 24) then
		mouseReleased = "YES"
		mouseJustPressed = "NO"
	end

	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		if amenu.row > 1 then
			amenu.row = amenu.row-1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		if amenu.row < amenu.maxRow then
			amenu.row = amenu.row+1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
		if amenu.page == 5 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 3 then
				unitNum = unitNum + 1
			elseif amenu.row == 4 then
				unitNum2 = unitNum2 + 1
			elseif amenu.row == 5 then
				unitNum3 = unitNum3 + 1
			end
		elseif amenu.page == 6 then
			if amenu.row == 1 then -- Object
				if currentObject == "Base" then
					currentObject = "Button"
				elseif currentObject == "Button" then
					currentObject = "Text"
				else
					currentObject = "Base"
				end
			elseif amenu.row == 2 then -- PosX
				cObject[currentObject].locX = cObject[currentObject].locX + 0.005
			elseif amenu.row == 3 then -- PosY
				cObject[currentObject].locY = cObject[currentObject].locY + 0.005
			elseif amenu.row == 4 then -- SizeX
				cObject[currentObject].sizeX = cObject[currentObject].sizeX + 0.01
			elseif amenu.row == 5 then -- SizeY
				cObject[currentObject].sizeY = cObject[currentObject].sizeY + 0.01
			end
		elseif amenu.page == 7 then
			if amenu.row == 1 then
				if propNum[amenu.row] < #weedPlants then propNum[amenu.row] = propNum[amenu.row] + 1 end
			elseif amenu.row == 2 then
				if propNum[amenu.row] < #weedItems then propNum[amenu.row] = propNum[amenu.row] + 1 end
			elseif amenu.row == 3 then
				if propNum[amenu.row] < #methMats then propNum[amenu.row] = propNum[amenu.row] + 1 end
			elseif amenu.row == 4 then
				if propNum[amenu.row] < #methItems then propNum[amenu.row] = propNum[amenu.row] + 1 end
			elseif amenu.row == 5 then
				if propNum[amenu.row] < #crops then propNum[amenu.row] = propNum[amenu.row] + 1 end
			elseif amenu.row == 6 then
				if propNum[amenu.row] < #randomProps then propNum[amenu.row] = propNum[amenu.row] + 1 end
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		if amenu.page == 5 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 3 then
				unitNum = unitNum - 1
			elseif amenu.row == 4 then
				unitNum2 = unitNum2 - 1
			elseif amenu.row == 5 then
				unitNum3 = unitNum3 - 1
			end
		elseif amenu.page == 6 then
			if amenu.row == 1 then
				if currentObject == "Text" then
					currentObject = "Button"
				elseif currentObject == "Button" then
					currentObject = "Base"
				else
					currentObject = "Text"
				end
			elseif amenu.row == 2 then -- PosX
				cObject[currentObject].locX = cObject[currentObject].locX - 0.005
			elseif amenu.row == 3 then -- PosY
				cObject[currentObject].locY = cObject[currentObject].locY - 0.005
			elseif amenu.row == 4 then -- SizeX
				cObject[currentObject].sizeX = cObject[currentObject].sizeX - 0.01
			elseif amenu.row == 5 then -- SizeY
				cObject[currentObject].sizeY = cObject[currentObject].sizeY - 0.01
			end
		elseif amenu.page == 7 then
			if propNum[amenu.row] > 1 then propNum[amenu.row] = propNum[amenu.row] - 1 end
		end
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		if amenu.page == 0 then
			amenu.page = amenu.row
			amenu.row = 1
		elseif amenu.page == 1 then
			if amenu.row == 5 then
				myPlayer.blood = 100.0
			elseif amenu.row == 6 then
				myPlayer.bleedRate = 0.0
			end
		elseif amenu.page == 3 then
			if amenu.row == 5 then
				amenu.row = 1
				amenu.page = 7
			elseif amenu.row == 6 then
				equipShield("prop_ballistic_shield")
			end
		elseif amenu.page == 4 then
			if amenu.row == 1 then
				if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					local plate = GetVehicleNumberPlateText(vehicle)
					TriggerEvent("addKey", plate)
				end
			elseif amenu.row == 2 then
				if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					SetVehicleModKit(vehicle, 0)
					SetVehicleMod(vehicle, 16, 0, false)
				end
			elseif amenu.row == 3 then
				local coord = GetEntityCoords(GetPlayerPed(-1))
				RequestNamedPtfxAsset("core")
				SetPtfxAssetNextCall("core")
				StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", coord.x, coord.y, coord.z, 0.0, 0.0, 0.0, 0.5, false, false, false, false)
			elseif amenu.row == 4 then
				SetEntityInvincible(GetPlayerPed(-1), true)
			elseif amenu.row == 5 then
				SetEntityInvincible(GetPlayerPed(-1), false)
			elseif amenu.row == 6 then
				TriggerEvent("sync:updatePlayer")
			end
		elseif amenu.page == 5 then
			if amenu.row == 3 then
				if saspUnits[unitNum] ~= nil then
					ShowNotification("Name: " .. saspUnits[unitNum].Name .. " (" .. saspUnits[unitNum].ID .. ")")
				else
					ShowNotification("~r~Invalid Unit ID")
				end
			elseif amenu.row == 4 then
				if lspdUnits[unitNum2] ~= nil then
					ShowNotification("Name: " .. lspdUnits[unitNum2].Name .. " (" .. lspdUnits[unitNum2].ID .. ")")
				else
					ShowNotification("~r~Invalid Unit ID")
				end
			elseif amenu.row == 5 then
				if medicUnits[unitNum2] ~= nil then
					ShowNotification("Name: " .. medicUnits[unitNum2].Name .. " (" .. medicUnits[unitNum2].ID .. ")")
				else
					ShowNotification("~r~Invalid Unit ID")
				end
			end
		elseif amenu.page == 6 then
			if amenu.row == 1 then
				RequestAnimDict("combat@drag_ped@")
				TaskPlayAnim(GetPlayerPed(-1), "combat@drag_ped", "injured_pickup_back_ped", 8.0, 0.0, -1, 9, 0.0, false, false, false)
			end
		elseif amenu.page == 7 then
			if amenu.row == 1 then
				spawnTestProp(weedPlants[propNum[amenu.row]])
			elseif amenu.row == 2 then
				spawnTestProp(weedItems[propNum[amenu.row]])
			elseif amenu.row == 3 then
				spawnTestProp(methMats[propNum[amenu.row]])
			elseif amenu.row == 4 then
				spawnTestProp(methItems[propNum[amenu.row]])
			elseif amenu.row == 5 then
				spawnTestProp(crops[propNum[amenu.row]])
			elseif amenu.row == 6 then
				spawnTestProp(randomProps[propNum[amenu.row]])
			end
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 then
			amenu.show = 0
			amenu.row = 1
			phone('enable')
		elseif amenu.page <= 6 then
			amenu.row = amenu.page
			amenu.page = 0
		elseif amenu.page == 7 then
			amenu.row = 5
			amenu.page = 3
		end
	end
end


function spawnTestProp(objName)
	local hash = GetHashKey(objName)
	local coords = GetEntityCoords(GetPlayerPed(-1), true)
	local forward = GetEntityForwardX(GetPlayerPed(-1))*1.3
	local forward2 = GetEntityForwardY(GetPlayerPed(-1))*1.3
	RequestModel(hash) while not HasModelLoaded(hash) do Wait(1) end

	if spawnedObject ~= 0 then
		SetEntityAsMissionEntity(spawnedObject, true, true)
		DeleteObject(spawnedObject)
	end
	spawnedObject = CreateObject(hash, coords.x+forward, coords.y+forward2, coords.z-1, true, true, false)
	PlaceObjectOnGroundProperly(spawnedObject)
end

function equipShield(shieldType)
	if shield ~= 0 then
		SetEntityAsMissionEntity(shield, true, true)
		DeleteObject(shield)
		shield = 0
	else
		local hash = GetHashKey(shieldType)
		local coords = GetEntityCoords(GetPlayerPed(-1), true)
		local forward = GetEntityForwardX(GetPlayerPed(-1))*1.3
		local forward2 = GetEntityForwardY(GetPlayerPed(-1))*1.3
		RequestModel(hash) while not HasModelLoaded(hash) do Wait(1) end
		shield = CreateObject(hash, coords.x+forward, coords.y+forward2, coords.z-1, true, true, false)
		while not DoesEntityExist(shield) do Wait(1) end
		AttachEntityToEntity(shield, GetPlayerPed(-1), 11816, 0.15, 0.45, 180.0, 0.0, 0.0, 0.0, false, true, false, false, 2, true)
	end
end
