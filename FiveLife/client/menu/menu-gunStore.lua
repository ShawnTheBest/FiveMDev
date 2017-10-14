--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

function showGunMenu()
	local myPed = GetPlayerPed(-1)
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.87, 0.3, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	RequestStreamedTextureDict("shopui_title_gunclub", true)
	while not HasStreamedTextureDictLoaded("shopui_title_gunclub") do
		Wait(0)
	end
	DrawSprite("shopui_title_gunclub", "shopui_title_gunclub", 0.87, 0.1, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.87, 0.1545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.795, 0.135, 0.0, 0.0, 0.35, amenu.title .. "",156,46,33,255)
	
	showNormalSelection()
	if licenses.handgun == true then
		DrawRect(0.87, 0.505, 0.16, 0.12, 0, 0, 0, 200)
		if amenu.page == 0 then
			amenu.title = "HANDGUNS"
			RequestStreamedTextureDict("srange_weap", true)
			while not HasStreamedTextureDictLoaded("srange_weap") do
				Wait(0)
			end
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Baretta M9",255,255,255,255)
			drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Glock 23",255,255,255,255)
			drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, ".38 Special",255,255,255,255)
			drawTxt(0.795, 0.29, 0.0, 0.0, 0.35, "Vintage Pistol",255,255,255,255)
			if amenu.row == 1 then DrawSprite("srange_weap", "weap_hg_1", 0.87, 0.505, 0.09, 0.14, 0.0, 255, 255, 255, 255)
			elseif amenu.row == 2 then DrawSprite("srange_weap", "weap_hg_2", 0.87, 0.505, 0.09, 0.14, 0.0, 255, 255, 255, 255)
			elseif amenu.row == 3 then DrawSprite("srange_weap", "weap_hg_6", 0.87, 0.505, 0.09, 0.14, 0.0, 255, 255, 255, 255)
			elseif amenu.row == 4 then DrawSprite("srange_weap", "weap_hg_7", 0.87, 0.505, 0.09, 0.14, 0.0, 255, 255, 255, 255) end
			drawGunPrice('weapon', "WEAPON_PISTOL", 'pistol', 0.17)
			drawGunPrice('weapon', "WEAPON_COMBATPISTOL", 'combat_pistol', 0.21)
			drawGunPrice('weapon', "WEAPON_SNSPISTOL", 'sns_pistol', 0.25)
			drawGunPrice('weapon', "WEAPON_VINTAGEPISTOL", 'vintage_pistol', 0.29)
			drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "1/2",156,46,33,255)
		elseif amenu.page == 1 then
			amenu.title = "OTHER"
			RequestStreamedTextureDict("srange_weap2", true)
			while not HasStreamedTextureDictLoaded("srange_weap2") do
				Wait(0)
			end
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Mossberg 500",255,255,255,255)
			drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "M1 Garand",114,114,114,255)
			drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "M1 Carbine",114,114,114,255)
			if amenu.row == 1 then DrawSprite("srange_weap2", "weap_sg_1", 0.87, 0.505, 0.13, 0.18, 0.0, 255, 255, 255, 255)
			elseif amenu.row == 2 then DrawSprite("srange_weap2", "weap_lmg_3", 0.87, 0.505, 0.13, 0.18, 0.0, 255, 255, 255, 255)
			elseif amenu.row == 3 then DrawSprite("srange_weap2", "weap_lmg_4", 0.87, 0.505, 0.13, 0.18, 0.0, 255, 255, 255, 255) end
			drawGunPrice('weapon', "WEAPON_PUMPSHOTGUN", 'shotgun', 0.17)
			drawGunPrice('weapon', "WEAPON_HEAVYSHOTGUN", 'heavy_shotgun', 0.21)
			drawGunPrice('weapon', "WEAPON_MUSKET", 'musket', 0.25)
			drawTxt(0.925, 0.135, 0.0, 0.0, 0.35, "2/2",156,46,33,255)
		elseif amenu.page == 2 then
			amenu.title = "BARETTA M9"
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Buy Magazine",255,255,255,255)
			drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Flashlight",255,255,255,255)
			drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Suppressor",114,114,114,255)
			drawGunPrice('component', "WEAPON_PISTOL", 'pistol', 0.21)
			drawTxt(0.916, 0.25, 0.0, 0.0, 0.35, "  --",114,114,114,255)
			drawTxt(0.916, 17, 0.0, 0.0, 0.35, "$" .. getAmmoPrice('pistol'),255,255,255,255)
		elseif amenu.page == 3 then
			amenu.title = "GLOCK 23"
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Buy Magazine",255,255,255,255)
			drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Flashlight",255,255,255,255)
			drawTxt(0.795, 0.25, 0.0, 0.0, 0.35, "Suppressor",114,114,114,255)
			drawGunPrice('component', "WEAPON_COMBATPISTOL", 'combat_pistol', 0.21)
			drawTxt(0.916, 0.25, 0.0, 0.0, 0.35, "  --",114,114,114,255)
			drawTxt(0.916, 17, 0.0, 0.0, 0.35, "$" .. getAmmoPrice('combat_pistol'),255,255,255,255)
		elseif amenu.page == 4 then
			amenu.title = "SNS PISTOL"
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Buy Magazine",255,255,255,255)
			drawTxt(0.916, 17, 0.0, 0.0, 0.35, "$" .. getAmmoPrice('sns_pistol'),255,255,255,255)
		elseif amenu.page == 5 then
			amenu.title = "VINTAGE PISTOL"
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Buy Magazine",255,255,255,255)
			drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Suppressor",114,114,114,255)
			drawTxt(0.916, 0.21, 0.0, 0.0, 0.35, "  --",114,114,114,255)
			drawTxt(0.916, 17, 0.0, 0.0, 0.35, "$" .. getAmmoPrice('vintage_pistol'),255,255,255,255)
		elseif amenu.page == 6 then
			amenu.title = "MOSSBERG 500"
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Buy Magazine",255,255,255,255)
			drawTxt(0.795, 0.21, 0.0, 0.0, 0.35, "Flashlight",255,255,255,255)
			drawGunPrice('component', "WEAPON_PUMPSHOTGUN", 'shotgun', 0.21)
			drawTxt(0.916, 17, 0.0, 0.0, 0.35, "$" .. getAmmoPrice('shotgun'),255,255,255,255)
		end
	else
		if amenu.page == 0 then
			amenu.title = "GUN LICENSE"
			drawTxt(0.795, 0.17, 0.0, 0.0, 0.35, "Buy License",255,255,255,255)
			drawTxt(0.916, 0.17, 0.0, 0.0, 0.35, "$" .. getBuyPrice('gunLicense'),255,255,255,255)
		end
	end
	
	
	
	
	
	-- ============================== KEY PRESSES ==============================
	
	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		if amenu.row > 1 then 
			amenu.row = amenu.row-1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		if licenses.handgun then
			if amenu.page == 0 then
				if amenu.row < 4 then
					amenu.row = amenu.row+1
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				end
			elseif amenu.page == 1 or amenu.page == 2 or amenu.page == 3 then
				if amenu.row < 3 then 
					amenu.row = amenu.row+1
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				end
			elseif amenu.page == 4 then
				if amenu.row < 1 then 
					amenu.row = amenu.row+1
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				end
			elseif amenu.page == 5 or amenu.page == 6 then
				if amenu.row < 2 then 
					amenu.row = amenu.row+1
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				end
			end
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 then
			amenu.page = 1
			amenu.row = 1
		else
			amenu.page = 0
			amenu.row = 1
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
		PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 then
			amenu.page = 1
			amenu.row = 1
		else
			amenu.page = 0
			amenu.row = 1
		end
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		if licenses.handgun then
			if amenu.page == 0 then	-- Main Menu
				if amenu.row == 1 then
					if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), false) then
						amenu.page = 2
						amenu.row = 1
					else
						if bankStats.cash >= getBuyPrice('pistol') then
							TriggerServerEvent("deductMoney", 0, getBuyPrice('pistol'))
							TriggerServerEvent("giveWeapon", 'pistol', 12)
							GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), 12, false, false)
							ShowNotification("Pistol bought.")
						else
							ShowNotification("~r~You don't have enough money for that.")
						end
					end
				elseif amenu.row == 2 then
					if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_COMBATPISTOL'), false) then
						amenu.page = 3
						amenu.row = 1
					else
						if bankStats.cash >= getBuyPrice('combat_pistol') then
							TriggerServerEvent("deductMoney", 0, getBuyPrice('combat_pistol'))
							TriggerServerEvent("giveWeapon", 'combat_pistol', 12)
							GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_COMBATPISTOL'), 12, false, false)
							ShowNotification("Combat Pistol bought.")
						else
							ShowNotification("~r~You don't have enough money for that.")
						end
					end
				elseif amenu.row == 3 then
					if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_SNSPISTOL'), false) then
						amenu.page = 4
						amenu.row = 1
					else
						if bankStats.cash >= getBuyPrice('sns_pistol') then
							TriggerServerEvent("deductMoney", 0, getBuyPrice('sns_pistol'))
							TriggerServerEvent("giveWeapon", 'sns_pistol', 6)
							GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNSPISTOL'), 6, false, false)
							ShowNotification("SNS Pistol bought.")
						else
							ShowNotification("~r~You don't have enough money for that.")
						end
					end
				elseif amenu.row == 4 then
					if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_VINTAGEPISTOL'), false) then
						amenu.page = 5
						amenu.row = 1
					else
						if bankStats.cash >= getBuyPrice('vintage_pistol') then
							TriggerServerEvent("deductMoney", 0, getBuyPrice('vintage_pistol'))
							TriggerServerEvent("giveWeapon", 'vintage_pistol', 7)
							GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_VINTAGEPISTOL'), 7, false, false)
							ShowNotification("Vintage Pistol bought.")
						else
							ShowNotification("~r~You don't have enough money for that.")
						end
					end
				end
			elseif amenu.page == 1 then	-- Other Menu
				if amenu.row == 1 then
					if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_PUMPSHOTGUN'), false) then
						amenu.page = 6
						amenu.row = 1
					else
						if bankStats.cash >= getBuyPrice('shotgun') then
							TriggerServerEvent("deductMoney", 0, getBuyPrice('shotgun'))
							TriggerServerEvent("giveWeapon", 'pump_shotgun', 8)
							GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PUMPSHOTGUN'), 8, false, false)
							ShowNotification("Mossberg 500 bought.")
						else
							ShowNotification("~r~You don't have enough money for that.")
						end
					end
				elseif amenu.row == 2 then
					-- M1 Garand
				elseif amenu.row == 2 then
					-- M1 Carbine
				end
			elseif amenu.page == 2 then -- Pistol
				if amenu.row == 1 then
					if bankStats.cash >= getAmmoPrice('pistol') then
						TriggerServerEvent("deductMoney", 0, getAmmoPrice('pistol'))
						TriggerServerEvent("giveAmmo", 'ammo_pistol', 12)
						AddAmmoToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), 12)
						ShowNotification("1 Pistol magazine bought for $" .. getAmmoPrice('pistol'))
					else
						ShowNotification("~r~You don't have enough money for that.")
					end
				elseif amenu.row == 2 then
					if HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), 0x359B7AAE) == false then
						if bankStats.cash >= getComponentPrice('pistol') then
							TriggerServerEvent("deductMoney", 0, getComponentPrice('pistol'))
							GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), 0x359B7AAE)
							ShowNotification("Flashlight attachment bought.")
						end
					end
				elseif amenu.row == 3 then
					-- Suppressor
				end
			elseif amenu.page == 3 then -- Combat Pistol
				if amenu.row == 1 then
					if bankStats.cash >= getAmmoPrice('combat_pistol') then
						TriggerServerEvent("deductMoney", 0, getAmmoPrice('combat_pistol'))
						TriggerServerEvent("giveAmmo", 'ammo_pistol', 12)
						AddAmmoToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), 12)
						ShowNotification("1 Pistol magazine bought for $" .. getAmmoPrice('combat_pistol'))
					else
						ShowNotification("~r~You don't have enough money for that.")
					end
				elseif amenu.row == 2 then
					if HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_COMBATPISTOL'), 0x359B7AAE) == false then
						if bankStats.cash >= getComponentPrice('combat_pistol') then
							TriggerServerEvent("deductMoney", 0, getComponentPrice('combat_pistol'))
							GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_COMBATPISTOL'), 0x359B7AAE)
							ShowNotification("Flashlight attachment bought.")
						end
					end
				elseif amenu.row == 3 then
					-- Suppressor
				end
			elseif amenu.page == 4 then -- SNS Pistol
				if amenu.row == 1 then
					if bankStats.cash >= getAmmoPrice('sns_pistol') then
						TriggerServerEvent("deductMoney", 0, getAmmoPrice('sns_pistol'))
						TriggerServerEvent("giveAmmo", 'ammo_pistol', 6)
						AddAmmoToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), 6)
						ShowNotification("1 Pistol magazine bought for $" .. getAmmoPrice('sns_pistol'))
					else
						ShowNotification("~r~You don't have enough money for that.")
					end
				end
			elseif amenu.page == 5 then -- Vintage Pistol
				if amenu.row == 1 then
					if bankStats.cash >= getAmmoPrice('vintage_pistol') then
						TriggerServerEvent("deductMoney", 0, getAmmoPrice('vintage_pistol'))
						TriggerServerEvent("giveAmmo", 'ammo_pistol', 7)
						AddAmmoToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), 7)
						ShowNotification("1 Pistol magazine bought for $" .. getAmmoPrice('vintage_pistol'))
					else
						ShowNotification("~r~You don't have enough money for that.")
					end
				elseif amenu.row == 2 then
					-- Suppressor
				end
			elseif amenu.page == 6 then -- Shotgun
				if amenu.row == 1 then
					if bankStats.cash >= getAmmoPrice('shotgun') then
						TriggerServerEvent("deductMoney", 0, getAmmoPrice('shotgun'))
						TriggerServerEvent("giveAmmo", 'ammo_shotgun', 8)
						AddAmmoToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PUMPSHOTGUN'), 8)
						ShowNotification("8 Shotgun ammo bought for $" .. getAmmoPrice('shotgun'))
					else
						ShowNotification("~r~You don't have enough money for that.")
					end
				elseif amenu.row == 2 then
					if HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_PUMPSHOTGUN'), 0x7BC4CDDC) == false then
						if bankStats.cash >= getComponentPrice('shotgun') then
							TriggerServerEvent("deductMoney", 0, getComponentPrice('shotgun'))
							GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PUMPSHOTGUN'), 0x7BC4CDDC)
							ShowNotification("Flashlight attachment bought.")
						end
					end
				end
			end
		else
			local price = getBuyPrice('gunLicense')
			if bankStats.cash >= price then
				TriggerServerEvent("buyLicense", 'handgun', price)
				licenses.handgun = true
			else
				ShowNotification("~r~You don't have enough cash for that.")
			end
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if amenu.page == 0 or amenu.page == 1 then
			amenu.show = 0
			amenu.row = 1
			phone('enable')
			TriggerEvent("AwesomeFreeze", false)
		elseif amenu.page == 2 or amenu.page == 3 or amenu.page == 4 or amenu.page == 5 then
			amenu.page = 0
			amenu.row = 1
		elseif amenu.page == 6 then
			amenu.page = 1 
			amenu.row = 1
		end
	end
end




	-- ============================== MENU FUNCTIONS ==============================

function drawGunPrice(types, gun, name, y)
	local myPed = GetPlayerPed(-1)
	if types == 'weapon' then
		RequestStreamedTextureDict("mpleaderboard", true)
		while not HasStreamedTextureDictLoaded("mpleaderboard") do
			Wait(0)
		end
		if HasPedGotWeapon(myPed, GetHashKey(gun), false) then
			DrawSprite("mpleaderboard", "leaderboard_votetick_icon", 0.935, y+0.02, 0.035, 0.045, 0.0, 255, 255, 255, 255)
			DrawSprite("mpleaderboard", "leaderboard_voteblank_icon", 0.935, y+0.02, 0.035, 0.045, 0.0, 0, 0, 0, 255)
		else
			drawTxt(0.916, y, 0.0, 0.0, 0.35, "$" .. getBuyPrice(name),255,255,255,255)
		end
	elseif types == 'component' then
		RequestStreamedTextureDict("mpleaderboard", true)
		while not HasStreamedTextureDictLoaded("mpleaderboard") do
			Wait(0)
		end
		if name == 'pistol' then
			if HasPedGotWeaponComponent(myPed, GetHashKey(gun), 0x359B7AAE) then
				DrawSprite("mpleaderboard", "leaderboard_votetick_icon", 0.935, y+0.02, 0.035, 0.045, 0.0, 255, 255, 255, 255)
				DrawSprite("mpleaderboard", "leaderboard_voteblank_icon", 0.935, y+0.02, 0.035, 0.045, 0.0, 0, 0, 0, 255)
			else
				drawTxt(0.916, y, 0.0, 0.0, 0.35, "$" .. getComponentPrice(name),255,255,255,255)
			end
		elseif name == 'combat_pistol' then
			if HasPedGotWeaponComponent(myPed, GetHashKey(gun), 0x359B7AAE) then
				DrawSprite("mpleaderboard", "leaderboard_votetick_icon", 0.935, y+0.02, 0.035, 0.045, 0.0, 255, 255, 255, 255)
				DrawSprite("mpleaderboard", "leaderboard_voteblank_icon", 0.935, y+0.02, 0.035, 0.045, 0.0, 0, 0, 0, 255)
			else
				drawTxt(0.916, y, 0.0, 0.0, 0.35, "$" .. getComponentPrice(name),255,255,255,255)
			end
		elseif name == 'shotgun' then
			if HasPedGotWeaponComponent(myPed, GetHashKey(gun), 0x7BC4CDDC) then
				DrawSprite("mpleaderboard", "leaderboard_votetick_icon", 0.935, y+0.02, 0.035, 0.045, 0.0, 255, 255, 255, 255)
				DrawSprite("mpleaderboard", "leaderboard_voteblank_icon", 0.935, y+0.02, 0.035, 0.045, 0.0, 0, 0, 0, 255)
			else
				drawTxt(0.916, y, 0.0, 0.0, 0.35, "$" .. getComponentPrice(name),255,255,255,255)
			end
		elseif name == 'heavy_shotgun' then
			if HasPedGotWeaponComponent(myPed, GetHashKey(gun), 0x7BC4CDDC) then
				DrawSprite("mpleaderboard", "leaderboard_votetick_icon", 0.935, y+0.02, 0.035, 0.045, 0.0, 255, 255, 255, 255)
				DrawSprite("mpleaderboard", "leaderboard_voteblank_icon", 0.935, y+0.02, 0.035, 0.045, 0.0, 0, 0, 0, 255)
			else
				drawTxt(0.916, y, 0.0, 0.0, 0.35, "$" .. getComponentPrice(name),255,255,255,255)
			end
		end
	end
end


