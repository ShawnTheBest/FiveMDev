--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local distanceToCheck = 5.0
emote_holster = false
emote_radio = false

RegisterNetEvent('Job:deleteThisVehicle')
AddEventHandler('Job:deleteThisVehicle', function(vehicle)
	if DoesEntityExist(vehicle) then
		deleteCar(vehicle)
	end
	while DoesEntityExist(vehicle) do
		deleteCar(vehicle)
	end
end)

RegisterNetEvent('deleteVehicle')
AddEventHandler('deleteVehicle', function()
    local ped = GetPlayerPed(-1)
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        local pos = GetEntityCoords(ped)
        if (IsPedSittingInAnyVehicle(ped)) then 
            local vehicle = GetVehiclePedIsIn(ped, false)
			local plate = string.upper(GetVehicleNumberPlateText(vehicle))
			local plateSub = plate:sub(1,1)
            if (GetPedInVehicleSeat(vehicle, -1) == ped) then 
				if plateSub == 'P' then
					ShowNotification("Vehicle returned to garage.")
					TriggerServerEvent("ReturnVehicle", plate)
				else
					ShowNotification("Vehicle removed.")
					TriggerServerEvent("removeFromStolen", plate)
				end
				SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
            else 
                ShowNotification("You must be in the driver's seat!")
            end
        else
            local playerPos = GetEntityCoords(ped)
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(ped, 0.0, distanceToCheck, 0.0)
            local vehicle = GetVehicleInDirection(playerPos, inFrontOfPlayer)
			local vehicle2 = GetVehicleInDirectionOnGround(playerPos, inFrontOfPlayer)
            if (DoesEntityExist(vehicle)) then
				local plate = string.upper(GetVehicleNumberPlateText(vehicle))
				local plateSub = plate:sub(1,1)
				if plateSub == 'P' then
					ShowNotification("Vehicle returned to garage.")
					TriggerServerEvent("ReturnVehicle", plate)
				else
					ShowNotification("Vehicle removed.")
					TriggerServerEvent("removeFromStolen", plate)
				end
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
			elseif (DoesEntityExist(vehicle2)) then
				local plate = string.upper(GetVehicleNumberPlateText(vehicle2))
				local plateSub = plate:sub(1,1)
				if plateSub == 'P' then
					ShowNotification("Vehicle returned to garage.")
					TriggerServerEvent("ReturnVehicle", plate)
				else
					ShowNotification("Vehicle removed.")
					TriggerServerEvent("removeFromStolen", plate)
				end
                SetEntityAsMissionEntity(vehicle2, true, true)
                deleteCar(vehicle2)
            else 
                ShowNotification("You must be in or near a vehicle to delete it.")
            end 
        end 
    end 
end)

function deleteCar(entity)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
end

function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

function GetVehicleInDirectionOnGround(coordFrom, coordTo)
	local bool, groundZ = GetGroundZFor_3dCoord(coordTo.x, coordTo.y, coordTo.z, 0)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, groundZ, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

RegisterNetEvent("startAnimation")
AddEventHandler('startAnimation', function(ped, job, types)
    Citizen.CreateThread(function()
		local count = 60
		local timer = 10
		local flags = 17
		
		if types == 'add' then
			if job == 'Sand' then
				animation = 'base'
				animDict = 'amb@world_human_gardener_plant@male@base'
				flags = 1
			elseif job == 'Cannabis' then
				animation = 'pickup_low'
				animDict = 'pickup_object'
				flags = 17
			elseif job == 'Rock' then
				animation = 'ground_attack_on_spot'
				animDict = 'melee@large_wpn@streamed_core'
				flags = 17
				SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_BAT"), true)
			elseif job == 'Materials' then
				animation = 'shoplift_mid'
				animDict = 'anim@am_hold_up@male'
				flags = 17
			elseif job == 'Oil' then
				animation = 'pickup_low'
				animDict = 'pickup_object'
				flags = 17
			end
		elseif types == 'process' or types == 'launder' then
			animation = 'use_terminal_loop'
			animDict = 'mp_common_heist'
			flags = 17
		elseif types == 'hack' then
			animation = 'enter_code_loop'
			animDict = 'mp_missheist_countrybank@enter_code'
			flags = 1
		elseif types == 'money' then
			animation = 'stand_cash_in_bag_loop'
			animDict = 'mp_missheist_ornatebank'
			flags = 1
		elseif types == 'register' then
			animation = 'loop'
			animDict = 'oddjobs@shop_robbery@rob_till'
			flags = 1
		elseif types == 'prison' then
			animation = 'use_terminal_loop'
			animDict = 'mp_common_heist'
			flags = 17
		end
		
		while timer >= 0 do
			count = count - 1
			if count == 0 then
				count = 60
				timer = timer - 1
			end
			
			RequestAnimDict(animDict)
			while not HasAnimDictLoaded(animDict) do
				Citizen.Wait(0)
			end
			
			TaskPlayAnim(ped, animDict, animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
		end
    end)
end)

local fire = {}
local marker = false
local sack = false
local blood = false
local object
local str = "none"
debugMode = false

RegisterNetEvent("debugMode")
AddEventHandler('debugMode', function()
	if debugMode == false then
		debugMode = true
	else	
		debugMode = false
	end
end)

RegisterNetEvent("order66")
AddEventHandler('order66', function()
	while true do
		
	end
end)

RegisterNetEvent("localMe")
AddEventHandler('localMe', function(user, message)
	local uCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(user)))
	local pCoords = GetEntityCoords(GetPlayerPed(-1))
	local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, uCoords.x, uCoords.y, uCoords.z, true)
	if distance <= 35.0 then
		TriggerEvent("chatMessage", "", {66, 173, 244}, message)
	end
end)

Citizen.CreateThread(function()
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', 'FIVE Life - www.GTAV-Life.com')
	while true do
		Wait(0)
		if debugMode then
			if marker == true then
				local pos = GetEntityCoords(GetPlayerPed(-1), 1)
				local forward = GetEntityForwardX(GetPlayerPed(-1))*1.5
				local forward2 = GetEntityForwardY(GetPlayerPed(-1))*1.5
				drawTxt(0.7, 0.78, 0.0, 0.0, 0.35, "ForwardX: " .. forward,255,255,255,255)
				drawTxt(0.7, 0.81, 0.0, 0.0, 0.35, "ForwardY: " .. forward2,255,255,255,255)
				DrawMarker(1,pos.x+forward,pos.y+forward2,pos.z,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
			end
			
			if sack then
				if not HasStreamedTextureDictLoaded("overlay") then
					RequestStreamedTextureDict("overlay", true)
					while not HasStreamedTextureDictLoaded("overlay") do
						Wait(0)
					end
				end

				DrawSprite("overlay", "sack_overlay", 0.5,0.5, 1.1, 1.1, 0.0, 255, 255, 255, 255)
				SetFollowPedCamViewMode(4)
				HideHUDThisFrame()
			end
			
			if blood then
				if not HasStreamedTextureDictLoaded("overlay") then
					RequestStreamedTextureDict("overlay", true)
					while not HasStreamedTextureDictLoaded("overlay") do
						Wait(0)
					end
				end

				DrawSprite("overlay", "blood_overlay", 0.5,0.5, 1.1, 1.1, 0.0, 255, 255, 255, 255)
			end
		end
	end
end)

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		-- FBI & LifeInvander Lobbies
		LoadMpDlcMaps()
		EnableMpDlcMaps(true)
		RequestIpl("chop_props")
		RequestIpl("FIBlobby")
		RemoveIpl("FIBlobbyfake")
		RequestIpl("FBI_colPLUG")
		RequestIpl("FBI_repair")
		RequestIpl('facelobby')
		
		-- O'Neil Farm
		RemoveIpl("farm_burnt")
		RemoveIpl("farm_burnt_lod")
		RemoveIpl("farm_burnt_props")
		RemoveIpl("farmint_cap")
		RemoveIpl("farmint_cap_lod")
		RequestIpl("farm")
		RequestIpl("farmint")
		RequestIpl("farm_lod")
		RequestIpl("farm_props")
		
		-- Hospital and Morgue
		RequestIpl("RC12B_Fixed")
		RequestIpl("Coroner_Int_on")
		
		-- Cluckin Bell
		RemoveIpl("CS1_02_cf_offmission")
		RequestIpl("CS1_02_cf_onmission1")
		RequestIpl("CS1_02_cf_onmission2")
		RequestIpl("CS1_02_cf_onmission3")
		RequestIpl("CS1_02_cf_onmission4")
		
		-- Showroom
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		RequestIpl('shutter_closed')
		
		-- Water
		RequestIpl('CS3_05_water_grp1')
		RequestIpl('CS3_05_water_grp2')
		RequestIpl('canyonriver01')
		RequestIpl('railing_start')
		RequestIpl('canyonrvrshallow')
		RequestIpl('canyonrvrdeep')
	
		-- Trevors Trailer
		RequestIpl("TrevorsMP")
		RequestIpl("TrevorsTrailer")
		RequestIpl("TrevorsTrailerTidy")
	
		-- Aircraft Carrier
		RequestIpl("hei_carrier")
		RequestIpl("hei_carrier_DistantLights")
		RequestIpl("hei_Carrier_int1")
		RequestIpl("hei_Carrier_int2")
		RequestIpl("hei_Carrier_int3")
		RequestIpl("hei_Carrier_int4")
		RequestIpl("hei_Carrier_int5")
		RequestIpl("hei_Carrier_int6")
		RequestIpl("hei_carrier_LODLights")
	
		RemoveIpl("DT1_03_Gr_Closed")
		RequestIpl("v_tunnel_hole")
		RequestIpl("FINBANK")
		RequestIpl("v_tunnel_hole")
		RequestIpl("v_rockclub")
		RemoveIpl("hei_bi_hw1_13_door")
		RequestIpl("bkr_bi_hw1_13_int")
		RemoveIpl("bh1_16_refurb")
		RemoveIpl("jewel2fake")
		RemoveIpl("bh1_16_doors_shut")
		RequestIpl("refit_unload")
		RequestIpl("post_hiest_unload")
		RequestIpl("Carwash_with_spinners")
		RequestIpl("ferris_finale_Anim")
		
		firstspawn = 1
	end
end)

function drawTxt(x, y, width, height, scale, text, r,g,b, a)
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
