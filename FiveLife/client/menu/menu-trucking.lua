--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

function showTruckingMenu()
	local myPed = GetPlayerPed(-1)
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Trucking",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	
	showNormalSelection()
	if amenu.page == 0 then
		if licenses.truck == true then
			amenu.title = "SELECT HAUL (PAGE 1)"
			menuItems("Cluckin Bell - 8.0mi", "Logging - 7.9mi", "Humane Lab - 6.6mi", "Sandy Shores - 4.7mi", "Vehicle Haul - 4.4mi", "Kortz Museum - 4.0mi")
		else
			amenu.title = "BUY LICENSE"
			menuItems("License: $2500", "nil", "nil", "nil", "nil", "nil")
		end
	elseif amenu.page == 1 then
		amenu.title = "SELECT HAUL (PAGE 2)"
		menuItems("Observatory - 3.9mi", "Airport - 2.7mi", "nil", "nil", "nil", "nil")
	end
	
	-- ============================== KEY PRESSES ==============================
	
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
		if licenses.truck then
			if amenu.page == 0 then amenu.page = 1 else amenu.page = 0 end
			amenu.row = 1
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		if licenses.truck then
			if amenu.page == 0 then amenu.page = 1 else amenu.page = 0 end
			amenu.row = 1
		end
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		if amenu.page == 0 then
			if licenses.truck then
				startJob(0)
			else
				if bankStats.cash >= 2500 then
					TriggerServerEvent("buyLicense", 'truck', 2500)
					licenses.truck = true
				else
					ShowNotification("~r~You don't have enough cash for that.")
				end
			end
		elseif amenu.page == 1 then
			startJob(1)
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 or amenu.page == 1 then
			amenu.show = 0
			amenu.row = 1
			phone('enable')
			TriggerEvent("AwesomeFreeze", false)
		end
	end
end

function startJob(page)
	local rig = GetHashKey("phantom")
	local trail = GetHashKey("tanker2")
	SetWaypointOff()
	if page == 0 then
		job_status = amenu.row
		if amenu.row == 1 then
			trail = GetHashKey("trailers2")
			SetNewWaypoint(-18.4, 6264.1)
		elseif amenu.row == 2 then
			trail = GetHashKey("trailerlogs")
			SetNewWaypoint(-800.4, 5403.9)
		elseif amenu.row == 3 then
			trail = GetHashKey("trailers")
			SetNewWaypoint(3574.2, 3656.2)
		elseif amenu.row == 4 then
			trail = GetHashKey("trailers")
			SetNewWaypoint(2043.4, 3178.5)
		elseif amenu.row == 5 then
			trail = GetHashKey("tr4")
			SetNewWaypoint(237.8, 2586.3)
		elseif amenu.row == 6 then
			trail = GetHashKey("trailers")
			SetNewWaypoint(-2339.3, 278.3)
		end
	elseif page == 1 then
		job_status = amenu.row+6
		trail = GetHashKey("trailers")
		if amenu.row == 1 then
			SetNewWaypoint(-404.5, 1230.3)
		elseif amenu.row == 2 then
			SetNewWaypoint(-756.8, -2600.1)
		end
	end
	local trailer = spawnJobVehicle(trail, 1239.5, -3087.7, 5.8, 92.0)
	job_vehicle = spawnJobVehicle(rig, 1218.7, -3087.2, 5.7, 92.0)
	if not DoesEntityExist(job_vehicle) or not DoesEntityExist(trailer) then
		Wait(100)
	end
	AttachVehicleToTrailer(job_vehicle, trailer, 10.0)
	SetVehicleNumberPlateText(job_vehicle, "PTRUCK" .. GetRandomIntInRange(1, 9))
	SetVehicleModKit(job_vehicle, 0)
	SetVehicleMod(job_vehicle, 16, 0, false)
	SetEntityInvincible(trailer, true)
	SetEntityAsMissionEntity(job_vehicle, true, true)
	SetEntityAsMissionEntity(trailer, true, true)
	TriggerEvent("AwesomeFreeze", false)
	TaskWarpPedIntoVehicle(GetPlayerPed(-1), job_vehicle, -1)
	amenu.show = 0
	amenu.row = 1
	phone('enable')
end
