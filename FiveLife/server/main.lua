--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

trainingServer = false

local weatherTypes = {"CLEAR", "EXTRASUNNY", "CLOUDS", "OVERCAST", "RAIN", "CLEARING", "THUNDER", "SMOG", "FOGGY", "XMAS", "SNOWLIGHT", "BLIZZARD"}
local lowercaseCmds = {"TWEET", "ATWEET", "TEXT", "EC", "ME", "RP", "KICK", "TEMPBAN", "BAN", "ANNOUNCE", "CONSOLE"}
local firstspawn = true
local spawn = 0
upTime = {hour = 0, minute = 0}
serverReady = false
FuelAmount = 150
Users = {}
jailedPlayers = {}
jailedPlayerCount = 1
saUnits = {}
lsUnits = {}
medUnits = {}
docUnits = {}
consoleCommands = {}
commands = {}
tempbanList = {"nil"}
stolenPlates = {}

AddEventHandler('onMySQLReady', function ()
	serverReady = true
end)

AddEventHandler("playerConnecting", function(playerName, setReason)
	if serverReady then
		local steamID = GetPlayerIdentifiers(source)[1]
		local reason = 'none'

		for i=1, #tempbanList do
			if tempbanList[i] == steamID then
				reason = 'TempBanned'
			end
		end

		for i=1, #banList do
			if banList[i] == steamID then
				reason = 'Banned'
			end
		end

		if reason ~= 'none' then
			print("Connection rejected for: " .. playerName .. " (" .. reason .. ")")
			setReason("You are " .. reason .. ". To appeal your ban, go to GTAV-Life.com")
			CancelEvent()
		else
			print("CONNECTING: (" .. steamID .. ")")
		end
	else
		print("Connection rejected for: " .. playerName .. " (Connected too soon)")
		setReason("Server still initializing, please re-join")
		CancelEvent()
	end
end)

RegisterServerEvent("Stance:UpdateHeading")
AddEventHandler("Stance:UpdateHeading", function(heading)
	TriggerClientEvent("Stance:SyncPlayerHeading", -1, source, heading)
end)

RegisterServerEvent("updateStolenTimer")
AddEventHandler("updateStolenTimer", function(plate)
	if stolenPlates[plate] == nil then
		stolenPlates[plate] = (GetGameTimer()/1000)
	end
end)

RegisterServerEvent("removeFromStolen")
AddEventHandler("removeFromStolen", function(plate)
	if stolenPlates[plate] ~= nil then
		stolenPlates[plate] = nil
	end
end)

RegisterServerEvent("ActionLog")
AddEventHandler("ActionLog", function(message, flag)
	if(Users[GetPlayerIdentifiers(source)[1]] ~= nil)then
		logAction(GetPlayerName(source) .. " " .. message, flag)
	end
end)

RegisterServerEvent("Sync:UpdateWeapons")
AddEventHandler("Sync:UpdateWeapons", function()
	LoadWeapons(source)
end)

RegisterServerEvent("server:spawnObject")
AddEventHandler("server:spawnObject", function(obj, x, y, z, yaw, alpha)
	TriggerClientEvent("client:spawnObject", source, obj, x, y, z, yaw, alpha)
end)

RegisterServerEvent("Job:deleteVehicle")
AddEventHandler("Job:deleteVehicle", function(veh)
	TriggerClientEvent('Job:deleteThisVehicle', source, veh)
end)

RegisterServerEvent("finishSpawn")
AddEventHandler("finishSpawn", function(spawnpoint)
	local point = tonumber(spawnpoint)
	TriggerClientEvent("AwesomeInvisible", source, false)
	TriggerClientEvent("AwesomeFreeze", source, false)
	TriggerClientEvent("teleportSpawning", source, point)
end)

RegisterServerEvent("respawnMenu")
AddEventHandler("respawnMenu", function()
	if(Users[GetPlayerIdentifiers(source)[1]] ~= nil)then
		TriggerClientEvent("menu:openMenu", source, 1, 0)
	end
end)

RegisterServerEvent("playerCreationMenu")
AddEventHandler("playerCreationMenu", function()
	if(Users[GetPlayerIdentifiers(source)[1]] ~= nil)then
		TriggerClientEvent("openPLAYERmenu", source)
	end
end)

RegisterServerEvent("updatePlayerDeath")
AddEventHandler("updatePlayerDeath", function(bool)
	local steamID = GetPlayerIdentifiers(source)[1]
	if Users[steamID] ~= nil then
		Users[steamID].dead = bool
	end
end)

RegisterServerEvent("playerLoaded")
AddEventHandler('playerLoaded', function(name)
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	TriggerClientEvent("teleportSpawning", serverID, 5)
	Users[steamID] = {}
	if(Users[steamID] ~= nil)then
		TriggerClientEvent("AwesomeFreeze", serverID, true)
		TriggerClientEvent("AwesomeInvisible", serverID, true)
		MySQL.Async.fetchScalar('SELECT COUNT(1) FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(count)
			if tonumber(count) == 1 then
				print("User has account: " .. name)
				MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
					Users[steamID].username = result[1].username
					Users[steamID].rp_name = result[1].rp_name
					Users[steamID].groupID = result[1].groupID
					Users[steamID].jobID = result[1].jobID
					Users[steamID].serverID = serverID
					Users[steamID].dead = false
				end)
				loginUser(serverID)
			else
				print("User does not have account: " .. name)
				TriggerClientEvent("chatMessage", source, '', {0, 0, 0}, "Use ^1/rp <first last> ^0to set your name. Make sure it is correct!")
			end
		end)
	end
	logAction(name .. " connected. (" .. steamID .. ")", 0)
end)

-- Server Disconnect Player
AddEventHandler('playerDropped', function(reason)
	-- Check if Usersrow is existing -> Deleting Users var at disconnect
	local serverID = source
	local localname = GetPlayerName(serverID)
	local steamID = GetPlayerIdentifiers(serverID)[1]
	print("Player " .. localname .. " disconnected. Reason: " .. reason)
	logAction(localname .. " disconnected. Reason: " .. reason, 0)
	if Users[steamID] ~= nil then
		if Users[steamID].dead == true then
			logAction(localname .. " combat logged, Inventory wiped.", 1)
			print("Player " .. localname .. " combat logged, Wiping..")
			TriggerEvent("takeAllWeapons", serverID)
			TriggerEvent("wipeInventory", serverID)
		end
		Users[steamID] = nil
	end
end)

RegisterServerEvent("baseevents:onPlayerKilled")
AddEventHandler('baseevents:onPlayerKilled', function(killerID, kilerInVeh, deathType)
	if GetPlayerName(killerID) ~= nil then
		local killerSteam = GetPlayerIdentifiers(killerID)[1]
		local killerRpName = Users[killerSteam].rp_name
		local victimSteam = GetPlayerIdentifiers(source)[1]
		local victimRpName = Users[victimSteam].rp_name
		local deathCause = "killed"
		local flag = 0

		if kilerInVeh then
			if deathType == "killed" then
				deathCause = "run over"
				flag = 1
			else
				deathCause = deathType
			end
		else
			deathCause = deathType
		end

		logDeath(victimRpName .. " (" .. GetPlayerName(source) .. ") was " .. deathCause .. " by " .. killerRpName .. " (" .. GetPlayerName(killerID) .. ")", flag)
	end
end)

RegisterServerEvent("baseevents:onPlayerDied")
AddEventHandler('baseevents:onPlayerDied', function(notUsed)
	if GetPlayerName(source) ~= nil then
		local victimSteam = GetPlayerIdentifiers(source)[1]
		local victimRpName = Users[victimSteam].rp_name

		logDeath(victimRpName .. " (" .. GetPlayerName(source) .. ") was fatally injured.", 0)
	end
end)

AddEventHandler('rconCommand', function(commandName, args)
	rconCommandEntered(commandName, args)
end)

AddEventHandler('chatMessage', function(source, color, message)
	local steamID = GetPlayerIdentifiers(source)[1]
	if (Users[steamID].groupID ~= nil) then
		if(string.sub(message, 1, 1) == "/" and string.len(message) >= 2) then
			chatCommandEntered(source, message)
			CancelEvent()
		elseif string.len(message) >= 1 then
			local tag = ""
			local color = {255, 255, 255}
			local adminlevel = tonumber(Users[steamID].groupID)
			if(adminlevel == 0)then
				tag = "USER"
				color = {255, 255, 255}
			elseif(adminlevel == 1)then
				tag = "MOD"
				color = {25, 7, 155}
			elseif(adminlevel == 2)then
				tag = "ADMIN"
				color = {106, 9, 186}
			elseif(adminlevel == 3)then
				tag = "SR-ADMIN"
				color = {224, 204, 24}
			elseif(adminlevel == 4)then
				tag = "HEAD-ADMIN"
				color = {3, 124, 15}
			elseif(adminlevel == 5)then
				tag = "MANAGER"
				color = {226, 177, 27}
			elseif(adminlevel == 6)then
				tag = "LEAD"
				color = {200, 0, 0}
			elseif(adminlevel > 6)then
				tag = "DEV"
				color = {200, 0, 0}
			end

			TriggerClientEvent('chatMessage', -1, "[" .. tag .. "] " .. Users[steamID].rp_name, color, message)
			CancelEvent()
		else
			CancelEvent()
		end
	else
		if string.sub(message, 1, 3) == "/rp" then
			chatCommandEntered(source, message)
		else
			TriggerClientEvent('chatMessage', source, "HELP: ", {200, 0, 0}, "Use ^3/rp First LastName")
		end
		CancelEvent()
	end
end)

function chatCommandEntered(sender, input)
	local fullCommand = string.gsub(input, "/", "")
	local command = stringsplit(fullCommand, " ")
	local upperCase = stringsplit(string.upper(fullCommand), " ")
	local cmd = upperCase[1]
	local goodArgument = false
	local steamID = GetPlayerIdentifiers(sender)[1]
	local adminlevel = 0
	table.remove(command, 1)
	table.remove(upperCase, 1)

	if Users[steamID].groupID ~= nil then
		adminlevel = tonumber(Users[steamID].groupID)
	end

	if commands[cmd] ~= nil then
		local cmdPerm = tonumber(commands[cmd].perm)
		if adminlevel >= cmdPerm then
			if commands[cmd].args[1] ~= "nil" then
				for i=1, #commands[cmd].args do
					if upperCase[1] == commands[cmd].args[i] then
						goodArgument = true
					elseif upperCase[1] == "HELP" then
						TriggerClientEvent('chatMessage', sender, "HELP", {200, 0, 0}, "" .. commands[cmd].help)
					end
				end
			else
				goodArgument = true
			end
			if goodArgument then
				print("Command: " .. cmd .. " called by " .. GetPlayerName(sender) .. ".")
				local canBeUppercase = true
				for i=1, #lowercaseCmds do
					if cmd == lowercaseCmds[i] then
						canBeUppercase = false
					end
				end
				if canBeUppercase then
					TriggerEvent("FiveLife:Command-" .. cmd, sender, upperCase)
				else
					TriggerEvent("FiveLife:Command-" .. cmd, sender, command)
				end
			else
				TriggerClientEvent('chatMessage', sender, "Invalid Parameters", {200, 0, 0}, "" .. commands[cmd].help)
			end
		else
			print(GetPlayerName(sender) .. " tried to use " .. cmd .. " command.")
		end
	else
		TriggerClientEvent('chatMessage', sender, "", {200, 0, 0}, "Invalid command!")
	end
end

function rconCommandEntered(name, args)
	local cmd = string.upper(name)
	if consoleCommands[cmd] ~= nil then
		TriggerEvent("FiveLife:Console-" .. cmd, args)
		CancelEvent()
	end
end



-- =================================== HELPER FUNCTIONS ===================================


function logAction(message, flags)
	file = io.open("logs/ActionLog.txt", "a")
	local flagged = ""
	if flags == 0 then
		flagged = ""
	elseif flags == 1 then
		flagged = "[FLAGGED]"
	elseif flags == 2 then
		flagged = "[Reserved]"
	elseif flags == 3 then
		flagged = "[Reserved]"
	end
	file:write(os.date("[%m/%d %H:%M]") .. " " .. message .. " " .. flagged)
	file:write("\n")
	file:close()
end

function logCommand(message, flags)
	file = io.open("logs/CommandLog.txt", "a")
	local flagged = ""
	if flags == 0 or flags == nil then
		flagged = ""
	elseif flags == 1 then
		flagged = "[FLAGGED]"
	elseif flags == 2 then
		flagged = "[ABUSE]"
	elseif flags == 3 then
		flagged = "[PERMS]"
	end
	file:write(os.date("[%m/%d %H:%M]") .. " " .. message .. " " .. flagged)
	file:write(" \n")
	file:close()
end

function logDeath(message, flags)
	file = io.open("logs/DeathLog.txt", "a")
	local flagged = ""
	if flags == 0 then
		flagged = ""
	elseif flags == 1 then
		flagged = "[FLAG - VDM]"
	elseif flags == 2 then
		flagged = "[Reserved]"
	elseif flags == 3 then
		flagged = "[Reserved]"
	end
	file:write(os.date("[%m/%d %H:%M]") .. " " .. message .. " " .. flagged)
	file:write("\n")
	file:close()
end

function logDebug(message, flags)
	file = io.open("logs/DebugLog.txt", "a")
	local flagged = ""
	if flags == 0 then
		flagged = ""
	elseif flags == 1 then
		flagged = "[MINOR]"
	elseif flags == 2 then
		flagged = "[CRITICAL]"
	elseif flags == 3 then
		flagged = "[Reserved]"
	end
	file:write(os.date("[%m/%d %H:%M]") .. " " .. message .. " " .. flagged)
	file:write("\n")
	file:close()
end

function logTweet(message)
	file = io.open("logs/TweetLog.txt", "a")
	file:write(os.date("[%m/%d %H:%M]") .. " " .. message)
	file:write("\n")
	file:close()
end

function addToBanlist(steamID)
	file = io.open("logs/BanList.txt", "a")
	file:write(", \n")
	file:write("\"" .. steamID .. "\"")
	file:close()
end

RegisterServerEvent("PayCheck:PayMe")
AddEventHandler("PayCheck:PayMe", function(job)
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	MySQL.Async.fetchScalar('SELECT bank FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		if Users[steamID] ~= nil then
			local amount = 20
			local white = Users[steamID].jobID
			local jobName = 'N/A'
			if job == 0 then
				if white ~= 0 then
					amount = 25
					jobName = 'Off Duty'
				else
					amount = 20
					jobName = 'Unemployed'
				end
			elseif job < 4 then
				amount = 150
				jobName = 'Law Enforcement'
			elseif job == 4 or jobType == 5 then
				amount = 135
				jobName = 'Emergency Services'
			else
				amount = 25
				jobName = 'Unemployed'
			end
			TriggerEvent("givePlayerMoney", serverID, amount)
			TriggerClientEvent("notifyPlayer", serverID, "Bank Account: ~g~$" .. (tonumber(result)+amount))
			TriggerClientEvent("notifyPlayer", serverID, "You were paid ~g~$" .. amount .. " ~w~for being " .. jobName .. ".")
		end
	end)
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function SendPlayerChatMessage(source, message, color)
	if(color == nil) then
		color = { 0, 0x99, 255}
	end
	TriggerClientEvent("chatMessage", source, '', color, message)
end

RegisterServerEvent("startEmote")
AddEventHandler("startEmote", function(emote)
	TriggerClientEvent('play' .. emote .. 'Emote', source)
end)
