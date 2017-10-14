--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

RegisterServerEvent("getFuelLevel")
AddEventHandler("getFuelLevel", function()
	TriggerClientEvent("updateFuel", source, FuelAmount)
end)

RegisterServerEvent("changeFuelLevel")
AddEventHandler("changeFuelLevel", function(amount)
	FuelAmount = FuelAmount + amount
	TriggerClientEvent("updateFuel", -1, FuelAmount)
end)
