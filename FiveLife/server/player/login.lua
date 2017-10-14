
function loginUser(serverID)
	local steamID = GetPlayerIdentifiers(serverID)[1]
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		LoadPlayer(serverID)
		TriggerClientEvent("AwesomeGod", serverID, false)
		TriggerClientEvent("createTimer", serverID)
		TriggerClientEvent("UpdateRpName", serverID, result[1].rp_name)
		TriggerClientEvent("UpdateMoney", serverID, 'account', result[1].bank)
		TriggerClientEvent("UpdateMoney", serverID, 'cash', result[1].cash)
		TriggerClientEvent("UpdateJob", serverID, result[1].jobID)
		TriggerClientEvent("menu:openMenu", serverID, 1, 0)
		TriggerClientEvent("UpdateJobSpecificBlips", serverID, result[1].jobID)
		LoadLicenses(serverID, result[1].license)
		LoadInventory(serverID)
		LoadWeapons(serverID)
		checkPrison(serverID)
	end)
end

function LoadWeapons(serverID)
	local steamID = GetPlayerIdentifiers(serverID)[1]
	MySQL.Async.fetchAll('SELECT * FROM player_weapons WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		if result[1].molotov ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'molotov', result[1].molotov) end
		if result[1].baseball_bat ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'baseball_bat') end
		if result[1].crowbar ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'crowbar') end
		if result[1].hammer ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'hammer') end
		if result[1].flashlight ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'flashlight') end
		if result[1].pistol ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'pistol') end
		if result[1].combat_pistol ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'combat_pistol') end
		if result[1].sns_pistol ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'sns_pistol') end
		if result[1].vintage_pistol ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'vintage_pistol') end
		if result[1].pump_shotgun ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'pump_shotgun') end
		if result[1].sawnoff_shotgun ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'sawnoff_shotgun') end
		if result[1].heavy_shotgun ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'heavy_shotgun') end
		if result[1].assault_rifle ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'assault_rifle') end
		if result[1].ammo_pistol ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'ammo_pistol', result[1].ammo_pistol) end
		if result[1].ammo_shotgun ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'ammo_shotgun', result[1].ammo_shotgun) end
		if result[1].ammo_smg ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'ammo_smg', result[1].ammo_smg) end
		if result[1].ammo_rifle ~= 0 then TriggerClientEvent("UpdateWeapons", serverID, 'ammo_rifle', result[1].ammo_rifle) end
	end)
end

function LoadInventory(serverID)
	local steamID = GetPlayerIdentifiers(serverID)[1]
	MySQL.Async.fetchAll('SELECT * FROM player_inventory WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		local info = stringsplit(result[1].SLOT1, " ")
		if info[1] ~= 'Empty' then
			TriggerClientEvent("UpdateInventory", serverID, 'SLOT1', info[1], info[2])
			info = stringsplit(result[1].SLOT2, " ")
			if info[1] ~= 'Empty' then
				TriggerClientEvent("UpdateInventory", serverID, 'SLOT2', info[1], info[2])
				info = stringsplit(result[1].SLOT3, " ")
				if info[1] ~= 'Empty' then
					TriggerClientEvent("UpdateInventory", serverID, 'SLOT3', info[1], info[2])
					info = stringsplit(result[1].SLOT4, " ")
					if info[1] ~= 'Empty' then
						TriggerClientEvent("UpdateInventory", serverID, 'SLOT4', info[1], info[2])
						info = stringsplit(result[1].SLOT5, " ")
						if info[1] ~= 'Empty' then
							TriggerClientEvent("UpdateInventory", serverID, 'SLOT5', info[1], info[2])
							info = stringsplit(result[1].SLOT6, " ")
							if info[1] ~= 'Empty' then
								TriggerClientEvent("UpdateInventory", serverID, 'SLOT6', info[1], info[2])
								info = stringsplit(result[1].SLOT7, " ")
								if info[1] ~= 'Empty' then
									TriggerClientEvent("UpdateInventory", serverID, 'SLOT7', info[1], info[2])
									info = stringsplit(result[1].SLOT8, " ")
									if info[1] ~= 'Empty' then
										TriggerClientEvent("UpdateInventory", serverID, 'SLOT8', info[1], info[2])
										info = stringsplit(result[1].SLOT9, " ")
										if info[1] ~= 'Empty' then
											TriggerClientEvent("UpdateInventory", serverID, 'SLOT9', info[1], info[2])
											info = stringsplit(result[1].SLOT10, " ")
											if info[1] ~= 'Empty' then
												TriggerClientEvent("UpdateInventory", serverID, 'SLOT10', info[1], info[2])
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

function LoadLicenses(serverID, data)
	local split = stringsplit(data, ' ')
	local car = false
	local truck = false
	local handgun = false
	local rifle = false
	local homeowner = false
	local gang = false
	local rebel = false
	
	for i=1, 7, 1 do
		if split[i] ~= nil then
			if split[i] == 'car' then
				car = true
			elseif split[i] == 'truck' then
				truck = true
			elseif split[i] == 'handgun' then
				handgun = true
			elseif split[i] == 'rifle' then
				rifle = true
			elseif split[i] == 'homeowner' then
				homeowner = true
			elseif split[i] == 'gang' then
				gang = true
			elseif split[i] == 'rebel' then
				rebel = true
			end
		end
	end
	
	TriggerClientEvent("UpdateLicenses", serverID, car, truck, handgun, rifle, homeowner, gang, rebel)
end

function LoadPlayer(serverID)
	local steamID = GetPlayerIdentifiers(serverID)[1]
	local gender, shape1, shape2, skin1, skin2, shapeM, skinM, beard1, beard2, beard3, hair1, hair2, hair3, eyebrow1, eyebrow2, eye1
	local arm1, arm2, legs1, legs2, para1, para2, shoes1, shoes2, neck1, neck2, under1, under2, armor1, armor2, badges1, badges2, over1, over2, hat1, hat2, glasses1, glasses2, watches, tats
	MySQL.Async.fetchAll('SELECT * FROM player_model WHERE identifier = @steamID', {['@steamID'] = steamID}, function(result)
		local split = stringsplit(result[1].faceShape, ":")
		shape1 = split[1]
		shape2 = split[2]
		split = stringsplit(result[1].faceSkin, ":")
		skin1 = split[1]
		skin2 = split[2]
		shapeM = result[1].shapeMix
		skinM = result[1].skinMix
		split = stringsplit(result[1].beard, ":")
		beard1 = split[1]
		beard2 = split[2]
		beard3 = split[3]
		split = stringsplit(result[1].hair, ":")
		hair1 = split[1]
		hair2 = split[2]
		hair3 = split[3]
		split = stringsplit(result[1].eyebrows, ":")
		eyebrow1 = split[1]
		eyebrow2 = split[2]
		eye1 = result[1].head
		gender = result[1].gender
		split = stringsplit(result[1].armType, ":")
		arm1 = split[1]
		arm2 = split[2]
		split = stringsplit(result[1].legs, ":")
		legs1 = split[1]
		legs2 = split[2]
		split = stringsplit(result[1].parachute, ":")
		para1 = split[1]
		para2 = split[2]
		split = stringsplit(result[1].shoes, ":")
		shoes1 = split[1]
		shoes2 = split[2]
		split = stringsplit(result[1].neck, ":")
		neck1 = split[1]
		neck2 = split[2]
		split = stringsplit(result[1].underShirt, ":")
		under1 = split[1]
		under2 = split[2]
		split = stringsplit(result[1].armor, ":")
		armor1 = split[1]
		armor2 = split[2]
		split = stringsplit(result[1].badges, ":")
		badges1 = split[1]
		badges2 = split[2]
		split = stringsplit(result[1].overShirt, ":")
		over1 = split[1]
		over2 = split[2]
		split = stringsplit(result[1].hat, ":")
		hat1 = split[1]
		hat2 = split[2]
		split = stringsplit(result[1].glasses, ":")
		glasses1 = split[1]
		glasses2 = split[2]
		split = stringsplit(result[1].watches, ":")
		watches = split[1]
		split = stringsplit(result[1].tattoos, ":")
		tats = split[1]
		
		TriggerClientEvent("LoadBasics", serverID, gender, shape1, shape2, skin1, skin2, shapeM, skinM, beard1, beard2, beard3, hair1, hair2, hair3, eyebrow1, eyebrow2, eye1)
		TriggerClientEvent("LoadClothing", serverID, arm1, arm2, legs1, legs2, para1, para2, shoes1, shoes2, neck1, neck2, under1, under2, armor1, armor2, badges1, badges2, over1, over2, hat1, hat2, glasses1, glasses2, watches, tats)
	end)
end

function checkPrison(serverID)
	local steamID = GetPlayerIdentifiers(serverID)[1]
	for i=1, jailedPlayerCount do
		if jailedPlayers[i] ~= nil then
			if jailedPlayers[i]['Steam'] ~= nil then
				if jailedPlayers[i]['Steam'] == steamID then
					jailedPlayers[i]['ID'] = serverID
					TriggerClientEvent("AwesomeInvisible", serverID, false)
					TriggerClientEvent("AwesomeFreeze", serverID, false)
					TriggerClientEvent("jailPlayer", serverID, jailedPlayers[i]['Time'])
				end
			end
		end
	end
end
