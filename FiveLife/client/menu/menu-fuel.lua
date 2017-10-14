--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

function showFuelMenu()
	local myPed = GetPlayerPed(-1)
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Fuel Transport",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	
	showNormalSelection()
	if amenu.page == 0 then
		if licenses.truck == true then
			amenu.title = "SELECT HAUL"
			menuItems("Paleto Bay - 6.7mi", "Route 68 - 4.8mi", "Sandy Shores - 3.8mi", "Pacific Bluffs - 3.2mi", "nil", "nil")
		else
			amenu.title = "BUY LICENSE"
			menuItems("License: $2500", "nil", "nil", "nil", "nil", "nil")
		end
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
	
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left

	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		if amenu.page == 0 then
			if licenses.truck then
				job_status = amenu.row
				local rig = GetHashKey("phantom")
				local trail = GetHashKey("tanker2")
				local trailer = spawnJobVehicle(trail, 1690.0, -1582.0, 112.0, 142)
				job_vehicle = spawnJobVehicle(rig, 1686.0, -1568.0, 112.0, 336)
				
				if not DoesEntityExist(job_vehicle) or not DoesEntityExist(trailer) then
					Wait(100)
				end
				AttachVehicleToTrailer(job_vehicle, trailer, 10.0)
				SetVehicleNumberPlateText(job_vehicle, "TANKER" .. GetRandomIntInRange(1, 9))
				SetEntityInvincible(trailer, true)
				SetEntityAsMissionEntity(job_vehicle, true, true)
				SetEntityAsMissionEntity(trailer, true, true)
				
				SetWaypointOff()
				if amenu.row == 1 then
					SetNewWaypoint(200.0, 6618.0)
				elseif amenu.row == 2 then
					SetNewWaypoint(-2527.0, 2341.0)
				elseif amenu.row == 3 then
					SetNewWaypoint(1781.0, 3328.0)
				elseif amenu.row == 4 then
					SetNewWaypoint(-2059.0, -305.0)
				end
				TriggerEvent("AwesomeFreeze", false)
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), job_vehicle, -1)
				amenu.show = 0
				amenu.row = 1
				phone('enable')
			else
				if bankStats.cash >= 2500 then
					TriggerServerEvent("buyLicense", 'truck', 2500)
					licenses.truck = true
				else
					ShowNotification("~r~You don't have enough cash for that.")
				end
			end
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 then
			amenu.show = 0
			amenu.row = 1
			phone('enable')
			TriggerEvent("AwesomeFreeze", false)
		end
	end
end


