
-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 900

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos then
				if time > 0 then
					if time == math.ceil(secondsUntilKick / 4) or time == math.ceil(secondsUntilKick / 2) then
						TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1You'll be kicked in " .. time .. " seconds for being AFK!")
					end

					time = time - 1
				else
					TriggerServerEvent("kickForBeingAnAFKDouchebag")
				end
			else
				time = secondsUntilKick
			end

			prevPos = currentPos
		end
	end
end)

--[[
Citizen.CreateThread(function()
	local id = GetPlayerServerId() -- get player ID 
	while true do
        Wait(150000) -- time to refresh script (10 000 for every 1 seconds)
		TriggerServerEvent("checkMyPingBro")
		ptable = GetPlayers()
		playerNumber = 0
		for _, i in ipairs(ptable) do
			playerNumber = playerNumber + 1
		end
		local name = GetPlayerName(PlayerId())		-- get player name
		TriggerServerEvent('sendSessionPlayerNumber', playerNumber, name, id)	-- Send infos of number players for client to server
	end
end)
]]--

function GetPlayers() -- function to get players
    local players = {}

    for i = 1, 32 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end