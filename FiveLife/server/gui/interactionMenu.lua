--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

RegisterServerEvent("getRoleplayName")
AddEventHandler("getRoleplayName", function(serverID)
	if GetPlayerIdentifiers(serverID) ~= nil then
		local steamID = GetPlayerIdentifiers(serverID)[1]
		local userID = source
		MySQL.Async.fetchScalar("SELECT rp_name FROM users WHERE identifier = @steamID", {['@steamID'] = steamID}, function(name)
			TriggerClientEvent("interact:updateName", userID, name)
		end)
	end
end)
