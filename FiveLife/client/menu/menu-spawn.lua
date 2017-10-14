--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

function showSpawnMenu()
	RequestStreamedTextureDict("commonmenu", true)
	while not HasStreamedTextureDictLoaded("commonmenu") do
		Citizen.Wait(1)
	end
	DrawSprite("commonmenu", "gradient_bgd", 0.5, 0.5, 0.16, 0.3, 0.0, 255, 255, 255, 255)
	DrawSprite("commonmenu", "interaction_bgd", 0.5, 0.3, 0.16, 0.075, 0.0, 255, 255, 255, 255)
	DrawRect(0.5, 0.3545, 0.16, 0.034, 0, 0, 0, 255)
	drawTxt(0.425, 0.275, 0.0, 0.0, 0.55, "Spawn Menu",255,255,255,255)
	drawTxt(0.425, 0.335, 0.0, 0.0, 0.35, "SELECT LOCATION",30,88,162,255)
	if amenu.row == 1 then DrawRect(0.5, 0.39, 0.16, 0.034, 255, 255, 255, 255) end
	if amenu.row == 2 then DrawRect(0.5, 0.43, 0.16, 0.034, 255, 255, 255, 255) end
	if amenu.row == 3 then DrawRect(0.5, 0.47, 0.16, 0.034, 255, 255, 255, 255) end
	if amenu.row == 4 then DrawRect(0.5, 0.51, 0.16, 0.034, 255, 255, 255, 255) end
	if amenu.row == 5 then DrawRect(0.5, 0.55, 0.16, 0.034, 255, 255, 255, 255) end
	drawTxt(0.425, 0.37, 0.0, 0.0, 0.35, "Paleto Bay",255,255,255,255)
	drawTxt(0.425, 0.41, 0.0, 0.0, 0.35, "Sandy Shores",255,255,255,255)
	drawTxt(0.425, 0.45, 0.0, 0.0, 0.35, "Chumash",255,255,255,255)
	drawTxt(0.425, 0.49, 0.0, 0.0, 0.35, "Los Santos",255,255,255,255)
	drawTxt(0.425, 0.53, 0.0, 0.0, 0.35, "Your Home",114,114,114,255)
	
	
	
	
	
	-- ============================== KEY PRESSES ==============================
	
	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		if amenu.row > 1 then 
			amenu.row = amenu.row-1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		if amenu.row < 5 then 
			amenu.row = amenu.row+1
			PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		end
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
	
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
	
	elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
		if amenu.row == 5 then
			ShowNotification("~r~You have no home!")
		else
			PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			TriggerServerEvent("finishSpawn", amenu.row)
			TriggerServerEvent("loadPlayerWeapons")
			SetEntityHealth(GetPlayerPed(-1), 200)
			TriggerServerEvent("ActionLog", "spawned at " .. amenu.row .. ".", 0)
			phone('enable')
			updateFace()
			updateClothes()
			amenu.show = 0
			Wait(3000)
			TriggerEvent("sync:updatePlayer")
			TriggerServerEvent("Sync:UpdateWeapons")
		end
	elseif IsControlJustPressed(1, 177) or IsDisabledControlJustPressed(1, 177) then -- Backspace
	
	end
end

