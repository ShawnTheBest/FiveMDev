--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local mdt = {show = false, state = "MAIN", page = 1, button = 1, row = 0, input = 0, currentCall = 0}
local myInfo = {}
local color = {r = 255, b = 255, g = 255}
local callMax = 0
local unitMax = 0
local shownCalls = 0
local shownUnits = 0
local line = 1
local fontID

local debug_selectionY = 0.5
local debug_textY = 0.4
local debug_textX = 0.4

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local area = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
		if area ~= nil then
			if myInfo.Location ~= area then
				TriggerServerEvent("updateUnitInfo", "location", area)
				myInfo.Location = area
				if myInfo.Status == "10-11" or myInfo.Status == "10-23" then
					ShowNotification("~g~Update your MDT Status!")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	RegisterFontFile('LSANS')
    fontID = RegisterFontId('Lucida Sans')
	while true do
		Citizen.Wait(1)
		if onDuty ~= 0 and onDuty < 5 then
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
				local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				if GetVehicleClass(vehicle) == 18 or IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
					if keyboardOpen == false then
						if IsControlJustPressed(0, 47) or IsDisabledControlJustPressed(0, 47) then -- G
							mdt.show = not mdt.show
							if mdt.show then
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							else
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
						end
					end
				end
				
				if mdt.show then
					if mdt.input ~= 0 then
						checkMDTKeyboard()
					end
					showMDT()
					
					if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- Up Arrow
						if mdt.state == "CALLS" then
							if mdt.page == 1 then
								if mdt.row > 1 then
									mdt.row = mdt.row - 1
									PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								end
							end
						elseif mdt.state == "UNITS" then
							if mdt.row > 1 then
								mdt.row = mdt.row - 1
								PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
						end
					elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- Down Arrow
						if mdt.state == "CALLS" then
							if mdt.page == 1 then
								if mdt.row < shownCalls-1 then
									mdt.row = mdt.row + 1
									PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								end
							end
						elseif mdt.state == "UNITS" then
							if mdt.row < shownUnits-1 then
								mdt.row = mdt.row + 1
								PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
						end
					elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- Left Arrow
						if mdt.state == "MAIN" then
							if mdt.button > 1 then
								mdt.button = mdt.button - 1
								PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
						elseif mdt.state == "UNITS" then
							if mdt.page > 1 then
								mdt.page = mdt.page - 1
								PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							else
								mdt.page = 4
								PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
						end
					elseif IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- Right Arrow
						if mdt.state == "MAIN" then
							if mdt.button < 3 then
								mdt.button = mdt.button + 1
								PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
						elseif mdt.state == "UNITS" then
							if mdt.page < 4 then
								mdt.page = mdt.page + 1
								PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							else
								mdt.page = 1
								PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
						end
					elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
						if mdt.state == "MAIN" then
							if mdt.button == 1 then
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								mdt.state = "CALLS"
								mdt.page = 1
								if shownCalls > 1 then mdt.row = 1 else mdt.row = 0 end
							elseif mdt.button == 2 then
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								-- mdt.state = "DATABASE"
								ShowNotification("Database under construction")
							elseif mdt.button == 3 then
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								mdt.state = "UNITS"
								mdt.row = 1
								if onDuty == 1 then
									mdt.page = 1
								elseif onDuty == 2 then
									mdt.page = 4
								elseif onDuty == 3 then
									mdt.page = 2
								elseif onDuty == 4 then
									mdt.page = 3
								end
							end
						elseif mdt.state == "CALLS" then
							if mdt.page == 1 then
								if mdt.row > 0 then
									if shownCalls > 1 then
										PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
										mdt.page = 2
										getCallNumber(mdt.row)
									end
								end
							elseif mdt.page == 2 then
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								SetNewWaypoint(emergencyCalls[mdt.currentCall]['posX'], emergencyCalls[mdt.currentCall]['posY'])
								TriggerServerEvent("updateUnitInfo", "status", "10-76")
								TriggerServerEvent("updateUnitInfo", "notes", "REPORT - " .. mdt.currentCall)
								TriggerEvent('checkOnScene', emergencyCalls[mdt.currentCall]['posX'], emergencyCalls[mdt.currentCall]['posY'], emergencyCalls[mdt.currentCall]['posZ'], emergencyCalls[mdt.currentCall]['area'])
								mdt.page = 1
								mdt.state = "MAIN"
								mdt.show = false
							end
						elseif mdt.state == "UNITS" then
							if mdt.input == 0 then
								if isUnitMe(mdt.row) then
									PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
									mdt.input = 1
									keyboardOpen = true
									myInfo.Notes = getUnitInfoAtRow("NOTES", mdt.row)
									DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
								else
									PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
									setWaypointToUnit(mdt.row)
								end
							end
						end
					elseif IsControlJustPressed(1, 202) or IsDisabledControlJustPressed(1, 202) then -- Backspace
						if mdt.state == "MAIN" then
							PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							mdt.show = false
							mdt.input = 0
							mdt.row = 1
							mdt.button = 1
						elseif mdt.state == "CALLS" then
							if mdt.page == 2 then
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								mdt.page = 1
							elseif mdt.page == 1 then
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								mdt.state = "MAIN"
								mdt.row = 1
								mdt.button = 1
							end
						elseif mdt.state == "UNITS" then
							if mdt.input == 0 then
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								mdt.state = "MAIN"
								mdt.row = 1
								mdt.button = 3
							end
						end
					elseif IsControlJustPressed(1, 178) or IsDisabledControlJustPressed(1, 178) then -- Delete
						if mdt.state == "CALLS" then
							if mdt.row > 0 and shownCalls > 1 then
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								removeCall(mdt.row)
								mdt.page = 1
							end
						elseif mdt.state == "UNITS" then
							if mdt.input == 0 then
								mdt.input = 2
								keyboardOpen = true
								PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
							end
						end
					end
				end
			elseif mdt.show ~= false then
				mdt.show = false
				mdt.input = 0
			end
		end
	end
end)

function showMDT()
	RequestStreamedTextureDict("police", true)
	while not HasStreamedTextureDictLoaded("police") do
		Citizen.Wait(1)
	end
	if tonumber(newTime.m) < 10 then drawMdtText(0.5, 0.183, 0.27, newTime.h .. ":0".. newTime.m, 255, 255, 255, 255, 1) else drawMdtText(0.5, 0.183, 0.27, newTime.h .. ":".. newTime.m, 255, 255, 255, 255, 1) end
	
	if mdt.state == "MAIN" then
		DrawSprite("police", "base_main", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		if mdt.button == 1 then
			DrawSprite("police", "base_main_button1", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif mdt.button == 2 then
			DrawSprite("police", "base_main_button2", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif mdt.button == 3 then
			DrawSprite("police", "base_main_button3", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		end
		if onDuty == 1 then
			DrawSprite("police", "base_main_LS", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif onDuty == 2 then
			DrawSprite("police", "base_main_DOC", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif onDuty == 3 then
			DrawSprite("police", "base_main_SA", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif onDuty == 4 then
			DrawSprite("police", "base_main_EMS", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		end
	elseif mdt.state == "CALLS" then
		if onDuty == 1 then
			DrawSprite("police", "base_secondary_LS", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif onDuty == 2 then
			DrawSprite("police", "base_secondary_DOC", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif onDuty == 3 then
			DrawSprite("police", "base_secondary_SA", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif onDuty == 4 then
			DrawSprite("police", "base_secondary_EMS", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		end
		if mdt.page == 1 then
			DrawSprite("police", "overlay_calls", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
			showCalls()
			showMDTSelection()
		elseif mdt.page == 2 then
			DrawSprite("police", "overlay_calls_info", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
			showCallInfo()
		end
	elseif mdt.state == "UNITS" then
		if mdt.page == 1 then
			DrawSprite("police", "base_secondary_LS", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif mdt.page == 2 then
			DrawSprite("police", "base_secondary_SA", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif mdt.page == 3 then
			DrawSprite("police", "base_secondary_EMS", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		elseif mdt.page == 4 then
			DrawSprite("police", "base_secondary_DOC", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		end
		DrawSprite("police", "overlay_units", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		if isUnitMe(mdt.row) then
			DrawSprite("police", "overlay_units_status", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		else
			DrawSprite("police", "overlay_units_goto", 0.5,0.5, 0.75,0.75, 0.0, 255, 255, 255, 255)
		end
		showUnits()
		showMDTSelection()
	end
end

function setWaypointToUnit(row)
	if getUnitInfoAtRow("ID", row) ~= nil then
		local serverID = getUnitInfoAtRow("ID", row)
		local serverPed = GetPlayerPed(GetPlayerFromServerId(serverID))
		local coords = GetEntityCoords(serverPed, true)
		SetNewWaypoint(coords.x, coords.y)
	end
end

function isUnitMe(row)
	if onDuty == 1 then
		if mdt.page ~= 1 then
			return false
		end
	elseif onDuty == 2 then
		if mdt.page ~= 4 then
			return false
		end
	elseif onDuty == 3 then
		if mdt.page ~= 2 then
			return false
		end
	elseif onDuty == 4 then
		if mdt.page ~= 3 then
			return false
		end
	end
	
	local serverID = getUnitInfoAtRow("ID", row)
	local serverPed = GetPlayerPed(GetPlayerFromServerId(serverID))
	if serverPed == GetPlayerPed(-1) then
		return true
	else
		return false
	end
end

function showCalls()
	local offset = 0.035
	shownCalls = 1
	for i=1, 500 do
		if shownCalls < 13 then
			if emergencyCalls[i] ~= nil then
				offset = 0.035*shownCalls
				drawMdtText(0.192, 0.261+offset, 0.3, "".. i, 255, 255, 255, 255, 1)
				drawMdtText(0.407, 0.261+offset, 0.3, string.upper("" .. emergencyCalls[i]['area']), 255, 255, 255, 255, 1)
				drawMdtText(0.666, 0.261+offset, 0.3, "" .. emergencyCalls[i]['type'], 255, 255, 255, 255, 1)
				drawMdtText(0.787, 0.261+offset, 0.3, "" .. emergencyCalls[i]['time'], 255, 255, 255, 255, 1)
				shownCalls = shownCalls + 1
			end
		else
			return
		end
	end
end

function showCallInfo()
	drawMdtText2(0.275, 0.32, 0.3, "" .. mdt.currentCall, 255, 255, 255, 255, 0.2, 0.8)
	drawMdtText2(0.625, 0.32, 0.3, "" .. emergencyCalls[mdt.currentCall]['type'], 255, 255, 255, 255, 0.2, 0.8)
	drawMdtText2(0.625, 0.358, 0.3, "" .. emergencyCalls[mdt.currentCall]['time'], 255, 255, 255, 255, 0.2, 0.8)
	drawMdtText2(0.255, 0.358, 0.3, "" .. string.upper(emergencyCalls[mdt.currentCall]['area']), 255, 255, 255, 255, 0.2, 0.8)
	drawMdtText2(0.21, 0.49, 0.3, "" .. string.upper(emergencyCalls[mdt.currentCall]['text']), 255, 255, 255, 255, 0.21, 0.75)
end

function getCallNumber(row)
	local rowNumber = 1
	for i=1, 500 do
		if emergencyCalls[i] ~= nil then
			if rowNumber == row then
				mdt.currentCall = i
				return
			end
			rowNumber = rowNumber + 1
		end
	end
end

function removeCall(row)
	local rowNumber = 1
	for i=1, 500 do
		if emergencyCalls[i] ~= nil then
			if rowNumber == row then
				emergencyCalls[i] = nil
				shownCalls = shownCalls - 1
				if mdt.row ~= 1 then
					if shownCalls-1 > mdt.row then
						-- Nothing
					elseif shownCalls-1 < mdt.row then
						mdt.row = mdt.row - 1
					end
				elseif mdt.row == 1 then
					if shownCalls > 1 then
						-- Nothing
					else
						mdt.row = 0
					end
				end
				return
			end
			rowNumber = rowNumber + 1
		end
	end
end

function showUnits()
	local offset = 0.035
	shownUnits = 1

	for i=1, 12 do 
		if mdt.page == 1 then
			if lspdUnits[i] ~= nil then
				offset = 0.035*shownUnits
				setStatusColor(lspdUnits[i].Status)
				drawMdtText(0.197, 0.261+offset, 0.3, "" .. string.upper(lspdUnits[i].Unit), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.297, 0.261+offset, 0.3, "" .. string.upper(lspdUnits[i].Status), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.480, 0.261+offset, 0.3, "" .. string.upper(lspdUnits[i].Location), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.712, 0.261+offset, 0.3, "" .. string.upper(lspdUnits[i].Notes), color.r, color.b, color.g, 255, 1)
				shownUnits = shownUnits + 1
			end
		elseif mdt.page == 2 then
			if saspUnits[i] ~= nil then
				offset = 0.035*shownUnits
				setStatusColor(saspUnits[i].Status)
				drawMdtText(0.197, 0.261+offset, 0.3, "" .. string.upper(saspUnits[i].Unit), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.297, 0.261+offset, 0.3, "" .. string.upper(saspUnits[i].Status), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.480, 0.261+offset, 0.3, "" .. string.upper(saspUnits[i].Location), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.712, 0.261+offset, 0.3, "" .. string.upper(saspUnits[i].Notes), color.r, color.b, color.g, 255, 1)
				shownUnits = shownUnits + 1
			end
		elseif mdt.page == 3 then
			if medicUnits[i] ~= nil then
				offset = 0.035*shownUnits
				setStatusColor(medicUnits[i].Status)
				drawMdtText(0.197, 0.261+offset, 0.3, "" .. string.upper(medicUnits[i].Unit), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.297, 0.261+offset, 0.3, "" .. string.upper(medicUnits[i].Status), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.480, 0.261+offset, 0.3, "" .. string.upper(medicUnits[i].Location), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.712, 0.261+offset, 0.3, "" .. string.upper(medicUnits[i].Notes), color.r, color.b, color.g, 255, 1)
				shownUnits = shownUnits + 1
			end
		elseif mdt.page == 4 then
			if docUnits[i] ~= nil then
				offset = 0.035*shownUnits
				setStatusColor(docUnits[i].Status)
				drawMdtText(0.197, 0.261+offset, 0.3, "" .. string.upper(docUnits[i].Unit), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.297, 0.261+offset, 0.3, "" .. string.upper(docUnits[i].Status), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.480, 0.261+offset, 0.3, "" .. string.upper(docUnits[i].Location), color.r, color.b, color.g, 255, 1)
				drawMdtText(0.712, 0.261+offset, 0.3, "" .. string.upper(docUnits[i].Notes), color.r, color.b, color.g, 255, 1)
				shownUnits = shownUnits + 1
			end
		end
	end
end

function getUnitInfoAtRow(info, row)
	local rowNumber = 1
	if mdt.page == 1 then
		for i=1, 10 do 
			if lspdUnits[i] ~= nil then
				if rowNumber == row then
					if info == "ID" then
						return lspdUnits[i].ID
					elseif info == "NOTES" then
						return lspdUnits[i].Notes
					end
				end
				rowNumber = rowNumber + 1
			end
		end
	elseif mdt.page == 2 then
		for i=1, 12 do 
			if saspUnits[i] ~= nil then
				if rowNumber == row then
					if info == "ID" then
						return saspUnits[i].ID
					elseif info == "NOTES" then
						return saspUnits[i].Notes
					end
				end
				rowNumber = rowNumber + 1
			end
		end
	elseif mdt.page == 3 then
		for i=1, 7 do 
			if medicUnits[i] ~= nil then
				if rowNumber == row then
					if info == "ID" then
						return medicUnits[i].ID
					elseif info == "NOTES" then
						return medicUnits[i].Notes
					end
				end
				rowNumber = rowNumber + 1
			end
		end
	elseif mdt.page == 4 then
		for i=1, 5 do 
			if docUnits[i] ~= nil then
				if rowNumber == row then
					if info == "ID" then
						return docUnits[i].ID
					elseif info == "NOTES" then
						return docUnits[i].Notes
					end
				end
				rowNumber = rowNumber + 1
			end
		end
	end
	return nil
end

function checkMDTKeyboard()
	HideHudAndRadarThisFrame()
	if UpdateOnscreenKeyboard() == 3 then
		mdt.input = 0
		keyboardOpen = false
	elseif UpdateOnscreenKeyboard() == 1 then
		local inputText = GetOnscreenKeyboardResult()
		if string.len(inputText) > 0 then
			if mdt.input == 1 then
				local pos = GetEntityCoords(GetPlayerPed(-1))
				local area = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
				if area ~= nil then
					myInfo.Location = area
				end
				myInfo.Status = inputText
				TriggerServerEvent("updateUnitInfo", "location", myInfo.Location)
				TriggerServerEvent("updateUnitInfo", "status", inputText)
				if inputText == "10-8" and string.sub(myInfo.Notes, 1, 6) == "REPORT" then
					TriggerServerEvent("updateUnitInfo", "notes", "CLEAR")
				end
			elseif mdt.input == 2 then
				TriggerServerEvent("updateUnitInfo", "notes", inputText)
			end
			mdt.input = 0
			keyboardOpen = false
		else
			DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 128)
		end
	elseif UpdateOnscreenKeyboard() == 2 then
		mdt.input = 0
		keyboardOpen = false
	end
end

function setStatusColor(status)
	if status == "10-8" or status == "SIGNAL 11" then
		color.r = 0 color.b = 155 color.g = 33
	elseif status == "10-76" or status == "10-6" or status == "10-11" or status == "10-19" then
		color.r = 234 color.b = 222 color.g = 0
	elseif status == "10-23" or status == "10-7" or status == "10-50" then
		color.r = 173 color.b = 26 color.g = 0
	else
		color.r = 255 color.b = 255 color.g = 255
	end
end

function showMDTSelection()
	if mdt.row ~= 0 then
		local rowOffset = 0.035*mdt.row
		DrawSprite("police", "overlay_selection", 0.5, 0.465+rowOffset, 0.75,0.75, 0.0, 255, 255, 255, 255)
	end
end

function drawMdtText(x, y, scale, text, r, g, b, a, centered)
    SetTextFont(fontID)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
	SetTextCentre(centered)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y+0.005)
end

function drawMdtText2(x, y, scale, text, r, g, b, a, wrapLeft, wrapRight)
    SetTextFont(fontID)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
	SetTextWrap(wrapLeft, wrapRight)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y+0.005)
end
