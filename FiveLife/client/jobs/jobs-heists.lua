--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local genStoreRob = { {1959.99, 3740.13, 32.34}, {1727.65, 6415.25, 35.03}, {1696.72, 4923.91, 42.06}, {2678.01, 3279.42, 55.24}, {549.21, 2671.40, 42.15}, {-3242.21, 999.96, 12.83}, {-3038.91, 584.33, 7.91}, {-1818.91, 792.92, 138.08}, {372.34, 326.51, 103.57}, {1165.04, -324.45, 69.2}, {2557.2, 380.78, 108.62}, {-706.1, -915.38, 19.22}, {24.31, -1347.38, 29.5}, {-47.87, -1759.3, 29.4} }
local genStoreHead = {305.5, 235.0, 348.0, 329.5, 93.8, 350.1, 11.3, 150.2, 252.7, 117.7, 352.0, 115.9, 270.9, 72.0}
local genStoreArea = {"Sandy Shores", "Mount Chiliad", "Grapeseed", "Senora Desert", "Harmony", "Chumash", "Chumash", "Vinewood Hills", "Vinewood", "Mirror Park", "Tataviam Mountains", "Little Seoul", "Strawberry", "Davis"}
local bank_ornate_warning_area = {258.658, 222.21, 106.28}
local bank_ornate_vault_hack = {253.5426, 228.3029, 101.0} 		-- Heading: 71
local bank_ornate_vault_collect = {263.7695, 214.2869, 101.0}
local prison_power_station_area = {2100.8, 2342.6, 94.3}
local prison_generator_area = {1758.6, 2612.3, 45.6}
local prison_power_station_explosions = {{2108.5, 2324.9, 94.3}, {2093.3, 2324.7, 94.3}, {2108.9, 2318.8, 94.3}}
local job_blips_extra = {}
local ticks = 0
local timer = 0
local waitTime = 0
local busy = false
local stacks = 0
local maxStacks = 0
local heistType = 'none'
local bank_ornate_warning = false
local bank_ornate_hack = false
local bank_ornate_collect = false
local genStoreRobbery = false
local currentStore = 0
local heistSent = false
local prison_power_station = false
local prison_generator = false
local prison_power_status = "ON"

Citizen.CreateThread(function()
	TriggerServerEvent("Heist:NewPlayer")
	while true do
		Citizen.Wait(1)
		checkHeistRange()
		if onDuty == 0 or onDuty == 4 then
			if busy == false then
				if bank_ornate_hack and heistCooldown.high == false then
					if policeCount >= 6 then
						ShowTip('Hold ~INPUT_ENTER~ to hack console.')
					else
						ShowTip('~r~Not enough law enforcement in city!')
					end
				elseif bank_ornate_collect and heistCooldown.involved then
					if stacks < maxStacks then
						ShowTip('Hold ~INPUT_ENTER~ to collect cash.')
					end
				elseif bank_ornate_hack and heistCooldown.high == true and not heistCooldown.involved then
					ShowTip('~r~Bank robbed too recently!')
				elseif bank_ornate_warning then
					if heistCooldown.involved then
						heistCooldown.involved = false
						ShowNotification("~r~Heist canceled")
					else
						ShowTip('~r~Unauthorized area!')
					end
				elseif genStoreRobbery and storeCooldown[currentStore] == false then
					if policeCount >= 3 then
						ShowTip('Hold ~INPUT_ENTER~ to rob register.')
					else
						ShowTip('~r~Not enough law enforcement in city!')
					end
				elseif genStoreRobbery and storeCooldown[currentStore] == true then
					ShowTip('~r~Store robbed too recently!')
				elseif prison_power_station and heistCooldown.prisonCool == false and heistCooldown.prisonStatus == 'locked' then
					if policeCount >= 5 then
						ShowTip('Hold ~INPUT_ENTER~ to overload power station.')
					else
						ShowTip('~r~Not enough law enforcement in city!')
					end
				elseif prison_generator and heistCooldown.prisonCool == true and heistCooldown.prisonStatus == 'locked' then
					ShowTip('Hold ~INPUT_ENTER~ to turn off backup generator.')
				elseif prison_power_station and heistCooldown.prisonCool == true then
					ShowTip('~r~Power station overloaded')
				end
			else
				ShowTip('Press ~INPUT_ENTER~ to cancel.')
			
				if IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then	
					if heistType ~= 'none' then
						ticks = ticks + 1
						if ticks == 70 then
							ticks = 0
							timer = timer + 1
						end
						if timer == waitTime then
							if heistType == 'hack' then
								if bank_ornate_hack then SetEntityCoords(GetPlayerPed(-1), 253.23, 222.78, 101.0) end
								ClearPedTasks(GetPlayerPed(-1))
								busy = false
								heistType = 'none'
							elseif heistType == 'money' then
								if stacks < maxStacks then
									if hasSpace('Stolen-Cash') then
										stacks = stacks + 1
										TriggerServerEvent("addToPlayerInventory", 0, 'Stolen-Cash', 1000)
									else
										ShowNotification("~r~You have no space for ~b~Stolen Cash~r~.")
									end
								else
									ShowNotification("~r~There is no more cash to collect!")
									heistCooldown.involved = false
									ClearPedTasks(GetPlayerPed(-1))
									busy = false
									heistType = 'none'
								end
							elseif heistType == 'register' then
								if stacks < maxStacks then
									if hasSpace('Stolen-Cash') then
										stacks = stacks + 1
										TriggerServerEvent("addToPlayerInventory", 0, 'Stolen-Cash', 100)
										if heistSent == false then
											TriggerServerEvent("Heist:UpdateHeists", currentStore, "General Store - " .. genStoreArea[currentStore], genStoreRob[currentStore][1], genStoreRob[currentStore][2], genStoreRob[currentStore][3])
											heistSent = true
										end
									else
										ShowNotification("~r~You have no space for ~b~Stolen Cash~r~.")
									end
								else
									ShowNotification("~r~There is no more cash to collect!")
									heistCooldown.involved = false
									ClearPedTasks(GetPlayerPed(-1))
									busy = false
									heistType = 'none'
									heistSent = false
								end
							elseif heistType == 'prison' then
								ClearPedTasks(GetPlayerPed(-1))
								busy = false
								heistType = 'none'
								TriggerServerEvent("Prison:ActivateAlarm")
								TriggerServerEvent("Heist:PrisonBreak", "STAGE3")
							end
							timer = 0
						end
					end
				else
					busy = false
					heistType = 'none'
					timer = 0
				end
			end

			-- F, Z, W
			if IsControlJustPressed(1, 23) or IsDisabledControlJustPressed(1, 23) or IsControlJustPressed(1, 20) or IsDisabledControlJustPressed(1, 20) or IsControlJustPressed(1, 32) or IsDisabledControlJustPressed(1, 32) then
				if busy then
					busy = false
					timer = 0
					heistType = 'none'
					heistSent = false
					ClearPedTasks(GetPlayerPed(-1))
					ShowNotification("~r~Action canceled")
				end
			end

			if IsControlPressed(1, 23) or IsDisabledControlPressed(1, 23) then -- F
				if busy == false then
					buttonPressed = buttonPressed - 1
					if buttonPressed < 0 then
						if bank_ornate_hack and heistCooldown.high == false then
							if policeCount >= 6 then
								TriggerServerEvent("Heist:UpdateHeists", "high", "Pacific Standard Bank", 263.7695, 214.2869, 101.0)
								waitHeistTimer('bank_hack', 90, 'hack')
								stacks = 0
								maxStacks = GetRandomIntInRange(16, 24)
								ShowNotification("Hacking console...")
							end
						elseif bank_ornate_collect and heistCooldown.involved then
							if stacks < maxStacks then
								waitHeistTimer('bank_collect', 15, 'money')
								ShowNotification("Stealing money...")
							end
						elseif genStoreRobbery and storeCooldown[currentStore] == false then
							if policeCount >= 3 then
								waitHeistTimer('rob_register', 13, 'register')
								stacks = 0
								maxStacks = GetRandomIntInRange(12, 20)
								ShowNotification("Robbing cash register...")
							end
						elseif prison_power_station and heistCooldown.prisonCool == false and heistCooldown.prisonStatus == 'locked' then
							if policeCount >= 5 then
								ShowNotification("~g~Overloading power grid...")
								TriggerServerEvent("Heist:PrisonBreak", "STAGE1")
								Wait(5000)
								SetNewWaypoint(1758.6, 2612.3)
								ShowNotification("Turn off prison ~r~backup generator~w~!")
								AddExplosion(prison_power_station_explosions[1][1], prison_power_station_explosions[1][2], prison_power_station_explosions[1][3], 5, 0.0, true, false, 2.0, false)
								Wait(2000)
								AddExplosion(prison_power_station_explosions[2][1], prison_power_station_explosions[2][2], prison_power_station_explosions[2][3], 5, 0.0, true, false, 2.0, false)
								Wait(1000)
								AddExplosion(prison_power_station_explosions[3][1], prison_power_station_explosions[3][2], prison_power_station_explosions[3][3], 5, 0.0, true, false, 2.0, false)
							end
						elseif prison_generator and heistCooldown.prisonCool == true and heistCooldown.prisonStatus == 'locked' then
							TriggerServerEvent("Heist:PrisonBreak", "STAGE2")
							ShowNotification("Cutting backup generator...")
							waitHeistTimer('cut_power', 20, 'prison')
						end
						buttonPressed = 128
					end
				end
			elseif buttonPressed ~= 128 then
				buttonPressed = 128
			end
		else
			if bank_ornate_hack or genStoreRobbery then
				ShowTip('~r~Can not rob while on duty!')
			end
		end
	end
end)

function waitHeistTimer(name, waitT, heist)
	TriggerServerEvent("playAnimation", GetPlayerPed(-1), name, heist)
	waitTime = waitT
	heistType = heist
	busy = true
	if bank_ornate_hack then
		SetEntityCoords(GetPlayerPed(-1), bank_ornate_vault_hack[1], bank_ornate_vault_hack[2], bank_ornate_vault_hack[3])
		SetEntityHeading(GetPlayerPed(-1), 70.0)
	elseif genStoreRobbery then
		SetEntityCoords(GetPlayerPed(-1), genStoreRob[currentStore][1], genStoreRob[currentStore][2], genStoreRob[currentStore][3]-1.0)
		SetEntityHeading(GetPlayerPed(-1), genStoreHead[currentStore])
	end
end

function checkHeistRange()
	if IsPedInAnyVehicle(myPed, true) == false then
		genStoreRobbery = false
		for i=1, 14, 1 do
			if GetDistanceBetweenCoords(genStoreRob[i][1],genStoreRob[i][2],genStoreRob[i][3], GetEntityCoords(GetPlayerPed(-1), true), true) < 1 then
				genStoreRobbery = true
				currentStore = i
			end
		end
		if GetDistanceBetweenCoords(bank_ornate_vault_hack[1],bank_ornate_vault_hack[2],bank_ornate_vault_hack[3], GetEntityCoords(GetPlayerPed(-1), true), true) < 2 then bank_ornate_hack = true else bank_ornate_hack = false end
		if GetDistanceBetweenCoords(bank_ornate_vault_collect[1],bank_ornate_vault_collect[2],bank_ornate_vault_collect[3], GetEntityCoords(GetPlayerPed(-1), true), true) < 2 then bank_ornate_collect = true else bank_ornate_collect = false end
		if GetDistanceBetweenCoords(bank_ornate_warning_area[1],bank_ornate_warning_area[2],bank_ornate_warning_area[3], GetEntityCoords(GetPlayerPed(-1), true), true) < 3 then bank_ornate_warning = true else bank_ornate_warning = false end	
		if GetDistanceBetweenCoords(prison_power_station_area[1],prison_power_station_area[2],prison_power_station_area[3], GetEntityCoords(GetPlayerPed(-1), true), true) < 3 then prison_power_station = true else prison_power_station = false end
		if GetDistanceBetweenCoords(prison_generator_area[1],prison_generator_area[2],prison_generator_area[3], GetEntityCoords(GetPlayerPed(-1), true), true) < 3 then prison_generator = true else prison_generator = false end
	end
end