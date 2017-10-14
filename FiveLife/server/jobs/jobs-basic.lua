--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

AddEventHandler('onMySQLReady', function ()
   MySQL.Async.execute("UPDATE garage SET inGarage='true'", {}, function() end)
end)



-- ============================ WHITELIST EVENT HANDLERS ============================

RegisterServerEvent("setWhitelistJob")
AddEventHandler("setWhitelistJob", function(player, job)
	local steamID = GetPlayerIdentifiers(player)[1]
	if job == 'NONE' then
		MySQL.Async.execute("UPDATE users SET jobID=0 WHERE identifier = @steamID", {['@steamID'] = steamID}, function(result) end)
	elseif job == 'LSPD' then
		MySQL.Async.execute("UPDATE users SET jobID=1 WHERE identifier = @steamID", {['@steamID'] = steamID}, function(result) end)
	elseif job == 'DOC' then
		MySQL.Async.execute("UPDATE users SET jobID=2 WHERE identifier = @steamID", {['@steamID'] = steamID}, function(result) end)
	elseif job == 'SASP' then
		MySQL.Async.execute("UPDATE users SET jobID=3 WHERE identifier = @steamID", {['@steamID'] = steamID}, function(result) end)
	elseif job == 'EMS' then
		MySQL.Async.execute("UPDATE users SET jobID=4 WHERE identifier = @steamID", {['@steamID'] = steamID}, function(result) end)
	elseif job == 'FIRE' then
		MySQL.Async.execute("UPDATE users SET jobID=5 WHERE identifier = @steamID", {['@steamID'] = steamID}, function(result) end)
	elseif job == 'CIV' then
		MySQL.Async.execute("UPDATE users SET jobID=99 WHERE identifier = @steamID", {['@steamID'] = steamID}, function(result) end)
	end
end)

RegisterServerEvent("setRank")
AddEventHandler("setRank", function(player, rank)
	local steamID = GetPlayerIdentifiers(player)[1]
	MySQL.Async.execute("UPDATE users SET groupID=@rank WHERE identifier = @steamID", {['@steamID'] = steamID, ['@rank'] = rank}, function(result) end)
end)


-- ============================ MONEY EVENT HANDLERS ============================

RegisterServerEvent("givePlayerMoney")
AddEventHandler("givePlayerMoney", function(player, amount)
	if player == 0 then
		increasePlayerAccount(source, amount)
	else
		increasePlayerAccount(player, amount)
	end
end)

RegisterServerEvent("givePlayerCash")
AddEventHandler("givePlayerCash", function(player, amount)
	if player == 0 then
		increasePlayerCash(source, amount)
	else
		increasePlayerCash(player, amount)
	end
end)

RegisterServerEvent("deductMoney")
AddEventHandler("deductMoney", function(player, amount)
	if player == 0 then
		deductMoney(source, amount)
	else
		deductMoney(player, amount)
	end
end)

RegisterServerEvent("removeMoney")
AddEventHandler("removeMoney", function(player, amount)
	if player == 0 then
		removeMoney(source, amount)
	else
		removeMoney(player, amount)
	end
end)


-- ============================ INVENTORY EVENT HANDLERS ============================

RegisterServerEvent("addToPlayerInventory")
AddEventHandler("addToPlayerInventory", function(player, item, amount)
	if player == 0 then
		addItem(source, item, amount)
	else
		addItem(player, item, amount)
	end
end)

RegisterServerEvent("removeFromInventory")
AddEventHandler("removeFromInventory", function(player, item, amount)
	if player == 0 then
		removeItem(source, item, amount)
	else
		removeItem(player, item, amount)
	end
end)

RegisterServerEvent("sortInventory")
AddEventHandler("sortInventory", function()
	sortPlayerInv(source)
end)

RegisterServerEvent("wipeInventory")
AddEventHandler("wipeInventory", function(player)
	if player == 0 then
		wipeInv(source)
	else
		wipeInv(player)
	end
end)

RegisterServerEvent("processItems")
AddEventHandler("processItems", function(item)
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	if item ~= "Stolen-Cash" then
		processItem(serverID, item)
	else
		payPerItem(serverID, item)
		removeItem(serverID, item, 'all')
	end
end)


-- ============================ WEAPON EVENT HANDLERS ============================

RegisterServerEvent("giveWeapon")
AddEventHandler("giveWeapon", function(gun, ammo)
	addWeapon(source, gun, ammo)
end)

RegisterServerEvent("takeWeapon")
AddEventHandler("takeWeapon", function(gun)
	removeWeapon(source, gun)
end)

RegisterServerEvent("takeAllWeapons")
AddEventHandler("takeAllWeapons", function(player)
	if player == 0 then
		removeAllWeapons(source)
	else
		removeAllWeapons(player)
	end
end)

RegisterServerEvent("giveAmmo")
AddEventHandler("giveAmmo", function(gun, ammo)
	addAmmo(source, gun, ammo)
end)

RegisterServerEvent("updateAmmo")
AddEventHandler("updateAmmo", function(gun, ammo)
	changeAmmo(source, gun, ammo)
end)


-- ============================ LICENSE EVENT HANDLERS ============================

RegisterServerEvent("buyLicense")
AddEventHandler("buyLicense", function(license, price)
	local steamID = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchScalar("SELECT license FROM users WHERE identifier = @steamID", {['@steamID'] = steamID}, function(result) 
		local split = stringsplit(result, ' ')
		local hasLicense = false

		for i=1, 7, 1 do
			if split[i] ~= nil then
				if split[i] == license then
					hasLicense = true
				end
			end
		end
		if hasLicense == false then
			addLicense(source, license)
			deductMoney(source, price)
		end
	end)
end)

RegisterServerEvent("revokeLicense")
AddEventHandler("revokeLicense", function(player, license)
	if player == 0 then
		removeLicense(source, license)
	else
		removeLicense(player, license)
	end
end)


-- ============================ JOB EVENT HANDLERS ============================

RegisterServerEvent("Job:BasicJobPayout")
AddEventHandler("Job:BasicJobPayout", function(item)
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	payPerItem(serverID, item)
	removeItem(serverID, item, 'all')
end)

RegisterServerEvent("Job:FuelPayout")
AddEventHandler("Job:FuelPayout", function(amount)
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	MySQL.Async.fetchScalar('SELECT cash FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(cash)
		local value = 0
		local need = 1.0
		
		if FuelAmount < 100 then
			need = 1.5
		elseif FuelAmount < 250 then
			need = 1.25
		elseif FuelAmount < 500 then
			need = 1.1
		elseif FuelAmount < 750 then
			need = 1.0
		end
		
		if amount == 1 then
			value = 1450*need
		elseif amount == 2 then
			value = 1175*need
		elseif amount == 3 then
			value = 950*need
		elseif amount == 4 then
			value = 800*need
		end
		
		setCash(serverID, cash+value)
		TriggerClientEvent("notifyPlayer", serverID, "~g~Paid $" .. value)
		logAction(GetPlayerName(serverID) .. " hauled fuel for $" .. value, 0)
	end)
end)

RegisterServerEvent("Job:HaulPayout")
AddEventHandler("Job:HaulPayout", function(place)
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	MySQL.Async.fetchScalar('SELECT cash FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(cash)
		local value = 0
		if place == 1 then
			value = 1875
		elseif place == 2 then
			value = 1800
		elseif place == 3 then
			value = 1625
		elseif place == 4 then
			value = 1350
		elseif place == 5 then
			value = 1275
		elseif place == 6 then
			value = 1200
		elseif place == 7 then
			value = 1180
		elseif place == 8 then
			value = 950
		end
		
		setCash(serverID, cash+value)
		TriggerClientEvent("notifyPlayer", serverID, "~g~Paid $" .. value)
		logAction(GetPlayerName(serverID) .. " hauled supplies for $" .. value, 0)
	end)
end)

RegisterServerEvent("Job:BusPayout")
AddEventHandler("Job:BusPayout", function()
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	MySQL.Async.fetchScalar('SELECT cash FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(cash)
		local value = 3500
		setCash(serverID, cash+value)
		TriggerClientEvent("notifyPlayer", serverID, "~g~Paid $" .. value)
		logAction(GetPlayerName(serverID) .. " drove a bus for $" .. value, 0)
	end)
end)


-- ============================ POLICE EVENT HANDLERS ============================

RegisterServerEvent("goOffDuty")
AddEventHandler("goOffDuty", function()
	TriggerClientEvent("returnToModel", source)
end)

RegisterServerEvent("searchPlayer")
AddEventHandler("searchPlayer", function(user, player)
	local steamID = GetPlayerIdentifiers(player)[1]
	MySQL.Async.fetchAll('SELECT * FROM player_inventory WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		local split1 = stringsplit(result[1].SLOT1, ' ')
		local split2 = stringsplit(result[1].SLOT2, ' ')
		local split3 = stringsplit(result[1].SLOT3, ' ')
		local split4 = stringsplit(result[1].SLOT4, ' ')
		local split5 = stringsplit(result[1].SLOT5, ' ')
		local split6 = stringsplit(result[1].SLOT6, ' ')
		local split7 = stringsplit(result[1].SLOT7, ' ')
		local split8 = stringsplit(result[1].SLOT8, ' ')
		local split9 = stringsplit(result[1].SLOT9, ' ')
		local split10 = stringsplit(result[1].SLOT10, ' ')
	
		TriggerClientEvent("returnSearch", user, player, split1[1], split1[2], split2[1], split2[2], split3[1], split3[2], split4[1], split4[2], split5[1], split5[2], split6[1], split6[2], split7[1], split7[2], split8[1], split8[2], split9[1], split9[2], split10[1], split10[2])
	end)
end)

RegisterServerEvent("ticketPlayer")
AddEventHandler("ticketPlayer", function(player, amount)
	local steamID = GetPlayerIdentifiers(player)[1]
	local price = tonumber(amount)
	if steamID ~= nil then
		MySQL.Async.fetchScalar('SELECT cash FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(cash)
			if tonumber(cash) >= price then
				setCash(player, cash-price)
				TriggerClientEvent("notifyPlayer", player, "~r~You have been ticketed ~g~$" .. price)
				TriggerClientEvent("notifyPlayer", source, "~g~Ticket paid!")
			else
				MySQL.Async.fetchScalar('SELECT bank FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(account)
					if tonumber(account) >= price then
						setAccount(player, account-price)
						TriggerClientEvent("notifyPlayer", player, "~r~You have been ticketed ~g~$" .. price)
						TriggerClientEvent("notifyPlayer", source, "~g~Ticket paid!")
					else
						TriggerClientEvent("notifyPlayer", player, "Not enough money for that.")
						TriggerClientEvent("notifyPlayer", source, "~r~Not enough money to pay!")
					end
				end)
			end
		end)
	else
		TriggerClientEvent("notifyPlayer", source, "~r~Invalid Player ID")
	end
end)

RegisterServerEvent("removeIllegalItems")
AddEventHandler("removeIllegalItems", function(player)
	local steamID = "steamID"
	local serverID = player
	local items = {}
	local removed = false
	
	if player == 0 then
		steamID = GetPlayerIdentifiers(source)[1]
		serverID = source
	else
		steamID = GetPlayerIdentifiers(player)[1]
		serverID = player
	end
	MySQL.Async.fetchAll('SELECT * FROM player_inventory WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		items[1] = stringsplit(result[1].SLOT1, ' ')
		items[2] = stringsplit(result[1].SLOT2, ' ')
		items[3] = stringsplit(result[1].SLOT3, ' ')
		items[4] = stringsplit(result[1].SLOT4, ' ')
		items[5] = stringsplit(result[1].SLOT5, ' ')
		items[6] = stringsplit(result[1].SLOT6, ' ')
		items[7] = stringsplit(result[1].SLOT7, ' ')
		items[8] = stringsplit(result[1].SLOT8, ' ')
		items[9] = stringsplit(result[1].SLOT9, ' ')
		items[10] = stringsplit(result[1].SLOT10, ' ')
	
		for i=1, 10 do
			if items[i][1] == "Stolen-Cash" or items[i][1] == "Weed" or items[i][1] == "Meth" then
				MySQL.Async.execute("UPDATE player_inventory SET SLOT" .. i .. "='Empty 0' WHERE identifier = @steamID", {['@steamID'] = steamID}, function(res) end)
				TriggerClientEvent('UpdateInventory', serverID, 'SLOT' .. i, "Empty", 0)
				removed = true
			end
		end
		
		if removed then
			TriggerClientEvent("notifyPlayer", serverID, "~r~Illegal items seized.")
			sortPlayerInv(serverID)
		end
	end)
end)


-- ============================ MENU EVENT HANDLERS ============================

RegisterServerEvent("Menu:Bank")
AddEventHandler("Menu:Bank", function(transaction, amount)
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	local currentAccount = ""
	local currentCash = ""
	local newAccount = 0
	local newCash = 0
	local change = tonumber(amount)
	
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		currentAccount = tonumber(result[1].bank)
		currentCash = tonumber(result[1].cash)
		
		if transaction == 'deposit' then
			newAccount = currentAccount + change
			newCash = currentCash - change
			
			MySQL.Async.execute("UPDATE users SET cash=@newItem WHERE identifier = @steamID", {['@steamID'] = steamID, ['@newItem'] = newCash}, function() end)
			MySQL.Async.execute("UPDATE users SET bank=@newItem WHERE identifier = @steamID", {['@steamID'] = steamID, ['@newItem'] = newAccount}, function() end)
			print("Account: " .. newAccount .. " | Cash: " .. newCash)
		elseif transaction == 'withdraw' then
			newAccount = currentAccount - change
			newCash = currentCash + change
			
			MySQL.Async.execute("UPDATE users SET cash=@newItem WHERE identifier = @steamID", {['@steamID'] = steamID, ['@newItem'] = newCash}, function() end)
			MySQL.Async.execute("UPDATE users SET bank=@newItem WHERE identifier = @steamID", {['@steamID'] = steamID, ['@newItem'] = newAccount}, function() end)
			print("Account: " .. newAccount .. " | Cash: " .. newCash)
		end
		TriggerClientEvent("UpdateMoney", serverID, 'account', newAccount)
		TriggerClientEvent("UpdateMoney", serverID, 'cash', newCash)
	end)
end)


-- ============================ OTHER EVENT HANDLERS ============================

RegisterServerEvent("playAnimation")
AddEventHandler("playAnimation", function(ped, name, types)
	TriggerClientEvent("startAnimation", source, ped, name, types)
end)

RegisterServerEvent("useShop")
AddEventHandler("useShop", function(item, price, amount)
	local serverID = source
	deductMoney(serverID, price)
	addItem(serverID, item, amount)
	TriggerClientEvent("notifyPlayer", serverID, amount .. "~b~ " .. item .. "~w~ bought for $" .. price)
end)





-- ============================ MONEY FUNCTIONS ============================

function increasePlayerAccount(player, amount)
	local steamID = GetPlayerIdentifiers(player)[1]
	MySQL.Async.fetchScalar('SELECT bank FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		local newAmount = tonumber(result)+amount
		MySQL.Async.execute('UPDATE users SET bank=@newAmount WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newAmount'] = newAmount}, function() end)
		TriggerClientEvent('UpdateMoney', player, 'account', newAmount)
	end)
end

function increasePlayerCash(player, amount)
	local steamID = GetPlayerIdentifiers(player)[1]
	MySQL.Async.fetchScalar('SELECT cash FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		local newAmount = tonumber(result)+amount
		MySQL.Async.execute('UPDATE users SET cash=@newAmount WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newAmount'] = newAmount}, function() end)
		TriggerClientEvent('UpdateMoney', player, 'cash', newAmount)
	end)
end

function deductMoney(player, amount)
	local steamID = GetPlayerIdentifiers(player)[1]
	local deduction = tonumber(amount)
	MySQL.Async.fetchScalar('SELECT cash FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(cash)
		local money = tonumber(cash)
		if money >= deduction then
			setCash(player, money-deduction)
		end
	end)
end

function removeMoney(player, amount)
	local steamID = GetPlayerIdentifiers(player)[1]
	local moneyAmount = tonumber(amount)
	MySQL.Async.fetchScalar('SELECT bank FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(account)
		local money = tonumber(account)
		if money >= moneyAmount then
			setAccount(player, money-moneyAmount)
		end
	end)
end

function setAccount(player, amount)
	local steamID = GetPlayerIdentifiers(player)[1]
	MySQL.Async.execute('UPDATE users SET bank =@newAmount WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newAmount'] = amount}, function() end)
	TriggerClientEvent('UpdateMoney', player, 'account', amount)
end

function setCash(player, amount)
	local steamID = GetPlayerIdentifiers(player)[1]
	MySQL.Async.execute('UPDATE users SET cash =@newAmount WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newAmount'] = amount}, function() end)
	TriggerClientEvent('UpdateMoney', player, 'cash', amount)
end


-- ============================ INVENTORY FUNCTIONS ============================

function addItem(player, item, amount)
	local steamID = GetPlayerIdentifiers(player)[1]
	local maxStack = tonumber(checkItem(item))
	local firstEmpty = 0
	local itemSlot = 0
	local items = {}
	MySQL.Async.fetchAll('SELECT * FROM player_inventory WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		items[1] = stringsplit(result[1].SLOT1, ' ')
		items[2] = stringsplit(result[1].SLOT2, ' ')
		items[3] = stringsplit(result[1].SLOT3, ' ')
		items[4] = stringsplit(result[1].SLOT4, ' ')
		items[5] = stringsplit(result[1].SLOT5, ' ')
		items[6] = stringsplit(result[1].SLOT6, ' ')
		items[7] = stringsplit(result[1].SLOT7, ' ')
		items[8] = stringsplit(result[1].SLOT8, ' ')
		items[9] = stringsplit(result[1].SLOT9, ' ')
		items[10] = stringsplit(result[1].SLOT10, ' ')
		
		for i=1, 10 do
			if items[i][1] == 'Empty' then
				if firstEmpty == 0 then
					firstEmpty = i
				end
			end
		end
		for i=1, 10 do
			if items[i][1] == item then
				if itemSlot == 0 then
					itemSlot = i
				end
			end
		end
		
		if itemSlot == 0 then
			MySQL.Async.execute("UPDATE player_inventory SET SLOT" .. firstEmpty .. "=@newItem WHERE identifier = @steamID", {['@steamID'] = steamID, ['@newItem'] = item .. ' ' .. amount}, function() end)
			TriggerClientEvent('UpdateInventory', player, 'SLOT' .. firstEmpty, item, amount)
		else
			local newTotal = tonumber(items[itemSlot][2]) + amount
			if newTotal > maxStack then
				TriggerClientEvent("notifyPlayer", player, "~r~You can't carry anymore ~b~" .. item .. "~r~!")
			elseif newTotal <= maxStack then
				MySQL.Async.execute("UPDATE player_inventory SET SLOT" .. itemSlot .. "=@newItem WHERE identifier = @steamID", {['@steamID'] = steamID, ['@newItem'] = item .. ' ' .. newTotal}, function() end)
				TriggerClientEvent('UpdateInventory', player, 'SLOT' .. itemSlot, item, newTotal)
			end
		end
	end)
end

function removeItem(player, item, amount)
	local steamID = GetPlayerIdentifiers(player)[1]
	local serverID = player
	local current = 0
	local itemSlot = 0
	local items = {}
	MySQL.Async.fetchAll('SELECT * FROM player_inventory WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		items[1] = stringsplit(result[1].SLOT1, ' ')
		items[2] = stringsplit(result[1].SLOT2, ' ')
		items[3] = stringsplit(result[1].SLOT3, ' ')
		items[4] = stringsplit(result[1].SLOT4, ' ')
		items[5] = stringsplit(result[1].SLOT5, ' ')
		items[6] = stringsplit(result[1].SLOT6, ' ')
		items[7] = stringsplit(result[1].SLOT7, ' ')
		items[8] = stringsplit(result[1].SLOT8, ' ')
		items[9] = stringsplit(result[1].SLOT9, ' ')
		items[10] = stringsplit(result[1].SLOT10, ' ')
		
		for i=1, 10 do
			if items[i][1] == item then
				if itemSlot == 0 then
					itemSlot = i
				end
			end
		end
		
		current = tonumber(items[itemSlot][2])
		if amount == 'all' or current == amount then
			MySQL.Async.execute("UPDATE player_inventory SET SLOT" .. itemSlot .. "='Empty 0' WHERE identifier = @steamID", {['@steamID'] = steamID}, function() end)
			TriggerClientEvent('UpdateInventory', serverID, 'SLOT' .. itemSlot, "Empty", 0)
		elseif current > amount then
			MySQL.Async.execute("UPDATE player_inventory SET SLOT" .. itemSlot .. "=@newAmount WHERE identifier = @steamID", {['@steamID'] = steamID, ['@newAmount'] = item .. ' ' .. current-amount}, function() end)
			TriggerClientEvent('UpdateInventory', serverID, 'SLOT' .. itemSlot, item, current-amount)
		end
		sortPlayerInv(serverID)
	end)
end

function wipeInv(player)
	local steamID = GetPlayerIdentifiers(player)[1]
	MySQL.Async.execute("UPDATE player_inventory SET SLOT1='Empty 0', SLOT2='Empty 0', SLOT3='Empty 0', SLOT4='Empty 0', SLOT5='Empty 0', SLOT6='Empty 0', SLOT7='Empty 0', SLOT8='Empty 0', SLOT9='Empty 0', SLOT10='Empty 0' WHERE identifier = @steamID", {['@steamID'] = steamID}, function() end)
	TriggerClientEvent('UpdateInventory', player, "emptyAll", 'Empty', 0)
	MySQL.Async.execute("UPDATE users SET cash=0 WHERE identifier = @steamID", {['@steamID'] = steamID}, function() end)
	TriggerClientEvent('UpdateMoney', player, 'cash', 0)
end

function sortPlayerInv(player)
	local steamID = GetPlayerIdentifiers(player)[1]
	local serverID = player
	local items = {}
	local itemsNew = {}
	local invAmountNew = {}
	local split = ""
	
	MySQL.Async.fetchAll('SELECT * FROM player_inventory WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		items[1] = stringsplit(result[1].SLOT1, ' ')
		items[2] = stringsplit(result[1].SLOT2, ' ')
		items[3] = stringsplit(result[1].SLOT3, ' ')
		items[4] = stringsplit(result[1].SLOT4, ' ')
		items[5] = stringsplit(result[1].SLOT5, ' ')
		items[6] = stringsplit(result[1].SLOT6, ' ')
		items[7] = stringsplit(result[1].SLOT7, ' ')
		items[8] = stringsplit(result[1].SLOT8, ' ')
		items[9] = stringsplit(result[1].SLOT9, ' ')
		items[10] = stringsplit(result[1].SLOT10, ' ')
	
		for i=1, 10 do
			itemsNew[i] = {}
			itemsNew[i][1] = items[i][1]
			itemsNew[i][2] = items[i][2]
		end
		
		for i=1, 9 do
			if itemsNew[i][1] == 'Empty' then
				if itemsNew[i+1][1] ~= 'Empty' then
					itemsNew[i][1] = itemsNew[i+1][1]
					itemsNew[i][2] = itemsNew[i+1][2]
					itemsNew[i+1][1] = 'Empty'
					itemsNew[i+1][2] = 0
				end
			end
		end
		
		for i=1, 10 do
			if itemsNew[i][1] == items[i][1] then
				-- No Sort Required
			else
				MySQL.Async.execute('UPDATE player_inventory SET SLOT' .. i .. '=@newItem WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newItem'] = itemsNew[i][1] .. ' ' .. itemsNew[i][2]}, function() end)
				TriggerClientEvent('UpdateInventory', serverID, 'SLOT' .. i, itemsNew[i][1], itemsNew[i][2])
			end
		end
	end)
end

function payPerItem(player, item)
	local steamID = GetPlayerIdentifiers(player)[1]
	local items = {}
	local amount = 0
	local value = 0
	MySQL.Async.fetchAll('SELECT * FROM player_inventory WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		items[1] = stringsplit(result[1].SLOT1, ' ')
		items[2] = stringsplit(result[1].SLOT2, ' ')
		items[3] = stringsplit(result[1].SLOT3, ' ')
		items[4] = stringsplit(result[1].SLOT4, ' ')
		items[5] = stringsplit(result[1].SLOT5, ' ')
		items[6] = stringsplit(result[1].SLOT6, ' ')
		items[7] = stringsplit(result[1].SLOT7, ' ')
		items[8] = stringsplit(result[1].SLOT8, ' ')
		items[9] = stringsplit(result[1].SLOT9, ' ')
		items[10] = stringsplit(result[1].SLOT10, ' ')
		if items[1][1] == item then
			amount = tonumber(items[1][2])
		elseif items[2][1] == item then
			amount = tonumber(items[2][2])
		elseif items[3][1] == item then
			amount = tonumber(items[3][2])
		elseif items[4][1] == item then
			amount = tonumber(items[4][2])
		elseif items[5][1] == item then
			amount = tonumber(items[5][2])
		elseif items[6][1] == item then
			amount = tonumber(items[6][2])
		elseif items[7][1] == item then
			amount = tonumber(items[7][2])
		elseif items[8][1] == item then
			amount = tonumber(items[8][2])
		elseif items[9][1] == item then
			amount = tonumber(items[9][2])
		elseif items[10][1] == item then
			amount = tonumber(items[10][2])
		end
		
		if item == 'Glass' then -- $336
			value = 10*amount
		elseif item == 'Concrete' then -- $768
			value = 31*amount
		elseif item == 'Weed' then -- $1176
			value = 28*amount
		elseif item == 'Meth' then -- $1824 (-380) (+1482)
			value = 48*amount
		elseif item == 'Oil' then -- $920
			value = 30*amount
		elseif item == 'Grapes' then -- $
			value = 4*amount
		elseif item == 'Sand' then -- $
			value = 2*amount
		elseif item == "Stolen-Cash" then
			value = 1*amount
		end
		
		if item == 'Stolen-Cash' then
			TriggerClientEvent("notifyPlayer", player, "~b~Stolen Cash ~g~laundered.")
			logAction(GetPlayerName(player) .. " laundered " .. amount .. " dirty money for $" .. value, 0)
		else
			TriggerClientEvent("notifyPlayer", player, "~g~" .. amount .. " ~b~" .. item .. " ~g~sold for $" .. value)
			logAction(GetPlayerName(player) .. " sold " .. amount .. " " .. item .. " for $" .. value, 0)
		end
		
		increasePlayerCash(player, value)
	end)
end

function processItem(player, item)
	local steamID = GetPlayerIdentifiers(player)[1]
	local serverID = player
	local items = {}
	local itemSlot = 0
	local amount = 0
	MySQL.Async.fetchAll('SELECT * FROM player_inventory WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		items[1] = stringsplit(result[1].SLOT1, ' ')
		items[2] = stringsplit(result[1].SLOT2, ' ')
		items[3] = stringsplit(result[1].SLOT3, ' ')
		items[4] = stringsplit(result[1].SLOT4, ' ')
		items[5] = stringsplit(result[1].SLOT5, ' ')
		items[6] = stringsplit(result[1].SLOT6, ' ')
		items[7] = stringsplit(result[1].SLOT7, ' ')
		items[8] = stringsplit(result[1].SLOT8, ' ')
		items[9] = stringsplit(result[1].SLOT9, ' ')
		items[10] = stringsplit(result[1].SLOT10, ' ')
		if items[1][1] == item then
			itemSlot = 1
		elseif items[2][1] == item then
			itemSlot = 2
		elseif items[3][1] == item then
			itemSlot = 3
		elseif items[4][1] == item then
			itemSlot = 4
		elseif items[5][1] == item then
			itemSlot = 5
		elseif items[6][1] == item then
			itemSlot = 6
		elseif items[7][1] == item then
			itemSlot = 7
		elseif items[8][1] == item then
			itemSlot = 8
		elseif items[9][1] == item then
			itemSlot = 9
		elseif items[10][1] == item then
			itemSlot = 10
		end
		amount = items[itemSlot][2]
		
		if process(item) ~= 'None' then
			local newItem = process(item)
			MySQL.Async.execute('UPDATE player_inventory SET SLOT' .. itemSlot .. '=@newItem WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newItem'] = newItem .. ' ' .. amount}, function() end)
			TriggerClientEvent('UpdateInventory', serverID, 'SLOT' .. itemSlot, newItem, amount)
			TriggerClientEvent("notifyPlayer", serverID, "~b~" .. item .. "~g~ processed.")
		else
			TriggerClientEvent("notifyPlayer", serverID, "~b~" .. item .. "~r~ not processed!")
		end
	end)
end


-- ============================ WEAPON FUNCTIONS ============================

function addWeapon(player, gun, ammo)
	local steamID = GetPlayerIdentifiers(player)[1]
	MySQL.Async.execute('UPDATE player_weapons SET ' .. gun ..' =1 WHERE identifier = @steamID', {['@steamID'] = steamID}, function() end)
end

function removeWeapon(player, gun)
	local steamID = GetPlayerIdentifiers(source)[1]
	MySQL.Async.execute('UPDATE player_weapons SET ' .. gun ..' =0 WHERE identifier = @steamID', {['@steamID'] = steamID}, function() end)
end

function removeAllWeapons(player)
	local steamID = GetPlayerIdentifiers(player)[1]
	MySQL.Async.execute('UPDATE player_weapons SET molotov=0, baseball_bat=0, crowbar=0, hammer=0, pistol=0, combat_pistol=0, sns_pistol=0, vintage_pistol=0, pump_shotgun=0, sawnoff_shotgun=0, micro_smg=0, assault_rifle=0, carbine_rifle=0, heavy_shotgun=0, flashlight=0, ammo_pistol=0, ammo_shotgun=0, ammo_smg=0, ammo_rifle=0 WHERE identifier = @steamID', {['@steamID'] = steamID}, function() end)
end

function addAmmo(player, ammoType, ammoCount)
	local steamID = GetPlayerIdentifiers(player)[1]
	local currentAmmo = 0
	MySQL.Async.fetchAll('SELECT * FROM player_weapons WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		if ammoType == 'ammo_pistol' then
			currentAmmo = tonumber(result[1].ammo_pistol)
		elseif ammoType == 'ammo_shotgun' then
			currentAmmo = tonumber(result[1].ammo_shotgun)
		elseif ammoType == 'ammo_smg' then
			currentAmmo = tonumber(result[1].ammo_smg)
		elseif ammoType == 'ammo_rifle' then
			currentAmmo = tonumber(result[1].ammo_rifle)
		end
		MySQL.Async.execute('UPDATE player_weapons SET ' .. ammoType .. ' =@newAmount WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newAmount'] = '' .. currentAmmo+ammoCount}, function() end)
	end)
end

function changeAmmo(player, ammoType, ammoCount)
	local steamID = GetPlayerIdentifiers(player)[1]
	MySQL.Async.execute('UPDATE player_weapons SET ' .. ammoType .. ' =@newAmount WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newAmount'] = ammoCount}, function() end)
end


-- ============================ LICENSE FUNCTIONS ============================

function addLicense(player, license)
	local steamID = GetPlayerIdentifiers(player)[1]
	local currentLicense = ""
	
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		currentLicense = result[1].license
		if currentLicense == 'none' then
			MySQL.Async.execute('UPDATE users SET license=@newItem WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newItem'] = "" .. license}, function() end)
			TriggerClientEvent("UpdateSingleLicense", player, license, true)
		else
			MySQL.Async.execute('UPDATE users SET license=@newItem WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newItem'] = currentLicense .. " " .. license}, function() end)
			TriggerClientEvent("UpdateSingleLicense", player, license, true)
		end
	end)
end

function removeLicense(player, license)
	local steamID = GetPlayerIdentifiers(player)[1]
	local split = ""
	local newLicense = ""
	local removedLicense = string.lower(license)
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		split = stringsplit(result[1].license, ' ')
		for i=1, #split, 1 do
			if split[i] ~= nil then
				if split[i] ~= removedLicense then
					newLicense = newLicense .. " " .. split[i]
				end
			end
		end
	
		MySQL.Async.execute('UPDATE users SET license=@newItem WHERE identifier = @steamID', {['@steamID'] = steamID, ['@newItem'] = newLicense}, function() end)
		TriggerClientEvent("UpdateSingleLicense", player, removedLicense, false)
	end)
end


-- ============================ BASE FUNCTIONS ============================

function process(item)
	if item == 'Sand' then
		return 'Glass'
	elseif item == 'Rock' then
		return 'Concrete'
	elseif item == 'Cannabis' then
		return 'Weed'
	elseif item == 'Materials' then
		return 'Meth'
	else
		return 'None'
	end
end

function checkItem(item)
	if item == 'Sand' then
		return 48
	elseif item == 'Cannabis' then
		return 42
	elseif item == 'Weed' then
		return 42
	elseif item == 'Rock' then
		return 32
	elseif item == 'Glass' then
		return 48
	elseif item == 'Grapes' then
		return 64
	elseif item == 'Concrete' then
		return 32
	elseif item == 'Materials' then
		return 38
	elseif item == 'Meth' then
		return 38
	elseif item == 'Oil' then
		return 32
	elseif item == 'Lumber' then
		return 26
	elseif item == 'Ore' then
		return 26
	elseif item == 'GPS' then
		return 3
	elseif item == 'Compass' then
		return 3
	elseif item == 'Engine-Kit' then
		return 1
	elseif item == 'Body-Kit' then
		return 5
	elseif item == 'Hotwire-Kit' then
		return 4
	elseif item == 'Morphine' then
		return 8
	elseif item == 'Bandage' then
		return 10
	elseif item == 'Adrenaline' then
		return 5
	elseif item == 'Lockpick' then
		return 15
	elseif item == 'Stolen-Cash' then
		return 20000
	end
end

function returnSlot(num)
	if num == 1 then
		return 'SLOT1'
	elseif num == 2 then
		return 'SLOT2'
	elseif num == 3 then
		return 'SLOT3'
	elseif num == 4 then
		return 'SLOT4'
	elseif num == 5 then
		return 'SLOT5'
	elseif num == 6 then
		return 'SLOT6'
	elseif num == 7 then
		return 'SLOT7'
	elseif num == 8 then
		return 'SLOT8'
	elseif num == 9 then
		return 'SLOT9'
	elseif num == 10 then
		return 'SLOT10'
	end
end

function getPrices(item)
	if item == 'Materials' then
		return 10
	else
		return 0
	end
end
