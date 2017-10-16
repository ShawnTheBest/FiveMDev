--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local defaultHelp = "Use /help"


	----- CONSTRUCT COMMANDS -----
commands["POS"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["RP"] = {perm = 0, help = "/rp First LastName", args = {"nil"}}
commands["DV"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["REVEAL"] = {perm = 0, help = "/reveal [FIRST LASTNAME]", args = {"nil"}}

	----- GENERAL COMMANDS -----
commands["TEXT"] = {perm = 0, help = "/text [ID] [MESSAGE]", args = {"nil"}}
commands["TWEET"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["ATWEET"] = {perm = 0, help = "Anonymous tweeting", args = {"nil"}}
commands["ME"] = {perm = 0, help = "Local action chat", args = {"nil"}}
commands["EMOTE"] = {perm = 0, help = "Use /emotes for list", args = {"COP", "SIT", "CHAIR", "KNEEL", "MEDIC", "NOTEPAD", "TRAFFIC", "PHOTO", "CLIPBOARD", "LEAN", "BLEEZE", "SMOKE", "DRINK", "COFFEE", "FISH", "SUNBATH", "HOOKER", "PUSHUPS", "SITUPS"}}
commands["EMOTES"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["DRAG"] = {perm = 0, help = "/drag [ID]", args = {"nil"}}
commands["TRUNK"] = {perm = 0, help = "/trunk [ID]", args = {"nil"}}
commands["BANDAGE"] = {perm = 0, help = "/bandage [ID]", args = {"nil"}}
commands["PULSE"] = {perm = 0, help = "/pulse [ID]", args = {"nil"}}
commands["INJECT"] = {perm = 0, help = "/inject [MORPHINE, ADRENALINE] [ID]", args = {"MORPHINE", "ADRENALINE"}}
commands["SUICIDE"] = {perm = 0, help = "/suicide", args = {"nil"}}
commands["HIDECHAT"] = {perm = 2, help = "/hidechat", args = {"nil"}}
commands["SHOWCHAT"] = {perm = 2, help = "/showchat", args = {"nil"}}

	----- JOB COMMANDS -----
commands["TOW"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["VIEW"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["GOTO"] = {perm = 0, help = defaultHelp, args = {"nil"}}

	----- MODERATOR COMMANDS -----
commands["KICK"] = {perm = 1, help = "/kick [ID] [REASON]", args = {"nil"}}
commands["TEMPBAN"] = {perm = 1, help = "/tempban [ID] [REASON]", args = {"nil"}}
commands["ANNOUNCE"] = {perm = 1, help = "/announce [MESSAGE]", args = {"nil"}}
commands["SETJOB"] = {perm = 1, help = "/setJob [NONE, LSPD, SASP, EMS, DOC, CIV] [ID]", args = {"NONE", "LSPD", "SASP", "EMS", "FIRE", "DOC", "CIV"}}
commands["MODMODE"] = {perm = 1, help = defaultHelp, args = {"nil"}}
commands["PING"] = {perm = 1, help = "/ping [ID]", args = {"nil"}}

	----- ADMINISTRATOR COMMANDS -----
commands["BAN"] = {perm = 2, help = "/ban [ID] [REASON]", args = {"nil"}}
commands["SETRANK"] = {perm = 2, help = "/setRank [0-7] [ID]", args = {"0", "1", "2", "3", "4", "5", "6", "7"}}
commands["ADMINMODE"] = {perm = 2, help = defaultHelp, args = {"nil"}}
commands["CLEARCHAT"] = {perm = 2, help = "/clearchat", args = {"nil"}}

	----- SENIOR ADMIN COMMANDS -----
commands["GIVE"] = {perm = 3, help = "/give [ITEM] [PLAYER] [AMOUNT]", args = {"MONEY"}}
commands["REMOVE"] = {perm = 3, help = "/remove [ITEM] [PLAYER] [AMOUNT]", args = {"MONEY"}}
commands["WIPE"] = {perm = 4, help = "/wipe [WEAPONS, INVENTORY] [ID]", args = {"WEAPONS", "INVENTORY"}}
commands["UPTIME"] = {perm = 3, help = defaultHelp, args = {"nil"}}
commands["TIMER"] = {perm = 3, help = defaultHelp, args = {"nil"}}

	----- DEVELOPER COMMANDS -----
commands["DEBUG"] = {perm = 7, help = defaultHelp, args = {"nil"}}
commands["DEVMODE"] = {perm = 7, help = defaultHelp, args = {"nil"}}
commands["CONSOLE"] = {perm = 6, help = "/console [MESSAGE]", args = {"nil"}}
commands["TIME"] = {perm = 6, help = "/time [LIST, TIME]", args = {"LIST", "MORNING", "NOON", "EVENING", "NIGHT"}}
commands["NEXTWEATHER"] = {perm = 6, help = "/nextweather [LIST, WEATHER]", args = {"LIST", "CLEAR", "EXTRASUNNY", "CLOUDS", "OVERCAST", "RAIN", "CLEARING", "THUNDER", "SMOG", "FOGGY", "XMAS", "SNOWLIGHT", "BLIZZARD"}}
commands["FORCEWEATHER"] = {perm = 4, help = "/forceweather", args = {"nil"}}
commands["CRASH"] = {perm = 5, help = defaultHelp, args = {"nil"}}
commands["FORCEREVIVE"] = {perm = 7, help = defaultHelp, args = {"nil"}}

	----- HELP COMMANDS -----
commands["HELP"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["CIVCOM"] = {perm = 0, help = defaultHelp, args = {"nil"}}
commands["EMSCOM"] = {perm = 0, help = "/emscom (1 or 2)", args = {"1", "2"}}
commands["COPCOM"] = {perm = 0, help = "/copcom (1 or 2)", args = {"1", "2"}}
commands["MODCOM"] = {perm = 1, help = defaultHelp, args = {"nil"}}
commands["ADMINCOM"] = {perm = 2, help = defaultHelp, args = {"nil"}}




	--------------- CONSTRUCT COMMANDS ---------------

RegisterServerEvent('FiveLife:SendNotification')
AddEventHandler('FiveLife:SendNotification', function(info, target)
	TriggerClientEvent("FL:ReturnNotification", target, info)
end)

RegisterServerEvent('FiveLife:Command-POS')
AddEventHandler('FiveLife:Command-POS', function(sender, args)
	TriggerClientEvent("getPosition", sender)
end)

RegisterServerEvent('FiveLife:Command-RP')
AddEventHandler('FiveLife:Command-RP', function(sender, args)
	if args[1] ~= nil then
		if args[2] ~= nil then
			local steamID = GetPlayerIdentifiers(sender)[1]
			local fullName = args[1] .. " " .. args[2]
			local taken = false

			--fullName = string.gsub(fullName, "^", "")
			for i=0, 9 do
				fullName = string.gsub(fullName, "^" .. i, "")
			end

			registerUser(sender, fullName)
			Users[steamID].rp_name = fullName
			MySQL.Async.execute("UPDATE users SET rp_name=@name WHERE identifier = @steamID", {['@steamID'] = steamID, ['@name'] = fullName}, function(result) end)
			TriggerClientEvent('UpdateRpName', sender, fullName)
			TriggerClientEvent('chatMessage', sender, "", {0, 0x99, 255}, "Name successfully set!")
		else
			TriggerClientEvent('chatMessage', sender, "", {0, 0x99, 255}, "^1Please enter a last name.")
		end
	else
		TriggerClientEvent('chatMessage', sender, "", {0, 0x99, 255}, "^1/rp First LastName")
	end
end)

RegisterServerEvent('FiveLife:Command-DV')
AddEventHandler('FiveLife:Command-DV', function(sender, args)
	local adminlevel = tonumber(Users[GetPlayerIdentifiers(sender)[1]].groupID)
	local joblevel = tonumber(Users[GetPlayerIdentifiers(sender)[1]].jobID)
	if adminlevel > 0 or joblevel > 0 then
		TriggerClientEvent('deleteVehicle', sender)
	end
end)

RegisterServerEvent('FiveLife:Command-REVEAL')
AddEventHandler('FiveLife:Command-REVEAL', function(sender, args)
	if #args >= 2 then
		local fullName = string.upper(args[1] .. " " .. args[2])
		local found = false
		for i=1, 500 do
			if GetPlayerName(i) ~= nil then
				local steamID = GetPlayerIdentifiers(i)[1]
				if steamID ~= nil then
					if Users[steamID] ~= nil then
						if string.upper(Users[steamID].rp_name) == fullName then
							TriggerClientEvent('chatMessage', sender, "", {0, 0x99, 255}, "User: " .. GetPlayerName(i) .. " (" .. i .. ")")
							found = true
						end
					end
				end
			end
		end
		if not found then
			TriggerClientEvent('chatMessage', sender, "", {0, 0x99, 255}, "^1RP Name not found!")
		end
	else
		TriggerClientEvent('chatMessage', sender, "", {0, 0x99, 255}, "^1/reveal First LastName")
	end
end)

RegisterServerEvent('FiveLife:Command-TOW')
AddEventHandler('FiveLife:Command-TOW', function(sender, args)
	TriggerClientEvent('Jobs:Tow', sender)
end)

RegisterServerEvent('FiveLife:Command-VIEW')
AddEventHandler('FiveLife:Command-VIEW', function(sender, args)
	if args[1] ~= nil then
		TriggerClientEvent("viewReport", sender, args[1])
	end
end)

RegisterServerEvent('FiveLife:Command-GOTO')
AddEventHandler('FiveLife:Command-GOTO', function(sender, args)
	if args[1] ~= nil then
		TriggerClientEvent("gotoReport", sender, args[1])
	end
end)



	--------------- GENERAL COMMANDS ---------------

RegisterServerEvent('FiveLife:Command-TEXT')
AddEventHandler('FiveLife:Command-TEXT', function(sender, args)
	if args[1] ~= nil then
		local player = tonumber(table.remove(args, 1))
		if GetPlayerName(player) ~= nil then
			local message = table.concat(args, " ")
			local steamID1 = GetPlayerIdentifiers(sender)[1]
			local steamID2 = GetPlayerIdentifiers(player)[1]
			TriggerClientEvent('chatMessage', sender, "TO", {12, 153, 26}, "^2" .. Users[steamID2].rp_name .. ": " .. message)
			TriggerClientEvent('chatMessage', player, "FROM", {12, 153, 26}, "^2" .. Users[steamID1].rp_name .. " (" .. sender .. "): " .. message)
		else
			TriggerClientEvent('chatMessage', sender, "RP", {255, 0, 0}, "^1Invalid player ID!")
		end
	else
		TriggerClientEvent('chatMessage', sender, "RP", {255, 0, 0}, "^1/text [ID] [MESSAGE]")
	end
end)

RegisterServerEvent('FiveLife:Command-TWEET')
AddEventHandler('FiveLife:Command-TWEET', function(sender, args)
	local message = table.concat(args, " ")
	local steamID = GetPlayerIdentifiers(sender)[1]
	TriggerClientEvent('chatMessage', -1, "[Tweet]", {66, 173, 244}, "^3 " .. Users[steamID].rp_name .. ": " .. message)
end)

RegisterServerEvent('FiveLife:Command-ATWEET')
AddEventHandler('FiveLife:Command-ATWEET', function(sender, args)
	local message = table.concat(args, " ")
	logTweet(GetPlayerName(sender) .. ": " .. message)
	TriggerClientEvent('chatMessage', -1, "[Tweet]", {66, 173, 244}, "^3" .. "ANON: " .. message)
end)

RegisterServerEvent('FiveLife:Command-ME')
AddEventHandler('FiveLife:Command-ME', function(sender, args)
	local message = table.concat(args, " ")
	local steamID = GetPlayerIdentifiers(sender)[1]
	TriggerClientEvent("localMe", -1, sender, "^4" .. Users[steamID].rp_name .. " " .. message)
end)

RegisterServerEvent('FiveLife:Command-EMOTE')
AddEventHandler('FiveLife:Command-EMOTE', function(sender, args)
	TriggerClientEvent('play' .. args[1] .. 'Emote', sender)
end)

RegisterServerEvent('FiveLife:Command-EMOTES')
AddEventHandler('FiveLife:Command-EMOTES', function(sender, args)
	TriggerClientEvent('printEmoteList', sender)
end)

RegisterServerEvent('FiveLife:Command-DRAG')
AddEventHandler('FiveLife:Command-DRAG', function(sender, args)
	if args[1] ~= nil then
		if GetPlayerName(args[1]) ~= nil then
			TriggerClientEvent("FL:DragPlayer", sender, args[1])
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
	end
end)

RegisterServerEvent('FiveLife:StartDragging')
AddEventHandler('FiveLife:StartDragging', function(target)
	TriggerClientEvent("FL:StartDragging", target, source)
end)

RegisterServerEvent('FiveLife:StopDragging')
AddEventHandler('FiveLife:StopDragging', function(target)
	TriggerClientEvent("FL:StopDragging", target, source)
end)

RegisterServerEvent('FiveLife:CancelDrag')
AddEventHandler('FiveLife:CancelDrag', function(target)
	TriggerClientEvent("FL:CancelDrag", target)
end)

RegisterServerEvent('FiveLife:Command-TRUNK')
AddEventHandler('FiveLife:Command-TRUNK', function(sender, args)
	if args[1] ~= nil then
		if GetPlayerName(args[1]) ~= nil then
			TriggerClientEvent("FL:PutIntoTrunk", args[1])
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
	end
end)

RegisterServerEvent('FiveLife:Command-PULSE')
AddEventHandler('FiveLife:Command-PULSE', function(sender, args)
	if args[1] ~= nil then
		if GetPlayerName(args[1]) ~= nil then
			TriggerClientEvent("FL:CheckPulse", args[1], sender)
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
	end
end)

RegisterServerEvent('FiveLife:Command-BANDAGE')
AddEventHandler('FiveLife:Command-BANDAGE', function(sender, args)
	if args[1] ~= nil then
		local player = tonumber(args[1])
		if GetPlayerName(player) ~= nil then
			if player == sender then
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Use bandges in Inventory!")
			else
				TriggerClientEvent("FL:BandagePlayer", sender, player)
				logAction(GetPlayerName(player) .. " was bandaged by " .. GetPlayerName(sender), 0)
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
	end
end)

RegisterServerEvent('FiveLife:BandagePlayer')
AddEventHandler('FiveLife:BandagePlayer', function(target)
	TriggerClientEvent("FL:BandageMe", target)
end)

RegisterServerEvent('FiveLife:Command-INJECT')
AddEventHandler('FiveLife:Command-INJECT', function(sender, args)
	if args[2] ~= nil then
		local player = tonumber(args[2])
		if GetPlayerName(player) ~= nil then
			if args[1] == "MORPHINE" then
				TriggerClientEvent("FL:InjectPlayer", sender, player, args[1])
				logAction(GetPlayerName(player) .. " was injected with Morphine by " .. GetPlayerName(sender), 0)
			elseif args[1] == "ADRENALINE" then
				TriggerClientEvent("FL:InjectPlayer", sender, player, args[1])
				logAction(GetPlayerName(player) .. " was injected with Adrenaline by " .. GetPlayerName(sender), 0)
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
	end
end)

RegisterServerEvent('FiveLife:InjectPlayer')
AddEventHandler('FiveLife:InjectPlayer', function(target, item)
	TriggerClientEvent("FL:InjectMe", target, item)
end)

RegisterServerEvent('FiveLife:Command-SUICIDE')
AddEventHandler('FiveLife:Command-SUICIDE', function(sender, args)
	TriggerClientEvent("FL:SuicideByGun", sender)
end)

RegisterServerEvent('FiveLife:Command-CHAT-HIDE')
AddEventHandler('FiveLife:Command-CHAT-HIDE', function(sender, args)
	TriggerClientEvent("chat:hide", sender)
end)

RegisterServerEvent('FiveLife:Command-CHAT-SHOW')
AddEventHandler('FiveLife:Command-CHAT-SHOW', function(sender, args)
	TriggerClientEvent("chat:show", sender)
end)

	--------------- MODERATOR COMMANDS ---------------
RegisterServerEvent('FiveLife:Command-KICK')
AddEventHandler('FiveLife:Command-KICK', function(sender, args)
	local toKick = table.remove(args, 1)
	local reason = table.concat(args, " ")

	if reason == nil then reason = "You were kicked." end

	if toKick ~= nil then
		if GetPlayerName(toKick) == nil then
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		else
			logCommand(GetPlayerName(sender) .. " kicked " .. GetPlayerName(toKick) .. ". Reason: " .. reason, 0)
			TriggerClientEvent('chatMessage', sender, "SYSTEM", {0, 0x99, 255}, GetPlayerName(toKick) .. " kicked!")
			DropPlayer(tonumber(toKick), reason)
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1/kick [ID] [Reason]")
	end
end)

RegisterServerEvent('FiveLife:Command-TEMPBAN')
AddEventHandler('FiveLife:Command-TEMPBAN', function(sender, args)
	local toBan = tonumber(table.remove(args, 1))
	local reason = table.concat(args, " ")

	if reason == nil then reason = "You were tempbanned. Appeal at GTAV-Life.com" end

	if toBan ~= nil then
		if GetPlayerName(toBan) ~= nil then
			local bannedSteamID = GetPlayerIdentifiers(toBan)[1]
			logCommand(GetPlayerName(sender) .. " tempbanned " .. GetPlayerName(toBan) .. " (" .. bannedSteamID .. "). Reason: " .. reason, 0)
			TriggerClientEvent('chatMessage', sender, "SYSTEM", {200, 0, 0}, GetPlayerName(toBan) .. " tempbanned!")
			table.insert(tempbanList, bannedSteamID)
			DropPlayer(toBan, reason)
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1/tempban [ID] [Reason]")
	end
end)

RegisterServerEvent('FiveLife:Command-ANNOUNCE')
AddEventHandler('FiveLife:Command-ANNOUNCE', function(sender, args)
	local message = table.concat(args, " ")
	if message ~= nil then
		TriggerClientEvent('chatMessage', -1, "[ANNOUNCEMENT]", {255, 0, 0}, " " .. message)
	end
end)

RegisterServerEvent('FiveLife:Command-SETJOB')
AddEventHandler('FiveLife:Command-SETJOB', function(sender, args)
	local job = string.upper(table.remove(args, 1))
	local player = table.remove(args, 1)
	if GetPlayerName(player) ~= nil then
		TriggerEvent("setWhitelistJob", player, job)
		logCommand(GetPlayerName(sender) .. " set " .. GetPlayerName(player) .. " as " .. job .. ".", 0)
		TriggerClientEvent('chatMessage', sender, "SYSTEM", {200, 0, 0}, GetPlayerName(player) .. "'s job set!")
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
	end
end)

RegisterServerEvent('FiveLife:Command-MODMODE')
AddEventHandler('FiveLife:Command-MODMODE', function(sender, args)
	logCommand(GetPlayerName(sender) .. " used ModMode.", 0)
	-- To be implemented
end)

RegisterServerEvent('FiveLife:Command-PING')
AddEventHandler('FiveLife:Command-PING', function(sender, args)
	if args[1] ~= nil then
		if GetPlayerName(args[1]) ~= nil then
			TriggerClientEvent("chatMessage", sender, 'PING', {0, 0x99, 255}, "" .. GetPlayerPing(args[1]))
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1/ping [ID]")
	end
end)



	--------------- ADMINISTRATOR COMMANDS ---------------
RegisterServerEvent('FiveLife:Command-BAN')
AddEventHandler('FiveLife:Command-BAN', function(sender, args)
	local toBan = tonumber(table.remove(args, 1))
	local reason = table.concat(args, " ")

	if reason == nil then reason = "You were banned. Appeal at GTAV-Life.com" end

	if toBan ~= nil then
		if GetPlayerName(toBan) ~= nil then
			local bannedSteamID = GetPlayerIdentifiers(toBan)[1]
			logCommand(GetPlayerName(sender) .. " banned " .. GetPlayerName(toBan) .. " (" .. bannedSteamID .. "). Reason: " .. reason, 0)
			addToBanlist(GetPlayerIdentifiers(toBan)[1])
			TriggerClientEvent('chatMessage', sender, "SYSTEM", {200, 0, 0}, GetPlayerName(toBan) .. " banned!")
			table.insert(tempbanList, bannedSteamID)
			DropPlayer(toBan, reason)
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1/ban [ID] [Reason]")
	end
end)

RegisterServerEvent('FiveLife:Command-SETRANK')
AddEventHandler('FiveLife:Command-SETRANK', function(sender, args)
	local adminlevel = tonumber(Users[GetPlayerIdentifiers(sender)[1]].groupID)
	if adminlevel > tonumber(args[1]) then
		if args[1] ~= nil and args[2] ~= nil then
			local level = table.remove(args, 1)
			local player = table.remove(args, 1)
			if GetPlayerName(player) ~= nil then
				TriggerEvent("setRank", player, level)
				logCommand(GetPlayerName(sender) .. " promoted " .. GetPlayerName(player) .. " to " .. level .. ".", 3)
				TriggerClientEvent('chatMessage', sender, "SYSTEM", {200, 0, 0}, GetPlayerName(player) .. "'s level set!")
			else
				TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid player ID!")
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1/setAdmin [ID] [RANK(1-7)]")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1You can not promote higher than yourself!")
	end
end)

RegisterServerEvent('FiveLife:Command-ADMINMODE')
AddEventHandler('FiveLife:Command-ADMINMODE', function(sender, args)
	logCommand(GetPlayerName(sender) .. " used AdminMode.", 0)
	-- To be implemented
end)

RegisterServerEvent('FiveLife:Command-CLEARCHAT')
AddEventHandler('FiveLife:Command-CLEARCHAT', function(sender)
	logCommand(GetPlayerName(sender) .. " has cleared the chat.", 0)
	TriggerClientEvent('chat:clear', -1)
	TriggerClientEvent('chatMessage', -1, "["..sender.."]", {255, 0, 0}, "cleared chat!")
end)

	--------------- SENIOR ADMIN COMMANDS ---------------
RegisterServerEvent('FiveLife:Command-GIVE')
AddEventHandler('FiveLife:Command-GIVE', function(sender, args)
	local item = table.remove(args, 1)
	local player = tonumber(table.remove(args, 1))
	local amount = table.remove(args, 1)

	if item ~= nil and amount ~= nil then
		if player == tonumber(sender) then
			logCommand(GetPlayerName(sender) .. " tried to give themselves " .. amount .. " " .. item .. ".", 2)
			TriggerEvent("anticheat:Flagged", "Abuse of Funds.")
		elseif GetPlayerName(player) == nil then
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		else
			if item == "MONEY" then
				logCommand(GetPlayerName(sender) .. " gave " .. amount .. " " .. item .. " to " .. GetPlayerName(player) .. ".", 1)
				TriggerClientEvent('chatMessage', sender, "SYSTEM", {200, 0, 0}, GetPlayerName(player) .. " given " .. amount .. " " .. item)
				TriggerEvent("givePlayerMoney", player, amount)
			end
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1USAGE: /give [Item] [Player] [Amount]")
	end
end)

RegisterServerEvent('FiveLife:Command-REMOVE')
AddEventHandler('FiveLife:Command-REMOVE', function(sender, args)
	local item = table.remove(args, 1)
	local player = table.remove(args, 1)
	local amount = table.remove(args, 1)

	if item ~= nil and amount ~= nil then
		if GetPlayerName(player) ~= nil then
			if item == "MONEY" then
				logCommand(GetPlayerName(sender) .. " removed " .. amount .. " " .. item .. " from " .. GetPlayerName(player) .. ".", 1)
				TriggerClientEvent('chatMessage', sender, "SYSTEM", {200, 0, 0}, GetPlayerName(player) .. " deducted " .. amount .. " " .. item)
				TriggerEvent("removeMoney", player, amount)
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1USAGE: /remove [Item] [Player] [Amount]")
	end
end)

RegisterServerEvent('FiveLife:Command-WIPE')
AddEventHandler('FiveLife:Command-WIPE', function(sender, args)
	local item = table.remove(args, 1)
	local player = table.remove(args, 1)

	if item ~= nil and player ~= nil then
		if GetPlayerName(player) ~= nil then
			if item == "WEAPONS" then
				TriggerEvent("takeAllWeapons", player)
				logCommand(GetPlayerName(sender) .. " wiped " .. GetPlayerName(player) .. "'s weapons.", 1)
			elseif item == "INVENTORY" then
				TriggerEvent("wipeInventory", player)
				logCommand(GetPlayerName(sender) .. " wiped " .. GetPlayerName(player) .. "'s inventory.", 1)
			end
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1USAGE: /wipe [WEAPONS, INVENTORY] [ID]")
	end
end)



	--------------- DEVELOPER COMMANDS ---------------
RegisterServerEvent('FiveLife:Command-DEBUG')
AddEventHandler('FiveLife:Command-DEBUG', function(sender, args)
	TriggerClientEvent("menu:openMenu", sender, 16, 0)
end)

RegisterServerEvent('FiveLife:Command-DEVMODE')
AddEventHandler('FiveLife:Command-DEVMODE', function(sender, args)
	TriggerClientEvent("menu:openMenu", sender, 15, 0)
end)

RegisterServerEvent('FiveLife:Command-CONSOLE')
AddEventHandler('FiveLife:Command-CONSOLE', function(sender, args)
	local message = table.concat(args, " ")
	if message ~= nil then
		TriggerClientEvent('chatMessage', -1, "Console", {255, 0, 0}, " " .. message)
	end
end)

RegisterServerEvent('FiveLife:Command-TIME')
AddEventHandler('FiveLife:Command-TIME', function(sender, args)
	if args[1] == 'LIST' then
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^3/time [MORNING, NOON, EVENING, NIGHT]")
	else
		TriggerEvent("ts:overrideTime", args[1])
	end
end)

RegisterServerEvent('FiveLife:Command-NEXTWEATHER')
AddEventHandler('FiveLife:Command-NEXTWEATHER', function(sender, args)
	if args[1] == "LIST" then
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^3/weather [CLEAR, EXTRASUNNY, CLOUDS, OVERCAST, RAIN, CLEARING, THUNDER, SMOG, FOGGY, XMAS, SNOWLIGHT, BLIZZARD]")
	elseif args[1] ~= nil then
		TriggerEvent("ts:overrideWeather", args[1])
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Use /weather list")
	end
end)

RegisterServerEvent('FiveLife:Command-FORCEWEATHER')
AddEventHandler('FiveLife:Command-FORCEWEATHER', function(sender, args)
	TriggerEvent("ts:forceWeather")
end)

RegisterServerEvent('FiveLife:Command-CRASH')
AddEventHandler('FiveLife:Command-CRASH', function(sender, args)
	if args[1] ~= nil then
		local player = table.remove(args, 1)
		if GetPlayerName(player) ~= nil then
			TriggerClientEvent("order66", player)
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid ID")
	end
end)

RegisterServerEvent('FiveLife:Command-UPTIME')
AddEventHandler('FiveLife:Command-UPTIME', function(sender, args)
	TriggerClientEvent("chatMessage", sender, 'UPTIME', {0, 0x99, 255}, "" .. upTime.hour .. "h " .. upTime.minute .. "m")
end)

RegisterServerEvent('FiveLife:Command-TIMER')
AddEventHandler('FiveLife:Command-TIMER', function(sender, args)
	TriggerClientEvent("chatMessage", sender, 'UPTIME', {0, 0x99, 255}, "" .. GetGameTimer())
end)

RegisterServerEvent('FiveLife:Command-FORCEREVIVE')
AddEventHandler('FiveLife:Command-FORCEREVIVE', function(sender, args)
	if args[1] ~= nil then
		local player = table.remove(args, 1)
		if GetPlayerName(player) ~= nil then
			TriggerClientEvent("revivePlayer", player)
		else
			TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
		end
	else
		TriggerClientEvent("chatMessage", sender, '', {0, 0x99, 255}, "^1Invalid Player ID")
	end
end)


	--------------- HELP COMMANDS ---------------
RegisterServerEvent('FiveLife:Command-HELP')
AddEventHandler('FiveLife:Command-HELP', function(sender, args)
	local adminlevel = tonumber(Users[GetPlayerIdentifiers(sender)[1]].groupID)
	TriggerClientEvent("chatMessage", sender, "", {255, 84, 0}, "^4---- Help List ----")
	TriggerClientEvent("chatMessage", sender, "Teamspeak", {255, 84, 0}, "45.63.67.150:8519")
	TriggerClientEvent("chatMessage", sender, "Website", {255, 84, 0}, "www.gtav-life.com")
	TriggerClientEvent("chatMessage", sender, "Civillian Commands", {255, 84, 0}, "/civcom")
	TriggerClientEvent("chatMessage", sender, "Police Commands", {255, 84, 0}, "/copcom 1")
	TriggerClientEvent("chatMessage", sender, "EMS Commands", {255, 84, 0}, "/emscom 1")
	if (adminlevel > 1) then
		TriggerClientEvent("chatMessage", sender, "Admin Commands", {255, 84, 0}, "/admincom")
	elseif (adminlevel == 1) then
		TriggerClientEvent("chatMessage", sender, "Moderator Commands", {255, 84, 0}, "/modcom")
	end
end)

RegisterServerEvent('FiveLife:Command-CIVCOM')
AddEventHandler('FiveLife:Command-CIVCOM', function(sender, args)
	TriggerClientEvent("chatMessage", sender, "", {255, 84, 0}, "^4---- Civillian Commands ----")
	TriggerClientEvent("chatMessage", sender, "Text", {255, 84, 0}, "/text [id]")
	TriggerClientEvent("chatMessage", sender, "Tweet", {255, 84, 0}, "/tweet [message]")
	TriggerClientEvent("chatMessage", sender, "In-Chat Action", {255, 84, 0}, "/me [action or message]")
	TriggerClientEvent("chatMessage", sender, "Change Voice Volume", {255, 84, 0}, "^3M")
	TriggerClientEvent("chatMessage", sender, "Virtual Phone", {255, 84, 0}, "^3Y")
	TriggerClientEvent("chatMessage", sender, "Interaction Menu", {255, 84, 0}, "^3E")
	TriggerClientEvent("chatMessage", sender, "Speed Limiter", {255, 84, 0}, "^3Shift + Space")
end)

RegisterServerEvent('FiveLife:Command-EMSCOM')
AddEventHandler('FiveLife:Command-EMSCOM', function(sender, args)
	if args[1] == '2' then
		TriggerClientEvent("chatMessage", sender, "", {255, 84, 0}, "^4---- EMS Commands (Page 2) ----")
        TriggerClientEvent("chatMessage", sender, "Revive", {255, 84, 0}, "/revive [id]")
        TriggerClientEvent("chatMessage", sender, "Goto Report Location", {255, 84, 0}, "/goto [reportid]")
        TriggerClientEvent("chatMessage", sender, "View a Report", {255, 84, 0}, "/view [reportid]")
        TriggerClientEvent("chatMessage", sender, "Clothing Menu", {255, 84, 0}, "F6")
        TriggerClientEvent("chatMessage", sender, "Delete Vehicle", {255, 84, 0}, "/dv")
		TriggerClientEvent("chatMessage", sender, "Emergency Chat", {255, 84, 0}, "/ec [message]")
	else
		TriggerClientEvent("chatMessage", sender, "", {255, 84, 0}, "^4---- EMS Commands (Page 1) ----")
        TriggerClientEvent("chatMessage", sender, "Siren Control", {255, 84, 0}, "1, 2, 3, 4")
        TriggerClientEvent("chatMessage", sender, "Light Control", {255, 84, 0}, "E")
        TriggerClientEvent("chatMessage", sender, "Go on duty", {255, 84, 0}, "/duty")
        TriggerClientEvent("chatMessage", sender, "Spawn Vehicles", {255, 84, 0}, "/spawn [carname]")
        TriggerClientEvent("chatMessage", sender, "Seat a player", {255, 84, 0}, "/seat [id]")
        TriggerClientEvent("chatMessage", sender, "Un-Seat a player", {255, 84, 0}, "/unseat [id]")
        TriggerClientEvent("chatMessage", sender, "EMS Commands Page 2", {255, 0, 0}, "/emscom 2")
	end
end)

RegisterServerEvent('FiveLife:Command-COPCOM')
AddEventHandler('FiveLife:Command-COPCOM', function(sender, args)
	if args[1] == '2' then
		TriggerClientEvent("chatMessage", sender, "", {255, 84, 0}, "^4---- Police Commands (Page 2) ----")
        TriggerClientEvent("chatMessage", sender, "Cuff a player", {255, 84, 0}, "/cuff [id]")
        TriggerClientEvent("chatMessage", sender, "Jail a player", {255, 84, 0}, "/jail [id] [minutes]")
        TriggerClientEvent("chatMessage", sender, "Revive", {255, 84, 0}, "/revive [id]")
        TriggerClientEvent("chatMessage", sender, "Goto Report Location", {255, 84, 0}, "/goto [reportid]")
        TriggerClientEvent("chatMessage", sender, "View a Report", {255, 84, 0}, "/view [reportid]")
        TriggerClientEvent("chatMessage", sender, "Clothing Menu", {255, 84, 0}, "F6")
        TriggerClientEvent("chatMessage", sender, "Delete Vehicle", {255, 84, 0}, "/dv")
		TriggerClientEvent("chatMessage", sender, "Emergency Chat", {255, 84, 0}, "/ec [message]")
	else
		TriggerClientEvent("chatMessage", sender, "", {255, 84, 0}, "^4---- Police Commands (Page 1) ----")
        TriggerClientEvent("chatMessage", sender, "Siren Control", {255, 84, 0}, "1, 2, 3, 4")
        TriggerClientEvent("chatMessage", sender, "Light Control", {255, 84, 0}, "E")
		TriggerClientEvent("chatMessage", sender, "Go on duty", {255, 84, 0}, "/duty")
        TriggerClientEvent("chatMessage", sender, "Spawn Vehicles", {255, 84, 0}, "/spawn [carname]")
        TriggerClientEvent("chatMessage", sender, "Ticket a player", {255, 84, 0}, "/ticket [id] [amount]")
        TriggerClientEvent("chatMessage", sender, "Seat a player", {255, 84, 0}, "/seat [id]")
        TriggerClientEvent("chatMessage", sender, "Un-Seat a player", {255, 84, 0}, "/unseat [id]")
        TriggerClientEvent("chatMessage", sender, "Police Commands Page 2", {255, 0, 0}, "/copcom 2")
	end
end)

RegisterServerEvent('FiveLife:Command-MODCOM')
AddEventHandler('FiveLife:Command-MODCOM', function(sender, args)
	TriggerClientEvent("chatMessage", sender, "", {255, 84, 0}, "^4---- Moderator Commands ----")
	TriggerClientEvent("chatMessage", sender, "Set Server Rank", {255, 84, 0}, "/setRank [id]")
	TriggerClientEvent("chatMessage", sender, "Set Job", {255, 84, 0}, "/setJob [id]")
	TriggerClientEvent("chatMessage", sender, "Kick", {255, 84, 0}, "/kick [id]")
	TriggerClientEvent("chatMessage", sender, "Tempban", {255, 84, 0}, "/tempban [id]")
end)

RegisterServerEvent('FiveLife:Command-ADMINCOM')
AddEventHandler('FiveLife:Command-ADMINCOM', function(sender, args)
	TriggerClientEvent("chatMessage", sender, "", {255, 84, 0}, "^4---- Administrator Commands ----")
	TriggerClientEvent("chatMessage", sender, "Set Server Rank", {255, 84, 0}, "/setRank [id]")
	TriggerClientEvent("chatMessage", sender, "Set Job", {255, 84, 0}, "/setJob [id]")
	TriggerClientEvent("chatMessage", sender, "Kick", {255, 84, 0}, "/kick [id]")
	TriggerClientEvent("chatMessage", sender, "Temp Ban", {255, 84, 0}, "/tempban [id]")
	TriggerClientEvent("chatMessage", sender, "Perm Ban", {255, 84, 0}, "/ban [id]")
end)
