--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

RegisterNetEvent("UpdateLicenses")
RegisterNetEvent("UpdateSingleLicense")
RegisterNetEvent("UpdateWeapons")
RegisterNetEvent("TogglePhone")
RegisterNetEvent("UpdateJob")

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local menu = {state = 0, object = 1, row = 1, page = 1, title = "Inventory", field = 0, input = 0}
local license = {car = false, truck = false, boat = false, handgun = false, rifle = false, homeowner = false, gang = false, rebel = false}
local vehicle = {hood = false, trunk = false, lfdoor = false, rfdoor = false, lrdoor = false, rrdoor = false, light = false, window = false}
local gunAmmo = {pistol = 000, shotgun = 000, smg = 000, rifle = 000}
local licenseList = {"none", "none", "none", "none", "none", "none", "none"}
local contact = "none"
local default = "none"
local prompt = false
local job = "none"
local blips = true
local armor = true
local playersClose = 1
local ptable
local pNum = 0
local offset = 0.675
local tab = {}
local i = 1
local j = 0
local phoneX = 0.00
local phoneY = 0.00
local livery = 1
local toggleRadio = true
local frontCam = false

function getBank(item)
	if item == 'account' then
		return moneyBank
	elseif item == 'cash' then
		return moneyCash
	end
end

function drawMenu()
	--DrawSprite("dictionary", "sprite", X, Y, X-Scale, Y-Scale, Heading, R, G, B, Alpha)
	--DrawRect( X, Y, width, height, r, g, b, a)
	RequestStreamedTextureDict("phone", true)
	while not HasStreamedTextureDictLoaded("phone") do
		Citizen.Wait(1)
	end
	if menu.state ~= 2 and menu.state ~= 9 then
		DrawSprite("phone", "phone_base", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		if tonumber(newTime.m) < 10 then drawTxt(0.923, 0.085, 0.0, 0.0, 0.25, newTime.h .. ":0" .. newTime.m .. "",255,255,255,255) else drawTxt(0.923, 0.085, 0.0, 0.0, 0.25, newTime.h .. ":" .. newTime.m .. "",255,255,255,255) end
	end
	
-- =============================================== MAIN SCREEN ===========================================================
	if menu.state == 1 then
		
		--drawTxt(0.7, 0.87, 0.0, 0.0, 0.35, "X: " .. phoneX,255,255,255,255)
		--drawTxt(0.7, 0.90, 0.0, 0.0, 0.35, "Y: " .. phoneY,255,255,255,255)
		DrawSprite("phone", "phone_main", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		drawWeather(1)
		if menu.field == 0 then DrawSprite("phone", "phone_highlight1", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 1 then DrawSprite("phone", "phone_highlight1", 0.9072,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 2 then DrawSprite("phone", "phone_highlight1", 0.9448,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 3 then DrawSprite("phone", "phone_highlight1", 0.982,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		
		if menu.field == 4 then DrawSprite("phone", "phone_highlight2", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 5 then DrawSprite("phone", "phone_highlight1", 0.9448,0.358, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 6 then DrawSprite("phone", "phone_highlight1", 0.982,0.358, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 7 then DrawSprite("phone", "phone_highlight1", 0.9448,0.416, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 8 then DrawSprite("phone", "phone_highlight1", 0.982,0.416, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 9 then DrawSprite("phone", "phone_highlight3", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		
		if menu.field == 10 then DrawSprite("phone", "phone_highlight4", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 11 then DrawSprite("phone", "phone_highlight1", 0.9448,0.59, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 12 then DrawSprite("phone", "phone_highlight1", 0.982,0.59, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		if menu.field == 13 then DrawSprite("phone", "phone_highlight5", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		
-- =============================================== PLAYER INFO ============================================================
	elseif menu.state == 2 then 
		--drawTxt(0.7, 0.87, 0.0, 0.0, 0.35, "X: " .. phoneX,255,255,255,255)
		--drawTxt(0.7, 0.90, 0.0, 0.0, 0.35, "Y: " .. phoneY,255,255,255,255)
		DrawSprite("phone", "player_base", 0.5,0.4, 0.54,0.55, 0.0, 255, 255, 255, 255)
		drawTitle(0.5, 0.193,  0.55, "" .. playerRPname,255,255,255,255,1)
		
		drawTitle(0.327, 0.208, 0.35, "Money",255,255,255,255,1)
		drawList(0.276, 0.235, 0.35, "Bank  ~g~" .. moneyBank,255,255,255,255) 
		drawList(0.276, 0.260, 0.35, "Cash  ~g~" .. moneyCash,255,255,255,255) 
		
		drawTitle(0.327, 0.368, 0.35, "Licenses",255,255,255,255,1)
		drawLicenses()
		
		drawTitle(0.5, 0.255, 0.35, "Garage",255,255,255,255,1)
		drawList(0.415, 0.280, 0.35, "None",255,255,255,255) 
		
		drawTitle(0.673, 0.208, 0.35, "Information",255,255,255,255,1)
		if onDuty == 0 then
			drawList(0.62, 0.235, 0.35, "Civilian",255,255,255,255) 
			drawList(0.62, 0.260, 0.35, "Unemployed",255,255,255,255)
		elseif onDuty == 1 then
			drawList(0.62, 0.235, 0.35, "Law Enforcement",255,255,255,255) 
			drawList(0.62, 0.260, 0.35, "Los Santos PD",255,255,255,255)
		elseif onDuty == 2 then
			drawList(0.62, 0.235, 0.35, "Law Enforcement",255,255,255,255) 
			drawList(0.62, 0.260, 0.35, "Blaine County SO",255,255,255,255)
		elseif onDuty == 3 then
			drawList(0.62, 0.235, 0.35, "Law Enforcement",255,255,255,255) 
			drawList(0.62, 0.260, 0.35, "San Andreas State",255,255,255,255)
		elseif onDuty == 4 then
			drawList(0.62, 0.235, 0.35, "Emergency Services",255,255,255,255) 
			drawList(0.62, 0.260, 0.35, "San Andreas Medical",255,255,255,255)
		end
		drawList(0.62, 0.285, 0.35, "",255,255,255,255)
		
		drawTitle(0.673, 0.368, 0.35, "Properties",255,255,255,255,1)
		drawList(0.62, 0.395, 0.35, "None",255,255,255,255)
		--drawList(0.62+phoneX, 0.45+phoneY, 0.35, "text",255,255,255,255)
		
	elseif menu.state == 3 then -- vehicle
		drawTitle(0.87, 0.125, 0.4, "Vehicle",255,255,255,255,1)
		drawList(0.8, 0.16, 0.35, "Hood",255,255,255,255)
		drawList(0.8, 0.18, 0.35, "Trunk",255,255,255,255)
		drawList(0.8, 0.20, 0.35, "Left Front Door",255,255,255,255)
		drawList(0.8, 0.22, 0.35, "Right Front Door",255,255,255,255)
		drawList(0.8, 0.24, 0.35, "Left Rear Door",255,255,255,255)
		drawList(0.8, 0.26, 0.35, "Right Rear Door",255,255,255,255)
		drawList(0.8, 0.28, 0.35, "Interior Light",255,255,255,255)
		drawList(0.8, 0.30, 0.35, "Windows",255,255,255,255)
		drawPhoneSelections()
		
	elseif menu.state == 4 then -- contacts
		drawTitle(0.87, 0.125, 0.4, "Contacts",255,255,255,255,1)
		drawList(0.8, 0.16, 0.35, "Law Enforcement",255,255,255,255)
		drawList(0.8, 0.18, 0.35, "Emergency Serivce",255,255,255,255)
		drawList(0.8, 0.20, 0.35, "Tow Truck",255,255,255,255)
		drawList(0.8, 0.22, 0.35, "Taxi Service",255,255,255,255)
		drawList(0.8, 0.24, 0.35, "Weazel News",255,255,255,255)
		drawPhoneSelections()
		
	elseif menu.state == 5 then -- inventory
		if prompt then showPrompt() end
		drawTitle(0.87, 0.125, 0.4, "Inventory",255,255,255,255,1)
		
		if invItem.slot1 == 'Empty' then 
			drawList(0.8, 0.16, 0.35, "Empty",255,255,255,255)
		else
			drawList(0.8, 0.16, 0.35, GetDisplayName(invItem.slot1),255,255,255,255)
			drawTitle(0.935, 0.16, 0.35, invAmount.slot1 .. "",255,255,255,255,1)
		end
		if invItem.slot2 ~= 'Empty' then 
			drawList(0.8, 0.18, 0.35, GetDisplayName(invItem.slot2),255,255,255,255)
			drawTitle(0.935, 0.18, 0.35, invAmount.slot2 .. "",255,255,255,255,1)
		end
		if invItem.slot3 ~= 'Empty' then 
			drawList(0.8, 0.20, 0.35, GetDisplayName(invItem.slot3),255,255,255,255)
			drawTitle(0.935, 0.20, 0.35, invAmount.slot3 .. "",255,255,255,255,1)
		end
		if invItem.slot4 ~= 'Empty' then 
			drawList(0.8, 0.22, 0.35, GetDisplayName(invItem.slot4),255,255,255,255)
			drawTitle(0.935, 0.22, 0.35, invAmount.slot4 .. "",255,255,255,255,1)
		end
		if invItem.slot5 ~= 'Empty' then 
			drawList(0.8, 0.24, 0.35, GetDisplayName(invItem.slot5),255,255,255,255)
			drawTitle(0.935, 0.24, 0.35, invAmount.slot5 .. "",255,255,255,255,1)
		end
		if invItem.slot6 ~= 'Empty' then 
			drawList(0.8, 0.26, 0.35, GetDisplayName(invItem.slot6),255,255,255,255)
			drawTitle(0.935, 0.26, 0.35, invAmount.slot6 .. "",255,255,255,255,1)
		end
		if invItem.slot7 ~= 'Empty' then 
			drawList(0.8, 0.28, 0.35, GetDisplayName(invItem.slot7),255,255,255,255)
			drawTitle(0.935, 0.28, 0.35, invAmount.slot7 .. "",255,255,255,255,1)
		end
		if invItem.slot8 ~= 'Empty' then 
			drawList(0.8, 0.30, 0.35, GetDisplayName(invItem.slot8),255,255,255,255)
			drawTitle(0.935, 0.30, 0.35, invAmount.slot8 .. "",255,255,255,255,1)
		end
		if invItem.slot9 ~= 'Empty' then 
			drawList(0.8, 0.32, 0.35, GetDisplayName(invItem.slot9),255,255,255,255)
			drawTitle(0.935, 0.32, 0.35, invAmount.slot9 .. "",255,255,255,255,1)
		end
		if invItem.slot10 ~= 'Empty' then 
			drawList(0.8, 0.32, 0.35, GetDisplayName(invItem.slot10),255,255,255,255)
			drawTitle(0.935, 0.32, 0.35, invAmount.slot10 .. "",255,255,255,255,1)
		end		
		drawPhoneSelections()
		
	elseif menu.state == 6 then -- job
		drawTitle(0.87, 0.125, 0.4, "Job Controls",255,255,255,255,1)
		if menu.page == 1 then
			if onDuty ~= 0 and onDuty < 5 then
				drawList(0.8, 0.16, 0.35, "Panic Button",255,255,255,255)
				drawList(0.8, 0.18, 0.35, "Request Backup",255,255,255,255)
				if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
					if GetVehicleLiveryCount(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > 0 then
						drawList(0.8, 0.20, 0.35, "Cycle Livery",255,255,255,255)
					end
				else
					drawList(0.8, 0.20, 0.35, "Emotes",255,255,255,255)
				end
			else
				drawList(0.8, 0.16, 0.35, "Emotes",255,255,255,255)
				if job_status ~= 0 then
					drawList(0.8, 0.18, 0.35, "Cancel Job",255,255,255,255)
				end
			end
		elseif menu.page == 2 then
			drawTitle(0.87, 0.16, 0.35, "Hand on holster",114,114,114,255,1)
			drawTitle(0.87, 0.18, 0.35, "Radio chatter",114,114,114,255,1)
			drawTitle(0.87, 0.20, 0.35, "Police stand",255,255,255,255,1)
			drawTitle(0.87, 0.22, 0.35, "Kneel",255,255,255,255,1)
			drawTitle(0.87, 0.24, 0.35, "Assess patient",255,255,255,255,1)
			drawTitle(0.87, 0.26, 0.35, "Notepad",255,255,255,255,1)
			drawTitle(0.87, 0.28, 0.35, "Traffic",255,255,255,255,1)
			drawTitle(0.87, 0.30, 0.35, "Clipboard",255,255,255,255,1)
			drawTitle(0.87, 0.32, 0.35, "Coffee",255,255,255,255,1)
			drawTitle(0.87, 0.34, 0.35, "Sit on ground",255,255,255,255,1)
			drawTitle(0.87, 0.36, 0.35, "Sit in chair",255,255,255,255,1)
			drawTitle(0.87, 0.38, 0.35, "Lean",255,255,255,255,1)
		elseif menu.page == 3 then
			drawTitle(0.87, 0.16, 0.35, "Sit on ground",255,255,255,255,1)
			drawTitle(0.87, 0.18, 0.35, "Sit in chair",255,255,255,255,1)
			drawTitle(0.87, 0.20, 0.35, "Kneel",255,255,255,255,1)
			drawTitle(0.87, 0.22, 0.35, "Notepad",255,255,255,255,1)
			drawTitle(0.87, 0.24, 0.35, "Photo",255,255,255,255,1)
			drawTitle(0.87, 0.26, 0.35, "Clipboard",255,255,255,255,1)
			drawTitle(0.87, 0.28, 0.35, "Lean",255,255,255,255,1)
			drawTitle(0.87, 0.30, 0.35, "Smoke",255,255,255,255,1)
			drawTitle(0.87, 0.32, 0.35, "Drink",255,255,255,255,1)
			drawTitle(0.87, 0.34, 0.35, "Fish",255,255,255,255,1)
			drawTitle(0.87, 0.36, 0.35, "Sunbath",255,255,255,255,1)
			drawTitle(0.87, 0.38, 0.35, "Pushups",255,255,255,255,1)
			drawTitle(0.87, 0.40, 0.35, "Situps",255,255,255,255,1)
		end
		drawPhoneSelections()
	elseif menu.state == 7 then -- settings
		drawTitle(0.87, 0.125, 0.4, "Settings",255,255,255,255,1)
		if toggleRadio then
			drawList(0.8, 0.16, 0.35, "Vehicle Radio  ~g~ON",255,255,255,255)
		else
			drawList(0.8, 0.16, 0.35, "Vehicle Radio  ~r~OFF",255,255,255,255)
		end
		drawPhoneSelections()
	elseif menu.state == 8 then -- info
		DrawSprite("phone", "phone_info", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		drawTitle(0.87, 0.125, 0.4, "Information",255,255,255,255,1)
	elseif menu.state == 9 then -- camera
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
		HideHudAndRadarThisFrame()
		SetTextRenderId(1)
		
	elseif menu.state == 10 then -- weather
		DrawSprite("phone", "phone_weather", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		drawWeather(0)
		
	elseif menu.state == 11 then -- radio
		DrawSprite("phone", "phone_radio", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		
	elseif menu.state == 12 then -- news
		DrawSprite("phone", "phone_news", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)

	elseif menu.state == 13 then -- finger
		drawTitle(0.87, 0.125, 0.4, "Coming Soon",255,255,255,255,1)
	elseif menu.state == 14 then -- mail
		drawTitle(0.87, 0.125, 0.4, "Mail",255,255,255,255,1)
	end
end

-- =============================================== EVENT HANDLERS ============================================================

AddEventHandler('UpdateJob', function(level)
	jobLevel = tonumber(level)
end)

AddEventHandler('UpdateWeapons', function(item, amount)	
	local myPed = GetPlayerPed(-1)
	local ammo = tonumber(amount)
	if item == 'molotov' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_MOLOTOV"), 0, false, false)
		SetPedAmmo(myPed, GetHashKey('WEAPON_MOLOTOV'), ammo)
	elseif item == 'baseball_bat' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_BAT"), 1, false, false)
	elseif item == 'crowbar' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_CROWBAR"), 1, false, false)
	elseif item == 'hammer' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_HAMMER"), 1, false, false)
	elseif item == 'flashlight' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_FLASHLIGHT"), 1, false, false)
	elseif item == 'pistol' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_PISTOL"), 1, false, false)
	elseif item == 'combat_pistol' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_COMBATPISTOL"), 1, false, false)
	elseif item == 'sns_pistol' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_SNSPISTOL"), 1, false, false)
	elseif item == 'vintage_pistol' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_VINTAGEPISTOL"), 1, false, false)
	elseif item == 'pump_shotgun' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_PUMPSHOTGUN"), 1, false, false)
	elseif item == 'sawnoff_shotgun' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_SAWNOFFSHOTGUN"), 1, false, false)
	elseif item == 'heavy_shotgun' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_HEAVYSHOTGUN"), 1, false, false)
	elseif item == 'assault_rifle' then
		GiveWeaponToPed(myPed, GetHashKey("WEAPON_ASSAULTRIFLE"), 1, false, false)
	elseif item == 'ammo_pistol' and ammo > 0 then
		SetPedAmmo(myPed, GetHashKey('WEAPON_PISTOL'), ammo)
	elseif item == 'ammo_shotgun' and ammo > 0 then
		SetPedAmmo(myPed, GetHashKey('WEAPON_PUMPSHOTGUN'), ammo)
	elseif item == 'ammo_smg' and ammo > 0 then
		--SetPedAmmo(myPed, GetHashKey('WEAPON_PUMPSHOTGUN'), ammo)
	elseif item == 'ammo_rifle' and ammo > 0 then
		SetPedAmmo(myPed, GetHashKey('WEAPON_ASSAULTRIFLE'), ammo)
	end
end)

function checkAmmo(gun, ammo)
	if gun == "WEAPON_PISTOL" or gun == "WEAPON_COMBATPISTOL" or gun == "WEAPON_SNSPISTOL" or gun == "WEAPON_VINTAGEPISTOL" then
		local myPed = GetPlayerPed(-1)
		if gunAmmo.pistol == 000 then
			AddAmmoToPed(myPed, GetHashKey('WEAPON_PISTOL'), ammo)
		else
			if ammo > gunAmmo.pistol then
				SetPedAmmo(myPed, GetHashKey('WEAPON_PISTOL'), ammo)
			end
		end
	elseif gun == "WEAPON_PUMPSHOTGUN" or gun == "WEAPON_SAWNOFFSHOTGUN" then
		local myPed = GetPlayerPed(-1)
		if gunAmmo.shotgun == 000 then
			AddAmmoToPed(myPed, GetHashKey('WEAPON_PUMPSHOTGUN'), ammo)
		else
			if ammo > gunAmmo.shotgun then
				SetPedAmmo(myPed, GetHashKey('WEAPON_PUMPSHOTGUN'), ammo)
			end
		end
	end
end

AddEventHandler('UpdateLicenses', function(car, truck, handgun, rifle, homeowner, gang, rebel)
	if car then license.car = true end
	if truck then license.truck = true end
	if handgun then license.handgun = true end
	if rifle then license.rifle = true end
	if homeowner then license.homeowner = true end
	if gang then license.gang = true end
	if rebel then license.rebel = true end
end)

AddEventHandler('UpdateSingleLicense', function(types, bool)
	if types == 'car' then
		license.car = bool
	elseif types == 'truck' then
		license.truck = bool
	elseif types == 'handgun' then
		license.handgun = bool
	elseif types == 'rifle' then
		license.rifle = bool
	elseif types == 'homeowner' then
		license.homeowner = bool
	elseif types == 'gang' then
		license.gang = bool
	elseif types == 'rebel' then
		license.rebel = bool
	end
end)

AddEventHandler('TogglePhone', function(bool)
	phoneEnabled = bool
end)

function phone(toggle)
	if toggle == 'disable' then
		phoneEnabled = false
		menu.state = 0
	elseif toggle == 'enable' then
		phoneEnabled = true
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if phoneEnabled == true then
			if menu.input == 1 then
				checkPhoneKeyboard()
			end
			if not toggleRadio then
				for i=81, 85 do
					DisableControlAction(0, i, 1)
				end
				--SetRadioToStationName("OFF")
			end
			if (IsControlJustPressed(1, 246) or IsDisabledControlJustPressed(1, 246)) and keyboardOpen == false and ziptied == false and cameraActive == false then -- Y
				if GetEntityHealth(GetPlayerPed(-1)) > 110 then
					if menu.state == 0 then		
						if stance.type == "STANDING" or stance.type == "CROUCH" or stance.type == "PRONE" then
							if situation.type == "ALIVE" or situation.type == "DOWNED" or situation.type == "DOWNED2" then
								menu.state = 1
								for i=1, 7 do
									licenseList[i] = "None"
								end
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
						else
							menu.state = 0
							phoneEnabled = false
						end
					else
						menu.state = 0
						PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					end
				end
			end
			
			if menu.state ~= 0 then
				if jailed or ziptied then 
					menu.state = 0 
					phoneEnabled = false
				end
				drawMenu()
				if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
					phoneX = phoneX - 0.001
					if menu.state == 1 then
						if menu.field == 1 or menu.field == 2 or menu.field == 3 or menu.field == 5 or menu.field == 6 or menu.field == 8 or menu.field == 11 or menu.field == 12 then
							menu.field = menu.field-1
						elseif menu.field == 7 then
							menu.field = 4
						elseif menu.field == 13 then
							menu.field = 10
						end
					elseif menu.state == 2 then

					elseif menu.state == 3 then
					
					elseif menu.state == 4 then
					
					end
				elseif IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
					phoneX = phoneX + 0.001
					if menu.state == 1 then
						if menu.field == 0 or menu.field == 1 or menu.field == 2 or menu.field == 4 or menu.field == 5 or menu.field == 7 or menu.field == 10 or menu.field == 11 then
							menu.field = menu.field+1
						end
					elseif menu.state == 2 then
						
					elseif menu.state == 3 then
					
					elseif menu.state == 4 then
					
					end
				elseif IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
					phoneY = phoneY - 0.001
					if menu.state == 1 then
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if menu.field == 4 then
							menu.field = 0
						elseif menu.field == 5 then
							menu.field = 2
						elseif menu.field == 6 then
							menu.field = 3
						elseif menu.field == 7 then
							menu.field = 5
						elseif menu.field == 8 then
							menu.field = 6
						elseif menu.field == 9 then
							menu.field = 4
						elseif menu.field == 10 or menu.field == 11 or menu.field == 12 then
							menu.field = 9
						elseif menu.field == 13 then
							menu.field = 11
						end
					elseif menu.state == 2 then -- Player Info
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						
					elseif menu.state == 3 or menu.state == 4 or menu.state == 5 or menu.state == 6 then -- Vehicle, Contacts, Inventory, 
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if menu.row > 1 then
							menu.row = menu.row - 1
							prompt = false
						end
					end
				elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
					phoneY = phoneY + 0.001
					if menu.state == 1 then -- Main Menu
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if menu.field == 0 or menu.field == 1 then
							menu.field = 4
						elseif menu.field == 2 then
							menu.field = 5
						elseif menu.field == 3 then
							menu.field = 6
						elseif menu.field == 4 or menu.field == 7 or menu.field == 8 then
							menu.field = 9
						elseif menu.field == 5 then
							menu.field = 7
						elseif menu.field == 6 then
							menu.field = 8
						elseif menu.field == 9 then
							menu.field = 10
						elseif menu.field == 11 or menu.field == 12 then
							menu.field = 13
						end
					elseif menu.state == 2 then -- Player Info
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						
					elseif menu.state == 3 then -- Vehicle
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if menu.row < 8 then
							menu.row = menu.row + 1
						end
					elseif menu.state == 4 then -- Contacts
						if menu.row < 5 then
							menu.row = menu.row + 1
						end
					elseif menu.state == 5 then -- Inventory
						if menu.row < GetInvRows() then
							menu.row = menu.row + 1
							prompt = false
						end
					elseif menu.state == 6 then -- Job
						if menu.page == 1 then
							if onDuty ~= 0 and onDuty < 5 then
								if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
									if GetVehicleLiveryCount(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > 0 then
										if menu.row < 3 then
											menu.row = menu.row + 1
										end
									else
										if menu.row < 2 then
											menu.row = menu.row + 1
										end
									end
								else
									if menu.row < 3 then
										menu.row = menu.row + 1
									end
								end
							else
								if job_gas ~= 0 then
									if menu.row < 2 then
										menu.row = menu.row + 1
									end
								else
									if menu.row < 1 then
										menu.row = menu.row + 1
									end
								end
							end
						elseif menu.page == 2 then
							if menu.row < 12 then
								menu.row = menu.row + 1
							end
						elseif menu.page == 3 then
							if menu.row < 13 then
								menu.row = menu.row + 1
							end
						end
					elseif menu.state == 7 then -- Settings
						if menu.row < 1 then
							menu.row = menu.row + 1
						end
					end

				elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
					if menu.state == 1 then -- Main Menu
						PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if menu.field == 0 then
							menu.row = 1
							menu.state = 2
						elseif menu.field == 1 then
							menu.row = 1
							menu.state = 3
						elseif menu.field == 2 then
							menu.row = 1
							menu.state = 4
						elseif menu.field == 3 then
							local myPed = GetPlayerPed(-1)
							ShowNotification("Syncing Data...")
							updatePlayerAmmo()
							TriggerEvent("sync:updatePlayer")
							TriggerServerEvent("Sync:UpdateWeapons")
						elseif menu.field == 4 then
							menu.row = 1
							menu.state = 5
						elseif menu.field == 5 then
							menu.row = 1
							menu.state = 6
						elseif menu.field == 6 then
							menu.state = 7
						elseif menu.field == 7 then
							menu.state = 8
						elseif menu.field == 8 then
							CreateMobilePhone(1)
							CellCamActivate(true, true)
							cameraActive = true
							menu.state = 9
						elseif menu.field == 9 then
							menu.state = 10
						elseif menu.field == 10 then
							menu.state = 11
						elseif menu.field == 11 then
							menu.state = 12
						elseif menu.field == 12 then
							menu.state = 13
						elseif menu.field == 13 then
							menu.state = 14
						end
					elseif menu.state == 2 then -- Player Info
						PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						
					elseif menu.state == 3 then -- Vehicles
						if GetVehiclePedIsIn(GetPlayerPed(-1), false) ~= nil then
							local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
							if menu.row == 1 then
								if vehicle.hood then
									SetVehicleDoorShut(veh, 4, false)
									vehicle.hood = false
								else
									SetVehicleDoorOpen(veh, 4, false, false)
									vehicle.hood = true
								end
							elseif menu.row == 2 then
								if vehicle.trunk then
									SetVehicleDoorShut(veh, 5, false)
									vehicle.trunk = false
								else
									SetVehicleDoorOpen(veh, 5, false, false)
									vehicle.trunk = true
								end
							elseif menu.row == 3 then
								if vehicle.lfdoor then
									SetVehicleDoorShut(veh, 0, false)
									vehicle.lfdoor = false
								else
									SetVehicleDoorOpen(veh, 0, false, false)
									vehicle.lfdoor = true
								end
							elseif menu.row == 4 then
								if vehicle.rfdoor then
									SetVehicleDoorShut(veh, 1, false)
									vehicle.rfdoor = false
								else
									SetVehicleDoorOpen(veh, 1, false, false)
									vehicle.rfdoor = true
								end
							elseif menu.row == 5 then
								if vehicle.lrdoor then
									SetVehicleDoorShut(veh, 2, false)
									vehicle.lrdoor = false
								else
									SetVehicleDoorOpen(veh, 2, false, false)
									vehicle.lrdoor = true
								end
							elseif menu.row == 6 then
								if vehicle.rrdoor then
									SetVehicleDoorShut(veh, 3, false)
									vehicle.rrdoor = false
								else
									SetVehicleDoorOpen(veh, 3, false, false)
									vehicle.rrdoor = true
								end
							elseif menu.row == 7 then
								if vehicle.light then
									SetVehicleInteriorlight(veh, false)
									vehicle.light = false
								else
									SetVehicleInteriorlight(veh, true)
									vehicle.light = true
								end
							elseif menu.row == 8 then
								if vehicle.window then
									RollUpWindow(veh,0)
									RollUpWindow(veh,1)
									RollUpWindow(veh,2)
									RollUpWindow(veh,3)
									vehicle.window = false
								else
									RollDownWindows(veh)
									vehicle.window = true
								end
							end
						end
					elseif menu.state == 4 then -- Contacts
						if menu.row == 1 then
							contact = "LE"
						elseif menu.row == 2 then
							contact = "EMS"
						elseif menu.row == 3 then
							contact = "TOW"
						elseif menu.row == 4 then
							contact = "TAXI"
						elseif menu.row == 5 then
							contact = "NEWS"
						end
						DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 128)
						keyboardOpen = true
						menu.input = 1
						menu.state = 0
					elseif menu.state == 5 then -- Inventory
						PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if prompt == false then
							prompt = true
						else
							if menu.row == 1 then doPrompt(invItem.slot1)
							elseif menu.row == 2 then doPrompt(invItem.slot2)
							elseif menu.row == 3 then doPrompt(invItem.slot3)
							elseif menu.row == 4 then doPrompt(invItem.slot4)
							elseif menu.row == 5 then doPrompt(invItem.slot5)
							elseif menu.row == 6 then doPrompt(invItem.slot6)
							elseif menu.row == 7 then doPrompt(invItem.slot7)
							elseif menu.row == 8 then doPrompt(invItem.slot8)
							elseif menu.row == 9 then doPrompt(invItem.slot9)
							elseif menu.row == 10 then doPrompt(invItem.slot10) end
						end
					elseif menu.state == 6 then -- Job
						if onDuty ~= 0 and onDuty < 5 then
							if menu.page == 1 then
								local pos = GetEntityCoords(GetPlayerPed(-1))
								local area = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
								if menu.row == 1 then
									TriggerServerEvent("newReport", 'police', pos.x, pos.y, pos.z, "CODE 99: OFFICER IN DANGER", area)
								elseif menu.row == 2 then
									TriggerServerEvent("newReport", 'police', pos.x, pos.y, pos.z, "Officer requesting additional unit.", area)
								elseif menu.row == 3 then
									if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
										local liveryCount = GetVehicleLiveryCount(GetVehiclePedIsIn(GetPlayerPed(-1), false))
										if livery < liveryCount then livery = livery + 1 elseif livery == liveryCount then livery = 1 end
										SetVehicleLivery(GetVehiclePedIsIn(GetPlayerPed(-1), false), livery)
									else
										menu.page = 2
									end
								end
							elseif menu.page == 2 then
								if menu.row == 1 then
									TriggerServerEvent("playAnimation", GetPlayerPed(-1), 'holster', 'emote')
								elseif menu.row == 2 then
									TriggerServerEvent("playAnimation", GetPlayerPed(-1), 'radio', 'emote')
								elseif menu.row == 3 then
									TriggerServerEvent("startEmote", 'COP')
								elseif menu.row == 4 then
									TriggerServerEvent("startEmote", 'KNEEL')
								elseif menu.row == 5 then
									TriggerServerEvent("startEmote", 'MEDIC')
								elseif menu.row == 6 then
									TriggerServerEvent("startEmote", 'NOTEPAD')
								elseif menu.row == 7 then
									TriggerServerEvent("startEmote", 'TRAFFIC')
								elseif menu.row == 8 then
									TriggerServerEvent("startEmote", 'CLIPBOARD')
								elseif menu.row == 9 then
									TriggerServerEvent("startEmote", 'COFFEE')
								elseif menu.row == 10 then
									TriggerServerEvent("startEmote", 'SIT')
								elseif menu.row == 11 then
									TriggerServerEvent("startEmote", 'CHAIR')
								elseif menu.row == 12 then
									TriggerServerEvent("startEmote", 'LEAN')
								end
							end
						else
							if menu.page == 1 then
								if menu.row == 1 then
									menu.page = 3
								elseif menu.row == 2 then
									if job_status ~= 0 then
										job_status = 0
										SetWaypointOff()
										menu.row = 1
									end
								end
							elseif menu.page == 3 then
								if menu.row == 1 then
									TriggerServerEvent("startEmote", 'sit')
								elseif menu.row == 2 then
									TriggerServerEvent("startEmote", 'chair')
								elseif menu.row == 3 then
									TriggerServerEvent("startEmote", 'kneel')
								elseif menu.row == 4 then
									TriggerServerEvent("startEmote", 'notepad')
								elseif menu.row == 5 then
									TriggerServerEvent("startEmote", 'photo')
								elseif menu.row == 6 then
									TriggerServerEvent("startEmote", 'clipboard')
								elseif menu.row == 7 then
									TriggerServerEvent("startEmote", 'lean')
								elseif menu.row == 8 then
									TriggerServerEvent("startEmote", 'smoke')
								elseif menu.row == 9 then
									TriggerServerEvent("startEmote", 'drink')
								elseif menu.row == 10 then
									TriggerServerEvent("startEmote", 'fish')
								elseif menu.row == 11 then
									TriggerServerEvent("startEmote", 'sunbath')
								elseif menu.row == 12 then
									TriggerServerEvent("startEmote", 'pushups')
								elseif menu.row == 13 then
									TriggerServerEvent("startEmote", 'situps')
								end
							end
						end
					elseif menu.state == 7 then -- Settings
						if menu.row == 1 then
							toggleRadio = not toggleRadio
						end
					elseif menu.state == 9 then -- Camera
						frontCam = not frontCam
						CellFrontCamActivate(frontCam)
					end

				elseif IsControlJustPressed(1, 202) or IsDisabledControlJustPressed(1, 202) then -- Backspace
					if menu.state == 1 then
						PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						menu.state = 0
						menu.field = 0
					elseif menu.state == 2 or menu.state == 3 or menu.state == 4  then -- player, vehicle, contacts
						PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						menu.field = menu.state-2
						menu.state = 1
					elseif menu.state == 5 then -- inventory
						PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if prompt == true then
							prompt = false
						else
							menu.field = menu.state-1
							menu.state = 1
						end
					elseif menu.state == 6 then
						if onDuty ~= 0 and onDuty < 5 then
							if menu.page == 2 then
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								menu.page = 1
								menu.row = 3
							else
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								menu.field = menu.state-1
								menu.state = 1
							end
						else
							if menu.page == 3 then
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								menu.page = 1
								menu.row = 1
							else
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								menu.field = menu.state-1
								menu.state = 1
							end
						end
					elseif menu.state == 9 then
						DestroyMobilePhone()
						cameraActive = false
						CellCamActivate(false, false)
						menu.state = 1
						menu.field = 8
					else -- job, settings, info, weather, radio, news, finger, mail
						PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						menu.field = menu.state-1
						menu.state = 1
					end
				end
			end
		end
	end
end)

-- =======================================================================

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

function showPrompt()
	if menu.row == 1 then
		drawPrompt(invItem.slot1, 0.16)
	elseif menu.row == 2 then
		drawPrompt(invItem.slot2, 0.18)
	elseif menu.row == 3 then
		drawPrompt(invItem.slot3, 0.20)
	elseif menu.row == 4 then
		drawPrompt(invItem.slot4, 0.22)
	elseif menu.row == 5 then
		drawPrompt(invItem.slot5, 0.24)
	elseif menu.row == 6 then
		drawPrompt(invItem.slot6, 0.26)
	elseif menu.row == 7 then
		drawPrompt(invItem.slot7, 0.28)
	elseif menu.row == 8 then
		drawPrompt(invItem.slot8, 0.30)
	elseif menu.row == 9 then
		drawPrompt(invItem.slot9, 0.32)
	elseif menu.row == 10 then
		drawPrompt(invItem.slot10, 0.34)
	end
end

function drawPrompt(slot, line)
	if slot == 'Empty' then
		prompt = false
	elseif slot == 'Morphine' then
		local health = GetEntityHealth(GetPlayerPed(-1))
		if health < 200 then
			drawTitle(0.9, line, 0.3, "Use" ,255,255,255,255,1)
		else
			drawTitle(0.9, line, 0.3, "Remove" ,255,255,255,255,1)
		end
	elseif slot == 'Bandage' then
		if myPlayer.bleedRate ~= 0.0 then
			drawTitle(0.9, line, 0.3, "Use" ,255,255,255,255,1)
		else
			drawTitle(0.9, line, 0.3, "Remove" ,255,255,255,255,1)
		end
	elseif slot == 'Adrenaline' then
		drawTitle(0.9, line, 0.3, "Use" ,255,255,255,255,1)
	elseif slot == 'Weed' or slot == 'Meth' or slot == 'Acid' then
		drawTitle(0.9, line, 0.3, "Use" ,255,255,255,255,1)
	else
		drawTitle(0.9, line, 0.3, "Remove" ,255,255,255,255,1)
	end
end

function doPrompt(item)
	if item == 'Morphine' then
		local health = GetEntityHealth(GetPlayerPed(-1))
		if health < 200 then
			TriggerServerEvent("removeFromInventory", 0, 'Morphine', 1)
			RequestAnimDict('mp_weapons_deal_sting') while not HasAnimDictLoaded('mp_weapons_deal_sting') do Citizen.Wait(0) end
			ClearPedTasks(GetPlayerPed(-1))
			TaskPlayAnim(GetPlayerPed(-1), 'mp_weapons_deal_sting', 'crackhead_bag_loop', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
			Wait(3000)
			ClearPedTasks(GetPlayerPed(-1))
			SetEntityHealth(GetPlayerPed(-1), health + 35)
			myPlayer.morphineDose = myPlayer.morphineDose + 1
			changeStance("CROUCH")
		else
			TriggerServerEvent("removeFromInventory", 0, 'Morphine', 1)
		end
	elseif item == "Bandage" then
		if myPlayer.bleedRate ~= 0.0 then
			TriggerServerEvent("removeFromInventory", 0, 'Bandage', 1)
			RequestAnimDict('mp_weapons_deal_sting') while not HasAnimDictLoaded('mp_weapons_deal_sting') do Citizen.Wait(0) end
			ClearPedTasks(GetPlayerPed(-1))
			TaskPlayAnim(GetPlayerPed(-1), 'mp_weapons_deal_sting', 'crackhead_bag_loop', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
			Wait(6000)
			ClearPedTasks(GetPlayerPed(-1))
			myPlayer.bleedRate = 0.0
			if situation.type == "DOWNED" then
				changeSituation("ALIVE")
				ClearPedTasksImmediately(GetPlayerPed(-1))
			end
			changeStance("CROUCH")
		else
			TriggerServerEvent("removeFromInventory", 0, 'Bandage', 1)
		end
	elseif item == "Adrenaline" then
		TriggerServerEvent("removeFromInventory", 0, 'Adrenaline', 1)
		RequestAnimDict('mp_weapons_deal_sting') while not HasAnimDictLoaded('mp_weapons_deal_sting') do Citizen.Wait(0) end
		ClearPedTasks(GetPlayerPed(-1))
		TaskPlayAnim(GetPlayerPed(-1), 'mp_weapons_deal_sting', 'crackhead_bag_loop', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
		Wait(2000)
		ClearPedTasks(GetPlayerPed(-1))
		myPlayer.adrenaline = myPlayer.adrenaline + 20
		StartScreenEffect("DMT_flight", myPlayer.adrenaline*1000, false)
		changeStance("CROUCH")
	elseif item == 'Weed' then
		TriggerServerEvent("removeFromInventory", 0, 'Weed', 1)
		StartScreenEffect("DMT_flight", 40000, false)
	elseif item == 'Meth' then
		TriggerServerEvent("removeFromInventory", 0, 'Meth', 1)
		StartScreenEffect("DrugsMichaelAliensFight", 50000, false)
		StartScreenEffect("DMT_flight", 50000, false)
	elseif item == 'Acid' then
		TriggerServerEvent("removeFromInventory", 0, 'Acid', 1)
		StartScreenEffect("DrugsTrevorClownsFight", 70000, false)
		StartScreenEffect("DMT_flight", 70000, false)
	else
		TriggerServerEvent("removeFromInventory", 0, item, 1)
	end
	prompt = false
end

function GetClosePlayers(radius)
    local closePlayers = {}
	local thisPlayer
	local distance
    for i = 0, 32 do
        if NetworkIsPlayerActive(i) then
			thisPlayer = closePlayers[i]
			distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(thisPlayer)), GetEntityCoords(GetPlayerPed(-1)))
			if distance <= radius then
				table.insert(closePlayers, i)
			end
        end
    end
    return closePlayers
end

function updatePlayerAmmo()
	local myPed = GetPlayerPed(-1)
	if HasPedGotWeapon(myPed, GetHashKey('WEAPON_PISTOL'), false, false) then
		TriggerServerEvent("updateAmmo", 'ammo_pistol', GetAmmoInPedWeapon(myPed, GetHashKey('WEAPON_PISTOL')))
	elseif HasPedGotWeapon(myPed, GetHashKey('WEAPON_COMBATPISTOL'), false, false) then
		TriggerServerEvent("updateAmmo", 'ammo_pistol', GetAmmoInPedWeapon(myPed, GetHashKey('WEAPON_COMBATPISTOL')))
	elseif HasPedGotWeapon(myPed, GetHashKey('WEAPON_SNSPISTOL'), false, false) then
		TriggerServerEvent("updateAmmo", 'ammo_pistol', GetAmmoInPedWeapon(myPed, GetHashKey('WEAPON_SNSPISTOL')))
	elseif HasPedGotWeapon(myPed, GetHashKey('WEAPON_VINTAGEPISTOL'), false, false) then
		TriggerServerEvent("updateAmmo", 'ammo_pistol', GetAmmoInPedWeapon(myPed, GetHashKey('WEAPON_VINTAGEPISTOL')))
	end
	if HasPedGotWeapon(myPed, GetHashKey('WEAPON_PUMPSHOTGUN'), false, false) then
		TriggerServerEvent("updateAmmo", 'ammo_shotgun', GetAmmoInPedWeapon(myPed, GetHashKey('WEAPON_PUMPSHOTGUN')))
	elseif HasPedGotWeapon(myPed, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), false, false) then
		TriggerServerEvent("updateAmmo", 'ammo_shotgun', GetAmmoInPedWeapon(myPed, GetHashKey('WEAPON_SAWNOFFSHOTGUN')))
	end
	if HasPedGotWeapon(myPed, GetHashKey('WEAPON_CARBINERIFLE'), false, false) then
		TriggerServerEvent("updateAmmo", 'ammo_rifle', GetAmmoInPedWeapon(myPed, GetHashKey('WEAPON_CARBINERIFLE')))
	elseif HasPedGotWeapon(myPed, GetHashKey('WEAPON_ASSAULTRIFLE'), false, false) then
		TriggerServerEvent("updateAmmo", 'ammo_rifle', GetAmmoInPedWeapon(myPed, GetHashKey('WEAPON_ASSAULTRIFLE')))
	end
end

function hasWeapon(item)
	local weapon = "WEAPON_" .. item
	return HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(weapon), false, false)
end

function hasLicense(item)
	local types = tostring(item)
	if types == "car" then 
		if license.car then
			return true
		end
	elseif types == "truck" then 
		if license.truck then
			return true
		end
	elseif types == "handgun" then 
		if license.handgun then
			return true
		end
	elseif types == "rifle" then 
		if license.rifle then
			return true
		end
	elseif types == "homeowner" then 
		if license.homeowner then
			return true
		end
	elseif types == "gang" then 
		if license.gang then
			return true
		end
	elseif types == "rebel" then 
		if license.rebel then
			return true
		end
	else
		return false
	end
end

function drawWeather(num)
	if num == 1 then
		if newWeather.now == "EXTRASUNNY" then DrawSprite("phone", "phone_main_weather_sunny", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.now == "CLEAR" or newWeather.now == "SMOG" then DrawSprite("phone", "phone_main_weather_clear", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.now == "CLOUDS" or newWeather.now == "FOGGY" or newWeather.now == "OVERCAST" then DrawSprite("phone", "phone_main_weather_cloudy", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.now == "RAIN" or newWeather.now == "CLEARING" then DrawSprite("phone", "phone_main_weather_rain", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.now == "SNOWLIGHT" or newWeather.now == "BLIZZARD" or newWeather.now == "XMAS" then DrawSprite("phone", "phone_main_weather_snow", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.now == "THUNDER" then DrawSprite("phone", "phone_main_weather_thunder", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
	else
		if newWeather.now == "EXTRASUNNY" then DrawSprite("phone", "phone_weather_now_sunny", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.now == "CLEAR" or newWeather.now == "SMOG" then DrawSprite("phone", "phone_weather_now_clear", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.now == "CLOUDS" or newWeather.now == "FOGGY" or newWeather.now == "OVERCAST" then DrawSprite("phone", "phone_weather_now_cloudy", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.now == "RAIN" or newWeather.now == "CLEARING" then DrawSprite("phone", "phone_weather_now_rain", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.now == "SNOWLIGHT" or newWeather.now == "BLIZZARD" or newWeather.now == "XMAS" then DrawSprite("phone", "phone_weather_now_snow", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.now == "THUNDER" then DrawSprite("phone", "phone_weather_now_thunder", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
		
		if newWeather.new == "EXTRASUNNY" then DrawSprite("phone", "phone_weather_next_sunny", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.new == "CLEAR" or newWeather.new == "SMOG" then DrawSprite("phone", "phone_weather_next_clear", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.new == "CLOUDS" or newWeather.new == "FOGGY" or newWeather.new == "OVERCAST" then DrawSprite("phone", "phone_weather_next_cloudy", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.new == "RAIN" or newWeather.new == "CLEARING" then DrawSprite("phone", "phone_weather_next_rain", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.new == "SNOWLIGHT" or newWeather.new == "BLIZZARD" or newWeather.new == "XMAS" then DrawSprite("phone", "phone_weather_next_snow", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255)
		elseif newWeather.new == "THUNDER" then DrawSprite("phone", "phone_weather_next_thunder", 0.87,0.3, 0.18,0.55, 0.0, 255, 255, 255, 255) end
	end
end

function drawLicenses()	
	local count = 1
	if license.car then licenseList[count]="Class I - Car" count=count+1 end
	if license.truck then licenseList[count]="Commercial Trucking" count=count+1 end
	if license.boat then licenseList[count]="Boating" count=count+1 end
	if license.homeowner then licenseList[count]="Homeowner" count=count+1 end
	if license.handgun then licenseList[count]="Concealed Carry" count=count+1 end
	if license.rifle then licenseList[count]="Rifle" count=count+1 end
	if license.rebel then licenseList[count]="Rebel" count=count+1 end

	if licenseList[1] ~= "None" then
		drawList(0.276, 0.395, 0.35, "" .. licenseList[1],255,255,255,255)
		if licenseList[2] ~= "None" then
			drawList(0.276, 0.420, 0.35, "" .. licenseList[2],255,255,255,255)
			if licenseList[3] ~= "None" then
				drawList(0.276, 0.445, 0.35, "" .. licenseList[3],255,255,255,255)
				if licenseList[4] ~= "None" then
					drawList(0.276, 0.470, 0.35, "" .. licenseList[4],255,255,255,255)
					if licenseList[5] ~= "None" then
						drawList(0.276, 0.395, 0.35, "" .. licenseList[5],255,255,255,255)
						if licenseList[6] ~= "None" then
							drawList(0.276, 0.495, 0.35, "" .. licenseList[6],255,255,255,255)
							if licenseList[7] ~= "None" then
								drawList(0.276, 0.520, 0.35, "" .. licenseList[7],255,255,255,255)
							end
						end
					end
				end
			end
		end
	else
		drawList(0.276, 0.395, 0.35, "None",255,255,255,255)
	end
end

function drawPhoneSelections()
	local offset = 0.02*menu.row
	DrawRect(0.87, 0.157+offset, 0.145, 0.019, 255, 255, 255, 255)
end

function GetDisplayName(text)
	if text == "Engine-Kit" then
		return "Engine Kit"
	elseif text == "Body-Kit" then
		return "Body Kit"
	elseif text == "Hotwire-Kit" then
		return "Hotwire Kit"
	elseif text == "DirtyOil" then
		return "Dirty Oil"
	elseif text == "Stolen-Cash" then
		return "Stolen Cash"
	elseif text == "Health-Pack" then
		return "Health Pack"
	elseif text == "Repair-Kit" then
		return "Repair Kit"
	else
		return text
	end
end

function checkPhoneKeyboard()
	HideHudAndRadarThisFrame()
	if UpdateOnscreenKeyboard() == 3 then
		menu.input = 0
		keyboardOpen = false
	elseif UpdateOnscreenKeyboard() == 1 then
		local inputText = GetOnscreenKeyboardResult()
		if string.len(inputText) > 0 then
			local pos = GetEntityCoords(GetPlayerPed(-1))
			local area = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
			if contact == "LE" then
				TriggerServerEvent("newReport", 'police', pos.x, pos.y, pos.z, inputText, area)
			elseif contact == "EMS" then
				TriggerServerEvent("newReport", 'ems', pos.x, pos.y, pos.z, inputText, area)
			elseif contact == "TOW" then
				TriggerServerEvent("newReport", 'tow', pos.x, pos.y, pos.z, inputText, area)
			elseif contact == "TAXI" then
				TriggerServerEvent("newReport", 'taxi', pos.x, pos.y, pos.z, inputText, area)
			elseif contact == "NEWS" then
				TriggerServerEvent("newReport", 'news', pos.x, pos.y, pos.z, inputText, area)
			end
			menu.input = 0
			keyboardOpen = false
		else
			DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 128)
		end
	elseif UpdateOnscreenKeyboard() == 2 then
		menu.input = 0
		keyboardOpen = false
	end
end

function GetInvRows()
	if invItem.slot10 ~= "Empty" then
		return 10
	elseif invItem.slot9 ~= "Empty" then
		return 9
	elseif invItem.slot8 ~= "Empty" then
		return 8
	elseif invItem.slot7 ~= "Empty" then
		return 7
	elseif invItem.slot6 ~= "Empty" then
		return 6
	elseif invItem.slot5 ~= "Empty" then
		return 5
	elseif invItem.slot4 ~= "Empty" then
		return 4
	elseif invItem.slot3 ~= "Empty" then
		return 3
	elseif invItem.slot2 ~= "Empty" then
		return 2
	else
		return 1
	end
end

