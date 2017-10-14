--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

-- Global client side variables, accessed in various client code
damageLog = {
	drowned = {0}, -- Chest
	fell = {0, 0, 0, 0}, -- Head, Chest, Arms, Legs
	burned = {0, 0, 0, 0},
	blunt = {0, 0, 0, 0},
	bites = {0, 0, 0, 0},
	deepBurns = {0, 0, 0, 0},
	vehicle = {0, 0, 0, 0},
	shotHand = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- Head, Neck, Chest, rArmUpper, rArmLower, lArmUpper, lArmLower, rLegUpper, rLegLower, lLegUpper, lLegLower
	shotPump = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	shotRifle = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}

invItem = {slot1 = "Empty", slot2 = "Empty", slot3 = "Empty", slot4 = "Empty", slot5 = "Empty", slot6 = "Empty", slot7 = "Empty", slot8 = "Empty", slot9 = "Empty", slot10 = "Empty"}
invAmount = {slot1 = 0, slot2 = 0, slot3 = 0, slot4 = 0, slot5 = 0, slot6 = 0, slot7 = 0, slot8 = 0, slot9 = 0, slot10 = 0}
storeCooldown = {false, false, false, false, false, false, false, false, false, false, false, false, false, false}
heistCooldown = {high = false, mid = false, low = false, prisonCool = false, prisonStatus = 'locked', involved = false}
newWeather = {now = "CLEAR", new = "CLEAR"}
newTime = {h = 18, m = 0, s = 0}
onDuty = 0
jobLevel = 0
phoneEnabled = false
sacked = false
ziptied = false
handState = false
moneyBank = 0
moneyCash = 0
playerRPname = 'none'
admin_mode = false
playerBusy = false
saspUnits = {}
lspdUnits = {}
medicUnits = {}
docUnits = {}
emergencyCalls = {}
policeCount = 0
medicCount = 0
totalFuelLevel = 350
job_vehicle = 0
job_status = 0
GSR = 0
cameraActive = false
situation = {}
situation.type = "ALIVE"
situation.dragging = false
situation.grabber = 0
situation.grabbing = 0
stance = {}
stance.type = "STANDING"
stance.laying = false
myPlayer = {}
myPlayer.blood = 100.0
myPlayer.bleedRate = 0.0
myPlayer.heart = true
myPlayer.adrenaline = 0
myPlayer.morphineDose = 0
myPlayer.cpr = false
myPlayer.resurrect = false

-- Local Unit variables
local uniqueID = 0
local uniqueID2 = 0

AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent("playerLoaded", GetPlayerName(PlayerId()))
end)

RegisterNetEvent("updateFuel")
AddEventHandler('updateFuel', function(level)
	totalFuelLevel = level
end)

RegisterNetEvent("addReport")
AddEventHandler('addReport', function(job, posX, posY, posZ, text, area, ID)
	if onDuty ~= 0 then
		local reportID = tonumber(ID)
		if onDuty <= 4 then
			if job == 'ems' then
				ShowNotification("~r~New Medical Report")
				ShowNotification("~r~Area: " .. area)
				emergencyCalls[reportID] = {}
				emergencyCalls[reportID]['posX'] = posX
				emergencyCalls[reportID]['posY'] = posY
				emergencyCalls[reportID]['posZ'] = posZ
				emergencyCalls[reportID]['text'] = text
				emergencyCalls[reportID]['area'] = area
				emergencyCalls[reportID]['type'] = "MEDICAL"
				if tonumber(newTime.m) < 10 then
					emergencyCalls[reportID]['time'] = "" .. newTime.h .. ":0" .. newTime.m
				else
					emergencyCalls[reportID]['time'] = "" .. newTime.h .. ":" .. newTime.m
				end
				TriggerServerEvent('InteractSound_SV:PlayOnSource', "Dispatch/RESIDENT/DISPATCH_INTRO_01", 0.5)
			elseif job == 'police' then
				emergencyCalls[reportID] = {}
				if text == "CODE 99: OFFICER IN DANGER" then
					ShowNotification("~r~CODE 99")
					emergencyCalls[reportID]['type'] = "CODE 99"
				elseif text == "Officer requesting additional unit." then
					ShowNotification("~r~Officer Requesting 10-32")
					emergencyCalls[reportID]['type'] = "BACKUP"
				elseif text == "BRINKS: Alarm Activated" then
					ShowNotification("~r~Alarm Activated")
					emergencyCalls[reportID]['type'] = "ALARM"
				elseif text == "Total Power Failure. Prison break in progress." then
					ShowNotification("~r~Prison Breach")
					emergencyCalls[reportID]['type'] = "ALARM"
				else
					ShowNotification("~r~New 911 Report")
					emergencyCalls[reportID]['type'] = "CITIZEN REPORT"
				end
				ShowNotification("~r~Area: " .. area)
				emergencyCalls[reportID]['posX'] = posX
				emergencyCalls[reportID]['posY'] = posY
				emergencyCalls[reportID]['posZ'] = posZ
				emergencyCalls[reportID]['text'] = text
				emergencyCalls[reportID]['area'] = area
				if tonumber(newTime.m) < 10 then
					emergencyCalls[reportID]['time'] = "" .. newTime.h .. ":0" .. newTime.m
				else
					emergencyCalls[reportID]['time'] = "" .. newTime.h .. ":" .. newTime.m
				end
				TriggerServerEvent('InteractSound_SV:PlayOnSource', "Dispatch/RESIDENT/DISPATCH_INTRO_01", 0.5)
			end
		end
	end
end)


	--------------------- UNITS ---------------------
	
RegisterNetEvent("addUnit")
AddEventHandler('addUnit', function(id, name, unitNum, status, loc, types, note)
	if types == "SASP" then
		if getEmptySpot('SASP') ~= nil then
			local spot = getEmptySpot('SASP')
			saspUnits[spot] = {ID = id, Name = name, Unit = unitNum, Status = status, Location = loc, Type = types, Notes = note}
			policeCount = policeCount + 1
		end
	elseif types == "LSPD" then
		if getEmptySpot('LSPD') ~= nil then
			local spot = getEmptySpot('LSPD')
			lspdUnits[spot] = {ID = id, Name = name, Unit = unitNum, Status = status, Location = loc, Type = types, Notes = note}
			policeCount = policeCount + 1
		end
	elseif types == 'EMS' or types == 'FIRE' then
		if getEmptySpot('EMS') ~= nil then
			local spot = getEmptySpot('EMS')
			medicUnits[spot] = {ID = id, Name = name, Unit = unitNum, Status = status, Location = loc, Type = types, Notes = note}
			medicCount = medicCount + 1
		end
	elseif types == 'DOC' then
		if getEmptySpot('DOC') ~= nil then
			local spot = getEmptySpot('DOC')
			docUnits[spot] = {ID = id, Name = name, Unit = unitNum, Status = status, Location = loc, Type = types, Notes = note}
		end
	end
end)

RegisterNetEvent("removeUnitName")
AddEventHandler('removeUnitName', function(name)
	removeUnitByName(name)
end)

RegisterNetEvent("removeUnitID")
AddEventHandler('removeUnitID', function(id)
	removeUnitByID(id)
end)

RegisterNetEvent("updateUnit")
AddEventHandler('updateUnit', function(name, field, info)
	if getSaspSpot(name) ~= nil then
		local spot = getSaspSpot(name)
		if field == 'status' then
			saspUnits[spot].Status = info
		elseif field == 'location' then
			saspUnits[spot].Location = info
		elseif field == 'unitNum' then
			saspUnits[spot].Unit = info
		elseif field == 'notes' then
			saspUnits[spot].Notes = info
		end
	elseif getLspdSpot(name) ~= nil then
		local spot = getLspdSpot(name)
		if field == 'status' then
			lspdUnits[spot].Status = info
		elseif field == 'location' then
			lspdUnits[spot].Location = info
		elseif field == 'unitNum' then
			lspdUnits[spot].Unit = info
		elseif field == 'notes' then
			lspdUnits[spot].Notes = info
		end
	elseif getMedicSpot(name) ~= nil then
		local spot = getMedicSpot(name)
		if field == 'status' then
			medicUnits[spot].Status = info
		elseif field == 'location' then
			medicUnits[spot].Location = info
		elseif field == 'unitNum' then
			medicUnits[spot].Unit = info
		elseif field == 'notes' then
			medicUnits[spot].Notes = info
		end
	elseif getDocSpot(name) ~= nil then
		local spot = getDocSpot(name)
		if field == 'status' then
			docUnits[spot].Status = info
		elseif field == 'location' then
			docUnits[spot].Location = info
		elseif field == 'unitNum' then
			docUnits[spot].Unit = info
		elseif field == 'notes' then
			docUnits[spot].Notes = info
		end
	end
end)

function removeUnitByName(name)
	if getSaspSpot(name) ~= nil then
		local spot = getSaspSpot(name)
		saspUnits[spot] = nil
		policeCount = policeCount - 1
	elseif getLspdSpot(name) ~= nil then
		local spot = getLspdSpot(name)
		lspdUnits[spot] = nil
		policeCount = policeCount - 1
	elseif getMedicSpot(name) ~= nil then
		local spot = getMedicSpot(name)
		medicUnits[spot] = nil
		medicCount = medicCount - 1
	elseif getDocSpot(name) ~= nil then
		local spot = getDocSpot(name)
		docUnits[spot] = nil
	end
end

function removeUnitByID(id)
	for i=1, 10 do
		if saspUnits[i] ~= nil then
			if saspUnits[i].ID == id then
				saspUnits[i] = nil
				policeCount = policeCount - 1
			end
		end
	end
	for i=1, 10 do
		if lspdUnits[i] ~= nil then
			if lspdUnits[i].ID == id then
				lspdUnits[i] = nil
				policeCount = policeCount - 1
			end
		end
	end
	for i=1, 7 do
		if medicUnits[i] ~= nil then
			if medicUnits[i].ID == id then
				medicUnits[i] = nil
				medicCount = medicCount - 1
			end
		end
	end
	for i=1, 5 do
		if docUnits[i] ~= nil then
			if docUnits[i].ID == id then
				docUnits[i] = nil
			end
		end
	end
end

function getSaspSpot(name)
	for i=1, 10 do
		if saspUnits[i] ~= nil then
			if saspUnits[i].Name == name then
				return i
			end
		end
	end
	return nil
end

function getLspdSpot(name)
	for i=1, 10 do
		if lspdUnits[i] ~= nil then
			if lspdUnits[i].Name == name then
				return i
			end
		end
	end
	return nil
end

function getMedicSpot(name)
	for i=1, 7 do
		if medicUnits[i] ~= nil then
			if medicUnits[i].Name == name then
				return i
			end
		end
	end
	return nil
end

function getDocSpot(name)
	for i=1, 5 do
		if docUnits[i] ~= nil then
			if docUnits[i].Name == name then
				return i
			end
		end
	end
	return nil
end

function getEmptySpot(job)
	if job == 'SASP' then
		for i=1, 10 do
			if saspUnits[i] == nil then
				return i
			end
		end
		return nil
	elseif job == 'LSPD' then
		for i=1, 10 do
			if lspdUnits[i] == nil then
				return i
			end
		end
		return nil
	elseif job == 'EMS' then
		for i=1, 7 do
			if medicUnits[i] == nil then
				return i
			end
		end
		return nil
	elseif job == 'DOC' then
		for i=1, 5 do
			if docUnits[i] == nil then
				return i
			end
		end
		return nil
	end
end


	--------------------- INVENTORY ---------------------
RegisterNetEvent("UpdateInventory")
AddEventHandler('UpdateInventory', function(item, item2, item3)
	local slot = item
	local name = tostring(item2)
	local amount = tonumber(item3)
	
	if slot ~= "emptyAll" then
		if slot == 'SLOT1' then
			invItem.slot1 = name
			invAmount.slot1 = amount
		elseif slot == 'SLOT2' then
			invItem.slot2 = name
			invAmount.slot2 = amount
		elseif slot == 'SLOT3' then
			invItem.slot3 = name
			invAmount.slot3 = amount
		elseif slot == 'SLOT4' then
			invItem.slot4 = name
			invAmount.slot4 = amount
		elseif slot == 'SLOT5' then
			invItem.slot5 = name
			invAmount.slot5 = amount
		elseif slot == 'SLOT6' then
			invItem.slot6 = name
			invAmount.slot6 = amount
		elseif slot == 'SLOT7' then
			invItem.slot7 = name
			invAmount.slot7 = amount
		elseif slot == 'SLOT8' then
			invItem.slot8 = name
			invAmount.slot8 = amount
		elseif slot == 'SLOT9' then
			invItem.slot9 = name
			invAmount.slot9 = amount
		elseif slot == 'SLOT10' then
			invItem.slot10 = name
			invAmount.slot10 = amount
		end
	else
		invItem.slot1 = 'Empty'
		invAmount.slot1 = 0
		invItem.slot2 = 'Empty'
		invAmount.slot2 = 0
		invItem.slot3 = 'Empty'
		invAmount.slot3 = 0
		invItem.slot4 = 'Empty'
		invAmount.slot4 = 0
		invItem.slot5 = 'Empty'
		invAmount.slot5 = 0
		invItem.slot6 = 'Empty'
		invAmount.slot6 = 0
		invItem.slot7 = 'Empty'
		invAmount.slot7 = 0
		invItem.slot8 = 'Empty'
		invAmount.slot8 = 0
		invItem.slot9 = 'Empty'
		invAmount.slot9 = 0
		invItem.slot10 = 'Empty'
		invAmount.slot10 = 0
	end
	sortInventory()
end)

function hasItem(item)
	if invItem.slot1 == item then
		return true
	elseif invItem.slot2 == item then
		return true
	elseif invItem.slot3 == item then
		return true
	elseif invItem.slot4 == item then
		return true
	elseif invItem.slot5 == item then
		return true
	elseif invItem.slot6 == item then
		return true
	elseif invItem.slot7 == item then
		return true
	elseif invItem.slot8 == item then
		return true
	elseif invItem.slot9 == item then
		return true
	elseif invItem.slot10 == item then
		return true
	else
		return false
	end
end

function hasSpace(item)
	local space = false
	if invItem.slot1 == 'Empty' or invItem.slot1 == item then
		space = true
	elseif invItem.slot2 == 'Empty' or invItem.slot2 == item then
		space = true 
	elseif invItem.slot3 == 'Empty' or invItem.slot3 == item then
		space = true 
	elseif invItem.slot4 == 'Empty' or invItem.slot4 == item then
		space = true 
	elseif invItem.slot5 == 'Empty' or invItem.slot5 == item then
		space = true 
	elseif invItem.slot6 == 'Empty' or invItem.slot6 == item then
		space = true 
	elseif invItem.slot7 == 'Empty' or invItem.slot7 == item then
		space = true 
	elseif invItem.slot8 == 'Empty' or invItem.slot8 == item then
		space = true 
	elseif invItem.slot9 == 'Empty' or invItem.slot9 == item then
		space = true 
	elseif invItem.slot10 == 'Empty' or invItem.slot10 == item then
		space = true 
	end
	return space
end

RegisterNetEvent("UpdateRpName")
AddEventHandler('UpdateRpName', function(name)
	playerRPname = name
end)

RegisterNetEvent("UpdateMoney")
AddEventHandler('UpdateMoney', function(item, amount)
	if item == 'account' then
		moneyBank = tonumber(amount)
	elseif item == 'cash' then
		moneyCash = tonumber(amount)
	end
end)

RegisterNetEvent("UpdateHeistCooldown")
AddEventHandler('UpdateHeistCooldown', function(level, cool, involve)
	if level == 'high' then
		heistCooldown.high = cool
	elseif level == 'mid' then
		heistCooldown.mid = cool
	elseif level == 'low' then
		heistCooldown.low = cool
	elseif level == 'prison' then
		heistCooldown.prisonCool = cool
		heistCooldown.prisonStatus = involve
	else
		storeCooldown[level] = cool
	end
	if involve ~= nil and level ~= 'prison' then
		heistCooldown.involved = involve
	end
end)

RegisterNetEvent("client:spawnObject")
AddEventHandler("client:spawnObject", function(obj, x, y, z, yaw, alpha)
	Citizen.CreateThread(function()
		local objectID = GetHashKey(obj)
		RequestModel(objectID)
		while not HasModelLoaded(objectID) do
			Citizen.Wait(0)
		end

		local playerCoords = GetEntityCoords(GetPlayerPed(-1))
        playerCoords = playerCoords + vector3(0, 2, 0)

		object = CreateObject(objectID, x, y, z, true, true, true)
		while DoesEntityExist(object) ~= true do
			Citizen.Wait(0)
		end
		if alpha == 0 then SetEntityVisible(object, false, 0) end
		SetEntityRotation(object, 0.0, 0.0, -20.0, 1, true)
	end)
end)

function sortInventory()
	if invItem.slot1 == 'Empty' then
		if invItem.slot2 ~= 'Empty' then
			invItem.slot1 = invItem.slot2
			invAmount.slot1 = invAmount.slot2
			invItem.slot2 = 'Empty'
			invAmount.slot2 = 0
		end
	end
	if invItem.slot2 == 'Empty' then
		if invItem.slot3 ~= 'Empty' then
			invItem.slot2 = invItem.slot3
			invAmount.slot2 = invAmount.slot3
			invItem.slot3 = 'Empty'
			invAmount.slot3 = 0
		end
	end
	if invItem.slot3 == 'Empty' then
		if invItem.slot4 ~= 'Empty' then
			invItem.slot3 = invItem.slot4
			invAmount.slot3 = invAmount.slot4
			invItem.slot4 = 'Empty'
			invAmount.slot4 = 0
		end
	end
	if invItem.slot4 == 'Empty' then
		if invItem.slot5 ~= 'Empty' then
			invItem.slot4 = invItem.slot5
			invAmount.slot4 = invAmount.slot5
			invItem.slot5 = 'Empty'
			invAmount.slot5 = 0
		end
	end
	if invItem.slot5 == 'Empty' then
		if invItem.slot6 ~= 'Empty' then
			invItem.slot5 = invItem.slot6
			invAmount.slot5 = invAmount.slot6
			invItem.slot6 = 'Empty'
			invAmount.slot6 = 0
		end
	end
	if invItem.slot6 == 'Empty' then
		if invItem.slot7 ~= 'Empty' then
			invItem.slot6 = invItem.slot7
			invAmount.slot6 = invAmount.slot7
			invItem.slot7 = 'Empty'
			invAmount.slot7 = 0
		end
	end
	if invItem.slot7 == 'Empty' then
		if invItem.slot8 ~= 'Empty' then
			invItem.slot7 = invItem.slot8
			invAmount.slot7 = invAmount.slot8
			invItem.slot8 = 'Empty'
			invAmount.slot8 = 0
		end
	end
	if invItem.slot8 == 'Empty' then
		if invItem.slot9 ~= 'Empty' then
			invItem.slot8 = invItem.slot9
			invAmount.slot8 = invAmount.slot9
			invItem.slot9 = 'Empty'
			invAmount.slot9 = 0
		end
	end
	if invItem.slot9 == 'Empty' then
		if invItem.slot10 ~= 'Empty' then
			invItem.slot9 = invItem.slot10
			invAmount.slot9 = invAmount.slot10
			invItem.slot10 = 'Empty'
			invAmount.slot10 = 0
		end
	end
end
