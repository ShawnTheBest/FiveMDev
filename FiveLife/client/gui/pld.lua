local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', }
local bigMap = 0.0
local walking = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local myPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(myPed)
		local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())

		if IsRadarHidden() == false and situation.type ~= "CUFFED" and situation.type ~= "GRABBED" and cameraActive == false then
			RequestStreamedTextureDict('overlay') while not HasStreamedTextureDictLoaded('overlay') do Citizen.Wait(0) end
			
			if not IsPedInAnyVehicle(myPed, false) then
				if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) and keyboardOpen == false then
					walking = true
				elseif walking then
					walking = false
				end
			elseif walking then
				walking = false
			end
			
			if stance.type == "HANDSUP" then
				DrawSprite("overlay", "stance_surrender_standing", 0.215+bigMap, 0.89, 0.05, 0.06, 0.0, 255, 255, 255, 255)
			elseif stance.type == "KNEEL_HANDSUP" then
				DrawSprite("overlay", "stance_surrender_kneeling1", 0.215+bigMap, 0.89, 0.05, 0.06, 0.0, 255, 255, 255, 255)
			elseif stance.type == "KNEEL_HANDSONHEAD" then
				DrawSprite("overlay", "stance_surrender_kneeling2", 0.215+bigMap, 0.89, 0.05, 0.06, 0.0, 255, 255, 255, 255)
			elseif stance.type == "PRONE" or stance.type == "LAYING_GIVEUP" or stance.type == "DEAD" or stance.type == "DEAD_CUFFED" or stance.type == "DRAGGED" then
				DrawSprite("overlay", "stance_prone", 0.215+bigMap, 0.89, 0.05, 0.06, 0.0, 255, 255, 255, 255)
			elseif walking then
				if stance.type == "CROUCH" or stance.type == "PRONE_RUN" then
					DrawSprite("overlay", "stance_crouch_walking", 0.215+bigMap, 0.89, 0.05, 0.06, 0.0, 255, 255, 255, 255)
				else
					DrawSprite("overlay", "stance_walking", 0.215+bigMap, 0.89, 0.05, 0.06, 0.0, 255, 255, 255, 255)
				end
			elseif stance.type == "CROUCH" then
				DrawSprite("overlay", "stance_crouch", 0.215+bigMap, 0.89, 0.05, 0.06, 0.0, 255, 255, 255, 255)
			else
				DrawSprite("overlay", "stance_idle", 0.215+bigMap, 0.89, 0.05, 0.06, 0.0, 255, 255, 255, 255)
			end
			
			if(GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z))then
				if(zones[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1)))then
					drawPLD(0.69+bigMap, 1.45, 1.0,1.0,0.4, "~y~" .. tostring(GetStreetNameFromHashKey(var1)) .. " ~w~/ ~y~" .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], 255, 255, 255, 255-(100-round(myPlayer.blood)))
				end
			end
			
			DrawRect(0.182+bigMap, 0.895, 0.01, 0.18, 0, 0, 0, 110)
			DrawRect(0.1815+bigMap, 0.895 + (0.0008 * (100.0 - myPlayer.blood)), 0.005, (0.0017 * myPlayer.blood), 200, 0, 0, 130)
			-- 0.0017 * myPlayer.blood
			-- 0.895 + (0.8 * (100.0 - myPlayer.blood))
			
			if NetworkIsPlayerTalking(PlayerId()) then
				drawTxt(0.69+bigMap, 1.42, 1.0,1.0,0.4, "~b~Voice: " .. currentVoip, 255, 255, 255, 255-(100-round(myPlayer.blood)))
			else
				drawTxt(0.69+bigMap, 1.42, 1.0,1.0,0.4, "~w~Voice: " .. currentVoip, 255, 255, 255, 255-(100-round(myPlayer.blood)))
			end
		end
		
		if IsControlJustPressed(1, 213) or IsDisabledControlJustPressed(1, 213) then -- HOME
			if bigMap == 0.0 then
				bigMap = 0.1
				SetRadarBigmapEnabled(true, false)
			else
				bigMap = 0.0
				SetRadarBigmapEnabled(false, false)
			end
		end
	end
end)

function drawPLD(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end