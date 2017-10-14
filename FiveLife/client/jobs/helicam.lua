-- FiveM Heli Cam by mraes
-- Version 1.2 2017-06-08

-- config
local fov_max = 80.0
local fov_min = 10.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 2.0 -- camera zoom speed
local speed_lr = 3.0 -- speed by which the camera pans left-right 
local speed_ud = 3.0 -- speed by which the camera pans up-down
local toggle_control = 137 -- control id of the button by which to toggle the helicam mode. Default: INPUT_CONTEXT,51 is the E key
local toggle_vision = 21 -- control id to toggle vision mode (default key is arrow down)
local toggle_light = 22 -- control id to toggle searchlight

-- Script starts here
local helicam = false
local polmav_hash = GetHashKey("polmav")
local huey_hash = GetHashKey("statehuey")
local lspd_heli = GetHashKey("lspdheli")
local fov = (fov_max+fov_min)*0.5
local vision_state = 0 -- 0 is normal, 1 is nightmode, 2 is thermal vision
local searchlight = false
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
		if IsControlJustPressed(0, toggle_control) and IsVehicleHeliAndHighEnough(GetVehiclePedIsIn(GetPlayerPed(-1))) then 
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
			helicam = true
		end
			
		if helicam then
			local scaleform = RequestScaleformMovie("HELI_CAM")
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(0)
			end
			local lPed = GetPlayerPed(-1)
			local heli = GetVehiclePedIsIn(lPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", 2)
			AttachCamToEntity(cam, heli, 0.0,0.0,-1.5, true)
			SetCamRot(cam, 0.0,0.0,GetEntityHeading(heli))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
			PopScaleformMovieFunctionVoid()

			while helicam and not IsEntityDead(lPed) and IsVehicleHeliAndHighEnough(heli) do
				if IsControlJustPressed(0, toggle_control) then
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					break
				end
				if IsControlJustPressed(0, toggle_vision) then
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ChangeVision()
				end
				if IsControlJustPressed(0, toggle_light) then
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ToggleSearchlight()
				end
				CheckSearchLight(lPed, cam)
				CheckInputRotation(cam)
				HandleZoom(cam)
				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				HideHUDThisFrame()
				PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
				PushScaleformMovieFunctionParameterFloat(GetEntityCoords(heli).z)
				PushScaleformMovieFunctionParameterFloat(zoomvalue)
				PushScaleformMovieFunctionParameterFloat(GetCamRot(cam, 2).z)
				PopScaleformMovieFunctionVoid()
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(0)
			end
			helicam = false
			fov = (fov_max+fov_min)*0.5 -- reset to starting zoom level
			RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
			SetScaleformMovieAsNoLongerNeeded(scaleform) -- Cleanly release the scaleform
			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		end
	end
end)

RegisterNetEvent('heli:searchlight')
AddEventHandler('heli:searchlight', function(serverID, state)
	local heli = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
	SetVehicleSearchlight(heli, state, false)
end)

function IsVehicleHeliAndHighEnough(vehicle)
	local height = GetEntityHeightAboveGround(vehicle)
	if IsVehicleModel(vehicle, polmav_hash) or IsVehicleModel(vehicle, huey_hash) or IsVehicleModel(vehicle, lspd_heli) then
		if height > 1.5 then
			return true
		end
	end
	return false
end

function ChangeVision()
	if vision_state == 0 then
		SetNightvision(true)
		vision_state = 1
	elseif vision_state == 1 then
		SetNightvision(false)
		SetSeethrough(true)
		vision_state = 2
	else
		SetSeethrough(false)
		vision_state = 0
	end
end

function ToggleSearchlight()
	searchlight = not searchlight
	TriggerServerEvent("heli:toggleSearchlight", searchlight)
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(19) -- weapon wheel
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
end

function CheckSearchLight(ped, cam)
	if searchlight then
		local coords = GetCamCoord(cam)
		local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
		local spotpoint = coords+(forward_vector*50.0)
		DrawLine(coords, coords+(forward_vector*100.0), 255,0,0,255) -- debug line to show LOS of cam
		SetMountedWeaponTarget(ped, 0, 0, spotpoint.x, spotpoint.y, spotpoint.z)
	end
end

function CheckInputRotation(cam)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) then -- Scrollup
		fov = math.max(fov - zoomspeed, fov_min)
	end
	if IsControlJustPressed(0,242) then
		fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
		fov = current_fov
	end
	SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end