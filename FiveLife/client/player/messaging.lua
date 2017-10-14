--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

local gmPlayerJoined = 0
local second = 60000
local minute = 5

AddEventHandler('playerSpawned', function(spawn)
	Citizen.CreateThread(function()
		Citizen.Wait(500)
		TriggerServerEvent("onPlayerConnect")
	end)

	if gmPlayerJoined == 0 then
		ShowNotification('Welcome to ~b~FIVE Life~w~, enjoy your stay!')
		gmPlayerJoined = 1
	end
end)
