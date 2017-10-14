--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================


-- Vehicle Garage
RegisterServerEvent("AddToGarage")
AddEventHandler("AddToGarage", function(model, inGarage, plate, color)
	local steamID = GetPlayerIdentifiers(source)[1]
	MySQL.Async.execute("INSERT INTO garage (`identifier`, `vehicle`, `inGarage`, `plate`, `colorp`, `colors`, `armor`, `engine`, `transmission`, `brakes`, `tint`, `platetype`, `wheeltype`, `wheel`, `spoiler`, `fbumper`, `rbumper`, `skirt`, `grille`, `hood`, `roof`) VALUES (@steamID, @model, @garage, @plate, @color, @color, 0, -1, -1, -1, -1, 3, 0, -1, -1, -1, -1, -1, -1, -1, -1)", {['@steamID'] = steamID, ['@model'] = model, ['@garage'] = inGarage, ['@plate'] = plate, ['@color'] = color}, function() end)
end)

RegisterServerEvent("GetGarageVehicles")
AddEventHandler("GetGarageVehicles", function()
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	MySQL.Async.fetchScalar("SELECT COUNT(*) FROM garage where identifier = @steamID AND inGarage = 'true'", {['@steamID'] = steamID}, function(result2)
		local count = tonumber(result2)
		if count > 0 then
			MySQL.Async.fetchAll("SELECT * FROM garage WHERE identifier = @steamID AND inGarage = 'true'", {['@steamID'] = steamID}, function(result)
				if count > 1 then
					if count > 2 then
						if count > 3 then
							if count > 4 then
								if count > 5 then
									if count > 6 then
										if count > 7 then
											if count > 8 then
												if count > 9 then
													TriggerClientEvent("LoadGarage", serverID, result[1].vehicle, result[1].plate, result[2].vehicle, result[2].plate, result[3].vehicle, result[3].plate, result[4].vehicle, result[4].plate, result[5].vehicle, result[5].plate, result[6].vehicle, result[6]['plate'], result[7].vehicle, result[7].plate, result[8].vehicle, result[8].plate, result[9].vehicle, result[9].plate, result[10].vehicle, result[10].plate)
												else
													TriggerClientEvent("LoadGarage", serverID, result[1].vehicle, result[1].plate, result[2].vehicle, result[2].plate, result[3].vehicle, result[3].plate, result[4].vehicle, result[4].plate, result[5].vehicle, result[5].plate, result[6].vehicle, result[6].plate, result[7].vehicle, result[7].plate, result[8].vehicle, result[8].plate, result[9].vehicle, result[9].plate, 'none', 'null')
												end
											else
												TriggerClientEvent("LoadGarage", serverID, result[1].vehicle, result[1].plate, result[2].vehicle, result[2].plate, result[3].vehicle, result[3].plate, result[4].vehicle, result[4].plate, result[5].vehicle, result[5].plate, result[6].vehicle, result[6].plate, result[7].vehicle, result[7].plate, result[8].vehicle, result[8].plate, 'none', 'null', 'none', 'null')
											end
										else
											TriggerClientEvent("LoadGarage", serverID, result[1].vehicle, result[1].plate, result[2].vehicle, result[2].plate, result[3].vehicle, result[3].plate, result[4].vehicle, result[4].plate, result[5].vehicle, result[5].plate, result[6].vehicle, result[6].plate, result[7].vehicle, result[7].plate, 'none', 'null', 'none', 'null', 'none', 'null')
										end
									else
										TriggerClientEvent("LoadGarage", serverID, result[1].vehicle, result[1].plate, result[2].vehicle, result[2].plate, result[3].vehicle, result[3].plate, result[4].vehicle, result[4].plate, result[5].vehicle, result[5].plate, result[6].vehicle, result[6].plate, 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null')
									end
								else
									TriggerClientEvent("LoadGarage", serverID, result[1].vehicle, result[1].plate, result[2].vehicle, result[2].plate, result[3].vehicle, result[3].plate, result[4].vehicle, result[4].plate, result[5].vehicle, result[5].plate, 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null')
								end
							else
								TriggerClientEvent("LoadGarage", serverID, result[1].vehicle, result[1].plate, result[2].vehicle, result[2].plate, result[3].vehicle, result[3].plate, result[4].vehicle, result[4].plate, 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null')
							end
						else
							TriggerClientEvent("LoadGarage", serverID, result[1].vehicle, result[1].plate, result[2].vehicle, result[2].plate, result[3].vehicle, result[3].plate, 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null')
						end
					else
						TriggerClientEvent("LoadGarage", serverID, result[1].vehicle, result[1].plate, result[2].vehicle, result[2].plate, 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null')
					end
				else
					TriggerClientEvent("LoadGarage", serverID, result[1].vehicle, result[1].plate, 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null')
				end
			end)
		else
			TriggerClientEvent("LoadGarage", serverID, 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null', 'none', 'null')
		end
	end)
end)

RegisterServerEvent("GetVehicleInfo")
AddEventHandler("GetVehicleInfo", function(vehicle, plate)
	local steamID = GetPlayerIdentifiers(source)[1]
	local serverID = source
	MySQL.Async.fetchAll("SELECT * FROM garage WHERE identifier = @steamID AND inGarage = 'true' AND plate = @plate", {['@steamID'] = steamID, ['@plate'] = plate}, function(result)
		TriggerClientEvent("LoadVehicleInfo", serverID, result[1].vehicle, result[1].plate, result[1].colorp, result[1].colors, result[1].engine, result[1].transmission, result[1].brakes, result[1].tint, result[1].wheeltype, result[1].wheel, result[1].spoiler, result[1].fbumper, result[1].rbumper, result[1].skirt, result[1].grille, result[1].hood, result[1].roof)
	end)
end)

RegisterServerEvent("SaveVehicleMods")
AddEventHandler("SaveVehicleMods", function(plate, color1, color2, transmission, brakes, tint, platetype, wheeltype, wheel, spoiler, fbumper, rbumper, skirt, grille, hood, roof)
	local steamID = GetPlayerIdentifiers(source)[1]
	MySQL.Async.execute("UPDATE garage SET colorp=@color1, colors=@color2, transmission=@transmission, brakes=@brakes, tint=@tint, wheeltype=@wheeltype, wheel=@wheel, spoiler=@spoiler, fbumper=@fbumper, rbumper=@rbumper, skirt=@skirt, grille=@grille, hood=@hood, roof=@roof WHERE plate = @plate", 
	{['@steamID'] = steamID, ['@plate'] = plate, ['@color1'] = color1, ['@color2'] = color2, ['@transmission'] = transmission, ['@brakes'] = brakes, ['@tint'] = tint, ['@wheeltype'] = wheeltype, ['@wheel'] = wheel, ['@spoiler'] = spoiler, ['@fbumper'] = fbumper, ['@rbumper'] = rbumper, ['@skirt'] = skirt, ['@grille'] = grille, ['@hood'] = hood, ['@roof'] = roof}, function() end)
end)

RegisterServerEvent("ReturnVehicle")
AddEventHandler("ReturnVehicle", function(plate)
	MySQL.Async.execute("UPDATE garage SET inGarage = 'true' WHERE plate = @plate", {['@plate'] = plate}, function() end)
end)

RegisterServerEvent("RemoveFromGarage")
AddEventHandler("RemoveFromGarage", function(plate)
	MySQL.Async.execute("UPDATE garage SET inGarage = 'false' WHERE plate = @plate", {['@plate'] = plate}, function() end)
end)

-- Player Clothing
RegisterServerEvent("savePlayerBasics")
AddEventHandler("savePlayerBasics", function(pGender, pFaceShape, pFaceSkin, pShapeMix, pSkinMix, pBeard, pHair, pEyebrows, pEyes)
	local steamID = GetPlayerIdentifiers(source)[1]
	MySQL.Async.execute("UPDATE player_model SET gender=@gender, faceShape=@faceShape, faceSkin=@faceSkin, shapeMix=@shapeMix, skinMix=@skinMix, beard=@beard, hair=@hair, eyebrows=@eyebrows, head=@eyes WHERE identifier = @steamID",
	{['@steamID'] = steamID, ['@gender'] = pGender, ['@faceShape'] = pFaceShape, ['@faceSkin'] = pFaceSkin, ['@shapeMix'] = pShapeMix, ['@skinMix'] = pSkinMix, ['@beard'] = pBeard, ['@hair'] = pHair, ['@eyebrows'] = pEyebrows, ['@eyes'] = pEyes}, function() end)
end)

RegisterServerEvent("savePlayerClothes")
AddEventHandler("savePlayerClothes", function(pArm, pLegs, pPara, pShoes, pNeck, pUnder, pArmor, pBadges, pOver, pHat, pGlasses, pWatches, pTats)
	local steamID = GetPlayerIdentifiers(source)[1]
	MySQL.Async.execute("UPDATE player_model SET armType=@armType, legs=@legs, parachute=@parachute, shoes=@shoes, neck=@neck, undershirt=@undershirt, armor=@armor, badges=@badges, overShirt=@overShirt, hat=@hat, glasses=@glasses, watches=@watches, tattoos=@tattoos WHERE identifier = @steamID",
	{['@steamID'] = steamID, ['@armType'] = pArm, ['@legs'] = pLegs, ['@parachute'] = pPara, ['@shoes'] = pShoes, ['@neck'] = pNeck, ['@skinMix'] = pSkinMix, ['@undershirt'] = pUnder, ['@armor'] = pArmor, ['@badges'] = pBadges, ['@overShirt'] = pOver, ['@hat'] = pHat, ['@glasses'] = pGlasses, ['@watches'] = pWatches, ['@tattoos'] = pTats}, function() end)
end)

