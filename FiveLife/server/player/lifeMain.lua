--[[ ====================================================================================================================================

													Copyright © 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means, 
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator. 

]]-- ====================================================================================================================================

RegisterServerEvent("lockVehicleDoors")
AddEventHandler("lockVehicleDoors", function(vehicle, flag)
	TriggerClientEvent("vehicleDoorLock", -1, vehicle, flag)
end)

RegisterServerEvent("giveKeys")
AddEventHandler("giveKeys", function(id, keyChain)
	TriggerClientEvent("addAllKeys", id, keyChain)
end)