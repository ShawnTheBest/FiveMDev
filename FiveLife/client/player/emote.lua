RegisterNetEvent('printInvalidEmote')
RegisterNetEvent('printEmoteList')
RegisterNetEvent('playCOPEmote')
RegisterNetEvent('playSITEmote')
RegisterNetEvent('playCHAIREmote')
RegisterNetEvent('playKNEELEmote')
RegisterNetEvent('playMEDICEmote')
RegisterNetEvent('playNOTEPADEmote')
RegisterNetEvent('playTRAFFICEmote')
RegisterNetEvent('playPHOTOEmote')
RegisterNetEvent('playCLIPBOARDEmote')
RegisterNetEvent('playLEANEmote')
RegisterNetEvent('playBLEEZEEmote')
RegisterNetEvent('playSMOKEEmote')
RegisterNetEvent('playDRINKEmote')
RegisterNetEvent('playCOFFEEEmote')
RegisterNetEvent('playFISHEmote')
RegisterNetEvent('playSUNBATHEmote')
RegisterNetEvent('playHOOKEREmote')
RegisterNetEvent('playPUSHUPSEmote')
RegisterNetEvent('playSITUPSEmote')

currently_playing_emote = false;

playing_cop_emote = false
playing_sit_emote = false
playing_chair_emote = false
playing_kneel_emote = false
playing_medic_emote = false
playing_notepad_emote = false
playing_traffic_emote = false
playing_photo_emote = false
playing_clipboard_emote = false
playing_lean_emote = false
playing_bleeze_emote = false
playing_smoke_emote = false
playing_drink_emote = false
playing_coffee_emote = false
playing_fish_emote = false
playing_sunbath_emote = false
playing_hooker_emote = false
playing_pushups_emote = false
playing_situps_emote = false

AddEventHandler('printEmoteList', function()
	TriggerEvent('chatMessage', "", {255, 0, 0}, "^2Emote List: ^0Cop, Sit, Chair, Kneel, Medic, Notepad, Traffic, Photo, Clipboard, Lean, Smoke, Drink, Coffee, Fish, Sunbath, Hooker, Pushups, Situps")
end)

AddEventHandler('printInvalidEmote', function()
	TriggerEvent('chatMessage', "", {255, 0, 0}, "^1Invalid emote specified, use /emotes")
end)

--!!!DO NOT EDIT BELOW THIS LINE!!!

AddEventHandler('playCOPEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_cop_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, true)
			playing_cop_emote = true
			currently_playing_emote = true
		elseif playing_cop_emote == true then
			ClearPedTasks(ped)
			playing_cop_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playSITEmote', function()
	local ped = GetPlayerPed(-1)
	if IsPedInAnyVehicle(ped, false) then
		if stance.type == "STANDING" or stance.type == "CROUCH" or stance.type == "CUFFED" then
			if playing_sit_emote == false then
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PICNIC", 0, true)
				playing_sit_emote = true
				currently_playing_emote = true
			elseif playing_sit_emote == true then
				ClearPedTasks(ped)
				playing_sit_emote = false
				currently_playing_emote = false
			end
		end
	end
end)
AddEventHandler('playCHAIREmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_chair_emote == false then
			pos = GetEntityCoords(ped)
			head = GetEntityHeading(ped)
			TaskStartScenarioAtPosition(ped, "PROP_HUMAN_SEAT_CHAIR", pos['x'], pos['y'], pos['z'] - 1, head, 0, 0, 1)
			playing_chair_emote = true
			currently_playing_emote = true
		elseif playing_chair_emote == true then
			ClearPedTasks(ped)
			playing_chair_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playKNEELEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_kneel_emote == false then
			TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
			playing_kneel_emote = true
			currently_playing_emote = true
		elseif playing_kneel_emote == true then
			ClearPedTasks(ped)
			playing_kneel_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playMEDICEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_medic_emote == false then
			TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
			playing_medic_emote = true
			currently_playing_emote = true
		elseif playing_medic_emote == true then
			ClearPedTasks(ped)
			playing_medic_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playNOTEPADEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_notepad_emote == false then
			TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true)
			playing_notepad_emote = true
			currently_playing_emote = true
		elseif playing_notepad_emote == true then
			ClearPedTasks(ped)
			playing_notepad_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playTRAFFICEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_traffic_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CAR_PARK_ATTENDANT", 0, false)
			playing_traffic_emote = true
			currently_playing_emote = true
		elseif playing_traffic_emote == true then
			ClearPedTasks(ped)
			playing_traffic_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playPHOTOEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_photo_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PAPARAZZI", 0, false)
			playing_photo_emote = true
			currently_playing_emote = true
		elseif playing_photo_emote == true then
			ClearPedTasks(ped)
			playing_photo_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playCLIPBOARDEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_clipboard_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
			playing_clipboard_emote = true
			currently_playing_emote = true
		elseif playing_clipboard_emote == true then
			ClearPedTasks(ped)
			playing_clipboard_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playLEANEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_lean_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_LEANING", 0, true)
			playing_lean_emote = true
			currently_playing_emote = true
		elseif playing_lean_emote == true then
			ClearPedTasks(ped)
			playing_lean_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playBLEEZEEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_bleeze_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING_POT", 0, true)
			playing_bleeze_emote = true
			currently_playing_emote = true
		elseif playing_bleeze_emote == true then
			ClearPedTasks(ped)
			playing_bleeze_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playSMOKEEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_smoke_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_SMOKE", 0, true)
			playing_smoke_emote = true
			currently_playing_emote = true
		elseif playing_smoke_emote == true then
			ClearPedTasks(ped)
			playing_smoke_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playDRINKEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_drink_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_DRINKING", 0, true)
			playing_drink_emote = true
			currently_playing_emote = true
		elseif playing_drink_emote == true then
			ClearPedTasks(ped)
			playing_drink_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playCOFFEEEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_coffee_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_COFFEE", 0, true)
			playing_coffee_emote = true
			currently_playing_emote = true
		elseif playing_coffee_emote == true then
			ClearPedTasks(ped)
			playing_coffee_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playFISHEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_fish_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_FISHING", 0, true)
			playing_fish_emote = true
			currently_playing_emote = true
		elseif playing_fish_emote == true then
			ClearPedTasks(ped)
			playing_fish_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playSUNBATHEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_sunbath_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SUNBATHE_BACK", 0, true)
			playing_sunbath_emote = true
			currently_playing_emote = true
		elseif playing_sunbath_emote == true then
			ClearPedTasks(ped)
			playing_sunbath_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playHOOKEREmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_hooker_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", 0, true)
			playing_hooker_emote = true
			currently_playing_emote = true
		elseif playing_hooker_emote == true then
			ClearPedTasks(ped)
			playing_hooker_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playPUSHUPSEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_pushups_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PUSH_UPS", 0, true)
			playing_pushups_emote = true
			currently_playing_emote = true
		elseif playing_pushups_emote == true then
			ClearPedTasks(ped)
			playing_pushups_emote = false
			currently_playing_emote = false
		end
	end
end)

AddEventHandler('playSITUPSEmote', function()
	local ped = GetPlayerPed(-1)
	if stance.type == "STANDING" or stance.type == "CROUCH" then
		if playing_situps_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SIT_UPS", 0, true)
			playing_situps_emote = true
			currently_playing_emote = true
		elseif playing_situps_emote == true then
			ClearPedTasks(ped)
			playing_situps_emote = false
			currently_playing_emote = false
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(1, 266) or IsControlJustPressed(1, 267) or IsControlJustPressed(1, 268) or IsControlJustPressed(1, 269) then
			if currently_playing_emote then
				ClearPedTasksImmediately(GetPlayerPed(-1))
				playing_cop_emote = false
				playing_sit_emote = false
				playing_chair_emote = false
				playing_kneel_emote = false
				playing_medic_emote = false
				playing_notepad_emote = false
				playing_traffic_emote = false
				playing_photo_emote = false
				playing_clipboard_emote = false
				playing_lean_emote = false
				playing_bleeze_emote = false
				playing_smoke_emote = false
				playing_drink_emote = false
				playing_coffee_emote = false
				playing_fish_emote = false
				playing_sunbath_emote = false
				playing_hooker_emote = false
				playing_pushups_emote = false
				playing_situps_emote = false
				currently_playing_emote = false
			end
		end
	end
end)
