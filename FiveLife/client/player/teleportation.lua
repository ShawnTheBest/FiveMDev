RegisterNetEvent("teleportToPlayer")
AddEventHandler("teleportToPlayer", function(message)
	local playerPed = GetPlayerPed(-1)
	local teleportPed = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(message))))
	SetEntityCoords(playerPed, teleportPed)
end)

RegisterNetEvent("teleportToSender")
AddEventHandler("teleportToSender", function(message)
	local playerPed = GetPlayerPed(-1)
	local teleportPed = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(message))))
	SetEntityCoords(playerPed, teleportPed)
end)

-- Spawn stuff
local SpawnPositions = {
	{-336.650, 6152.88, 31.49},
	{1853.156, 3710.71, 33.27},
	{-3155.62, 1061.545, 20.674},
	{111.197, -721.604, 47.077},
	{8.46, -1674.91, 225.0},
	{8.46, -1674.91, 300.0}
}


function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

-- Police Garage: 404.423, -975.306, -99.0
RegisterNetEvent("playerCreationTele")
AddEventHandler("playerCreationTele", function()
	Citizen.CreateThread(function()
		RequestCollisionAtCoord(408.829, -998.507, -99.0042)
		Citizen.Wait(50)
		SetEntityHeading(GetPlayerPed(-1), 270.0)
		SetEntityCoords(GetPlayerPed(-1), 408.829, -998.507, -99.0042)
		Citizen.Wait(50)
	end)
end)

RegisterNetEvent("teleportSpawning")
AddEventHandler("teleportSpawning", function(location)
	Citizen.CreateThread(function()
		Citizen.Wait(50)
		local playerPed = GetPlayerPed(-1)
		local spawnPos = SpawnPositions[location]
		RequestCollisionAtCoord(spawnPos[1], spawnPos[2], spawnPos[3])
		SetEntityCoords(playerPed, spawnPos[1], spawnPos[2], spawnPos[3])
	end)
end)

RegisterNetEvent("teleportSky")
AddEventHandler("teleportSky", function()
	Citizen.CreateThread(function()
		Citizen.Wait(50)
		local playerPed = GetPlayerPed(-1)
		local spawnPos = SpawnPositions[5]
		RequestCollisionAtCoord(spawnPos[1], spawnPos[2], spawnPos[3])
		SetEntityCoords(playerPed, spawnPos[1], spawnPos[2], spawnPos[3])
	end)
end)

RegisterNetEvent("DeathMenuTele")
AddEventHandler("DeathMenuTele", function()
	Citizen.CreateThread(function()
		Citizen.Wait(50)
		local playerPed = GetPlayerPed(-1)
		local spawnPos = SpawnPositions[5]
		RequestCollisionAtCoord(spawnPos[1], spawnPos[2], spawnPos[3])
		SetEntityCoords(playerPed, spawnPos[1], spawnPos[2], spawnPos[3])
	end)
end)

RegisterNetEvent("getPosition")
AddEventHandler("getPosition", function(message)
	local playerPed = GetPlayerPed(-1)
	local teleportPed = GetEntityCoords(playerPed)
	TriggerEvent('chatMessage', 'SYSTEM', {0, 255, 0}, ":"..teleportPed)
end)
