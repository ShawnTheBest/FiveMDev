--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local emergencyVehicles = {'STATE1', 'STATE2', 'STATE3', 'STATE4', 'STATE5', 'STATE6', 'STATE7', 'STATE8', 'LSPD1', 'LSPD2', 'LSPD3', 'LSPD4', 'LSPD5', 'LSPD6', 'LSPD7', 'LSPD8', 'RIOT', 'PBUS', 'LSPDHELI', 'FIRETRUK', 'FIRETRUK2', 'EMS1', 'AMBULANCE', 'POLMAV', 'MEDMAV', 'DEFENDER', 'STATEHUEY', 'STATEBIKE', 'TOW', 'ASUV', 'DET1', 'DET2', 'DET3', 'DET4', 'DOC1', 'DOC2', 'DOCVAN', 'DOJ1'}
local defaultHelp = "Use /copcom"


	----- GENERAL COMMANDS -----
commands["DUTY"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["SPAWN"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["EC"] = {perm = 0, help = defaultHelp, args = {"nil"}}

	----- LAW ENFORCEMENT COMMANDS -----
commands["JAIL"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["RAPPEL"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["CONFISCATE"] = {perm = 0, help = "/confiscate [ID]", args = {"nil"}}
commands["REVOKE"] = {perm = 0, help = "/revoke [LIST, LICENSE] [ID]", args = {"LIST", "CAR", "TRUCK", "HANDGUN", "RIFLE"}}
commands["SPIKE"] = {perm = 0, help = "/spike [SET, REMOVE, REMOVEALL]", args = {"SET", "REMOVE", "REMOVEALL"}}
commands["K9"] = {perm = 0, help = "/k9 [SPAWN, REMOVE, HEAL]", args = {"SPAWN", "REMOVE", "HEAL", "ATTACK"}}
commands["GSR"] = {perm = 0, help = "/gsr [ID]", args = {"nil"}}
commands["PLATE"] = {perm = 0, help = "/plate [PLATE]", args = {"nil"}}
commands["CPR"] = {perm = 0, help = "/cpr [ID]", args = {"nil"}}

	----- EMERGENCY SERVICE COMMANDS -----
commands["REVIVESELF"] = {perm = 0, help = "/reviveself", args = {"nil"}}
commands["EXAMINE"] = {perm = 0, help = "/examine [ID]", args = {"nil"}}
commands["INJURIES"] = {perm = 0, help = "/injuries [ID]", args = {"nil"}}
commands["BLOOD"] = {perm = 0, help = "/blood [ID]", args = {"nil"}}
commands["DOSE"] = {perm = 0, help = "/dose [ID]", args = {"nil"}}

commands["TRANSFUSE"] = {perm = 0, help = "/transfuse [ID]", args = {"nil"}}
commands["DEFIB"] = {perm = 0, help = "/defib [ID]", args = {"nil"}}
commands["DEAD"] = {perm = 0, help = "/dead [ID]", args = {"nil"}}

	----- DEPRECIATED COMMANDS -----
commands["CUFF"] = {perm = 0, help = "/cuff [ID]", args = {"nil"}}
commands["UNSEAT"] = {perm = 0, help = "/unseat [ID]", args = {"nil"}}
commands["SEAT"] = {perm = 0, help = "/seat [ID]", args = {"nil"}}
commands["TICKET"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["SEARCH"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["GRAB"] = {perm = 0, help = defaultHelp, args = {"nil"}}






	--------------- GENERAL COMMANDS ---------------


RegisterServerEvent('FiveLife:Command-SPAWN')
AddEventHandler('FiveLife:Command-SPAWN', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 or jobID == 4 or jobID == 5 then
		if args[1] ~= nil then
			local vehicle = args[1]
			for i=1, #emergencyVehicles do
				if vehicle == emergencyVehicles[i] then
					TriggerClientEvent("spawnEmergencyVehicle", sender, vehicle)
				end
			end
 		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid vehicle!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-EC')
AddEventHandler('FiveLife:Command-EC', function(sender, args)
	local steamID = GetPlayerIdentifiers(sender)[1]
	local jobID = tonumber(Users[steamID].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 or jobID == 4 or jobID == 5 then
		if args[1] ~= nil then
			local message = table.concat(args, " ")
			TriggerClientEvent("emergencyChat", -1, Users[steamID].rp_name, message)
		end
	end
end)



	--------------- LAW ENFORCEMENT COMMANDS ---------------

RegisterServerEvent('FiveLife:Command-JAIL')
AddEventHandler('FiveLife:Command-JAIL', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			if GetPlayerName(args[1]) ~= nil then
				--if sender == tonumber(args[1]) then
				--	TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1You can't jail yourself!")
				if args[2] ~= nil then
					local jailTime = tonumber(args[2])
					local steamID = GetPlayerIdentifiers(args[1])[1]
					TriggerClientEvent("jailPlayer", args[1], jailTime)
					TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, GetPlayerName(args[1]) .. " has been jailed for " .. jailTime .. " minutes.")
					jailedPlayers[jailedPlayerCount] = {}
					jailedPlayers[jailedPlayerCount]['ID'] = tonumber(args[1])
					jailedPlayers[jailedPlayerCount]['Steam'] = steamID
					jailedPlayers[jailedPlayerCount]['Time'] = jailTime
					jailedPlayerCount = jailedPlayerCount + 1
				else
					TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid jail time!")
				end
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-CONFISCATE')
AddEventHandler('FiveLife:Command-CONFISCATE', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			if GetPlayerName(args[1]) ~= nil then
				TriggerEvent("removeIllegalItems", args[1])
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-REVOKE')
AddEventHandler('FiveLife:Command-REVOKE', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			if args[1] == "LIST" then
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1/revoke [CAR, TRUCK, HANDGUN, RIFLE] [ID]")
			else
				local license = args[1]
				if args[2] ~= nil then
					local player = args[2]
					if GetPlayerName(player) ~= nil then
						TriggerEvent("revokeLicense", player, license)
					else
						TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
					end
				else
					TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
				end
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid license! Try ^3/revoke LIST")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-SPIKE')
AddEventHandler('FiveLife:Command-SPIKE', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] == "SET" then
			TriggerClientEvent("setSpikes", sender)
		elseif args[1] == "REMOVE" then
			TriggerClientEvent("removeSpikes", sender, 1)
		elseif args[1] == "REMOVEALL" then
			TriggerClientEvent("removeSpikes", sender, "ALL")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-K9')
AddEventHandler('FiveLife:Command-K9', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 3 then
		if args[1] == "SPAWN" then
			TriggerClientEvent("K9:Spawn", sender)
		elseif args[1] == "REMOVE" then
			TriggerClientEvent("K9:Remove", sender)
		elseif args[1] == "HEAL" then
			TriggerClientEvent("K9:Heal", sender)
		elseif args[1] == "ATTACK" then
			if GetPlayerName(args[2]) ~= nil then
				TriggerClientEvent("K9:Attack", "PLAYER", tonumber(args[2]))
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		end
	end
end)

RegisterServerEvent('FiveLife:Command-GSR')
AddEventHandler('FiveLife:Command-GSR', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			local player = tonumber(args[1])
			if GetPlayerName(player) ~= nil then
				TriggerClientEvent("FL:CheckGSR", player, sender)
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-CPR')
AddEventHandler('FiveLife:Command-CPR', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 or jobID == 4 then
		if args[1] ~= nil then
			local player = tonumber(args[1])
			if GetPlayerName(player) ~= nil then
				TriggerClientEvent("FL:CprPlayer", sender, player)
				logAction(GetPlayerName(player) .. " was given CPR by " .. GetPlayerName(sender), 0)
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:CprPlayer')
AddEventHandler('FiveLife:CprPlayer', function(target)
	TriggerClientEvent("FL:CprMe", target)
end)

RegisterServerEvent('FiveLife:CprSuccess')
AddEventHandler('FiveLife:CprSuccess', function(target)
	TriggerClientEvent("FL:CprSuccess", target)
end)

RegisterServerEvent('FiveLife:Command-PLATE')
AddEventHandler('FiveLife:Command-PLATE', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			local plate = string.upper(args[1])
			local plateSub = plate:sub(1,1)
			if plateSub == 'P' or plateSub == 'G' or plateSub == 'E' then
				MySQL.Async.fetchScalar("SELECT COUNT(*) FROM garage where plate = @plate", {['@plate'] = plate}, function(result)
					local count = tonumber(result)
					if count > 0 then
						MySQL.Async.fetchScalar("SELECT identifier FROM garage WHERE plate = @plate", {['@plate'] = plate}, function(playerID)
							MySQL.Async.fetchScalar("SELECT rp_name FROM users WHERE identifier = @playerID", {['@playerID'] = playerID}, function(result2)
								if result2 ~= nil then
									TriggerClientEvent("FL:ReturnNotification", sender, "~b~Owner: ~w~" .. result2)
								else
									TriggerClientEvent("FL:ReturnNotification", sender, "~b~Plate: ~r~No records")
								end
							end)
						end)
					else
						TriggerClientEvent("FL:ReturnNotification", sender, "~b~Plate: ~r~No records")
					end
				end)
			else
				if stolenPlates[plate] ~= nil then
					local difference = stolenPlates[plate] - (GetGameTimer()/1000)
					if difference > 10 then
						TriggerClientEvent("FL:ReturnNotification", sender, "~b~Plate: ~r~Reported Stolen (" .. (stolenPlates[plate]-10) .. " mins ago)")
					else
						TriggerClientEvent("FL:ReturnNotification", sender, "~b~Plate: ~y~Unregistered Driver")
					end
				else
					TriggerClientEvent("FL:ReturnNotification", sender, "~b~Plate: ~w~Clean")
				end
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1/plate [PlateNumber]")
		end
	end
end)


	--------------- EMERGENCY SERVICE COMMANDS ---------------

RegisterServerEvent('FiveLife:Command-REVIVESELF')
AddEventHandler('FiveLife:Command-REVIVESELF', function(sender, args)
	if jobID == 4 then
		TriggerClientEvent("revivePlayer", sender)
	end
end)


RegisterServerEvent('FiveLife:Command-EXAMINE')
AddEventHandler('FiveLife:Command-EXAMINE', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 or jobID == 4 then
		if args[1] ~= nil then
			local player = tonumber(args[1])
			if GetPlayerName(player) ~= nil then
				TriggerClientEvent("FL:Examine", player, sender)
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-INJURIES')
AddEventHandler('FiveLife:Command-INJURIES', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 or jobID == 4 then
		if args[1] ~= nil then
			local player = tonumber(args[1])
			if GetPlayerName(player) ~= nil then
				TriggerClientEvent("FL:CheckInjuries", player, sender)
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-BLOOD')
AddEventHandler('FiveLife:Command-BLOOD', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 or jobID == 4 then
		if args[1] ~= nil then
			local player = tonumber(args[1])
			if GetPlayerName(player) ~= nil then
				TriggerClientEvent("FL:CheckBlood", player, sender)
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-DOSE')
AddEventHandler('FiveLife:Command-DOSE', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 4 then
		if args[1] ~= nil then
			local player = tonumber(args[1])
			if GetPlayerName(player) ~= nil then
				TriggerClientEvent("FL:CheckDose", player, sender)
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-TRANSFUSE')
AddEventHandler('FiveLife:Command-TRANSFUSE', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 4 then
		if args[1] ~= nil then
			local player = tonumber(args[1])
			if GetPlayerName(player) ~= nil then
				TriggerClientEvent("FL:TransfusePlayer", sender, player)
				logAction(GetPlayerName(player) .. " was given a blood transfusion by " .. GetPlayerName(sender), 0)
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:TransfusePlayer')
AddEventHandler('FiveLife:TransfusePlayer', function(target)
	TriggerClientEvent("FL:TransfuseMe", target)
end)

RegisterServerEvent('FiveLife:Command-DEFIB')
AddEventHandler('FiveLife:Command-DEFIB', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 4 then
		if args[1] ~= nil then
			local player = tonumber(args[1])
			if GetPlayerName(player) ~= nil then
				TriggerClientEvent("FL:DefibPlayer", sender, player)
				logAction(GetPlayerName(player) .. " was Defibrillated by " .. GetPlayerName(sender), 0)
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:DefibSuccess')
AddEventHandler('FiveLife:DefibSuccess', function(target)
	TriggerClientEvent("FL:DefibSuccess", target)
end)

RegisterServerEvent('FiveLife:Command-DEAD')
AddEventHandler('FiveLife:Command-DEAD', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 4 then
		if args[1] ~= nil then
			local player = tonumber(args[1])
			if GetPlayerName(player) ~= nil then
				TriggerClientEvent("FL:PronounceDead", player)
				logAction(GetPlayerName(player) .. " was pronounced dead by " .. GetPlayerName(sender), 0)
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)





	--------------- DEPRECIATED COMMANDS ---------------
RegisterServerEvent('FiveLife:Command-CUFF')
AddEventHandler('FiveLife:Command-CUFF', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			if GetPlayerName(args[1]) ~= nil then
				TriggerClientEvent("LE:CuffMe", args[1], sender)
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-UNSEAT')
AddEventHandler('FiveLife:Command-UNSEAT', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 or jobID == 4 then
		if args[1] ~= nil then
			if GetPlayerName(args[1]) ~= nil then
				TriggerClientEvent("unseatPlayer", args[1])
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-SEAT')
AddEventHandler('FiveLife:Command-SEAT', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 or jobID == 4 then
		if args[1] ~= nil then
			if GetPlayerName(args[1]) ~= nil then
				TriggerClientEvent("forceEnter", args[1])
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-TICKET')
AddEventHandler('FiveLife:Command-TICKET', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			if GetPlayerName(args[1]) ~= nil then
				if args[2] ~= nil then
					local amount = tonumber(args[2])
					if amount > 0 and amount < 1500 then
						TriggerEvent("ticketPlayer", args[1], amount)
						TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^3" .. GetPlayerName(args[1]) .. " has been ticketed for $" .. amount)
					else
						TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid ticket amount!")
					end
				else
					TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid ticket amount!")
				end
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-SEARCH')
AddEventHandler('FiveLife:Command-SEARCH', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			if GetPlayerName(args[1]) ~= nil then
				TriggerEvent("searchPlayer", sender, args[1])
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)

RegisterServerEvent('FiveLife:Command-GRAB')
AddEventHandler('FiveLife:Command-GRAB', function(sender, args)
	local jobID = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if jobID == 1 or jobID == 2 or jobID == 3 then
		if args[1] ~= nil then
			if GetPlayerName(args[1]) ~= nil then
				if GetPlayerName(args[1]) == GetPlayerName(sender) then
					TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1You can't grab yourself!")
				else
					TriggerEvent("grabPlayer", args[1], sender)
				end
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	end
end)
