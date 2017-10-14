--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local sandCollection = {-2449.046, 4239.988, 2.6}
local sandProcessing = {1089.155, -2001.336, 29.85}
local sandSelling = {-1320.084, -1263.451, 3.55}
local rockCollection = {2928.896, 2793.517, 39.55}
local rockProcessing = {292.4954, 2867.004, 42.82}
local rockSelling = {91.85948, -416.7049, 36.54}
local weedCollection = {2214.541, 5577.739, 52.65}
local weedProcessing = {1443.164, 6332.503, 22.75}
local weedSelling = {128.8903, -1920.13, 20.0}
local methCollection = {352.4255, -2036.18, 21.3}
local methProcessing = {1390.47, 3605.182, 38.7}
local methSelling = {-1144.03, 4937.542, 221.25}
local oilCollection = {-3134.82, 2614.921, 0.0}
local oilSelling = {1680.469, -1663.716, 110.45}
local grapesCollection = {-1860.7, 2145.265, 121.5}
local moneyLaundering = {-555.66, 5320.2, 73.2}
local powerStation = {2100.8, 2342.6, 94.3}
local job_blips_basic = {}
local job = 'Cannabis'
local jobType = 'none'
local ticks = 0
local timer = 0
local waitTime = 0
local buttonPressed = 128
local busy = false
local collection = false
local processing = false
local selling = false
local sandC = false
local sandP = false
local sandS= false
local concreteC = false
local concreteP = false
local concreteS = false
local weedC = false
local weedP = false
local weedS = false
local methC = false
local methP = false
local methS= false
local oilC = false
local oilS = false
local grapeC = false
local laundering = false

local animation = 'idle_a'
local animDict = 'amb@prop_human_bum_bin@idle_a'
local flags = 48

function ShowJobBlips(bool)
	if bool then
		drawJobBlip(sandCollection, 177, 16, 'Sand Mining')
		drawJobBlip(sandProcessing, 128, 16, 'Sand Processing')
		drawJobBlip(sandSelling, 108, 16, 'Glass Buyer')
		drawJobBlip(weedCollection, 140, 52, 'Cannabis Farm')
		drawJobBlip(weedProcessing, 128, 52, 'Weed Processing')
		drawJobBlip(weedSelling, 108, 52, 'Weed Buyer')
		drawJobBlip(rockCollection, 270, 39, 'Rock Mining')
		drawJobBlip(rockProcessing, 128, 39, 'Concrete Processing')
		drawJobBlip(rockSelling, 108, 39, 'Concrete Buyer')
		drawJobBlip(methCollection, 177, 26, 'Meth Materials')
		drawJobBlip(methProcessing, 128, 26, 'Meth Processing')
		drawJobBlip(methSelling, 108, 26, 'Meth Buyer')
		drawJobBlip(oilCollection, 4, 40, 'Oil Mining')
		drawJobBlip(oilSelling, 128, 40, 'Oil Buyer')
		drawJobBlip(grapesCollection, 103, 83, 'Grape Gathering')
		drawJobBlip(moneyLaundering, 108, 75, 'Money Laundering')
		drawJobBlip(powerStation, 446, 0, 'Power Station')
		
		Citizen.CreateThread(function()
			while #job_blips_basic > 0 do
				Citizen.Wait(0)
				checkJobRange()
			end
		end)
	elseif bool == false and #job_blips_basic > 0 then
		for i,b in ipairs(job_blips_basic) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		job_blips_basic = {}
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if busy == false then
			if sandC then
				ShowTip('Hold ~INPUT_ENTER~ to mine sand.')
			elseif concreteC then
				ShowTip('Hold ~INPUT_ENTER~ to mine rock.')
			elseif weedC then
				ShowTip('Hold ~INPUT_ENTER~ to collect cannabis.')
			elseif methC then
				ShowTip('Hold ~INPUT_ENTER~ to buy meth materials.')
			elseif oilC then
				ShowTip('Hold ~INPUT_ENTER~ to collect oil.')
			elseif grapeC then
				ShowTip('Hold ~INPUT_ENTER~ to collect grapes.')
			elseif sandP then
				ShowTip('Hold ~INPUT_ENTER~ to process sand.')
			elseif concreteP then
				ShowTip('Hold ~INPUT_ENTER~ to process rock.')
			elseif weedP then
				ShowTip('Hold ~INPUT_ENTER~ to process cannabis.')
			elseif methP then
				ShowTip('Hold ~INPUT_ENTER~ to process materials.')
			elseif sandS then
				ShowTip('Hold ~INPUT_ENTER~ to sell glass.')
			elseif concreteS then
				ShowTip('Hold ~INPUT_ENTER~ to sell concrete.')
			elseif weedS then
				ShowTip('Hold ~INPUT_ENTER~ to sell weed.')
			elseif methS then
				ShowTip('Hold ~INPUT_ENTER~ to sell meth.')
			elseif oilS then
				ShowTip('Hold ~INPUT_ENTER~ to sell oil.')
			elseif laundering then
				ShowTip('Hold ~INPUT_ENTER~ to launder money.')
			end
		else
			ShowTip('Press ~INPUT_ENTER~ to cancel.')
		
			if IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
				ticks = ticks + 1
				if ticks == 60 then
					ticks = 0
					timer = timer + 1
				end
				if timer == waitTime then
					if jobType == 'add' then
						TriggerServerEvent("addToPlayerInventory", 0, '' .. job, tonumber(getCount(job)))
					elseif jobType == 'process' then
						TriggerServerEvent("processItems", '' .. job)
						ClearPedTasks(GetPlayerPed(-1))
						busy = false
						job = 'none'
					end
					timer = 0
				end
			else
				busy = false
				job = 'none'
				timer = 0
			end
		end
		
		-- F, Z, W
		if IsControlJustPressed(1, 23) or IsDisabledControlJustPressed(1, 23) or IsControlJustPressed(1, 20) or IsDisabledControlJustPressed(1, 20) or IsControlJustPressed(1, 32) or IsDisabledControlJustPressed(1, 32) then
			if busy then
				busy = false
				job = 'none'
				timer = 0
				ClearPedTasks(GetPlayerPed(-1))
				ShowNotification("~r~Action canceled")
			end
		end
		
		if IsControlPressed(1, 23) or IsDisabledControlPressed(1, 23) then -- F
			if busy == false then
				buttonPressed = buttonPressed - 1
				if buttonPressed < 0 then
					if collection then
						PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if sandC then
							if hasSpace('Sand') then waitTimer('Sand', 3, 'add') else ShowNotification("~r~You have no space for ~b~Sand~r~.") end
						elseif concreteC then
							if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_BAT"), false, false) then
								if hasSpace('Rock') then waitTimer('Rock', 6, 'add') else ShowNotification("~r~You have no space for ~b~Rock~r~.") end
							else
								ShowNotification("You need a pickaxe to mine rock.")
							end
						elseif weedC then
							if hasSpace('Cannabis') then waitTimer('Cannabis', 6, 'add') else ShowNotification("~r~You have no space for ~b~Cannabis~r~.") end
						elseif methC then
							if hasSpace('Materials') then waitTimer('Materials', 6, 'add') else ShowNotification("~r~You have no space for ~b~Materials~r~.") end
						elseif oilC then
							if hasSpace('Oil') then waitTimer('Oil', 10, 'add') else ShowNotification("~r~You have no space for ~b~Oil~r~.") end
						elseif grapeC then
							if hasSpace('Grapes') then waitTimer('Grapes', 4, 'add') else ShowNotification("~r~You have no space for ~b~Grapes~r~.") end
						end
					elseif processing then
						PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if sandP then
							if hasItem('Sand') then waitTimer('Sand', 16, 'process') else ShowNotification("~r~You have no ~b~Sand ~r~to process.") end
						elseif concreteP then
							if hasItem('Concrete') then
								ShowNotification("~r~You already have ~b~Concrete~r~!")
							elseif hasItem('Rock') then
								waitTimer('Rock', 20, 'process')
							else
								ShowNotification("~r~You have no ~b~Rocks ~r~to process.")
							end
						elseif weedP then
							if hasItem('Weed') then
								ShowNotification("~r~You already have ~b~Weed~r~!")
							elseif hasItem('Cannabis') then
								waitTimer('Cannabis', 30, 'process')
							else
								ShowNotification("~r~You have no ~b~Cannabis ~r~to process.")
							end
						elseif methP then
							if hasItem('Materials') then waitTimer('Materials', 48, 'process') else ShowNotification("~r~You have no ~b~Materials ~r~to process.") end
						elseif laundering then
							if hasItem('Stolen-Cash') then waitTimer('Stolen-Cash', 60, 'process') else ShowNotification("~r~You have no ~b~Stolen Cash ~r~to launder.") end
						end
					elseif selling then
						PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if sandS then
							if hasItem('Glass') then TriggerServerEvent("Job:BasicJobPayout", 'Glass') else ShowNotification("~r~You have no ~b~Glass ~r~to sell.") end
						elseif concreteS then
							if hasItem('Concrete') then TriggerServerEvent("Job:BasicJobPayout", 'Concrete') else ShowNotification("~r~You have no ~b~Concrete ~r~to sell.") end
						elseif weedS then
							if hasItem('Weed') then TriggerServerEvent("Job:BasicJobPayout", 'Weed') else ShowNotification("~r~You have no ~b~Weed ~r~to sell.") end
						elseif methS then
							if hasItem('Meth') then TriggerServerEvent("Job:BasicJobPayout", 'Meth') else ShowNotification("~r~You have no ~b~Meth ~r~to sell.") end
						elseif oilS then
							if hasItem('Oil') then TriggerServerEvent("Job:BasicJobPayout", 'Oil') else ShowNotification("~r~You have no ~b~Oil ~r~to sell.") end
						end
					end
					buttonPressed = 128
				end
			end
		elseif buttonPressed ~= 128 then
			buttonPressed = 128
		end
	end
end)

function waitTimer(name, waitT, types)
	TriggerServerEvent("playAnimation", GetPlayerPed(-1), name, types)
	job = name
	jobType = types
	waitTime = waitT
	busy = true
end

function getCount(item)
	if item == 'Sand' or item == 'Rock' then
		return GetRandomIntInRange(1, 5)
	elseif item == 'Cannabis' or item == 'Oil' then
		return GetRandomIntInRange(0, 3)
	elseif item == 'Materials' then
		return GetRandomIntInRange(1, 2)
	elseif item == 'Grapes' then
		return GetRandomIntInRange(3, 7)
	end
end

function checkJobRange()
	if drawMarker(sandCollection, 45, 45, 0) == true then sandC = true else sandC = false end
	if drawMarker(sandProcessing, 45, 10, 0) == true then sandP = true else sandP = false end
	if drawMarker(sandSelling, 45, 10, 0) == true then sandS = true else sandS = false end
	if drawMarker(rockCollection, 45, 45, 0) == true then concreteC = true else concreteC = false end
	if drawMarker(rockProcessing, 45, 5, 0) == true then concreteP = true else concreteP = false end
	if drawMarker(rockSelling, 45, 10, 0) == true then concreteS = true else concreteS = false end
	if drawMarker(weedCollection, 45, 10, 0) == true then weedC = true else weedC = false end
	if drawMarker(weedProcessing, 45, 2, 0) == true then weedP = true else weedP = false end
	if drawMarker(weedSelling, 45, 10, 0) == true then weedS = true else weedS = false end
	if drawMarker(methCollection, 45, 10, 0) == true then methC = true else methC = false end
	if drawMarker(methProcessing, 45, 3, 0) == true then methP = true else methP = false end
	if drawMarker(methSelling, 45, 10, 0) == true then methS = true else methS = false end
	if drawMarker(moneyLaundering, 45, 5, 0) == true then laundering = true else laundering = false end
	if drawMarker(oilCollection, 45, 10, 0) == true then oilC = true else oilC = false end
	if drawMarker(oilSelling, 45, 10, 0) == true then oilS = true else oilS = false end
	if drawMarker(grapesCollection, 45, 45, 0) == true then grapeC = true else grapeC = false end
	
	if sandC == true or concreteC == true or weedC == true or methC == true or oilC == true or grapeC== true then
		collection = true
	else
		collection = false
	end
	if sandP == true or concreteP == true or weedP == true or methP == true or laundering == true then
		processing = true
	else
		processing = false
	end
	if sandS == true or concreteS == true or weedS == true or methS == true or oilS == true then
		selling = true
	else
		selling = false
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

function drawJobBlip(tab, sprite, color, name)
	local blip = AddBlipForCoord(tab[1],tab[2],tab[3])
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName('' .. name)
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
	table.insert(job_blips_basic, {blip = blip})
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		ShowJobBlips(true)
		firstspawn = 1
	end
end)