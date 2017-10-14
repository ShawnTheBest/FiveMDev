--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local lastHeading = 0.0
local weaponOnBack = 0
local zVal = 0.225
local yRot = 125.0
local yVal = -0.17

RegisterNetEvent("Stance:SyncPlayerHeading")
AddEventHandler('Stance:SyncPlayerHeading', function(user, heading)
	local playerPed = GetPlayerPed(GetPlayerFromServerId(user))
	SetEntityHeading(playerPed, heading)
end)

RegisterNetEvent("FL:PutIntoTrunk")
AddEventHandler('FL:PutIntoTrunk', function()
	local myCoord = GetEntityCoords(GetPlayerPed(-1))
	local veh = GetClosestVehicle(myCoord.x, myCoord.y, myCoord.z, 5.0, 0, 70)
	if veh ~= nil then
		local vehCoord = GetEntityCoords(veh)
		if GetDistanceBetweenCoords(vehCoord.x, vehCoord.y, vehCoord.z, myCoord.x, myCoord.y, myCoord.z, true) < 5 then
			situation.vehicle = veh
			if situation.type == "TRUNKED" then
				local vCoord = GetOffsetFromEntityInWorldCoords(veh, 0.0, 7.0, 0.0)
				changeSituation("DEAD")
				SetEntityCoords(GetPlayerPed(-1), vCoord.x, vCoord.y, vCoord.z)
			elseif situation.type == "DEAD" then
				changeSituation("TRUNKED")
			end
		end
	end
end)

RegisterNetEvent('LE:CuffMe')
AddEventHandler('LE:CuffMe', function(arrestingOfficer)
	local serverPed = GetPlayerPed(GetPlayerFromServerId(arrestingOfficer))
	local sCoord = GetEntityCoords(serverPed)
	local myCoord = GetEntityCoords(GetPlayerPed(-1))
	if GetDistanceBetweenCoords(sCoord.x, sCoord.y, sCoord.z, myCoord.x, myCoord.y, myCoord.z, true) < 5.0 then
		if situation.type ~= "CUFFED" then
			if stance.type == "PRONE" or stance.type == "LAYING_GIVEUP" then
				TriggerServerEvent("LE:CuffOnGround", arrestingOfficer)
			end
			GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HANDCUFFS"), 1, false, true)
			SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_HANDCUFFS"), true)
			if GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(GetPlayerPed(-1), 7, 41, 0, 0)
			else
				SetPedComponentVariation(GetPlayerPed(-1), 7, 25, 0, 0)
			end
			SetEnableHandcuffs(GetPlayerPed(-1), true)
			changeSituation("CUFFED")
		elseif situation.type == "CUFFED" then
			SetEnableHandcuffs(GetPlayerPed(-1), false)
			SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 0)
			phoneEnabled = true
			SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263, true)
			changeSituation("ALIVE")
		end
	else
		TriggerServerEvent("LE:TooFarForCuff", arrestingOfficer)
	end
end)

RegisterNetEvent('LE:CuffPlayerOnGround')
AddEventHandler('LE:CuffPlayerOnGround', function(playerToCuff)
	local pedToCuff = GetPlayerPed(GetPlayerFromServerId(playerToCuff))
	local pedCoord = GetOffsetFromEntityInWorldCoords(pedToCuff, -1.0, 0.25, 0.0)
	SetEntityCoords(GetPlayerPed(-1), pedCoord.x, pedCoord.y, pedCoord.z-1.0)
	SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(pedToCuff) - 90.0)
	RequestAnimDict('mp_arresting') while not HasAnimDictLoaded('mp_arresting') do Citizen.Wait(0) end
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'arrest_on_floor_front_left_a', 8.0, 1.0, -1, 0, 0, 0, 0, 0)
end)

RegisterNetEvent("grabPlayer")
AddEventHandler('grabPlayer', function(user)
	situation.grabber = tonumber(user)
	if situation.type == "GRABBED" then
		changeSituation("CUFFED")
	elseif situation.type == "CUFFED" then
		changeSituation("GRABBED")
	end
end)

RegisterNetEvent("FL:StartDragging")
AddEventHandler('FL:StartDragging', function(user)
	situation.grabber = tonumber(user)
	if situation.type == "DEAD" or situation.type == "DOWNED" then
		RequestAnimDict('combat@drag_ped@')
		changeSituation("DRAGGED")
	else
		TriggerServerEvent("FiveLife:CancelDrag", situation.grabber)
	end
end)

RegisterNetEvent("FL:StopDragging")
AddEventHandler("FL:StopDragging", function(user)
	situation.grabber = tonumber(user)
	changeSituation("DEAD")
end)

RegisterNetEvent("FL:CancelDrag")
AddEventHandler('FL:CancelDrag', function()
	situation.grabber = tonumber(user)
	changeSituation("ALIVE")
end)

RegisterNetEvent("FL:DragPlayer")
AddEventHandler('FL:DragPlayer', function(user)
	situation.grabbing = tonumber(user)
	RequestAnimDict('combat@drag_ped@')
	local targetPed = GetPlayerPed(GetPlayerFromServerId(situation.grabbing))
	local targetCoords = GetEntityCoords(targetPed, true)
	local myCoords = GetEntityCoords(GetPlayerPed(-1), true)
	if targetPed ~= GetPlayerPed(-1) then
		if GetDistanceBetweenCoords(targetCoords.x, targetCoords.y, targetCoords.z, myCoords.x, myCoords.y, myCoords.z, true) < 5.0 then
			if situation.type == "DRAGGING" then
				changeSituation("ALIVE")
				TriggerServerEvent('FiveLife:StopDragging', situation.grabbing)
			elseif (stance.type == "STANDING" or stance.type == "CROUCH") and situation.type == "ALIVE" then
				changeSituation("DRAGGING")
				TriggerServerEvent('FiveLife:StartDragging', situation.grabbing)
			end
		else
			ShowNotification("~r~Must be closer to target")
		end
	else
		ShowNotification("~r~You can't drag yourself")
		changeStance("STANDING")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if situation.type == "DOWNED" or stance.type == "PRONE" then
			if not stance.laying then
				if situation.type == "DOWNED" then
					Citizen.Wait(1050)
				elseif stance.type == "PRONE" then
					Citizen.Wait(850)
				end
				stance.laying = true
			end
		end
	end
end)

Citizen.CreateThread(function()
	RequestAnimSet("move_ped_crouched")
	RequestAnimSet("move_ped_crouched_strafing")
	RequestAnimDict("move_crawl")

	while true do
		Citizen.Wait(0)

		--checkWeapons()
		if situation.type == "ALIVE" or situation.type == "JAILED" then
			if IsControlJustPressed(1, 20) or IsDisabledControlJustPressed(1, 20) then -- Z
				if stance.type == "STANDING" or stance.type == "CROUCH" or stance.type == "PRONE" or stance.type == "HANDSUP" or stance.type == "LAYING_GIVEUP" then
					if not IsEntityPlayingAnim(GetPlayerPed(-1), 'mp_weapons_deal_sting', 'crackhead_bag_loop', 3) then
						if stance.type == "STANDING" then
							changeStance("HANDSUP")
						elseif stance.type == "CROUCH" then
							changeStance("STANDING")
							Wait(10)
							changeStance("HANDSUP")
						elseif stance.type == "PRONE" then
							changeStance("LAYING_GIVEUP")
						elseif stance.type == "HANDSUP" then
							changeStance("STANDING")
							DisablePlayerFiring(GetPlayerPed(-1), false)
						elseif stance.type == "LAYING_GIVEUP" then
							changeStance("PRONE")
							DisablePlayerFiring(GetPlayerPed(-1), false)
						end
					end
				end
			end

			-- Stance Changes
			if IsControlPressed(0, 36) or IsDisabledControlPressed(0, 36) then -- CTRL
				if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					DisableControlAction(0, 32, 1)
					DisableControlAction(0, 33, 1)
					DisableControlAction(0, 268, 1)
					DisableControlAction(0, 269, 1)
					if IsDisabledControlJustPressed(0, 32) then -- W
						if stance.type == "CROUCH" then
							changeStance("STANDING")
						elseif stance.type == "PRONE" then
							changeStance("CROUCH")
						elseif stance.type == "KNEEL_HANDSUP" then
							changeStance("HANDSUP")
						elseif stance.type == "KNEEL_HANDSONHEAD" then
							changeStance("KNEEL_HANDSUP")
						end
					elseif IsDisabledControlJustPressed(0, 33) then -- S
						if stance.type == "STANDING" then
							changeStance("CROUCH")
						elseif stance.type == "CROUCH" then
							changeStance("PRONE")
						elseif stance.type == "HANDSUP" then
							changeStance("KNEEL_HANDSUP")
						elseif stance.type == "KNEEL_HANDSUP" then
							changeStance("KNEEL_HANDSONHEAD")
						end
					end
				end
			end
			if stance.type == "PRONE" then
				checkProneMovement()
			elseif stance.type ~= "STANDING" and stance.type ~= "CROUCH" then
				restrictStancePed()
			end
			if situation.type == "JAILED" then
				restrictSituationPed()
			end
		else
			if situation.type == "DRAGGING" then
				checkDraggingMovement()
			elseif situation.type == "DOWNED" then
				checkDownedMovement()
			else
				restrictSituationPed()
			end
		end
	end
end)


	--------------------------------
	---- CHANGE STANCE FUNCTION ----
	--------------------------------

function changeStance(pStance)
	local ped = GetPlayerPed(-1)
	local nextStance = pStance
	if nextStance == "STANDING" then -- STANDING
		ClearPedTasks(ped)
		ResetPedMovementClipset(ped, 0.0)
		ResetPedStrafeClipset(ped)
		if stance.type == "KNEEL_HANDSUP" then
			RequestAnimDict('random@arrests') while not HasAnimDictLoaded('random@arrests') do Citizen.Wait(0) end
			TaskPlayAnim(ped, 'random@arrests', 'kneeling_arrest_escape', 8.0, 2.0, -1, 0, 0, 0, 0, 0)
		end
	elseif nextStance == "CROUCH" then -- CROUCH
		ClearPedTasks(ped)
		SetPedMovementClipset(ped, "move_ped_crouched", 2.5)
		SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
	elseif nextStance == "PRONE" then -- PRONE
		TaskPlayAnim(ped, "move_crawl", "onfront_fwd", 8.0, -4.0, -1, 2, 0.0, false, false, false)
		stance.laying = true
	elseif nextStance == "HANDSUP" then -- HANDSUP
		if stance.type == "STANDING" then
			RequestAnimDict('ped') while not HasAnimDictLoaded('ped') do Citizen.Wait(0) end
			TaskPlayAnim(ped, 'ped', 'handsup_base', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
		else
			RequestAnimDict('random@arrests') while not HasAnimDictLoaded('random@arrests') do Citizen.Wait(0) end
			TaskPlayAnim(ped, 'random@arrests', 'kneeling_arrest_get_up', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Citizen.Wait(3000)
			TaskPlayAnim(ped, 'ped', 'handsup_base', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
		end
	elseif nextStance == "KNEEL_HANDSUP" then -- KNEEL_HANDSUP
		if stance.type == "HANDSUP" then
			RequestAnimDict('random@arrests') while not HasAnimDictLoaded('random@arrests') do Citizen.Wait(0) end
			TaskPlayAnim(ped, 'random@arrests', 'idle_2_hands_up', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Citizen.Wait(3500)
			TaskPlayAnim(ped, 'random@arrests', 'kneeling_arrest_idle', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
		elseif stance.type == "KNEEL_HANDSONHEAD" then
			RequestAnimDict('random@arrests@busted') while not HasAnimDictLoaded('random@arrests@busted') do Citizen.Wait(0) end
			TaskPlayAnim(ped, 'random@arrests@busted', 'exit', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Citizen.Wait(3500)
			TaskPlayAnim(ped, 'random@arrests', 'kneeling_arrest_idle', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
		end
	elseif nextStance == "KNEEL_HANDSONHEAD" then -- KNEEL_HANDSONHEAD
		RequestAnimDict('random@arrests@busted') while not HasAnimDictLoaded('random@arrests@busted') do Citizen.Wait(0) end
		TaskPlayAnim(ped, 'random@arrests@busted', 'enter', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
		Citizen.Wait(1500)
		TaskPlayAnim(ped, 'random@arrests@busted', 'idle_a', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
	elseif nextStance == "LAYING_GIVEUP" then -- LAYING_GIVEUP
		RequestAnimDict('mp_bank_heist_1') while not HasAnimDictLoaded('mp_bank_heist_1') do Citizen.Wait(0) end
		if GetRandomIntInRange(1, 10) > 5 then
			TaskPlayAnim(ped, 'mp_bank_heist_1', 'prone_r_loop', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
		else
			TaskPlayAnim(ped, 'mp_bank_heist_1', 'prone_l_loop', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
		end
		stance.laying = false
	end
	stance.type = nextStance
	ClearPedTasks(ped)
end


	-----------------------------------
	---- CHANGE SITUATION FUNCTION ----
	-----------------------------------

function changeSituation(pSituation)
	local ped = GetPlayerPed(-1)
	local nextSituation = pSituation
	ClearPedTasks(ped)
	if nextSituation == "ALIVE" then -- ALIVE
		if situation.type == "DEAD_CUFFED" then
			nextSituation = "CUFFED"
			GiveWeaponToPed(ped, GetHashKey("WEAPON_HANDCUFFS"), 1, false, true)
			SetCurrentPedWeapon(ped, GetHashKey("WEAPON_HANDCUFFS"), true)
			SetEnableHandcuffs(ped, true)
			changeStance("STANDING")
		elseif situation.type == "KO_JAIL" then
			nextSituation = "JAILED"
			SetEntityInvincible(ped, false)
			changeStance("PRONE")
		elseif situation.type == "KO" or situation.type == "DEAD" then
			changeStance("PRONE")
		elseif situation.type == "DOWNED" then
			changeStance("PRONE")
		elseif situation.type == "DRAGGING" then
			TaskPlayAnim(ped, 'combat@drag_ped@', 'injured_putdown_plyr', 8.0, 1.0, -1, 0, 0, 0, 0, 0)
			lastHeading = 0.0
			situation.grabbing = 0
			Citizen.Wait(2500)
			changeStance("STANDING")
		elseif situation.type == "CUFFED" then
			SetEnableHandcuffs(ped, false)
			SetPedComponentVariation(ped, 7, 0, 0, 0)
			SetCurrentPedWeapon(ped, 0xA2719263, true)
		end
	elseif nextSituation == "CUFFED" then -- CUFFED
		if situation.type == "GRABBED" then
			DetachEntity(ped, true, false)
			while IsEntityAttachedToAnyPed(ped) do
				DetachEntity(ped, true, false)
			end
			DetachEntity(ped, true, false)
			situation.grabber = 0
		end
		RequestAnimDict('mp_arresting') while not HasAnimDictLoaded('mp_arresting') do Citizen.Wait(0) end
		ResetPedMovementClipset(ped, 0.0)
		ResetPedStrafeClipset(ped)
		ClearPedTasks(ped)
		if stance.type == "LAYING_GIVEUP" or stance.type == "PRONE" then
			RequestAnimDict('mp_arresting') while not HasAnimDictLoaded('mp_arresting') do Citizen.Wait(0) end
			TaskPlayAnim(ped, 'mp_arresting', 'arrest_on_floor_front_left_b', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Citizen.Wait(5000)
		end
		changeStance("STANDING")
		TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
	elseif nextSituation == "GRABBED" then -- GRABBED
		if situation.grabber ~= 0 then
			local grabPed = GetPlayerPed(GetPlayerFromServerId(situation.grabber))
			AttachEntityToEntity(ped, grabPed, 11816, 0.2, 0.5, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		end
	elseif nextSituation == "GRABBING" then -- GRABBING
		-- Nothin
	elseif nextSituation == "DRAGGED" then -- DRAGGED
		if situation.grabber ~= 0 then
			local coord = GetEntityCoords(GetPlayerPed(-1), true)
			local head = GetEntityHeading(GetPlayerPed(-1))
			local grabPed = GetPlayerPed(GetPlayerFromServerId(situation.grabber))
			RequestAnimDict('combat@drag_ped@') while not HasAnimDictLoaded('combat@drag_ped@') do Citizen.Wait(0) end
			NetworkResurrectLocalPlayer(coord.x, coord.y, coord.z, head, true, false)
			myPlayer.resurrect = true
			ClearPedTasks(ped)
			TaskPlayAnim(ped, 'combat@drag_ped@', 'injured_pickup_back_ped', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Citizen.Wait(5000)
			AttachEntityToEntity(ped, grabPed, 11816, 0.0, 0.6, 0.17, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			TaskPlayAnim(ped, 'combat@drag_ped@', 'injured_drag_ped', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
		end
	elseif nextSituation == "DRAGGING" then -- DRAGGING
		if stance.type == "CROUCH" then
			ResetPedMovementClipset(ped, 0.0)
			ResetPedStrafeClipset(ped)
		end
		if situation.grabbing ~= 0 then
			RequestAnimDict('combat@drag_ped@') while not HasAnimDictLoaded('combat@drag_ped@') do Citizen.Wait(0) end
			TaskPlayAnim(ped, 'combat@drag_ped@', 'injured_pickup_back_plyr', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Citizen.Wait(5000)
			TaskPlayAnim(ped, 'combat@drag_ped@', 'injured_drag_plyr', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			situation.dragging = true
		end
	elseif nextSituation == "DEAD" then -- DEAD & DEAD_CUFFED
		SetEntityHealth(ped, 110)
		if situation.type == "CUFFED" then
			nextSituation = "DEAD_CUFFED"
		end
		if situation.type == "DRAGGED" or situation.type == "TRUNKED" then
			DetachEntity(ped, true, false)
			while IsEntityAttachedToAnyPed(ped) do
				DetachEntity(ped, true, false)
			end
			TaskPlayAnim(ped, 'combat@drag_ped@', 'injured_putdown_ped', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			situation.grabber = 0
			situation.vehicle = 0
		elseif situation.type == "GRABBED" then
			DetachEntity(ped, true, false)
			while IsEntityAttachedToAnyPed(ped) do
				DetachEntity(ped, true, false)
			end
			DetachEntity(ped, true, false)
			situation.grabber = 0
			nextSituation = "DEAD_CUFFED"
			TriggerServerEvent("updatePlayerDeath", true)
			TriggerServerEvent("ActionLog", "was mortally wounded.", 0)
		else
			TriggerServerEvent("updatePlayerDeath", true)
			TriggerServerEvent("ActionLog", "was mortally wounded.", 0)
		end
		changeStance("PRONE")
		SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
	elseif nextSituation == "KO" then -- KO & KO_JAIL
		if situation.type == "JAILED" then
			nextSituation = "KO_JAIL"
			SetPlayerInvincible(ped, true)
		end
		SetPedToRagdoll(ped, 10000, 10000, 0, 0, 0, 0)
		TriggerServerEvent("ActionLog", "was knocked out.", 0)
		SetEntityHealth(ped, 140)
	elseif nextSituation == "JAILED" then -- JAILED
		SetPedComponentVariation(ped, 7, 0, 0, 0)
		SetCurrentPedWeapon(ped, 0xA2719263, true)
		SetEnableHandcuffs(ped, false)
	elseif nextSituation == "DOWNED" then -- DOWNED
		SetPedToRagdoll(ped, 10000, 10000, 0, 0, 0, 0)
		local coord = GetEntityCoords(ped, true)
		local head = GetEntityHeading(ped)
		Citizen.Wait(2000)
		RequestAnimDict('move_injured_ground') while not HasAnimDictLoaded('move_injured_ground') do Citizen.Wait(0) end
		NetworkResurrectLocalPlayer(coord.x, coord.y, coord.z, head, true, false)
		changeStance("PRONE")
		ClearPedTasksImmediately(ped)
		TaskPlayAnim(ped, "move_injured_ground", "front_loop", 8.0, -4.0, -1, 2, 0.0, false, false, false)
		SetEntityHealth(ped, 115)
		TriggerServerEvent("ActionLog", "was downed.", 0)
		ClearPedTasks(ped)
		SetPlayerInvincible(ped, false)
	elseif nextSituation == "TRUNKED" then
		if situation.vehicle ~= 0 then
			ClearPedTasks(ped)
			RequestAnimDict('mp_dispose_of_veh') while not HasAnimDictLoaded('mp_dispose_of_veh') do Citizen.Wait(0) end
			TaskPlayAnim(ped, 'mp_dispose_of_veh', 'dead_ped_idle', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			AttachEntityToEntity(ped, situation.vehicle, GetEntityBoneIndexByName(situation.vehicle, "chassis"), 0.0, -1.92, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
			TaskPlayAnim(ped, 'mp_dispose_of_veh', 'dead_ped_idle', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
		end
	end
	situation.type = nextSituation
	ClearPedTasks(ped)
end


	-----------------------------------------
	---- RESTRICTION AND CHECK FUNCTIONS ----
	-----------------------------------------

function restrictSituationPed()
	local myPed = GetPlayerPed(-1)
	DisablePlayerFiring(myPed, true)
	DisableControlAction(0, 23, 1)
	DisableControlAction(0, 37, 1)
	DisableControlAction(0, 45, 1)
	DisableControlAction(0, 50, 1)
	if IsPedInAnyVehicle(myPed, false) then
		DisableControlAction(0, 23, 1)
		DisableControlAction(0, 77, 1)
		DisableControlAction(0, 78, 1)
	end
	if situation.type == "CUFFED" or situation.type == "GRABBED" then
		HideHudAndRadarThisFrame()
		DisableControlAction(0, 21, 1)
		DisableControlAction(2, 22, 1)
		DisableControlAction(0, 24, 1)
		DisableControlAction(0, 25, 1)
		DisableControlAction(0, 36, 1)
		DisableControlAction(0, 44, 1)
		DisableControlAction(0, 140, 1)
		DisableControlAction(0, 141, 1)
		DisableControlAction(0, 142, 1)
		if IsPedInAnyVehicle(myPed, false) then
			DisableControlAction(0, 71, 1)
			DisableControlAction(0, 72, 1)
			DisableControlAction(2, 75, 1)
		end
		if not HasPedGotWeapon(myPed, GetHashKey("WEAPON_HANDCUFFS"), false) then
			GiveWeaponToPed(myPed, GetHashKey("WEAPON_HANDCUFFS"), 1, false, true)
		end
		SetCurrentPedWeapon(myPed, GetHashKey("WEAPON_HANDCUFFS"), true)
		if not IsEntityPlayingAnim(myPed, 'mp_arresting', 'idle', 3) then
			TaskPlayAnim(myPed, 'mp_arresting', 'idle', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
		end
	elseif situation.type == "DEAD" or situation.type == "DEAD_CUFFED" then
		SetEntityInvincible(myPed, false)
		if myPlayer.cpr == false then
			SetPedToRagdoll(myPed, 2000, 2000, 0, 0, 0, 0)
		end
	elseif situation.type == "KO" or situation.type == "KO_JAIL" then
		if situation.type == "KO_JAIL" then
			SetEntityInvincible(myPed, true)
		end
		SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
		ResetPedRagdollTimer(myPed)
	elseif situation.type == "DRAGGED" then
		SetEntityInvincible(myPed, true)
		SetEntityHealth(myPed, 110)
	elseif situation.type == "JAILED" then
		HideHudAndRadarThisFrame()
		DisableControlAction(0, 36, 1)
		DisableControlAction(0, 44, 1)
		DisableControlAction(0, 50, 1)
		--DisableControlAction(0, 140, 1)
		--DisableControlAction(0, 141, 1)
		--DisableControlAction(0, 142, 1)
		DisableControlAction(0, 245, 1)
		if heistCooldown.prisonStatus == 'open' then
			ShowNotification("Prison Break: Press ~y~CTRL+SPACE ~w~to escape!")
			if IsControlPressed(0, 36) or IsDisabledControlPressed(0, 36) then -- CTRL
				if IsControlJustPressed(1, 22) or IsDisabledControlJustPressed(1, 22) then -- SPACE
					TriggerServerEvent("Prison:BreakOut")
				end
			end
		end
	end
end

function restrictStancePed()
	local myPed = GetPlayerPed(-1)
	DisablePlayerFiring(myPed, true)
	DisableControlAction(0, 23, 1)
	DisableControlAction(0, 24, 1)
	DisableControlAction(0, 25, 1)
	DisableControlAction(0, 37, 1)
	DisableControlAction(0, 45, 1)
	DisableControlAction(0, 50, 1)
	if IsDisabledControlJustPressed(0, 37) then
		SetCurrentPedWeapon(myPed, 0xA2719263, true)
	end
	if IsPedInAnyVehicle(myPed, false) then
		DisableControlAction(0, 34, 1)
		DisableControlAction(0, 35, 1)
		DisableControlAction(0, 59, 1)
		DisableControlAction(0, 63, 1)
		DisableControlAction(0, 64, 1)
		DisableControlAction(0, 77, 1)
		DisableControlAction(0, 78, 1)
		DisableControlAction(27, 278, 1)
		DisableControlAction(27, 279, 1)
	end
	if stance.type == "HANDSUP" then
		if not IsEntityPlayingAnim(myPed, 'ped', 'handsup_base', 3) then
			TaskPlayAnim(myPed, 'ped', 'handsup_base', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
		end
	elseif stance.type == "KNEEL_HANDSUP" then
		if IsDisabledControlJustPressed(0, 21) then
			changeStance("STANDING")
		end
	end
end

function checkDraggingMovement()
	local ped = GetPlayerPed(-1)
	DisableControlAction(0, 24, 1)
	DisableControlAction(0, 25, 1)
	DisableControlAction(0, 37, 1)
	if IsControlPressed(0, 34) or IsDisabledControlPressed(0, 34) then
		SetEntityHeading(ped, GetEntityHeading(ped)+2.0)
		checkHeadingSync()
	elseif IsControlPressed(0, 35) or IsDisabledControlPressed(0, 35) then
		SetEntityHeading(ped, GetEntityHeading(ped)-2.0)
		checkHeadingSync()
	end
	if IsControlPressed(0, 33) then
		if situation.dragging then
			TaskPlayAnim(ped, 'combat@drag_ped@', 'injured_drag_plyr', 8.0, -4.0, -1, 2, 0.0, false, false, false)
			situation.dragging = false
		end
	elseif IsControlJustReleased(0, 33) then
		TaskPlayAnim(ped, 'combat@drag_ped@', 'injured_drag_plyr', 4.0, -4.0, -1, 2, 0.0, false, false, false)
		situation.dragging = true
	end
end

function checkDownedMovement()
	local myPed = GetPlayerPed(-1)
	DisableControlAction(0, 24, 1)
	DisableControlAction(0, 25, 1)
	DisableControlAction(0, 37, 1)
	if IsControlPressed(0, 34) or IsDisabledControlPressed(0, 34) then
		SetEntityHeading(myPed, GetEntityHeading(myPed)+1.0)
		--checkHeadingSync()
	elseif IsControlPressed(0, 35) or IsDisabledControlPressed(0, 35) then
		SetEntityHeading(myPed, GetEntityHeading(myPed)-1.0)
		--checkHeadingSync()
	end
	if IsControlPressed(0, 32) then
		if stance.laying then
			TaskPlayAnim(myPed, "move_injured_ground", "front_loop", 8.0, -4.0, -1, 2, 0.0, false, false, false)
			stance.laying = false
		end
	elseif IsControlJustReleased(0, 32) then
		--TaskPlayAnim(myPed, "move_injured_ground", "front_loop", 4.0, -4.0, -1, 2, 0.0, false, false, false)
		stance.laying = true
	end
end

function checkProneMovement()
	local myPed = GetPlayerPed(-1)
	DisableControlAction(0, 24, 1)
	DisableControlAction(0, 25, 1)
	DisableControlAction(0, 37, 1)
	if IsControlPressed(0, 34) or IsDisabledControlPressed(0, 34) then
		SetEntityHeading(myPed, GetEntityHeading(myPed)+1.4)
		--checkHeadingSync()
	elseif IsControlPressed(0, 35) or IsDisabledControlPressed(0, 35) then
		SetEntityHeading(myPed, GetEntityHeading(myPed)-1.4)
		--checkHeadingSync()
	end
	if IsControlPressed(0, 32) then
		if stance.laying then
			TaskPlayAnim(myPed, "move_crawl", "onfront_fwd", 8.0, -4.0, -1, 2, 0.0, false, false, false)
			stance.laying = false
		end
	elseif IsControlPressed(0, 33) then
		if stance.laying then
			TaskPlayAnim(myPed, "move_crawl", "onfront_bwd", 8.0, -4.0, -1, 2, 0.0, false, false, false)
			stance.laying = false
		end
	elseif IsControlJustReleased(0, 32) then
		--TaskPlayAnim(myPed, "move_crawl", "onfront_fwd", 4.0, -4.0, -1, 2, 0.0, false, false, false)
		stance.laying = true
	elseif IsControlJustReleased(0, 33) then
		--TaskPlayAnim(myPed, "move_crawl", "onfront_bwd", 4.0, -4.0, -1, 2, 0.0, false, false, false)
		stance.laying = true
	end
end

function checkHeadingSync()
	local myHeading = GetEntityHeading(ped)
	if lastHeading == 0.0 then
		lastHeading = myHeading
	elseif myHeading < lastHeading-5.0 or myHeading > lastHeading+5.0 then
		TriggerServerEvent("Stance:UpdateHeading", myHeading)
		lastHeading = myHeading
	end
end


-- Weapons shown on back (Not used yet)
function checkWeapons()
	local ped = GetPlayerPed(-1)
	local rifleHash = GetHashKey("weapon_carbinerifle")
	local modelHash = GetHashKey("w_ar_carbinerifle")
	if HasPedGotWeapon(ped, rifleHash, false) then
		if IsPedArmed(ped, 6) then
			if GetCurrentPedWeapon(ped, rifleHash, 1) then
				if weaponOnBack ~= 0 then
					Citizen.Trace("Weapon removed")
					DetachEntity(weaponOnBack, true, false)
					DeleteEntity(weaponOnBack)
					while DoesEntityExist(weaponOnBack) do
						DetachEntity(weaponOnBack, true, false)
						DeleteEntity(weaponOnBack)
					end
					weaponOnBack = 0
				end
			else
				if weaponOnBack == 0 then
					Citizen.Trace("Weapon on back")
					RequestModel(modelHash)
					while not HasModelLoaded(modelHash) do
						Citizen.Wait(0)
					end
					local myCoords = GetEntityCoords(ped)
					weaponOnBack = CreateObject(modelHash, myCoords.x, myCoords.y, myCoords.z-1.0, true, false, true)
					while not DoesEntityExist(weaponOnBack) do
						Citizen.Wait(0)
					end
					--AttachEntityToEntity(weaponOnBack, ped, GetEntityBoneIndexByName(ped, "SKEL_Spine2"), 0.075, yVal, zVal, 0.0, 125.0, 0.0, false, false, true, false, 0, true)
					local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_Spine2")
					AttachEntityToEntityPhysically(weaponOnBack, ped, boneIndex, boneIndex, 0.075, yVal, zVal, 0.0, 0.0, 0.0, 0.0, 125.0, 0.0, 1000.0, true, 1, true, false, 2)
				end
			end
		else
			if weaponOnBack == 0 then
				Citizen.Trace("Weapon on back")
				RequestModel(modelHash)
				while not HasModelLoaded(modelHash) do
					Citizen.Wait(0)
				end
				local myCoords = GetEntityCoords(ped)
				weaponOnBack = CreateObject(modelHash, myCoords.x, myCoords.y, myCoords.z-1.0, true, false, true)
				while not DoesEntityExist(weaponOnBack) do
					Citizen.Wait(0)
				end
				--AttachEntityToEntity(weaponOnBack, ped, GetEntityBoneIndexByName(ped, "SKEL_Spine2"), 0.075, yVal, zVal, 0.0, 125.0, 0.0, false, false, true, false, 0, true)
				local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_Spine2")
				AttachEntityToEntityPhysically(weaponOnBack, ped, boneIndex, boneIndex, 0.075, yVal, zVal, 0.0, 0.0, 0.0, 0.0, 125.0, 0.0, 1000.0, true, 1, true, false, 2)
			end
		end
	end
	drawTxt(0.7, 0.84, 0.0, 0.0, 0.35, "yVal: " .. yVal,255,255,255,255)
	drawTxt(0.7, 0.87, 0.0, 0.0, 0.35, "zVal: " .. zVal,255,255,255,255)

	if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
		zVal = zVal + 0.05
	elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
		zVal = zVal - 0.05
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
		yVal = yVal - 0.05
	elseif IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 190) then -- right
		yVal = yVal + 0.05
	end
end
