--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local bankSpots = { {-113.995, 6470.18, 31.6267}, {1174.96, 2706.8, 38.094}, {-2962.47, 482.981, 15.7031}, {-1212.52, -330.651, 37.787}, {149.951, -1040.75, 29.3741}, {247.533, 223.289, 106.287}, {252.558, 221.358, 106.286}, {242.274, 225.078, 106.287} }
local generalStoreSpots = { {1960.34, 3742.14, 32.3438}, {1729.78, 6416.22, 35.0372}, {1699.44, 4923.52, 42.0637}, {2677.12, 3281.31, 55.2411}, {548.116, 2669.46, 42.1565}, {-3242.89, 1001.4, 12.8307}, {-3040.98, 585.228, 7.90893}, {-1821.62, 794.022, 138.115}, {374.205, 327.729, 103.566}, {1163.39, -322.174, 69.2052}, {2555.53, 382.162, 108.623}, {-707.409, -912.866, 19.2156}, {25.7084, -1345.73, 29.497}, {-47.2384, -1756.66, 29.421} }
local gunStoreSpots = { {810.1309, -2157.711, 29.61899}, {842.442, -1033.869, 28.194}, {22.009, -1106.745, 29.797}, {-662.126, -934.829, 21.829}, {-1305.474, -394.352, 36.695}, {252.587, -50.125, 69.941}, {2567.964, 293.9637, 108.735}, {-3172.353, 1087.727, 20.839}, {-1118.117, 2698.774, 18.554}, {1693.164, 3760.086, 34.7053}, {-330.699, 6084.073, 31.455} }
local lowClothingSpots = { {71.4065, -1398.73, 29.3761}, {1696.99, 4829.15, 42.0631}, {-1108.46, 2709.52, 19.1079}, {1190.78, 2714.06, 38.2226}, {11.6799, 6513.63, 31.8778}, {429.398, -800.449, 29.2911}, {-829.391, -1073.22, 11.3281}, {-1187.94, -768.688, 17.3253}, {617.732, 2766.73, 42.0881}, {120.999, -226.066, 54.5578}, {-3175.47, 1041.83, 20.8632} }
local highClothingSpots = { {-708.469, -160.666, 37.4152}, {-158.48, -296.857, 39.7333}, {-1457.22, -241.372, 49.8057} }
local barberSpots = { {-813.081, -183.619, 37.5689}, {138.125, -1706.32, 29.2916}, {-1280.68, -1117.11, 6.99011}, {1930.48, 3732.15, 32.8444}, {1214.63, -473.193, 66.208}, {-33.629, -154.524, 57.0765}, {-276.33, 6226.61, 31.6955} }
local carStoreSpots = { {67.2323, 3693.669, 40.01968}, {-43.00457, 1880.931, 195.9384}, {265.6327, 2599.901, 44.76222}, {-41.4628, -1675.51, 29.4233}, {120.1437, 6625.944, 31.9556}, {-34.1066, -1102.26, 26.42233}, {287.03,-1147.336,29.29191} }
local boatStoreSpots = { {-1600.926, 5204.92, 4.310093}, {1299.333, 4226.071, 33.90868}, {-764.4886, -1375.161,1.59521} }
local planeStoreSpots = { {1732.743, 3309.687, 41.22346}, {-983.6029, -2992.434, 13.94518}, {2133.169, 4784.824, 40.9703} }
local garageUseSpots = { {-223.413, 6243.236, 30.4}, {181.207, 2793.512, 44.55}, {-789.7234, 307.146, 84.52}, {809.9477, -923.6013, 24.9}, {-659.4764, -2369.043, 12.87}, {-3186.05, 1273.707, 11.57} }
local garageReturnSpots = { {-221.522, 6248.501, 31.491}, {188.268, 2786.999, 45.6103}, {-791.6349, 333.4494, 85.7005}, {815.1071, -921.9573, 26.06298}, {-674.0284, -2391.265, 13.89032}, {-3182.99, 1277.412, 12.7295} }
local carCustomsSpots = { }
local dmvSpots = { {437.9903, -624.4621, 28.7086}, {} }
local blips = {}
local bank = false
local generalStore = false
local gunStore = false
local lowClothing = false
local highClothing = false
local barber = false
local motorcycle1 = false
local motorcycle2 = false
local truck = false
local car1 = false
local car2 = false
local car3 = false
local exotic = false
local garage1 = false
local garage2 = false
local garage3 = false
local garage4 = false
local garage5 = false
local garage6 = false
local returnCar = false

function ShowStoreBlips(bool)
	if bool then
		for i=1, 6, 1 do
			drawStoreBlip(bankSpots[i], 374, 13, 'Bank')
		end
		for i=1, 14, 1 do
			drawStoreBlip(generalStoreSpots[i], 59, 4, 'General Store')
		end
		for i=1, 11, 1 do
			drawStoreBlip(gunStoreSpots[i], 110, 4, 'Gun Store')
		end
		for i=1, 11, 1 do
			drawStoreBlip(lowClothingSpots[i], 73, 4, 'Clothing Store')
		end
		for i=1, 3, 1 do
			drawStoreBlip(highClothingSpots[i], 73, 5, 'Ponsonbys')
		end
		for i=1, 3, 1 do
			drawStoreBlip(barberSpots[i], 71, 4, 'Barber Shop')
		end
		for i=1, 3, 1 do
			drawStoreBlip(boatStoreSpots[i], 356, 4, 'Boat Dock')
		end
		for i=1, 3, 1 do
			drawStoreBlip(planeStoreSpots[i], 359, 4, 'Plane Hanger')
		end
		for i=1, 1, 1 do
			drawStoreBlip(dmvSpots[i], 357, 4, 'DMV')
		end
		for i=1, 6, 1 do
			drawStoreBlip(garageReturnSpots[i], 50, 4, 'Garage')
		end
		
		drawStoreBlip(carStoreSpots[1], 226, 4, 'Motorcycle Dealer') -- Sandy
		drawStoreBlip(carStoreSpots[7], 226, 4, 'Motorcycle Dealer') -- LS
		drawStoreBlip(carStoreSpots[2], 67, 4, 'Truck Dealer')
		drawStoreBlip(carStoreSpots[3], 225, 4, 'Car Dealership') -- Sandy
		drawStoreBlip(carStoreSpots[4], 225, 4, 'Car Dealership') -- LS
		drawStoreBlip(carStoreSpots[5], 225, 4, 'Car Dealership') -- Paleto
		drawStoreBlip(carStoreSpots[6], 225, 5, 'Exotic Car Dealer')
		
		Citizen.CreateThread(function()
			while #blips > 0 do
				Citizen.Wait(0)
				checkStoreRange()
			end
		end)
	elseif bool == false and #blips > 0 then
		for i,b in ipairs(blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		blips = {}
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
	
		if bank then
			ShowTip('Press ~INPUT_ENTER~ to use bank.')
		elseif generalStore then
			ShowTip('Press ~INPUT_ENTER~ to use store.')
		elseif gunStore then
			ShowTip('Press ~INPUT_ENTER~ to use store.')
		elseif lowClothing then
			ShowTip('Press ~INPUT_ENTER~ to use store.')
		elseif highClothing then
			ShowTip('Press ~INPUT_ENTER~ to use store.')
		elseif barber then
			ShowTip('Press ~INPUT_ENTER~ to use shop.')
		elseif motorcycle1 or motorcycle2 or truck or car1 or car2 or car3 or exotic then
			ShowTip('Press ~INPUT_ENTER~ to use shop.')
		elseif garage1 or garage2 or garage3 or garage4 or garage5 or garage6 then
			ShowTip('Press ~INPUT_ENTER~ to use garage.')
		elseif returnCar then
			ShowTip('Press ~INPUT_ENTER~ to store car.')
		end
		
		if IsControlJustPressed(1, 23) or IsDisabledControlJustPressed(1, 23) then -- F
			if bank then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 2, 0)
			elseif generalStore then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 3, 0)
			elseif gunStore then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 4, 0)
			elseif lowClothing then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 6, 0)
			elseif highClothing then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 7, 0)
			elseif barber then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 8, 0)
			elseif car1 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 10, 1)
			elseif car2 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 10, 2)
			elseif car3 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 10, 3)
			elseif exotic then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 12, 0)
			elseif motorcycle1 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 13, 1)
			elseif motorcycle2 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 13, 2)
			elseif truck then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				--TriggerEvent("menu:openMenu", 10, 6)
				ShowNotification("This store is closed. Please come back later.")
			elseif garage1 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 11, 1)
			elseif garage2 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 11, 2)
			elseif garage3 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 11, 3)
			elseif garage4 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 11, 4)
			elseif garage5 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 11, 5)
			elseif garage6 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("menu:openMenu", 11, 6)
			elseif returnCar then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				TriggerEvent("returnCarToGarage")
			end
		end
	end
end)

function checkStoreRange()
	bank = false
	for i=1, 8, 1 do
		if drawMarker(bankSpots[i], 20, 1.5, 0) == true then
			bank = true
		end
	end
	generalStore = false
	for i=1, 14, 1 do
		if drawMarker(generalStoreSpots[i], 20, 1.5, 0) == true then
			generalStore = true
		end
	end
	gunStore = false
	for i=1, 11, 1 do
		if drawMarker(gunStoreSpots[i], 20, 1.5, 0) == true then
			gunStore = true
		end
	end
	lowClothing = false
	for i=1, 11, 1 do
		if drawMarker(lowClothingSpots[i], 20, 1.5, 0) == true then
			lowClothing = true
		end
	end
	highClothing = false
	for i=1, 3, 1 do
		if drawMarker(highClothingSpots[i], 20, 1.5, 0) == true then
			highClothing = true
		end
	end
	barber = false
	for i=1, 3, 1 do
		if drawMarker(barberSpots[i], 20, 1.5, 0) == true then
			barber = true
		end
	end
	
	-- Vehicle Shops
	if drawMarker(carStoreSpots[1], 20, 1.5, 0) == true then motorcycle1 = true else motorcycle1 = false end
	if drawMarker(carStoreSpots[7], 20, 1.5, 0) == true then motorcycle2 = true else motorcycle2 = false end
	if drawMarker(carStoreSpots[2], 20, 1.5, 0) == true then truck = true else truck = false end
	if drawMarker(carStoreSpots[3], 20, 1.5, 0) == true then car1 = true else car1 = false end
	if drawMarker(carStoreSpots[4], 20, 1.5, 0) == true then car2 = true else car2 = false end
	if drawMarker(carStoreSpots[5], 20, 1.5, 0) == true then car3 = true else car3 = false end
	if drawMarker(carStoreSpots[6], 20, 1.5, 0) == true then exotic = true else exotic = false end
	-- Garages
	returnCar = false
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
		if drawMarker(garageUseSpots[1], 15, 1.5, 1) == true then garage1 = true else garage1 = false end
		if drawMarker(garageUseSpots[2], 15, 1.5, 1) == true then garage2 = true else garage2 = false end
		if drawMarker(garageUseSpots[3], 15, 1.5, 1) == true then garage3 = true else garage3 = false end
		if drawMarker(garageUseSpots[4], 15, 1.5, 1) == true then garage4 = true else garage4 = false end
		if drawMarker(garageUseSpots[5], 15, 1.5, 1) == true then garage5 = true else garage5 = false end
		if drawMarker(garageUseSpots[6], 15, 1.5, 1) == true then garage6 = true else garage6 = false end
	else
		garage1 = false garage2 = false garage3 = false garage4 = false garage5 = false garage6 = false
		for i=1, 6, 1 do
			if drawVehicleMarker(garageReturnSpots[i], 20, 2.0, 0) == true then
				returnCar = true
			end
		end
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

function drawVehicleMarker(tab, markerRange, useRange, markerTrue)
	local myPed = GetPlayerPed(-1)
	if GetDistanceBetweenCoords(tab[1],tab[2],tab[3], GetEntityCoords(myPed, true), true) < markerRange then
		if markerTrue == 1 then DrawMarker(1,tab[1],tab[2],tab[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0) end
		if IsPedInAnyVehicle(myPed, false) and GetDistanceBetweenCoords(tab[1],tab[2],tab[3], GetEntityCoords(myPed, true), true) < useRange then
			local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(myPed, false))
			if plate:sub(1,1) == 'P' then
				return true
			else
				return false
			end
		else
			return false
		end
	end
end

function drawStoreBlip(tab, sprite, color, name)
	local blip = AddBlipForCoord(tab[1],tab[2],tab[3])
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName('' .. name)
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
	table.insert(blips, {blip = blip})
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		ShowStoreBlips(true)
		firstspawn = 1
	end
end)