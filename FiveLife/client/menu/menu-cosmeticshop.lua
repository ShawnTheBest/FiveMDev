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

function showCosmeticMenu()
    bankStats.account = getBank('account')
	bankStats.cash = getBank('cash')
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end

	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Cosmetic Shop",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	
	if amenu.page ~= 0 then showNormalSelection() end
	if amenu.page == 0 then -- Main Page
		amenu.title = "Cosmetic Shop"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Gender",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Face",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Purchase: ~g~$10000",255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
	elseif amenu.page == 1 then -- Gender
		amenu.title = "Gender"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Male",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Female",255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
		drawBox(0)
	elseif amenu.page == 2 then -- Face
		amenu.title = "FACE"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Parent 1: " .. cStoreFace.shapeFirst,255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Parent 2: " .. cStoreFace.shapeSecond,255,255,255,255)
		DrawRect(0.87, 0.27, 0.12, 0.015, 0, 0, 0, 255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Skin Tone 1: " .. cStoreFace.skinFirst-1,255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Skin Tone 2: " .. cStoreFace.skinSecond-1,255,255,255,255)
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
	end
	
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
			if amenu.row < 3 then
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
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		local myPed = GetPlayerPed(-1)
		if amenu.page == 2 then -- FACE
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if cStoreFace.shapeFirst > 0 then cStoreFace.shapeFirst = cStoreFace.shapeFirst-1 else cStoreFace.shapeFirst = 45 end
			elseif amenu.row == 2 then
				if cStoreFace.shapeSecond > 0 then cStoreFace.shapeSecond = cStoreFace.shapeSecond-1 else cStoreFace.shapeSecond = 45 end
			elseif amenu.row == 3 then
				if cStoreFace.shapeMix > 0.0 then cStoreFace.shapeMix = cStoreFace.shapeMix-0.1 end
				if amenu.field1 > 0 then amenu.field1 = amenu.field1-1 end
				UpdatePedHeadBlendData(GetPlayerPed(-1), cStoreFace.shapeMix, cStoreFace.skinMix, 0.0)
			elseif amenu.row == 4 then
				if cStoreFace.skinFirst > 1 then cStoreFace.skinFirst = cStoreFace.skinFirst-1 end
			elseif amenu.row == 5 then
				if cStoreFace.skinSecond > 1 then cStoreFace.skinSecond = cStoreFace.skinSecond-1 end
			elseif amenu.row == 6 then
				if cStoreFace.skinMix > 0.0 then cStoreFace.skinMix = cStoreFace.skinMix-0.1 else cStoreFace.skinMix = 0.0 end
				if amenu.field2 > 0 then amenu.field2 = amenu.field2-1 end
				UpdatePedHeadBlendData(myPed, cStoreFace.shapeMix, cStoreFace.skinMix, 0.0)
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
		local myPed = GetPlayerPed(-1)
		if amenu.page == 2 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if cStoreFace.shapeFirst < 45 then cStoreFace.shapeFirst = cStoreFace.shapeFirst+1 else cStoreFace.shapeFirst = 0 end
			elseif amenu.row == 2 then
				if cStoreFace.shapeSecond < 45 then cStoreFace.shapeSecond = cStoreFace.shapeSecond+1 else cStoreFace.shapeSecond = 0  end
			elseif amenu.row == 3 then
				if cStoreFace.shapeMix < 1.0 then cStoreFace.shapeMix = cStoreFace.shapeMix+0.1 end
				if amenu.field1 < 10 then amenu.field1 = amenu.field1+1 end
				UpdatePedHeadBlendData(GetPlayerPed(-1), cStoreFace.shapeMix, cStoreFace.skinMix, 0.0)
			elseif amenu.row == 4 then
				if cStoreFace.skinFirst < 7 then cStoreFace.skinFirst = cStoreFace.skinFirst+1 end
			elseif amenu.row == 5 then
				if cStoreFace.skinSecond < 7 then cStoreFace.skinSecond = cStoreFace.skinSecond+1 end
			elseif amenu.row == 6 then
				if cStoreFace.skinMix < 1.0 then cStoreFace.skinMix = cStoreFace.skinMix+0.1 else cStoreFace.skinMix = 1.0 end
				if amenu.field2 < 10 then amenu.field2 = amenu.field2+1 end
				UpdatePedHeadBlendData(GetPlayerPed(-1), cStoreFace.shapeMix, cStoreFace.skinMix, 0.0)
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
				Wait(50)
				if bankStats.cash >= 1 then
					TriggerServerEvent("deductMoney", 0, 10000)
					ShowNotification("Surgery Purchased!")
					model.hat = GetPedPropIndex(GetPlayerPed(-1), 0)
					texture.hat = GetPedPropTextureIndex(GetPlayerPed(-1), 0)
					TriggerServerEvent("savePlayerBasics", cStoreModel.gender, cStoreFace.shapeFirst .. ":" .. cStoreFace.shapeSecond, cStoreFace.skinFirst .. ":" .. cStoreFace.skinSecond, cStoreFace.shapeMix, cStoreFace.skinMix, cStoreModel.beard .. ":" .. cStoreTexture.beard .. ":" .. cStoreTexture.beard2, cStoreModel.hair .. ":" .. cStoreTexture.hair .. ":" .. cStoreTexture.hair2, cStoreModel.eyebrows .. ":" .. cStoreTexture.eyebrows, cStoreTexture.eyes)
					saveFace(1)
					amenu.show = 0
					phone('enable')
					TriggerEvent("AwesomeFreeze", false)
				else
					ShowNotification("~r~You don't have enough cash!")
				end
			end
		elseif amenu.page == 1 then -- GENDER
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				cStoreModel.gender = 'male'
				resetStoreFace()
				setModel(GetHashKey('mp_m_freemode_01'))
			elseif amenu.row == 2 then
				cStoreModel.gender = 'female'
				resetStoreFace()
				setModel(GetHashKey('mp_f_freemode_01'))
			end
		elseif amenu.page == 2 then -- Face
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 then
			amenu.show = 0
			updateFace()
			phone('enable')
			sure = false
			TriggerEvent("AwesomeFreeze", false)
		elseif amenu.page == 1 then
			amenu.page = 0 
			amenu.row = 1
		elseif amenu.page == 2 then
			amenu.page = 0 
			amenu.row = 2
		elseif amenu.page == 3 then
			amenu.page = 0 
			amenu.row = 2
		end
	end
end
	-- ============================== MENU FUNCTIONS ==============================

function resetStoreFace()
	cStoreFace.shapeFirst = 0 cStoreFace.shapeSecond = 0 cStoreFace.skinFirst = 1 cStoreFace.skinSecond = 1 cStoreFace.shapeMix = 0.5 cStoreFace.skinMix = 0.5
	cStoreModel.head = 0 cStoreModel.beard = 0 cStoreModel.hair = 0
	cStoreTexture.head = 0 cStoreTexture.beard = 1 cStoreTexture.beard2 = 0.0 cStoreTexture.hair = 1 cStoreTexture.hair2 = 1
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

function saveFace(types)
	if types == 0 then
		cStoreModel.gender = model.gender
		cStoreFace.shapeFirst = face.shapeFirst
		cStoreFace.shapeSecond = face.shapeSecond
		cStoreFace.skinFirst = face.skinFirst
		cStoreFace.skinSecond = face.skinSecond
		cStoreFace.shapeMix = face.shapeMix
		cStoreFace.skinMix = face.shapeMix

	elseif types == 1 then
		model.gender = cStoreModel.gender
		face.shapeFirst = cStoreFace.shapeFirst
		face.shapeSecond = cStoreFace.shapeSecond
		face.skinFirst = cStoreFace.skinFirst
		face.skinSecond = cStoreFace.skinSecond
		face.shapeMix = cStoreFace.shapeMix
		face.shapeMix = cStoreFace.skinMix
	end
end