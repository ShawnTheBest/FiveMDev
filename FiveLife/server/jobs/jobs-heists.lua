--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

storeCool = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
heistCool = {high = false, mid = false, low = false}
prisonBreak = {status = 'locked', cool = false}

highMinutes = 60
midMinutes = 30
lowMinutes = 15
prisonMinutes = 2

RegisterServerEvent("Heist:UpdateHeists")
AddEventHandler("Heist:UpdateHeists", function(level, place, xPos, yPos, zPos)
	if level == 'high' then
		TriggerClientEvent("UpdateHeistCooldown", -1, 'high', true, false)
		TriggerClientEvent("UpdateHeistCooldown", source, 'high', true, true)
		heistCool.high = true
	elseif level == 'mid' then
		TriggerClientEvent("UpdateHeistCooldown", -1, 'mid', true, nil)
		TriggerClientEvent("UpdateHeistCooldown", source, 'mid', true, nil)
		heistCool.mid = true
	elseif level == 'low' then
		TriggerClientEvent("UpdateHeistCooldown", -1, 'low', true, nil)
		heistCool.low = true
	else
		TriggerClientEvent("UpdateHeistCooldown", -1, level, true, nil)
		storeCool[level] = 45
	end
	TriggerEvent("newReport", 'police', xPos, yPos, zPos, "BRINKS: Alarm Activated", place)
end)

RegisterServerEvent("Heist:PrisonBreak")
AddEventHandler("Heist:PrisonBreak", function(status)
	if status == "STAGE1" then
		TriggerClientEvent("UpdateHeistCooldown", -1, 'prison', true, 'locked')
		TriggerEvent("newReport", 'police', 2082.8, 2340.3, 94.3, "Possible power failure at Power Station A.", "Ron Alternates Wind Farm")
		prisonBreak.cool = true
	elseif status == "STAGE2" then
		-- Nothing yet
	elseif status == "STAGE3" then
		TriggerEvent("newReport", 'police', 1831.5, 2602.7, 45.9, "Total Power Failure. Prison break in progress.", "Bolingbroke Penitentiary")
		TriggerClientEvent("UpdateHeistCooldown", -1, 'prison', true, 'open')
		prisonBreak.status = 'open'
	end
end)

RegisterServerEvent("Heist:NewPlayer")
AddEventHandler("Heist:NewPlayer", function()
	TriggerClientEvent("UpdateHeistCooldown", source, 'high', heistCool.high, false)
	TriggerClientEvent("UpdateHeistCooldown", source, 'mid', heistCool.mid, false)
	TriggerClientEvent("UpdateHeistCooldown", source, 'low', heistCool.low, false)
	TriggerClientEvent("UpdateHeistCooldown", source, 'prison', prisonBreak.cool, prisonBreak.status)
	for i=1, 14 do 
		if storeCool[i] ~= 0 then
			TriggerClientEvent("UpdateHeistCooldown", source, i, true, false)
		end
	end
end)
