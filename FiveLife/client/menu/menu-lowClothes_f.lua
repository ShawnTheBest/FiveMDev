--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local totalClothingPrice = 0
local sure = false

function showLowClothesMenu_f()
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
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Hats ~g~$15",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "More Hats ~g~$15",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Head Accessories ~g~$50",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Helmets ~g~$30",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Caps ~g~$25",255,255,255,255)
	elseif amenu.page == 2 then
		amenu.title = "SHIRTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "T-Shirts ~g~$10",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Polos ~g~$15",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Shirts ~g~$15",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Sweaters ~g~$20",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Athletic ~g~$20",255,255,255,255)
	elseif amenu.page == 3 then
		amenu.title = "JACKETS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Jean/Leather ~g~$35",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Athletic ~g~$30",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Outerwear ~g~$30",255,255,255,255)
	elseif amenu.page == 4 then
		amenu.title = "PANTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Jeans ~g~$15",255,255,255,255)	
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Shorts ~g~$10",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Skirts ~g~$12",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Athletic ~g~$12",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Work Pants ~g~$20",255,255,255,255)
	elseif amenu.page == 5 then
		amenu.title = "SHOES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Casual ~g~$20",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Athletic ~g~$30",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Boots ~g~$35",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Other ~g~$20",255,255,255,255)
	elseif amenu.page == 11 then -- HEADWEARS - Hats
		amenu.title = "HATS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Hat",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Backwards Hat",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Cowboy Hat",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Hip Hop Hat",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Snapback",255,255,255,255)
	elseif amenu.page == 12 then -- HEADWEARS - More Hats
		amenu.title = "MORE HATS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Trucker Hat",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Backwards Trucker Hat",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Flatbill Hat",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "No hat",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Headphones",255,255,255,255)
	elseif amenu.page == 13 then -- HEADWEARS - Head Accessories
		amenu.title = "HEAD ACCESSORIES"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Cat Glasses",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Sunglasses",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Barbara",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "No Glasses",255,255,255,255)
	elseif amenu.page == 14 then -- HEADWEARS - Helmets
		amenu.title = "HELMETS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Motorcycle Helmet (Open)",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Motorcycle Helmet (Closed)",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Spike Helmet",255,255,255,255)
	elseif amenu.page == 15 then -- HEADWEARS - Caps
		amenu.title = "CAPS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Beanie",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Fedora",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Beret",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Sunhat",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Top Hat",255,255,255,255)
	elseif amenu.page == 21 then -- SHIRTS - T-Shirts
		amenu.title = "T-SHIRTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Regular",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Shoulder",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Designer",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Crop Top",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Jersey",255,255,255,255)
	elseif amenu.page == 22 then -- SHIRTS - Polos
		amenu.title = "POLOS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Regular",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Robe Top",255,255,255,255)
	elseif amenu.page == 23 then -- SHIRTS - Shirts
		amenu.title = "SHIRTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Casual",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Jean",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Closed Flannel",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Open Flannel",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Corset",255,255,255,255)
	elseif amenu.page == 24 then -- SHIRTS - Sweaters
		amenu.title = "SWEATERS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Closed Hoodie",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Large Hoodie",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Turtle Neck",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Sweatshirt",255,255,255,255)
	elseif amenu.page == 25 then -- SHIRTS - Athletic
		amenu.title = "ATHLETIC"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Bikini Top",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Sports Bra",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Tank Top",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Pleated Tank Top",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Sleevless Crop Top",255,255,255,255)
	elseif amenu.page == 31 then -- JACKETS - Leather
		amenu.title = "JEAN/LEATHER"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Leather",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Jean",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Jock Jacket",255,255,255,255)
	elseif amenu.page == 32 then -- JACKETS - Athletic
		amenu.title = "ATHLETIC"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Running Jacket",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Closed Letterman",255,255,255,255)
	elseif amenu.page == 33 then -- JACKETS - Outerwear
		amenu.title = "OUTERWEAR"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Rain Jacket Down",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Rain Jacket Up",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Fur Coat",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Long Coat",255,255,255,255)
	elseif amenu.page == 41 then -- PANTS - Jeans
		amenu.title = "JEANS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Skinny",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Regular",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Capris",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Skinny Shredded",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Skinny Shredded2",255,255,255,255)
	elseif amenu.page == 42 then -- PANTS - Shorts
		amenu.title = "SHORTS" 
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Jean Shorts",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Running Shorts",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Mini Shorts",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Lace Shorts",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Shorts Fishnet Leggings",255,255,255,255)
	elseif amenu.page == 43 then -- PANTS - Skirts
		amenu.title = "SKIRTS" 
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Business Skirt",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Patterned Skirt",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Casual Mini Skirt",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Designed Mini Skirt",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Pleated Mini Skirt",255,255,255,255)
	elseif amenu.page == 44 then -- PANTS - Athletic
		amenu.title = "ATHLETIC"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Sweats",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Capris",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Bikini Bottoms",255,255,255,255)
	elseif amenu.page == 45 then -- PANTS - Work Pants
		amenu.title = "WORK PANTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Regular",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Slacks",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Business",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Lingerie",255,255,255,255)
	elseif amenu.page == 51 then -- SHOES - Casual
		amenu.title = "CASUAL"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Skate Shoes",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Converse",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "High Tops",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Heels",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "Open Toe Heels",255,255,255,255)
	elseif amenu.page == 52 then -- SHOES - Athletic
		amenu.title = "ATHLETIC"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Sneakers",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Tennis Shoes",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Lightup Skechers",255,255,255,255)
	elseif amenu.page == 53 then -- SHOES - Boots
		amenu.title = "BOOTS"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Uggs",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Cowgirl",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Calf Boots",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Booties",255,255,255,255)
	elseif amenu.page == 54 then -- SHOES - Loungewear
		amenu.title = "OTHER"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Boat Shoes",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Flip Flops",255,255,255,255)
		drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Sandals",255,255,255,255)
		drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Flats",255,255,255,255)
		drawTxt(0.795, 0.33, 0.0, 0.0, 0.35, "No Shoes",255,255,255,255)
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
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 3 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 4 then
			if amenu.row < 6 then 
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
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 14 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end	
		elseif amenu.page == 15 then
			if amenu.row < 6then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end	
		elseif amenu.page == 21 then
			if amenu.row < 6 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 22 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 23 then
			if amenu.row < 5 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 24 then
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end	
		elseif amenu.page == 25 then
			if amenu.row < 5then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end	
		elseif amenu.page == 31 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 32 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 33 then
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 41 then
			if amenu.row < 5 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 42 then
			if amenu.row < 5 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 43 then
			if amenu.row < 5 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 44 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 45 then
			if amenu.row < 4 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 51 then
			if amenu.row < 5 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 52 then
			if amenu.row < 3 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 53 then
			if amenu.row < 4 then 
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
        if amenu.texture > 0 then amenu.texture = amenu.texture -1 end
		if amenu.page == 13 then
			cStoreTexture.glasses = amenu.texture
        elseif amenu.page > 9 and amenu.page < 13 or amenu.page > 13 and amenu.page < 20 then
			cStoreTexture.hat = amenu.texture
        elseif amenu.page > 20 and amenu.page < 40 then
            cStoreTexture.overShirt = amenu.texture
        elseif amenu.page > 40 and amenu.page < 50 then
            cStoreTexture.legs = amenu.texture
        elseif amenu.page > 50 and amenu.page < 60 then
            cStoreTexture.shoes = amenu.texture
        end
        updateStoreClothes()
    elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
        if amenu.texture < amenu.maxTexture then amenu.texture = amenu.texture + 1 end
		if amenu.page == 13 then
			cStoreTexture.glasses = amenu.texture
        elseif amenu.page > 9 and amenu.page < 13 or amenu.page > 13 and amenu.page < 20 then
			cStoreTexture.hat = amenu.texture
        elseif amenu.page > 20 and amenu.page < 40 then
            cStoreTexture.overShirt = amenu.texture
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
		elseif amenu.page == 11 then -- Hats
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Hat
				useProp('hat', 43, 0, 0, 7, 15)
			elseif amenu.row == 2 then -- Backwards Hat
				useProp('hat', 44, 0, 0, 7, 15)
			elseif amenu.row == 3 then -- Cowboy Hat
				useProp('hat', 20, 0, 0, 6, 15)
			elseif amenu.row == 4 then -- Hip Hop Hat
				useProp('hat', 9, 0, 0, 7, 15)
			elseif amenu.row == 5 then -- Snapback
				useProp('hat', 55, 0, 0, 25, 15)
			end
		elseif amenu.page == 12 then -- More Hats
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Trucker Hat
				useProp('hat', 108, 0, 0, 10, 15)
			elseif amenu.row == 2 then -- Backwards Trucker Hat
				useProp('hat', 109, 0, 0, 10, 15)
			elseif amenu.row == 3 then -- Flat Bill Hat
				useProp('hat', 56, 0, 0, 25, 15)
			elseif amenu.row == 4 then -- No Hat
				useProp('hat', 57, 0, 0, 0, 0)
				ClearPedProp(GetPlayerPed(-1), 0)
			elseif amenu.row == 5 then -- Headphones
				useProp('hat', 15, 0, 0, 7, 50)
			end
		elseif amenu.page == 13 then -- Head Accessories
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Prescription Glasses
				useProp('glasses', 14, 0, 0, 10, 50)
			elseif amenu.row == 2 then -- Sunglasses
				useProp('glasses', 16, 0, 0, 10, 50)
			elseif amenu.row == 3 then -- Barbara
				useProp('glasses', 4, 0, 0, 10, 50)
			elseif amenu.row == 4 then -- No glasses
				useProp('glasses', 5, 0, 0, 0, 0)
			end
		elseif amenu.page == 14 then -- Helmets
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Motorcycle Helmet (Open)
				useProp('hat', 48, 0, 0, 0, 30)
			elseif amenu.row == 2 then -- Motorcycle Helmet (Closed)
				useProp('hat', 51, 0, 0, 0, 30)
			elseif amenu.row == 3 then -- Spiked Helmet
				useProp('hat', 83, 0, 0, 9, 30)
			end
		elseif amenu.page == 15 then -- Caps
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Beanie
				useProp('hat', 5, 0, 0, 7, 25)
			elseif amenu.row == 2 then -- Fedora
				useProp('hat', 13, 0, 0, 7, 25)
			elseif amenu.row == 3 then -- Beret
				useProp('hat', 14, 0, 0, 7, 25)
			elseif amenu.row == 4 then -- Sunhat
				useProp('hat', 22, 0, 0, 6, 25)
			elseif amenu.row == 5 then -- Top Hat
				useProp('hat', 27, 0, 0, 13, 25)
			end
		elseif amenu.page == 21 then -- T-Shirts
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			-- useClothes(types, model1, texture1, arm, model2, texture2, startTexture, endTexture, price)
			if amenu.row == 1 then -- Regular
				useClothes('overShirt', 0, 0, 0, 14, 0, 0, 15, 10)
			elseif amenu.row == 2 then -- Shoulder
				useClothes('overShirt', 2, 0, 2, 14, 0, 0, 15, 10)
			elseif amenu.row == 3 then -- Designer
				useClothes('overShirt', 68, 0, 0, 14, 0, 0, 5, 10)
			elseif amenu.row == 4 then -- Crop Top
				useClothes('overShirt', 195, 0, 15, 14, 0, 0, 25, 10)
			elseif amenu.row == 5 then -- Jersey
				useClothes('overShirt', 125, 0, 3, 14, 0, 0, 9, 10)
			end
		elseif amenu.page == 22 then -- Misc
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Regular
				useClothes('overShirt', 14, 0, 0, 14, 0, 0, 15, 15)
			elseif amenu.row == 2 then -- Robe Top
				useClothes('overShirt', 105, 0, 15, 14, 0, 0, 7, 15)
			end
		elseif amenu.page == 23 then -- Shirts
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Casual
				useClothes('overShirt', 9, 0, 0, 14, 0, 0, 14, 15)
			elseif amenu.row == 2 then -- Jean
				useClothes('overShirt', 171, 0, 4, 14, 0, 0, 7, 15)
			elseif amenu.row == 3 then -- Closed Flannel
				useClothes('overShirt', 121, 0, 3, 14, 0, 0, 16, 15)
			elseif amenu.row == 4 then -- Open Flannel
				useClothes('overShirt', 120, 0, 6, 11, 11, 0, 16, 15)
			elseif amenu.row == 5 then -- Corset
				useClothes('overShirt', 111, 0, 15, 2, 0, 0, 11, 15)
			end
		elseif amenu.page == 24 then -- Sweaters
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Closed Hoodie
				useClothes('overShirt', 3, 0, 3, 14, 0, 0, 4, 20)
			elseif amenu.row == 2 then -- Large Hoodie
				useClothes('overShirt', 78, 0, 3, 14, 0, 0, 7, 20)
			elseif amenu.row == 3 then -- Turtle Neck
				useClothes('overShirt', 136, 0, 3, 14, 0, 0, 7, 20)
			elseif amenu.row == 4 then -- Sweatshirt
				useClothes('overShirt', 71, 0, 3, 14, 0, 0, 15, 20)	
			end
		elseif amenu.page == 25 then -- Athletic
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Bikini Top
				useClothes('overShirt', 18, 0, 15, 14, 0, 0, 11, 15)
			elseif amenu.row == 2 then -- Sports Bra
				useClothes('overShirt', 33, 0, 15, 14, 0, 0, 8, 15)
			elseif amenu.row == 3 then -- Tank Top
				useClothes('overShirt', 16, 0, 15, 14, 0, 0, 6, 15)
			elseif amenu.row == 4 then -- Pleated Tank Top
				useClothes('overShirt', 26, 0, 15, 14, 0, 0, 12, 15)
			elseif amenu.row == 5 then -- Sleeveless Crop Top
				useClothes('overShirt', 170, 0, 15, 2, 0, 0, 5, 15)
			end
		elseif amenu.page == 31 then -- Leather Jackets
			-- useClothes(types, model1, texture1, arm, model2, texture2, startTexture, endTexture, price)
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Leather
				useClothes('overShirt', 35, 0, 1, 11, 11, 0, 11, 35)
			elseif amenu.row == 2 then -- Jean
				useClothes('overShirt', 31, 0, 1, 11, 11, 0, 6, 35)
			elseif amenu.row == 3 then -- Jock Jacket
				useClothes('overShirt', 148, 0, 1, 11, 11, 0, 5, 35)
			end
		elseif amenu.page == 32 then -- Athletic
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Running Jacket
				useClothes('overShirt', 138, 0, 6, 11, 11, 0, 10, 30)
			elseif amenu.row == 2 then -- Closed Letterman
				useClothes('overShirt', 81, 0, 1, 14, 0, 0, 11, 30)
			end
		elseif amenu.page == 33 then -- Outerwear
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Rain Up
				useClothes('overShirt', 62, 0, 1, 11, 11, 0, 5, 30)
			elseif amenu.row == 2 then -- Rain Down 
				useClothes('overShirt', 63, 0, 1, 11, 11, 0, 5, 30)
			elseif amenu.row == 3 then -- Fur Coat
				useClothes('overShirt', 65, 0, 6, 11, 11, 0, 11, 30)
			elseif amenu.row == 4 then -- Long Coat
				useClothes('overShirt', 107, 0, 51, 14, 11, 0, 11, 30)
			end
		elseif amenu.page == 41 then -- Jeans
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			-- useClothes(types, model1, texture1, arm, model2, texture2, startTexture, endTexture, price)
			if amenu.row == 1 then -- Skinny
				useClothes('legs', 51, 0, 0, 0, 0, 0, 4, 15)
			elseif amenu.row == 2 then -- Regular
				useClothes('legs', 0, 0, 0, 0, 0, 0, 15, 15)
			elseif amenu.row == 3 then -- Capris
				useClothes('legs', 4, 0, 0, 0, 0, 0, 15, 15)
			elseif amenu.row == 4 then -- Skinny Shredded
				useClothes('legs', 43, 0, 0, 0, 0, 0, 4, 15)
			elseif amenu.row == 5 then -- Skinny Shredded2
				useClothes('legs', 44, 0, 0, 0, 0, 0, 4, 15)
			end
		elseif amenu.page == 42 then -- Shorts
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Jean
				useClothes('legs', 25, 0, 0, 0, 0, 0, 12, 10)
			elseif amenu.row == 2 then -- Running
				useClothes('legs', 10, 0, 0, 0, 0, 0, 2, 10)
			elseif amenu.row == 3 then -- Mini
				useClothes('legs', 16, 0, 0, 0, 0, 0, 11, 10)
			elseif amenu.row == 4 then -- Lace
				useClothes('legs', 19, 0, 0, 0, 0, 0, 4, 10)
			elseif amenu.row == 5 then -- Shorts Fishnet Leggings
				useClothes('legs', 78, 0, 0, 0, 0, 0, 3, 10)
			end
		elseif amenu.page == 43 then -- Skirts
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Business
				useClothes('legs', 7, 0, 0, 0, 0, 0, 2, 12)
			elseif amenu.row == 2 then -- Patterned
				useClothes('legs', 24, 0, 0, 0, 0, 0, 11, 12)
			elseif amenu.row == 3 then -- Casual Mini
				useClothes('legs', 8, 0, 0, 0, 0, 0, 11, 12)
			elseif amenu.row == 4 then -- Designed Mini
				useClothes('legs', 9, 0, 0, 0, 0, 0, 15, 12)
			elseif amenu.row == 5 then -- Pleated Mini
				useClothes('legs', 12, 0, 0, 0, 0, 0, 15, 12)
			end
		elseif amenu.page == 44 then -- Athletic
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Sweats
				useClothes('legs', 2, 0, 0, 0, 0, 0, 2, 12)
			elseif amenu.row == 2 then -- Capris
				useClothes('legs', 11, 0, 0, 0, 0, 0, 15, 12)
			elseif amenu.row == 3 then -- Bikini Bottoms
				useClothes('legs', 17, 0, 0, 0, 0, 0, 11, 10)
			end
		elseif amenu.page == 45 then -- Work Pants
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Regular
				useClothes('legs', 3, 0, 0, 0, 0, 0, 15, 20)
			elseif amenu.row == 2 then -- Slacks
				useClothes('legs', 6, 0, 0, 0, 0, 0, 2, 20)
			elseif amenu.row == 3 then -- Business
				useClothes('legs', 23, 0, 0, 0, 0, 0, 12, 20)
			elseif amenu.row == 4 then -- Lingerie
				useClothes('legs', 20, 0, 0, 0, 0, 0, 2, 20)
			end
		elseif amenu.page == 51 then -- Casual
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Skate Shoes
				useClothes('shoes', 1, 0, 0, 0, 0, 0, 15, 20)
			elseif amenu.row == 2 then -- Converse
				useClothes('shoes', 3, 0, 0, 0, 0, 0, 15, 20)
			elseif amenu.row == 3 then -- High Tops
				useClothes('shoes', 11, 0, 0, 0, 0, 0, 3, 20)
			elseif amenu.row == 4 then -- Heels
				useClothes('shoes', 0, 0, 0, 0, 0, 0, 3, 20)
			elseif amenu.row == 5 then -- Open Toe Heels
				useClothes('shoes', 8, 0, 0, 0, 0, 0, 15, 20)
			end
		elseif amenu.page == 52 then -- Athletic
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Sneakers
				useClothes('shoes', 11, 0, 0, 0, 0, 0, 3, 30)
			elseif amenu.row == 2 then -- Tennis Shoes
				useClothes('shoes', 10, 0, 0, 0, 0, 0, 3, 30)
			elseif amenu.row == 3 then -- Lightup Skechers
				useClothes('shoes', 58, 0, 0, 0, 0, 0, 10, 30)
			end
		elseif amenu.page == 53 then -- Boots
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Uggs
				useClothes('shoes', 2, 0, 0, 0, 0, 0, 15, 35)
			elseif amenu.row == 2 then -- Cowgirl
				useClothes('shoes', 38, 0, 0, 0, 0, 0, 4, 35)
			elseif amenu.row == 3 then -- Boots
				useClothes('shoes', 56, 0, 0, 0, 0, 0, 2, 35)
			elseif amenu.row == 4 then -- Booties
				useClothes('shoes', 7, 0, 0, 0, 0, 0, 15, 35)
			end
		elseif amenu.page == 54 then -- Lounge
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then -- Boat Shoes
				useClothes('shoes', 37, 0, 0, 0, 0, 0, 3, 20)
			elseif amenu.row == 2 then -- Flip Flops
				useClothes('shoes', 5, 0, 0, 0, 0, 0, 1, 20)
			elseif amenu.row == 3 then -- Sandals
				useClothes('shoes', 15, 0, 0, 0, 0, 0, 15, 20)
			elseif amenu.row == 4 then -- Flats
				useClothes('shoes', 13, 0, 0, 0, 0, 0, 15, 20)
			elseif amenu.row == 5 then -- No shoes
				useClothes('shoes', 35, 0, 0, 0, 0, 0, 0, 0)
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
	if cStoreModel.glasses == 5 or cStoreModel.glasses == 0 then
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