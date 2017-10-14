--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

RegisterServerEvent("AntiCheat:CheckLocalMoney")
AddEventHandler("AntiCheat:CheckLocalMoney", function(playerBank, playerCash)
	local steamID = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		if result[1] ~= nil then
			local thisBank = tonumber(result[1].bank)
			local thisCash = tonumber(result[1].cash)
			local bankDifference = 0
			local cashDifference = 0
			
			if playerBank > thisBank then bankDifference = playerBank - thisBank else bankDifference = thisBank - playerBank end
			if playerCash > thisCash then cashDifference = playerCash - thisCash else cashDifference = thisCash - playerCash end
			if bankDifference > 1000 then
				--AntiCheatAutoBan(source, "Illegitimate Bank Funds.")
				logCheat(GetPlayerName(source) .. " flagged for Illegitimate Bank | " .. steamID[1])
				logCheat("Player: " .. playerBank .. " | Database: " .. thisBank)
			elseif cashDifference > 1000 then
				--AntiCheatAutoBan(source, "Illegitimate Cash Funds.")
				logCheat(GetPlayerName(source) .. " flagged for Illegitimate Cash | " .. steamID[1])
				logCheat("INFO: Player: " .. playerCash .. " | Database: " .. thisCash)
			end
		end
	end)
end)

RegisterServerEvent("AntiCheat:blacklistedVehicle")
AddEventHandler("AntiCheat:blacklistedVehicle", function()
	TriggerClientEvent('deleteVehicle', source)
end)

RegisterServerEvent("AntiCheat:Banned")
AddEventHandler("AntiCheat:Banned", function(reason, info)
	AntiCheatAutoBan(source, reason, info)
end)

RegisterServerEvent("AntiCheat:Kicked")
AddEventHandler("AntiCheat:Kicked", function(reason, info)
	AntiCheatAutoKick(source, reason, info)
end)

RegisterServerEvent("AntiCheat:Flagged")
AddEventHandler("AntiCheat:Flagged", function(reason, info)
	local steamID = GetPlayerIdentifiers(source)[1]
	logCheat(GetPlayerName(source) .. " flagged for " .. reason .. " | " .. steamID)
	logCheat("INFO: " .. info)
end)

function AntiCheatAutoBan(player, reason, info)
	local steamID = GetPlayerIdentifiers(player)[1]
	logCheat(GetPlayerName(player) .. " banned for " .. reason .. " | " .. steamID)
	logCheat("INFO: " .. info)
	addToBanlist(steamID)
	DropPlayer(player, "[Anti-Cheat] Banned for " .. reason .. " Appeal at GTAV-Life.com")
end

function AntiCheatAutoKick(player, reason, info)
	local steamID = GetPlayerIdentifiers(player)[1]
	logCheat(GetPlayerName(player) .. " kicked for " .. reason .. " | " .. steamID)
	logCheat("INFO: " .. info)
	DropPlayer(player, "[Anti-Cheat] Warning: " .. reason .. ".")
end

function logCheat(message)
	file = io.open("logs/CheatLog.txt", "a")
	file:write(os.date("[%m/%d %H:%M]") .. " " .. message)
	file:write("\n")
	file:close()
end