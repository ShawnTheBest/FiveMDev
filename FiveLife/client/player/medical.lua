--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local hospitalLocations = { {294.968, -1447.979, 29.966}, {298.753, -584.458, 43.261} , {-448.957, -340.778, 34.502} , {1827.978, 3692.274, 34.223} }
local advDamageKey = {"~r~Head", "~r~Neck", "~y~Chest", "Right Shoulder", "Right Forearm", "Left Shoulder", "Left Forearm", "Right Thigh", "Right Calf", "Left Thigh", "Left Calf"}
local damageKey = {"Head", "Chest", "Arms", "Legs"}
local smenu = {row = 1, input = false, called = false}
local waitTimer = 0
local reminder = 30
local doseTimer = 90
local lastInjury = {}
lastInjury.type = ""
lastInjury.location = 0
lastInjury.severity = "NONE"
lastInjury.health = 0
lastInjury.armor = 0
lastInjury.damaged = false


-- =============================================== EVENT HANDLERS ============================================================

RegisterNetEvent("revivePlayer")
AddEventHandler("revivePlayer", function()
	respawn_revive("REVIVE")
end)

RegisterNetEvent("FL:ReturnNotification")
AddEventHandler("FL:ReturnNotification", function(info)
	ShowNotification("" .. info)
end)

RegisterNetEvent("FL:PronounceDead")
AddEventHandler("FL:PronounceDead", function()
	if myPlayer.heart == false then
		waitTimer = 0
	end
end)

RegisterNetEvent("FL:SuicideByGun")
AddEventHandler("FL:SuicideByGun", function()
	local myPed = GetPlayerPed(-1)
	local weapHash = GetHashKey("WEAPON_PISTOL")
	local hasGun = true
	RequestNamedPtfxAsset("scr_solomon3")
	if situation.type == "ALIVE" then
		if HasPedGotWeapon(myPed, GetHashKey("WEAPON_PISTOL"), false) then
			weapHash = GetHashKey("WEAPON_PISTOL")
		elseif HasPedGotWeapon(myPed, GetHashKey("WEAPON_COMBATPISTOL"), false) then
			weapHash = GetHashKey("WEAPON_COMBATPISTOL")
		elseif HasPedGotWeapon(myPed, GetHashKey("WEAPON_SNSPISTOL"), false) then
			weapHash = GetHashKey("WEAPON_SNSPISTOL")
		elseif HasPedGotWeapon(myPed, GetHashKey("WEAPON_VINTAGEPISTOL"), false) then
			weapHash = GetHashKey("WEAPON_VINTAGEPISTOL")
		else
			hasGun = false
		end
		if hasGun then
			SetCurrentPedWeapon(myPed, weapHash, true)
			if IsPedWeaponReadyToShoot(myPed) then
				changeStance("STANDING")
				local pCoords = GetEntityCoords(myPed)
				ShowNotification("~r~You took the easy way out.")
				RequestAnimDict('mp_suicide') while not HasAnimDictLoaded('mp_suicide') do Citizen.Wait(0) end
				TaskPlayAnim(myPed, 'mp_suicide', 'pistol', 8.0, 1.0, -1, 0, 0, 0, 0, 0)
				Wait(800)
				ShootSingleBulletBetweenCoords(pCoords.x, pCoords.y, pCoords.z, pCoords.x, pCoords.y, pCoords.z+0.5, 0, false, weapHash, myPed, true, false, 1.0)
				UseParticleFxAssetNextCall("scr_solomon3")
				StartParticleFxNonLoopedOnPedBone("scr_trev4_747_blood_impact", myPed, 0, 0, 0, 0, 0, 0, 31086, 0.2, false, false, false)
				SetPedToRagdoll(myPed, 5000, 5000, 0, 0, 0, 0)
				changeSituation("DEAD")
				tookBleedDamage(0.8, false)
				logDamage("HANDGUN", 1)
				waitTimer = 150
			else
				ShowNotification("~r~Not ready to shoot!")
			end
		else
			ShowNotification("~r~You need a gun!")
		end
	end
end)

RegisterNetEvent("FL:CheckGSR")
AddEventHandler("FL:CheckGSR", function(user)
	if GSR > 600 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~GSR Results: ~g~Positive, High", user)
	elseif GSR > 300 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~GSR Results: ~g~Positive, Medium", user)
	elseif GSR > 0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~GSR Results: ~g~Positive, Low", user)
	else
		TriggerServerEvent("FiveLife:SendNotification", "~b~GSR Results: ~r~Negative", user)
	end
end)

RegisterNetEvent("FL:Examine")
AddEventHandler("FL:Examine", function(user)
	if myPlayer.blood > 95.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~g~Normal", user)
	elseif myPlayer.blood > 75.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~y~Steady", user)
	elseif myPlayer.blood > 50.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~y~Low", user)
	elseif myPlayer.blood > 25.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~o~Very Low", user)
	elseif myPlayer.blood > 0.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~r~Critically Low", user)
	elseif myPlayer.heart == false then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~r~None", user)
	end
	if GetEntityHealth(GetPlayerPed(-1)) < 125 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pain: ~r~Heavy", user)
	elseif GetEntityHealth(GetPlayerPed(-1)) < 150 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pain: ~r~Moderate", user)
	elseif GetEntityHealth(GetPlayerPed(-1)) < 175 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pain: ~r~Light", user)
	elseif GetEntityHealth(GetPlayerPed(-1)) < 200 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pain: ~r~Minor", user)
	else
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pain: ~r~None", user)
	end
	if myPlayer.bleedRate ~= 0.0 then
		if getOtherWounds() == "" and getBluntWounds() == "" and getVehicleWounds() == "" and getBurnWounds() == "" and getHandgunWounds() == "NONE" and getShotgunWounds() == "NONE" and getRifleWounds() == "NONE" then
			TriggerServerEvent("FiveLife:SendNotification", "~b~Injuries: ~g~No Injuries", user)
		else
			TriggerServerEvent("FiveLife:SendNotification", "~b~Injuries: ~r~Injured", user)
		end
	end
	if myPlayer.bleedRate == 0.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Bleeding: ~g~Not bleeding", user)
	elseif myPlayer.bleedRate < 0.25 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Bleeding: ~y~Slightly", user)
	elseif myPlayer.bleedRate < 0.5 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Bleeding: ~o~Lightly", user)
	elseif myPlayer.bleedRate < 1.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Bleeding: ~r~Moderately", user)
	else
		TriggerServerEvent("FiveLife:SendNotification", "~b~Bleeding: ~r~Severely", user)
	end
	if GetEntityHealth(GetPlayerPed(-1)) < 200 then
		if myPlayer.morphineDose > 3 then
			TriggerServerEvent("FiveLife:SendNotification", "~b~Morphine: ~r~" .. myPlayer.morphineDose .. " Doses", user)
		else
			TriggerServerEvent("FiveLife:SendNotification", "~b~Morphine: ~g~" .. myPlayer.morphineDose .. " Doses", user)
		end
	end
end)

RegisterNetEvent("FL:CheckPulse")
AddEventHandler("FL:CheckPulse", function(user)
	if myPlayer.blood > 90.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~g~Normal", user)
	elseif myPlayer.blood > 75.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~y~Steady", user)
	elseif myPlayer.blood > 50.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~y~Low", user)
	elseif myPlayer.blood > 25.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~o~Very Low", user)
	elseif myPlayer.blood > 0.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~r~Critically Low", user)
	elseif myPlayer.heart == false then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Pulse: ~r~None", user)
	end
end)

RegisterNetEvent("FL:CheckBlood")
AddEventHandler("FL:CheckBlood", function(user)
	if myPlayer.blood < 75.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Blood: ~r~" .. round(myPlayer.blood) .. " Units.", user)
	elseif myPlayer.blood < 90.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Blood: ~g~" .. round(myPlayer.blood) .. " Units.", user)
	else
		TriggerServerEvent("FiveLife:SendNotification", "~b~Blood: ~w~" .. round(myPlayer.blood) .. " Units.", user)
	end
	if myPlayer.bleedRate == 0.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Bleeding: ~g~Not bleeding", user)
	elseif myPlayer.bleedRate < 0.25 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Bleeding: ~y~Slightly", user)
	elseif myPlayer.bleedRate < 0.5 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Bleeding: ~o~Lightly", user)
	elseif myPlayer.bleedRate < 1.0 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Bleeding: ~r~Moderately", user)
	else
		TriggerServerEvent("FiveLife:SendNotification", "~b~Bleeding: ~r~Severely", user)
	end
end)

RegisterNetEvent("FL:CheckInjuries")
AddEventHandler("FL:CheckInjuries", function(user)
	local handgunWounds = getHandgunWounds()
	local shotgunWounds = getShotgunWounds()
	local rifleWounds = getRifleWounds()
	local bluntWounds = getBluntWounds()
	local vehicleWounds = getVehicleWounds()
	local burnWounds = getBurnWounds()
	local otherWounds = getOtherWounds()

	if bluntWounds ~= "" then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Injuries: ~w~" .. bluntWounds, user)
	end
	if vehicleWounds ~= "" then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Injuries: ~w~" .. vehicleWounds, user)
	end
	if burnWounds ~= "" then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Injuries: ~w~" .. burnWounds, user)
	end
	if otherWounds ~= "" then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Injuries: ~w~" .. otherWounds, user)
	end
	if rifleWounds ~= "NONE" then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Injuries: ~w~" .. rifleWounds, user)
	end
	if shotgunWounds ~= "NONE" then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Injuries: ~w~" .. shotgunWounds, user)
	end
	if handgunWounds ~= "NONE" then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Injuries: ~w~" .. handgunWounds, user)
	end

	if otherWounds == "" and bluntWounds == "" and vehicleWounds == "" and burnWounds == "" and handgunWounds == "NONE" and shotgunWounds == "NONE" and rifleWounds == "NONE" then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Injuries: ~g~No Injuries", user)
	end
end)

RegisterNetEvent("FL:CheckDose")
AddEventHandler("FL:CheckDose", function(user)
	if myPlayer.morphineDose > 3 then
		TriggerServerEvent("FiveLife:SendNotification", "~b~Morphine: ~r~" .. myPlayer.morphineDose .. " doses in system", user)
	else
		TriggerServerEvent("FiveLife:SendNotification", "~b~Morphine: ~g~" .. myPlayer.morphineDose .. " doses in system", user)
	end
end)

RegisterNetEvent("FL:BandagePlayer")
AddEventHandler('FL:BandagePlayer', function(user)
	local targetID = tonumber(user)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetID))
	local targetCoords = GetEntityCoords(targetPed, true)
	local myCoords = GetEntityCoords(GetPlayerPed(-1), true)
	if targetPed ~= GetPlayerPed(-1) then
		if GetDistanceBetweenCoords(targetCoords.x, targetCoords.y, targetCoords.z, myCoords.x, myCoords.y, myCoords.z, true) < 3.0 then
			if situation.type ~= "DEAD" and situation.type ~= "DEAD_CUFFED" and situation.type ~= "DOWNED" then
				if hasItem('Bandage') then
					TriggerServerEvent("FiveLife:BandagePlayer", targetID)
					if onDuty == 0 then TriggerServerEvent("removeFromInventory", 0, 'Bandage', 1) end
					RequestAnimDict('amb@medic@standing@tendtodead@idle_a') while not HasAnimDictLoaded('amb@medic@standing@tendtodead@idle_a') do Citizen.Wait(0) end
					TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
					Wait(6000)
					ClearPedTasks(GetPlayerPed(-1))
					ShowNotification("~g~Bandaging successful.")
				else
					ShowNotification("~r~You have no Bandages!")
				end
			end
		else
			ShowNotification("~r~Must be closer to target.")
		end
	else
		ShowNotification("~r~Use your phone to bandage yourself!")
	end
end)

RegisterNetEvent("FL:BandageMe")
AddEventHandler('FL:BandageMe', function()
	if situation.type ~= "DEAD" and situation.type ~= "DEAD_CUFFED" then
		FreezeEntityPosition(GetPlayerPed(-1), true)
	end
	Wait(5500)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasks(GetPlayerPed(-1))
	ClearPedBloodDamage(GetPlayerPed(-1))
	ShowNotification("~g~You have been bandaged.")
	myPlayer.bleedRate = 0.0
	if situation.type == "DOWNED" then
		changeSituation("ALIVE")
		TriggerServerEvent("updatePlayerDeath", false)
	end
end)

RegisterNetEvent("FL:TransfusePlayer")
AddEventHandler('FL:TransfusePlayer', function(user)
	local targetID = tonumber(user)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetID))
	local targetCoords = GetEntityCoords(targetPed, true)
	local myCoords = GetEntityCoords(GetPlayerPed(-1), true)
	if targetPed ~= GetPlayerPed(-1) then
		if GetDistanceBetweenCoords(targetCoords.x, targetCoords.y, targetCoords.z, myCoords.x, myCoords.y, myCoords.z, true) < 3.0 then
			TriggerServerEvent("FiveLife:TransfusePlayer", targetID)
			RequestAnimDict('amb@medic@standing@tendtodead@idle_a') while not HasAnimDictLoaded('amb@medic@standing@tendtodead@idle_a') do Citizen.Wait(0) end
			TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
			Wait(10000)
			ClearPedTasks(GetPlayerPed(-1))
			ShowNotification("~g~Blood transfusion successful.")
		else
			ShowNotification("~r~Must be closer to target")
		end
	else
		ShowNotification("~r~You can't transfuse yourself!")
	end
end)

RegisterNetEvent("FL:TransfuseMe")
AddEventHandler('FL:TransfuseMe', function()
	if situation.type ~= "DEAD" and situation.type ~= "DEAD_CUFFED" then
		FreezeEntityPosition(GetPlayerPed(-1), true)
	end
	Wait(9000)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasks(GetPlayerPed(-1))
	ShowNotification("~g~You have received a blood transfusion.")
	myPlayer.blood = myPlayer.blood + 50.0
	if myPlayer.blood > 100.0 then
		myPlayer.blood = 100.0
	end
end)

RegisterNetEvent("FL:InjectPlayer")
AddEventHandler('FL:InjectPlayer', function(user, item)
	local targetID = tonumber(user)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetID))
	local targetCoords = GetEntityCoords(targetPed, true)
	local myCoords = GetEntityCoords(GetPlayerPed(-1), true)
	local injection = item
	if targetPed ~= GetPlayerPed(-1) then
		if GetDistanceBetweenCoords(targetCoords.x, targetCoords.y, targetCoords.z, myCoords.x, myCoords.y, myCoords.z, true) < 3.0 then
			if situation.type ~= "DEAD" and situation.type ~= "DEAD_CUFFED" and situation.type ~= "DOWNED" then
				if injection == 'MORPHINE' then injection = 'Morphine' elseif injection == 'ADRENALINE' then injection = 'Adrenaline' end
				if hasItem(injection) then
					TriggerServerEvent("FiveLife:InjectPlayer", targetID, injection)
					if onDuty == 0 then TriggerServerEvent("removeFromInventory", 0, injection, 1) end
					RequestAnimDict('amb@medic@standing@tendtodead@idle_a') while not HasAnimDictLoaded('amb@medic@standing@tendtodead@idle_a') do Citizen.Wait(0) end
					TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
					Wait(4500)
					ClearPedTasks(GetPlayerPed(-1))
					ShowNotification("~g~" .. injection .. " injection successful.")
				else
					ShowNotification("~r~You have no ~b~" .. injection .. "~r~!")
				end
			else
				--ShowNotification("~r~You must be alive to do that!")
			end
		else
			ShowNotification("~r~Must be closer to target")
		end
	else
		ShowNotification("~r~Use your phone to inject yourself!")
	end
end)

RegisterNetEvent("FL:InjectMe")
AddEventHandler('FL:InjectMe', function(item)
	if situation.type ~= "DEAD" and situation.type ~= "DEAD_CUFFED" then
		FreezeEntityPosition(GetPlayerPed(-1), true)
	end
	Wait(4000)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasks(GetPlayerPed(-1))
	ShowNotification("~g~You have been injected with " .. item .. ".")
	if item == 'Morphine' then
		if GetEntityHealth(GetPlayerPed(-1)) < 200 then
			SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 35)
		end
		myPlayer.morphineDose = myPlayer.morphineDose + 1
		doseTimer = 90
	elseif item == 'Adrenaline' then
		if situation.type == "DEAD" or situation.type == "DEAD_CUFFED" then
			if myPlayer.heart then
				local coord = GetEntityCoords(GetPlayerPed(-1), true)
				local head = GetEntityHeading(GetPlayerPed(-1))
				NetworkResurrectLocalPlayer(coord.x, coord.y, coord.z, head, true, false)
				TriggerServerEvent("ActionLog", "was revived.", 0)
				changeSituation("ALIVE")
				SetPlayerInvincible(PlayerId(), false)
				TriggerServerEvent("updatePlayerDeath", false)
				resetDamageLog()
			end
		else
			myPlayer.adrenaline = myPlayer.adrenaline + 20
			StartScreenEffect("DMT_flight", myPlayer.adrenaline*1000, false)
		end
	end
end)

RegisterNetEvent("FL:CprPlayer")
AddEventHandler('FL:CprPlayer', function(user)
	local targetID = tonumber(user)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetID))
	local targetCoords = GetEntityCoords(targetPed, true)
	local myCoords = GetEntityCoords(GetPlayerPed(-1), true)
	if targetPed ~= GetPlayerPed(-1) then
		if GetDistanceBetweenCoords(targetCoords.x, targetCoords.y, targetCoords.z, myCoords.x, myCoords.y, myCoords.z, true) < 3.0 then
			if situation.type ~= "DEAD" and situation.type ~= "DEAD_CUFFED" and situation.type ~= "DOWNED" then
				local targetSide = GetOffsetFromEntityInWorldCoords(targetPed, 1.0, 0.0, 0.0)
				TriggerServerEvent("FiveLife:CprPlayer", targetID)
				SetEntityCoords(GetPlayerPed(-1), targetSide.x, targetSide.y, targetSide.z-0.5)
				SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(targetPed)-270)
				RequestAnimDict('mini@cpr@char_a@cpr_str') while not HasAnimDictLoaded('mini@cpr@char_a@cpr_str') do Citizen.Wait(0) end
				TaskPlayAnim(GetPlayerPed(-1), 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
				Wait(3000)
				SetEntityCoords(GetPlayerPed(-1), targetSide.x, targetSide.y, targetSide.z-0.5)
				SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(targetPed)-270)
				Wait(9000)
				ClearPedTasks(GetPlayerPed(-1))
				if GetRandomIntInRange(1, 10) > 6 then
					ShowNotification("~g~CPR successful!")
					TriggerServerEvent("FiveLife:CprSuccess", targetID)
				else
					ShowNotification("~r~CPR failed!")
				end
			end
		else
			ShowNotification("~r~Must be closer to target")
		end
	else
		ShowNotification("~r~You can't perform CPR on yourself!")
	end
end)

RegisterNetEvent("FL:CprMe")
AddEventHandler('FL:CprMe', function()
	myPlayer.cpr = true
	RequestAnimDict('mini@cpr@char_b@cpr_str') while not HasAnimDictLoaded('mini@cpr@char_b@cpr_str') do Citizen.Wait(0) end
	if not myPlayer.resurrect then
		local coord = GetEntityCoords(GetPlayerPed(-1), true)
		local head = GetEntityHeading(GetPlayerPed(-1))
		NetworkResurrectLocalPlayer(coord.x, coord.y, coord.z, head, true, false)
		myPlayer.resurrect = true
	end
	ClearPedTasksImmediately(GetPlayerPed(-1))
	TaskPlayAnim(GetPlayerPed(-1), 'mini@cpr@char_b@cpr_str', 'cpr_pumpchest', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
	Wait(11000)
	ClearPedTasks(GetPlayerPed(-1))
	myPlayer.cpr = false
	SetPedToRagdoll(GetPlayerPed(-1), 10000, 10000, 0, 0, 0, 0)
end)

RegisterNetEvent("FL:CprSuccess")
AddEventHandler('FL:CprSuccess', function()
	ShowNotification("~g~CPR successful!")
	if myPlayer.blood < 20.0 then
		myPlayer.blood = 20.0
	end
	myPlayer.heart = true
	SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
	TriggerServerEvent("updatePlayerDeath", false)
end)

RegisterNetEvent("FL:DefibPlayer")
AddEventHandler('FL:DefibPlayer', function(user)
	local targetID = tonumber(user)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetID))
	local targetCoords = GetEntityCoords(targetPed, true)
	local myCoords = GetEntityCoords(GetPlayerPed(-1), true)
	if targetPed ~= GetPlayerPed(-1) then
		if GetDistanceBetweenCoords(targetCoords.x, targetCoords.y, targetCoords.z, myCoords.x, myCoords.y, myCoords.z, true) < 3.0 then
			local targetSide = GetOffsetFromEntityInWorldCoords(targetPed, 1.0, 0.0, 0.0)
			SetEntityCoords(GetPlayerPed(-1), targetSide.x, targetSide.y, targetSide.z-0.5)
			SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(targetPed)-270)
			RequestAnimDict('amb@medic@standing@tendtodead@idle_a') while not HasAnimDictLoaded('amb@medic@standing@tendtodead@idle_a') do Citizen.Wait(0) end
			TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
			Wait(5000)
			ClearPedTasks(GetPlayerPed(-1))
			if GetRandomIntInRange(1, 10) > 4 then
				ShowNotification("~g~Defib successful!")
				TriggerServerEvent("FiveLife:DefibSuccess", targetID)
			else
				ShowNotification("~r~Defib failed!")
			end
		else
			ShowNotification("~r~Must be closer to target")
		end
	else
		ShowNotification("~r~You can't Defib on yourself!")
	end
end)

RegisterNetEvent("FL:DefibSuccess")
AddEventHandler('FL:DefibSuccess', function()
	ShowNotification("~g~Defib successful!")
	if myPlayer.blood == 0.0 then
		myPlayer.blood = 30.0
	end
	myPlayer.heart = true
	TriggerServerEvent("updatePlayerDeath", false)
end)


-- =============================================== UPDATES (EVERY SECOND) ============================================================

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if waitTimer ~= 0 then
			waitTimer = waitTimer - 1
		end

		if doseTimer ~= 0 then
			doseTimer = doseTimer - 1
		elseif myPlayer.morphineDose ~= 0 then
			myPlayer.morphineDose = myPlayer.morphineDose - 1
			doseTimer = 90
		end

		if myPlayer.blood > 0.0 then
			if myPlayer.bleedRate ~= 0.0 then
				if myPlayer.adrenaline == 0 then
					myPlayer.blood = (myPlayer.blood - myPlayer.bleedRate)
				end
				if reminder > 0 then
					reminder = reminder - 1
				elseif situation.type ~= "DEAD" and situation.type ~= "DEAD_CUFFED" then
					if myPlayer.bleedRate > 1.0 then
						ShowNotification("~r~You are bleeding severely! ~y~Bandage yourself!")
					elseif myPlayer.bleedRate > 0.5 then
						ShowNotification("~r~You are bleeding moderately. ~y~Bandage yourself!")
					elseif myPlayer.bleedRate > 0.25 then
						ShowNotification("~r~You are bleeding slightly.")
					else
						ShowNotification("~r~You are bleeding a little.")
					end
					reminder = 30
				end
			end
			if myPlayer.blood > 90.0 then
				if myPlayer.bleedRate < 0.05 then
					if GetEntityHealth(GetPlayerPed(-1)) < 175 then
						SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 1)
					end
				end
			elseif myPlayer.blood > 55.0 then
				if myPlayer.bleedRate < 0.25 then
					if GetEntityHealth(GetPlayerPed(-1)) < 145 then
						SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 1)
					end
				elseif myPlayer.bleedRate < 0.5 then
					if GetEntityHealth(GetPlayerPed(-1)) < 135 then
						SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 1)
					end
				elseif myPlayer.bleedRate < 0.10 then
					if GetEntityHealth(GetPlayerPed(-1)) < 125 then
						SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 1)
					end
				end
			elseif myPlayer.blood < 30.0 then
				if myPlayer.adrenaline == 0 then
					if GetRandomIntInRange(1, 20) > 17 then
						if situation.type == "ALIVE" then
							SetPedToRagdoll(GetPlayerPed(-1), 2000, 2000, 0, 0, 0, 0)
						end
					end
				end
				if situation.type == "DEAD" or situation.type == "DEAD_CUFFED" then
					if GetEntityHealth(GetPlayerPed(-1)) > 115 then
						SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) - 1)
					end
				end
			end
		end
		if GetEntityHealth(GetPlayerPed(-1)) > 180 then
			if myPlayer.blood < 80.0 then
				if myPlayer.bleedRate == 0.0 then
					myPlayer.blood = myPlayer.blood + 0.1
				end
			end
		end
		if GSR ~= 0 then
			GSR = GSR - 1
		end
		if myPlayer.adrenaline ~= 0 then
			myPlayer.adrenaline = myPlayer.adrenaline - 1
			RestorePlayerStamina(PlayerId(), 100.0)
		end
	end
end)




-- =============================================== CHECKS & STUFF ============================================================

Citizen.CreateThread(function()
	while true do
		local myPed = GetPlayerPed(-1)
		Citizen.Wait(0)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		CheckAtHospital()
		if smenu.input then
			checkReviveKeyboard()
		end
		if IsPedShooting(GetPlayerPed(-1)) then
			GSR = 900
		end

		if myPlayer.morphineDose > 5 and myPlayer.heart then
			myPlayer.heart = false
			TriggerServerEvent("updatePlayerDeath", true)
			ShowNotification("~r~You have been overdosed and your heart is failing!")
		end

		if myPlayer.blood < 1.0 and myPlayer.blood ~= 0.0 then
			if myPlayer.heart then
				myPlayer.heart = false
				TriggerServerEvent("updatePlayerDeath", true)
				ShowNotification("~r~Your heart has stopped!")
			end
			myPlayer.blood = 0.0
		elseif myPlayer.blood < 15.0 and myPlayer.blood ~= 0.0 then
			if situation.type ~= "DEAD" and situation.type ~= "DEAD_CUFFED" then
				changeSituation("DEAD")
				ShowNotification("~r~You have passed out!")
				smenu.called = false
				waitTimer = 300
			end
		end

		-- =============== Player Health Checks ===============
		if IsPlayerDead(PlayerId()) then
			local _, bone = GetPedLastDamageBone(myPed)
			SetPedToRagdoll(myPed, 5000, 5000, 0, 0, 0, 0)
			SetEntityInvincible(myPed, true)
			SetEntityHealth(myPed, 110)
			myPlayer.resurrect = false
			if situation.type == "ALIVE" or situation.type == "CUFFED" or situation.type == "GRABBED" then
				if bone == 31086 then -- Head
					changeSituation("DEAD")
					tookBleedDamage(0.4, false)
					ShowNotification("~r~You are unconscious!")
					TriggerServerEvent("updatePlayerDeath", true)
				elseif HasPedBeenDamagedByNonLethalWeapon() then
					ClearPedTasks(myPed)
					SetPedToRagdoll(myPed, 5000, 5000, 0, 0, 0, 0)
					changeSituation("DOWNED")
					ShowNotification("~r~You are injured and bleeding! ~y~Bandage yourself!")
					if myPlayer.bleedRate == 0.0 then
						tookBleedDamage(0.5, false)
					else
						tookBleedDamage(0.25, false)
					end
				else
					changeSituation("DEAD")
					tookBleedDamage(0.2, false)
					ShowNotification("~r~You are unconscious!")
				end
				lastInjury.damaged = true
				checkInjuries()
				smenu.called = false
				waitTimer = 300
				smenu.row = 1
			elseif situation.type == "JAILED" then
				changeSituation("KO")
				myPlayer.bleedRate = 0.0
				ShowNotification("~r~You are knocked out!")
				waitTimer = 15
			elseif situation.type == "DOWNED" then
				ClearPedTasks(myPed)
				SetPedToRagdoll(myPed, 5000, 5000, 0, 0, 0, 0)
				changeSituation("DEAD")
				tookBleedDamage(0.1, false)
				TriggerServerEvent("updatePlayerDeath", true)
				ShowNotification("~r~You are unconscious!")
				lastInjury.damaged = true
				checkInjuries()
				smenu.called = false
				waitTimer = 300
				smenu.row = 1
			end
		elseif GetEntityHealth(myPed) > 251 then
			TriggerServerEvent("AntiCheat:Banned", "Health Modification", "Recorded Health - " .. GetEntityHealth(myPed))
		elseif GetEntityHealth(myPed) < 110 and situation.type ~= "KO" and situation.type ~= "KO_JAIL" then
			if IsPedInMeleeCombat(myPed) then
				changeSituation("KO")
				ShowNotification("~r~You are knocked out!")
				waitTimer = 15
			end
		end
		if not IsPlayerDead(PlayerId()) then
			checkInjuries()
		end

		-- ====== Dead & Knockout Functions ======
		if situation.type == "DEAD" or situation.type == "DEAD_CUFFED" or situation.type == "DRAGGED" then
			drawMedicMenu()
		elseif situation.type == "KO" or situation.type == "KO_JAIL" then
			if waitTimer > 0 then
				SetEntityHealth(myPed, GetEntityHealth(myPed)+4)
			else
				changeSituation("ALIVE")
			end
		end

-- ========================================== KEY PRESSES ==========================================

		if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
			if smenu.row == 2 then
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				smenu.row = 1
			end
		elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
			if smenu.row == 1 then
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				smenu.row = 2
			end
		elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
			if spotlight then
				additive = additive-1.0
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
			if spotlight then
				additive = additive+1.0
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
			if situation.type == "DEAD_CUFFED" or situation.type == "DEAD" or situation.type == "DRAGGED" then
				if smenu.row == 1 then
					-- Teleport to spawn
					if waitTimer > 0 then
						ShowNotification("Wait " .. waitTimer .. "s to Respawn")
					else
						if situation.type ~= "DEAD_CUFFED" then
							PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							respawn_revive("RESPAWN")
						elseif situation.type == "DRAGGED" then
							ShowNotification("~r~You can't respawn while being dragged!")
						else
							ShowNotification("~r~You can't respawn while cuffed!")
						end
					end
				elseif smenu.row == 2 and smenu.called == false then
					PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					if smenu.called == false then
						keyboardOpen = true
						smenu.input = true
						smenu.called = true
						DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
					end
				end
			end
		end
	end
end)

-- ========================================== HELPER FUNCTIONS ==========================================

function respawn_revive(which)
	if which == "RESPAWN" then
		NetworkResurrectLocalPlayer(8.4, -1674.9, 300.0, 0.0, true, false)
		RemoveAllPedWeapons(GetPlayerPed(-1), true)
		TriggerServerEvent("takeAllWeapons", 0)
		TriggerServerEvent("wipeInventory", 0)
		TriggerServerEvent("respawnMenu")
		TriggerServerEvent("ActionLog", "died.", 0)
		changeSituation("ALIVE")
		changeStance("STANDING")
	elseif which == "REVIVE" then
		local coord = GetEntityCoords(GetPlayerPed(-1), true)
		local head = GetEntityHeading(GetPlayerPed(-1))
		NetworkResurrectLocalPlayer(coord.x, coord.y, coord.z, head, true, false)
		changeSituation("ALIVE")
		changeStance("PRONE")
	end
	myPlayer.blood = 100.0
	myPlayer.bleedRate = 0.0
	myPlayer.heart = true
	myPlayer.resurrect = true
	SetPlayerInvincible(PlayerId(), false)
	SetEntityHealth(GetPlayerPed(-1), 200)
	ClearPedBloodDamage(GetPlayerPed(-1))
	TriggerServerEvent("updatePlayerDeath", false)
	resetDamageLog()
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(false, false)
end

function drawMedicMenu()
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(0)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.155, 0.16, 0.034, 0, 0, 0, 255)
	if myPlayer.heart == false then
		drawTxt(0.795, 0.075, 0.0, 0.0, 0.50, "Deceased",255,255,255,255)
	else
		drawTxt(0.795, 0.075, 0.0, 0.0, 0.50, "Injured",255,255,255,255)
	end
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, "MEDICS ONLINE: " .. medicCount,30,88,162,255)

	if waitTimer > 0 then
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Respawn (" .. waitTimer .. "s)",114,114,114,255)
	else
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Respawn",255,255,255,255)
	end
	if smenu.called == false then
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Call Medic",255,255,255,255)
	else
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Call Medic",114,114,114,255)
	end
	if smenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
	if smenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
end

function checkReviveKeyboard()
	HideHudAndRadarThisFrame()
	if UpdateOnscreenKeyboard() == 3 then
		keyboardOpen = false
		smenu.input = false
	elseif UpdateOnscreenKeyboard() == 1 then
		local inputText = GetOnscreenKeyboardResult()
		if string.len(inputText) > 0 then
			ShowNotification("~g~Report sent to ~b~Emergency Services~g~.")
			local pos = GetEntityCoords(GetPlayerPed(-1))
			local area = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
			TriggerServerEvent("newReport", 'ems', pos.x, pos.y, pos.z, inputText, area)
			keyboardOpen = false
			smenu.input = false
		else
			DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 128)
		end
	elseif UpdateOnscreenKeyboard() == 2 then
		keyboardOpen = false
		smenu.input = false
	end
end

function getHandgunWounds()
	local returnResults = false
	local handgunEntries = "Entries (9mm): "
	for i=1, 11 do
		if damageLog.shotHand[i] ~= 0 then
			handgunEntries = handgunEntries .. advDamageKey[i] .. " (" .. damageLog.shotHand[i] .. ")~w~, "
			returnResults = true
		end
	end
	if returnResults then return handgunEntries else return "NONE" end
end

function getShotgunWounds()
	local returnResults = false
	local shotgunEntries = "Entries (12g): "
	for i=1, 11 do
		if damageLog.shotPump[i] ~= 0 then
			shotgunEntries = shotgunEntries .. advDamageKey[i] .. " (" .. damageLog.shotPump[i] .. ")~w~, "
			returnResults = true
		end
	end
	if returnResults then return shotgunEntries else return "NONE" end
end

function getRifleWounds()
	local returnResults = false
	local rifleEntries = "Entries (5.56): "
	for i=1, 11 do
		if damageLog.shotRifle[i] ~= 0 then
			rifleEntries = rifleEntries .. advDamageKey[i] .. " (" .. damageLog.shotRifle[i] .. ")~w~, "
			returnResults = true
		end
	end
	if returnResults then return rifleEntries else return "NONE" end
end

function checkInjuries()
	local myPed = GetPlayerPed(-1)
	local _, bone = GetPedLastDamageBone(myPed)

	if GetPedArmour(myPed) > 0 then
		if GetPedArmour(myPed) > lastInjury.armor then
			lastInjury.armor = GetPedArmour(myPed)
		elseif GetPedArmour(myPed) < lastInjury.armor then
			lastInjury.armor = GetPedArmour(myPed)
			lastInjury.damaged = true
		end
	end
	if GetEntityHealth(myPed) > lastInjury.health then
		lastInjury.health = GetEntityHealth(myPed)
	elseif GetEntityHealth(myPed) < lastInjury.health then
		lastInjury.health = GetEntityHealth(myPed)
		lastInjury.damaged = true
	end

	if lastInjury.damaged then
		SetEntityInvincible(myPed, true)
		if HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_cougar"), 0) or HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_animal"), 0) then
			lastInjury.type = "ANIMAL"
		elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_fire"), 0) then
			lastInjury.type = "FIRE"
		elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_explosion"), 0) then
			lastInjury.type = "EXPLOSION"
		elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_drowning"), 0) or HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_drowning_in_vehicle"), 0)  then
			lastInjury.type = "DROWNED"
		elseif HasPedBeenDamagedByWeapon(myPed, 0, 1) then
			lastInjury.type = "BLUNT"
		elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_rammed_by_car"), 0) or HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_run_over_by_car"), 0) then
			lastInjury.type = "VEHICLE"
		elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_fall"), 0) then
			lastInjury.type = "FELL"
		elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_pistol"), 0) or HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_combatpistol"), 0) or HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_snspistol"), 0) or HasEntityBeenDamagedByWeapon(myPed, GetHashKey("weapon_vintagepistol"), 0) then
			lastInjury.type = "HANDGUN"
		elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_pumpshotgun"), 0) then
			lastInjury.type = "SHOTGUN"
		elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_carbinerifle"), 0) then
			lastInjury.type = "RIFLE"
		else
			lastInjury.type = ""
		end

		if lastInjury.type == "HANDGUN" or lastInjury.type == "SHOTGUN" or lastInjury.type == "RIFLE" then
			if bone == 31086 then
				lastInjury.location = 1		-- Head
				tookBleedDamage(0.5, false)
			elseif bone == 39317 or bone == 10706 or bone == 64729 then
				lastInjury.location = 2		-- Neck
				tookBleedDamage(0.4, false)
			elseif bone == 24818 or bone == 24817 or bone == 24816 or bone == 23553 then
				lastInjury.location = 3		-- Chest
				tookBleedDamage(0.2, true)
			elseif bone == 40269 or bone == 2992 then
				lastInjury.location = 4		-- Upper_R_Arm
				tookBleedDamage(0.1, true)
			elseif  bone == 28252 or bone == 57005 then
				lastInjury.location = 5		-- Lower_R_Arm
				tookBleedDamage(0.05, false)
			elseif bone == 45509 or bone == 22711 then
				lastInjury.location = 6		-- Upper_L_Arm
				tookBleedDamage(0.1, true)
			elseif  bone == 61163 or bone == 18905 then
				lastInjury.location = 7		-- Lower_L_Arm
				tookBleedDamage(0.05, false)
			elseif bone == 51826 or bone == 16335 then
				lastInjury.location = 8		-- Upper_R_Leg
				tookBleedDamage(0.1, false)
			elseif  bone == 36864 or bone == 52301 then
				lastInjury.location = 9		-- Lower_R_Leg
				tookBleedDamage(0.05, false)
			elseif bone == 58271 or bone == 14201 then
				lastInjury.location = 10 	-- Upper_L_Leg
				tookBleedDamage(0.1, false)
			elseif  bone == 63931 or bone == 14201 then
				lastInjury.location = 11	-- Lower_L_Leg
				tookBleedDamage(0.05, false)
			elseif bone == 11816 then
				if GetRandomIntInRange(1, 10) > 5 then
					lastInjury.location = 8	-- Upper_R_Leg
				else
					lastInjury.location = 10-- Upper_L_Leg
				end
				tookBleedDamage(0.1, false)
			end
			if lastInjury.location ~= 0 then
				Citizen.Trace("DEBUG: Shot in " .. advDamageKey[lastInjury.location])
			end
		elseif lastInjury.type ~= "" then
			if bone == 31086 then
				lastInjury.location = 1	-- Head
				if lastInjury.type == "FELL" or lastInjury.type == "VEHICLE" or lastInjury.type == "BLUNT" then
					tookBleedDamage(0.1, false)
				end
			elseif bone == 24818 or bone == 24817 or bone == 24816 or bone == 23553 then
				lastInjury.location = 2 -- Chest
				if lastInjury.type == "FELL" or lastInjury.type == "VEHICLE" then
					if GetRandomIntInRange(1, 10) > 5 then
						tookBleedDamage(0.1, false)
					end
				end
			elseif bone == 45509 or bone == 61163 or bone == 18905 or bone == 22711 or bone == 40269 or bone == 28252 or bone == 57005 or bone == 2992 then
				lastInjury.location = 3 -- Arms
			elseif bone == 11816 or bone == 58271 or bone == 63931 or bone == 14201 or bone == 51826 or bone == 36864 or bone == 52301 then
				lastInjury.location = 4 -- Legs
			end
			if lastInjury.location ~= 0 then
				Citizen.Trace("DEBUG: " .. lastInjury.type .. " - " .. damageKey[lastInjury.location])
			end
		end
		if lastInjury.location ~= 0 and lastInjury.type ~= "" then
			logDamage(lastInjury.type, lastInjury.location)
		end

		lastInjury.damaged = false
		lastInjury.type = ""
		lastInjury.location = 0
		Wait(250)
		SetEntityInvincible(myPed, false)
		ClearPedLastDamageBone(myPed)
		ClearPedLastWeaponDamage(myPed)
		ClearEntityLastDamageEntity(myPed)
	end
	--ClearPedLastDamageBone(myPed)
	--ClearPedLastWeaponDamage(myPed)
	--ClearEntityLastDamageEntity(myPed)
end

function logDamage(injury, place)
	if injury == "HANDGUN" then
		damageLog.shotHand[place] = damageLog.shotHand[place] + 1
	elseif injury == "SHOTGUN" then
		damageLog.shotPump[place] = damageLog.shotPump[place] + 1
	elseif injury == "RIFLE" then
		damageLog.shotRifle[place] = damageLog.shotRifle[place] + 1
	elseif injury == "DROWNED" then
		damageLog.drowned[1] = damageLog.drowned[1] + 1
	elseif injury == "VEHICLE" then
		damageLog.vehicle[place] = damageLog.vehicle[place] + 1
	elseif injury == "FELL" then
		damageLog.fell[place] = damageLog.fell[place] + 1
	elseif injury == "FIRE" then
		damageLog.burned[place] = damageLog.burned[place] + 1
	elseif injury == "ANIMAL" then
		damageLog.bites[place] = damageLog.bites[place] + 1
	elseif injury == "EXPLOSION" then
		damageLog.deepBurns[place] = damageLog.deepBurns[place] + 1
	elseif injury == "BLUNT" then
		damageLog.blunt[place] = damageLog.blunt[place] + 1
	end
end

function resetDamageLog()
	for i=1, 11 do
		damageLog.shotHand[i] = 0
		damageLog.shotPump[i] = 0
		damageLog.shotRifle[i] = 0
	end
	for i=1, 4 do
		damageLog.drowned[i] = 0
		damageLog.vehicle[i] = 0
		damageLog.fell[i] = 0
		damageLog.burned[i] = 0
		damageLog.bites[i] = 0
		damageLog.deepBurns[i] = 0
		damageLog.blunt[i] = 0
	end
end

function tookBleedDamage(increaseBleed, checkVest)
	if checkVest then
		if onDuty == 0 then
			if myPlayer.bleedRate == 0.0 then
				ShowNotification("~r~You are bleeding!")
			end
			myPlayer.bleedRate = myPlayer.bleedRate + increaseBleed
		end
	else
		if myPlayer.bleedRate == 0.0 then
			ShowNotification("~r~You are bleeding!")
		end
		myPlayer.bleedRate = myPlayer.bleedRate + increaseBleed
	end
end

function getBluntWounds()
	local checkBlunt = false
	local blunts = ""
	local allInjuries = ""
	for i=1, 4 do
		if damageLog.blunt[i] ~= 0 then checkBlunt = true end
	end
	if checkBlunt then
		if damageLog.blunt[1] ~= 0 then
			blunts = "Blunt trauma to ~r~head and neck~w~"
		elseif damageLog.blunt[2] ~= 0 then
			blunts = "Blunt trauma to ~y~chest~w~ and back"
		elseif damageLog.blunt[3] ~= 0 then
			blunts = "Blunt trauma to arms"
		elseif damageLog.blunt[4] ~= 0 then
			blunts = "Blunt trauma to legs"
		end
		allInjuries = allInjuries .. blunts .. ". "
	end

	return allInjuries
end

function getVehicleWounds()
	local checkRanOver = false
	local ranOver = ""
	local vehicleHitCount = 0
	local allInjuries = ""
	for i=1, 4 do
		if damageLog.vehicle[i] ~= 0 then checkRanOver = true end
	end
	if checkRanOver then
		ranOver = "Vehicle trauma on "
		if damageLog.vehicle[1] ~= 0 then
			ranOver = ranOver .. "~r~head and neck~w~"
			vehicleHitCount = vehicleHitCount + 1
		elseif damageLog.vehicle[2] ~= 0 then
			if vehicleHitCount > 0 then
				ranOver = ranOver .. ", ~y~chest~w~ and back"
			else
				ranOver = ranOver .. "~y~chest~w~ and back"
			end
			vehicleHitCount = vehicleHitCount + 1
		elseif damageLog.vehicle[3] ~= 0 then
			if vehicleHitCount > 0 then
				ranOver = ranOver .. ", arms"
			else
				ranOver = ranOver .. "arms"
			end
			vehicleHitCount = vehicleHitCount + 1
		elseif damageLog.vehicle[4] ~= 0 then
			if vehicleHitCount > 0 then
				ranOver = ranOver .. ", and legs"
			else
				ranOver = ranOver .. "legs"
			end
		end
		allInjuries = allInjuries .. ranOver .. ". "
	end

	return allInjuries
end

function getBurnWounds()
	local checkBurns = false
	local checkBurns2 = false
	local burns = ""
	local allInjuries = ""
	for i=1, 4 do
		if damageLog.burned[i] ~= 0 then checkBurns = true end
		if damageLog.deepBurns[i] ~= 0 then checkBurns2 = true end
	end
	if checkBurns2 then
		local extra = ""
		local burnCount = 0
		allInjuries = allInjuries .. "3rd Degree burns on "
		if damageLog.deepBurns[1] ~= 0 then
			burns = burns + "~r~head, neck~w~"
			burnCount = burnCount + 1
		end
		if damageLog.deepBurns[2] ~= 0 then
			if burnCount > 0 then
				extra = ", "
			end
			burns = burns .. extra .. "~y~chest~w~, back"
			burnCount = burnCount + 1
		end
		if damageLog.deepBurns[3] ~= 0 then
			if burnCount > 0 then
				extra = ", "
			end
			burns = burns .. extra .. "arms"
			burnCount = burnCount + 1
		end
		if damageLog.deepBurns[4] ~= 0 then
			if burnCount > 0 then
				extra = ", and "
			end
			burns = burns .. extra .. "legs"
			burnCount = burnCount + 1
		end
		allInjuries = allInjuries .. burns .. ". "
	elseif checkBurns then
		local extra = ""
		local burnCount = 0
		allInjuries = allInjuries .. "2nd Degree burns on "
		if damageLog.burned[1] ~= 0 then
			burns = burns .. "~r~head, neck~w~"
			burnCount = burnCount + 1
		end
		if damageLog.burned[2] ~= 0 then
			if burnCount > 0 then
				extra = ", "
			end
			burns = burns .. extra .. "~y~chest~w~, back"
			burnCount = burnCount + 1
		end
		if damageLog.burned[3] ~= 0 then
			if burnCount > 0 then
				extra = ", "
			end
			burns = burns .. extra .. "arms"
			burnCount = burnCount + 1
		end
		if damageLog.burned[4] ~= 0 then
			if burnCount > 0 then
				extra = ", and "
			end
			burns = burns .. extra .. "legs"
			burnCount = burnCount + 1
		end
		allInjuries = allInjuries .. burns .. ". "
	end

	return allInjuries
end

function getOtherWounds()
	local checkDrowned = false
	local checkFell = false
	local checkBites = false
	local falls = ""
	local animalBites = ""
	local allInjuries = ""

	if damageLog.drowned[1] ~= 0 then
		checkDrowned = true
	end
	for i=1, 4 do
		if damageLog.fell[i] ~= 0 then checkFell = true end
		if damageLog.bites[i] ~= 0 then checkBites = true end
	end

	if checkFell then
		if damageLog.fell[1] ~= 0 then
			falls = "Fell on their ~r~head and neck~w~"
		elseif damageLog.fell[2] ~= 0 then
			falls = "Fell on their ~y~chest~w~ and back (" .. damageLog.fell[2] .. ")"
		elseif damageLog.fell[3] ~= 0 then
			falls = "Fell on their arms (" .. damageLog.fell[3] .. ")"
			if damageLog.fell[4] ~= 0 then
				falls = "Fell on their arms and legs (" .. (damageLog.fell[3] + damageLog.fell[4]) .. ")"
			end
		elseif damageLog.fell[4] ~= 0 then
			falls = "Fell on their legs (" .. damageLog.fell[4] .. ")"
		end
		allInjuries = allInjuries .. falls .. ". "
	end

	if checkBites then
		if damageLog.bites[1] ~= 0 then
			animalBites = "Scratches and bites on ~r~face and neck~w~"
		elseif damageLog.bites[2] ~= 0 then
			animalBites = "Scratches and bites on ~y~chest~w~ and back"
		elseif damageLog.bites[3] ~= 0 then
			animalBites = "Scratches and bites on arms (" .. damageLog.bites[3] .. ")"
			if damageLog.bites[4] ~= 0 then
				falls = "Scratches and bites on arms and legs (" .. (damageLog.bites[3] + damageLog.bites [4]) .. ")"
			end
		elseif damageLog.bites[4] ~= 0 then
			animalBites = "Scratches and bites on legs (" .. damageLog.bites[4] .. ")"
		end
		allInjuries = allInjuries .. animalBites .. ". "
	end

	return allInjuries
end

function HasPedBeenDamagedByNonLethalWeapon()
	local myPed = GetPlayerPed(-1)
	local lethal = true
	if HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_explosion"), 0) then
		lethal = false
	elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_drowning"), 0) or HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_drowning_in_vehicle"), 0)  then
		lethal = false
	elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_pumpshotgun"), 0) then
		lethal = false
	elseif HasPedBeenDamagedByWeapon(myPed, GetHashKey("weapon_carbinerifle"), 0) then
		lethal = false
	end
	return lethal
end

function CheckAtHospital()
	atHospital = false
	for i=1, #hospitalLocations do
		if drawMarker(hospitalLocations[i], 20, 1.5, 0) == true then atHospital = true end
	end
	if atHospital then
		local morphineCost = round((200-GetEntityHealth(GetPlayerPed(-1)))*1.3)
		if morphineCost < 0 then morphineCost = 0 end
		local bandageCost = round(myPlayer.bleedRate*100.0)
		if bandageCost < 0 then morphineCost = 0 end
		local bloodCost = round((100.0-myPlayer.blood)*2.0)
		if bloodCost < 0 then morphineCost = 0 end
		local hospitalBill = morphineCost + bandageCost + bloodCost
		if hospitalBill == 0 then
			ShowTip("You are not injured.")
		else
			ShowTip("Press ~INPUT_ENTER~ to get treated for $" .. hospitalBill .. ".")
		end
		if IsControlJustPressed(1, 23) or IsDisabledControlJustPressed(1, 23) then -- F
			if moneyCash > hospitalBill then
				TriggerServerEvent("deductMoney", 0, hospitalBill)
				healPlayer()
			elseif moneyBank > hospitalBill then
				TriggerServerEvent("removeMoney", 0, hospitalBill)
				healPlayer()
			else
				ShowNotification("~r~You don't have any insurance or money!")
			end
		end
	end
end

function healPlayer()
	myPlayer.blood = 100.0
	myPlayer.bleedRate = 0.0
	myPlayer.heart = true
	myPlayer.resurrect = true
	SetPlayerInvincible(PlayerId(), false)
	SetEntityHealth(GetPlayerPed(-1), 200)
	ClearPedBloodDamage(GetPlayerPed(-1))
	TriggerServerEvent("updatePlayerDeath", false)
	resetDamageLog()
end

function drawTxt(x, y, width, height, scale, text, r,g,b, a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
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
