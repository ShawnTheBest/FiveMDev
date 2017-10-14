local distPlayerNames = 35
local height = 1.0
local proneAnim = {{"move_crawl", "onfront_bwd"}, {"move_crawl", "onfront_fwd"}, {"mp_bank_heist_1", "prone_r_loop"}, {"mp_bank_heist_1", "prone_l_loop"}}
local crouchAnim = {{"random@arrests", "kneeling_arrest_idle"}, {"random@arrests@busted", "enter"}, {"random@arrests@busted", "exit"}, {"random@arrests@busted", "idle_a"}}

function DrawText3D(x, y, z, text, r, g, b, alpha)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(2)
        SetTextProportional(1)
        SetTextColour(r, g, b, alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
		SetTextCentre(1)
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		if cameraActive == false then
			for id = 0, 64 do
				if (NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
					local targetPed = GetPlayerPed(id)
					local pCoords = GetEntityCoords(GetPlayerPed(-1), true)
					local tCoords = GetEntityCoords(GetPlayerPed(id), true)
					local distance = math.floor(GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, tCoords.x, tCoords.y, tCoords.z, true))
					local prone = false
					local crouch = false
					
					if IsPedInAnyVehicle(targetPed, false) then
						local veh = GetVehiclePedIsIn(targetPed, false)
						if GetPedInVehicleSeat(veh, -1) == targetPed then
							tCoords = GetOffsetFromEntityInWorldCoords(veh, -0.4, 0.2, 0.1)
						elseif GetPedInVehicleSeat(veh, 0) == targetPed then
							tCoords = GetOffsetFromEntityInWorldCoords(veh, 0.4, 0.2, 0.1)
						elseif GetPedInVehicleSeat(veh, 1) == targetPed then
							tCoords = GetOffsetFromEntityInWorldCoords(veh, -0.4, -0.9, 0.1)
						elseif GetPedInVehicleSeat(veh, 2) == targetPed then
							tCoords = GetOffsetFromEntityInWorldCoords(veh, 0.4, -0.9, 0.1)
						end
					else
						for i=1, #proneAnim do
							if IsEntityPlayingAnim(targetPed, proneAnim[i][1], proneAnim[i][2], 3) then
								prone = true
							end
						end
						for i=1, #crouchAnim do
							if IsEntityPlayingAnim(targetPed, crouchAnim[i][1], crouchAnim[i][2], 3) then
								crouch = true
							end
						end
						
						if prone then
							distPlayerNames = 15
							height = -0.4
						elseif crouch then
							distPlayerNames = 25
							height = 0.5
						elseif IsPedRagdoll(targetPed) then
							distPlayerNames = 25
							height = -0.4
						else
							distPlayerNames = 35
							height = 1.0
						end
					end
					
					if (distance < distPlayerNames) and IsEntityVisible(targetPed) then
						if HasEntityClearLosToEntity(GetPlayerPed(-1), targetPed, 17) then
							if NetworkIsPlayerTalking(id) then
								DrawText3D(tCoords.x, tCoords.y, tCoords.z+height, "" .. GetPlayerServerId(id), 26, 177, 242, 255)
							else
								DrawText3D(tCoords.x, tCoords.y, tCoords.z+height, "" .. GetPlayerServerId(id), 255, 255, 255, 255)
							end
						end
					end
				end
			end
		end
    end
end)

