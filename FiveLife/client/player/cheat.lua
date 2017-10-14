--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

local unauthorizedWeapons = {0x22D8FE39, 0x9D07F764, 0xA284510B, 0xB1CA77B1, 0x42BF8A85, 0x93E220BD, 0x2C3731D9, 0x6D544C99} -- AP, MG, GLauncher, RPG, Minigun, Grenade, SBomb, Railgun 
local flaggedForKick = false
local bannedWeapon = 0x22D8FE39
local banReason = ""
local kickReason = ""

Citizen.CreateThread(function()
	while true do
		-- Citizen.Wait(60000) -- 1 Minute
		Citizen.Wait(300000)
		
		-- PayCheck
		TriggerServerEvent("PayCheck:PayMe", onDuty)
		
		-- Check money values
		TriggerServerEvent("AntiCheat:CheckLocalMoney", moneyBank, moneyCash)

		for i=1, 10, 1 do
			if HasPedGotWeapon(GetPlayerPed(-1), unauthorizedWeapons[i], false) then
				flaggedForKick = true
				bannedWeapon = unauthorizedWeapons[i]
				kickReason = "Unauthorized Weapons"
			end
		end
		
		if flaggedForKick == true then
			TriggerServerEvent("AntiCheat:Kicked", kickReason, "Weapon Hash - " .. bannedWeapon)
		end
	end
end)
