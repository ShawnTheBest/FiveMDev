--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local vehEnter = { {265.6327, 2599.901, 44.0}, {-41.4628, -1675.51, 28.5}, {120.1437, 6625.944, 31.0} }
local vehViewing = { {261.9929, 2578.813, 45.07617}, {-51.81469, -1685.387, 29.49171}, {128.606, 6660.217, 31.68045} }
local vehSpawning = { {235.5717, 2574.534, 45.99896}, {-23.98486, -1677.901, 29.47142}, {116.771, 6653.365, 31.6046} }
local vehHeading = {190.0, 230.0, 60.0}
local vehSpawnHeading = {330.0, 122.0, 120.0}
local vehColors = {0, 11, 4, 8, 27, 150, 33, 143, 135, 36, 38, 99, 88, 89, 49, 50, 54, 141, 62, 64, 73, 96, 94, 104, 99, 71, 142, 145, 107, 111, 112} -- 1-31

function showVehicleMenu()
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.155, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Vehicle Dealer",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	if amenu.page ~= 0 then 
		DrawRect(0.87, 0.48, 0.16, 0.068, 0, 0, 0, 200)
		drawTxt(0.795, 0.45, 0.0, 0.0, 0.25, "ENTER - Buy",255,255,255,255)
		drawTxt(0.795, 0.48, 0.0, 0.0, 0.25, "LEFT/RIGHT - Cycle Color",255,255,255,255)
		drawTxt(0.795, 0.41, 0.0, 0.0, 0.35, "Price: ~g~$" .. vehMenu.cost,255,255,255,255)	
	end
	
	showRegularCar()
	showNormalSelection()
	if amenu.page == 0 then -- Main Page
		amenu.title = "VEHICLE TYPES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Sedans",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Coupes",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Muscle",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "SUVs",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Vans",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Trucks",255,255,255,255)	
	elseif amenu.page == 1 then -- Sedans
		amenu.title = "SEDANS"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/4",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Albany Emperor",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Albany Primo",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Albany Washington",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Benefactor Schafter",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Bravado Buffalo",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Chevel Fugitive",255,255,255,255)
	elseif amenu.page == 2 then -- Sedans
		amenu.title = "SEDANS"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/4",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Chevel Surge",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Declasse Asea",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Declasse Premier",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Dundreary Regina",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Karin Asterope",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Karin Intruder",255,255,255,255)
	elseif amenu.page == 3 then -- Sedans
		amenu.title = "SEDANS"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "3/4",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Karin Sultan",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Lampadati Felon",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Obey Tailgater",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Ubermacht Oracle",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Ubermacht Oracle MK2",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Vapid Stanier",255,255,255,255)
	elseif amenu.page == 4 then -- Sedans
		amenu.title = "SEDANS"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "4/4",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Vulcan Ingot",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Vulcan Warrener",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Zirconium Stratum",255,255,255,255)
	elseif amenu.page == 5 then -- Coupes
		amenu.title = "COUPES"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/2",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Benefactor Panto",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Bollokan Prairie",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Declasse Rhapsody",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Dinka Blista",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Grotti Brioso",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Karin Dilettante",255,255,255,255)
	elseif amenu.page == 6 then -- Coupes
		amenu.title = "COUPES"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/2",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Weeny Issi",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Karin Futo",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Ocelot Jackal",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Ubermacht Sentinel",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Ubermacht Sentinel XS",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Ubermacht Zion",255,255,255,255)
	elseif amenu.page == 7 then -- Trucks
		amenu.title = "TRUCKS"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/1",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Bravado Bison",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Vapid Bobcat",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Vapid Sadler",255,255,255,255)
	elseif amenu.page == 8 then -- Muscle
		amenu.title = "MUSCLE"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/3",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Albany Buccaneer",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Albany Virgo",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Bravado Gauntlet",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Chevel Picador",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Declasse Tampa",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Declasse Sabre Turbo",255,255,255,255)
	elseif amenu.page == 9 then -- Muscle
		amenu.title = "MUSCLE"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/3",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Declasse Vigero",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Imponte Dukes",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Imponte Phoenix",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Imponte Ruiner",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Vapid Chino",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Vapid Dominator",255,255,255,255)
	elseif amenu.page == 10 then -- Muscle
		amenu.title = "MUSCLE"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "3/3",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Vapid Slamvan",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Willard Faction",255,255,255,255)
	elseif amenu.page == 11 then -- SUV
		amenu.title = "SUVs"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/3",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Albany Cavalcade",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Albany Cavalcade Mk2",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Benefactor Dubsta",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Benefactor Serrano",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Bravado Gresley",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Canis Mesa",255,255,255,255)
	elseif amenu.page == 12 then -- SUV
		amenu.title = "SUVs"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/3",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Canis Seminole",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Declasse Granger",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Dundreary Landstalker",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Enus Huntley",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Gallivanter Baller",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Gallivanter Baller Mk2",255,255,255,255)
	elseif amenu.page == 13 then -- SUV
		amenu.title = "SUVs"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "3/3",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Declasse Rancher XL2",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Merryweather Mesa",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Mammoth Patriot",255,255,255,255)
	elseif amenu.page == 14 then -- Van
		amenu.title = "VANS"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/2",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "BF Surfer",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Bravado Rumpo",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Declasse Burrito",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Declasse Moonbeam",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Vapid Minivan",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Vapid Speedo",255,255,255,255)
	elseif amenu.page == 15 then -- Van
		amenu.title = "VANS"
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/2",30,88,162,255)
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Bravado Rumpo Custom",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Declasse Gang Burrito",255,255,255,255)
	end
	
	
	
	
	
	-- ============================== KEY PRESSES ==============================
	
	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
        if amenu.page ~= 0 and amenu.page ~= 1 and amenu.page ~= 5 and amenu.page ~= 7 and amenu.page ~= 8 and amenu.page ~= 11 and amenu.page ~=14 then
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
			if amenu.row < 7 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
			if amenu.row == 7 then 
				amenu.page = 2
				amenu.row = 1
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
			if amenu.row < 7 then
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
			if amenu.row < 7 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
			if amenu.row == 7 then 
				amenu.page = 6
				amenu.row = 1
			end
		elseif amenu.page == 6 then
			if amenu.row < 6 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 7 then
			if amenu.row < 3 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 8 then
			if amenu.row < 7 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
			if amenu.row == 7 then
				amenu.page = 9
				amenu.row = 1
			end
		elseif amenu.page == 9 then
			if amenu.row < 7 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
			if amenu.row == 7 then
				amenu.page = 10
				amenu.row = 1
			end
		elseif amenu.page == 10 then
			if amenu.row < 2 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 11 then
			if amenu.row < 7 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
			if amenu.row == 7 then
				amenu.page = 12
				amenu.row = 1
			end
		elseif amenu.page == 12 then
			if amenu.row < 7 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
			if amenu.row == 7 then
				amenu.page = 13
				amenu.row = 1
			end
		elseif amenu.page == 13 then
			if amenu.row < 3 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 14 then
			if amenu.row < 7 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
			if amenu.row == 7 then
				amenu.page = 15
				amenu.row = 1
			end
		elseif amenu.page == 15 then
			if amenu.row < 2 then
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
				amenu.page = 5
				amenu.row = 1
			elseif amenu.row == 3 then
				amenu.page = 8
				amenu.row = 1
			elseif amenu.row == 4 then 
				amenu.page = 11
				amenu.row = 1
			elseif amenu.row == 5 then
				amenu.page = 14
				amenu.row = 1
			elseif amenu.row == 6 then
				amenu.page = 7
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
					local newVeh = CreateVehicle(carHash, vehSpawning[location][1], vehSpawning[location][2], vehSpawning[location][3], vehSpawnHeading[location], true, false)
					SetVehicleOnGroundProperly(newVeh)
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), newVeh, -1)
					for i = 0,24 do
						SetVehicleModKit(newVeh,0)
						RemoveVehicleMod(newVeh,i)
					end
					if vehMenu.model == "rumpo" then SetVehicleLivery(newVeh, 1) end
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
		elseif amenu.page == 1 or amenu.page == 2 or amenu.page == 3 or amenu.page == 4 then
			amenu.page = 0
			amenu.row = 1
		elseif amenu.page == 5 or amenu.page == 6 then
			amenu.page = 0
			amenu.row = 2
		elseif amenu.page == 8 or amenu.page == 9 or amenu.page == 10 then
			amenu.page = 0
			amenu.row = 3
		elseif amenu.page == 11 or amenu.page == 12 or amenu.page == 13 then
			amenu.page = 0
			amenu.row = 4
		elseif amenu.page == 7 then
			amenu.page = 0
			amenu.row = 6
		elseif amenu.page == 14 or amenu.page == 15 then
			amenu.page = 0
			amenu.row = 5
		end	
	end
end






	-- ============================== MENU FUNCTIONS ==============================

function showRegularCar()
	if amenu.page == 0 then -- Main Page
		if amenu.row == 1 then
			if vehMenu.model ~= "emperor" then spawnRegularCar("emperor") end -- Sedans
		elseif amenu.row == 2 then
			if vehMenu.model ~= "panto" then spawnRegularCar("panto") end -- Coupes
		elseif amenu.row == 3 then
			if vehMenu.model ~= "buccaneer" then spawnRegularCar("buccaneer") end -- Muscle
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "cavalcade" then spawnRegularCar("cavalcade") end -- SUVs
		elseif amenu.row == 5 then
			if vehMenu.model ~= "surfer" then spawnRegularCar("surfer") end -- Vans
		elseif amenu.row == 6 then
			if vehMenu.model ~= "bison" then spawnRegularCar("bison") end -- Trucks
		end
	elseif amenu.page == 1 then -- Sedans
		if amenu.row == 1 then
			if vehMenu.model ~= "emperor" then spawnRegularCar("emperor") end
			vehMenu.cost = 6000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "primo" then spawnRegularCar("primo") end
			vehMenu.cost = 8000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "washington" then spawnRegularCar("washington") end
			vehMenu.cost = 8000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "schafter2" then spawnRegularCar("schafter2") end
			vehMenu.cost = 13000
		elseif amenu.row == 5 then
			if vehMenu.model ~= "buffalo" then spawnRegularCar("buffalo") end
			vehMenu.cost = 14000
		elseif amenu.row == 6 then
			if vehMenu.model ~= "fugitive" then spawnRegularCar("fugitive") end
			vehMenu.cost = 10500
		end
	elseif amenu.page == 2 then -- Sedans
		if amenu.row == 1 then
			if vehMenu.model ~= "surge" then spawnRegularCar("surge") end
			vehMenu.cost = 6000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "asea" then spawnRegularCar("asea") end
			vehMenu.cost = 10000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "premier" then spawnRegularCar("premier") end 
			vehMenu.cost = 9000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "regina" then spawnRegularCar("regina") end
			vehMenu.cost = 5000
		elseif amenu.row == 5 then
			if vehMenu.model ~= "asterope" then spawnRegularCar("asterope") end
			vehMenu.cost = 8000
		elseif amenu.row == 6 then
			if vehMenu.model ~= "intruder" then spawnRegularCar("intruder") end
			vehMenu.cost = 10000
		end
	elseif amenu.page == 3 then -- Sedans
		if amenu.row == 1 then
			if vehMenu.model ~= "sultan" then spawnRegularCar("sultan") end
			vehMenu.cost = 9000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "felon" then spawnRegularCar("felon") end
			vehMenu.cost = 11000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "tailgater" then spawnRegularCar("tailgater") end
			vehMenu.cost = 12000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "oracle" then spawnRegularCar("oracle") end
			vehMenu.cost = 10000
		elseif amenu.row == 5 then
			if vehMenu.model ~= "oracle2" then spawnRegularCar("oracle2") end
			vehMenu.cost = 12000
		elseif amenu.row == 6 then
			if vehMenu.model ~= "stanier" then spawnRegularCar("stanier") end
			vehMenu.cost = 7000
		end
	elseif amenu.page == 4 then -- Sedans
		if amenu.row == 1 then
			if vehMenu.model ~= "ingot" then spawnRegularCar("ingot") end
			vehMenu.cost = 7000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "warrener" then spawnRegularCar("warrener") end
			vehMenu.cost = 9000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "stratum" then spawnRegularCar("stratum") end
			vehMenu.cost = 9000
		end
	elseif amenu.page == 5 then -- Coupes
		if amenu.row == 1 then
			if vehMenu.model ~= "panto" then spawnRegularCar("panto") end
			vehMenu.cost = 6000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "prairie" then spawnRegularCar("prairie") end
			vehMenu.cost = 10000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "rhapsody" then spawnRegularCar("rhapsody") end
			vehMenu.cost = 7000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "blista" then spawnRegularCar("blista") end
			vehMenu.cost = 7500
		elseif amenu.row == 5 then
			if vehMenu.model ~= "brioso" then spawnRegularCar("brioso") end
			vehMenu.cost = 9500
		elseif amenu.row == 6 then
			if vehMenu.model ~= "dilettante" then spawnRegularCar("dilettante") end
			vehMenu.cost = 6500
		end
	elseif amenu.page == 6 then -- Coupes
		if amenu.row == 1 then
			if vehMenu.model ~= "issi2" then spawnRegularCar("issi2") end
			vehMenu.cost = 7000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "futo" then spawnRegularCar("futo") end
			vehMenu.cost = 8000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "jackal" then spawnRegularCar("jackal") end
			vehMenu.cost = 12000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "sentinel2" then spawnRegularCar("sentinel2") end
			vehMenu.cost = 10000
		elseif amenu.row == 5 then
			if vehMenu.model ~= "sentinel" then spawnRegularCar("sentinel") end
			vehMenu.cost = 12000
		elseif amenu.row == 6 then
			if vehMenu.model ~= "zion" then spawnRegularCar("zion") end
			vehMenu.cost = 13500
		end
	elseif amenu.page == 7 then -- Trucks
		if amenu.row == 1 then
			if vehMenu.model ~= "bison" then spawnRegularCar("bison") end
			vehMenu.cost = 7000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "bobcatxl" then spawnRegularCar("bobcatxl") end
			vehMenu.cost = 7500
		elseif amenu.row == 3 then
			if vehMenu.model ~= "sadler" then spawnRegularCar("sadler") end
			vehMenu.cost = 7000
		end
	elseif amenu.page == 8 then -- Muscle
		if amenu.row == 1 then
			if vehMenu.model ~= "buccaneer" then spawnRegularCar("buccaneer") end
			vehMenu.cost = 10000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "virgo" then spawnRegularCar("virgo") end
			vehMenu.cost = 11000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "gauntlet" then spawnRegularCar("gauntlet") end
			vehMenu.cost = 12000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "picador" then spawnRegularCar("picador") end
			vehMenu.cost = 9500
		elseif amenu.row == 5 then
			if vehMenu.model ~= "tampa" then spawnRegularCar("tampa") end
			vehMenu.cost = 10000
		elseif amenu.row == 6 then
			if vehMenu.model ~= "sabregt" then spawnRegularCar("sabregt") end
			vehMenu.cost = 13000
		end
	elseif amenu.page == 9 then -- Muscle
		if amenu.row == 1 then
			if vehMenu.model ~= "vigero" then spawnRegularCar("vigero") end
			vehMenu.cost = 12000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "dukes" then spawnRegularCar("dukes") end
			vehMenu.cost = 9000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "phoenix" then spawnRegularCar("phoenix") end 
			vehMenu.cost = 13000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "ruiner" then spawnRegularCar("ruiner") end
			vehMenu.cost = 12500
		elseif amenu.row == 5 then
			if vehMenu.model ~= "chino" then spawnRegularCar("chino") end
			vehMenu.cost = 9000
		elseif amenu.row == 6 then
			if vehMenu.model ~= "dominator" then spawnRegularCar("dominator") end
			vehMenu.cost = 14000
		end
	elseif amenu.page == 10 then -- Muscle
		if amenu.row == 1 then
			if vehMenu.model ~= "slamvan" then spawnRegularCar("slamvan") end
			vehMenu.cost = 8000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "faction" then spawnRegularCar("faction") end
			vehMenu.cost = 9000
		end
	elseif amenu.page == 11 then -- SUV
		if amenu.row == 1 then
			if vehMenu.model ~= "cavalcade" then spawnRegularCar("cavalcade") end
			vehMenu.cost = 12000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "cavalcade2" then spawnRegularCar("cavalcade2") end
			vehMenu.cost = 20000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "dubsta" then spawnRegularCar("dubsta") end 
			vehMenu.cost = 14000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "serrano" then spawnRegularCar("serrano") end
			vehMenu.cost = 10000
		elseif amenu.row == 5 then
			if vehMenu.model ~= "gresley" then spawnRegularCar("gresley") end
			vehMenu.cost = 11000
		elseif amenu.row == 6 then
			if vehMenu.model ~= "mesa" then spawnRegularCar("mesa") end
			vehMenu.cost = 10000
		end
	elseif amenu.page == 12 then -- SUV
		if amenu.row == 1 then
			if vehMenu.model ~= "seminole" then spawnRegularCar("seminole") end
			vehMenu.cost = 10500
		elseif amenu.row == 2 then
			if vehMenu.model ~= "granger" then spawnRegularCar("granger") end
			vehMenu.cost = 12000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "landstalker" then spawnRegularCar("landstalker") end 
			vehMenu.cost = 11000
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "huntley" then spawnRegularCar("huntley") end
			vehMenu.cost = 12000
		elseif amenu.row == 5 then
			if vehMenu.model ~= "baller" then spawnRegularCar("baller") end
			vehMenu.cost = 11000
		elseif amenu.row == 6 then
			if vehMenu.model ~= "baller2" then spawnRegularCar("baller2") end
			vehMenu.cost = 13000
		end
	elseif amenu.page == 13 then -- SUV
		if amenu.row == 1 then
			if vehMenu.model ~= "RancherXL2" then spawnRegularCar("RancherXL2") end
			vehMenu.cost  = 11000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "Mesa3" then spawnRegularCar("Mesa3") end
			vehMenu.cost = 15000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "Patriot" then spawnRegularCar("Patriot") end
			vehMenu.cost = 16000			
		end
	elseif amenu.page == 14 then -- Van
		if amenu.row == 1 then
			if vehMenu.model ~= "surfer" then spawnRegularCar("surfer") end
			vehMenu.cost = 4000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "rumpo" then spawnRegularCar("rumpo") end
			vehMenu.cost = 8000
		elseif amenu.row == 3 then
			if vehMenu.model ~= "burrito3" then spawnRegularCar("burrito3") end 
			vehMenu.cost = 7500
		elseif amenu.row == 4 then 
			if vehMenu.model ~= "moonbeam" then spawnRegularCar("moonbeam") end
			vehMenu.cost = 6500
		elseif amenu.row == 5 then
			if vehMenu.model ~= "minivan" then spawnRegularCar("minivan") end
			vehMenu.cost = 6750
		elseif amenu.row == 6 then
			if vehMenu.model ~= "speedo" then spawnRegularCar("speedo") end
			vehMenu.cost = 7500
		end
	elseif amenu.page == 15 then -- Van
		elseif amenu.row == 1 then
			if vehMenu.model ~= "rumpo3" then spawnRegularCar("rumpo3") end
			vehMenu.cost = 11000
		elseif amenu.row == 2 then
			if vehMenu.model ~= "GBurrito2" then spawnRegularCar("GBurrito2") end
			vehMenu.cost = 12000
		end
	end

function spawnRegularCar(car)
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
	local newVeh = CreateVehicle(carHash, vehViewing[location][1], vehViewing[location][2], vehViewing[location][3], vehHeading[location], false, false)
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
	if car == "rumpo" then SetVehicleLivery(newVeh, 1) end
	SetVehicleColours(newVeh, vehColors[vehMenu.color], vehColors[vehMenu.color])
	SetVehicleExtraColours(newVeh, vehColors[vehMenu.color], 4)
end