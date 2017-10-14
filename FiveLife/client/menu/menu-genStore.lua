--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

function showStoreMenu()
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	RequestStreamedTextureDict("shopui_title_conveniencestore", true)
	while not HasStreamedTextureDictLoaded("shopui_title_conveniencestore") do
		Wait(0)
	end
	DrawSprite("shopui_title_conveniencestore", "shopui_title_conveniencestore", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",30,88,162,255)
	
	showNormalSelection()
	if amenu.page == 0 then
		amenu.title = "GENERAL STORE"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Buy Items",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Sell Items",255,255,255,255)
	elseif amenu.page == 1 then
		amenu.title = "TOOLS"
		menuItems("GPS", "Compass", "Pickaxe", "Crowbar", "Hammer", "Flashlight")
		menuPrices(getBuyPrice('GPS'), getBuyPrice('Compass'), getBuyPrice('Pickaxe'), getBuyPrice('Crowbar'), getBuyPrice('Hammer'), getBuyPrice('Flashlight'))
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/3",30,88,162,255)
	elseif amenu.page == 2 then
		amenu.title = "OTHER"
		menuItems("Morphine", "Bandage", "Adrenaline", "Engine Kit", "Body Kit", "Hotwire Kit")
		menuPrices(getBuyPrice('Morphine'), getBuyPrice('Bandage'), getBuyPrice('Adrenaline'), getBuyPrice('Engine-Kit'), getBuyPrice('Body-Kit'), getBuyPrice('Hotwire-Kit'))
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/3",30,88,162,255)
	elseif amenu.page == 3 then	
		amenu.title = "FOOD"
		menuItems("Heart Stopper", "Meteorite Bar", "Phat Chips", "ECola", "Sprunk", "nil")
		menuPrices(getBuyPrice('Heart-Stopper'), getBuyPrice('Meteorite-Bar'), getBuyPrice('Phat-Chips'), getBuyPrice('ECola'), getBuyPrice('Sprunk'), "nil")
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "3/3",30,88,162,255)
	elseif amenu.page == 5 then
		amenu.title = "OTHER"
		drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Grapes",255,255,255,255)
		drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Sand",255,255,255,255)
		drawTxt(0.92, 0.17, 0.0, 0.0, 0.35, "$" .. getSellPrice('Grapes'),255,255,255,255)
		drawTxt(0.92, 0.21, 0.0, 0.0, 0.35, "$" .. getSellPrice('Sand'),255,255,255,255)
		drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/1",30,88,162,255)
	end
	
	
	
	
	
	-- ============================== KEY PRESSES ==============================
	
	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		if amenu.row > 1 then 
			amenu.row = amenu.row-1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		if amenu.page == 0 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 1 then
			if amenu.row < amenu.maxRow then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 2 then
			if amenu.row < amenu.maxRow then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 3 then
			if amenu.row < amenu.maxRow then
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		elseif amenu.page == 5 then
			if amenu.row < 2 then 
				amenu.row = amenu.row+1
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 1 then
			amenu.page = 3
			amenu.row = 1
		elseif amenu.page == 2 then
			amenu.page = 1
			amenu.row = 1
		elseif amenu.page == 3 then
			amenu.page = 2
			amenu.row = 1
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
		PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 1 then
			amenu.page = 2
			amenu.row = 1
		elseif amenu.page == 2 then
			amenu.page = 3
			amenu.row = 1
		elseif amenu.page == 3 then
			amenu.page = 1
			amenu.row = 1
		end
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		if amenu.page == 0 then -- GENERAL STORE
			if amenu.row == 1 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				amenu.page = 1
				amenu.row = 1
			elseif amenu.row == 2 then
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				amenu.page = 5
				amenu.row = 1
			end
		elseif amenu.page == 1 then --(Page 1)
			if amenu.row == 1 then
				buyItem('GPS')
			elseif amenu.row == 2 then
				buyItem('Compass')
			elseif amenu.row == 3 then
				buyWeapon('Pickaxe')
			elseif amenu.row == 4 then
				buyWeapon('Crowbar')
			elseif amenu.row == 5 then
				buyWeapon('Hammer')
			elseif amenu.row == 6 then
				buyWeapon('Flashlight')
			end
		elseif amenu.page == 2 then -- (Page 2)
			if amenu.row == 1 then
				buyItem('Morphine')
			elseif amenu.row == 2 then
				buyItem('Bandage')
			elseif amenu.row == 3 then
				buyItem('Adrenaline')
			elseif amenu.row == 4 then
				buyItem('Engine-Kit')
			elseif amenu.row == 5 then
				buyItem('Body-Kit')
			elseif amenu.row == 6 then
				buyItem('Hotwire-Kit')
			end
		elseif amenu.page == 5 then -- (Sell)
			if amenu.row == 1 then
				if hasItem('Grapes') then
					TriggerServerEvent("jobPayout", 'Grapes', 'all')
				else
					ShowNotification("~r~You have no ~b~Grapes")
				end
			elseif amenu.row == 2 then
				if hasItem('Sand') then
					TriggerServerEvent("jobPayout", 'Sand', 'all')
				else
					ShowNotification("~r~You have no ~b~Sand")
				end
			end
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		if amenu.page == 0 then
			PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			amenu.show = 0
			amenu.row = 1
			phone('enable')
			TriggerEvent("AwesomeFreeze", false)
		elseif amenu.page == 1 or amenu.page == 2 or amenu.page == 3 or amenu.page == 5 then
			PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			amenu.page = 0
			amenu.row = 1
		end
	end
end


