--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local changingWeather = 0
local debugged = false

RegisterNetEvent("ts:timesync")
AddEventHandler("ts:timesync", function(time)
	newTime = time
end)

RegisterNetEvent("ts:weathersync")
AddEventHandler("ts:weathersync", function(weatherNow, weatherLater)
	if newWeather.now ~= weatherNow then
		ClearWeatherTypePersist()
		--ClearOverrideWeather()
		SetWeatherTypeOverTime(weatherNow, 60.0)
		Citizen.Trace("Transitioning Weather...")
		changingWeather = 60
		newWeather.now = weatherNow
	end
	newWeather.new = weatherLater
end)

Citizen.CreateThread(function()
	TriggerServerEvent("ts:newplayer")
	while true do
		Citizen.Wait(1000)
		NetworkOverrideClockTime(newTime.h, newTime.m, newTime.s)
		if changingWeather ~= 0 then
			changingWeather = changingWeather - 1
			if debugged == false then
				Citizen.Trace("Holding Weather...")
				debugged = true
			end
		else
			if debugged == true then
				Citizen.Trace("Setting Weather...")
				debugged = false
			end
			SetWeatherTypePersist(newWeather.now)
			SetWeatherTypeNowPersist(newWeather.now)
			SetWeatherTypeNow(newWeather.now)
			--SetOverrideWeather(newWeather.now)
		end
	end
end)
