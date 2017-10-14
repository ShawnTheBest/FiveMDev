--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local vehEnter = { {67.2323, 3693.669, 40.01968}, {261.9021, -1149.543, 30.3405} }
local vehViewing = { {60.17, 3685.83, 39.834}, {254.8731, -1155.958, 29.25015} }
local vehSpawning = { {51.39, 3681.52, 39.742}, {240.2624, -1157.394, 29.30157} }
local vehHeading = {190.0, 230.0, 122.0}
local vehSpawnHeading = {330.0, 319.0, 120.0}
local vehColors = {0, 11, 4, 8, 27, 150, 33, 143, 135, 36, 38, 99, 88, 89, 49, 50, 54, 141, 62, 64, 73, 96, 94, 104, 99, 71, 142, 145, 107, 111, 112} -- 1-31

function showBikeMenu()
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.155, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Bike Dealer",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	if amenu.page ~= 0 then 
		DrawRect(0.87, 0.48, 0.16, 0.068, 0, 0, 0, 200)
		drawTxt(0.795, 0.45, 0.0, 0.0, 0.25, "ENTER - Buy",255,255,255,255)
		drawTxt(0.795, 0.48, 0.0, 0.0, 0.25, "LEFT/RIGHT - Cycle Color",255,255,255,255)
		drawTxt(0.795, 0.41, 0.0, 0.0, 0.35, "Price: ~g~$" .. vehMenu.cost,255,255,255,255)	
	end
	
	showBike()
	showNormalSelection()
	if amenu.page == 0 then -- Main Page
		amenu.title = "VEHICLE TYPES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Choppers",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Street Bikes",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Dirt Bikes",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "ATVs",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Mopeds",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Bicycles",255,255,255,255)	
	elseif amenu.page == 1 then -- Choppers
		amenu.title = "CHOPPERS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Western Daemon",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "LCC Hexer",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "LCC Innovation",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Western Sovereign",255,255,255,255)
	elseif amenu.page == 2 then -- Street Bikes
		amenu.title = "STREET BIKES"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/3",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Dinka Akuma",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Western Bagger",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Pegassi Bati 801",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Pegassi Bati 801RR",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Nagasaki Carbon RS",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Dinka Double-T",255,255,255,255)
	elseif amenu.page == 3 then -- Street Bikes
		amenu.title = "STREET BIKES"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/3",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Dinka Enduro",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Shitzu Hakuchou",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Principe Lectro",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Principe Nemesis",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Shitzu PCJ 600",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Pegassi Ruffian",255,255,255,255)
	elseif amenu.page == 4 then -- Street Bikes
		amenu.title = "STREET BIKES"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "3/3",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Dinka Thrust",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Shitzu Vader",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Dinka Vindicator",255,255,255,255)
	elseif amenu.page == 5 then -- Dirt Bikes
		amenu.title = "DIRT BIKES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Maibatsu Sanchez",255,255,255,255)
	elseif amenu.page == 6 then -- ATVs
		amenu.title = "ATVS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Nagasaki Blazer",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Nagasaki Hot Rod Blazer",255,255,255,255)
	elseif amenu.page == 7 then -- Mopeds
		amenu.title = "MOPEDS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Pegassi Faggio",255,255,255,255)
	elseif amenu.page == 8 then -- Bicycles
		amenu.title = "BICYCLES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "BMX",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Cruiser",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Fixter",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Tri-Cycles Race Bike",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Scorcher",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Whippet Race Bike",255,255,255,255)
	end
	
	
	
	-- ============================== KEY PRESSES ==============================
	
	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		if amenu.page > 2 and amenu.page < 5 then
			if amenu.row > 0 then
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				amenu.row = amenu.row-1
				if amenu.row == 0 then
					amenu.page = amenu.page - 1
					amenu.row = 6
				end
			end
		else
			if amenu.row > 1 then
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				amenu.row = amenu.row-1
			end
		end
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		if amenu.page == 0 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 1 then
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 2 then
			if amenu.row < 7 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
			if amenu.row == 7 then
				amenu.page = 3
				amenu.row = 1
			end
		elseif amenu.page == 3 then
			if amenu.row < 6 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
			if amenu.row == 7 then
				amenu.page = 4
				amenu.row = 1
			end
		elseif amenu.page == 4 then
			if amenu.row < 3 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 5 then
			if amenu.row < 1 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 6 then
			if amenu.row < 2 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 7 then
			if amenu.row < 1 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 8 then
			if amenu.row < 6 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		if vehMenu.color > 1 then vehMenu.color = vehMenu.color-1 else vehMenu.color = 31 end
		SetVehicleColours(GetVehiclePedIsIn(GetPlayerPed(-1), false), vehColors[vehMenu.color], vehColors[vehMenu.color])
		SetVehicleExtraColours(GetVehiclePedIsIn(GetPlayerPed(-1), false), vehColors[vehMenu.color], 4)
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
		if vehMenu.color < 31 then vehMenu.color = vehMenu.color+1 else vehMenu.color = 1 end
		SetVehicleColours(GetVehiclePedIsIn(GetPlayerPed(-1), false), vehColors[vehMenu.color], vehColors[vehMenu.color])
		SetVehicleExtraColours(GetVehiclePedIsIn(GetPlayerPed(-1), false), vehColors[vehMenu.color], 4)
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		if amenu.page == 0 then -- Main Page
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				amenu.page = 1
				amenu.row = 1
			elseif amenu.row == 2 then
				amenu.page = 2
				amenu.row = 1
			elseif amenu.row == 3 then
				amenu.page = 5
				amenu.row = 1
			elseif amenu.row == 4 then 
				amenu.page = 6
				amenu.row = 1
			elseif amenu.row == 5 then
				amenu.page = 7
				amenu.row = 1
			elseif amenu.row == 6 then
				amenu.page = 8
				amenu.row = 1
			end
		else
			if IsAnyVehicleNearPoint(vehSpawning[location][1], vehSpawning[location][2], vehSpawning[location][3], 5.0) == false then
				if bankStats.cash >= vehMenu.cost then						
					TriggerServerEvent("deductMoney", 0, vehMenu.cost)
					ShowNotification("Vehicle bought!")
					
					if GetVehiclePedIsIn(GetPlayerPed(-1), false) ~= false then
						local inCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						SetEntityAsMissionEntity(inCar, true, true)
						while DoesEntityExist(inCar) do
							Citizen.Wait(0)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(inCar))
						end
					else
						local lastCar = GetVehiclePedIsIn(GetPlayerPed(-1), true)
						SetEntityAsMissionEntity(lastCar, true, true)
						while DoesEntityExist(lastCar) do
							Citizen.Wait(0)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(lastCar))
						end
					end
					
					local carHash = GetHashKey(vehMenu.model)
					RequestModel(carHash)
					while not HasModelLoaded(carHash) do
						Citizen.Wait(0)
						drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
					end
					local newVeh = CreateVehicle(carHash, vehSpawning[location][1], vehSpawning[location][2], vehSpawning[location][3], vehSpawnHeading[3], true, false)
					SetVehicleOnGroundProperly(newVeh)
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), newVeh, -1)
					for i = 0,24 do
						SetVehicleModKit(newVeh,0)
						RemoveVehicleMod(newVeh,i)
					end
					SetVehicleColours(newVeh, vehColors[vehMenu.color], vehColors[vehMenu.color])
					SetVehicleExtraColours(newVeh, vehColors[vehMenu.color], 4)
					local color = vehColors[vehMenu.color]
					local plate = "P" .. GetRandomIntInRange(10, 99) .. "" .. GetRandomIntInRange(10, 99) .. "" .. GetRandomIntInRange(100, 999)
					SetVehicleNumberPlateText(newVeh, "" .. plate)
					amenu.show = 0
					phone('enable')
					TriggerEvent("AwesomeFreeze", false)
					SetEntityVisible(GetPlayerPed(-1), true, 0)
					vehMenu.open = false
					TriggerEvent("addKey", plate)
					TriggerServerEvent("AddToGarage", vehMenu.model, 'false', plate, color)
				else
					ShowNotification("~r~You don't have enough cash!")
				end
			else
				ShowNotification("~r~Spawn area is full!")
			end
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		if amenu.page == 0 then
			amenu.show = 0
			phone('enable')
			if GetVehiclePedIsIn(GetPlayerPed(-1), false) ~= false then
				local inCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				SetEntityAsMissionEntity(inCar, true, true)
				while DoesEntityExist(inCar) do
					Citizen.Wait(0)
					Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(inCar))
				end
			else
				local lastCar = GetVehiclePedIsIn(GetPlayerPed(-1), true)
				SetEntityAsMissionEntity(lastCar, true, true)
				while DoesEntityExist(lastCar) do
					Citizen.Wait(0)
					Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(lastCar))
				end
			end
			SetEntityCoords(GetPlayerPed(-1), vehEnter[location][1], vehEnter[location][2], vehEnter[location][3], 1, 0, 0, 1)
			TriggerEvent("AwesomeFreeze", false)
			SetEntityVisible(GetPlayerPed(-1), true, 0)
			vehMenu.open = false
		elseif amenu.page == 1 then
			amenu.page = 0
			amenu.row = 1
		elseif amenu.page == 2 or amenu.page == 3 or amenu.page == 4 then
			amenu.page = 0
			amenu.row = 2
		elseif amenu.page == 5 then
			amenu.page = 0
			amenu.row = 3
		elseif amenu.page == 6 then
			amenu.page = 0
			amenu.row = 4
		elseif amenu.page == 7 then
			amenu.page = 0
			amenu.row = 5
		elseif amenu.page == 8 then
			amenu.page = 0
			amenu.row = 6
		end	
	end
end






	-- ============================== MENU FUNCTIONS ==============================

function showBike()
	if amenu.page == 0 then -- Main Page
		if amenu.row == 1 then
			if vehMenu.model ~= "daemon" then spawnBike("daemon") end -- Choppers
		elseif amenu.row == 2 then
			if vehMenu.model ~= "akuma" then spawnBike("akuma") end -- Street Bikes
		elseif amenu.row == 3 then
			if vehMenu.model ~= "sanchez" then spawnBike("sanchez") end -- Dirt Bikes
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "blazer" then spawnBike("blazer") end -- ATVs
		elseif amenu.row == 5 then
			if vehMenu.model ~= "faggio" then spawnBike("faggio") end -- Mopeds
		elseif amenu.row == 6 then
			if vehMenu.model ~= "bmx" then spawnBike("bmx") end -- Bicycles
		end
	elseif amenu.page == 1 then -- Choppers
		if amenu.row == 1 then
			if vehMenu.model ~= "daemon" then spawnBike("daemon") end
			vehMenu.cost = 12000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "hexer" then spawnBike("hexer") end
			vehMenu.cost = 10000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "innovation" then spawnBike("innovation") end
			vehMenu.cost = 9000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "sovereign" then spawnBike("sovereign") end
			vehMenu.cost = 10000
		end
	elseif amenu.page == 2 then -- Street Bikes
		if amenu.row == 1 then
			if vehMenu.model ~= "akuma" then spawnBike("akuma") end
			vehMenu.cost = 14000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "bagger" then spawnBike("bagger") end
			vehMenu.cost = 13000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "bati" then spawnBike("bati") end
			vehMenu.cost = 15000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "bati2" then spawnBike("bati2") end
			vehMenu.cost = 15000
		elseif amenu.row == 5 then
			if vehMenu.model ~= "carbonrs" then spawnBike("carbonrs") end
			vehMenu.cost = 14000
		elseif amenu.row == 6 then
			if vehMenu.model ~= "double" then spawnBike("double") end
			vehMenu.cost = 12000
		end
	elseif amenu.page == 3 then -- Street Bikes
		if amenu.row == 1 then
			if vehMenu.model ~= "enduro" then spawnBike("enduro") end
			vehMenu.cost = 11000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "hakuchou" then spawnBike("hakuchou") end
			vehMenu.cost = 13000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "lectro" then spawnBike("lectro") end
			vehMenu.cost = 14000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "nemesis" then spawnBike("nemesis") end
			vehMenu.cost = 12000
		elseif amenu.row == 5 then
			if vehMenu.model ~= "pcj" then spawnBike("pcj") end
			vehMenu.cost = 10000
		elseif amenu.row == 6 then
			if vehMenu.model ~= "ruffian" then spawnBike("ruffian") end
			vehMenu.cost = 9000
		end
	elseif amenu.page == 4 then -- Street Bikes
		if amenu.row == 1 then
			if vehMenu.model ~= "thrust" then spawnBike("thrust") end
			vehMenu.cost = 10500
		elseif amenu.row == 2 then
			if vehMenu.model ~= "vader" then spawnBike("vader") end
			vehMenu.cost = 10000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "vindicator" then spawnBike("vindicator") end
			vehMenu.cost = 11000
		end
	elseif amenu.page == 5 then -- Dirt Bikes
		if amenu.row == 1 then
			if vehMenu.model ~= "sanchez" then spawnBike("sanchez") end
			vehMenu.cost = 4000
		end
	elseif amenu.page == 6 then -- ATVs
		if amenu.row == 1 then
			if vehMenu.model ~= "blazer" then spawnBike("blazer") end
			vehMenu.cost = 3500
		elseif amenu.row == 2 then
			if vehMenu.model ~= "blazer3" then spawnBike("blazer3") end
			vehMenu.cost = 3750
		end
	elseif amenu.page == 7 then -- Mopeds
		if amenu.row == 1 then
			if vehMenu.model ~= "faggio" then spawnBike("faggio") end
			vehMenu.cost = 600
		end
	elseif amenu.page == 8 then -- Bicycles
		if amenu.row == 1 then
			if vehMenu.model ~= "bmx" then spawnBike("bmx") end
			vehMenu.cost = 200
		elseif amenu.row == 2 then
			if vehMenu.model ~= "cruiser" then spawnBike("cruiser") end
			vehMenu.cost = 150
		elseif amenu.row == 3 then
			if vehMenu.model ~= "fixter" then spawnBike("fixter") end 
			vehMenu.cost = 400
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "tribike3" then spawnBike("tribike3") end
			vehMenu.cost = 700
		elseif amenu.row == 5 then
			if vehMenu.model ~= "scorcher" then spawnBike("scorcher") end
			vehMenu.cost = 500
		elseif amenu.row == 6 then
			if vehMenu.model ~= "tribike" then spawnBike("tribike") end
			vehMenu.cost = 800
		end
	end
end

function spawnBike(car)
	local pPed = GetPlayerPed(-1)
	local inCar = GetVehiclePedIsIn(pPed, false)
	local inModel = inCar
	local carHash = GetHashKey(car)
	if carHash ~= inModel then
		SetEntityAsMissionEntity(inCar, true, true)
		while DoesEntityExist(inCar) do
			Citizen.Wait(0)
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(inCar))
		end
	end
	
	RequestModel(carHash)
	while not HasModelLoaded(carHash) do
		Citizen.Wait(0)
		drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
	end
	local newVeh = CreateVehicle(carHash, vehViewing[location][1], vehViewing[location][2], vehViewing[location][3], vehHeading[2], false, false)
	SetVehicleOnGroundProperly(newVeh)
	FreezeEntityPosition(newVeh,true)
	SetEntityInvincible(newVeh,true)
	SetVehicleDoorsLocked(newVeh, 4)
	TaskWarpPedIntoVehicle(pPed, newVeh, -1)
	for i = 0,24 do
		SetVehicleModKit(newVeh,0)
		RemoveVehicleMod(newVeh,i)
	end
	vehMenu.model = car
	SetVehicleColours(newVeh, vehColors[vehMenu.color], vehColors[vehMenu.color])
	SetVehicleExtraColours(newVeh, vehColors[vehMenu.color], 4)
end