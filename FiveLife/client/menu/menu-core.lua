--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

-- Global menu variables (Should add more unique names)
amenu = {show = 0, row = 0, page = 0, title = "", input = 0, texture = 0, maxTexture = 0, field = 1, field1 = 5, field2 = 5, field3 = 5, maxRow = 1}
model = {gender = 'male', head = 0, beard = 0, hair = 0, armType = 0, legs = 0, parachute = 0, shoes = 0, neck = 0, underShirt = 0, armor = 0, badges = 0, overShirt = 0, hat = 11, glasses = 0, eyebrows = 0, tattoos = 0, watches = 0}
texture = {head = 0, beard = 1, beard2 = 1.0, hair = 1, hair2 = 1, armType = 0, legs = 0, parachute = 0, shoes = 0, neck = 0, underShirt = 0, armor = 0, badges = 0, overShirt = 0, hat = 0, glasses = 0, eyebrows = 1, tattoos = 0, eyes = 0, watches = 0}
face = {shapeFirst = 0, shapeSecond = 0, skinFirst = 1, skinSecond = 1, shapeMix = 0.5, skinMix = 0.5}
hairColor = {0, 60, 59, 58, 13, 29, 28, 27, 26, 42, 40, 38, 31, 54, 20, 47, 46}
skinColor = {0, 16, 6, 4, 10, 8, 2}
cStoreModel = {head = 0, beard = 0, hair = 0, armType = 0, legs = 0, parachute = 0, shoes = 0, neck = 0, underShirt = 0, armor = 0, badges = 0, overShirt = 0, hat = 0, glasses = 0, eyebrows = 0, tattoos = 0, watches = 0}
cStoreTexture = {head = 0, beard = 1, beard2 = 1.0, hair = 1, hair2 = 1, armType = 0, legs = 0, parachute = 0, shoes = 0, neck = 0, underShirt = 0, armor = 0, badges = 0, overShirt = 0, hat = 0, glasses = 0, eyebrows = 1, tattoos = 0, eyes = 0, watches = 0}
vehViewing = { {261.9929, 2578.813, 45.07617}, {-51.81469, -1685.387, 29.49171}, {128.606, 6660.217, 31.68045}, {-46.56, -1097.38, 26.0}, {60.17, 3685.83, 39.834}, {254.8731, -1155.958, 29.25015} }
prices = {hat = 0, glasses = 0, neck = 0, underShirt = 0, overShirt = 0, legs = 0, shoes = 0, total = 0}
vehicleInfo = {vehicle = "", plate = "", color1 = 0, color2 = 0, engine = 0, trans = 0, brakes = 0, tint = 0, wheelType = 0, wheel = 0, spoiler = 0, fbump = 0, rbump = 0, skirt = 0, grille = 0, hood = 0, roof = 0}
vehMenu = {page = 0, maxPage = 0, cost = 0, model = "emperor", color = 1, open = false}
licenses = {handgun = false, rifle = false, truck = false}
bankStats = {account = 0, cash = 0}
currentPlayers = {}
admin_lastLocation = {}
location = 0

local menuList = {"SPAWN", "BANK", "STORE", "GUN", "PLAYER", "LOWCLOTHES", "HIGHCLOTHES", "BARBER", "RESERVED", "VEHICLE", "GARAGE", "EXOTIC", "BIKE", "RESERVED", "ADMIN", "DEBUG", "JOB-FUEL", "JOB-TRUCKING", "COSMETIC"}

Citizen.CreateThread(function()
	while true do
		Wait(0)
		
		if amenu.show == 1 then
			showSpawnMenu()
		elseif amenu.show == 2 then
			showBankMenu()
		elseif amenu.show == 3 then
			showStoreMenu()
		elseif amenu.show == 4 then
			showGunMenu()
		elseif amenu.show == 5 then
			showPlayerMenu()
		elseif amenu.show == 6 then
			showLowClothesMenu_m()
		elseif amenu.show == 7 then
			showHighClothesMenu()
		elseif amenu.show == 8 then
			showBarberMenu()
		elseif amenu.show == 9 then
			showLowClothesMenu_f()
		elseif amenu.show == 10 then
			showVehicleMenu()
		elseif amenu.show == 11 then
			showGarageMenu()
		elseif amenu.show == 12 then
			showExoticMenu()
		elseif amenu.show == 13 then
			showBikeMenu()
		elseif amenu.show == 15 then
			showAdminMenu()
		elseif amenu.show == 16 then
			showDebugMenu()
		elseif amenu.show == 17 then
			showFuelMenu()
		elseif amenu.show == 18 then
			showTruckingMenu()
		elseif amenu.show == 19 then
			showCosmeticMenu()
		end
	end
end)





-- ============================================== CLIENT EVENTS ==============================================

RegisterNetEvent("menu:openMenu")
AddEventHandler("menu:openMenu", function(menu, second)
	if amenu.show == 0 then
		if GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01") then
			model.gender = 'male'
			updateClothes()
		elseif GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01") then
			model.gender = 'female'
			updateClothes()
		end
		PlaySound(-1, "FocusIn", "HintCamSounds", 0, 0, 1)
		bankStats.account = moneyBank
		bankStats.cash = moneyCash
		phone('disable')
		amenu.show = tonumber(menu)
		amenu.page = 0
		amenu.row = 1
		amenu.input = 0
		if menuList[menu] ~= "ADMIN" and menuList[menu] ~= "PLAYER" and menuList[menu] ~= "DEBUG" then TriggerEvent("AwesomeFreeze", true) end
		if menuList[menu] == "SPAWN" then
			SetEntityCoords(GetPlayerPed(-1), 8.46, -1674.91, 300.0)
			SetEntityVisible(GetPlayerPed(-1), false)
		elseif menuList[menu] == "GUN" then
			licenses.handgun = hasLicense('handgun')
		elseif menuList[menu] == "PLAYER" then
			updateFace()
		elseif menuList[menu] == "LOWCLOTHES" or menuList[menu] == "HIGHCLOTHES" or menuList[menu] == "BARBER" then
			prices.hat = 0 prices.glasses = 0 prices.neck = 0 prices.underShirt = 0 
			prices.overShirt = 0 prices.legs = 0 prices.shoes = 0 prices.total = 0
			saveClothes(0)
			if model.gender == 'female' and menuList[menu] == "LOWCLOTHES" then
				amenu.show = 9
			elseif model.gender == 'female' and menuList[menu] == "HIGHCLOTHES" then
				ShowNotification("~r~Under Development")
				amenu.show = 0
			end
		elseif menuList[menu] == "VEHICLE" then
			location = second
			SetEntityCoords(GetPlayerPed(-1), vehViewing[second][1], vehViewing[second][2], vehViewing[second][3])
			SetEntityVisible(GetPlayerPed(-1), false)
			vehMenu.model = "emperor"
			vehMenu.open = true
		elseif menuList[menu] == "GARAGE" then
			location = second
			vehicleInfo.plate = ""
			TriggerServerEvent("GetGarageVehicles")
		elseif menuList[menu] == "ADMIN" then
			admin_lastLocation = GetEntityCoords(GetPlayerPed(-1), true)
			SetEntityVisible(GetPlayerPed(-1), false)
			TriggerEvent("AwesomeGod", true)
			getCurrentPlayersActive()
		elseif menuList[menu] == "EXOTIC" then
			SetEntityCoords(GetPlayerPed(-1), vehViewing[4][1], vehViewing[4][2], vehViewing[4][3])
			SetEntityVisible(GetPlayerPed(-1), false)
			vehMenu.model = "ninef"
			vehMenu.open = true
		elseif menuList[menu] == "BIKE" then
			location = second
			SetEntityCoords(GetPlayerPed(-1), vehViewing[4+second][1], vehViewing[4+second][2], vehViewing[4+second][3])
			SetEntityVisible(GetPlayerPed(-1), false)
			vehMenu.model = "daemon"
			vehMenu.open = true
		elseif menuList[menu] == "JOB-FUEL" or menuList[menu] == "JOB-TRUCKING" then
			licenses.truck = hasLicense('truck')
		end
	end
end)

RegisterNetEvent("LoadVehicleInfo")
AddEventHandler("LoadVehicleInfo", function(vehicle, plate, color1, color2, engine, trans, brakes, tint, wheelType, wheel, spoiler, fbump, rbump, skirt, grille, hood, roof)
	vehicleInfo.plate = plate
	vehicleInfo.color1 = tonumber(color1)
	vehicleInfo.color2 = tonumber(color2)
	vehicleInfo.engine = tonumber(engine)
	vehicleInfo.trans = tonumber(trans)
	vehicleInfo.brakes = tonumber(brakes)
	vehicleInfo.tint = tonumber(tint)
	vehicleInfo.wheelType = tonumber(wheelType)
	vehicleInfo.wheel = tonumber(wheel)
	vehicleInfo.spoiler = tonumber(spoiler)
	vehicleInfo.fbump = tonumber(fbump)
	vehicleInfo.rbump = tonumber(rbump)
	vehicleInfo.skirt = tonumber(skirt)
	vehicleInfo.grille = tonumber(grille)
	vehicleInfo.hood = tonumber(hood)
	vehicleInfo.roof = tonumber(roof)
end)

RegisterNetEvent("returnCarToGarage")
AddEventHandler("returnCarToGarage", function()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	local plate = GetVehicleNumberPlateText(vehicle)
	TriggerServerEvent("ReturnVehicle", plate)
	SetEntityAsMissionEntity(vehicle, true, true)
	while DoesEntityExist(vehicle) do
		Citizen.Wait(0)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
	end
end)

RegisterNetEvent("LoadBasics")
AddEventHandler("LoadBasics", function(gender, shape1, shape2, skin1, skin2, shapeM, skinM, beard1, beard2, beard3, hair1, hair2, hair3, eyebrow1, eyebrow2, eye1)
	model.gender = tostring(gender) -- Gender
	local hash = GetHashKey('mp_m_freemode_01')
	if gender == 'female' then 
		hash = GetHashKey('mp_f_freemode_01')
	end
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		Citizen.Wait(0)
	end
	SetPlayerModel(PlayerId(), hash)
	face.shapeFirst = tonumber(shape1)
	face.shapeSecond = tonumber(shape2)
	face.skinFirst = tonumber(skin1)
	face.skinSecond = tonumber(skin2)
	face.shapeMix = tonumber(shapeM)
	face.skinMix = tonumber(skinM)
	model.beard = tonumber(beard1)
	texture.beard = tonumber(beard2)
	if beard3 == nil then texture.beard2 = 1.0 else texture.beard2 = tonumber(beard3) end
	model.hair = tonumber(hair1)
	texture.hair = tonumber(hair2)
	texture.hair2 = tonumber(hair3)
	model.eyebrows = tonumber(eyebrow1)
	texture.eyebrows = tonumber(eyebrow2)
	texture.eyes = tonumber(eye1)
	Wait(250)
	updateFace()
end)

RegisterNetEvent("LoadClothing")
AddEventHandler("LoadClothing", function(arm1, arm2, legs1, legs2, para1, para2, shoes1, shoes2, neck1, neck2, under1, under2, armor1, armor2, badges1, badges2, over1, over2, hat1, hat2, glasses1, glasses2, watches, tats)
	model.armType = tonumber(arm1)
	texture.armType = tonumber(arm2)
	model.legs = tonumber(legs1)
	texture.legs = tonumber(legs2)
	model.parachute = tonumber(para1)
	texture.parachute = tonumber(para2)
	model.shoes = tonumber(shoes1)
	texture.shoes = tonumber(shoes2)
	model.neck = tonumber(neck1)
	texture.neck = tonumber(neck2)
	model.underShirt = tonumber(under1)
	texture.underShirt = tonumber(under2)
	model.armor = tonumber(armor1)
	texture.armor = tonumber(armor2)
	model.badges = tonumber(badges1)
	texture.badges = tonumber(badges2)
	model.overShirt = tonumber(over1)
	texture.overShirt = tonumber(over2)
	model.hat = tonumber(hat1)
	texture.hat = tonumber(hat2)
	model.glasses = tonumber(glasses1)
	texture.glasses = tonumber(glasses2)
	model.watches = tonumber(watches)
	model.tattoos = tonumber(tats)
	Wait(250)
	updateClothes()
end)

RegisterNetEvent("sync:updatePlayer")
AddEventHandler("sync:updatePlayer", function()
	updateFace()
	updateClothes()
end)

-- ============================================== CORE FUNCTIONS ==============================================

function spawnJobVehicle(vehHash, x, y, z, head)
	RequestModel(vehHash)
	while not HasModelLoaded(vehHash) do
		Citizen.Wait(0)
		drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
	end
	local vehicle = CreateVehicle(vehHash, x, y, z, head, true, false)
	
	return vehicle
end

function updateFace()
	local myPed = GetPlayerPed(-1)
	SetPedHeadBlendData(myPed, face.shapeFirst, face.shapeSecond, 0, skinColor[face.skinFirst], skinColor[face.skinSecond], 0, face.shapeMix, face.skinMix, 0.0, false)
	SetPedComponentVariation(myPed, 2, model.hair, 0, 0)
	SetPedHairColor(myPed, hairColor[texture.hair], hairColor[texture.hair2])
	SetPedHeadOverlay(myPed, 2, model.eyebrows, 1.0)
	SetPedHeadOverlayColor(myPed, 2, 1, hairColor[texture.eyebrows], 0)
	SetPedEyeColor(myPed, texture.eyes)
	if model.gender == 'male' then
		SetPedHeadOverlay(myPed, 1, model.beard, texture.beard2)
		SetPedHeadOverlayColor(myPed, 1, 1, hairColor[texture.beard], 0)
	end
end

function updateClothes()
	local myPed = GetPlayerPed(-1)
	SetPedComponentVariation(myPed, 3, model.armType, texture.armType, 0)
	SetPedComponentVariation(myPed, 4, model.legs, texture.legs, 0)
	SetPedComponentVariation(myPed, 5, model.parachute, texture.parachute, 0)
	SetPedComponentVariation(myPed, 6, model.shoes, texture.shoes, 0)
	SetPedComponentVariation(myPed, 7, model.neck, texture.neck, 0)
	SetPedComponentVariation(myPed, 8, model.underShirt, texture.underShirt, 0)
	SetPedComponentVariation(myPed, 9, model.armor, texture.armor, 0)
	SetPedComponentVariation(myPed, 10, model.badges, texture.badges, 0)
	SetPedComponentVariation(myPed, 11, model.overShirt, texture.overShirt, 0)
	SetPedPropIndex(myPed, 0, model.hat, texture.hat, true)
	if model.hat == 11 or model.hat == 57 then
		ClearPedProp(myPed, 0)
	end
	SetPedPropIndex(myPed, 1, model.glasses, texture.glasses, true)
	if model.glasses == 5 or model.glasses == 6 then
		ClearPedProp(myPed, 1)
	end
end

function showNormalSelection()
	local offset = 0.04 * amenu.row
	DrawRect(0.87, 0.15+offset, 0.16, 0.034, 255, 255, 255, 255)
end

function menuItems(item1, item2, item3, item4, item5, item6)
	if item1 ~= "nil" then drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "" .. item1,255,255,255,255) amenu.maxRow = 1 end
	if item2 ~= "nil" then drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "" .. item2,255,255,255,255) amenu.maxRow = 2 end
	if item3 ~= "nil" then drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "" .. item3,255,255,255,255) amenu.maxRow = 3 end
	if item4 ~= "nil" then drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "" .. item4,255,255,255,255) amenu.maxRow = 4 end
	if item5 ~= "nil" then drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "" .. item5,255,255,255,255) amenu.maxRow = 5 end
	if item6 ~= "nil" then drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "" .. item6,255,255,255,255) amenu.maxRow = 6 end
end

function menuPrices(item1, item2, item3, item4, item5, item6)
	if item1 ~= "nil" then drawTxt(0.92, 0.17, 0.0, 0.0, 0.35, "$" .. item1,255,255,255,255) amenu.maxRow = 1 end
	if item2 ~= "nil" then drawTxt(0.92, 0.21, 0.0, 0.0, 0.35, "$" .. item2,255,255,255,255) amenu.maxRow = 2 end
	if item3 ~= "nil" then drawTxt(0.92, 0.25, 0.0, 0.0, 0.35, "$" .. item3,255,255,255,255) amenu.maxRow = 3 end
	if item4 ~= "nil" then drawTxt(0.92, 0.29, 0.0, 0.0, 0.35, "$" .. item4,255,255,255,255) amenu.maxRow = 4 end
	if item5 ~= "nil" then drawTxt(0.92, 0.33, 0.0, 0.0, 0.35, "$" .. item5,255,255,255,255) amenu.maxRow = 5 end
	if item6 ~= "nil" then drawTxt(0.92, 0.37, 0.0, 0.0, 0.35, "$" .. item6,255,255,255,255) amenu.maxRow = 6 end
end

function buyWeapon(weapon)
	local price = getBuyPrice(weapon)
	if bankStats.cash >= price then
		TriggerServerEvent("deductMoney", 0, price)
		ShowNotification("1 ~b~" .. weapon .."~w~ bought for $" .. price)
		giveWeapon(weapon)
	else
		ShowNotification("~r~You don't have enough money for a ~b~" .. weapon)
	end
end

function buyItem(item)
	local price = getBuyPrice(item)
	if bankStats.cash >= price then
		if hasSpace(item) then
			TriggerServerEvent("useShop", item, price, 1)
		else
			ShowNotification("~r~You don't have enough space for a ~b~" .. item)
		end
	else
		ShowNotification("~r~You don't have enough money for a ~b~" .. item)
	end
end

function giveWeapon(weap)
	if weap == "Pickaxe" then
		TriggerServerEvent("giveWeapon", 'baseball_bat', 1)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BAT"), 1, false, true)
	elseif weap == "Crowbar" then
		TriggerServerEvent("giveWeapon", 'crowbar', 1)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CROWBAR"), 1, false, true)
	elseif weap == "Hatchet" then
		TriggerServerEvent("giveWeapon", 'hatchet', 1)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HATCHET"), 1, false, true)
	elseif weap == "Hammer" then
		TriggerServerEvent("giveWeapon", 'hammer', 1)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HAMMER"), 1, false, true)
	elseif weap == "Flashlight" then
		TriggerServerEvent("giveWeapon", 'flashlight', 1)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 1, false, true)
	end
end

function getAmmoPrice(item)
	if item == 'pistol' then
		return 27
	elseif item == 'combat_pistol' then
		return 27
	elseif item == 'sns_pistol' then
		return 13
	elseif item == 'vintage_pistol' then
		return 25
	elseif item == 'shotgun' then
		return 30
	elseif item == 'heavy_shotgun' then
		return 45
	elseif item == 'musket' then
		return 36
	end
end

function getComponentPrice(item)
	if item == 'pistol' then
		return 25
	elseif item == 'combat_pistol' then
		return 25
	elseif item == 'shotgun' then
		return 30
	elseif item == 'heavy_shotgun' then
		return 30
	end
end

function getBuyPrice(item)
	if item == 'Pickaxe' then
		return 35
	elseif item == 'Crowbar' then
		return 32
	elseif item == 'Engine-Kit' then
		return 75
	elseif item == 'Body-Kit' then
		return 50
	elseif item == 'Hotwire-Kit' then
		return 150
	elseif item == 'Morphine' then
		return 40
	elseif item == 'Bandage' then
		return 25
	elseif item == 'Adrenaline' then
		return 30
	elseif item == 'GPS' then
		return 27
	elseif item == 'Lockpick' then
		return 14
	elseif item == 'Hatchet' then
		return 28
	elseif item == 'Hammer' then
		return 24
	elseif item == 'Flashlight' then
		return 15
	elseif item == 'Compass' then
		return 24
	elseif item == 'pistol' then
		return 415
	elseif item == 'combat_pistol' then
		return 540
	elseif item == 'sns_pistol' then
		return 230
	elseif item == 'vintage_pistol' then
		return 750
	elseif item == 'shotgun' then
		return 445
	elseif item == 'heavy_shotgun' then
		return 625
	elseif item == 'musket' then
		return 810
	elseif item == 'gunLicense' then
		return 250
	elseif item == 'Heart-Stopper' then
		return 10
	elseif item == 'ECola' then
		return 6
	elseif item == 'Sprunk' then
		return 6
	elseif item == 'Meteorite-Bar' then
		return 5
	elseif item == 'Phat-Chips' then
		return 3
	end
end

function getSellPrice(item)
	if item == 'Grapes' then
		return 5
	elseif item == 'Sand' then
		return 2
	end
end

function getCurrentPlayersActive()
	currentPlayers = {}
	for i=1, 32 do
		if NetworkIsPlayerActive(i) then
			if GetPlayerPed(i) ~= nil then
				if GetPlayerPed(i) ~= GetPlayerPed(-1) then
					table.insert(currentPlayers, i)
				end
			end
		end
	end
end
