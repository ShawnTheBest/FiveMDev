--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================


function showBankMenu()
	HideHudAndRadarThisFrame()
	RequestStreamedTextureDict("bank", true)
	while not HasStreamedTextureDictLoaded("bank") do
		Citizen.Wait(1)
	end
	DrawSprite("bank", "bank_base", 0.5,0.4, 0.54,0.55, 0.0, 255, 255, 255, 255)
	
	if amenu.page == 0 then
		DrawSprite("bank", "bank_info", 0.5,0.4, 0.54,0.55, 0.0, 255, 255, 255, 255)
		drawTitle(0.5, 0.193,  0.55, "Savings Bank",255,255,255,255,1)
		
		if amenu.input == 0 then
			DrawSprite("bank", "bank_buttons", 0.5,0.4, 0.54,0.55, 0.0, 255, 255, 255, 255)
			if amenu.row == 1 then DrawSprite("bank", "bank_highlight", 0.5,0.4, 0.54,0.55, 0.0, 255, 255, 255, 255) end
			if amenu.row == 2 then DrawSprite("bank", "bank_highlight", 0.5,0.454, 0.54,0.55, 0.0, 255, 255, 255, 255) end
			if amenu.row == 3 then DrawSprite("bank", "bank_highlight", 0.5,0.505, 0.54,0.55, 0.0, 255, 255, 255, 255) end
	
			drawTitle(0.5, 0.2855, 0.35, "Withdrawal",255,255,255,255,1)
			drawTitle(0.5, 0.3435, 0.35, "Deposit",255,255,255,255,1)
			drawTitle(0.5, 0.3935, 0.35, "Transfer",255,255,255,255,1)
		end
		drawTitle(0.34, 0.54, 0.35, "Account Balance",255,255,255,255,1)
		drawTitle(0.34, 0.565, 0.35, "~g~" .. moneyBank,255,255,255,255,1)
	end
	
	
	
	
	
	-- ============================== KEY PRESSES ==============================
	
	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		if amenu.row > 1 then 
			amenu.row = amenu.row-1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		if amenu.row < 3 and amenu.input == 0 then 
			amenu.row = amenu.row+1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
		
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
		if amenu.input == 0 then
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			if amenu.row == 1 then
				DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
				amenu.input = 1
				keyboardOpen = true
			elseif amenu.row == 2 then
				DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
				amenu.input = 1
				keyboardOpen = true
			elseif amenu.row == 3 then
				ShowNotification("Transfers coming soon")
			end
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
		if amenu.page == 0 then
			if amenu.input == 0 then
				PlaySound(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				amenu.show = 0
				phone('enable')
				TriggerEvent("AwesomeFreeze", false)
				local myPed = GetPlayerPed(-1)
				SetEnableHandcuffs(myPed, false)
				HidePedWeaponForScriptedCutscene(myPed, false)
				SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
			end
		end
	end
	
	if amenu.input == 1 then
		HideHudAndRadarThisFrame()
		if UpdateOnscreenKeyboard() == 3 then
			amenu.input = 0
			keyboardOpen = false
		elseif UpdateOnscreenKeyboard() == 1 then
			local inputText = GetOnscreenKeyboardResult()
			if string.len(inputText) > 0 then
				local amount = tonumber(inputText)
				if amount ~= nil and amount > 0 then
					if amenu.row == 1 then
						if moneyBank >= amount then
							TriggerServerEvent("Menu:Bank", 'withdraw', amount)
							amenu.input = 0
							keyboardOpen = false
						else
							ShowNotification("~r~Not enough funds in account!")
							DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
						end
					elseif amenu.row == 2 then
						if moneyCash >= amount then
							TriggerServerEvent("Menu:Bank", 'deposit', amount)
							amenu.input = 0
							keyboardOpen = false
						else
							ShowNotification("~r~Not enough funds in hand!")
							DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
						end
					end
				else
					DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8F", "", "", "", "", "", 64)
				end
			else
				DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
			end
		elseif UpdateOnscreenKeyboard() == 2 then
			amenu.input = 0
			keyboardOpen = false
		end
	end
end

