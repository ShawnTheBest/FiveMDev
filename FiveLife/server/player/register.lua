
function hasAccount(source)
	local steamID = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchScalar('SELECT COUNT(1) FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(count)
		if tonumber(count) == 1 then
			return true
		else
			return false
		end
	end)
end

function saveKD(source)
	local username = GetPlayerName(source)
	--MySQL:executeQuery("UPDATE users SET kills='@newKD' WHERE username = '@username'",
    --{['@username'] = username, ['@newKD'] = Users[steamID[1]]['kills']})

	--MySQL:executeQuery("UPDATE users SET deaths='@newKD' WHERE username = '@username'",
    --{['@username'] = username, ['@newKD'] = Users[steamID[1]]['deaths']})
end

function registerUser(source, rpName)
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	local rp_name = rpName
	MySQL.Async.fetchScalar('SELECT COUNT(1) FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(count)
		if tonumber(count) == 1 then
			-- Has Account, don't register
		else
			local username = GetPlayerName(serverID)
			
			-- Inserting Default User Info
			MySQL.Async.execute("INSERT INTO users (`identifier`, `username`, `rp_name`, `groupID`, `jobID`, `bank`, `cash`, `license`, `banned`, `banreason`) VALUES (@steamID, @username, @rpName, '0', '0', '200', '100', 'none', '0', 'N/A')", {['@steamID'] = steamID, ['@username'] = username, ['@rpName'] = rp_name}, function() end)
			-- Inserting Default Player Model
			MySQL.Async.execute("INSERT INTO player_model (`identifier`, `gender`, `faceShape`, `faceSkin`, `shapeMix`, `skinMix`, `head`, `beard`, `hair`, `armType`, `legs`, `parachute`, `shoes`, `neck`, `underShirt`, `armor`, `badges`, `overShirt`, `hat`, `glasses`, `watches`, `eyebrows`, `tattoos`) VALUES (@steamID, 'male', '0:0', '0:0', '0.5', '0.5', '0:0', '0:0', '0:0', '0:0', '0:0', '0:0', '0:0', '0:0', '0:0', '0:0', '0:0', '0:0', '11:0', '0:0', '0:0', '0:0', '0:0')", {['@steamID'] = steamID}, function() end)
			-- Inseting Empty Inventory
			MySQL.Async.execute("INSERT INTO player_inventory (`identifier`, `SLOT1`, `SLOT2`, `SLOT3`, `SLOT4`, `SLOT5`, `SLOT6`, `SLOT7`, `SLOT8`, `SLOT9`, `SLOT10`) VALUES (@steamID, 'Empty 0', 'Empty 0', 'Empty 0', 'Empty 0', 'Empty 0', 'Empty 0', 'Empty 0', 'Empty 0', 'Empty 0', 'Empty 0')", {['@steamID'] = steamID}, function() end)
			-- Inseting Default Weapons
			MySQL.Async.execute("INSERT INTO player_weapons (`identifier`, `molotov`, `baseball_bat`, `crowbar`, `hammer`, `pistol`, `combat_pistol`, `sns_pistol`, `vintage_pistol`, `pump_shotgun`, `sawnoff_shotgun`, `micro_smg`, `assault_rifle`, `carbine_rifle`, `heavy_shotgun`, `flashlight`, `ammo_pistol`, `ammo_shotgun`, `ammo_smg`, `ammo_rifle`) VALUES (@steamID, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')", {['@steamID'] = steamID}, function() end)
			
			Users[steamID].username = username
			Users[steamID].rp_name = rp_name
			Users[steamID].groupID = 0
			Users[steamID].jobID = 0
			Users[steamID].serverID = serverID

			TriggerClientEvent("UpdateMoney", serverID, 'account', 200)
			TriggerClientEvent("UpdateMoney", serverID, 'cash', 100)
			TriggerClientEvent("menu:openMenu", serverID, 5, 0)
			TriggerClientEvent("LoadClothing", serverID, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			TriggerClientEvent("AwesomeInvisible", serverID, false)
			TriggerClientEvent("AwesomeFreeze", serverID, false)
			TriggerClientEvent("playerCreationTele", serverID)
		end
	end)
end