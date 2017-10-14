-- simple_cursor_driver_for_FiveReborn
mousedrw = 0				-- mousedrw-is_mouse_drawing 
mouseX, mouseY = 0.0,0.0	-- default_position (the_left-top_corner_of_the_screen)

function CursorInZone(zonex, zoney, zonex1, zoney1) -- made_it_bitch xD
	if mousedrw == 1 and mousex > zonex and mousex < zonex1 and mousey > zoney and mousey < zoney1 then
		return true
	elseif mousedrw == 1 and mousex_d > zonex and mousex_d < zonex1 and mousey_d > zoney and mousey_d < zoney1 then
		return true
	else
		return false
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		mouseX = GetControlNormal(2,239)
		mouseY = GetControlNormal(2,240)
		-- hotfix_for_disabled_ctrl
		mousex_d = GetDisabledControlNormal(2,239)
		mousey_d = GetDisabledControlNormal(2,240)
		-- draw_the_cursor
		--ShowCursorThisFrame()
	end
end)		