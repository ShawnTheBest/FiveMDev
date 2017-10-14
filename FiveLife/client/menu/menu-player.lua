--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local eyeColor = {'Light Green', 'Dark Green', 'Light Blue', 'Blue', 'Hazel', 'Dark Brown', 'Light Brown', 'Grey'}
local hairColorName = {'Black', 'Dark Brown', 'Brown', 'Light Brown', 'Blonde', 'White', 'Light Grey', 'Grey', 'Dark Grey', 'Green', 'Blue-Green', 'Blue', 'Purple', 'Red', 'Red-Orange', 'Orange', 'Yellow'}
local sure = false
local color = 35
local color2 = 35

function showPlayerMenu()
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Player Creation",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	
	if amenu.page == 0 then -- Main Page
		amenu.title = "CREATE YOUR PLAYER"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Gender",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Face",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Hair",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Features",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Continue",255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 3 then DrawRect(0.87, 0.27, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 4 then DrawRect(0.87, 0.31, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 5 then DrawRect(0.87, 0.39, 0.16, 0.034, 255, 255, 255, 255) end
	elseif amenu.page == 1 then -- Gender
		amenu.title = "GENDER"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Male",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Female",255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
		drawBox(0)
	elseif amenu.page == 2 then -- Face
		amenu.title = "FACE"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Parent 1: " .. face.shapeFirst,255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Parent 2: " .. face.shapeSecond,255,255,255,255)
		DrawRect(0.87, 0.27, 0.12, 0.015, 0, 0, 0, 255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Skin Tone 1: " .. face.skinFirst-1,255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Skin Tone 2: " .. face.skinSecond-1,255,255,255,255)
		DrawRect(0.87, 0.39, 0.12, 0.015, 0, 0, 0, 255)
		drawTxt(0.798, 0.25, 0.0, 0.0, 0.35, "1                                    2",255,255,255,255)
		drawTxt(0.798, 0.37, 0.0, 0.0, 0.35, "1                                    2",255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) drawBox(1) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) drawBox(1) end
		if amenu.row == 3 then color = 255 drawBox(2) else color = 35 end
		if amenu.row == 4 then DrawRect(0.87, 0.31, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 5 then DrawRect(0.87, 0.35, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 6 then color2 = 255 drawBox(3) else color2 = 35 end
		drawSquares(1)
	elseif amenu.page == 3 then -- Hair
		amenu.title = "HAIR"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Hair Style: " .. model.hair,255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Hair Color: " .. hairColorName[texture.hair],255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Highlights: " .. hairColorName[texture.hair2],255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 3 then DrawRect(0.87, 0.27, 0.16, 0.034, 255, 255, 255, 255) end
		if model.gender == 'male' then
			drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Beard Style: " .. model.beard,255,255,255,255)
			drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Beard Color: " .. hairColorName[texture.beard],255,255,255,255)
			drawTxt(0.795, 0.41, 0.0, 0.0, 0.35, "0                                    1",255,255,255,255)
			if amenu.row == 4 then DrawRect(0.87, 0.35, 0.16, 0.034, 255, 255, 255, 255) end
			if amenu.row == 5 then DrawRect(0.87, 0.39, 0.16, 0.034, 255, 255, 255, 255) end
			if amenu.row == 6 then color = 255 drawBox(4) else color = 35 end
			DrawRect(0.87, 0.43, 0.12, 0.015, 0, 0, 0, 255)
			drawSquares(2)
		end
	elseif amenu.page == 4 then -- Features
		amenu.title = "FEATURES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Eyebrow Style: " .. model.eyebrows,255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Eyebrow Color: " .. hairColorName[texture.eyebrows],255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Eye Color: " .. eyeColor[texture.eyes+1],255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 3 then DrawRect(0.87, 0.31, 0.16, 0.034, 255, 255, 255, 255) end
	end
	local pCoords = GetEntityCoords(GetPlayerPed(-1), true)
	if pCoords.y < -1001.0 then SetEntityCoords(GetPlayerPed(-1), pCoords.x, -1000.0, pCoords.z-1.0) end
	
	-- Disables fighting in player creation
	DisableControlAction(0, 21, 1)
	DisableControlAction(2, 22, 1)
	DisableControlAction(0, 24, 1)
	DisableControlAction(0, 25, 1)
	DisableControlAction(0, 140, 1)
	DisableControlAction(0, 141, 1)
	DisableControlAction(0, 142, 1)
	
	
	if sure == true then
		drawTxt(0.9, 0.41, 0.0, 0.0, 0.3, "Sure?",255,255,255,255)
	end
	
	-- ============================== KEY PRESSES ==============================
	
	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		if amenu.row > 1 then 
			amenu.row = amenu.row-1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		if amenu.page == 0 then
			if amenu.row < 5 then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 1 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 2 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 3 then
			if model.gender == 'male' then
				if amenu.row < 6 then 
					amenu.row = amenu.row+1
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				end
			else
				if amenu.row < 3 then 
					amenu.row = amenu.row+1
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				end
			end
		elseif amenu.page == 4 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		local myPed = GetPlayerPed(-1)
		if amenu.page == 2 then -- FACE
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if face.shapeFirst > 0 then face.shapeFirst = face.shapeFirst-1 else face.shapeFirst = 45 end
				updateFace()
			elseif amenu.row == 2 then
				if face.shapeSecond > 0 then face.shapeSecond = face.shapeSecond-1 else face.shapeSecond = 45 end
				updateFace()
			elseif amenu.row == 3 then
				if face.shapeMix > 0.0 then face.shapeMix = face.shapeMix-0.1 end
				if amenu.field1 > 0 then amenu.field1 = amenu.field1-1 end
				UpdatePedHeadBlendData(GetPlayerPed(-1), face.shapeMix, face.skinMix, 0.0)
			elseif amenu.row == 4 then
				if face.skinFirst > 1 then face.skinFirst = face.skinFirst-1 end
				updateFace()
			elseif amenu.row == 5 then
				if face.skinSecond > 1 then face.skinSecond = face.skinSecond-1 end
				updateFace()
			elseif amenu.row == 6 then
				if face.skinMix > 0.0 then face.skinMix = face.skinMix-0.1 else face.skinMix = 0.0 end
				if amenu.field2 > 0 then amenu.field2 = amenu.field2-1 end
				UpdatePedHeadBlendData(myPed, face.shapeMix, face.skinMix, 0.0)
			end
		elseif amenu.page == 3 then -- HAIR
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if model.gender == 'male' then 
					if model.hair == 24 then 
						model.hair = 22
					else
						if model.hair > 0 then model.hair = model.hair-1 else model.hair = 73 end 
					end
				elseif model.gender == 'female' then
					if model.hair == 25 then
						model.hair = 23
					else
						if model.hair > 0 then model.hair = model.hair-1 else model.hair = 77 end
					end
				end
				SetPedComponentVariation(myPed, 2, model.hair, 0, 0)
			elseif amenu.row == 2 then
				if texture.hair > 1 then texture.hair = texture.hair-1 else texture.hair = 17 end
				SetPedHairColor(myPed, hairColor[texture.hair], hairColor[texture.hair2])
			elseif amenu.row == 3 then
				if texture.hair2 > 1 then texture.hair2 = texture.hair2-1 else texture.hair2 = 17 end
				SetPedHairColor(myPed, hairColor[texture.hair], hairColor[texture.hair2])
			elseif amenu.row == 4 then
				if model.beard > 0 then model.beard = model.beard-1 else model.beard = 28 end
				SetPedHeadOverlay(myPed, 1, model.beard, texture.beard2)
				if texture.beard == 1 then SetPedHeadOverlayColor(myPed, 1, 1, hairColor[texture.beard], 0) end
			elseif amenu.row == 5 then
				if texture.beard > 1 then texture.beard = texture.beard-1 else texture.beard = 17 end
				SetPedHeadOverlayColor(myPed, 1, 1, hairColor[texture.beard], 0)
			elseif amenu.row == 6 then
				if texture.beard2 > 0.0 then texture.beard2 = texture.beard2-0.1 else texture.beard2 = 0.0 end
				if amenu.field3 > 0 then amenu.field3 = amenu.field3-1 end
				SetPedHeadOverlay(myPed, 1, model.beard, texture.beard2)
			end
		elseif amenu.page == 4 then -- FEATURES
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if model.eyebrows > 0 then model.eyebrows = model.eyebrows-1 else model.eyebrows = 33 end
				SetPedHeadOverlay(myPed, 2, model.eyebrows, 1.0)
				if texture.eyebrows == 1 then SetPedHeadOverlayColor(myPed, 2, 1, hairColor[texture.eyebrows], 0) end
			elseif amenu.row == 2 then
				if texture.eyebrows > 1 then texture.eyebrows = texture.eyebrows-1 else texture.eyebrows = 17 end
				SetPedHeadOverlayColor(myPed, 2, 1, hairColor[texture.eyebrows], 0)
			elseif amenu.row == 3 then
				if texture.eyes > 0 then texture.eyes = texture.eyes-1 else texture.eyes = 7 end
				SetPedEyeColor(myPed, texture.eyes)
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
		local myPed = GetPlayerPed(-1)
		if amenu.page == 2 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if face.shapeFirst < 45 then face.shapeFirst = face.shapeFirst+1 else face.shapeFirst = 0 end
				updateFace()
			elseif amenu.row == 2 then
				if face.shapeSecond < 45 then face.shapeSecond = face.shapeSecond+1 else face.shapeSecond = 0  end
				updateFace()
			elseif amenu.row == 3 then
				if face.shapeMix < 1.0 then face.shapeMix = face.shapeMix+0.1 end
				if amenu.field1 < 10 then amenu.field1 = amenu.field1+1 end
				UpdatePedHeadBlendData(GetPlayerPed(-1), face.shapeMix, face.skinMix, 0.0)
			elseif amenu.row == 4 then
				if face.skinFirst < 7 then face.skinFirst = face.skinFirst+1 end
				updateFace()
			elseif amenu.row == 5 then
				if face.skinSecond < 7 then face.skinSecond = face.skinSecond+1 end
				updateFace()
			elseif amenu.row == 6 then
				if face.skinMix < 1.0 then face.skinMix = face.skinMix+0.1 else face.skinMix = 1.0 end
				if amenu.field2 < 10 then amenu.field2 = amenu.field2+1 end
				UpdatePedHeadBlendData(GetPlayerPed(-1), face.shapeMix, face.skinMix, 0.0)
			end
		elseif amenu.page == 3 then -- HAIR
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if model.gender == 'male' then 
					if model.hair == 22 then 
						model.hair = 24
					else
						if model.hair < 73 then model.hair = model.hair+1 else model.hair = 0 end 
					end
				elseif model.gender == 'female' then
					if model.hair == 23 then
						model.hair = 25
					else
						if model.hair < 77 then model.hair = model.hair+1 else model.hair = 0 end 
					end
				end
				SetPedComponentVariation(myPed, 2, model.hair, 0, 0)
			elseif amenu.row == 2 then
				if texture.hair < 17 then texture.hair = texture.hair+1 else texture.hair = 1 end
				SetPedHairColor(myPed, hairColor[texture.hair], hairColor[texture.hair2])
			elseif amenu.row == 3 then
				if texture.hair2 < 17 then texture.hair2 = texture.hair2+1 else texture.hair2 = 1 end
				SetPedHairColor(myPed, hairColor[texture.hair], hairColor[texture.hair2])
			elseif amenu.row == 4 then
				if model.beard < 28 then model.beard = model.beard+1 else model.beard = 0 end
				SetPedHeadOverlay(myPed, 1, model.beard, texture.beard2)
				if texture.beard == 1 then SetPedHeadOverlayColor(myPed, 1, 1, hairColor[texture.beard], 0) end
			elseif amenu.row == 5 then
				if texture.beard < 17 then texture.beard = texture.beard+1 else texture.beard = 1 end
				SetPedHeadOverlayColor(myPed, 1, 1, hairColor[texture.beard], 0)
			elseif amenu.row == 6 then
				if texture.beard2 < 1.0 then texture.beard2 = texture.beard2+0.1 else texture.beard2 = 1.0 end
				if amenu.field3 < 10 then amenu.field3 = amenu.field3+1 end
				SetPedHeadOverlay(myPed, 1, model.beard, texture.beard2)
			end
		elseif amenu.page == 4 then -- FEATURES
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if model.eyebrows < 33 then model.eyebrows = model.eyebrows+1 else model.eyebrows = 0 end
				SetPedHeadOverlay(myPed, 2, model.eyebrows, 1.0)
				if texture.eyebrows == 1 then SetPedHeadOverlayColor(myPed, 2, 1, hairColor[texture.eyebrows], 0) end
			elseif amenu.row == 2 then
				if texture.eyebrows < 17 then texture.eyebrows = texture.eyebrows+1 else texture.eyebrows = 1 end
				SetPedHeadOverlayColor(myPed, 2, 1, hairColor[texture.eyebrows], 0)
			elseif amenu.row == 3 then
				if texture.eyes < 7 then texture.eyes = texture.eyes+1 else texture.eyes = 0 end
				SetPedEyeColor(myPed, texture.eyes)
			end
		end
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		if amenu.page == 0 then
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				amenu.page = 1
				amenu.row = 1
			elseif amenu.row == 2 then
				amenu.page = 2
				amenu.row = 1
			elseif amenu.row == 3 then
				amenu.page = 3
				amenu.row = 1
			elseif amenu.row == 4 then
				amenu.page = 4
				amenu.row = 1
			elseif amenu.row == 5 then
				if sure == false then
					sure = true
				elseif sure == true then
					amenu.show = 0
					phone('enable')
					if model.gender == 'male' then
						model.hat = 11
					else
						model.hat = 57
					end
					updateClothes()
					TriggerServerEvent("savePlayerBasics", model.gender, face.shapeFirst .. ":" .. face.shapeSecond, face.skinFirst .. ":" .. face.skinSecond, face.shapeMix, face.skinMix, model.beard .. ":" .. texture.beard .. ":" .. texture.beard2, model.hair .. ":" .. texture.hair .. ":" .. texture.hair2, model.eyebrows .. ":" .. texture.eyebrows, texture.eyes)
					TriggerServerEvent("finishSpawn", 4)
					TriggerServerEvent("ActionLog", "registered succesfully.", 0)							
					sure = false
				end
			end
		elseif amenu.page == 1 then -- GENDER
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				model.gender = 'male'
				resetFace()
				setModel(GetHashKey('mp_m_freemode_01'))
			elseif amenu.row == 2 then
				model.gender = 'female'
				resetFace()
				setModel(GetHashKey('mp_f_freemode_01'))
			end
		elseif amenu.page == 2 then -- FACE
		
		elseif amenu.page == 3 then -- HAIR
		
		elseif amenu.page == 4 then -- FEATURES
		
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 then
			if amenu.row == 5 then
				if sure == true then
					sure = false
				end
			end
		elseif amenu.page == 1 or amenu.page == 2 or amenu.page == 3 or amenu.page == 4 then
			amenu.page = 0 
			amenu.row = 1
		end
	end
end


RegisterNetEvent("returnToModel")
AddEventHandler("returnToModel", function()
	local pModel = GetHashKey('mp_m_freemode_01')
	if model.gender == 'female' then
		pModel = GetHashKey('mp_f_freemode_01')
	end
	setModel(pModel)
	updateClothes()
	TriggerServerEvent("loadPlayerWeapons")
end)

RegisterNetEvent("refreshModel")
AddEventHandler("refreshModel", function()
	updateFace()
end)


	-- ============================== MENU FUNCTIONS ==============================

function resetFace()
	face.shapeFirst = 0 face.shapeSecond = 0 face.skinFirst = 1 face.skinSecond = 1 face.shapeMix = 0.5 face.skinMix = 0.5
	model.head = 0 model.beard = 0 model.hair = 0
	texture.head = 0 texture.beard = 1 texture.beard2 = 0.0 texture.hair = 1 texture.hair2 = 1
end

function setModel(hash)
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		Citizen.Wait(0)
	end
	SetPlayerModel(PlayerId(), hash)
	updateFace()
end
	
function drawBox(num)
	if num == 0 then
		DrawRect(0.87, 0.465, 0.16, 0.034, 0, 0, 0, 200)
		drawTxt(0.795, 0.445, 0.0, 0.0, 0.35, "Only two genders..",255,255,255,255)
	elseif num == 1 then
		DrawRect(0.87, 0.50, 0.16, 0.102, 0, 0, 0, 200)
		drawTxt(0.795, 0.45, 0.0, 0.0, 0.35, "0-20 Regular Males",255,255,255,255)
		drawTxt(0.795, 0.48, 0.0, 0.0, 0.35, "21-41 Regular Females",255,255,255,255)
		drawTxt(0.795, 0.51, 0.0, 0.0, 0.35, "42-45 Special",255,255,255,255)
	elseif num == 2 then
		DrawRect(0.87, 0.465, 0.16, 0.034, 0, 0, 0, 200)
		drawTxt(0.795, 0.445, 0.0, 0.0, 0.35, "Slider to mix faces.",255,255,255,255)
	elseif num == 3 then
		DrawRect(0.87, 0.465, 0.16, 0.034, 0, 0, 0, 200)
		drawTxt(0.795, 0.445, 0.0, 0.0, 0.35, "Slider to mix skin tones.",255,255,255,255)
	elseif num == 4 then
		DrawRect(0.87, 0.465, 0.16, 0.034, 0, 0, 0, 200)
		drawTxt(0.795, 0.445, 0.0, 0.0, 0.35, "Slider for beard opacity.",255,255,255,255)
	end
end

function drawSquares(num)
	if num == 1 then
		if amenu.field1 == 0 then DrawRect(0.82, 0.27, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field1 == 1 then DrawRect(0.83, 0.27, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field1 == 2 then DrawRect(0.84, 0.27, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field1 == 3 then DrawRect(0.85, 0.27, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field1 == 4 then DrawRect(0.86, 0.27, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field1 == 5 then DrawRect(0.87, 0.27, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field1 == 6 then DrawRect(0.88, 0.27, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field1 == 7 then DrawRect(0.89, 0.27, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field1 == 8 then DrawRect(0.90, 0.27, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field1 == 9 then DrawRect(0.91, 0.27, 0.02, 0.03, color, color, color, 255) 
		elseif amenu.field1 == 10 then DrawRect(0.92, 0.27, 0.02, 0.03, color, color, color, 255) end
		
		if amenu.field2 == 0 then DrawRect(0.82, 0.39, 0.02, 0.03, color2, color2, color2, 255)
		elseif amenu.field2 == 1 then DrawRect(0.83, 0.39, 0.02, 0.03, color2, color2, color2, 255)
		elseif amenu.field2 == 2 then DrawRect(0.84, 0.39, 0.02, 0.03, color2, color2, color2, 255)
		elseif amenu.field2 == 3 then DrawRect(0.85, 0.39, 0.02, 0.03, color2, color2, color2, 255)
		elseif amenu.field2 == 4 then DrawRect(0.86, 0.39, 0.02, 0.03, color2, color2, color2, 255)
		elseif amenu.field2 == 5 then DrawRect(0.87, 0.39, 0.02, 0.03, color2, color2, color2, 255)
		elseif amenu.field2 == 6 then DrawRect(0.88, 0.39, 0.02, 0.03, color2, color2, color2, 255)
		elseif amenu.field2 == 7 then DrawRect(0.89, 0.39, 0.02, 0.03, color2, color2, color2, 255)
		elseif amenu.field2 == 8 then DrawRect(0.90, 0.39, 0.02, 0.03, color2, color2, color2, 255)
		elseif amenu.field2 == 9 then DrawRect(0.91, 0.39, 0.02, 0.03, color2, color2, color2, 255) 
		elseif amenu.field2 == 10 then DrawRect(0.92, 0.39, 0.02, 0.03, color2, color2, color2, 255) end
	elseif num == 2 then
		if amenu.field3 == 0 then DrawRect(0.82, 0.43, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field3 == 1 then DrawRect(0.83, 0.43, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field3 == 2 then DrawRect(0.84, 0.43, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field3 == 3 then DrawRect(0.85, 0.43, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field3 == 4 then DrawRect(0.86, 0.43, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field3 == 5 then DrawRect(0.87, 0.43, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field3 == 6 then DrawRect(0.88, 0.43, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field3 == 7 then DrawRect(0.89, 0.43, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field3 == 8 then DrawRect(0.90, 0.43, 0.02, 0.03, color, color, color, 255)
		elseif amenu.field3 == 9 then DrawRect(0.91, 0.43, 0.02, 0.03, color, color, color, 255) 
		elseif amenu.field3 == 10 then DrawRect(0.92, 0.43, 0.02, 0.03, color, color, color, 255) end
	end
end

