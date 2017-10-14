local weatherTypes = {"CLEAR", "EXTRASUNNY", "CLOUDS", "OVERCAST", "RAIN", "CLEARING", "THUNDER", "SMOG", "FOGGY", "XMAS", "SNOWLIGHT", "BLIZZARD"}
local cycle = {duration = 1200000, percent = 100}
local december = false
local hurricane = false
weather = {now = "CLEAR", new = "CLEAR", stage = "NONE"}
time = {h = 18, m = 0, s = 0}

RegisterServerEvent("ts:newplayer")
AddEventHandler("ts:newplayer", function()
    TriggerClientEvent("ts:timesync", source, time)
	TriggerClientEvent("ts:weathersync", source, weather.now, weather.new)
end)

RegisterServerEvent("ts:forceWeather")
AddEventHandler("ts:forceWeather", function()
	cycleWeather()
end)

RegisterServerEvent("ts:overrideTime")
AddEventHandler("ts:overrideTime", function(override)
	if override == "MORNING" then
		time.h = 6
		time.m = 0
	elseif override == "NOON" then
		time.h = 12
		time.m = 0
	elseif override == "EVENING" then
		time.h = 18
		time.m = 0
	elseif override == "NIGHT" then
		time.h = 23
		time.m = 0
	end
	TriggerClientEvent("ts:timesync", -1, time)
end)

RegisterServerEvent("ts:overrideWeather")
AddEventHandler("ts:overrideWeather", function(override)
	local overrideWeather = string.upper(override)
	weather.new = overrideWeather
	print("Weather Override: Next is " .. override)
	TriggerClientEvent("ts:weathersync", -1, weather.now, weather.new)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20000)
		time.m = time.m + 1
		if time.m > 59 then
			time.m = 0

			time.h = time.h + 1
			if time.h > 23 then
				time.h = 0
			end
		end
		TriggerClientEvent("ts:timesync", -1, time)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(cycle.duration)
		cycleWeather()
	end
end)

function cycleWeather()
	weather.now = weather.new
	math.randomseed(GetGameTimer())
	cycle.duration = math.random(1200000, 2400000)
	weather.new = getNextWeather(weather.now, cycle.percent)
	cycle.percent = math.random(1, 100)
	TriggerClientEvent("ts:weathersync", -1, weather.now, weather.new)
	print("Weather Now: " .. weather.now)
	print("Weather Next: " .. weather.new)
	print("Weather Duration: " .. cycle.duration)
end

function getNextWeather(lastWeatherType, key)
	if december then
		return "XMAS"
	elseif hurricane then
		if key > 60 then
			return "THUNDER"
		else
			return "RAIN"
		end
	else
		if lastWeatherType == "EXTRASUNNY" then
			if key > 75 then
				return "EXTRASUNNY"
			elseif key > 30 then
				return "CLEAR"
			elseif key > 10 then
				return "CLOUDS"
			else
				return "OVERCAST"
			end
		elseif lastWeatherType == "CLEAR" then
			if key > 80 then
				return "CLEAR"
			elseif key > 65 then
				return "CLOUDS"
			elseif key > 50 then
				return "OVERCAST"
			elseif key > 35 then
				cycle.duration = math.random(300000, 600000)
				return "CLEARING"
			elseif key > 15 then
				return "EXTRASUNNY"
			elseif key > 5 then
				return "FOGGY"
			else
				return "SMOG"
			end
		elseif lastWeatherType == "OVERCAST" then
			if key > 70 then
				cycle.duration = math.random(300000, 600000)
				return "CLEARING"
			elseif key > 50 then
				return "OVERCAST"
			elseif key > 30 then
				return "CLEAR"
			elseif key > 20 then
				return "FOGGY"
			else
				return "CLOUDS"
			end
		elseif lastWeatherType == "CLEARING" then
			if key > 80 then
				return "RAIN"
			elseif key > 60 then
				return "FOGGY"
			elseif key > 40 then
				return "OVERCAST"
			else
				return "CLEAR"
			end
		elseif lastWeatherType == "RAIN" then
			if key > 80 then
				return "RAIN"
			elseif key > 55 then
				return "THUNDER"
			else
				cycle.duration = math.random(300000, 600000)
				return "CLEARING"
			end
		elseif lastWeatherType == "THUNDER" then
			if key > 80 then
				return "THUNDER"
			elseif key > 55 then
				return "RAIN"
			else
				cycle.duration = math.random(300000, 600000)
				return "CLEARING"
			end
		elseif lastWeatherType == "CLOUDS" then
			if key > 80 then
				return "CLOUDS"
			elseif key > 60 then
				return "OVERCAST"
			elseif key > 30 then
				return "CLEAR"
			elseif key > 10 then
				return "CLEARING"
			else
				return "FOGGY"
			end
		elseif lastWeatherType == "FOGGY" then
			if key > 90 then
				return "FOGGY"
			elseif key > 35 then
				return "CLEAR"
			elseif key > 15 then
				return "OVERCAST"
			else
				return "CLEARING"
			end
		elseif lastWeatherType == "SMOG" then
			if key > 80 then
				return "SMOG"
			elseif key > 40 then
				return "CLEAR"
			elseif key > 15 then
				return "OVERCAST"
			else
				return "CLOUDS"
			end
		end
	end
end
