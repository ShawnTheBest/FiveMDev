--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local totalClothingPrice = 0
local sure = false

function showLowClothesMenu_m()
	bankStats.account = getBank('account')
	bankStats.cash = getBank('cash')
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.075, 0.0, 0.0, 0.55, "Clothing Store",255,255,255,255)
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
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Headwear",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Shirts",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Jackets",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Pants",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Shoes",255,255,255,255)
		prices.total = prices.hat+prices.underShirt+prices.overShirt+prices.legs+prices.shoes
		drawTxt(0.795, 0.41, 0.0, 0.0, 0.35, "Purchase: ~g~$" .. prices.total,255,255,255,255)
		if amenu.row == 1 then DrawRect(0.87, 0.19, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 2 then DrawRect(0.87, 0.23, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 3 then DrawRect(0.87, 0.27, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 4 then DrawRect(0.87, 0.31, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 5 then DrawRect(0.87, 0.35, 0.16, 0.034, 255, 255, 255, 255) end
		if amenu.row == 6 then DrawRect(0.87, 0.43, 0.16, 0.034, 255, 255, 255, 255) end
	elseif amenu.page == 1 then 
		amenu.title = "HEADWEAR"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Hats ~g~$20",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "More Hats ~g~$20",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Head Accessories ~g~$50",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Helmets ~g~$30",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Caps ~g~$25",255,255,255,255)
	elseif amenu.page == 2 then
		amenu.title = "SHIRTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "T-Shirts ~g~$10",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Polos ~g~$15",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Shirts ~g~$15",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Sweaters ~g~$20",255,255,255,255)
	elseif amenu.page == 3 then
		amenu.title = "JACKETS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Leather ~g~$35",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Athletic ~g~$30",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Outerwear ~g~$30",255,255,255,255)
	elseif amenu.page == 4 then
		amenu.title = "PANTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Jeans ~g~$15",255,255,255,255)	
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Shorts ~g~$10",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Athletic ~g~$12",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Work Pants ~g~$20",255,255,255,255)
	elseif amenu.page == 5 then
		amenu.title = "SHOES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Casual ~g~$20",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Athletic ~g~$30",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Boots ~g~$35",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Loungewear ~g~$20",255,255,255,255)
	elseif amenu.page == 11 then -- HEADWEAR - Hats
		amenu.title = "HATS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Baseball Hat",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Backwards Hat",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Flat Brim Hat",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Cowboy Hat",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Bucket Hat",255,255,255,255)
	elseif amenu.page == 12 then -- HEADWEAR - More Hats
		amenu.title = "MORE HATS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Beret",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Bowler Hat",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Snapback Hat",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Backwards Snap",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "No Hat",255,255,255,255)
	elseif amenu.page == 13 then -- HEADWEAR - Head Accessories
		amenu.title = "HEAD ACCESSORIES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Prescription Glasses",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Head Phones",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "No Glasses",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Wayfarer",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Sunglasses",255,255,255,255)
	elseif amenu.page == 14 then -- HEADWEAR - Helmets
		amenu.title = "HELMETS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Army Cap",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Dirtbike Helmet",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Motorbike Helmet",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Motorcycle Helmet",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Bandana",255,255,255,255)
	elseif amenu.page == 15 then -- HEADWEAR - Caps
		amenu.title = "CAPS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Beanie (Medium)",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Beanie (Small)",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Fedora",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Pork Pie Hat",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Top Hat",255,255,255,255)
	elseif amenu.page == 21 then -- SHIRTS - T-Shirts
		amenu.title = "T-SHIRTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Regular",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "V-Neck",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Baseball",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Designer",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Oversized",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Classic",255,255,255,255)
	elseif amenu.page == 22 then -- SHIRTS - Polos
		amenu.title = "POLOS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Regular",255,255,255,255)
		if model.gender == 'male' then drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Oversized",255,255,255,255) end
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "No Shirt",255,255,255,255)
	elseif amenu.page == 23 then -- SHIRTS - Shirts
		amenu.title = "SHIRTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Casual",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Tucked",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Layered",255,255,255,255)
		drawTxt(0.795, 0.37, 0.0, 0.0, 0.35, "Jean",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Closed Flannel",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Open Flannel",255,255,255,255)
	elseif amenu.page == 24 then -- SHIRTS - Sweaters
		amenu.title = "SWEATERS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Open Hoodie",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Closed Hoodie",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Long Sleeve",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Turtle Neck",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Zip Up",255,255,255,255)
	elseif amenu.page == 31 then -- JACKETS - Leather
		amenu.title = "LEATHER"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Open Leather",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Closed Leather",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Jock Jacket",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Racing Jacket",255,255,255,255)
	elseif amenu.page == 32 then -- JACKETS - Athletic
		amenu.title = "ATHLETIC"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Sports Jacket",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Running Jacket",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Letterman Open",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Letterman Closed",255,255,255,255)
	elseif amenu.page == 33 then -- JACKETS - Outerwear
		amenu.title = "OUTERWEAR"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Rain Jacket Down",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Rain Jacket Up",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Wind Jacket",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Quilted Jacket",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Leather Coat",255,255,255,255)
	elseif amenu.page == 41 then -- PANTS - Jeans
		amenu.title = "JEANS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Regular",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Low Jeans",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Skinny",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Hipster Skinny",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Designer Jeans",255,255,255,255)
	elseif amenu.page == 42 then -- PANTS - Shorts
		amenu.title = "SHORTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Regular",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Capri Jeans",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Short Shorts",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Long Shorts",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Cargo Shorts",255,255,255,255)
	elseif amenu.page == 43 then -- PANTS - Athletic
		amenu.title = "ATHLETIC"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Regular Sweats",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Baggy Sweats",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Swim Shorts",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Swim Shorts 2",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Swim Shorts 3",255,255,255,255)
	elseif amenu.page == 44 then -- PANTS - Work Pants
		amenu.title = "WORK PANTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Regular",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Cargo Pants",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Chinos",255,255,255,255)
	elseif amenu.page == 51 then -- SHOES - Casual
		amenu.title = "CASUAL"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Skate Shoes",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Sneakers",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "High Tops",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Vans",255,255,255,255)
	elseif amenu.page == 52 then -- SHOES - Athletic
		amenu.title = "ATHLETIC"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Tennis Shoes",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Basketball",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "No Shoes",255,255,255,255)
	elseif amenu.page == 53 then -- SHOES - Boots
		amenu.title = "BOOTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Work Boots",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Duty Boots",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Hiking Boots",255,255,255,255)
	elseif amenu.page == 54 then -- SHOES - Loungewear
		amenu.title = "LOUNGEWEAR"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Boat Shoes",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Flip Flops",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Socks & Sandals",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Moccasins",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Slippers",255,255,255,255)
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
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 2 then
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 3 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 4 then
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 5 then
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 11 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 12 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 13 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 14 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end	
		elseif amenu.page == 15 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 21 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 22 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 23 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 24 then
			if amenu.row < 5 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end	
		elseif amenu.page == 31 then
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 32 then
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 33 then
			if amenu.row < 5 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 41 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 42 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 43 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 44 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 51 then
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 52 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 53 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 54 then
			if amenu.row < 5 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		if amenu.page == 13 then
			if amenu.texture >0 then amenu.texture = amenu.texture -1 end
			cStoreTexture.glasses = amenu.texture
		elseif amenu.page > 9 and amenu.page < 13 or amenu.page > 13 and amenu.page < 20 then
			if amenu.texture >0 then amenu.texture = amenu.texture -1 end
			cStoreTexture.hat = amenu.texture
		elseif amenu.page == 21 then -- T-Shirts
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 0 or cStoreModel.overShirt == 47 then -- Regular
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 6 then cStoreTexture.overShirt = 8
				elseif amenu.texture == 9 then cStoreModel.overShirt = 47 cStoreTexture.overShirt = 0
				elseif amenu.texture == 10 then cStoreModel.overShirt = 47 cStoreTexture.overShirt = 1
				else cStoreModel.overShirt = 0 cStoreTexture.overShirt = amenu.texture end
			elseif cStoreModel.underShirt == 0 or cStoreModel.underShirt == 2 or cStoreModel.underShirt == 53 or cStoreModel.underShirt == 54 then -- t-shirt underShirt variation
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 6 then cStoreTexture.underShirt = 8
				elseif amenu.texture == 9 then 
					if cStoreModel.underShirt == 0 then cStoreModel.underShirt = 53 cStoreTexture.underShirt = 0 end
					if cStoreModel.underShirt == 2 then cStoreModel.underShirt = 54 cStoreTexture.underShirt = 0 end
				elseif amenu.texture == 10 then 
					if cStoreModel.underShirt == 0 or cStoreModel.underShirt == 53 then cStoreModel.underShirt = 53 cStoreTexture.underShirt = 1 end
					if cStoreModel.underShirt == 2 or cStoreModel.underShirt == 54 then cStoreModel.underShirt = 54 cStoreTexture.underShirt = 1 end
				else
					if cStoreModel.underShirt == 0 or cStoreModel.underShirt == 53 then cStoreModel.underShirt = 0 cStoreTexture.underShirt = amenu.texture end
					if cStoreModel.underShirt == 2 or cStoreModel.underShirt == 54 then cStoreModel.underShirt = 2 cStoreTexture.underShirt = amenu.texture end
				end
			elseif cStoreModel.overShirt == 1 or cStoreModel.overShirt == 16 then -- V-Neck
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 2 then
					cStoreModel.overShirt = 1
					cStoreTexture.overShirt = 14
				elseif amenu.texture == 9 then
					cStoreModel.overShirt = 1
					cStoreTexture.overShirt = 11
				elseif amenu.texture == 10 then
					cStoreModel.overShirt = 1
					cStoreTexture.overShirt = 12
				elseif amenu.texture > 10 then
					cStoreModel.overShirt = 16
					cStoreTexture.overShirt = amenu.texture-11
				else
					cStoreModel.overShirt = 1
					cStoreTexture.overShirt = amenu.texture
				end
			elseif cStoreModel.underShirt == 1 or cStoreModel.underShirt == 14 or cStoreModel.underShirt == 16 or cStoreModel.underShirt == 18 then -- underShirt variation
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 2 then
					cStoreTexture.underShirt = 14
				elseif amenu.texture == 9 then
					cStoreTexture.underShirt = 11
				elseif amenu.texture == 10 then
					if cStoreModel.underShirt == 1 or cStoreModel.underShirt == 16 then cStoreModel.underShirt = 1 end
					if cStoreModel.underShirt == 14 or cStoreModel.underShirt == 18 then cStoreModel.underShirt = 14 end
					cStoreTexture.underShirt = 12
				elseif amenu.texture > 10 then
					if cStoreModel.underShirt == 1 then cStoreModel.underShirt = 16
					elseif cStoreModel.underShirt == 14 then cStoreModel.underShirt = 18 end
					cStoreTexture.underShirt = amenu.texture-11
				else
					if cStoreModel.underShirt == 1 or cStoreModel.underShirt == 16 then cStoreModel.underShirt = 1 end
					if cStoreModel.underShirt == 14 or cStoreModel.underShirt == 18 then cStoreModel.underShirt = 14 end
					cStoreTexture.underShirt = amenu.texture
				end
			elseif cStoreModel.overShirt == 8 or cStoreModel.overShirt == 38 then -- Baseball
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 0 then
					cStoreModel.overShirt = 8
					cStoreTexture.overShirt = 0
				elseif amenu.texture == 1 then
					cStoreModel.overShirt = 8
					cStoreTexture.overShirt = 10
				elseif amenu.texture == 2 then
					cStoreModel.overShirt = 8
					cStoreTexture.overShirt = 13
				elseif amenu.texture == 3 then
					cStoreModel.overShirt = 8
					cStoreTexture.overShirt = 14
				elseif amenu.texture > 3 then
					cStoreModel.overShirt = 38
					cStoreTexture.overShirt = amenu.texture-4
				end
			elseif cStoreModel.underShirt == 8 then -- Baseball underShirt variation
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 0 then cStoreTexture.underShirt = 0
				elseif amenu.texture == 1 then cStoreTexture.underShirt = 10
				elseif amenu.texture == 2 then cStoreTexture.underShirt = 13
				elseif amenu.texture == 3 then cStoreTexture.underShirt = 14 end
			elseif cStoreModel.overShirt == 73 then -- Designer
				
			elseif cStoreModel.overShirt == 80 or cStoreModel.overShirt == 81 then -- Oversized
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture > 2 then 
					cStoreModel.overShirt = 81
					cStoreTexture.overShirt = amenu.texture-3
				else
					cStoreModel.overShirt = 80
					cStoreTexture.overShirt = amenu.texture 
				end
			elseif cStoreModel.overShirt == 135 or cStoreModel.overShirt == 105 then -- Classic
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 7 then 
					cStoreModel.overShirt = 105
					cStoreTexture.overShirt = 0
				else
					cStoreModel.overShirt = 135
					cStoreTexture.overShirt = amenu.texture 
				end
			end
		elseif amenu.page == 22 then -- Polos
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 9 then -- Regular
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 8 then cStoreTexture.overShirt = 14
				elseif amenu.texture == 9 then cStoreTexture.overShirt = 15
				else cStoreTexture.overShirt = amenu.texture end
			elseif cStoreModel.underShirt == 9 then -- Regular under variation
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 8 then cStoreTexture.underShirt = 14
				elseif amenu.texture == 9 then cStoreTexture.underShirt = 15
				else cStoreTexture.underShirt = amenu.texture end
			elseif cStoreModel.overShirt == 82 then -- Oversized
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			end
		elseif amenu.page == 23 then -- Shirts
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 12 then -- Casual
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.underShirt == 12 then -- Casual underShirt variation
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.underShirt = amenu.texture
			elseif cStoreModel.overShirt == 13 or cStoreModel.overShirt == 26 then -- Tucked
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 4 then
					cStoreModel.overShirt = 13
					cStoreTexture.overShirt = 5
				elseif amenu.texture == 5 then
					cStoreModel.overShirt = 26
					cStoreTexture.overShirt = 2
				elseif amenu.texture > 5 then
					cStoreModel.overShirt = 26
					cStoreTexture.overShirt = amenu.texture-2
				else
					cStoreModel.overShirt = 13
					cStoreTexture.overShirt = amenu.texture
				end
			elseif cStoreModel.underShirt == 13 or cStoreModel.underShirt == 27 then -- Tucked underShirt variation
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 4 then
					cStoreModel.underShirt = 13
					cStoreTexture.underShirt = 5
				elseif amenu.texture == 5 then
					cStoreModel.underShirt = 27
					cStoreTexture.underShirt = 2
				elseif amenu.texture > 5 then
					cStoreModel.underShirt = 27
					cStoreTexture.underShirt = amenu.texture-2
				else
					cStoreModel.underShirt = 13
					cStoreTexture.underShirt = amenu.texture
				end
			elseif cStoreModel.overShirt == 41 or cStoreModel.overShirt == 126 then -- Closed Flannel
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture <= 3 then
					cStoreModel.overShirt = 41
					cStoreTexture.overShirt = amenu.texture
				else
					cStoreModel.overShirt = 126
					cStoreTexture.overShirt = amenu.texture-4
				end
			elseif cStoreModel.underShirt == 43 then -- Closed Flannel underShirt variation
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.underShirt = amenu.texture
			elseif cStoreModel.overShirt == 127 then -- Open Flannel
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 14 then -- Layered
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.underShirt == 29 or cStoreModel.underShirt == 30 then -- Layered underShirt variation
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.underShirt = amenu.texture
			elseif cStoreModel.overShirt == 42 then -- Jean
				
			end
		elseif amenu.page == 24 then -- Sweaters
			updateStoreClothes()
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 7 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 86 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 89 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 139 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.underShirt == 74 or cStoreModel.underShirt == 75 then -- underShirt variation
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.underShirt = amenu.texture
			elseif cStoreModel.overShirt == 61 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			end
		elseif amenu.page == 31 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 62 then
			
			elseif cStoreModel.overShirt == 37 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 156 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 6 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 2 then
					cStoreTexture.overShirt = 11
				elseif amenu.texture == 7 then
					cStoreTexture.overShirt = 9
				else
					cStoreTexture.overShirt = amenu.texture
				end
			end
		elseif amenu.page == 32 then -- Athletic
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 3 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 113 or cStoreModel.overShirt == 141 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture > 3 then
					cStoreModel.overShirt = 141
					cStoreTexture.overShirt = amenu.texture-4
				else
					cStoreModel.overShirt = 113
					cStoreTexture.overShirt = amenu.texture
				end
			elseif cStoreModel.overShirt == 88 or cStoreModel.overShirt == 87 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			end
		elseif amenu.page == 33 then -- Outerwear
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 69 or cStoreModel.overShirt == 68 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 124 then
				
			elseif cStoreModel.overShirt == 136 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 138 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.overShirt = amenu.texture
			end
		elseif amenu.page == 41 then -- Pants
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.legs == 75 or cStoreModel.legs == 1 or cStoreModel.legs == 82 or cStoreModel.legs == 78 or cStoreModel.legs == 76 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.legs = amenu.texture
			end
		elseif amenu.page == 42 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.legs == 6 or cStoreModel.legs == 80 or cStoreModel.legs == 18 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 42 or cStoreModel.legs == 62 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture > 7 then 
					cStoreModel.legs = 62
					cStoreTexture.legs = amenu.texture-8
				else
					cStoreModel.legs = 42
					cStoreTexture.legs = amenu.texture
				end
			elseif cStoreModel.legs == 14 then
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 0 then
					cStoreTexture.legs = 0
				elseif amenu.texture == 1 then
					cStoreTexture.legs = 1
				elseif amenu.texture == 2 then
					cStoreTexture.legs = 12
				end
			end
		elseif amenu.page == 43 then -- Athletic
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.legs == 3 then -- Regular
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 5 or cStoreModel.legs == 64 then -- Baggy
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture > 15 then
					cStoreModel.legs = 64
					cStoreTexture.legs = amenu.texture-15
				else
					cStoreModel.legs = 5
					cStoreTexture.legs = amenu.texture
				end
			elseif cStoreModel.legs == 6 then -- Swim
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 16 then -- Swim 2
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 54 then -- Swim 3
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.legs = amenu.texture
			end
		elseif amenu.page == 44 then -- Work Pants
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.legs == 7 or cStoreModel.legs == 9 or cStoreModel.legs == 27 then -- Regular, Cargo, Chinos
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.legs = amenu.texture
			end
		elseif amenu.page == 51 then -- Casual
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.shoes == 1 then -- Skate Shoes
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 7 or cStoreModel.shoes == 8 or cStoreModel.shoes == 9 then -- Sneakers
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture > 15 and amenu.texture < 30 then
					cStoreModel.shoes = 8
					cStoreTexture.shoes = amenu.texture-15
				elseif amenu.texture >= 30 then
					cStoreModel.shoes = 9
					cStoreTexture.shoes = amenu.texture-30
				else
					cStoreModel.shoes = 7
					cStoreTexture.shoes = amenu.texture
				end
			elseif cStoreModel.shoes == 26 then -- High Tops
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture == 10 then
					cStoreTexture.shoes = 15
				else
					cStoreTexture.shoes = amenu.texture
				end
			elseif cStoreModel.shoes == 42 then --Vans
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.shoes = amenu.texture
			end
		elseif amenu.page == 52 then -- Athletic
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.shoes == 31 then -- Sneakers
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 32 or cStoreModel.shoes == 46 then -- Basketball
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				if amenu.texture > 15 then
					cStoreModel.shoes = 46
					cStoreTexture.shoes = amenu.texture-15
				else
					cStoreModel.shoes = 32
					cStoreTexture.shoes = amenu.texture
				end
			end
		elseif amenu.page == 53 then -- Boots 
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.shoes == 12 then -- Work Boots
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 24 then -- Duty Boots
				
			elseif cStoreModel.shoes == 14 then -- Hiking Boots
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.shoes = amenu.texture
			end
		elseif amenu.page == 54 then -- Loungewear
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.shoes == 3 then -- Boat Shoes
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 5 then -- Flip Flops
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 6 then -- Socks & Sandals
				
			elseif cStoreModel.shoes == 36 then -- Moccasins
				if amenu.texture > 0 then amenu.texture = amenu.texture - 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 41 then -- Slippers
				
			end
		end
		updateStoreClothes()
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
		if amenu.page == 13 then
			if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
			cStoreTexture.glasses = amenu.texture
		elseif amenu.page > 9 and amenu.page < 13 or amenu.page > 13 and amenu.page < 20 then
			if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
			cStoreTexture.hat = amenu.texture
		elseif amenu.page == 21 then -- T-Shirts
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 0 or cStoreModel.overShirt == 47 then -- Regular
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 6 then cStoreTexture.overShirt = 8
				elseif amenu.texture == 9 then cStoreModel.overShirt = 47 cStoreTexture.overShirt = 0
				elseif amenu.texture == 10 then cStoreModel.overShirt = 47 cStoreTexture.overShirt = 1
				else cStoreModel.overShirt = 0 cStoreTexture.overShirt = amenu.texture end
			elseif cStoreModel.underShirt == 0 or cStoreModel.underShirt == 2 or cStoreModel.underShirt == 53 or cStoreModel.underShirt == 54 then -- t-shirt underShirt variation
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 6 then cStoreTexture.underShirt = 8
				elseif amenu.texture == 9 then 
					if cStoreModel.underShirt == 0 then cStoreModel.underShirt = 53 cStoreTexture.underShirt = 0 end
					if cStoreModel.underShirt == 2 then cStoreModel.underShirt = 54 cStoreTexture.underShirt = 0 end
				elseif amenu.texture == 10 then 
					if cStoreModel.underShirt == 0 or cStoreModel.underShirt == 53 then cStoreModel.underShirt = 53 cStoreTexture.underShirt = 1 end
					if cStoreModel.underShirt == 2 or cStoreModel.underShirt == 54 then cStoreModel.underShirt = 54 cStoreTexture.underShirt = 1 end
				else
					if cStoreModel.underShirt == 0 or cStoreModel.underShirt == 53 then cStoreModel.underShirt = 0 cStoreTexture.underShirt = amenu.texture end
					if cStoreModel.underShirt == 2 or cStoreModel.underShirt == 54 then cStoreModel.underShirt = 2 cStoreTexture.underShirt = amenu.texture end
				end
			elseif cStoreModel.overShirt == 1 or cStoreModel.overShirt == 16 then -- V-Neck
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 2 then
					cStoreModel.overShirt = 1
					cStoreTexture.overShirt = 14
				elseif amenu.texture == 9 then
					cStoreModel.overShirt = 1
					cStoreTexture.overShirt = 11
				elseif amenu.texture == 10 then
					cStoreModel.overShirt = 1
					cStoreTexture.overShirt = 12
				elseif amenu.texture > 10 then
					cStoreModel.overShirt = 16
					cStoreTexture.overShirt = amenu.texture-11
				else
					cStoreModel.overShirt = 1
					cStoreTexture.overShirt = amenu.texture
				end
			elseif cStoreModel.underShirt == 1 or cStoreModel.underShirt == 14 or cStoreModel.underShirt == 16 or cStoreModel.underShirt == 18 then -- underShirt variation
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 2 then
					cStoreTexture.underShirt = 14
				elseif amenu.texture == 9 then
					cStoreTexture.underShirt = 11
				elseif amenu.texture == 10 then
					if cStoreModel.underShirt == 1 or cStoreModel.underShirt == 16 then cStoreModel.underShirt = 1 end
					if cStoreModel.underShirt == 14 or cStoreModel.underShirt == 18 then cStoreModel.underShirt = 14 end
					cStoreTexture.underShirt = 12
				elseif amenu.texture > 10 then
					if cStoreModel.underShirt == 1 then cStoreModel.underShirt = 16
					elseif cStoreModel.underShirt == 14 then cStoreModel.underShirt = 18 end
					cStoreTexture.underShirt = amenu.texture-11
				else
					if cStoreModel.underShirt == 1 or cStoreModel.underShirt == 16 then cStoreModel.underShirt = 1 end
					if cStoreModel.underShirt == 14 or cStoreModel.underShirt == 18 then cStoreModel.underShirt = 14 end
					cStoreTexture.underShirt = amenu.texture
				end
			elseif cStoreModel.overShirt == 8 or cStoreModel.overShirt == 38 then -- Baseball
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 0 then
					cStoreModel.overShirt = 8
					cStoreTexture.overShirt = 0
				elseif amenu.texture == 1 then
					cStoreModel.overShirt = 8
					cStoreTexture.overShirt = 10
				elseif amenu.texture == 2 then
					cStoreModel.overShirt = 8
					cStoreTexture.overShirt = 13
				elseif amenu.texture == 3 then
					cStoreModel.overShirt = 8
					cStoreTexture.overShirt = 14
				elseif amenu.texture > 3 then
					cStoreModel.overShirt = 38
					cStoreTexture.overShirt = amenu.texture-4
				end
			elseif cStoreModel.underShirt == 8 then -- Baseball underShirt variation
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 0 then cStoreTexture.underShirt = 0
				elseif amenu.texture == 1 then cStoreTexture.underShirt = 10
				elseif amenu.texture == 2 then cStoreTexture.underShirt = 13
				elseif amenu.texture == 3 then cStoreTexture.underShirt = 14 end
			elseif cStoreModel.overShirt == 73 then -- Designer
				
			elseif cStoreModel.overShirt == 80 or cStoreModel.overShirt == 81 then -- Oversized
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture > 2 then 
					cStoreModel.overShirt = 81
					cStoreTexture.overShirt = amenu.texture-3
				else
					cStoreModel.overShirt = 80
					cStoreTexture.overShirt = amenu.texture 
				end
			elseif cStoreModel.overShirt == 135 or cStoreModel.overShirt == 105 then -- Classic
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 7 then 
					cStoreModel.overShirt = 105
					cStoreTexture.overShirt = 0
				else
					cStoreModel.overShirt = 135
					cStoreTexture.overShirt = amenu.texture 
				end
			end
		elseif amenu.page == 22 then -- Polos
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 9 then -- Regular
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 8 then cStoreTexture.overShirt = 14
				elseif amenu.texture == 9 then cStoreTexture.overShirt = 15
				else cStoreTexture.overShirt = amenu.texture end
			elseif cStoreModel.underShirt == 9 then -- Regular under variation
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 8 then cStoreTexture.underShirt = 14
				elseif amenu.texture == 9 then cStoreTexture.underShirt = 15
				else cStoreTexture.underShirt = amenu.texture end
			elseif cStoreModel.overShirt == 82 then -- Oversized
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			end
		elseif amenu.page == 23 then -- Shirts
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 12 then -- Casual
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.underShirt == 12 then -- Casual underShirt variation
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.underShirt = amenu.texture
			elseif cStoreModel.overShirt == 13 or cStoreModel.overShirt == 26 then -- Tucked
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 4 then
					cStoreModel.overShirt = 13
					cStoreTexture.overShirt = 5
				elseif amenu.texture == 5 then
					cStoreModel.overShirt = 26
					cStoreTexture.overShirt = 2
				elseif amenu.texture > 5 then
					cStoreModel.overShirt = 26
					cStoreTexture.overShirt = amenu.texture-2
				else
					cStoreModel.overShirt = 13
					cStoreTexture.overShirt = amenu.texture
				end
			elseif cStoreModel.underShirt == 13 or cStoreModel.underShirt == 27 then -- Tucked underShirt variation
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 4 then
					cStoreModel.underShirt = 13
					cStoreTexture.underShirt = 5
				elseif amenu.texture == 5 then
					cStoreModel.underShirt = 27
					cStoreTexture.underShirt = 2
				elseif amenu.texture > 5 then
					cStoreModel.underShirt = 27
					cStoreTexture.underShirt = amenu.texture-2
				else
					cStoreModel.underShirt = 13
					cStoreTexture.underShirt = amenu.texture
				end
			elseif cStoreModel.overShirt == 41 or cStoreModel.overShirt == 126 then -- Closed Flannel
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture <= 3 then
					cStoreModel.overShirt = 41
					cStoreTexture.overShirt = amenu.texture
				else
					cStoreModel.overShirt = 126
					cStoreTexture.overShirt = amenu.texture-4
				end
			elseif cStoreModel.underShirt == 43 then -- Closed Flannel underShirt variation
				if amenu.texture < 3 then amenu.texture = amenu.texture + 1 end
				cStoreTexture.underShirt = amenu.texture
			elseif cStoreModel.overShirt == 127 then -- Open Flannel
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 14 then -- Layered
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.underShirt == 29 or cStoreModel.underShirt == 30 then -- Layered underShirt variation
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.underShirt = amenu.texture
			elseif cStoreModel.overShirt == 42 then -- Jean
				
			end
		elseif amenu.page == 24 then -- Sweaters
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 7 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 86 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 89 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 139 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.underShirt == 74 or cStoreModel.underShirt == 75 then -- underShirt variation
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.underShirt = amenu.texture
			elseif cStoreModel.overShirt == 61 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			end
		elseif amenu.page == 31 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 62 then
				
			elseif cStoreModel.overShirt == 37 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 156 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 6 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 2 then
					cStoreTexture.overShirt = 11
				elseif amenu.texture == 7 then
					cStoreTexture.overShirt = 9
				else
					cStoreTexture.overShirt = amenu.texture
				end
			end
		elseif amenu.page == 32 then -- Athletic
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 3 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 113 or cStoreModel.overShirt == 141 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture > 3 then
					cStoreModel.overShirt = 141
					cStoreTexture.overShirt = amenu.texture-4
				else
					cStoreModel.overShirt = 113
					cStoreTexture.overShirt = amenu.texture
				end
			elseif cStoreModel.overShirt == 88 or cStoreModel.overShirt == 87 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			end
		elseif amenu.page == 33 then -- Outerwear
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.overShirt == 69 or cStoreModel.overShirt == 68 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 124 then
				
			elseif cStoreModel.overShirt == 136 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			elseif cStoreModel.overShirt == 138 then
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.overShirt = amenu.texture
			end
		elseif amenu.page == 41 then
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.legs == 75 then -- Regular
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 1 then -- Low
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 82 then -- Skinny Jeans
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 78 then -- Hipster Skinny
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 76 then -- Designer
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			end
		elseif amenu.page == 42 then -- Shorts
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.legs == 12 then -- Regular
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 0 then
					cStoreTexture.legs = 5
				elseif amenu.texture == 1 then
					cStoreTexture.legs = 7
				elseif amenu.texture == 2 then
					cStoreTexture.legs = 12
				end
			elseif cStoreModel.legs == 80 then -- Capri
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 18 then -- Short
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 42 or cStoreModel.legs == 62 then -- Long
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture > 7 then
					cStoreModel.legs = 62
					cStoreTexture.legs = amenu.texture-8
				else
					cStoreModel.legs = 42
					cStoreTexture.legs = amenu.texture
				end
			elseif cStoreModel.legs == 15 then -- Cargo
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			end
		elseif amenu.page == 43 then -- Athletic
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.legs == 3 then -- Regular
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 5 or cStoreModel.legs == 64 then -- Baggy
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture > 15 then
					cStoreModel.legs = 64
					cStoreTexture.legs = amenu.texture-15
				else
					cStoreModel.legs = 5
					cStoreTexture.legs = amenu.texture
				end
			elseif cStoreModel.legs == 6 then -- Swim
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 16 then -- Swim 2
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			elseif cStoreModel.legs == 54 then -- Swim 3
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			end
		elseif amenu.page == 44 then -- Work Pants
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.legs == 7 or cStoreModel.legs == 9 or cStoreModel.legs == 27 then -- Regular, Cargo, Chinos
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.legs = amenu.texture
			end
		elseif amenu.page == 51 then -- Casual
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.shoes == 1 then -- Skate Shoes
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 7 or cStoreModel.shoes == 8 or cStoreModel.shoes == 9 then -- Skate Sneakers
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture > 15 and amenu.texture < 30 then
					cStoreModel.shoes = 8
					cStoreTexture.shoes = amenu.texture-15
				elseif amenu.texture >= 30 then
					cStoreModel.shoes = 9
					cStoreTexture.shoes = amenu.texture-30
				else
					cStoreModel.shoes = 7
					cStoreTexture.shoes = amenu.texture
				end
			elseif cStoreModel.shoes == 26 then -- High Tops
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture == 10 then
					cStoreTexture.shoes = 15
				else
					cStoreTexture.shoes = amenu.texture
				end
			elseif cStoreModel.shoes == 42 then -- Vans
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.shoes = amenu.texture
			end
		elseif amenu.page == 52 then -- Athletic
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.shoes == 31 then -- Sneakers
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 32 or cStoreModel.shoes == 46 then -- Basketball
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				if amenu.texture > 15 then
					cStoreModel.shoes = 46
					cStoreTexture.shoes = amenu.texture-15
				else
					cStoreModel.shoes = 32
					cStoreTexture.shoes = amenu.texture
				end
			end
		elseif amenu.page == 53 then -- Boots
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.shoes == 12 then -- Work Boots
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 24 then -- Duty Boots
				
			elseif cStoreModel.shoes == 14 then -- Hiking Boots
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.shoes = amenu.texture
			end
		elseif amenu.page == 54 then -- Loungewear
			PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if cStoreModel.shoes == 3 then -- Boat Shoes
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 5 then -- Flip Flops
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 6 then -- Socks & Sandals
				
			elseif cStoreModel.shoes == 36 then -- Moccasins
				if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
				cStoreTexture.shoes = amenu.texture
			elseif cStoreModel.shoes == 41 then -- Slippers
				
			end
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
					TriggerServerEvent("deductMoney", 0, prices.total)
					ShowNotification("Clothes bought!")
					model.hat = GetPedPropIndex(GetPlayerPed(-1), 0)
					texture.hat = GetPedPropTextureIndex(GetPlayerPed(-1), 0)
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
		--useProp(types, model, texture, startTexture, endTexture, price)
		elseif amenu.page == 11 then -- Hats
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Baseball Hat
				useProp('hat', 44, 0, 0, 7, 15)
			elseif amenu.row == 2 then -- Backwards Hat
				useProp('hat', 45, 0, 0, 7, 15)
			elseif amenu.row == 3 then -- Flat Brim Hat
				useProp('hat', 4, 0, 0, 1, 15)
			elseif amenu.row == 4 then -- Cowboy Hat
				useProp('hat', 13, 0, 0, 7, 15)
			elseif amenu.row == 5 then -- Bucket Hat
				useProp('hat', 20, 0, 0, 5, 15)
			end
		elseif amenu.page == 12 then -- More Hats
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Beret
				useProp('hat', 7, 0, 0, 7, 15)
			elseif amenu.row == 2 then -- Bowler Hat
				useProp('hat', 26, 0, 0, 13, 15)
			elseif amenu.row == 3 then -- Snapback Hat
				useProp('hat', 55, 0, 0, 25, 15)
			elseif amenu.row == 4 then -- Backwards Snap
				useProp('hat', 77, 0, 0, 20, 15)
			elseif amenu.row == 5 then -- No Hat
				useProp('hat', 11, 0, 0, 0, 0)
				ClearPedProp(GetPlayerPed(-1), 0)
			end
		elseif amenu.page == 13 then -- Head Accessories
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Prescription Glasses
				useProp('glasses', 17, 0, 0, 10, 50)
			elseif amenu.row == 2 then -- Head Phones 
				useProp('hat', 15, 0, 0, 0, 50)
			elseif amenu.row == 3 then -- No Glasses
				useProp('glasses', 6, 0, 0, 0, 0)
			elseif amenu.row == 4 then -- Wayfarer
				useProp('glasses', 7, 0, 0, 10, 50)
			elseif amenu.row == 5 then -- Sunglasses
				useProp('glasses', 16, 0, 0, 10, 50)
			end
		elseif amenu.page == 14 then -- Helmet
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Army Cap
				useProp('hat', 6, 0, 0, 7, 30)
			elseif amenu.row == 2 then -- Dirtbike Helmet
				useProp('hat', 16, 0, 0, 7, 30)
			elseif amenu.row == 3 then -- Motorbike Helmet
				useProp('hat', 17, 0, 0, 7, 30)
			elseif amenu.row == 4 then -- Motorcycle Helmet
				useProp('hat', 18, 0, 0, 7, 30)
			elseif amenu.row == 5 then -- Bandana
				useProp('hat', 14, 0, 0, 7, 15)
			end
		elseif amenu.page == 15 then -- Caps
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Beanie (Medium)
				useProp('hat', 2, 0, 0, 7, 25)
			elseif amenu.row == 2 then -- Beanie (Small)
				useProp('hat', 5, 0, 0, 1, 25)
			elseif amenu.row == 3 then -- Fedora
				useProp('hat', 12, 0, 0, 2, 25)
			elseif amenu.row == 4 then -- Pork Pie Hat
				useProp('hat', 21, 0, 0, 7, 25)
			elseif amenu.row == 5 then -- Top Hat
				useProp('hat', 27, 0, 0, 13, 25)
			end
		elseif amenu.page == 21 then -- T-Shirts
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			-- useClothes(types, model1, texture1, arm, model2, texture2, startTexture, endTexture, price)
			if amenu.row == 1 then -- Regular
				if cStoreModel.overShirt == 62 or cStoreModel.overShirt == 156 or cStoreModel.overShirt == 3 or cStoreModel.overShirt == 88 or cStoreModel.overShirt == 138 then useClothes('underShirt', 0, 0, 0, 0, 0, 0, 10, 10)
				elseif cStoreModel.overShirt == 37 or cStoreModel.overShirt == 6 or cStoreModel.overShirt == 68 or cStoreModel.overShirt == 69 or cStoreModel.overShirt == 124 then useClothes('underShirt', 2, 0, 0, 0, 0, 0, 10, 10)
				else useClothes('overShirt', 0, 0, 0, 15, 0, 0, 10, 10) end
			elseif amenu.row == 2 then -- V-Neck
				if cStoreModel.overShirt == 62 or cStoreModel.overShirt == 156 or cStoreModel.overShirt == 3 or cStoreModel.overShirt == 88 or cStoreModel.overShirt == 138 then useClothes('underShirt', 1, 0, 0, 0, 0, 0, 10, 10)
				elseif cStoreModel.overShirt == 37 or cStoreModel.overShirt == 6 or cStoreModel.overShirt == 68 or cStoreModel.overShirt == 69 or cStoreModel.overShirt == 124 then useClothes('underShirt', 14, 0, 0, 0, 0, 0, 10, 10)
				else useClothes('overShirt', 1, 0, 0, 15, 0, 0, 13, 10) end
			elseif amenu.row == 3 then -- Baseball
				if cStoreModel.overShirt == 62 or cStoreModel.overShirt == 156 or cStoreModel.overShirt == 3 or cStoreModel.overShirt == 88 or cStoreModel.overShirt == 138 then useClothes('underShirt', 8, 0, 0, 0, 0, 0, 8, 10) amenu.maxTexture = 3
				else useClothes('overShirt', 8, 0, 8, 15, 0, 0, 8, 10) end
			elseif amenu.row == 4 then -- Designer
				if cStoreModel.overShirt == 62 or cStoreModel.overShirt == 156 or cStoreModel.overShirt == 3 or cStoreModel.overShirt == 88 or cStoreModel.overShirt == 138 then useClothes('underShirt', 65, 2, 0, 0, 0, 0, 0, 10)
				elseif cStoreModel.overShirt == 37 or cStoreModel.overShirt == 6 or cStoreModel.overShirt == 68 or cStoreModel.overShirt == 69 or cStoreModel.overShirt == 124 then useClothes('underShirt', 66, 2, 0, 0, 0, 0, 0, 10)
				else useClothes('overShirt', 73, 2, 0, 15, 0, 0, 0, 10) end
			elseif amenu.row == 5 then -- Oversized
				useClothes('overShirt', 80, 0, 0, 15, 0, 0, 5, 10)
			elseif amenu.row == 6 then -- Classic
				useClothes('overShirt', 135, 0, 11, 15, 0, 0, 7, 10)
			end
		elseif amenu.page == 22 then -- Polos
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Regular
				if cStoreModel.overShirt == 62 or cStoreModel.overShirt == 156 or cStoreModel.overShirt == 3 or cStoreModel.overShirt == 88 or cStoreModel.overShirt == 37 or cStoreModel.overShirt == 6 or cStoreModel.overShirt == 138 then useClothes('underShirt', 9, 0, 0, 0, 0, 0, 13, 15)
				else useClothes('overShirt', 9, 0, 0, 15, 0, 0, 13, 15) end
			elseif amenu.row == 2 then -- Oversized
				useClothes('overShirt', 82, 0, 0, 15, 0, 0, 15, 15)
			elseif amenu.row == 3 then -- No Shirt
				useClothes('overShirt', 91, 0, 15, 15, 0, 0, 0, 0)
			end
		elseif amenu.page == 23 then -- Shirts
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Casual
				if cStoreModel.overShirt == 62 or cStoreModel.overShirt == 156 or cStoreModel.overShirt == 3 or cStoreModel.overShirt == 88 or cStoreModel.overShirt == 138 then useClothes('underShirt', 12, 0, 0, 0, 0, 0, 11, 15)
				else useClothes('overShirt', 12, 0, 1, 15, 0, 0, 11, 15) end
			elseif amenu.row == 2 then -- Tucked
				if cStoreModel.overShirt == 62 or cStoreModel.overShirt == 156 or cStoreModel.overShirt == 3 or cStoreModel.overShirt == 88 or cStoreModel.overShirt == 138 then useClothes('underShirt', 13, 0, 0, 0, 0, 0, 11, 15)
				elseif cStoreModel.overShirt == 37 or cStoreModel.overShirt == 6 or cStoreModel.overShirt == 68 or cStoreModel.overShirt == 69 or cStoreModel.overShirt == 124 then useClothes('underShirt', 13, 0, 0, 0, 0, 0, 11, 15)
				else useClothes('overShirt', 13, 0, 11, 15, 0, 0, 11, 15) end
			elseif amenu.row == 3 then -- Closed Flannel
				if cStoreModel.overShirt == 62 or cStoreModel.overShirt == 156 or cStoreModel.overShirt == 3 or cStoreModel.overShirt == 88 or cStoreModel.overShirt == 138 then useClothes('underShirt', 43, 0, 0, 0, 0, 0, 18, 15) amenu.maxTexture = 3
				else useClothes('overShirt', 41, 0, 1, 15, 0, 0, 18, 15) end
			elseif amenu.row == 4 then -- Open Flannel
				useClothes('overShirt', 127, 0, 1, 0, 4, 0, 14, 15)
			elseif amenu.row == 5 then -- Layered
				if cStoreModel.overShirt == 62 or cStoreModel.overShirt == 156 or cStoreModel.overShirt == 3 or cStoreModel.overShirt == 88 or cStoreModel.overShirt == 138 then useClothes('underShirt', 29, 0, 0, 0, 0, 0, 15, 15)
				elseif cStoreModel.overShirt == 37 or cStoreModel.overShirt == 6 or cStoreModel.overShirt == 68 or cStoreModel.overShirt == 69 or cStoreModel.overShirt == 124 then useClothes('underShirt', 30, 0, 0, 0, 0, 0, 15, 15)
				else useClothes('overShirt', 14, 0, 1, 15, 0, 0, 15, 15) end
			elseif amenu.row == 6 then -- Jean
				useClothes('overShirt', 42, 0, 11, 15, 0, 0, 0, 15)
			end
		elseif amenu.page == 24 then -- Sweaters
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Open Hoodie
				useClothes('overShirt', 7, 0, 1, 0, 4, 0, 15, 20)
			elseif amenu.row == 2 then -- Closed Hoodie
				useClothes('overShirt', 86, 0, 1, 15, 0, 0, 4, 20)
			elseif amenu.row == 3 then -- Long Sleeve
				useClothes('overShirt', 89, 0, 1, 15, 0, 0, 3, 20)
			elseif amenu.row == 4 then -- Turtle Neck
				if cStoreModel.overShirt == 62 or cStoreModel.overShirt == 156 or cStoreModel.overShirt == 3 or cStoreModel.overShirt == 88 or cStoreModel.overShirt == 138 then useClothes('underShirt', 75, 0, 4, 0, 0, 0, 6, 20)
				elseif cStoreModel.overShirt == 37 or cStoreModel.overShirt == 6 or cStoreModel.overShirt == 68 or cStoreModel.overShirt == 69 or cStoreModel.overShirt == 124 then useClothes('underShirt', 74, 0, 4, 0, 0, 0, 6, 20)
				else useClothes('overShirt', 139, 0, 4, 15, 0, 0, 6, 20) end
			elseif amenu.row == 5 then -- Zip Up
				useClothes('overShirt', 61, 0, 1, 15, 0, 0, 3, 20)
			end
		elseif amenu.page == 31 then -- Leather Jackets
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Open Jacket
				useClothes('jacket', 62, 0, 1, 0, 0, 0, 0, 35)
			elseif amenu.row == 2 then -- Closed Jacket
				useClothes('jacket', 37, 0, 1, 1, 0, 0, 2, 35)
			elseif amenu.row == 3 then -- Jock Jacket
				useClothes('jacket', 156, 0, 1, 0, 0, 0, 5, 35)
			elseif amenu.row == 4 then -- Racing Jacket
				useClothes('jacket', 6, 0, 1, 1, 0, 0, 8, 35)
			end
		elseif amenu.page == 32 then -- Athletic
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Sports Jacket
				useClothes('jacket', 3, 0, 1, 0, 0, 0, 12, 30)
			elseif amenu.row == 2 then -- Running Jacket
				useClothes('overShirt', 113, 0, 6, 15, 0, 0, 13, 30)
			elseif amenu.row == 3 then -- Open Letterman
				useClothes('jacket', 88, 0, 1, 0, 0, 0, 11, 30)
			elseif amenu.row == 4 then -- Closed Letterman
				useClothes('overShirt', 87, 0, 1, 15, 0, 0, 11, 30)
			end
		elseif amenu.page == 33 then -- Outerwear
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Rain Up
				useClothes('jacket', 69, 0, 1, 1, 0, 0, 5, 30)
			elseif amenu.row == 2 then -- Rain Down 
				useClothes('jacket', 68, 0, 1, 1, 0, 0, 5, 30)
			elseif amenu.row == 3 then -- Wind
				useClothes('jacket', 124, 0, 1, 1, 0, 0, 0, 30)
			elseif amenu.row == 4 then -- Quilted
				useClothes('jacket', 136, 0, 1, 0, 0, 0, 6, 30)
			elseif amenu.row == 5 then -- Leather
				useClothes('overShirt', 138, 0, 1, 15, 0, 0, 2, 30)
			end
		elseif amenu.page == 41 then -- Jeans
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			-- useClothes(types, model1, texture1, arm, model2, texture2, startTexture, endTexture, price)
			if amenu.row == 1 then -- Regular
				useClothes('legs', 75, 0, 0, 0, 0, 0, 7, 15)
			elseif amenu.row == 2 then -- Low
				useClothes('legs', 1, 0, 0, 0, 0, 0, 15, 15)
			elseif amenu.row == 3 then -- Skinny
				useClothes('legs', 82, 0, 0, 0, 0, 0, 9, 15)
			elseif amenu.row == 4 then -- Hipster
				useClothes('legs', 78, 0, 0, 0, 0, 0, 7, 15)
			elseif amenu.row == 5 then -- Designer
				useClothes('legs', 76, 0, 0, 0, 0, 0, 7, 10)
			end
		elseif amenu.page == 42 then -- Shorts
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Regular
				useClothes('legs', 12, 5, 0, 0, 0, 0, 2, 10)
			elseif amenu.row == 2 then -- Capri
				useClothes('legs', 80, 0, 0, 0, 0, 0, 7, 10)
			elseif amenu.row == 3 then -- Short
				useClothes('legs', 18, 0, 0, 0, 0, 0, 11, 10)
			elseif amenu.row == 4 then -- Long
				useClothes('legs', 42, 0, 0, 0, 0, 0, 11, 10)
			elseif amenu.row == 5 then -- Cargo
				useClothes('legs', 15, 0, 0, 0, 0, 0, 15, 10)
			end
		elseif amenu.page == 43 then -- Athletic
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Regular
				useClothes('legs', 3, 0, 0, 0, 0, 0, 15, 12)
			elseif amenu.row == 2 then -- Baggy
				useClothes('legs', 5, 0, 0, 0, 0, 0, 25, 12)
			elseif amenu.row == 3 then -- Swim
				useClothes('legs', 6, 0, 0, 0, 0, 0, 2, 12)
			elseif amenu.row == 4 then -- Swim 2
				useClothes('legs', 16, 0, 0, 0, 0, 0, 11, 12)
			elseif amenu.row == 5 then -- Swim 3
				useClothes('legs', 54, 0, 0, 0, 0, 0, 6, 12)
			end
		elseif amenu.page == 44 then -- Work Pants
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Regular
				useClothes('legs', 7, 0, 0, 0, 0, 0, 15, 20)
			elseif amenu.row == 2 then -- Cargo
				useClothes('legs', 9, 0, 0, 0, 0, 0, 15, 20)
			elseif amenu.row == 3 then -- Chinos
				useClothes('legs', 27, 0, 0, 0, 0, 0, 11, 20)
			end
		elseif amenu.page == 51 then -- Casual
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Skate Shoes
				useClothes('shoes', 1, 0, 0, 0, 0, 0, 15, 20)
			elseif amenu.row == 2 then -- Skate Sneakers
				useClothes('shoes', 7, 0, 0, 0, 0, 0, 45, 20)
			elseif amenu.row == 3 then -- High Tops
				useClothes('shoes', 26, 0, 0, 0, 0, 0, 14, 20)
			elseif amenu.row == 4 then -- Vans
				useClothes('shoes', 42, 0, 0, 0, 0, 0, 9, 20)
			end
		elseif amenu.page == 52 then -- Athletic
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Tennis
				useClothes('shoes', 31, 0, 0, 0, 0, 0, 4, 30)
			elseif amenu.row == 2 then -- Basketball
				useClothes('shoes', 32, 0, 0, 0, 0, 0, 24, 30)
			elseif amenu.row == 3 then -- No Shoes
				useClothes('shoes', 34, 0, 0, 0, 0, 0, 0, 0)
			end
		elseif amenu.page == 53 then -- Boots
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Work Boots
				useClothes('shoes', 12, 0, 0, 0, 0, 0, 15, 35)
			elseif amenu.row == 2 then -- Duty Boots
				useClothes('shoes', 24, 0, 0, 0, 0, 0, 0, 35)
			elseif amenu.row == 3 then -- Hiking Boots
				useClothes('shoes', 14, 0, 0, 0, 0, 0, 15, 35)
			end
		elseif amenu.page == 54 then -- Loungewear
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Boat Shoes
				useClothes('shoes', 3, 0, 0, 0, 0, 0, 15, 20)
			elseif amenu.row == 2 then -- Flip Flops
				useClothes('shoes', 5, 0, 0, 0, 0, 0, 3, 20)
			elseif amenu.row == 3 then -- Socks & Sandals
				useClothes('shoes', 6, 0, 0, 0, 0, 0, 0, 20)
			elseif amenu.row == 4 then -- Moccasins
				useClothes('shoes', 36, 0, 0, 0, 0, 0, 3, 20)
			elseif amenu.row == 5 then -- Slippers
				useClothes('shoes', 41, 0, 0, 0, 0, 0, 0, 20)
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
		cStoreModel.glasses = model.glasses
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
		cStoreTexture.glasses = texture.glasses
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
		model.glasses = cStoreModel.glasses
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
		texture.glasses = cStoreTexture.glasses
	end
end