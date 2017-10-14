

	----- GENERAL CONSOLE COMMANDS -----
consoleCommands["ANNOUNCE"] = {help = "/announce [MESSAGE]"}
consoleCommands["CONSOLE"] = {help = "/console [MESSAGE]"}
consoleCommands["REVIVE"] = {help = "/revive [ID]"}
consoleCommands["UPTIME"] = {help = "/uptime"}
consoleCommands["TIMER"] = {help = "/timer"}

	----- LEVEL CONSOLE COMMANDS -----
consoleCommands["SETJOB"] = {help = "/setJob [NONE, LSPD, SASP, EMS] [ID]"}
consoleCommands["SETRANK"] = {help = "/setRank [0-7] [ID]"}

	----- ADMIN CONSOLE COMMANDS -----
consoleCommands["KICK"] = {help = "/kick [ID] [REASON]"}
consoleCommands["TEMPBAN"] = {help = "/tempban [ID] [REASON]"}
consoleCommands["BAN"] = {help = "/ban [ID] [REASON]"}
consoleCommands["CRASH"] = {help = "/crash [ID]"}





	--------------- TEXT CONSOLE COMMANDS ---------------
RegisterServerEvent('FiveLife:Console-ANNOUNCE')
AddEventHandler('FiveLife:Console-ANNOUNCE', function(args)
	local message = table.concat(args, " ")
	if message ~= nil then
		TriggerClientEvent('chatMessage', -1, "[ANNOUNCEMENT]", {255, 0, 0}, " " .. message)
		print("[ANNOUNCEMENT]: " .. message)
	end
end)

RegisterServerEvent('FiveLife:Console-CONSOLE')
AddEventHandler('FiveLife:Console-CONSOLE', function(args)
	local message = table.concat(args, " ")
	if message ~= nil then
		TriggerClientEvent('chatMessage', -1, "Console", {255, 0, 0}, " " .. message)
		print("Console: " .. message)
	end
end)

RegisterServerEvent('FiveLife:Console-REVIVE')
AddEventHandler('FiveLife:Console-REVIVE', function(args)
	if GetPlayerName(args[1]) ~= nil then
		TriggerClientEvent("revivePlayer", args[1])
		print("REVIVE: Player revived!")
	else
		print("REVIVE: Invalid player ID!")
	end
end)

RegisterServerEvent('FiveLife:Console-UPTIME')
AddEventHandler('FiveLife:Console-UPTIME', function(args)
	print("SERVER UPTIME: " .. upTime.hour .. "H " .. upTime.minute .. "M")
end)

RegisterServerEvent('FiveLife:Console-TIMER')
AddEventHandler('FiveLife:Console-TIMER', function(args)
	print("SERVER TIMER: " .. GetGameTimer())
end)


	--------------- LEVEL CONSOLE COMMANDS ---------------
RegisterServerEvent('FiveLife:Console-SETJOB')
AddEventHandler('FiveLife:Console-SETJOB', function(args)
	if args[1] ~= nil and args[2] ~= nil then
		local job = string.upper(table.remove(args, 1))
		local player = table.remove(args, 1)
		if GetPlayerName(player) ~= nil then
			if job == 'NONE' or job == 'LSPD' or job == 'SASP' or job == 'EMS' or job == 'FIRE' then
				TriggerEvent("setWhitelistJob", player, job)
				logCommand("Console set " .. GetPlayerName(player) .. " as " .. job .. ".", 0)
				print("JOB: " .. GetPlayerName(player) .. " set as " .. job .. ".")
			end
		end
	end
end)

RegisterServerEvent('FiveLife:Console-SETRANK')
AddEventHandler('FiveLife:Console-SETRANK', function(args)
	if args[1] ~= nil and args[2] ~= nil then
		local level = table.remove(args, 1)
		local player = table.remove(args, 1)
		if GetPlayerName(player) ~= nil then
			TriggerEvent("setRank", player, level)
			logCommand("Console promoted " .. GetPlayerName(player) .. " to " .. level .. ".", 3)
			print("RANK: " .. GetPlayerName(player) .. " set as " .. level .. ".")
		end
	end
end)


	--------------- ADMIN CONSOLE COMMANDS ---------------
RegisterServerEvent('FiveLife:Console-KICK')
AddEventHandler('FiveLife:Console-KICK', function(args)
	if args[1] ~= nil then
		local toKick = table.remove(args, 1)
		if GetPlayerName(toKick) ~= nil then
			local reason = table.concat(args, " ")
			if reason == nil then reason = "You were kicked." end
			logCommand("Console kicked " .. GetPlayerName(toKick) .. ".", 0)
			DropPlayer(tonumber(toKick), reason)
		end
	end
end)

RegisterServerEvent('FiveLife:Console-TEMPBAN')
AddEventHandler('FiveLife:Console-TEMPBAN', function(args)
	if args[1] ~= nil then
		local toBan = table.remove(args, 1)
		if GetPlayerName(toBan) ~= nil then
			local reason = table.concat(args, " ")
			local bannedSteamID = GetPlayerIdentifiers(toBan)[1]
			if reason == nil then reason = "You were tempbanned. Appeal at GTAV-Life.com" end
			logCommand("Console tempbanned " .. GetPlayerName(toBan) .. " (" .. bannedSteamID .. "). Reason: " .. reason, 0)
			table.insert(tempbanList, bannedSteamID)
			DropPlayer(toBan, reason)
		end
	end
end)

RegisterServerEvent('FiveLife:Console-BAN')
AddEventHandler('FiveLife:Console-BAN', function(args)
	if args[1] ~= nil then
		local toBan = table.remove(args, 1)
		if GetPlayerName(toBan) ~= nil then
			local reason = table.concat(args, " ")
			local bannedSteamID = GetPlayerIdentifiers(toBan)[1]
			if reason == nil then reason = "You were banned. Appeal at GTAV-Life.com" end
			logCommand("Console banned " .. GetPlayerName(toBan) .. " (" .. bannedSteamID .. "). Reason: " .. reason, 0)
			addToBanlist(GetPlayerIdentifiers(toBan)[1])
			table.insert(tempbanList, bannedSteamID)
			DropPlayer(toBan, reason)
		end
	end
end)

RegisterServerEvent('FiveLife:Console-CRASH')
AddEventHandler('FiveLife:Console-CRASH', function(args)
	if args[1] ~= nil then
		local player = table.remove(args, 1)
		if GetPlayerName(player) ~= nil then
			TriggerClientEvent("order66", player)
		end
	end
end)
