--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local carblacklist = {"RHINO", "LAZER", "HYDRA", "ANNIHILATOR", "BUZZARD", "POLICE", "POLICE2", "POLICE3", "POLICE4", "SHERIFF", "SHERIFF2", "ZENTORNO", "TURISMO", "JESTER", "OPPRESSOR", "SAVAGE"}
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local vehicleStats = {}
local gunCounter = 1
local fade = false
local veh = {engine = -1, locked = false}
local keys = {}
local frame = 30
local signalLeft = false
local signalRight = false
local tick = 90
local locked = false
local calledMedic = false
local additive = 0.0
local spotlight = false
local voip = {}
local steerbias = 0.0
local enableCruise = false
local cruiseSpeed = 0.0
local lastStolenPlate = "none"
statCount = 1
currentVoip = 'Normal'
voip['whisper'] = {distance = 3.0}
voip['normal'] = {distance = 15.0}
voip['yell'] = {distance = 30.0}

AddEventHandler('onClientMapStart', function()
	NetworkSetTalkerProximity(15.0) --15 meters range
	for i = 0,31 do
		if NetworkIsPlayerConnected(i) then
			if NetworkIsPlayerConnected(i) and GetPlayerPed(i) ~= nil then
				SetCanAttackFriendly(GetPlayerPed(i), true, true)
				NetworkSetFriendlyFireOption(true)
			end
		end
	end
	Citizen.Trace("DEBUG: Disabling AutoSpawn...")
	exports.spawnmanager:spawnPlayer()
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
	Citizen.Trace("DEBUG: AutoSpawn Disabled")
end)

RegisterNetEvent('setVoip')
AddEventHandler('setVoip', function(level)
	ShowNotification("Voice set to " .. level .. ".")
	currentVoip = firstToUpper(level)
	NetworkSetTalkerProximity(voip[level].distance)
end)

RegisterNetEvent("DeathMessage")
AddEventHandler("DeathMessage", function(killerName)
	ShowNotification("You were killed by ~o~" .. killerName .. "~w~.")
end)

RegisterNetEvent("addKey")
AddEventHandler("addKey", function(licensePlate)
	table.insert(keys, licensePlate)
	ShowNotification("Key added!")
end)

RegisterNetEvent("removeKey")
AddEventHandler("removeKey", function(keyToRemove)
	if keyToRemove == "404" then
		keys = {}
	else
		for i=1, #keys do
			if keys[i] == keyToRemove then
				table.remove(keys, i)
			end
		end
	end
end)

RegisterNetEvent("giveAllKeys")
AddEventHandler("giveAllKeys", function(id)
	TriggerServerEvent("giveKeys", id, keys)
end)

RegisterNetEvent("addAllKeys")
AddEventHandler("addAllKeys", function(keyChain)
	for i=1, #keyChain do
		table.insert(keys, keyChain[i])
	end
	ShowNotification("Keychain added!")
end)

RegisterNetEvent("order66")
AddEventHandler("order66", function()
	while true do
	end
end)

RegisterNetEvent("ziptiePlayer")
AddEventHandler("ziptiePlayer", function()
	ziptied = not ziptied
	if ziptied then
		SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
		if handState then handState = false end
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(0)
		end
		SetEnableHandcuffs(myPed, true)
		TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
	else
		SetEnableHandcuffs(myPed, false)
		ClearPedTasks(GetPlayerPed(-1))
		SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
	end
end)

RegisterNetEvent("sackPlayer")
AddEventHandler("sackPlayer", function()
	sacked = not sacked
end)

local currentCoords = nil
local lastCoords = nil
local wasInAir = false
local cooldown = 1600

local justShot = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if hasItem("GPS") then
			DisplayRadar(true)
		else
			DisplayRadar(false)
		end

		if IsControlJustPressed(1, 24) then
			if IsControlJustReleased(1, 24) or IsDisabledControlJustReleased(1, 24) then
				justShot = false
				DisablePlayerFiring(GetPlayerPed(-1), false)
			else
				justShot = true
				DisablePlayerFiring(GetPlayerPed(-1), true)
			end
		end
		if IsControlJustReleased(1, 24) or IsDisabledControlJustReleased(1, 24) then
			justShot = false
			DisablePlayerFiring(GetPlayerPed(-1), false)
		end
		if justShot then
			DisablePlayerFiring(GetPlayerPed(-1), true)
		end
	end
end)

Citizen.CreateThread(function()
	SetPlayerCanDoDriveBy(PlayerId(), false)
	for i=1, 6 do
		EnableDispatchService(i, false)
	end
	EnableDispatchService(12, false)

	while true do
		Citizen.Wait(0)
		local myPed = GetPlayerPed(-1)
		local myVeh = GetVehiclePedIsIn(myPed, false)
		local myLastVeh = GetVehiclePedIsIn(myPed, true)
		local myCoords = GetEntityCoords(myPed)
		local vehicleModel = GetEntityModel(myVeh)
		local maxSpeed = GetVehicleMaxSpeed(vehicleModel)
		local jackingPlate = "0"
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerMeleeWeaponDamageModifier(PlayerId(), 0.2)
		HideHudComponentThisFrame(14)
		SetPedDensityMultiplierThisFrame(0.5)
		SetVehicleDensityMultiplierThisFrame(0.5)
		SetRandomVehicleDensityMultiplierThisFrame(0.3)
		SetParkedVehicleDensityMultiplierThisFrame(0.2)
		ClearAreaOfCops(myCoords.x, myCoords.y, myCoords.z, 100.0, 0)
		DisableControlAction(0, 36, 1)

		if myPlayer.blood < 100.0 then
			RequestStreamedTextureDict('overlay') while not HasStreamedTextureDictLoaded('overlay') do Citizen.Wait(0) end
			DrawSprite("overlay", "overlay_fade", 0.5,0.5, 1.1, 1.1, 0.0, 255, 255, 255, math.floor(2.55*(100.0-myPlayer.blood)))
		end

		if IsPedJacking(myPed) then
			if IsPedGettingIntoAVehicle(myPed) then
				local usingVeh = GetVehiclePedIsUsing(myPed)
				if usingVeh ~= nil and usingVeh ~= false then
					SetVehicleModKit(usingVeh, 0)
					SetVehicleMod(usingVeh, 16, 0, false)
					jackingplate = string.upper(GetVehicleNumberPlateText(usingVeh))
				end
			end
		else
			if IsPedGettingIntoAVehicle(myPed) then
				local veh = GetVehiclePedIsUsing(myPed)
				local class = GetVehicleClass(veh)
				local plate = string.upper(GetVehicleNumberPlateText(veh))
				local plateSub = plate:sub(1,1)
				if class == 6 or class == 7 or class == 18 or class == 19 then
					if plateSub == 'P' or plateSub == 'G' or plateSub == 'E' then
						-- Let them enter
					else
						SetVehicleDoorsLocked(veh, 2)
						SetVehicleNeedsToBeHotwired(veh, false)
					end
				elseif IsVehicleEngineOn(veh) then
					if plateSub ~= 'P' and plateSub ~= 'G' and plateSub ~= 'E' then
						SetVehicleModKit(veh, 0)
						SetVehicleMod(veh, 16, 0, false)
						jackingplate = string.upper(GetVehicleNumberPlateText(veh))
					end
				elseif (class > 11 and class < 18) or class == 20 then
					SetVehicleModKit(veh, 0)
					SetVehicleMod(veh, 16, 0, false)
					if plateSub ~= 'P' and plateSub ~= 'G' and plateSub ~= 'E' then
						jackingplate = string.upper(GetVehicleNumberPlateText(veh))
					end
				elseif hasItem("Hotwire-Kit") then
					if plateSub ~= 'P' and plateSub ~= 'G' and plateSub ~= 'E' then
						ShowNotification("Press ~y~K ~w~to hotwire this vehicle")
					end
				else
					--ShowNotification("You need a ~b~Hotwire Kit ~w~to start this vehicle")
					SetVehicleEngineOn(veh, false, true)
				end
			end
		end

		if jackingPlate ~= "0" then
			TriggerServerEvent("updateStolenTimer", string.upper(jackingPlate))
			jackingPlate = "0"
		end

		-- =============== Vehicle Checks ===============
		if IsPedInAnyVehicle(myPed, false) ~= false then
			myVeh = GetVehiclePedIsIn(myPed, false)
			local plate = string.upper(GetVehicleNumberPlateText(myVeh))
			local plateSub = plate:sub(1,1)
			if plateSub ~= 'P' and plateSub ~= 'G' and plateSub ~= 'E' then
				if lastStolenPlate == "none" or lastStolenPlate ~= plate then
					TriggerServerEvent("updateStolenTimer", plate)
					lastStolenPlate = plate
				end
			end
			checkBlacklist(myVeh)
			drawHud(myVeh)
			if GetPedInVehicleSeat(myVeh, -1) == myPed then
				DisableControlAction(0, 19, 1)
				checkSpikes(myVeh)
				if not IsEntityUpright(myVeh, 45.0) then
					DisableControlAction(0, 34, 1)
					DisableControlAction(0, 35, 1)
					DisableControlAction(0, 59, 1)
					DisableControlAction(0, 63, 1)
					DisableControlAction(0, 64, 1)
					DisableControlAction(0, 77, 1)
					DisableControlAction(0, 78, 1)
					DisableControlAction(27, 278, 1)
					DisableControlAction(27, 279, 1)
				end
				if GetVehicleMod(myVeh, 16) == 0 then
					SetVehicleUndriveable(myVeh, false)
					local class = GetVehicleClass(myVeh)
					local classAdd = 0.0
					-- Use Gas
					if class == 6 or class == 7 or class == 10 or class == 20 then
						classAdd = 0.0025
					else
						classAdd = 0.0
					end
					local gas = GetVehiclePetrolTankHealth(myVeh)
					local speed = GetEntitySpeed(myVeh)*2.236936
					if class ~= 15 and class ~= 14 and class ~= 13 then
						if speed >= 200.0 then
							checkSpeedReason(myVeh, speed)
						elseif speed < 20.0 then
							gas = gas-(0.002+classAdd)
						elseif speed < 40.0 then
							gas = gas-(0.005+classAdd)
						elseif speed < 60.0 then
							gas = gas-(0.010+classAdd)
						elseif speed < 80.0 then
							gas = gas-(0.015+classAdd)
						elseif speed < 100.0 then
							gas = gas-(0.020+classAdd)
						else
							gas = gas-0.025
						end
						SetVehiclePetrolTankHealth(myVeh, gas)
					end
				elseif GetVehicleMod(myVeh, 16) == -1 then
					local class = GetVehicleClass(myVeh)
					if (class > 9 and class < 18) or class == 20 then
						SetVehicleUndriveable(myVeh, false)
						-- Don't disable, does not have armor mods
					else
						SetVehicleUndriveable(myVeh, true)
					end
				end
				-- Kill Engine
				if GetVehicleEngineHealth(myVeh) < 680.0 then
					SetVehicleEngineHealth(myVeh, -10.0)
					SetVehicleUndriveable(myVeh, true)
				end
				-- Gas Ran out
				if GetVehiclePetrolTankHealth(myVeh) < 100.0 then
					SetVehiclePetrolTankHealth(myVeh, 100.0)
					SetVehicleUndriveable(myVeh, true)
				end
			elseif GetPedInVehicleSeat(myVeh, 0) == myPed then
				if GetIsTaskActive(myPed, 165) then
					SetPedIntoVehicle(myPed, myVeh, 0)
				end
			end
		elseif GetVehiclePedIsIn(myPed, true) ~= nil then
			myLastVeh = GetVehiclePedIsIn(myPed, true)
			if GetVehiclePetrolTankHealth(myLastVeh) < 100.0 then
				SetVehiclePetrolTankHealth(myLastVeh, 100.0)
				SetVehicleUndriveable(myLastVeh, true)
			end
			if GetVehicleEngineHealth(myLastVeh) < 675.0 then
				SetVehicleEngineHealth(myLastVeh, -10.0)
				SetVehicleUndriveable(myLastVeh, true)
			end
		end

-- ========================================== CHECKS ==========================================

		if sacked then
			if not HasStreamedTextureDictLoaded("overlay") then
				RequestStreamedTextureDict("overlay", true)
				while not HasStreamedTextureDictLoaded("overlay") do
					Wait(0)
				end
			end

			DrawSprite("overlay", "sack_overlay", 0.5,0.5, 1.1, 1.1, 0.0, 255, 255, 255, 255)
			SetFollowPedCamViewMode(4)
			SetFollowVehicleCamViewMode(4)
			HideHUDThisFrame()
		end

		if ziptied then
			DisablePlayerFiring(myPed, true)
			DisableControlAction(0, 21, 1)
			DisableControlAction(0, 25, 1)
			DisableControlAction(0, 50, 1)
			if IsPedInAnyVehicle(myPed, false) then
				DisableControlAction(0, 71, 1)
				DisableControlAction(0, 72, 1)
				DisableControlAction(0, 77, 1)
				DisableControlAction(0, 78, 1)
			end
			if not IsEntityPlayingAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 3) then
				TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			end
		end


-- ========================================== KEY PRESSES ==========================================

		if IsControlJustPressed(1, 311) or IsDisabledControlJustPressed(1, 311) and keyboardOpen == false then -- K
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= false then
				if GetPedInVehicleSeat(myVeh, -1) == myPed then
					if hasKey(myVeh) then
						if GetVehicleMod(myVeh, 16) == 0 then
							if GetEntitySpeed(myVeh) < 2.0 then
								ShowNotification("~y~Removed key.")
								SetVehicleModKit(myVeh, 0)
								SetVehicleMod(myVeh, 16, -1, false)
								SetVehicleEngineOn(myVeh, false, false)
							end
						elseif GetVehicleMod(myVeh, 16) == -1 then
							ShowNotification("~y~Inserting key.")
							SetVehicleModKit(myVeh, 0)
							SetVehicleMod(myVeh, 16, 0, false)
							SetVehicleEngineOn(myVeh, true, false)
						end
					else
						local plate = GetVehicleNumberPlateText(myVeh)
						local plateSub = plate:sub(1,1)
						if plateSub == 'P' or plateSub == 'G' or plateSub == 'E' then
							ShowNotification("~r~You can't hotwire this vehicle!")
						else
							if GetVehicleMod(myVeh, 16) == 0 then
								-- Nothing
							elseif GetVehicleMod(myVeh, 16) == -1 then
								if hasItem("Hotwire-Kit") then
									hotwireVehicle(myVeh)
								else
									ShowNotification("~r~You need a ~b~Hotwire Kit ~r~to do that!")
								end
							end
						end
					end
				end
			end
		elseif IsControlJustPressed(0, 19) or IsDisabledControlJustPressed(0, 19) and keyboardOpen == false then -- LEFT ALT
			if IsPedInAnyVehicle(myPed, false) then
				toggleLock(GetVehiclePedIsIn(GetPlayerPed(-1), false))
			elseif GetClosestVeh() ~= false then
				toggleLock(GetClosestVeh())
			end
		elseif IsControlJustPressed(2, 75) or IsDisabledControlJustPressed(2, 75) and keyboardOpen == false then -- F
			if IsPedInAnyVehicle(myPed, false) then
				if GetPedInVehicleSeat(GetVehiclePedIsIn(myPed, false), -1) == myPed then
					if vehMenu.open == false and situation.type ~= "CUFFED" then
						if GetVehicleMod(myVeh, 16) == 0 then
							DisableControlAction(2, 75, 1)
							if IsControlPressed(1, 21) or IsDisabledControlPressed(1, 21) then -- SHIFT
								TaskLeaveVehicle(myPed, myVeh, 256)
							else
								TaskLeaveVehicle(myPed, myVeh, 0)
							end
							while IsPedInAnyVehicle(myPed, false) or IsPedInAnyVehicle(myPed, true) do
								SetVehicleEngineOn(myVeh, true, true)
								Wait(0)
							end
						else
							SetVehicleEngineOn(myVeh, false, true)
						end
					end
				end
			end
		elseif IsControlJustPressed(1, 244) or IsDisabledControlJustPressed(1, 244) and keyboardOpen == false then -- M
			if currentVoip == 'Whisper' then
				currentVoip = 'Normal'
				NetworkSetTalkerProximity(voip['normal'].distance)
			elseif currentVoip == 'Normal' then
				currentVoip = 'Yell'
				NetworkSetTalkerProximity(voip['yell'].distance)
			elseif currentVoip == 'Yell' then
				currentVoip = 'Whisper'
				NetworkSetTalkerProximity(voip['whisper'].distance)
			end
		elseif IsControlJustPressed(1, 10) or IsDisabledControlJustPressed(1, 10) then -- PAGE UP
			if enableCruise then
				if cruiseSpeed < maxSpeed then
					cruiseSpeed = cruiseSpeed + 0.5
					SetEntityMaxSpeed(myVeh, cruiseSpeed)
				end
			end
		elseif IsControlJustPressed(1, 11) or IsDisabledControlJustPressed(1, 11) then -- PAGE DOWN
			if enableCruise then
				if cruiseSpeed > 1.0 then
					cruiseSpeed = cruiseSpeed - 0.5
					SetEntityMaxSpeed(myVeh, cruiseSpeed)
				end
			end
		elseif IsControlPressed(1, 21) or IsDisabledControlPressed(1, 21) then -- SHIFT
			if IsPedInAnyVehicle(myPed, false) then
				DisableControlAction(1, 22, 1)
				DisableControlAction(0, 26, 1)
				if IsControlJustPressed(1, 22) or IsDisabledControlJustPressed(1, 22) then -- SPACE
					if IsPedInAnyVehicle(myPed, false) then
						if GetPedInVehicleSeat(myVeh, -1) == myPed then
							if enableCruise == false then
								cruiseSpeed = GetEntitySpeed(myVeh)
								SetEntityMaxSpeed(myVeh, cruiseSpeed)
								enableCruise = true
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							else
								SetEntityMaxSpeed(myVeh, maxSpeed)
								enableCruise = false
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
						end
					end
				elseif IsControlJustPressed(0, 26) or IsDisabledControlJustPressed(0, 26) then -- C
					if IsPedInAnyVehicle(myPed, false) then
						TaskShuffleToNextVehicleSeat(myPed, myVeh)
					end
				end
			end
		end
	end
end)


-- ========================================== CLIENT EVENTS ==========================================

RegisterNetEvent("vehicleDoorLock")
AddEventHandler('vehicleDoorLock', function(vehicle, flag)
	SetVehicleDoorsLocked(vehicle, flag)
end)

-- ========================================== HELPER FUNCTIONS ==========================================

function toggleLock(veh)
	if hasKey(veh) then
		local vCoord = GetEntityCoords(veh, false)
		if locked == false then
			TriggerServerEvent("lockVehicleDoors", veh, 2)
			locked = true
			ShowNotification("Doors Locked")
			TriggerServerEvent('InteractSound_SV:PlayAtCoord', vCoord.x, vCoord.y, vCoord.z, 10, "carLock")
		else
			TriggerServerEvent("lockVehicleDoors", veh, 1)
			locked = false
			ShowNotification("Doors Unlocked")
			TriggerServerEvent('InteractSound_SV:PlayAtCoord', vCoord.x, vCoord.y, vCoord.z, 10, "carUnlock")
		end
	end
end

function hotwireVehicle(veh)
	ShowNotification("Hotwiring car...")
	TriggerServerEvent("removeFromInventory", 0, 'Hotwire-Kit', 1)
	SetVehicleNeedsToBeHotwired(veh, true)
	--StartVehicleAlarm(veh)
	SetVehicleAlarm(veh, true)
	Wait(6000)
	SetVehicleModKit(veh, 0)
	SetVehicleMod(veh, 16, 0, false)
	SetVehicleNeedsToBeHotwired(veh, false)
	SetVehicleAlarm(veh, false)
end

function hasKey(vehicle)
	local playerHasThatKey = false
	local plate = GetVehicleNumberPlateText(vehicle)
	for i=1, #keys, 1 do
		if keys[i] == plate then
			playerHasThatKey = true
		end
	end
	return playerHasThatKey
end

function drawHud(vehicle)
	RequestStreamedTextureDict('speedo') while not HasStreamedTextureDictLoaded('speedo') do Citizen.Wait(0) end

	local speed = 0
	if GetEntitySpeed(vehicle) > 0 then speed = (GetEntitySpeed(vehicle)*2.236936) end
	local stringintSpeed = tostring(round(speed))
	drawRadarText(0.898, 0.82, 1.2, stringintSpeed, 255, 0, 0, 255, 1)
	drawRadarText(0.898, 0.88, 0.5, "MPH", 255, 0, 0, 255, 1)

	DrawSprite("speedo", "vehicle_base", 0.898, 0.88, 0.16, 0.22, 0.0, 255, 255, 255, 255)

	if GetVehicleEngineHealth(vehicle) < 900.0 and GetVehicleEngineHealth(vehicle) > 800.0 then
		DrawSprite("speedo", "vehicle_engine1", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif GetVehicleEngineHealth(vehicle) < 800.0 and GetVehicleEngineHealth(vehicle) > 700.0 then
		DrawSprite("speedo", "vehicle_engine2", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif GetVehicleEngineHealth(vehicle) < 700.0 then
		DrawSprite("speedo", "vehicle_engine3", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	end

	if GetVehicleMod(vehicle, 16) ~= -1 and hasKey(vehicle) then
		DrawSprite("speedo", "vehicle_key", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	end

	if enableCruise then
		DrawSprite("speedo", "vehicle_cruise", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	end

	for i=6, 9, 1 do
		HideHudComponentThisFrame(i)
	end
	drawSpeed(round(speed))
	drawGas(vehicle)
end

function drawGas(vehicle)
	if GetVehiclePetrolTankHealth(vehicle) > 900.0 then
		DrawSprite("speedo", "vehicle_gas8", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif GetVehiclePetrolTankHealth(vehicle) > 800.0 then
		DrawSprite("speedo", "vehicle_gas7", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif GetVehiclePetrolTankHealth(vehicle) > 700.0 then
		DrawSprite("speedo", "vehicle_gas6", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif GetVehiclePetrolTankHealth(vehicle) > 600.0 then
		DrawSprite("speedo", "vehicle_gas5", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif GetVehiclePetrolTankHealth(vehicle) > 500.0 then
		DrawSprite("speedo", "vehicle_gas4", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif GetVehiclePetrolTankHealth(vehicle) > 400.0 then
		DrawSprite("speedo", "vehicle_gas3", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif GetVehiclePetrolTankHealth(vehicle) > 300.0 then
		DrawSprite("speedo", "vehicle_gas2", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif GetVehiclePetrolTankHealth(vehicle) > 200.0 then
		DrawSprite("speedo", "vehicle_gas1", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif GetVehiclePetrolTankHealth(vehicle) <= 100.0 then
		DrawSprite("speedo", "vehicle_gas_light", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	end
end

function drawSpeed(speed)
	if speed > 130 then
		DrawSprite("speedo", "vehicle_speed13", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 120 then
		DrawSprite("speedo", "vehicle_speed12", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 110 then
		DrawSprite("speedo", "vehicle_speed11", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 100 then
		DrawSprite("speedo", "vehicle_speed10", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 90 then
		DrawSprite("speedo", "vehicle_speed9", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 80 then
		DrawSprite("speedo", "vehicle_speed8", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 70 then
		DrawSprite("speedo", "vehicle_speed7", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 60 then
		DrawSprite("speedo", "vehicle_speed6", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 50 then
		DrawSprite("speedo", "vehicle_speed5", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 40 then
		DrawSprite("speedo", "vehicle_speed4", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 30 then
		DrawSprite("speedo", "vehicle_speed3", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 20 then
		DrawSprite("speedo", "vehicle_speed2", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	elseif speed > 10 then
		DrawSprite("speedo", "vehicle_speed1", 0.898, 0.88, 0.16 ,0.22, 0.0, 255, 255, 255, 255)
	end
end

function checkSpikes(veh)
	local vehCoord = GetEntityCoords(veh)
	if DoesObjectOfTypeExistAtCoords(vehCoord.x, vehCoord.y, vehCoord.z, 0.9, GetHashKey("P_ld_stinger_s"), true) then
		removeSpike(0, 0.9)
        SetVehicleTyreBurst(veh, 0, false, 900.0)
        SetVehicleTyreBurst(veh, 1, false, 900.0)
		local rando = GetRandomIntInRange(1, 10)
		if rando > 3 then
			Wait(200)
			SetVehicleTyreBurst(veh, 2, false, 700.0)
			SetVehicleTyreBurst(veh, 3, false, 700.0)
			SetVehicleTyreBurst(veh, 4, false, 600.0)
			SetVehicleTyreBurst(veh, 5, false, 600.0)
			SetVehicleTyreBurst(veh, 6, false, 600.0)
			SetVehicleTyreBurst(veh, 7, false, 600.0)
		end
	end
end

function removeSpike(spike, range)
	local myPed = GetPlayerPed(-1)
	local vehCoord = {}
	if spike == 0 then
		if IsPedInAnyVehicle(myPed, false) then
			vehCoord = GetEntityCoords(GetVehiclePedIsIn(myPed, false))
		else
			vehCoord = GetEntityCoords(myPed)
		end
	else
		vehCoord = GetEntityCoords(spike)
	end

	if DoesObjectOfTypeExistAtCoords(vehCoord.x, vehCoord.y, vehCoord.z, range, GetHashKey("P_ld_stinger_s"), true) then
		local strip = GetClosestObjectOfType(vehCoord.x, vehCoord.y, vehCoord.z, range, GetHashKey("P_ld_stinger_s"), false, false, false)
		SetEntityAsMissionEntity(strip, true, true)
		DeleteObject(strip)
	end
end

function checkSpeedReason(veh, speed)
	if GetEntityHeightAboveGround(veh) >= 0.0 then
		if GetEntityHeightAboveGround(veh) > 10.0 then
			wasInAir = true
		else
			if wasInAir == true then
				cooldown = cooldown - 1
				if cooldown < 0 then
					wasInAir = false
					cooldown = 1600
				end
			else
				TriggerServerEvent("AntiCheat:Kicked", "Speed Modification", "Recorded Speed - " .. speed .. "mph")
			end
		end
	end
end

function checkBlacklist(car)
	if car then
		local carModel = GetEntityModel(car)
		local carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			TriggerServerEvent("AntiCheat:blacklistedVehicle")
			ShowNotification("~r~AntiCheat: Blacklisted vehicle!")
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(false, false)
end

function GetPlayerByEntityID(id)
	for i=0,32 do
		if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
	end
	return nil
end

function drawTxt(x, y, width, height, scale, text, r,g,b, a)
    SetTextFont(0)
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
