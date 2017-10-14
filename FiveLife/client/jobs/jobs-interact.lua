--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local gasStations = { {49.4187, 2778.793, 58.043}, {263.894, 2606.463, 44.983}, {263.894, 2606.463, 44.983}, {1039.958, 2671.134, 39.550}, {1207.260, 2660.175, 37.899}, {2539.685, 2594.192, 37.944}, {2679.858, 3263.946, 55.240}, {2005.055, 3773.887, 32.403}, {1687.156, 4929.392, 42.078}, {1701.314, 6416.028, 32.763}, {179.857, 6602.839, 31.868}, {-94.4619, 6419.594, 31.489}, {-2554.996, 2334.40, 33.078}, {-1800.375, 803.661, 138.651}, {-1437.622, -276.747, 46.207}, {-2096.243, -320.286, 13.168}, {-724.619, -935.1631, 19.213}, {-526.019, -1211.003, 18.184}, {-70.2148, -1761.792, 29.534}, {265.648, -1261.309, 29.292}, {819.653, -1028.846, 26.403}, {1208.951, -1402.567, 35.224}, {1181.381, -330.847, 69.316}, {620.843, 269.100, 103.089}, {2581.321, 362.039, 108.468} }
local gasCollection = {1698.32, -1537.76, 113.947}
local gasSelling = { {200.0, 6618.0, 31.0}, {-2527.0, 2341.0, 33.0}, {1781.0, 3328.0, 41.0}, {-2059.0, -305.0, 13.0} }
local truckingCollection = {1189.3, -3107.1, 5.56}
local truckingDropoffs = { {-18.4, 6264.1, 31.2}, {-800.4, 5403.9, 34.1}, {3574.2, 3656.2, 33.9}, {2043.4, 3178.5, 45.0}, {237.8, 2586.3, 45.3}, {-2339.3, 278.3, 169.5}, {-404.5, 1230.3, 325.6}, {-756.8, -2600.1, 13.8} }
local truckDropoff = {1218.7, -3087.2, 5.7}
local newsCollection = {-600.1, -930.1, 23.9}
local newsSpawn = {-542.8, -892.4, 24.7}
local cabCollection = {895.2, -179.3, 74.7}
local cabSpawn = {915.8, -164.0, 74.6}
local towCollection = { {-168.9, 6277.0, 31.5}, {2423.9, 3129.9, 48.2}, {410.6, -1623.9, 29.3} }
local towSpawns = { {-199.0, 6272.6, 31.5}, {2411.6, 3060.0, 48.2}, {389.8, -1620.4, 29.3} }
local busCollection = {471.2, -578.5, 28.5}
local busCheckpoints = { {2594.0, 361.6, 108.4}, {1658.3, 6412.3, 29.5}, {-223.4, 6204.4, 31.5}, {-3148.4, 1089.0, 20.7}, {-708.8, -935.7, 19.0}, {93.1, -1407.1, 29.1}, {444.4, -583.6, 28.5} }
local nextStop = 1
local gmenu = {row = 1}
local gasDropOff = {1686.0, -1568.0, 112.0}
local job_blips_interact = {}
local jobType = 0
local gasStation = false
local gasC = false
local gasS = 0
local gasD = false
local truckC = false
local truckS = 0
local truckD = false
local newsC = false
local cabC = false
local towC = 0
local busC = false
local busD = false
local busStop = 0
local gasPrice = 14
local gallons = 0
local fuel = 1
local lastTrailer = 0

local animation = 'idle_a'
local animDict = 'amb@prop_human_bum_bin@idle_a'
local flags = 48

function ShowJobInteractBlips(bool)
	if bool then
		drawJobInteractBlip(gasCollection, 415, 41, 'Fuel Transport')
		drawJobInteractBlip(truckingCollection, 306, 21, 'Trucking')
		drawJobInteractBlip(newsCollection, 457, 39, 'Weazel News')
		drawJobInteractBlip(cabCollection, 56, 46, 'Downtown Cab Co.')
		drawJobInteractBlip(busCollection, 326, 38, 'Dashound Bus')
		TriggerServerEvent("getFuelLevel")
		for i=1, #towCollection do
			drawJobInteractBlip(towCollection[i], 326, 44, 'Vehicle Impound')
		end
		for i=1, #gasStations do
			drawJobInteractBlip(gasStations[i], 361, 0, 'Gas Station')
		end
	elseif bool == false and #job_blips_interact > 0 then
		for i,b in ipairs(job_blips_interact) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		job_blips_interact = {}
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		checkJobInteractRange()
		checkJobDuties()
		
		if gasC then
			if job_status == 0 then
				ShowTip('Press ~INPUT_ENTER~ to open fuel menu.')
			else
				ShowTip('~r~Cancel current job first.')
			end
		elseif truckC then
			if job_status == 0 then
				ShowTip('Press ~INPUT_ENTER~ to open haul menu.')
			else
				ShowTip('~r~Cancel current job first.')
			end
		elseif newsC then
			if job_status == 0 then
				ShowTip('Press ~INPUT_ENTER~ to be a news reporter')
			else
				ShowTip('~r~Cancel current job first.')
			end
		elseif cabC then
			if job_status == 0 then
				ShowTip('Press ~INPUT_ENTER~ to be a taxi driver')
			else
				ShowTip('~r~Cancel current job first.')
			end
		elseif towC ~= 0 then
			if job_status == 0 then
				ShowTip('Press ~INPUT_ENTER~ to be a tow driver')
			else
				ShowTip('~r~Cancel current job first.')
			end
		elseif busC then
			if job_status == 0 then
				ShowTip('Press ~INPUT_ENTER~ to be a bus driver')
			else
				ShowTip('~r~Cancel current job first.')
			end
		elseif gasS ~= 0 then
			if gasS == job_status and IsVehicleAttachedToTrailer(job_vehicle) then
				ShowTip('Press ~INPUT_ENTER~ to unload fuel.')
			end
		elseif truckS ~= 0 then
			if truckS == job_status and IsVehicleAttachedToTrailer(job_vehicle) then
				ShowTip('Press ~INPUT_ENTER~ to unload haul.')
			end
		elseif gasD and job_status == 100 and IsVehicleAttachedToTrailer(job_vehicle) then
			ShowTip('Press ~INPUT_ENTER~ to exit rig and complete.')
		elseif truckD and job_status == 101 and IsVehicleAttachedToTrailer(job_vehicle) then
			ShowTip('Press ~INPUT_ENTER~ to exit rig and complete.')
		elseif busD and nextStop == 7 then
			ShowTip('Press ~INPUT_ENTER~ to exit bus and complete.')
		end
		if gasStation then
			ShowTip('Press ~INPUT_VEH_HANDBRAKE~ to refuel.')
		end

		if IsControlJustPressed(1, 23) or IsControlJustPressed(1, 23) then -- F
			if gasC then
				if job_status == 0 then
					PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					TriggerEvent("menu:openMenu", 17, 0)
				end
			elseif truckC then
				if job_status == 0 then
					PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					TriggerEvent("menu:openMenu", 18, 0)
				end
			elseif newsC then
				if job_status == 0 then
					spawnJobVeh(1)
				end
			elseif cabC then
				if job_status == 0 then
					spawnJobVeh(2)
				end
			elseif towC ~= 0 then
				if job_status == 0 then
					spawnJobVeh(3)
				end
			elseif busC then
				if job_status == 0 then
					spawnJobVeh(4)
				end
			elseif gasS ~= 0 then
				if gasS == job_status and IsVehicleAttachedToTrailer(job_vehicle)  then
					PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					ShowNotification("~b~Fuel unloaded. Drive back to depot to complete.")
					TriggerServerEvent("changeFuelLevel", 50)
					SetWaypointOff()
					SetNewWaypoint(1686.0, -1568.0)
					jobType = job_status
					job_status = 100
				end
			elseif truckS ~= 0 then
				if truckS == job_status and IsVehicleAttachedToTrailer(job_vehicle) then
					PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					ShowNotification("~b~Haul unloaded. Drive back to depot to complete.")
					SetWaypointOff()
					SetNewWaypoint(1218.7, -3087.2, 5.7)
					jobType = job_status
					job_status = 101
				end
			end
		end
		
		if gasStation then
			if IsControlJustPressed(1, 76) or IsDisabledControlJustPressed(1, 76) then -- SPACE
				gasMenu = true
				fuel = math.floor(GetVehiclePetrolTankHealth(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
			end
		elseif gasMenu then
			gasMenu = false
		end
		
		checkGasMenu()
	end
end)

RegisterNetEvent('Jobs:Tow')
AddEventHandler('Jobs:Tow', function()
	if job_status == 104 then
		if DoesEntityExist(job_vehicle) then
			local myPed = GetPlayerPed(-1)
			if not IsPedInAnyVehicle(myPed, false) then
				local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 5.0, 0.0)
				local vehicle = GetVehicleInDirection(GetEntityCoords(myPed), inFrontOfPlayer)
				if DoesEntityExist(vehicle) then
					if job_vehicle == vehicle then
						if currentTow ~= nil then
							AttachEntityToEntity(currentTow, job_vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
							DetachEntity(currentTow, true, true)
							currentTow = nil
							ShowNotification("~g~Vehicle detached!")
						else
							ShowNotification("~r~Can not tow your own truck!")
						end
					else
						if currentTow ~= nil then
							ShowNotification("~r~Can not tow more than one vehicle!")
						else
							if GetDistanceBetweenCoords(GetEntityCoords(job_vehicle, false), GetEntityCoords(vehicle, false), true) < 12 then
								local class = GetVehicleClass(vehicle)
								if class ~= 19 and class ~= 16 and class ~= 15 and class ~= 20 then
									currentTow = vehicle
									AttachEntityToEntity(currentTow, job_vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
									ShowNotification("~g~Vehicle attached!")
								else
									ShowNotification("~r~You can not tow that!")
								end
							else
								ShowNotification("~r~Vehicle must be closer to truck!")
							end
						end
					end
				else
					ShowNotification("~r~You must be facing a vehicle!")
				end
			else
				ShowNotification("~r~You must be outside the vehicle!")
			end
		else
			ShowNotification("~r~Flatbed does not exist!")
		end
	else
		ShowNotification("~r~You are not a tow driver!")
	end
end)

function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

function checkJobDuties()
	if job_status ~= 0 then
		if DoesEntityExist(job_vehicle) then
			if GetVehicleEngineHealth(job_vehicle) < 700.0 then
				ShowTip('~r~Repair the vehicle!')
			elseif not IsVehicleAttachedToTrailer(job_vehicle) and job_status > 99 and job_status < 102 then
				ShowTip('~r~Attach the trailer!')
			elseif not IsPedInVehicle(GetPlayerPed(-1), job_vehicle, false) and job_status ~= 102 and job_status ~= 103 and job_status ~= 104 then
				if job_status ~= 100 and job_status ~= 101 and not busD then
					ShowTip('~r~Get back inside the vehicle!')
				end
				if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					ShowNotification("~r~Job cancelled.")
					if DoesEntityExist(job_vehicle) then
						if IsVehicleAttachedToTrailer(job_vehicle) then
							local _, trailer = GetVehicleTrailerVehicle(job_vehicle)
							TriggerServerEvent("Job:deleteVehicle", trailer)
							TriggerServerEvent("Job:deleteVehicle", job_vehicle)
						elseif DoesEntityExist(lastTrailer) then
							TriggerServerEvent("Job:deleteVehicle", lastTrailer)
							TriggerServerEvent("Job:deleteVehicle", job_vehicle)
						else
							TriggerServerEvent("Job:deleteVehicle", job_vehicle)
						end
					end
					job_vehicle = 0
					job_status = 0
					jobType = 0
					SetWaypointOff()
				elseif gasD and IsVehicleAttachedToTrailer(job_vehicle) then
					local _, trailer = GetVehicleTrailerVehicle(job_vehicle)
					TriggerServerEvent("Job:FuelPayout", jobType)
					TriggerServerEvent("Job:deleteVehicle", trailer)
					TriggerServerEvent("Job:deleteVehicle", job_vehicle)
					job_status = 0
					job_vehicle = 0
					jobType = 0
				elseif truckD and IsVehicleAttachedToTrailer(job_vehicle) then
					local _, trailer = GetVehicleTrailerVehicle(job_vehicle)
					TriggerServerEvent("Job:HaulPayout", jobType)
					TriggerServerEvent("Job:deleteVehicle", trailer)
					TriggerServerEvent("Job:deleteVehicle", job_vehicle)
					job_status = 0
					job_vehicle = 0
					jobType = 0
				elseif busD and nextStop == 7 then
					TriggerServerEvent("Job:BusPayout")
					TriggerServerEvent("Job:deleteVehicle", job_vehicle)
					job_status = 0
					job_vehicle = 0
					jobType = 0
					nextStop = 1
				end
			elseif job_status == 105 then
				if busStop == nextStop then
					if nextStop == 6 then
						ShowNotification("~b~Head back to the depot to complete")
						nextStop = nextStop + 1
						SetNewWaypoint(busCheckpoints[nextStop][1], busCheckpoints[nextStop][2])
					else
						ShowNotification("~b~Head to the next stop")
						nextStop = nextStop + 1
						SetNewWaypoint(busCheckpoints[nextStop][1], busCheckpoints[nextStop][2])
					end
				end
			end
			if IsVehicleAttachedToTrailer(job_vehicle) then
				local _, lastTrailer = GetVehicleTrailerVehicle(job_vehicle)
			end
		end
	elseif job_vehicle ~= 0 then
		ShowNotification("~r~Job cancelled.")
		if DoesEntityExist(job_vehicle) then
			if IsVehicleAttachedToTrailer(job_vehicle) then
				local _, trailer = GetVehicleTrailerVehicle(job_vehicle)
				TriggerServerEvent("Job:deleteVehicle", trailer)
				TriggerServerEvent("Job:deleteVehicle", job_vehicle)
			elseif DoesEntityExist(lastTrailer) then
				TriggerServerEvent("Job:deleteVehicle", lastTrailer)
				TriggerServerEvent("Job:deleteVehicle", job_vehicle)
			else
				TriggerServerEvent("Job:deleteVehicle", job_vehicle)
			end
		end
		job_vehicle = 0
		job_status = 0
		jobType = 0
		SetWaypointOff()
	end
end







function checkJobInteractRange()
	-- Trucking
	if drawMarkerInteract(truckingCollection, 45, 5, false) == true then truckC = true else truckC = false end
	truckD = false
	if drawMarkerInteract(truckDropoff, 45, 10, false) == true then truckD = true end
	if drawMarkerInteract(truckDropoff, 45, 10, true) == true then truckD = true end
	truckS = 0
	for i=1, #truckingDropoffs, 1 do
		if drawMarkerInteract(truckingDropoffs[i], 45, 10, true) == true then
			truckS = i
		end
	end
	
	-- Fuel
	if drawMarkerInteract(gasCollection, 45, 5, false) == true then gasC = true else gasC = false end
	gasD = false
	if drawMarkerInteract(gasDropOff, 45, 10, false) == true then gasD = true end
	if drawMarkerInteract(gasDropOff, 45, 10, true) == true then gasD = true end
	gasS = 0
	for i=1, #gasSelling, 1 do
		if drawMarkerInteract(gasSelling[i], 45, 10, true) == true then 
			gasS = i
		end
	end
	
	-- Bus
	if drawMarkerInteract(busCollection, 45, 5, false) == true then busC = true else busC = false end
	busD = false
	if drawMarkerInteract(busCheckpoints[7], 45, 10, false) == true then busD = true end
	if drawMarkerInteract(busCheckpoints[7], 45, 10, true) == true then busD = true end
	busStop = 0
	for i=1, #busCheckpoints-1, 1 do
		if drawMarkerInteract(busCheckpoints[i], 45, 10, false) == true then 
			busStop = i
		end
	end
	
	
	-- Tow
	towC = 0
	for i=1, #towCollection, 1 do
		if drawMarkerInteract(towCollection[i], 45, 10, false) == true then 
			towC = i
		end
	end
	
	-- News
	if drawMarkerInteract(newsCollection, 45, 5, false) == true then newsC = true else newsC = false end
	
	-- Taxi
	if drawMarkerInteract(cabCollection, 45, 5, false) == true then cabC = true else cabC = false end
	
	-- Gas Stations
	gasStation = false
	for i=1, #gasStations, 1 do
		if drawMarkerInteract(gasStations[i], 45, 15, true) == true then
			gasStation = true
		end
	end
end

function drawMarkerInteract(tab, markerRange, useRange, activeInVehicle)
	local myPed = GetPlayerPed(-1)
	if activeInVehicle then
		if IsPedInAnyVehicle(myPed, false) then
			if GetDistanceBetweenCoords(tab[1],tab[2],tab[3], GetEntityCoords(myPed, true), true) < useRange then
				return true
			else
				return false
			end
		end
	else
		if GetDistanceBetweenCoords(tab[1],tab[2],tab[3], GetEntityCoords(myPed, true), true) < useRange then
			return true
		else
			return false
		end
	end
end

function drawJobInteractBlip(tab, sprite, color, name)
	local blip = AddBlipForCoord(tab[1], tab[2], tab[3])
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName(name)
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
	table.insert(job_blips_interact, {blip = blip})
end


function spawnJobVeh(job)
	SetWaypointOff()
	if job == 1 then
		job_status = 102
		local vehHash = GetHashKey("rumpo")
		RequestModel(vehHash)
		while not HasModelLoaded(vehHash) do
			Citizen.Wait(0)
			drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
		end
		job_vehicle = CreateVehicle(vehHash, -542.8, -892.4, 24.7, 172, true, false)
		if not DoesEntityExist(job_vehicle) then
			Wait(100)
		end
		SetVehicleNumberPlateText(job_vehicle, "PWEAZE" .. GetRandomIntInRange(1, 9))
		SetVehicleLivery(job_vehicle, 0)
	elseif job == 2 then
		job_status = 103
		local vehHash = GetHashKey("taxi")
		RequestModel(vehHash)
		while not HasModelLoaded(vehHash) do
			Citizen.Wait(0)
			drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
		end
		job_vehicle = CreateVehicle(vehHash, 915.8, -164.0, 74.6, 192, true, false)
		if not DoesEntityExist(job_vehicle) then
			Wait(100)
		end
		SetVehicleNumberPlateText(job_vehicle, "PTAXI-" .. GetRandomIntInRange(1, 9))
		SetVehicleWheelType(job_vehicle, 1)
		SetVehicleMod(job_vehicle, 23, 1, false)
	elseif job == 3 then
		job_status = 104
		local vehHash = GetHashKey("tow")
		RequestModel(vehHash)
		while not HasModelLoaded(vehHash) do
			Citizen.Wait(0)
			drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
		end
		job_vehicle = CreateVehicle(vehHash, towSpawns[towC][1], towSpawns[towC][2], towSpawns[towC][3], 192, true, false)
		if not DoesEntityExist(job_vehicle) then
			Wait(100)
		end
		SetVehicleNumberPlateText(job_vehicle, "PTOW-" .. GetRandomIntInRange(1, 9))
	elseif job == 4 then
		job_status = 105
		local vehHash = GetHashKey("coach")
		RequestModel(vehHash)
		while not HasModelLoaded(vehHash) do
			Citizen.Wait(0)
			drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
		end
		job_vehicle = CreateVehicle(vehHash, busCheckpoints[7][1], busCheckpoints[7][2], busCheckpoints[7][3], 192, true, false)
		if not DoesEntityExist(job_vehicle) then
			Wait(100)
		end
		SetVehicleNumberPlateText(job_vehicle, "PBUS-" .. GetRandomIntInRange(1, 9))
	end
	TriggerEvent("addKey", GetVehicleNumberPlateText(job_vehicle))
	SetEntityAsMissionEntity(job_vehicle, true, true)
	TriggerEvent("AwesomeFreeze", false)
	TaskWarpPedIntoVehicle(GetPlayerPed(-1), job_vehicle, -1)
	amenu.show = 0
	amenu.row = 1
	phone('enable')
	if job == 4 then
		ShowNotification("~b~Head to the first stop!")
		SetNewWaypoint(busCheckpoints[nextStop][1], busCheckpoints[nextStop][2])
	else
		ShowNotification("~b~Use ~y~/view [reportID] ~b~and ~y~/goto [reportID]")
	end
end

function checkGasMenu()
	if gasMenu then
		RequestStreamedTextureDict("commonmenu", true)
		while not HasStreamedTextureDictLoaded("commonmenu") do
			Citizen.Wait(1)
		end
		DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
		DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
		DrawRect(0.87, 0.155, 0.16, 0.034, 0, 0, 0, 255)
		drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Gas Station",255,255,255,255)
		drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, "BUY FUEL",30,88,162,255)
		
		if gmenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		
		if onDuty ~= 0 and onDuty < 5 then 
			gasPrice = 0
		else
			if totalFuelLevel < 150 then
				gasPrice = 25
			elseif totalFuelLevel < 300 then
				gasPrice = 18
			elseif totalFuelLevel < 500 then
				gasPrice = 15
			end
		end
		
		if totalFuelLevel > 0 then
			if fuel+(gallons*100) >= 1000 then
				if gasPrice ~= 0 then
					drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Gallons: Fill for $" .. gallons*gasPrice,255,255,255,255)
				else
					drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Gallons: Fill for Free",255,255,255,255)
				end
			else
				if gasPrice ~= 0 then
					drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Gallons: " .. gallons .. " for $" .. gallons*gasPrice,255,255,255,255)
				else
					drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Gallons: " .. gallons .. " for Free",255,255,255,255)
				end
			end
		else
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Gallons: Empty",255,255,255,255)
		end
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Total Fuel: " .. totalFuelLevel .. " gallons",255,255,255,255)
		
		if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
			if gmenu.row > 1 then 
				gmenu.row = gmenu.row-1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
			if gmenu.row < 1 then
				gmenu.row = gmenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
			if gmenu.row == 1 and totalFuelLevel > 0 then
				if fuel+(gallons*100) < 1000 then
					gallons = gallons + 1
				end
			end
		elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
			if gmenu.row == 1 and totalFuelLevel > 0 then
				if gallons > 0 then
					gallons = gallons - 1
				end
			end
		elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
			if gmenu.row == 1 and totalFuelLevel > 0 then
				if moneyCash >= gallons*gasPrice then
					local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					if gallons > 0 then
						if fuel+(gallons*100) >= 1000 then
							SetVehiclePetrolTankHealth(veh, 1000.0)
						else
							SetVehiclePetrolTankHealth(veh, fuel+(gallons*100.0))
						end
						ShowNotification(gallons .. " gallons bought for $" .. gallons*gasPrice)
						TriggerServerEvent("deductMoney", 0, gallons*gasPrice)
						TriggerServerEvent("changeFuelLevel", 0-gallons)
					end
					gasMenu = false
					gmenu.row = 1
					gallons = 0
				else
					ShowNotification("~r~Not enough cash!")
				end
			end
		elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
			gasMenu = false
			gmenu.row = 1
			gallons = 0
		end
	end
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		ShowJobInteractBlips(true)
		firstspawn = 1
	end
end)