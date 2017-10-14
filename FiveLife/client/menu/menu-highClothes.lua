--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local totalClothingPrice = 0
local sure = false

function showHighClothesMenu()
	bankStats.account = getBank('account')
	bankStats.cash = getBank('cash')
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Ponsonbys",255,255,255,255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	
	if amenu.page > 15 then
		DrawRect(0.87, 0.50, 0.16, 0.102, 0, 0, 0, 200)
		drawTxt(0.795, 0.45, 0.0, 0.0, 0.35, "ENTER - Select",255,255,255,255)
		drawTxt(0.795, 0.48, 0.0, 0.0, 0.35, "LEFT/RIGHT - Cycle",255,255,255,255)
		drawTxt(0.795, 0.51, 0.0, 0.0, 0.35, "Variation: (" .. amenu.texture .. "/" .. amenu.maxTexture .. ")",255,255,255,255)
	end
	
	if amenu.page ~= 0 then showNormalSelection() end
	if amenu.page == 0 then -- Main Page
		amenu.title = "BROWSE CLOTHES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Overshirts",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Shirts",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Neck",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Pants",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Shoes",255,255,255,255)
		prices.total = prices.hat+prices.underShirt+prices.overShirt+prices.legs+prices.shoes+prices.neck
		drawTxt(0.795, 0.41, 0.0, 0.0, 0.35, "Purchase: ~g~$" .. prices.total,255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 3 then DrawRect(0.87, 0.27, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 4 then DrawRect(0.87, 0.31, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 5 then DrawRect(0.87, 0.35, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 6 then DrawRect(0.87, 0.43, 0.16, 0.034, 255, 255, 255, 255) end
	elseif amenu.page == 1 then 
		amenu.title = "Overshirts"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Blazers ~g~$100",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Coats ~g~$100",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Casual ~g~$100",255,255,255,255)
	elseif amenu.page == 2 then
		amenu.title = "Undershirts"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Dress Shirts ~g~$50",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Shirt & Vest ~g~$50",255,255,255,255)
	elseif amenu.page == 3 then
		amenu.title = "NECK"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Ties ~g~$50",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Bow Ties ~g~$50",255,255,255,255)
	elseif amenu.page == 4 then
		amenu.title = "PANTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Slacks ~g~$75",255,255,255,255)	
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "More Slacks ~g~$75",255,255,255,255)
	elseif amenu.page == 5 then
		amenu.title = "SHOES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Shoes ~g~$50",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "More Shoes ~g~$50",255,255,255,255)
	elseif amenu.page == 11 then -- Overshirts - Blazers
		amenu.title = "Blazers"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Blazer (O)",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Blazer (C)",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Long Tail Blazer",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Leather Blazer (O)",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Leather Blazer (C)",255,255,255,255)
	elseif amenu.page == 12 then -- Overshirts - Coats
		amenu.title = "Coats"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Trench Coat(O)",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Trench Coat(C)",255,255,255,255)
	elseif amenu.page == 13 then -- Overshirts - Casual
		amenu.title = "Casual"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Vest",255,255,255,255)
        drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Casual Blazer (O)",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Casual Blazer (C)",255,255,255,255)
	elseif amenu.page == 21 then -- Undershirts - Dress Shirts
		amenu.title = "Dress Shirts"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Dress Shirt Neat",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Dress Shirt Unneat",255,255,255,255)
	elseif amenu.page == 22 then -- Undershirts - Shirt & Vest
		amenu.title = "Shirt & Vest"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Vest & Shirt Neat",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Vest & Shirt Unneat",255,255,255,255)
	elseif amenu.page == 31 then -- NECK - Ties
		amenu.title = "Ties"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Tie (Regular)",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Tie (Variety)",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Slim Tie (R)",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Slim Tie (V)",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "No Tie",255,255,255,255)
	elseif amenu.page == 32 then -- NECK - Bow Tie
		amenu.title = "Bow Ties"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Formal",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Casual",255,255,255,255)
	elseif amenu.page == 41 then -- PANTS - Slacks
		amenu.title = "Slacks"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Slacks Reg",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Slacks Slim",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Leather Slacks Reg",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Leather Slacks Slim",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Slacks Casual",255,255,255,255)
	elseif amenu.page == 42 then -- PANTS - More Slacks
		amenu.title = "More Slacks"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Slacks Alt",255,255,255,255)
	elseif amenu.page == 51 then -- SHOES - Shoes
		amenu.title = "Shoes"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Whole cut",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Plain Toe",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Cap Toe",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Square Toe",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Multi-Color Whole Cut",255,255,255,255)
	elseif amenu.page == 52 then -- SHOES - More Shoes
		amenu.title = "More Shoes"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Southern",255,255,255,255)
	end
	
	
	
	
	
	-- ============================== KEY PRESSES ==============================
	
	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		if amenu.row > 1 and amenu.input == 0 then 
			amenu.row = amenu.row-1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		if amenu.page == 0 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 1 then 
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 2 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 3 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 4 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 5 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 11 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 12 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 13 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 21 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 22 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 31 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 32 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 41 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 42 then
			if amenu.row < 1 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 51 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 52 then
			if amenu.row < 1 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
        if amenu.texture > 0 then amenu.texture = amenu.texture -1 end
        if amenu.page > 9 and amenu.page < 20 then
            cStoreTexture.overShirt = amenu.texture
        elseif amenu.page > 20 and amenu.page < 30 then
			if cStoreModel.underShirt then cStoreTexture.underShirt = amenu.texture
			end
        elseif amenu.page > 30 and amenu.page < 40 then
            cStoreTexture.neck = amenu.texture
        elseif amenu.page > 40 and amenu.page < 50 then
            cStoreTexture.legs = amenu.texture
        elseif amenu.page > 50 and amenu.page < 60 then
            cStoreTexture.shoes = amenu.texture
        end
        updateStoreClothes()
    elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
        if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
        if amenu.page > 9 and amenu.page < 20 then
            cStoreTexture.overShirt = amenu.texture
        elseif amenu.page > 20 and amenu.page < 30 then
			if cStoreModel.underShirt then cStoreTexture.underShirt = amenu.texture
			end
        elseif amenu.page > 30 and amenu.page < 40 then
            cStoreTexture.neck = amenu.texture
        elseif amenu.page > 40 and amenu.page < 50 then
            cStoreTexture.legs = amenu.texture
        elseif amenu.page > 50 and amenu.page < 60 then
            cStoreTexture.shoes = amenu.texture
        end
        updateStoreClothes()
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
				amenu.page = 5
				amenu.row = 1
			elseif amenu.row == 6 then
				Wait(50)
				if bankStats.cash >= prices.total then
					TriggerServerEvent("deductMoney", prices.total)
					ShowNotification("Clothes bought!")
					TriggerServerEvent("savePlayerClothes", cStoreModel.armType .. ":" .. cStoreTexture.armType, cStoreModel.legs  .. ":" .. cStoreTexture.legs, model.parachute  .. ":" .. texture.parachute, cStoreModel.shoes .. ":" .. cStoreTexture.shoes, model.neck .. ":" .. texture.neck, cStoreModel.underShirt .. ":" .. cStoreTexture.underShirt, model.armor .. ":" .. texture.armor, cStoreModel.badges .. ":" .. cStoreTexture.badges, cStoreModel.overShirt .. ":" .. cStoreTexture.overShirt, cStoreModel.hat .. ":" .. cStoreTexture.hat, model.glasses .. ":" .. texture.glasses, model.watches .. ":" .. texture.watches, model.tattoos .. ":" .. texture.tattoos)
					saveClothes(1)
					amenu.show = 0
					phone('enable')
					TriggerEvent("AwesomeFreeze", false)
				else
					ShowNotification("~r~You don't have enough cash!")
				end
			end
		elseif amenu.page == 1 then
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				amenu.page = 11
				amenu.row = 1
			elseif amenu.row == 2 then
				amenu.page = 12
				amenu.row = 1
			elseif amenu.row == 3 then
				amenu.page = 13
				amenu.row = 1
			elseif amenu.row == 4 then
				amenu.page = 14
				amenu.row = 1
			elseif amenu.row == 5 then
				amenu.page = 15
				amenu.row = 1
			end
		elseif amenu.page == 2 then
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				amenu.page = 21
				amenu.row = 1
			elseif amenu.row == 2 then
				amenu.page = 22
				amenu.row = 1
			elseif amenu.row == 3 then
				amenu.page = 23
				amenu.row = 1
			elseif amenu.row == 4 then
				amenu.page = 24
				amenu.row = 1
			elseif amenu.row == 5 then
				amenu.page = 25
				amenu.row = 1
			end
		elseif amenu.page == 3 then
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				amenu.page = 31
				amenu.row = 1
			elseif amenu.row == 2 then
				amenu.page = 32
				amenu.row = 1
			elseif amenu.row == 3 then
				amenu.page = 33
				amenu.row = 1
			end
		elseif amenu.page == 4 then
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				amenu.page = 41
				amenu.row = 1
			elseif amenu.row == 2 then
				amenu.page = 42
				amenu.row = 1
			elseif amenu.row == 3 then
				amenu.page = 43
				amenu.row = 1
			elseif amenu.row == 4 then
				amenu.page = 44
				amenu.row = 1
			elseif amenu.row == 5 then
				amenu.page = 45
				amenu.row = 1
			end
		elseif amenu.page == 5 then
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				amenu.page = 51
				amenu.row = 1
			elseif amenu.row == 2 then
				amenu.page = 52
				amenu.row = 1
			elseif amenu.row == 3 then
				amenu.page = 53
				amenu.row = 1
			elseif amenu.row == 4 then
				amenu.page = 54
				amenu.row = 1
			end
		elseif amenu.page == 11 then -- Blazers
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Blazer (Open)
				useClothes('overShirt', 31, 0, 12, 31, 0, 0, 7, 100)
			elseif amenu.row == 2 then -- Blazer (Closed)
				useClothes('overShirt', 32, 0, 12, 31, 0, 0, 7, 100)
			elseif amenu.row == 3 then -- Long Tail Blazer (O)
				useClothes('overShirt', 58, 0, 12, 31, 0, 0, 0, 100)
			elseif amenu.row == 4 then -- Leather Blazer (O)
				useClothes('overShirt', 101, 0, 12, 31, 0, 0, 3, 100)
			elseif amenu.row == 5 then -- Leather Blazer (C)
				useClothes('overShirt', 102, 0, 12, 31, 0, 0, 3, 100)
			end
		elseif amenu.page == 12 then -- Coats
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Trench Coat (O)
				useClothes('overShirt', 77, 0, 12, 31, 0, 0, 3, 100)
			elseif amenu.row == 2 then -- Trench Coat (C)
				useClothes('overShirt', 76, 0, 12, 31, 0, 0, 4, 100)
			end
		elseif amenu.page == 13 then -- Casual
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Vest
				useClothes('overShirt', 11, 0, 11, 6, 0, 0, 1, 100)
            elseif amenu.row == 2 then -- Casual Blazer (O)
				useClothes('overShirt', 59, 0, 12, 31, 0, 0, 7, 100)
			elseif amenu.row == 3 then -- Casual Blazer (C)
				useClothes('overShirt', 60, 0, 11, 31, 0, 0, 7, 100)
			end
		elseif amenu.page == 21 then -- Shirts
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			-- useClothes(types, model1, texture1, arm, model2, texture2, startTexture, endTexture, price)
			if amenu.row == 1 then -- Dress Shirt (T)
				if cStoreModel.overShirt == 31 or cStoreModel.overShirt == 32 or cStoreModel.overShirt == 58 or cStoreModel.overShirt == 101 or cStoreModel.overShirt == 102 or cStoreModel.overShirt == 77 or cStoreModel.overShirt == 76 then useClothes('underShirt', 31, 0, 0, 0, 0, 0, 15, 50)
                elseif cStoreModel.overShirt == 11 then useClothes('overShirt', 11, 0, 11, 6, 0, 1, 100)
                elseif cStoreModel.overShirt == 59 or cStoreModel.overShirt==60 then useClothes('underShirt', 10, 0, 0, 0, 0, 0, 15, 50)
                else ShowNotification("~r~Clothes Incompatible!")
                end
			elseif amenu.row == 2 then -- Dress Shirt (No T)
				if cStoreModel.overShirt == 31 or cStoreModel.overShirt == 32 or cStoreModel.overShirt == 58 or cStoreModel.overShirt == 101 or cStoreModel.overShirt == 102 or cStoreModel.overShirt == 77 or cStoreModel.overShirt == 76 then useClothes('underShirt', 32, 0, 0, 0, 0, 0, 15, 50)
                elseif cStoreModel.overShirt == 11 then useClothes('overShirt', 11, 0, 11, 7, 0, 1, 100)
                elseif cStoreModel.overShirt == 59 or cStoreModel.overShirt==60 then useClothes('underShirt', 11, 0, 0, 0, 0, 0, 15, 50)
                else ShowNotification("~r~Clothes Incompatible!")
                end
			end
		elseif amenu.page == 22 then -- Shirt & Vests
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Vest & Shirt (T)
				if cStoreModel.overShirt == 31 or cStoreModel.overShirt == 58 or cStoreModel.overShirt == 101 or cStoreModel.overShirt == 102 or cStoreModel.overShirt == 77 or cStoreModel.overShirt == 76 then useClothes('underShirt', 33, 0, 0, 0, 0, 0, 6, 50)
                elseif cStoreModel.overShirt == 59 or cStoreModel.overShirt == 60 then useClothes('underShirt', 26, 0, 0, 0, 0, 0, 12, 50)
                elseif cStoreModel.overShirt == 32 then useClothes('underShirt', 35, 0, 0, 0, 0, 0, 6, 50)
                else ShowNotification("~r~Clothes Incompatible!")
                end
			elseif amenu.row == 2 then -- Vest & Shirt (No T)
				if cStoreModel.overShirt == 31 or cStoreModel.overShirt == 32 or cStoreModel.overShirt == 58 or cStoreModel.overShirt == 101 or cStoreModel.overShirt == 102 or cStoreModel.overShirt == 77 or cStoreModel.overShirt == 76 then useClothes('underShirt', 34, 0, 0, 0, 0, 0, 6, 50)
                elseif cStoreModel.overShirt == 59 or cStoreModel.overShirt == 60 then useClothes('underShirt', 25, 0, 0, 0, 0, 0, 12, 50)
                elseif cStoreModel.overShirt == 32 then useClothes('underShirt', 36, 0, 0, 0, 0, 0, 6, 50)
                else ShowNotification("~r~Clothes Incompatible!")
                end
			end
		elseif amenu.page == 31 then -- Ties
			-- useClothes(types, model1, texture1, arm, model2, texture2, startTexture, endTexture, price)
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Tie Regular
				if cStoreModel.underShirt == 10 or cStoreModel.underShirt == 31 then useClothes('neck', 10, 0, 0, 0, 0, 0, 2, 50)
                else ShowNotification("~r~Clothes Incompatible!")
                end
			elseif amenu.row == 2 then -- Tie Variety
				if cStoreModel.underShirt == 26 then useClothes('neck', 24, 0, 0, 0, 0, 0, 15, 50)
                elseif cStoreModel.underShirt == 33 or cStoreModel.underShirt == 35 then useClothes('neck', 26, 0, 0, 0, 0, 0, 15, 50)
				elseif cStoreModel.overShirt == 60 or cStoreModel.overShirt == 32 or cStoreModel.overShirt == 72 or cStoreModel.overShirt == 102 and cStoreModel.underShirt == 31 or cStoreModel.underShirt == 10 then useClothes('neck', 28, 0, 0, 0, 0, 0, 15, 50)
                elseif cStoreModel.underShirt == 10 or cStoreModel.underShirt == 31 then useClothes('neck', 21, 0, 0, 0, 0, 0, 12, 50)
                else ShowNotification("~r~Clothes Incompatible!")
                end
			elseif amenu.row == 3 then -- Slim Tie (R)
				if cStoreModel.underShirt == 10 or cStoreModel.underShirt == 31 then useClothes('neck', 12, 0, 0, 0, 0, 0, 2, 50)
                else ShowNotification("~r~Clothes Incompatible!")
                end
            elseif amenu.row == 4 then -- Slim Tie (V)
				if cStoreModel.underShirt == 26 then useClothes('neck', 25, 0, 0, 0, 0, 0, 15, 50)
                elseif cStoreModel.underShirt == 33 or cStoreModel.underShirt == 35 then useClothes('neck', 27, 0, 0, 0, 0, 0, 15, 50)
				elseif cStoreModel.overShirt == 60 or cStoreModel.overShirt == 32 or cStoreModel.overShirt == 72 or cStoreModel.overShirt == 102 and cStoreModel.underShirt == 31 or cStoreModel.underShirt == 10 then useClothes('neck', 29, 0, 0, 0, 0, 0, 15, 50)
                elseif cStoreModel.underShirt == 10 or cStoreModel.underShirt == 31 then useClothes('neck', 23, 0, 0, 0, 0, 0, 12, 50)
                else ShowNotification("~r~Clothes Incompatible!")
                end
			elseif amenu.row == 5 then -- No Tie
				useClothes('neck', 0, 0, 0, 0, 0, 0, 0, 0)
				ClearPedProp(GetPlayerPed(-1), 0)
			end
		elseif amenu.page == 32 then -- Bow Ties
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Bow Tie Formal
				if cStoreModel.overShirt == 31 or cStoreModel.overShirt == 32 or cStoreModel.overShirt == 11 or cStoreModel.overShirt == 58 or cStoreModel.overShirt == 59 or cStoreModel.overShirt == 60 or cStoreModel.overShirt == 101 or cStoreModel.overShirt == 102 or cStoreModel.overShirt == 77 or cStoreModel.overShirt == 76 and cStoreModel.underShirt == 10 or cStoreModel.underShirt == 31 or cStoreModel.underShirt == 33 or cStoreModel.underShirt == 35 or cStoreModel.underShirt == 26 then useClothes('neck', 22, 0, 0, 0, 0, 0, 14, 50)
                else ShowNotification("~r~Clothes Incompatible!")
                end
			elseif amenu.row == 2 then -- Bow Tie Casual
				if cStoreModel.overShirt == 31 or cStoreModel.overShirt == 32 or cStoreModel.overShirt == 11 or cStoreModel.overShirt == 58 or cStoreModel.overShirt == 59 or cStoreModel.overShirt == 60 or cStoreModel.overShirt == 101 or cStoreModel.overShirt == 102 or cStoreModel.overShirt == 77 or cStoreModel.overShirt == 76 and cStoreModel.underShirt == 10 or cStoreModel.underShirt == 31 or cStoreModel.underShirt == 33 or cStoreModel.underShirt == 35 or cStoreModel.underShirt == 26 then useClothes('neck', 32, 0, 0, 0, 0, 0, 2, 50)
                else ShowNotification("~r~Clothes Incompatible!")
                end
			end
		elseif amenu.page == 41 then -- Slacks
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			-- useClothes(types, model1, texture1, arm, model2, texture2, startTexture, endTexture, price)
			if amenu.row == 1 then -- Slacks Reg
				useClothes('legs', 25, 0, 0, 0, 0, 0, 6, 75)
			elseif amenu.row == 2 then -- Slacks Slim
				useClothes('legs', 24, 0, 0, 0, 0, 0, 6, 75)
			elseif amenu.row == 3 then -- Leather Slacks Reg
				useClothes('legs', 50, 0, 0, 0, 0, 0, 3, 75)
			elseif amenu.row == 4 then -- Leather Slacks Slim
				useClothes('legs', 52, 0, 0, 0, 0, 0, 3, 75)
			elseif amenu.row == 5 then -- Slacks Casual
				useClothes('legs', 37, 0, 0, 0, 0, 0, 3, 75)
			end
		elseif amenu.page == 42 then -- More Slacks
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Slacks Alt
				useClothes('legs', 48, 0, 0, 0, 0, 0, 4, 75)
			end
		elseif amenu.page == 51 then -- Shoes
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Whole Cut
				useClothes('shoes', 10, 0, 0, 0, 0, 0, 0, 50)
			elseif amenu.row == 2 then -- Plain Toe
				useClothes('shoes', 15, 0, 0, 0, 0, 0, 15, 50)
			elseif amenu.row == 3 then -- Cap Toe
				useClothes('shoes', 20, 0, 0, 0, 0, 0, 11, 50)
			elseif amenu.row == 4 then -- Square Toe
				useClothes('shoes', 21, 0, 0, 0, 0, 0, 11, 50)
			elseif amenu.row == 5 then -- MC Whole Cut
				useClothes('shoes', 40, 0, 0, 0, 0, 0, 11, 50)
			end
		elseif amenu.page == 52 then -- More Shoes
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Southern
				useClothes('shoes', 38, 0, 0, 0, 0, 0, 4, 50)
			end
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 then
			amenu.show = 0
			updateClothes()
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
			amenu.row = 3
		elseif amenu.page == 4 then
			amenu.page = 0 
			amenu.row = 4
		elseif amenu.page == 5 then
			amenu.page = 0 
			amenu.row = 5
		elseif amenu.page == 11 then
			amenu.page = 1 
			amenu.row = 1
		elseif amenu.page == 12 then
			amenu.page = 1 
			amenu.row = 2
		elseif amenu.page == 13 then
			amenu.page = 1 
			amenu.row = 3
		elseif amenu.page == 14 then
			amenu.page = 1 
			amenu.row = 4
		elseif amenu.page == 15 then
			amenu.page = 1 
			amenu.row = 5
		elseif amenu.page == 21 then
			amenu.page = 2
			amenu.row = 1
		elseif amenu.page == 22 then
			amenu.page = 2
			amenu.row = 2
		elseif amenu.page == 23 then
			amenu.page = 2
			amenu.row = 3
		elseif amenu.page == 24 then
			amenu.page = 2
			amenu.row = 4
		elseif amenu.page == 25 then
			amenu.page = 2
			amenu.row = 5
		elseif amenu.page == 31 then
			amenu.page = 3
			amenu.row = 1
		elseif amenu.page == 32 then
			amenu.page = 3
			amenu.row = 2
		elseif amenu.page == 33 then
			amenu.page = 3
			amenu.row = 3
		elseif amenu.page == 41 then
			amenu.page = 4
			amenu.row = 1
		elseif amenu.page == 42 then
			amenu.page = 4
			amenu.row = 2
		elseif amenu.page == 43 then
			amenu.page = 4
			amenu.row = 3
		elseif amenu.page == 44 then
			amenu.page = 4
			amenu.row = 4
		elseif amenu.page == 45 then
			amenu.page = 4
			amenu.row = 5
		elseif amenu.page == 51 then
			amenu.page = 5
			amenu.row = 1
		elseif amenu.page == 52 then
			amenu.page = 5
			amenu.row = 2
		elseif amenu.page == 53 then
			amenu.page = 5
			amenu.row = 3
		elseif amenu.page == 54 then
			amenu.page = 5
			amenu.row = 4
		end
	end
end




	-- ============================== MENU FUNCTIONS ==============================

function updateStoreClothes()
    local myPed = GetPlayerPed(-1)
    SetPedComponentVariation(myPed, 3, cStoreModel.armType, cStoreTexture.armType, 0)
    SetPedComponentVariation(myPed, 4, cStoreModel.legs, cStoreTexture.legs, 0)
    SetPedComponentVariation(myPed, 5, cStoreModel.parachute, cStoreTexture.parachute, 0)
    SetPedComponentVariation(myPed, 6, cStoreModel.shoes, cStoreTexture.shoes, 0)
    SetPedComponentVariation(myPed, 7, cStoreModel.neck, cStoreTexture.neck, 0)
    SetPedComponentVariation(myPed, 8, cStoreModel.underShirt, cStoreTexture.underShirt, 0)
    SetPedComponentVariation(myPed, 9, cStoreModel.armor, cStoreTexture.armor, 0)
    SetPedComponentVariation(myPed, 10, cStoreModel.badges, cStoreTexture.badges, 0)
    SetPedComponentVariation(myPed, 11, cStoreModel.overShirt, cStoreTexture.overShirt, 0)
    SetPedPropIndex(myPed, 0, cStoreModel.hat, cStoreTexture.hat, true)
	if cStoreModel.hat == 11 or cStoreModel.hat == 0 then
		ClearPedProp(myPed, 0)
	end
	SetPedPropIndex(myPed, 1, cStoreModel.glasses, cStoreTexture.glasses, true)
	if cStoreModel.glasses == 6 or cStoreModel.glasses == 0 then
		ClearPedProp(myPed, 1)
	end
end

function useProp(types, model, texture, startTexture, endTexture, price)
    if types == 'hat' then
        cStoreModel.hat = model
        cStoreTexture.hat = texture
        prices.hat = price
    elseif types == 'glasses' then
        cStoreModel.glasses = model
        cStoreTexture.glasses = texture
        prices.glasses = price
    end
    amenu.texture = startTexture
    amenu.maxTexture = endTexture
    updateStoreClothes()
end

function useClothes(types, model1, texture1, arm, model2, texture2, startTexture, endTexture, price)
	if types == 'overShirt' then
		cStoreModel.overShirt = model1
		cStoreTexture.overShirt = texture1
		cStoreModel.armType = arm
		cStoreModel.underShirt = model2
		cStoreTexture.underShirt = texture2
		prices.overShirt = price
		cStoreModel.badges = 0
		cStoreTexture.badges = 0
	elseif types == 'underShirt' then
		cStoreModel.underShirt = model1
		cStoreTexture.underShirt = texture1
		prices.underShirt = price
		cStoreModel.badges = 0
		cStoreTexture.badges = 0
	elseif types == 'legs' then
		cStoreModel.legs = model1
		cStoreTexture.legs = texture1
		prices.legs = price
	elseif types == 'shoes' then
		cStoreModel.shoes = model1
		cStoreTexture.shoes = texture1
		prices.shoes = price
	elseif types == 'jacket' then
		checkShirt(model2)
		cStoreModel.overShirt = model1
		cStoreTexture.overShirt = texture1
		cStoreModel.armType = arm
		prices.overShirt = price
		cStoreModel.badges = 0
		cStoreTexture.badges = 0
	elseif types == 'neck' then
		cStoreModel.neck = model1
		cStoreTexture.neck = texture1
		prices.neck = price
	end
	amenu.texture = startTexture
	amenu.maxTexture = endTexture
	updateStoreClothes()
end

function checkShirt(types)
	if cStoreModel.overShirt == 0 or cStoreModel.underShirt == 0 or cStoreModel.underShirt == 2 then
		if types == 0 then cStoreModel.underShirt = 0 end
		if types == 1 then cStoreModel.underShirt = 2 end
		if cStoreModel.overShirt == 0 then cStoreTexture.underShirt = cStoreTexture.overShirt end
	elseif cStoreModel.overShirt == 1 or cStoreModel.underShirt == 1 or cStoreModel.underShirt == 14 then
		if types == 0 then cStoreModel.underShirt = 1 end
		if types == 1 then cStoreModel.underShirt = 14 end
		if cStoreModel.overShirt == 1 then cStoreTexture.underShirt = cStoreTexture.overShirt end
	elseif cStoreModel.overShirt == 8 or cStoreModel.underShirt == 8 then
		cStoreModel.underShirt = 8
		cStoreTexture.underShirt = cStoreTexture.overShirt
		if types == 1 then cStoreModel.underShirt = 2 cStoreTexture.underShirt = 4 end
	elseif cStoreModel.overShirt == 9 or cStoreModel.underShirt == 9 then
		cStoreModel.underShirt = 9
		cStoreTexture.underShirt = cStoreTexture.overShirt
		if types == 1 then cStoreModel.underShirt = 2 cStoreTexture.underShirt = 4 end	
	elseif cStoreModel.overShirt == 12 or cStoreModel.underShirt == 12 then
		cStoreModel.underShirt = 12
		cStoreTexture.underShirt = cStoreTexture.overShirt
		if types == 1 then cStoreModel.underShirt = 2 cStoreTexture.underShirt = 4 end
	elseif cStoreModel.overShirt == 13 or cStoreModel.underShirt == 13 then
		cStoreModel.underShirt = 13
		if cStoreModel.overShirt == 13 then cStoreTexture.underShirt = cStoreTexture.overShirt end
	elseif cStoreModel.overShirt == 14 or cStoreModel.underShirt == 29 or cStoreModel.underShirt == 30 then
		if types == 0 then cStoreModel.underShirt = 29 end
		if types == 1 then cStoreModel.underShirt = 30 end
		if cStoreModel.overShirt == 14 then cStoreTexture.underShirt = cStoreTexture.overShirt end
	elseif cStoreModel.overShirt == 16 or cStoreModel.underShirt == 16 or cStoreModel.underShirt == 18 then
		if types == 0 then cStoreModel.underShirt = 16 end
		if types == 1 then cStoreModel.underShirt = 18 end
		if cStoreModel.overShirt == 16 then cStoreTexture.underShirt = cStoreTexture.overShirt end
	elseif cStoreModel.overShirt == 22 or cStoreModel.underShirt == 23 or cStoreModel.underShirt == 24 then
		if types == 0 then cStoreModel.underShirt = 23 end
		if types == 1 then cStoreModel.underShirt = 24 end
		if cStoreModel.overShirt == 22 then cStoreTexture.underShirt = cStoreTexture.overShirt end
	elseif cStoreModel.overShirt == 38 or cStoreModel.underShirt == 41 then
		cStoreModel.underShirt = 41
		cStoreTexture.underShirt = cStoreTexture.overShirt
		if types == 1 then cStoreModel.underShirt = 2 cStoreTexture.underShirt = 4 end	
	elseif cStoreModel.overShirt == 41 or cStoreModel.underShirt == 43 then
		cStoreModel.underShirt = 43
		cStoreTexture.underShirt = cStoreTexture.overShirt
		if types == 1 then cStoreModel.underShirt = 2 cStoreTexture.underShirt = 4 end
	elseif cStoreModel.overShirt == 43 or cStoreModel.underShirt == 46 then
		cStoreModel.underShirt = 46
		cStoreTexture.underShirt = cStoreTexture.overShirt
		if types == 1 then cStoreModel.underShirt = 2 cStoreTexture.underShirt = 4 end
	elseif cStoreModel.overShirt == 47 or cStoreModel.underShirt == 53 or cStoreModel.underShirt == 54 then
		if types == 0 then cStoreModel.underShirt = 53 end
		if types == 1 then cStoreModel.underShirt = 54 end
		if cStoreModel.overShirt == 47 then cStoreTexture.underShirt = cStoreTexture.overShirt end	
	elseif cStoreModel.overShirt == 73 or cStoreModel.underShirt == 65 or cStoreModel.underShirt == 66 then
		if types == 0 then cStoreModel.underShirt = 65 end
		if types == 1 then cStoreModel.underShirt = 66 end
		if cStoreModel.overShirt == 73 then cStoreTexture.underShirt = cStoreTexture.overShirt end	
	elseif cStoreModel.overShirt == 139 or cStoreModel.underShirt == 75 then
		cStoreModel.underShirt = 75
		if cStoreModel.overShirt == 139 then cStoreTexture.underShirt = cStoreTexture.overShirt end	
	else
		if types == 0 then cStoreModel.underShirt = 0 end
		if types == 1 then cStoreModel.underShirt = 2 end
		cStoreTexture.underShirt = 4
	end
end

function saveClothes(types)
	if types == 0 then
		cStoreModel.armType = model.armType
		cStoreModel.legs = model.legs
		cStoreModel.parachute = model.parachute
		cStoreModel.shoes = model.shoes
		cStoreModel.neck = model.neck
		cStoreModel.underShirt = model.underShirt
		cStoreModel.armor = model.armor
		cStoreModel.badges = model.badges
		cStoreModel.overShirt = model.overShirt
		cStoreModel.hat = model.hat
		cStoreTexture.armType = texture.armType
		cStoreTexture.legs = texture.legs
		cStoreTexture.parachute = texture.parachute
		cStoreTexture.shoes = texture.shoes
		cStoreTexture.neck = texture.neck
		cStoreTexture.underShirt = texture.underShirt
		cStoreTexture.armor = texture.armor
		cStoreTexture.badges = texture.badges
		cStoreTexture.overShirt = texture.overShirt
		cStoreTexture.hat = texture.hat
	elseif types == 1 then
		model.armType = cStoreModel.armType
		model.legs = cStoreModel.legs
		model.parachute = cStoreModel.parachute
		model.shoes = cStoreModel.shoes
		model.neck = cStoreModel.neck
		model.underShirt = cStoreModel.underShirt
		model.armor = cStoreModel.armor
		model.badges = cStoreModel.badges
		model.overShirt = cStoreModel.overShirt
		model.hat = cStoreModel.hat
		texture.armType = cStoreTexture.armType
		texture.legs = cStoreTexture.legs
		texture.parachute = cStoreTexture.parachute
		texture.shoes = cStoreTexture.shoes
		texture.neck = cStoreTexture.neck
		texture.underShirt = cStoreTexture.underShirt
		texture.armor = cStoreTexture.armor
		texture.badges = cStoreTexture.badges
		texture.overShirt = cStoreTexture.overShirt
		texture.hat = cStoreTexture.hat
	end
end