--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local civPoliceBlips = { {-447.555, 6013.448, 31.716}, {1853.461, 3687.989, 34.267}, {440.9615, -981.102, 30.689} }
local hospitalBlips = { {294.968, -1447.979, 29.966}, {298.753, -584.458, 43.261} , {-448.957, -340.778, 34.502} , {1827.978, 3692.274, 34.223} , {-245.9079, 6330.465, 32.42619}}
local policeBlips = { {-448.117, 6008.141, 31.716}, {1848.686, 3689.895, 34.267}, {451.211, -992.155, 30.689} }
local radar = {shown = false, lastSpeed = 0, lockedSpeed = 0}
local newsReports = {}
local cabReports = {}
local towReports = {}
local policeLS = false
local policeSandy = false
local policePaleto = false
local hospital = false
local localJobLevel = 0
local cleared = false
local scene = {x = 0.0, y = 0.0, z = 0.0}
local callLocation = "San Andreas"
local placedSpikes = {}
local spikeCycle = 1
local lastPlate = "NONE"
local plateSub = "N"
local checkScene = false
local onScene = false
jailSentence = 0
local k9 = {}
k9.dog = nil
k9.inVehicle = false
k9.follow = false
k9.searching = false

RegisterNetEvent('updateJailTime')
AddEventHandler('updateJailTime', function(length)
	if length == 0 then
		jailSentence = length
		changeSituation("ALIVE")
		TriggerEvent("TogglePhone", 'enable')
		updateClothes()
		SetEntityCoords(GetPlayerPed(-1), 1847.22, 2586.20, 45.67)
	elseif length == 'OUT' then
		jailSentence = 0
		changeSituation("ALIVE")
		TriggerEvent("TogglePhone", 'enable')
		if GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01") then
			TriggerEvent("LoadClothing", 5, 0, 3, 7, 0, 0, 5, 0, 0, 0, 15, 0, 0, 0, 0, 0, 5, 0, 12, 0, 0, 0, 0, 0)
		elseif GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01") then
			TriggerEvent("LoadClothing", 0, 0, 3, 15, 0, 0, 5, 1, 0, 0, 14, 0, 0, 0, 0, 0, 23, 0, 58, 0, 0, 0, 0, 0)
		end
		RemoveAllPedWeapons(GetPlayerPed(-1), true)
		TriggerServerEvent("takeAllWeapons", 0)
		SetEntityCoords(GetPlayerPed(-1), 1664.6, 2605.3, 45.5)
	end
end)

RegisterNetEvent('checkOnScene')
AddEventHandler('checkOnScene', function(x, y, z, location)
	checkScene = true
	scene.x = x
	scene.y = y
	scene.z = z
	callLocation = location
end)

Citizen.CreateThread(function()
	TriggerServerEvent("getAllCurrentUnits")
	while true do
		Citizen.Wait(1)
		if localJobLevel ~= 0 then
			--checkEmergencyRange()
			AddAmmoToPed(GetPlayerPed(-1), GetHashKey('weapon_fireextinguisher'), 1000)

			if onDuty ~= 0 and onDuty < 5 then
				if checkScene then
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), scene.x, scene.y, scene.z, true) < 30 then
						TriggerServerEvent("updateUnitInfo", "status", "10-23")
						TriggerServerEvent("updateUnitInfo", "location", callLocation)
						onScene = true
						checkScene = false
					end
				elseif onScene then
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), scene.x, scene.y, scene.z, true) > 100 then
						TriggerServerEvent("updateUnitInfo", "status", "10-8")
						TriggerServerEvent("updateUnitInfo", "notes", "CLEAR")
						scene.x = 0.0
						scene.y = 0.0
						scene.z = 0.0
						onScene = false
					end
				end
			end
			if policeLS or policeSandy or policePaleto or hospital then
				if onDuty ~= 0 then
					ShowTip('Press ~INPUT_ENTER~ to go off duty.')
					if IsControlJustPressed(1, 23) or IsDisabledControlJustPressed(1, 23) then -- F
						if onDuty < 4 then

						else

						end
					end
				else
					ShowTip('Press ~INPUT_ENTER~ to go on duty.')
					if IsControlJustPressed(1, 23) or IsDisabledControlJustPressed(1, 23) then -- F
						if localJobLevel < 4 then
							if policeLS then
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								SetEntityCoords(GetPlayerPed(-1), 451.211, -992.155, 29.8)
								SetEntityHeading(GetPlayerPed(-1), 325.0)
								-- TriggerEvent("openPOLICEmenu", 1)
								onDuty = localJobLevel
							elseif policeSandy then
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								SetEntityCoords(GetPlayerPed(-1), 457.751, -988.928, 29.8)
								SetEntityHeading(GetPlayerPed(-1), 180.0)
								-- TriggerEvent("openPOLICEmenu", 2)
								onDuty = localJobLevel
							elseif policePaleto then
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								SetEntityCoords(GetPlayerPed(-1), 457.849, -992.605, 29.8)
								SetEntityHeading(GetPlayerPed(-1), 0.0)
								-- TriggerEvent("openPOLICEmenu", 3)
								onDuty = localJobLevel
							end
						else
							if hospital then
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								-- TriggerEvent("openEMSmenu")
							end
						end
					end
				end
			end
		else
			checkFineRange()
			if policeLS or policeSandy or policePaleto then
				ShowTip('Press ~INPUT_ENTER~ to view fines.')
				if IsControlJustPressed(1, 23) or IsDisabledControlJustPressed(1, 23) then -- F

				end
			elseif hospital then

			end
		end

		if situation.type == "JAILED" then
			drawTxt(0.85, 0.95, 0.0, 0.0, 0.35, "Jail Time: " .. jailSentence .. " minutes",255,255,255,255)
			local pCoords = GetEntityCoords(GetPlayerPed(-1), true)
			if pCoords.z > 48.0 then SetEntityCoords(GetPlayerPed(-1), pCoords.x, pCoords.y, 45.5) end
			if pCoords.x < 1619.5 then SetEntityCoords(GetPlayerPed(-1), 1620.0, pCoords.y, pCoords.z-1.0) end
			if pCoords.y > 2565.3 then SetEntityCoords(GetPlayerPed(-1), pCoords.x, 2565.0, pCoords.z-1.0) end
			if GetDistanceBetweenCoords(pCoords, 1642.18, 2527.43, 45.5649, true) > 150 then
				SetEntityCoords(GetPlayerPed(-1), 1642.18, 2527.43, 45.5649)
			end
		end

		if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
			local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			DisableControlAction(1, 73, 1)
			if IsControlJustPressed(1, 73) or IsDisabledControlJustPressed(1, 73) then -- X
				if not IsControlPressed(0, 36) and not IsDisabledControlPressed(0, 36) then -- CTRL
					if GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1) or GetPedInVehicleSeat(veh, 0) == GetPlayerPed(-1) then
						if GetVehicleClass(veh) ~= 15 then
							if radar.shown then radar.shown = false else radar.shown = true end
						end
					end
				end
			end
		else
			if radar.shown then
				radar.shown = false
			end
		end

		if radar.shown then
			DisableControlAction(0, 76, 1)
			RequestStreamedTextureDict("police", true)
			while not HasStreamedTextureDictLoaded("police") do
				Citizen.Wait(1)
			end
			DrawSprite("police", "police_radar_base", 0.7,0.92, 0.20,0.12, 0.0, 255, 255, 255, 255)
			local speed = 0
			if GetRadarVeh() ~= false then
				local target = GetRadarVeh()
				if GetEntitySpeed(target) > 0 then speed = (GetEntitySpeed(target)*2.236936) end
				radar.lastSpeed = round(speed)
				lastPlate = string.upper(GetVehicleNumberPlateText(target))
				plateSub = lastPlate:sub(1,1)
			end
			if IsControlJustPressed(1, 76) or IsDisabledControlJustPressed(1, 76) then -- SPACE
				radar.lockedSpeed = radar.lastSpeed
			end

			drawRadarText(0.665, 0.875, 1.2, "" .. radar.lastSpeed, 255, 0, 0, 255, 1)
			drawRadarText(0.745, 0.88, 0.8, "" .. radar.lockedSpeed, 255, 250, 0, 255, 1)

			if plateSub == 'P' then
				drawTxt(0.625, 0.825, 0.0, 0.0, 0.35, "Plate: " .. lastPlate, 209, 151, 16, 255)
			elseif plateSub == 'G' then
				drawTxt(0.625, 0.825, 0.0, 0.0, 0.35, "Plate: " .. lastPlate, 18, 201, 33, 255)
			else
				drawTxt(0.625, 0.825, 0.0, 0.0, 0.35, "Plate: " .. lastPlate, 255, 255, 255, 255)
			end
		end
	end
end)

function GetRadarVeh()
	local myPed = GetPlayerPed(-1)
	local myVeh = GetVehiclePedIsIn(myPed, false)
	local myPos = GetEntityCoords(myVeh, 1)
	local frontOfPlayer = GetOffsetFromEntityInWorldCoords(myVeh, 0.0, 45.0, 0.0)
	local closeVehicle = Radar_GetVehicleInDirection(myPos, frontOfPlayer, 2)
	if DoesEntityExist(closeVehicle) then
		return closeVehicle
	else
		return false
	end
end

function Radar_GetVehicleInDirection(coordFrom, coordTo, flag)
	local bool, zCoord = GetGroundZFor_3dCoord(coordTo.x, coordTo.y, coordTo.z+30.0, 0)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, zCoord+0.8, flag, GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

RegisterNetEvent('unseatPlayer')
AddEventHandler('unseatPlayer', function()
	ClearPedTasksImmediately(GetPlayerPed(-1))
	if situation.type == "CUFFED" then
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HANDCUFFS"), 1, false, true)
		SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_HANDCUFFS"), true)
	end
end)

RegisterNetEvent('forceEnter')
AddEventHandler('forceEnter', function()
	local suspectPos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
    local rayHandle = StartShapeTestRay(suspectPos.x, suspectPos.y, suspectPos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, vehicleHandle = GetShapeTestResult(rayHandle)
    if vehicleHandle ~= nil then
    	if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
    		if IsVehicleSeatFree(vehicleHandle, 1) then
        		SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
        	elseif IsVehicleSeatFree(vehicleHandle, 2) then
        		SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 2)
        	end
        end
    end
end)

RegisterNetEvent('jailPlayer')
AddEventHandler('jailPlayer', function(length)
	local myPed = GetPlayerPed(-1)
	jailSentence = length
	updateFace()
	--updateClothes()
	changeSituation("JAILED")
	TriggerServerEvent("removeIllegalItems", 0)
	SetEntityCoords(myPed, 1642.18, 2527.43, 45.5649)
	if GetEntityModel(myPed) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(myPed, 3, 5, 0, 0) -- Arms
		SetPedComponentVariation(myPed, 8, 15, 0, 0) -- Undershirt
		SetPedComponentVariation(myPed, 11, 5, 0, 0) -- Overshirt
		SetPedComponentVariation(myPed, 4, 3, 7, 0) -- Legs
		SetPedComponentVariation(myPed, 6, 5, 0, 0) -- Shoes
	elseif GetEntityModel(myPed) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(myPed, 3, 0, 0, 0) -- Arms
		SetPedComponentVariation(myPed, 8, 14, 0, 0) -- Undershirt
		SetPedComponentVariation(myPed, 11, 23, 0, 0) -- Overshirt
		SetPedComponentVariation(myPed, 4, 3, 15, 0) -- Legs
		SetPedComponentVariation(myPed, 6, 5, 1, 0) -- Shoes
	end
	ClearPedProp(myPed, 0)
end)

RegisterNetEvent("setSpikes")
AddEventHandler("setSpikes", function()
	Citizen.CreateThread(function()
		if onDuty ~= 0 then
			if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
				local coords = GetEntityCoords(GetPlayerPed(-1), true)
				local spike = GetHashKey("P_ld_stinger_s")
				local slot = 0
				RequestModel(spike) while not HasModelLoaded(spike) do Citizen.Wait(1) end

				for i=1, 3 do
					if placedSpikes[i] == nil then
						slot = i
					elseif not DoesEntityExist(placedSpikes[i]) then
						placedSpikes[i] = nil
						slot = i
					end
				end

				local forward = GetEntityForwardX(GetPlayerPed(-1))*1.3
				local forward2 = GetEntityForwardY(GetPlayerPed(-1))*1.3
				local object = CreateObject(spike, coords.x+forward, coords.y+forward2, coords.z-1, true, true, false)
				local heading = GetEntityHeading(GetPlayerPed(-1))
				if heading > 90.0 then heading = heading -90.0 else heading = heading + 90.0 end
				SetEntityHeading(object, heading)
				PlaceObjectOnGroundProperly(object)

				if slot == 0 then
					removeSpike(placedSpikes[spikeCycle], 1.0)
					placedSpikes[spikeCycle] = object
					if spikeCycle < 3 then spikeCycle = spikeCycle + 1 else spikeCycle = 1 end
				else
					placedSpikes[slot] = object
				end
			else
				-- Trying from in a vehicle
			end
		else
			-- Not on duty
		end
	end)
end)

RegisterNetEvent("removeSpikes")
AddEventHandler("removeSpikes", function(amount)
	if amount == "ALL" then
		for i=1, 3 do
			if placedSpikes[i] ~= nil then
				if DoesEntityExist(placedSpikes[i]) then
					removeSpike(placedSpikes[i], 1.0)
				end
				placedSpikes[i] = nil
			end
		end
	else
		removeSpike(0, 2.0)
	end
end)



RegisterNetEvent("K9:Spawn")
AddEventHandler("K9:Spawn", function()
	Citizen.CreateThread(function()
		if onDuty ~= 0 then
			if k9.dog == nil then
				local dogmodel = GetHashKey("A_C_Rottweiler")
				RequestModel(dogmodel)
				while not HasModelLoaded(dogmodel) do
					RequestModel(dogmodel)
					Citizen.Wait(100)
				end

				local pPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 2.0, 0.0)
				local pHead = GetEntityHeading(GetPlayerPed(-1))
				k9.dog = CreatePed(28, dogmodel, pPos.x, pPos.y, pPos.z, pHead, 1, 1)
				GiveWeaponToPed(k9.dog, GetHashKey("WEAPON_ANIMAL"), 200, true, true)
				SetBlockingOfNonTemporaryEvents(k9.dog, true, false)
				SetPedFleeAttributes(k9.dog, 0, 0)
				SetPedCombatAttributes(k9.dog, 3, true)
				SetPedCombatAttributes(k9.dog, 5, true)
				SetPedCombatAttributes(k9.dog, 46, true)
				SetEntityHealth(k9.dog, 400)
				SetPedArmour(k9.dog, 200)
				SetPedMoveRateOverride(k9.dog, 3.0)
			end
		else
			ShowNotification("~r~You are not on duty!")
		end
	end)
end)

RegisterNetEvent("K9:Remove")
AddEventHandler("K9:Remove", function()
	if k9.dog ~= nil then
		SetEntityAsMissionEntity(k9.dog, true, true)
		DeleteEntity(k9.dog)
		k9.follow = false
		k9.inVehicle = false
		k9.searching = false
		k9.dog = nil
	end
end)

RegisterNetEvent("K9:Heal")
AddEventHandler("K9:Heal", function()
	if k9.dog ~= nil then
		SetEntityHealth(k9.dog, 400)
		SetPedArmour(k9.dog, 200)
	end
end)

RegisterNetEvent("K9:EnterVehicle")
AddEventHandler("K9:EnterVehicle", function(veh)
	if k9.dog ~= nil then
		k9EnterVehicle(veh)
	end
end)

RegisterNetEvent("K9:ExitVehicle")
AddEventHandler("K9:ExitVehicle", function(speed)
	if k9.dog ~= nil then
		k9ExitVehicle(speed)
	end
end)

RegisterNetEvent("K9:Attack")
AddEventHandler("K9:Attack", function(types, ped)
	if k9.dog ~= nil then
		k9Attack(types, ped)
	end
end)

RegisterNetEvent("K9:SearchVehicle")
AddEventHandler("K9:SearchVehicle", function(veh)
	if k9.dog ~= nil then
		k9SearchVehicle(veh)
	end
end)

RegisterNetEvent("K9:Follow")
AddEventHandler("K9:Follow", function(toggle)
	if k9.dog ~= nil then
		k9Follow(toggle)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if onDuty ~= 0 and onDuty < 4 then
			if IsControlPressed(1, 21) or IsDisabledControlPressed(1, 21) then -- SHIFT
				DisableControlAction(0, 26, 1)
				if IsControlJustPressed(0, 26) or IsDisabledControlJustPressed(0, 26) then -- C
					if k9.dog ~= nil then
						if k9.inVehicle then
							TriggerServerEvent("K9:ExitVehicle", "QUICK")
						end
						TriggerServerEvent("K9:Attack", "PANIC", 0)
					end
				end
				if IsControlJustPressed(1, 73) or IsDisabledControlJustPressed(1, 73) then -- X
					if k9.dog ~= nil then
						if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
							if k9.inVehicle then
								ShowNotification("~y~*VORAUS*")
								TriggerServerEvent("K9:ExitVehicle", "NORMAL")
							else
								ShowNotification("~y~*GEH REIN*")
								TriggerServerEvent("K9:EnterVehicle", GetVehiclePedIsIn(GetPlayerPed(-1), false))
							end
						else
							local closeVeh = GetCloseVeh()
							if closeVeh ~= false then
								if GetVehiclePedIsIn(GetPlayerPed(-1), true) == closeVeh then
									if k9.inVehicle then
										ShowNotification("~y~*VORAUS*")
										TriggerServerEvent("K9:ExitVehicle", "NORMAL")
									else
										ShowNotification("~y~*GEH REIN*")
										TriggerServerEvent("K9:EnterVehicle", closeVeh)
									end
								else
									if k9.inVehicle then
										TriggerServerEvent("K9:ExitVehicle", "NORMAL")
									end
									TriggerServerEvent("K9:SearchVehicle", closeVeh)
								end
							else
								if not IsPlayerFreeAiming(PlayerId()) then
									if k9.follow then
										TriggerServerEvent("K9:Follow", false)
									else
										if k9.inVehicle then
											TriggerServerEvent("K9:ExitVehicle", "NORMAL")
										end
										TriggerServerEvent("K9:Follow", true)
									end
								else
									local bool, enemyPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
									if bool then
										if k9.inVehicle then
											TriggerServerEvent("K9:ExitVehicle", "QUICK")
										end
										TriggerServerEvent("K9:Attack", "NORMAL", 0)
									else
										ShowNotification("~r~No target in range")
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

function k9Follow(toggle)
	ClearPedTasks(k9.dog)
	if toggle then
		ShowNotification("~y~*HIER*")
		TaskFollowToOffsetOfEntity(k9.dog, GetPlayerPed(-1), 0.5, -0.5, 0.0, 5.0, -1, 0.0, 1)
	else
		ShowNotification("~y~*BLEIBEN*")
	end
	k9.follow = toggle
end

function k9ExitVehicle(speed)
	local dCoords = GetEntityCoords(k9.dog)
	local veh = GetClosestVehicle(dCoords.x, dCoords.y, dCoords.z, 3.0, 0, 23)
	local vehCoords = GetEntityCoords(veh)
	local forwardX = GetEntityForwardX(veh)*3.7
	local forwardY = GetEntityForwardY(veh)*3.7

	ClearPedTasks(k9.dog)
	SetVehicleDoorOpen(veh, 5, false)
	if speed == "NORMAL" then Wait(1500) else Wait(500) end
	DetachEntity(k9.dog, true, false)
	SetEntityCoords(k9.dog, vehCoords.x-forwardX, vehCoords.y-forwardY, vehCoords.z-1.0)
	if speed == "NORMAL" then Wait(1500) else Wait(500) end
	SetVehicleDoorShut(veh, 5, false)
	k9.inVehicle = false
end

function k9EnterVehicle(veh)
	local vehCoords = GetEntityCoords(veh)
	local forwardX = GetEntityForwardX(veh)*2.0
	local forwardY = GetEntityForwardY(veh)*2.0

	SetVehicleDoorOpen(veh, 5, false)
	TaskFollowNavMeshToCoord(k9.dog, vehCoords.x-forwardX, vehCoords.y-forwardY, vehCoords.z, 4.0, -1, 1.0, 1, 1)
	Wait(5000)
	TaskAchieveHeading(k9.dog, GetEntityHeading(veh), -1)
	RequestAnimDict("creatures@rottweiler@in_vehicle@van", true)
	RequestAnimDict("creatures@rottweiler@amb@world_dog_sitting@base", true)
	while not HasAnimDictLoaded("creatures@rottweiler@in_vehicle@van") or not HasAnimDictLoaded("creatures@rottweiler@amb@world_dog_sitting@base") do
		Citizen.Wait(0)
	end
	TaskPlayAnim(k9.dog, "creatures@rottweiler@in_vehicle@van", "get_in", 8.0, -4.0, -1, 2, 0.0, false, false, false)
	Wait(1100)
	ClearPedTasks(k9.dog)
	AttachEntityToEntity(k9.dog, veh, GetEntityBoneIndexByName(veh, "chassis"), 0.0, -1.92, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	TaskPlayAnim(k9.dog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -4.0, -1, 1, 0.0, false, false, false)
	Wait(500)
	SetVehicleDoorShut(veh, 5, false)
	k9.follow = false
	k9.inVehicle = true
end

function k9Attack(attackType, ped)
	if ped == 0 then
		if not IsPlayerFreeAiming(PlayerId()) and attackType == "PANIC" then
			ClearPedTasks(dog)
			local area = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 10.0, 0.0)
			TaskFollowNavMeshToCoord(k9.dog, area.x, area.y, area.z, 6.0, -1, 1.0, 1, 1)
			Wait(4000)
			local enemy = FindFirstPed()
			if enemy ~= nil then
				if enemy ~= GetPlayerPed(-1) then
					ShowNotification("~y~*FASSEN*")
					TaskCombatPed(k9.dog, enemy, 0, 16)
					SetPedKeepTask(k9.dog, true)
					k9.follow = false
				end
			end
		else
			local bool, enemyPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
			if bool then
				ShowNotification("~y~*FASSEN*")
				ClearPedTasks(dog)
				TaskCombatPed(k9.dog, enemyPed, 0, 16)
				SetPedKeepTask(k9.dog, true)
				k9.follow = false
			elseif attackType == "PANIC" then
				ClearPedTasks(dog)
				local area = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 10.0, 0.0)
				TaskFollowNavMeshToCoord(k9.dog, area.x, area.y, area.z, 6.0, -1, 1.0, 1, 1)
				Wait(4000)
				local player = GetNearestPlayerToEntity(k9.dog)
				if GetPlayerPed(player) ~= GetPlayerPed(-1) then
					ShowNotification("~y~*FASSEN*")
					TaskCombatPed(k9.dog, GetPlayerPed(player), 0, 16)
					SetPedKeepTask(k9.dog, true)
					k9.follow = false
				end
			else
				ShowNotification("~r~No target in range")
			end
		end
	elseif ped ~= 0 then
		local enemyPed = GetPlayerPed(GetPlayerFromServerId(tonumber(ped)))
		if enemyPed ~= nil then
			ShowNotification("~y~*FASSEN*")
			TaskCombatPed(k9.dog, enemyPed, 0, 16)
			SetPedKeepTask(k9.dog, true)
			k9.follow = false
		else
			ShowNotification("~r~Invalid target")
		end
	end
end

function k9SearchVehicle(veh)
	local vehSideR = GetOffsetFromEntityInWorldCoords(veh, 2.3, 0.0, 0.0)
	local vehRear = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.3, 0.0)
	local vehSideL = GetOffsetFromEntityInWorldCoords(veh, -2.3, 0.0, 0.0)
	local vehHead = GetEntityHeading(veh)

	if k9.searching == false then
		if k9.follow then
			ClearPedTasks(k9.dog)
			k9.follow = false
		end

		k9.searching = true
		ShowNotification("~y~*VERLOREN*")
		TaskFollowNavMeshToCoord(k9.dog, vehSideL.x, vehSideL.y, vehSideL.z, 3.5, -1, 1.0, 1, 1)
		Citizen.Wait(4000)
		TaskAchieveHeading(k9.dog, vehHead - 90, -1)
		SetVehicleDoorOpen(veh, 0, false)
		SetVehicleDoorOpen(veh, 2, false)
		Citizen.Wait(5000)
		SetVehicleDoorShut(veh, 0, false)
		SetVehicleDoorShut(veh, 2, false)

		TaskFollowNavMeshToCoord(k9.dog, vehRear.x, vehRear.y, vehRear.z, 3.0, -1, 1.0, 1, 1)
		Citizen.Wait(3000)
		TaskAchieveHeading(k9.dog, vehHead, -1)
		SetVehicleDoorOpen(veh, 5, false)
		SetVehicleDoorOpen(veh, 6, false)
		SetVehicleDoorOpen(veh, 7, false)
		Citizen.Wait(5000)
		SetVehicleDoorShut(veh, 5, false)
		SetVehicleDoorShut(veh, 6, false)
		SetVehicleDoorShut(veh, 7, false)

		TaskFollowNavMeshToCoord(k9.dog, vehSideR.x, vehSideR.y, vehSideR.z, 3.0, -1, 1.0, 1, 1)
		Citizen.Wait(3000)
		TaskAchieveHeading(k9.dog, vehHead - 270, -1)
		SetVehicleDoorOpen(veh, 1, false)
		SetVehicleDoorOpen(veh, 3, false)
		Citizen.Wait(5000)
		SetVehicleDoorShut(veh, 1, false)
		SetVehicleDoorShut(veh, 3, false)

		ShowNotification("~y~K9 ~w~Found: Nothing.")
		k9.searching = false
	end
end

function GetCloseVeh()
	local myPed = GetPlayerPed(-1)
	local myPos = GetEntityCoords(myPed, 1)
	local frontOfPlayer = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 3.0, 0.0)
	local closeVehicle = GetEntityInDirection(myPos, frontOfPlayer, 2)
	if DoesEntityExist(closeVehicle) then
		return closeVehicle
	else
		return false
	end
end

function GetEntityInDirection(coordFrom, coordTo, flag)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, flag, GetPlayerPed(-1), 0)
    local _, _, _, _, entity = GetShapeTestResult(rayHandle)
    return entity
end

RegisterNetEvent('spawnEmergencyVehicle')
AddEventHandler('spawnEmergencyVehicle', function(vehicle)
	local pCoords = GetEntityCoords(GetPlayerPed(-1))
	local carHash = GetHashKey(vehicle)
	if vehicle == 'medmav' then
		carHash = GetHashKey('polmav')
	end
	RequestModel(carHash)
	while not HasModelLoaded(carHash) do
		Citizen.Wait(0)
	end
	local spawnedVeh = CreateVehicle(carHash, pCoords.x + 3, pCoords.y, pCoords.z + 1.0, 0.0, true, false)
	while not DoesEntityExist(spawnedVeh) do
		Citizen.Wait(0)
	end
	SetEntityHeading(spawnedVeh, GetEntityHeading(GetPlayerPed(-1)))
	SetEntityAsMissionEntity(spawnedVeh, true, true)
	SetVehicleHasBeenOwnedByPlayer(spawnedVeh, true)
	SetVehicleModKit(spawnedVeh, 0)
	SetVehicleMod(spawnedVeh, 16, -1, false)
	addVehicleExtras(spawnedVeh, vehicle)
	SetVehicleDirtLevel(spawnedVeh, 0.0)
	TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawnedVeh, -1)
	local plate = "G" .. GetRandomIntInRange(10, 99) .. "" .. GetRandomIntInRange(10, 99) .. "" .. GetRandomIntInRange(100, 999)
	SetVehicleNumberPlateText(spawnedVeh, "" .. plate)
	TriggerEvent("addKey", plate)
end)

RegisterNetEvent("UpdateJobSpecificBlips")
AddEventHandler('UpdateJobSpecificBlips', function(level)
	localJobLevel = tonumber(level)
	if localJobLevel == 0 then -- Civilian
		for i=1, #civPoliceBlips do
			drawEmergencyBlip(civPoliceBlips[i], 58, 4, 'Police Station')
		end
	elseif localJobLevel == 1 or localJobLevel == 2 or localJobLevel == 3 then -- LSPD, BCSO, SASP
		for i=1, #policeBlips do
			drawEmergencyBlip(policeBlips[i], 58, 4, 'Department')
		end
	elseif localJobLevel == 4 or localJobLevel == 5 then -- EMS, FIRE
		for i=1, #civPoliceBlips do
			drawEmergencyBlip(civPoliceBlips[i], 58, 4, 'Police Station')
		end
	end
	for i=1, #hospitalBlips do
		drawEmergencyBlip(hospitalBlips[i], 61, 4, 'Hospital')
	end
end)

RegisterNetEvent("onDuty")
AddEventHandler('onDuty', function(job)
	if job ~= 'EMS' and job ~= 'FIRE' and job ~= 'OFF' then
		if onDuty == 0 then
			local model = ''
			if job == 'LSPD' then
				onDuty = 1
				model = GetHashKey('s_m_y_cop_01')
			elseif job == 'DOC' then
				onDuty = 2
				model = GetHashKey('s_m_y_sheriff_01')
			elseif job == 'SASP' then
				onDuty = 3
				model = GetHashKey('s_m_y_hwaycop_01')
			end
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(1)
			end
			SetPlayerModel(PlayerId(-1), model)
		end
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_nightstick'), 1, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_flashlight'), 1, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_carbinerifle'), 150, false, true)
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('weapon_carbinerifle'), 0x7BC4CDDC)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_pumpshotgun'), 150, false, true)
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('weapon_pumpshotgun'), 0x7BC4CDDC)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_fireextinguisher'), 9999, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_flare'), 25, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_stungun'), 1, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_combatpistol'), 200, false, true)
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('weapon_combatpistol'), 0x359B7AAE)
		SetPedArmour(GetPlayerPed(-1), 100)
	elseif job == 'EMS' then
		onDuty = 4
		local model = GetHashKey('s_m_m_paramedic_01')
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1)
		end
		SetPlayerModel(PlayerId(-1), model)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_fireextinguisher'), 9999, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_flashlight'), 1, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_flare'), 25, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_stungun'), 1, false, true)
		SetPedInfiniteAmmo(GetPlayerPed(-1), true, GetHashKey('weapon_fireextinguisher'))
	elseif job == 'FIRE' then
		onDuty = 5
		local model = GetHashKey('s_m_y_fireman_01')
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1)
		end
		SetPlayerModel(PlayerId(-1), model)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_fireextinguisher'), 9999, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_flashlight'), 1, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_flare'), 25, false, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('weapon_stungun'), 1, false, true)
		SetPedInfiniteAmmo(GetPlayerPed(-1), true, GetHashKey('weapon_fireextinguisher'))
	elseif job == 'OFF' then
		onDuty = 0
		TriggerServerEvent("goOffDuty")
	end
end)

RegisterNetEvent("notifyReports")
AddEventHandler('notifyReports', function(job, posX, posY, posZ, text, area, ID)
	if job_status == 102 then
		local reportID = tonumber(ID)
		if job == 'news' then
			ShowNotification("~r~News Report: #" .. reportID)
			ShowNotification("~r~Area: " .. area)
			newsReports[reportID] = {}
			newsReports[reportID]['posX'] = posX
			newsReports[reportID]['posY'] = posY
			newsReports[reportID]['posZ'] = posZ
			newsReports[reportID]['text'] = text
			newsReports[reportID]['area'] = area
			TriggerServerEvent('InteractSound_SV:PlayOnSource', "Dispatch/RESIDENT/DISPATCH_INTRO_01", 0.5)
		end
	elseif job_status == 103 then
		local reportID = tonumber(ID)
		if job == 'taxi' then
			ShowNotification("~r~Taxi Request: #" .. reportID)
			ShowNotification("~r~Area: " .. area)
			cabReports[reportID] = {}
			cabReports[reportID]['posX'] = posX
			cabReports[reportID]['posY'] = posY
			cabReports[reportID]['posZ'] = posZ
			cabReports[reportID]['text'] = text
			cabReports[reportID]['area'] = area
			TriggerServerEvent('InteractSound_SV:PlayOnSource', "Dispatch/RESIDENT/DISPATCH_INTRO_01", 0.5)
		end
	elseif job_status == 104 then
		local reportID = tonumber(ID)
		if job == 'tow' then
			ShowNotification("~r~Tow Request: #" .. reportID)
			ShowNotification("~r~Area: " .. area)
			towReports[reportID] = {}
			towReports[reportID]['posX'] = posX
			towReports[reportID]['posY'] = posY
			towReports[reportID]['posZ'] = posZ
			towReports[reportID]['text'] = text
			towReports[reportID]['area'] = area
			TriggerServerEvent('InteractSound_SV:PlayOnSource', "Dispatch/RESIDENT/DISPATCH_INTRO_01", 0.5)
		end
	end
end)

RegisterNetEvent("viewReport")
AddEventHandler('viewReport', function(ID)
	if job_status == 102 then
		local reportID = tonumber(ID)
		if newsReports[reportID] ~= nil then
			if newsReports[reportID]['area'] ~= "none" then
				ShowNotification("~g~Report: #" .. reportID .. "~g~ - " .. newsReports[reportID]['area'])
			else
				ShowNotification("~g~Report: #" .. reportID)
			end
			ShowNotification("~g~" .. newsReports[reportID]['text'])
		else
			ShowNotification("~r~Invalid Report Number!")
		end
	elseif job_status == 103 then
		local reportID = tonumber(ID)
		if cabReports[reportID] ~= nil then
			if cabReports[reportID]['area'] ~= "none" then
				ShowNotification("~g~Report: #" .. reportID .. "~g~ - " .. cabReports[reportID]['area'])
			else
				ShowNotification("~g~Report: #" .. reportID)
			end
			ShowNotification("~g~" .. cabReports[reportID]['text'])
		else
			ShowNotification("~r~Invalid Report Number!")
		end
	elseif job_status == 104 then
		local reportID = tonumber(ID)
		if towReports[reportID] ~= nil then
			if towReports[reportID]['area'] ~= "none" then
				ShowNotification("~g~Report: #" .. reportID .. "~g~ - " .. towReports[reportID]['area'])
			else
				ShowNotification("~g~Report: #" .. reportID)
			end
			ShowNotification("~g~" .. towReports[reportID]['text'])
		else
			ShowNotification("~r~Invalid Report Number!")
		end
	else
		ShowNotification("~r~You have no job!")
	end
end)

RegisterNetEvent("gotoReport")
AddEventHandler('gotoReport', function(ID)
	if job_status == 102 then
		local reportID = tonumber(ID)
		if newsReports[reportID]['posX'] ~= nil then
			SetNewWaypoint(newsReports[reportID]['posX'], newsReports[reportID]['posY'])
		else
			ShowNotification("~r~Invalid Report Number!")
		end
	elseif job_status == 103 then
		local reportID = tonumber(ID)
		if cabReports[reportID]['posX'] ~= nil then
			SetNewWaypoint(cabReports[reportID]['posX'], cabReports[reportID]['posY'])
		else
			ShowNotification("~r~Invalid Report Number!")
		end
	elseif job_status == 104 then
		local reportID = tonumber(ID)
		if towReports[reportID]['posX'] ~= nil then
			SetNewWaypoint(towReports[reportID]['posX'], towReports[reportID]['posY'])
		else
			ShowNotification("~r~Invalid Report Number!")
		end
	else
		ShowNotification("~r~You have no job!")
	end
end)

RegisterNetEvent("returnSearch")
AddEventHandler('returnSearch', function(player, item1, amount1, item2, amount2, item3, amount3, item4, amount4, item5, amount5, item6, amount6, item7, amount7, item8, amount8, item9, amount9, item10, amount10)
	if onDuty ~= 0 then
		if onDuty < 4 then
			if item1 ~= "Empty" then
				ShowNotification("- " .. amount1 .. " " .. item1)
				if item2 ~= "Empty" then
					ShowNotification("- " .. amount2 .. " " .. item2)
					if item3 ~= "Empty" then
						ShowNotification("- " .. amount3 .. " " .. item3)
						if item4 ~= "Empty" then
							ShowNotification("- " .. amount4 .. " " .. item4)
							if item5 ~= "Empty" then
								ShowNotification("- " .. amount5 .. " " .. item5)
								if item6 ~= "Empty" then
									ShowNotification("- " .. amount6 .. " " .. item6)
									if item7 ~= "Empty" then
										ShowNotification("- " .. amount7 .. " " .. item7)
										if item8 ~= "Empty" then
											ShowNotification("- " .. amount8 .. " " .. item8)
											if item9 ~= "Empty" then
												ShowNotification("- " .. amount9 .. " " .. item9)
												if item10 ~= "Empty" then
													ShowNotification("- " .. amount10 .. " " .. item10)
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("rappel")
AddEventHandler("rappel", function()
    Citizen.CreateThread(function()
        if not IsPedInAnyHeli(GetPlayerPed(-1)) then
            TriggerEvent("chatMessage", "Error", {255, 0, 0}, "You aren't in a Maverick.")
            return
        end

        local heli = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if IsVehicleModel(heli, GetHashKey("polmav")) or IsVehicleModel(heli, GetHashKey("statehuey")) then
			if GetPedInVehicleSeat(heli, -1) == GetPlayerPed(-1) or GetPedInVehicleSeat(heli, 0) == GetPlayerPed(-1) then
				TriggerEvent("chatMessage", "Error", {255, 0, 0}, "You have to sit on the side to rappel.")
			else
				TaskRappelFromHeli(GetPlayerPed(-1), 0)
			end
		else
			TriggerEvent("chatMessage", "Error", {255, 0, 0}, "You aren't in a Maverick.")
		end
    end)
end)

RegisterNetEvent("emergencyChat")
AddEventHandler('emergencyChat', function(sender, message)
	if onDuty ~= 0 then
		TriggerEvent("chatMessage", "", {255, 150, 76}, "^4[EC] " .. sender .. ": ^0" .. message)
	end
end)

function checkEmergencyRange()
	if drawMarker(policeBlips[1], 20, 1.5, 0) == true then policePaleto = true else policePaleto = false end
	if drawMarker(policeBlips[2], 20, 1.5, 0) == true then policeSandy = true else policeSandy = false end
	if drawMarker(policeBlips[3], 20, 1.5, 0) == true then policeLS = true else policeLS = false end

	hospital = false
	for i=1, #hospitalBlips do
		if drawMarker(hospitalBlips[i], 20, 1.5, 0) == true then hospital = true end
	end
end

function checkFineRange()
	if drawMarker(civPoliceBlips[1], 20, 1.5, 0) == true then policePaleto = true else policePaleto = false end
	if drawMarker(civPoliceBlips[2], 20, 1.5, 0) == true then policeSandy = true else policeSandy = false end
	if drawMarker(civPoliceBlips[3], 20, 1.5, 0) == true then policeLS = true else policeLS = false end

	hospital = false
	for i=1, #hospitalBlips do
		if drawMarker(hospitalBlips[i], 20, 1.5, 0) == true then hospital = true end
	end
end

function drawMarker(tab, markerRange, useRange, markerTrue)
	local myPed = GetPlayerPed(-1)
	if GetDistanceBetweenCoords(tab[1],tab[2],tab[3], GetEntityCoords(myPed, true), true) < markerRange then
		if markerTrue == 1 then DrawMarker(1,tab[1],tab[2],tab[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0) end
		if IsPedInAnyVehicle(myPed, true) == false and GetDistanceBetweenCoords(tab[1],tab[2],tab[3], GetEntityCoords(myPed, true), true) < useRange then
			return true
		else
			return false
		end
	end
end

function drawEmergencyBlip(tab, sprite, color, name)
	local blip = AddBlipForCoord(tab[1],tab[2],tab[3])
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName('' .. name)
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
end

function addVehicleExtras(vehToAdd, vehName)
	if vehName ~= 'STATEHUEY' then
		SetVehicleModKit(vehToAdd, 0)
		SetVehicleMod(vehToAdd, 11, 3, false)
		SetVehicleMod(vehToAdd, 12, 2, false)
		SetVehicleMod(vehToAdd, 13, 2, false)
	end
	if vehName == 'STATE1' or vehName == 'STATE3' then
		SetVehicleExtra(vehToAdd, 2, 1) -- 0 means on, 1 means off
		SetVehicleExtra(vehToAdd, 5, 0)
		SetVehicleExtra(vehToAdd, 7, 0)
		SetVehicleExtra(vehToAdd, 12, 0)
	elseif vehName == 'STATE2' then
		SetVehicleExtra(vehToAdd, 2, 0)
		SetVehicleExtra(vehToAdd, 5, 0)
		SetVehicleExtra(vehToAdd, 7, 1)
		SetVehicleExtra(vehToAdd, 12, 0)
		SetVehicleWheelType(vehToAdd, 1)
		SetVehicleMod(vehToAdd, 23, 3, false)
	elseif vehName == 'STATE4' then
		SetVehicleExtra(vehToAdd, 3, 0)
		SetVehicleExtra(vehToAdd, 5, 0)
		SetVehicleExtra(vehToAdd, 12, 0)
	elseif vehName == "STATE5" then
		SetVehicleExtra(vehToAdd, 3, 0)
		SetVehicleExtra(vehToAdd, 4, 1)
		SetVehicleExtra(vehToAdd, 6, 0)
		SetVehicleExtra(vehToAdd, 7, 1)
		SetVehicleExtra(vehToAdd, 8, 0)
	elseif vehName == "STATE6" then
		SetVehicleExtra(vehToAdd, 8, 0)
		SetVehicleExtra(vehToAdd, 10, 0)
		SetVehicleExtra(vehToAdd, 11, 0)
	elseif vehName == "STATE7" then
		SetVehicleExtra(vehToAdd, 1, 1)
		SetVehicleExtra(vehToAdd, 2, 1)
		SetVehicleExtra(vehToAdd, 3, 1)
		SetVehicleExtra(vehToAdd, 7, 0)
	elseif vehName == "STATE8" then
		SetVehicleExtra(vehToAdd, 1, 0)
		SetVehicleExtra(vehToAdd, 3, 0)
		SetVehicleExtra(vehToAdd, 4, 0)
	elseif vehName == 'LSPD1' then
		SetVehicleExtra(vehToAdd, 1, 0)
		SetVehicleExtra(vehToAdd, 2, 0)
		SetVehicleExtra(vehToAdd, 3, 0)
		SetVehicleExtra(vehToAdd, 5, 0)
		SetVehicleExtra(vehToAdd, 6, 0)
		SetVehicleExtra(vehToAdd, 7, 0)
		SetVehicleExtra(vehToAdd, 8, 0)
		SetVehicleExtra(vehToAdd, 9, 0)
		SetVehicleExtra(vehToAdd, 10, 0)
		SetVehicleExtra(vehToAdd, 11, 0)
	elseif vehName == 'LSPD2' then
		SetVehicleExtra(vehToAdd, 3, 0)
		SetVehicleExtra(vehToAdd, 6, 0)
		SetVehicleExtra(vehToAdd, 9, 0)
		SetVehicleExtra(vehToAdd, 12, 0)
	elseif vehName == 'LSPD3' then
		SetVehicleExtra(vehToAdd, 2, 0)
		SetVehicleExtra(vehToAdd, 3, 0)
		SetVehicleExtra(vehToAdd, 4, 0)
		SetVehicleExtra(vehToAdd, 5, 0)
		SetVehicleExtra(vehToAdd, 8, 0)
		SetVehicleExtra(vehToAdd, 9, 0)
		SetVehicleExtra(vehToAdd, 10, 0)
		SetVehicleExtra(vehToAdd, 11, 0)
		SetVehicleExtra(vehToAdd, 12, 0)
	elseif vehName == 'LSPD4' then
		SetVehicleExtra(vehToAdd, 2, 0)
		SetVehicleExtra(vehToAdd, 5, 0)
		SetVehicleExtra(vehToAdd, 6, 0)
		SetVehicleExtra(vehToAdd, 7, 0)
	elseif vehName == 'LSPD5' then
		SetVehicleExtra(vehToAdd, 1, 0)
		SetVehicleExtra(vehToAdd, 2, 0)
		SetVehicleExtra(vehToAdd, 4, 0)
		SetVehicleExtra(vehToAdd, 5, 0)
		SetVehicleExtra(vehToAdd, 6, 0)
		SetVehicleExtra(vehToAdd, 7, 0)
		SetVehicleExtra(vehToAdd, 8, 0)
		SetVehicleExtra(vehToAdd, 9, 0)
	elseif vehName == 'LSPD6' then
		SetVehicleExtra(vehToAdd, 3, 0)
	elseif vehName == 'LSPD7' then
		SetVehicleExtra(vehToAdd, 2, 0)
	elseif vehName == 'LSPD8' then
		SetVehicleExtra(vehToAdd, 8, 0)
		SetVehicleExtra(vehToAdd, 10, 0)
		SetVehicleExtra(vehToAdd, 11, 0)
		SetVehicleExtra(vehToAdd, 12, 0)
	end
	if vehName == 'MEDMAV' then
		SetVehicleLivery(vehToAdd, 1)
	elseif vehName == 'POLMAV' then
		SetVehicleLivery(vehToAdd, 2)
	end
end
