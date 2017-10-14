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

function showBarberMenu()
    bankStats.account = getBank('account')
	bankStats.cash = getBank('cash')
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end

	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Barber Shop",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	
	
	if amenu.page ~= 0 then showNormalSelection() end
	if amenu.page == 0 then -- Main Page
		amenu.title = "Barber Shop"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Hair",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Features",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Purchase: ~g~$5000",255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 3 then DrawRect(0.87, 0.27, 0.16, 0.034, 255, 255, 255, 255) end
	elseif amenu.page == 1 then -- Hair
		amenu.title = "HAIR"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Hair Style " .. cStoreModel.hair,255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Hair Color " .. hairColorName[cStoreTexture.hair],255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Highlights " .. hairColorName[cStoreTexture.hair2],255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 3 then DrawRect(0.87, 0.27, 0.16, 0.034, 255, 255, 255, 255) end
		if model.gender == 'male' then
			drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Beard Style " .. cStoreModel.beard,255,255,255,255)
			drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Beard Color " .. hairColorName[cStoreTexture.beard],255,255,255,255)
			drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "0                                    1",255,255,255,255)
			if amenu.row == 4 then DrawRect(0.87, 0.31, 0.16, 0.034, 255, 255, 255, 255) end
			if amenu.row == 5 then DrawRect(0.87, 0.35, 0.16, 0.034, 255, 255, 255, 255) end
			if amenu.row == 6 then color = 255 drawBox(4) else color = 35 end
			DrawRect(0.87, 0.39, 0.12, 0.015, 0, 0, 0, 255)
			drawSquares(2)
		end
	elseif amenu.page == 2 then -- Features
		amenu.title = "FEATURES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Eyebrow Style " .. cStoreModel.eyebrows,255,255,255,255)
    drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Eyebrow Color " .. hairColorName[cStoreTexture.eyebrows],255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Eye Color " .. eyeColor[cStoreTexture.eyes+1],255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 3 then DrawRect(0.87, 0.27, 0.16, 0.034, 255, 255, 255, 255) end
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
		elseif amenu.page == 2 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		local myPed = GetPlayerPed(-1)
		if amenu.page == 1 then -- HAIR
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if model.gender == 'male' then 
					if cStoreModel.hair == 24 then 
						cStoreModel.hair = 22
					else
						if cStoreModel.hair > 0 then cStoreModel.hair = cStoreModel.hair-1 else cStoreModel.hair = 73 end 
					end
				elseif model.gender == 'female' then
					if cStoreModel.hair == 25 then
						cStoreModel.hair = 23
					else
						if cStoreModel.hair > 0 then cStoreModel.hair = cStoreModel.hair-1 else cStoreModel.hair = 77 end
					end
				end
				SetPedComponentVariation(myPed, 2, cStoreModel.hair, 0, 0)
			elseif amenu.row == 2 then
				if cStoreTexture.hair > 1 then cStoreTexture.hair = cStoreTexture.hair-1 else cStoreTexture.hair = 17 end
				SetPedHairColor(myPed, hairColor[cStoreTexture.hair], hairColor[cStoreTexture.hair2])
			elseif amenu.row == 3 then
				if cStoreTexture.hair2 > 1 then cStoreTexture.hair2 = cStoreTexture.hair2-1 else cStoreTexture.hair2 = 17 end
				SetPedHairColor(myPed, hairColor[cStoreTexture.hair], hairColor[cStoreTexture.hair2])
			elseif amenu.row == 4 then
				if cStoreModel.beard > 0 then cStoreModel.beard = cStoreModel.beard-1 else cStoreModel.beard = 28 end
				SetPedHeadOverlay(myPed, 1, cStoreModel.beard, cStoreTexture.beard2)
				if cStoreTexture.beard == 1 then SetPedHeadOverlayColor(myPed, 1, 1, hairColor[cStoreTexture.beard], 0) end
			elseif amenu.row == 5 then
				if cStoreTexture.beard > 1 then cStoreTexture.beard = cStoreTexture.beard-1 else cStoreTexture.beard = 17 end
				SetPedHeadOverlayColor(myPed, 1, 1, hairColor[cStoreTexture.beard], 0)
			elseif amenu.row == 6 then
				if cStoreTexture.beard2 > 0.0 then cStoreTexture.beard2 = cStoreTexture.beard2-0.1 else cStoreTexture.beard2 = 0.0 end
				if amenu.field3 > 0 then amenu.field3 = amenu.field3-1 end
				SetPedHeadOverlay(myPed, 1, cStoreModel.beard, cStoreTexture.beard2)
			end
		elseif amenu.page == 2 then -- FEATURES
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if cStoreModel.eyebrows > 0 then cStoreModel.eyebrows = cStoreModel.eyebrows-1 else cStoreModel.eyebrows = 33 end
				SetPedHeadOverlay(myPed, 2, cStoreModel.eyebrows, 1.0)
				if cStoreTexture.eyebrows == 1 then SetPedHeadOverlayColor(myPed, 2, 1, hairColor[cStoreTexture.eyebrows], 0) end
			elseif amenu.row == 2 then
				if cStoreTexture.eyebrows > 1 then cStoreTexture.eyebrows = cStoreTexture.eyebrows-1 else cStoreTexture.eyebrows = 17 end
				SetPedHeadOverlayColor(myPed, 2, 1, hairColor[cStoreTexture.eyebrows], 0)
			elseif amenu.row == 3 then
				if cStoreTexture.eyes > 0 then cStoreTexture.eyes = cStoreTexture.eyes-1 else cStoreTexture.eyes = 7 end
				SetPedEyeColor(myPed, cStoreTexture.eyes)
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
		local myPed = GetPlayerPed(-1)
		if amenu.page == 1 then -- HAIR
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if model.gender == 'male' then 
					if cStoreModel.hair == 22 then 
						cStoreModel.hair = 24
					else
						if cStoreModel.hair < 73 then cStoreModel.hair = cStoreModel.hair+1 else cStoreModel.hair = 0 end 
					end
				elseif model.gender == 'female' then
					if cStoreModel.hair == 23 then
						cStoreModel.hair = 25
					else
						if cStoreModel.hair < 77 then cStoreModel.hair = cStoreModel.hair+1 else cStoreModel.hair = 0 end 
					end
				end
				SetPedComponentVariation(myPed, 2, cStoreModel.hair, 0, 0)
			elseif amenu.row == 2 then
				if cStoreTexture.hair < 17 then cStoreTexture.hair = cStoreTexture.hair+1 else cStoreTexture.hair = 1 end
				SetPedHairColor(myPed, hairColor[cStoreTexture.hair], hairColor[cStoreTexture.hair2])
			elseif amenu.row == 3 then
				if cStoreTexture.hair2 < 17 then cStoreTexture.hair2 = cStoreTexture.hair2+1 else cStoreTexture.hair2 = 1 end
				SetPedHairColor(myPed, hairColor[cStoreTexture.hair], hairColor[cStoreTexture.hair2])
			elseif amenu.row == 4 then
				if cStoreModel.beard < 28 then cStoreModel.beard = cStoreModel.beard+1 else cStoreModel.beard = 0 end
				SetPedHeadOverlay(myPed, 1, cStoreModel.beard, cStoreTexture.beard2)
				if cStoreTexture.beard == 1 then SetPedHeadOverlayColor(myPed, 1, 1, hairColor[cStoreTexture.beard], 0) end
			elseif amenu.row == 5 then
				if cStoreTexture.beard < 17 then cStoreTexture.beard = cStoreTexture.beard+1 else cStoreTexture.beard = 1 end
				SetPedHeadOverlayColor(myPed, 1, 1, hairColor[cStoreTexture.beard], 0)
			elseif amenu.row == 6 then
				if cStoreTexture.beard2 < 1.0 then cStoreTexture.beard2 = cStoreTexture.beard2+0.1 else cStoreTexture.beard2 = 1.0 end
				if amenu.field3 < 10 then amenu.field3 = amenu.field3+1 end
				SetPedHeadOverlay(myPed, 1, cStoreModel.beard, cStoreTexture.beard2)
			end
		elseif amenu.page == 2 then -- FEATURES
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				if cStoreModel.eyebrows < 33 then cStoreModel.eyebrows = cStoreModel.eyebrows+1 else cStoreModel.eyebrows = 0 end
				SetPedHeadOverlay(myPed, 2, cStoreModel.eyebrows, 1.0)
				if cStoreTexture.eyebrows == 1 then SetPedHeadOverlayColor(myPed, 2, 1, hairColor[cStoreTexture.eyebrows], 0) end
			elseif amenu.row == 2 then
				if cStoreTexture.eyebrows < 17 then cStoreTexture.eyebrows = cStoreTexture.eyebrows+1 else cStoreTexture.eyebrows = 1 end
				SetPedHeadOverlayColor(myPed, 2, 1, hairColor[cStoreTexture.eyebrows], 0)
			elseif amenu.row == 3 then
				if cStoreTexture.eyes < 7 then cStoreTexture.eyes = cStoreTexture.eyes+1 else cStoreTexture.eyes = 0 end
				SetPedEyeColor(myPed, cStoreTexture.eyes)
			end
		end
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		if amenu.page == 0 then
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				amenu.page = 1
				amenu.row = 1
                ClearPedProp(GetPlayerPed(-1), 0)
			elseif amenu.row == 2 then
				amenu.page = 2
				amenu.row = 1
			elseif amenu.row == 3 then
				Wait(50)
				if bankStats.cash >= 5000 then
					TriggerServerEvent("deductMoney", 0, 5000)
					ShowNotification("Hair bought!")
					TriggerServerEvent("savePlayerBasics", model.gender, face.shapeFirst .. ":" .. face.shapeSecond, face.skinFirst .. ":" .. face.skinSecond, face.shapeMix, face.skinMix, cStoreModel.beard .. ":" .. cStoreTexture.beard .. ":" .. cStoreTexture.beard2, cStoreModel.hair .. ":" .. cStoreTexture.hair .. ":" .. cStoreTexture.hair2, cStoreModel.eyebrows .. ":" .. cStoreTexture.eyebrows, cStoreTexture.eyes)
					saveHair(1)
					amenu.show = 0
					phone('enable')
					TriggerEvent("AwesomeFreeze", false)
				else
					ShowNotification("~r~You don't have enough cash!")
				end
			end
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
	function saveHair(types)
	if types == 0 then
		cStoreModel.hair = model.hair
		cStoreModel.beard = model.beard
		cStoreModel.eyebrows = model.eyebrows
		cStoreTexture.hair = texture.hair
		cStoreTexture.hair2 = texture.hair2
		cStoreTexture.beard = texture.beard
		cStoreTexture.beard2 = texture.beard2
		cStoreTexture.eyebrows = texture.eyebrows
		cStoreTexture.eyes = texture.eyes
	elseif types == 1 then
		model.hair = cStoreModel.hair
		model.beard = cStoreModel.beard
		model.eyebrows = cStoreModel.eyebrows
		texture.hair = cStoreTexture.hair
		texture.hair2 = cStoreTexture.hair2
		texture.beard = cStoreTexture.beard
		texture.beard2 = cStoreTexture.beard2
		texture.eyebrows = cStoreTexture.eyebrows
		texture.eyes = cStoreTexture.eyes
	end
end