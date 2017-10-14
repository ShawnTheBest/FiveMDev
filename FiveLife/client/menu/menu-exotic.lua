--[[ ====================================================================================================================================
 
                                                -   Copyright © 2017 GTAV-LIFE (Adam Masson) -
                                                    This file is part of project GTAV-Life..
        All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
            including copying, or other electronic or mechanical methods, without the prior written permission of the creator.
 
==================================================================================================================================== ]]--
 
local vehEnter = {-34.1066, -1102.26, 26.0}
local vehViewing = {-46.56, -1097.38, 26.0}
local vehSpawning = {-32.35, -1091.92, 26.0}
local vehHeading = {190.0, 136.0, 315.0}
local vehSpawnHeading = {330.0, 120.19, 318.345}
local vehColors = {0, 11, 4, 8, 27, 150, 33, 143, 135, 36, 38, 99, 88, 89, 49, 50, 54, 141, 62, 64, 73, 96, 94, 104, 99, 71, 142, 145, 107, 111, 112} -- 1-31
 
function showExoticMenu()
    RequestStreamedTextureDict("commonmenu", true)
    while not HasStreamedTextureDictLoaded("commonmenu") do
        Citizen.Wait(1)
    end
    DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
    DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
    DrawRect(0.87, 0.155, 0.16, 0.034, 0, 0, 0, 255)
    drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Exotic Dealer",255,255,255,255)
    drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
    if amenu.page ~= 0 then
        DrawRect(0.87, 0.48, 0.16, 0.068, 0, 0, 0, 200)
        drawTxt(0.795, 0.45, 0.0, 0.0, 0.25, "ENTER - Buy",255,255,255,255)
        drawTxt(0.795, 0.48, 0.0, 0.0, 0.25, "LEFT/RIGHT - Cycle Color",255,255,255,255)
        drawTxt(0.795, 0.41, 0.0, 0.0, 0.35, "Price: ~g~$" .. vehMenu.cost,255,255,255,255)
    end
   
    showExoticCar()
    showNormalSelection()
    if amenu.page == 0 then -- Main Page
        amenu.title = "VEHICLE TYPES"
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Sports",255,255,255,255)
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Classics",255,255,255,255)
        drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Luxury Sedans & Coupes",255,255,255,255)
        drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Luxury SUV's",255,255,255,255)
    elseif amenu.page == 1 then -- Sports
        amenu.title = "SPORTS"
        drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/4",30,88,162,255)
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Obey 9F",255,255,255,255)
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Obey 9F Cabrio",255,255,255,255)
        drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Albany Alpha",255,255,255,255)
        drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Bravado Banshee",255,255,255,255)
        drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Bravado Buffalo S",255,255,255,255)
        drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Grotti Carbonizzare",255,255,255,255)
    elseif amenu.page == 2 then -- Sports
        amenu.title = "SPORTS"
        drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/4",30,88,162,255)
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Pfister Comet",255,255,255,255)
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Invetero Coquette",255,255,255,255)
        drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Annis Elegy RH8",255,255,255,255)
        drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Benefactor Feltzer",255,255,255,255)
        drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Dewbauchee Rapid GT",255,255,255,255)
        drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Dewbauchee Rapid GT",255,255,255,255)
    elseif amenu.page == 3 then -- Sports
        amenu.title = "SPORTS"
        drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "3/4",30,88,162,255)
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Benefactor Surano",255,255,255,255)
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Bravado Verlierer",255,255,255,255)
        drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Maibatsu Penumbra",255,255,255,255)
        drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Benefactor Schwarzer",255,255,255,255)
        drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Dewbauchee Massacro",255,255,255,255)
        drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Hijack Khamelion",255,255,255,255)
    elseif amenu.page == 4 then -- Sports
        amenu.title = "SPORTS"
        drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "4/4",30,88,162,255)
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Schyster Fusilade",255,255,255,255)
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Lampadati Furore GT",255,255,255,255)
        drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Cognoscenti Cabrio",255,255,255,255)
    elseif amenu.page == 5 then -- Classics
        amenu.title = "CLASSICS"
        drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/3",30,88,162,255)
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Lampadati Casco",255,255,255,255)
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Invetero Coquette Classic",255,255,255,255)
        drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Invetero Coquette Blackfin",255,255,255,255)
        drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Dewbauchee JB 700",255,255,255,255)
        drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Declasse Mamba",255,255,255,255)
        drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Albany Manana",255,255,255,255)
    elseif amenu.page == 6 then -- Classics
        amenu.title = "CLASSICS"
        drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/3",30,88,162,255)
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Pegassi Monroe",255,255,255,255)
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Vapid Peyote",255,255,255,255)
        drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Lampadati Pigalle",255,255,255,255)
        drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Albany Roosevelt",255,255,255,255)
        drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Franken Stange",255,255,255,255)
        drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Grotti Stinger Topless",255,255,255,255)
    elseif amenu.page == 7 then -- Classics
        amenu.title = "CLASSICS"
        drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "3/3",30,88,162,255)
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Grotti Stinger",255,255,255,255) 
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Declasse Tornado",255,255,255,255)
        drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Truffade Z-Type",255,255,255,255)
        drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Vapid Hotknife",255,255,255,255)
   
    elseif amenu.page == 8 then -- Luxury Sedan & Coupes
        amenu.title = "LUX SEDANS & COUPES"
        drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/2",30,88,162,255)
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Ocelot F620",255,255,255,255)
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Felon Coupe",255,255,255,255)
        drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Windsor Hard Top",255,255,255,255)
        drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Windsor Soft Top",255,255,255,255)
        drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Enus Super Diamond",255,255,255,255)
        drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Benefactor Schafter V12",255,255,255,255)
    elseif amenu.page == 9 then -- Luxury Sedan & Coupes
        amenu.title = "LUX SEDANS & COUPES"
        drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/2",30,88,162,255)
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Benefactor Schafter LWB",255,255,255,255)
    elseif amenu.page == 10 then -- Luxury SUV's
        amenu.title ="LUXURY SUV's"
        drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/1",30,88,162,255)
        drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Gallivanter Baller LE",255,255,255,255)
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Gallivanter Baller LE LWB",255,255,255,255)
        drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Benefactor Dubsta",255,255,255,255)
        drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Benefactor Dubsta 6x6",255,255,255,255)
        drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Benefactor XLS",255,255,255,255)
        drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Fathom Fq2",255,255,255,255)
    end
 
 
    -- ============================== KEY PRESSES ============================== --
   
    if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
        if amenu.page ~= 0 and amenu.page ~= 1 and amenu.page ~= 5 and amenu.page ~= 8 and amenu.page~= 10 then
            if amenu.row > 0 then
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                amenu.row = amenu.row-1
				if amenu.row == 0 then
					amenu.page = amenu.page - 1
					amenu.row = 6
				end
            end
        else
            if amenu.row > 1 then
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            amenu.row = amenu.row-1
            end
        end
    elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
        if amenu.page == 0 then
            if amenu.row < 4 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end
        elseif amenu.page == 1 then
            if amenu.row < 7 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end
            if amenu.row == 7 then
                amenu.page = 2
                amenu.row = 1
            end
        elseif amenu.page == 2 then
            if amenu.row < 7 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end
            if amenu.row == 7 then
                amenu.page = 3
                amenu.row = 1
            end
        elseif amenu.page == 3 then
            if amenu.row < 7 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end
            if amenu.row == 7 then
                amenu.page = 4
                amenu.row = 1
            end
        elseif amenu.page == 4 then
            if amenu.row < 4 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end
        elseif amenu.page == 5 then
            if amenu.row < 7 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end
            if amenu.row == 7 then
                amenu.page = 6
                amenu.row = 1
            end
        elseif amenu.page == 6 then
            if amenu.row < 7 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end
            if amenu.row == 7 then
                amenu.page = 7
                amenu.row = 1
            end
        elseif amenu.page == 7 then
            if amenu.row < 4 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end
        elseif amenu.page == 8 then
            if amenu.row < 7 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
			if amenu.row == 7 then
                amenu.page = 9
                amenu.row = 1
            end
        elseif amenu.page == 9 then
            if amenu.row < 1 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end
        elseif amenu.page == 10 then
            if amenu.row < 6 then
                amenu.row = amenu.row+1
                PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end
        end
    elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
        if vehMenu.color > 1 then vehMenu.color = vehMenu.color-1 else vehMenu.color = 31 end
        SetVehicleColours(GetVehiclePedIsIn(GetPlayerPed(-1), false), vehColors[vehMenu.color], vehColors[vehMenu.color])
        SetVehicleExtraColours(GetVehiclePedIsIn(GetPlayerPed(-1), false), vehColors[vehMenu.color], 4)
    elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
        if vehMenu.color < 31 then vehMenu.color = vehMenu.color+1 else vehMenu.color = 1 end
        SetVehicleColours(GetVehiclePedIsIn(GetPlayerPed(-1), false), vehColors[vehMenu.color], vehColors[vehMenu.color])
        SetVehicleExtraColours(GetVehiclePedIsIn(GetPlayerPed(-1), false), vehColors[vehMenu.color], 4)
    elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
        if amenu.page == 0 then -- Main Page
            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            if amenu.row == 1 then
                amenu.page = 1
                amenu.row = 1
            elseif amenu.row == 2 then
                amenu.page = 5
                amenu.row = 1
            elseif amenu.row == 3 then
                amenu.page = 8
                amenu.row = 1
            elseif amenu.row == 4 then
                amenu.page = 10
                amenu.row = 1
            end
        else
            if IsAnyVehicleNearPoint(vehSpawning[1], vehSpawning[2], vehSpawning[3], 5.0) == false then
                if bankStats.cash >= vehMenu.cost then                     
                    TriggerServerEvent("deductMoney", 0, vehMenu.cost)
                    ShowNotification("Vehicle bought!")
                   
                    if GetVehiclePedIsIn(GetPlayerPed(-1), false) ~= false then
                        local inCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                        SetEntityAsMissionEntity(inCar, true, true)
                        while DoesEntityExist(inCar) do
                            Citizen.Wait(0)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(inCar))
                        end
                    else
                        local lastCar = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                        SetEntityAsMissionEntity(lastCar, true, true)
                        while DoesEntityExist(lastCar) do
                            Citizen.Wait(0)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(lastCar))
                        end
                    end
                   
                    local carHash = GetHashKey(vehMenu.model)
                    RequestModel(carHash)
                    while not HasModelLoaded(carHash) do
                        Citizen.Wait(0)
                        drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
                    end
                    local newVeh = CreateVehicle(carHash, vehSpawning[1], vehSpawning[2], vehSpawning[3], vehSpawnHeading[3], true, false)
                    SetVehicleOnGroundProperly(newVeh)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), newVeh, -1)
                    for i = 0,24 do
                        SetVehicleModKit(newVeh,0)
                        RemoveVehicleMod(newVeh,i)
                    end
                    SetVehicleColours(newVeh, vehColors[vehMenu.color], vehColors[vehMenu.color])
                    SetVehicleExtraColours(newVeh, vehColors[vehMenu.color], 4)
                    local color = vehColors[vehMenu.color]
                    local plate = "P" .. GetRandomIntInRange(10, 99) .. "" .. GetRandomIntInRange(10, 99) .. "" .. GetRandomIntInRange(100, 999)
                    SetVehicleNumberPlateText(newVeh, "" .. plate)
                    amenu.show = 0
                    phone('enable')
                    TriggerEvent("AwesomeFreeze", false)
                    SetEntityVisible(GetPlayerPed(-1), true, 0)
                    vehMenu.open = false
                    TriggerEvent("addKey", plate)
                    TriggerServerEvent("AddToGarage", vehMenu.model, 'false', plate, color)
                else
                    ShowNotification("~r~You don't have enough cash!")
                end
            else
                ShowNotification("~r~Spawn area is full!")
            end
        end
    elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
        if amenu.page == 0 then
            amenu.show = 0
            phone('enable')
            if GetVehiclePedIsIn(GetPlayerPed(-1), false) ~= false then
                local inCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                SetEntityAsMissionEntity(inCar, true, true)
                while DoesEntityExist(inCar) do
                    Citizen.Wait(0)
                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(inCar))
                end
            else
                local lastCar = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                SetEntityAsMissionEntity(lastCar, true, true)
                while DoesEntityExist(lastCar) do
                    Citizen.Wait(0)
                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(lastCar))
                end
            end
            SetEntityCoords(GetPlayerPed(-1), vehEnter[1], vehEnter[2], vehEnter[3], 1, 0, 0, 1)
            TriggerEvent("AwesomeFreeze", false)
            SetEntityVisible(GetPlayerPed(-1), true, 0)
            vehMenu.open = false
        elseif amenu.page == 1 or amenu.page == 2 or amenu.page == 3 or amenu.page == 4 then
            amenu.page = 0
            amenu.row = 1
        elseif amenu.page == 5 or amenu.page == 6 or amenu.page == 7 then
            amenu.page = 0
            amenu.row = 2
        elseif amenu.page == 8 or amenu.page == 9 or amenu.page == 10 then
            amenu.page = 0
            amenu.row = 3
        end
    end
end
 
    -- ============================== MENU FUNCTIONS ============================== --
 
function showExoticCar()
    if amenu.page == 0 then -- Main Page
        if amenu.row == 1 then
            if vehMenu.model ~= "ninef" then spawnExoticCar("ninef") end -- Sedans
        elseif amenu.row == 2 then
            if vehMenu.model ~= "casco" then spawnExoticCar("casco") end -- Coupes
        elseif amenu.row == 3 then
            if vehMenu.model ~= "Windsor2" then spawnExoticCar("Windsor2") end -- Luxury Sedans & Coupes
        elseif amenu.row == 4 then
            if vehMenu.model ~= "baller3" then spawnExoticCar("baller3") end -- Luxury SUV's       
        end
    elseif amenu.page == 1 then -- Sports
        if amenu.row == 1 then
            if vehMenu.model ~= "ninef" then spawnExoticCar("ninef") end
            vehMenu.cost = 125000
        elseif amenu.row == 2 then
            if vehMenu.model ~= "ninef2" then spawnExoticCar("ninef2") end
            vehMenu.cost = 135000
        elseif amenu.row == 3 then
            if vehMenu.model ~= "alpha" then spawnExoticCar("alpha") end
            vehMenu.cost = 115000
        elseif amenu.row == 4 then
            if vehMenu.model ~= "banshee" then spawnExoticCar("banshee") end
            vehMenu.cost = 90000
        elseif amenu.row == 5 then
            if vehMenu.model ~= "buffalo2" then spawnExoticCar("buffalo2") end
            vehMenu.cost = 65000
        elseif amenu.row == 6 then
            if vehMenu.model ~= "carbonizzare" then spawnExoticCar("carbonizzare") end
            vehMenu.cost = 130000
        end
    elseif amenu.page == 2 then -- Sports
        if amenu.row == 1 then
            if vehMenu.model ~= "comet2" then spawnExoticCar("comet2") end
            vehMenu.cost = 105000
        elseif amenu.row == 2 then
            if vehMenu.model ~= "coquette" then spawnExoticCar("coquette") end
            vehMenu.cost = 120000
        elseif amenu.row == 3 then
            if vehMenu.model ~= "elegy2" then spawnExoticCar("elegy2") end
            vehMenu.cost = 100000
        elseif amenu.row == 4 then
            if vehMenu.model ~= "feltzer2" then spawnExoticCar("feltzer2") end
            vehMenu.cost = 100000
        elseif amenu.row == 5 then
            if vehMenu.model ~= "rapidgt2" then spawnExoticCar("rapidgt2") end
            vehMenu.cost = 115000
        elseif amenu.row == 6 then
            if vehMenu.model ~= "rapidgt" then spawnExoticCar("rapidgt") end
            vehMenu.cost = 105000
        end
    elseif amenu.page == 3 then -- Sports
        if amenu.row == 1 then
            if vehMenu.model ~= "surano" then spawnExoticCar("surano") end
            vehMenu.cost = 135000
        elseif amenu.row == 2 then
            if vehMenu.model ~= "verlierer2" then spawnExoticCar("verlierer2") end
            vehMenu.cost = 120000
        elseif amenu.row == 3 then
            if vehMenu.model ~= "penumbra" then spawnExoticCar("penumbra") end
            vehMenu.cost = 50000
        elseif amenu.row == 4 then
            if vehMenu.model ~= "schwarzer" then spawnExoticCar("schwarzer") end
            vehMenu.cost = 70000
        elseif amenu.row == 5 then
            if vehMenu.model ~= "massacro" then spawnExoticCar("massacro") end
            vehMenu.cost = 130000
        elseif amenu.row == 6 then
            if vehMenu.model ~= "khamelion" then spawnExoticCar("khamelion") end
            vehMenu.cost = 95000
        end
    elseif amenu.page == 4 then -- Sports
        if amenu.row == 1 then
            if vehMenu.model ~= "fusilade" then spawnExoticCar("fusilade") end
            vehMenu.cost = 60000
        elseif amenu.row == 2 then
            if vehMenu.model ~= "furoregt" then spawnExoticCar("furoregt") end
            vehMenu.cost = 100000
        elseif amenu.row == 3 then
            if vehMenu.model ~= "CogCabrio" then spawnExoticCar("CogCabrio") end
            vehMenu.cost = 115000
        end
    elseif amenu.page == 5 then -- Classics
        if amenu.row == 1 then
            if vehMenu.model ~= "casco" then spawnExoticCar("casco") end
            vehMenu.cost = 70000
        elseif amenu.row == 2 then
            if vehMenu.model ~= "coquette2" then spawnExoticCar("coquette2") end
            vehMenu.cost = 58000
        elseif amenu.row == 3 then
            if vehMenu.model ~= "coquette3" then spawnExoticCar("coquette3") end
            vehMenu.cost = 63000
        elseif amenu.row == 4 then
            if vehMenu.model ~= "jb700" then spawnExoticCar("jb700") end
            vehMenu.cost = 50000
        elseif amenu.row == 5 then
            if vehMenu.model ~= "mamba" then spawnExoticCar("mamba") end
            vehMenu.cost = 37000
        elseif amenu.row == 6 then
            if vehMenu.model ~= "manana" then spawnExoticCar("manana") end
            vehMenu.cost = 18000
        end
    elseif amenu.page == 6 then -- Classics
        if amenu.row == 1 then
            if vehMenu.model ~= "monroe" then spawnExoticCar("monroe") end
            vehMenu.cost = 45000
        elseif amenu.row == 2 then
            if vehMenu.model ~= "peyote" then spawnExoticCar("peyote") end
            vehMenu.cost = 22000
        elseif amenu.row == 3 then
            if vehMenu.model ~= "pigalle" then spawnExoticCar("pigalle") end
            vehMenu.cost = 34000
        elseif amenu.row == 4 then
            if vehMenu.model ~= "btype" then spawnExoticCar("btype") end
            vehMenu.cost = 59000
        elseif amenu.row == 5 then
            if vehMenu.model ~= "btype2" then spawnExoticCar("btype2") end
            vehMenu.cost = 70000
        elseif amenu.row == 6 then
            if vehMenu.model ~= "stingergt" then spawnExoticCar("stingergt") end
            vehMenu.cost = 40000
        end
    elseif amenu.page == 7 then -- Classics
        if amenu.row == 1 then
            if vehMenu.model ~= "stinger" then spawnExoticCar("stinger") end
            vehMenu.cost = 39000
        elseif amenu.row == 2 then
            if vehMenu.model ~= "tornado" then spawnExoticCar("tornado") end
            vehMenu.cost = 20000
        elseif amenu.row == 3 then
            if vehMenu.model ~= "ztype" then spawnExoticCar("ztype") end
            vehMenu.cost = 60000
        elseif amenu.row == 4 then
            if vehMenu.model ~= "hotknife" then spawnExoticCar("hotknife") end
            vehMenu.cost = 65000
        end
    elseif amenu.page == 8 then -- Luxury Sedan & Coupes
        if amenu.row == 1 then
            if vehMenu.model ~= "F620" then spawnExoticCar("F620") end
            vehMenu.cost = 85000
        elseif amenu.row == 2 then
            if vehMenu.model ~= "Felon2" then spawnExoticCar("Felon2") end
            vehMenu.cost = 60000
        elseif amenu.row == 3 then
            if vehMenu.model ~= "Windsor" then spawnExoticCar("Windsor") end
            vehMenu.cost = 100000
        elseif amenu.row == 4 then
            if vehMenu.model ~= "Windsor2" then spawnExoticCar("Windsor2") end
            vehMenu.cost = 105000
        elseif amenu.row == 5 then
            if vehMenu.model ~= "superd" then spawnExoticCar("superd") end
            vehMenu.cost = 110000
        elseif amenu.row == 6 then
            if vehMenu.model ~= "schafter3" then spawnExoticCar("schafter3") end
            vehMenu.cost = 95000
        end
    elseif amenu.page == 9 then -- Luxury Sedan & Coupes
        if amenu.row == 1 then
            if vehMenu.model ~= "schafter4" then spawnExoticCar("schafter4") end
            vehMenu.cost = 95000
        end
    elseif amenu.page == 10 then -- Luxury SUV's
        if amenu.row == 1 then
            if vehMenu.model ~= "Baller3" then spawnExoticCar("Baller3") end
            vehMenu.cost = 85000
        elseif amenu.row == 2 then
            if vehMenu.model ~= "Baller4" then spawnExoticCar("Baller4") end
            vehMenu.cost = 90000
        elseif amenu.row == 3 then
            if vehMenu.model ~= "Dubsta2" then spawnExoticCar("Dubsta2") end
            vehMenu.cost = 100000
        elseif amenu.row == 4 then
            if vehMenu.model ~= "Dubsta3" then spawnExoticCar("Dubsta3") end
            vehMenu.cost = 150000
        elseif amenu.row == 5 then
            if vehMenu.model ~= "XLS" then spawnExoticCar("XLS") end
            vehMenu.cost = 80000
        elseif amenu.row == 6 then
            if vehMenu.model ~= "FQ2" then spawnExoticCar("FQ2") end
            vehMenu.cost = 50000
        end
    end
end
 
function spawnExoticCar(car)
    local pPed = GetPlayerPed(-1)
    local inCar = GetVehiclePedIsIn(pPed, false)
    local inModel = inCar
    local carHash = GetHashKey(car)
    if carHash ~= inModel then
        SetEntityAsMissionEntity(inCar, true, true)
        while DoesEntityExist(inCar) do
            Citizen.Wait(0)
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(inCar))
        end
    end
   
    RequestModel(carHash)
    while not HasModelLoaded(carHash) do
        Citizen.Wait(0)
        drawTxt(0.5, 0.5, 0.0, 0.0, 0.4, "Loading...",255,255,255,255)
    end
    local newVeh = CreateVehicle(carHash, vehViewing[1], vehViewing[2], vehViewing[3], vehHeading[2], false, false)
    SetVehicleOnGroundProperly(newVeh)
    FreezeEntityPosition(newVeh,true)
    SetEntityInvincible(newVeh,true)
    SetVehicleDoorsLocked(newVeh, 4)
    TaskWarpPedIntoVehicle(pPed, newVeh, -1)
    for i = 0,24 do
        SetVehicleModKit(newVeh,0)
        RemoveVehicleMod(newVeh,i)
    end
    vehMenu.model = car
    SetVehicleColours(newVeh, vehColors[vehMenu.color], vehColors[vehMenu.color])
    SetVehicleExtraColours(newVeh, vehColors[vehMenu.color], 4)
end