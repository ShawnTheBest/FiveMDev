--[[ ====================================================================================================================================
	
													Copyright © 2017 GTAV-LIFE (Adam Masson)											
													This file is part of project GTAV-Life.													
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 		
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

emergencyReports = 1
newsRequests = 1
taxiRequests = 1
towRequests = 1
unitNum = 0
unitNum2 = 0

RegisterServerEvent('Prison:ActivateAlarm')
AddEventHandler('Prison:ActivateAlarm', function()
	Citizen.CreateThread(function()
		for i=1, 20 do
			Citizen.Wait(5000)
			TriggerEvent('InteractSound_SV:PlayAtCoord', 1690.85, 2533.88, 61.378, 450, "Alarms/ALARM_PRISON")
		end
	end)
end)

RegisterServerEvent('Prison:BreakOut')
AddEventHandler('Prison:BreakOut', function()
	for i=1, jailedPlayerCount do
		if jailedPlayers[i] ~= nil then
			if jailedPlayers[i]['ID'] ~= nil then
				if jailedPlayers[i]['ID'] == tonumber(source) then
					TriggerClientEvent("updateJailTime", source, "OUT")
					jailedPlayers[i] = nil
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		for i=1, jailedPlayerCount do
			if jailedPlayers[i] ~= nil then
				if jailedPlayers[i]['Time'] ~= nil then
					jailedPlayers[i]['Time'] = jailedPlayers[i]['Time'] - 1
					if GetPlayerName(jailedPlayers[i]['ID']) ~= nil then
						TriggerClientEvent("updateJailTime", jailedPlayers[i]['ID'], jailedPlayers[i]['Time'])
					end
					if jailedPlayers[i]['Time'] == 0 then
						jailedPlayers[i] = nil
					end
				end
			end
		end
		if heistCool.high then
			highMinutes = highMinutes - 1
			if highMinutes < 0 then
				TriggerClientEvent("UpdateHeistCooldown", -1, 'high', false, false)
				heistCool.high = false
				highMinutes = 60
			end
		end
		if heistCool.mid then
			midMinutes = midMinutes - 1
			if midMinutes < 0 then
				TriggerClientEvent("UpdateHeistCooldown", -1, 'mid', false, false)
				heistCool.mid = false
				midMinutes = 30
			end
		end
		if prisonBreak.cool then
			midMinutes = midMinutes - 1
			if midMinutes < 0 then
				TriggerClientEvent("UpdateHeistCooldown", -1, 'prison', false, 'locked')
				prisonBreak.cool = false
				midMinutes = 30
			end
		end
		if prisonBreak.status == 'open' then
			prisonMinutes = prisonMinutes - 1
			if prisonMinutes < 0 then
				TriggerClientEvent("UpdateHeistCooldown", -1, 'prison', prisonBreak.cool, 'closed')
				prisonBreak.status = false
				prisonMinutes = 2
			end
		end
		for i=1, 14 do 
			if storeCool[i] ~= 0 then
				storeCool[i] = storeCool[i] - 1
				if storeCool[i] < 1 then
					TriggerClientEvent("UpdateHeistCooldown", -1, i, false, false)
					storeCool[i] = 0
				end
			end
		end
		
		upTime.minute = upTime.minute + 1
		if upTime.minute == 60 then
			upTime.hour = upTime.hour + 1
			upTime.minute = 0
		end
	end
end)


RegisterServerEvent('K9:EnterVehicle')
AddEventHandler('K9:EnterVehicle', function(vehicle)
	TriggerClientEvent("K9:EnterVehicle", source, vehicle)
end)

RegisterServerEvent('K9:ExitVehicle')
AddEventHandler('K9:ExitVehicle', function(speed)
	TriggerClientEvent("K9:ExitVehicle", source, speed)
end)

RegisterServerEvent('K9:Attack')
AddEventHandler('K9:Attack', function(types, ped)
	TriggerClientEvent("K9:Attack", source, types, ped)
end)

RegisterServerEvent('K9:SearchVehicle')
AddEventHandler('K9:SearchVehicle', function(vehicle)
	TriggerClientEvent("K9:SearchVehicle", source, vehicle)
end)

RegisterServerEvent('K9:Follow')
AddEventHandler('K9:Follow', function(toggle)
	TriggerClientEvent("K9:Follow", source, toggle)
end)


RegisterServerEvent('newReport')
AddEventHandler('newReport', function(job, posX, posY, posZ, text, area)
	if job == 'police' or job == 'ems' then
		TriggerClientEvent("addReport", -1, job, posX, posY, posZ, text, area, emergencyReports)
		emergencyReports = emergencyReports+1
	elseif job == 'news' then
		TriggerClientEvent("notifyReports", -1, job, posX, posY, posZ, text, area, newsRequests)
		newsRequests = newsRequests+1
	elseif job == 'taxi' then
		TriggerClientEvent("notifyReports", -1, job, posX, posY, posZ, text, area, taxiRequests)
		taxiRequests = taxiRequests+1
	elseif job == 'tow' then
		TriggerClientEvent("notifyReports", -1, job, posX, posY, posZ, text, area, towRequests)
		towRequests = towRequests+1
	end	
end)

RegisterServerEvent('updateUnitInfo')
AddEventHandler('updateUnitInfo', function(types, info)
	if types == "status" then
		TriggerClientEvent("updateUnit", -1, GetPlayerName(source), 'status', info)
		updateServerUnitInfo(source, 'status', info)
	elseif types == "notes" then
		TriggerClientEvent("updateUnit", -1, GetPlayerName(source), 'notes', info)
		updateServerUnitInfo(source, 'notes', info)
	elseif types == "location" then
		TriggerClientEvent("updateUnit", -1, GetPlayerName(source), 'location', info)
		updateServerUnitInfo(source, 'location', info)
	end	
end)

RegisterServerEvent('interact:search')
AddEventHandler('interact:search', function(playerID)
	TriggerEvent("searchPlayer", source, playerID)
end)

RegisterServerEvent('interact:grab')
AddEventHandler('interact:grab', function(playerID)
	TriggerClientEvent("grabPlayer", playerID, source)
end)

RegisterServerEvent('interact:cuff')
AddEventHandler('interact:cuff', function(playerID)
	TriggerClientEvent("LE:CuffMe", playerID, source)
end)

RegisterServerEvent('interact:seat')
AddEventHandler('interact:seat', function(playerID)
	TriggerClientEvent("forceEnter", playerID)
end)

RegisterServerEvent('interact:unseat')
AddEventHandler('interact:unseat', function(playerID)
	TriggerClientEvent("unseatPlayer", playerID)
end)

RegisterServerEvent('heli:toggleSearchlight')
AddEventHandler('heli:toggleSearchlight', function(searchlight)
	TriggerClientEvent("heli:searchlight", -1, source, searchlight)
end)

RegisterServerEvent('LE:CuffOnGround')
AddEventHandler('LE:CuffOnGround', function(arrestingOfficer)
	TriggerClientEvent("LE:CuffPlayerOnGround", arrestingOfficer, source)
end)

RegisterServerEvent('LE:TooFarForCuff')
AddEventHandler('LE:TooFarForCuff', function(arrestingOfficer)
	TriggerClientEvent("chatMessage", arrestingOfficer, '', {0, 0x99, 255}, "^1Too far to cuff!")
end)

RegisterServerEvent('FiveLife:Command-DUTY')
AddEventHandler('FiveLife:Command-DUTY', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	
	if args[1] ~= nil then 
		if args[1] == 'OFF' and jobID > 0 then
			TriggerClientEvent("onDuty", sender, 'OFF')
			if getSaspUnitSpot(sender) ~= nil then
				local spot = getSaspUnitSpot(sender)
				saUnits[spot] = nil
				TriggerClientEvent("removeUnitName", -1, GetPlayerName(sender))
			elseif getLspdUnitSpot(sender) ~= nil then
				local spot = getLspdUnitSpot(sender)
				lsUnits[spot] = nil
				TriggerClientEvent("removeUnitName", -1, GetPlayerName(sender))
			elseif getMedUnitSpot(sender) ~= nil then
				local spot = getMedUnitSpot(sender)
				medUnits[spot] = nil
				TriggerClientEvent("removeUnitName", -1, GetPlayerName(sender))
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1You are not on duty!")
			end
		else
			if jobID == 1 then
				if getLspdUnitSpot(sender) ~= nil then
					local spot = getLspdUnitSpot(sender)
					lsUnits[spot] = nil
					TriggerClientEvent("removeUnitName", -1, GetPlayerName(sender))
				end
				if getEmptySpot('LSPD') ~= nil then
					local spot = getEmptySpot('LSPD')
					TriggerClientEvent("onDuty", sender, 'LSPD')
					lsUnits[spot] = {ID = tonumber(sender), Name = GetPlayerName(sender), Unit = args[1], Status = "10-8", Location = "Los Santos", Type = "LSPD", Note = "None"}
					TriggerClientEvent("addUnit", -1, lsUnits[spot].ID, lsUnits[spot].Name, lsUnits[spot].Unit, lsUnits[spot].Status, lsUnits[spot].Location, lsUnits[spot].Type, lsUnits[spot].Note)
				else
					TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1All LSPD slots full!")
				end
			elseif jobID == 2 then
				if getDocUnitSpot(sender) ~= nil then
					local spot = getDocUnitSpot(sender)
					docUnits[spot] = nil
					TriggerClientEvent("removeUnitName", -1, GetPlayerName(sender))
				end
				if getEmptySpot('DOC') ~= nil then
					local spot = getEmptySpot('DOC')
					TriggerClientEvent("onDuty", sender, 'DOC')
					docUnits[spot] = {ID = tonumber(sender), Name = GetPlayerName(sender), Unit = args[1], Status = "10-8", Location = "San Andreas", Type = "DOC", Note = "None"}
					TriggerClientEvent("addUnit", -1, docUnits[spot].ID, docUnits[spot].Name, docUnits[spot].Unit, docUnits[spot].Status, docUnits[spot].Location, docUnits[spot].Type, docUnits[spot].Note)
				else
					TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1All DOC slots full!")
				end
			elseif jobID == 3 then
				if getSaspUnitSpot(sender) ~= nil then
					local spot = getSaspUnitSpot(sender)
					saUnits[spot] = nil
					TriggerClientEvent("removeUnitName", -1, GetPlayerName(sender))
				end
				if getEmptySpot('SASP') ~= nil then
					local spot = getEmptySpot('SASP')
					TriggerClientEvent("onDuty", sender, 'SASP')
					saUnits[spot] = {ID = tonumber(sender), Name = GetPlayerName(sender), Unit = args[1], Status = "10-8", Location = "San Andreas", Type = "SASP", Note = "None"}
					TriggerClientEvent("addUnit", -1, saUnits[spot].ID, saUnits[spot].Name, saUnits[spot].Unit, saUnits[spot].Status, saUnits[spot].Location, saUnits[spot].Type, saUnits[spot].Note)
				else
					TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1All SASP slots full!")
				end
			elseif jobID == 4 or jobID == 5 then
				if getMedUnitSpot(sender) ~= nil then
					local spot = getMedUnitSpot(sender)
					medUnits[spot] = nil
					TriggerClientEvent("removeUnitName", -1, GetPlayerName(sender))
				end
				if getEmptySpot('EMS') ~= nil then
					local spot = getEmptySpot('EMS')
					TriggerClientEvent("onDuty", sender, 'EMS')
					medUnits[spot] = {ID = tonumber(sender), Name = GetPlayerName(sender), Unit = args[1], Status = "10-8", Location = "San Andreas", Type = "EMS", Note = "None"}
					TriggerClientEvent("addUnit", -1, medUnits[spot].ID, medUnits[spot].Name, medUnits[spot].Unit, medUnits[spot].Status, medUnits[spot].Location, medUnits[spot].Type, medUnits[spot].Note)
				else
					TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1All EMS slots full!")
				end
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1You do not have a job!")
			end
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Use ^3/duty [UnitNumber] ^1without brackets!")
	end
end)

AddEventHandler('playerDropped', function(r)
	if getSaspUnitSpot(source) ~= nil then
		local spot = getSaspUnitSpot(source)
		TriggerClientEvent("removeUnitName", -1, saUnits[spot].Name)
		saUnits[spot] = nil
	elseif getLspdUnitSpot(source) ~= nil then
		local spot = getLspdUnitSpot(source)
		TriggerClientEvent("removeUnitName", -1, lsUnits[spot].Name)
		lsUnits[spot] = nil
	elseif getMedUnitSpot(source) ~= nil then
		local spot = getMedUnitSpot(source)
		TriggerClientEvent("removeUnitName", -1, medUnits[spot].Name)
		medUnits[spot] = nil
	elseif getDocUnitSpot(source) ~= nil then
		local spot = getDocUnitSpot(source)
		TriggerClientEvent("removeUnitName", -1, docUnits[spot].Name)
		docUnits[spot] = nil
	end
end)

RegisterServerEvent("getAllCurrentUnits")
AddEventHandler('getAllCurrentUnits', function()
	getUnits(source)
end)

function updateServerUnitInfo(sender, types, info)
	if getSaspUnitSpot(sender) ~= nil then
		local spot = getSaspUnitSpot(sender)
		if types == 'status' then
			saUnits[spot].Status = info
		elseif types == 'notes' then
			saUnits[spot].Note = info
		elseif types == 'location' then
			saUnits[spot].Location = info
		end
	elseif getLspdUnitSpot(sender) ~= nil then
		local spot = getLspdUnitSpot(sender)
		if types == 'status' then
			lsUnits[spot].Status = info
		elseif types == 'notes' then
			lsUnits[spot].Note = info
		elseif types == 'location' then
			lsUnits[spot].Location = info
		end
	elseif getMedUnitSpot(sender) ~= nil then
		local spot = getMedUnitSpot(sender)
		if types == 'status' then
			medUnits[spot].Status = info
		elseif types == 'notes' then
			medUnits[spot].Note = info
		elseif types == 'location' then
			medUnits[spot].Location = info
		end
	elseif getDocUnitSpot(sender) ~= nil then
		local spot = getDocUnitSpot(sender)
		if types == 'status' then
			docUnits[spot].Status = info
		elseif types == 'notes' then
			docUnits[spot].Note = info
		elseif types == 'location' then
			docUnits[spot].Location = info
		end
	end
end

function getUnits(player)
	for i=1, 12 do
		if saUnits[i] ~= nil then
			if saUnits[i].Name ~= nil then
				TriggerClientEvent("addUnit", player, saUnits[i].ID, saUnits[i].Name, saUnits[i].Unit, saUnits[i].Status, saUnits[i].Location, saUnits[i].Type, saUnits[i].Note)
			end
		end
	end
	for i=1, 10 do
		if lsUnits[i] ~= nil then
			if lsUnits[i].Name ~= nil then
				TriggerClientEvent("addUnit", player, lsUnits[i].ID, lsUnits[i].Name, lsUnits[i].Unit, lsUnits[i].Status, lsUnits[i].Location, lsUnits[i].Type, lsUnits[i].Note)
			end
		end
	end
	for i=1, 7 do
		if medUnits[i] ~= nil then
			if medUnits[i].Name ~= nil then
				TriggerClientEvent("addUnit", player, medUnits[i].ID, medUnits[i].Name, medUnits[i].Unit, medUnits[i].Status, medUnits[i].Location, medUnits[i].Type, medUnits[i].Note)
			end
		end
	end
	for i=1, 5 do
		if docUnits[i] ~= nil then
			if docUnits[i].Name ~= nil then
				TriggerClientEvent("addUnit", player, docUnits[i].ID, docUnits[i].Name, docUnits[i].Unit, docUnits[i].Status, docUnits[i].Location, docUnits[i].Type, docUnits[i].Note)
			end
		end
	end
end

function getSaspUnitSpot(serverID)
	for i=1, 12 do
		if saUnits[i] ~= nil then
			if saUnits[i].ID == serverID then
				return i
			end
		end
	end
	return nil
end

function getLspdUnitSpot(serverID)
	for i=1, 10 do
		if lsUnits[i] ~= nil then
			if lsUnits[i].ID == serverID then
				return i
			end
		end
	end
	return nil
end

function getMedUnitSpot(serverID)
	for i=1, 7 do
		if medUnits[i] ~= nil then
			if medUnits[i].ID == serverID then
				return i
			end
		end
	end
	return nil
end

function getDocUnitSpot(serverID)
	for i=1, 5 do
		if docUnits[i] ~= nil then
			if docUnits[i].ID == serverID then
				return i
			end
		end
	end
	return nil
end

function getEmptySpot(job)
	local SaspSlots = 12
	local LspdSlots = 10
	local EmsSlots = 7
	local DocSlots = 5
	
	if trainingServer then
		SaspSlots = 32
		LspdSlots = 32
		EmsSlots = 32
		DocSlots = 32
	end
	
	if job == 'SASP' then
		for i=1, SaspSlots do
			if saUnits[i] == nil then
				return i
			end
		end
		return nil
	elseif job == 'LSPD' then
		for i=1, LspdSlots do
			if lsUnits[i] == nil then
				return i
			end
		end
		return nil
	elseif job == 'EMS' then
		for i=1, EmsSlots do
			if medUnits[i] == nil then
				return i
			end
		end
		return nil
	elseif job == 'DOC' then
		for i=1, DocSlots do
			if docUnits[i] == nil then
				return i
			end
		end
		return nil
	end
end

--[[
OnCmd:register( "ziptie", function( source, args )
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			if GetPlayerName(args[1]) ~= nil then
				TriggerClientEvent("ziptiePlayer", args[1])
			else
				TriggerClientEvent("chatMessage", source, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", source, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

OnCmd:register( "sack", function( source, args )

	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			if GetPlayerName(args[1]) ~= nil then
				TriggerClientEvent("sackPlayer", args[1])
			else
				TriggerClientEvent("chatMessage", source, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", source, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)
]]--


