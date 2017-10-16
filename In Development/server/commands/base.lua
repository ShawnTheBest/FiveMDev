--[[ ====================================================================================================================================

													Copyright � 2017 GTAV-LIFE (Adam Masson)
													This file is part of project GTAV-Life.
		All rights reserved. No part of this material may be reproduced, distributed, or transmitted in any form or by any means,
			including copying, or other electronic or mechanical methods, without the prior written permission of the creator.

]]-- ====================================================================================================================================

	----- GENERAL COMMANDS -----
commands["HIDECHAT"] = {perm = 0, help = "/hidechat", args = {"nil"}}
commands["SHOWCHAT"] = {perm = 0, help = "/showchat", args = {"nil"}}

	----- ADMINISTRATOR COMMANDS -----
commands["CLEARCHAT"] = {perm = 2, help = "/clearchat", args = {"nil"}}
	--------------- GENERAL COMMANDS ---------------

RegisterServerEvent('FiveLife:Command-CHAT-HIDE')
AddEventHandler('FiveLife:Command-CHAT-HIDE', function(sender, args)
	TriggerClientEvent("chat:hide", sender)
end)

RegisterServerEvent('FiveLife:Command-CHAT-SHOW')
AddEventHandler('FiveLife:Command-CHAT-SHOW', function(sender, args)
	TriggerClientEvent("chat:show", sender)
end)

	--------------- ADMINISTRATOR COMMANDS ---------------
RegisterServerEvent('FiveLife:Command-CLEARCHAT')
AddEventHandler('FiveLife:Command-CLEARCHAT', function(sender)
	logCommand(GetPlayerName(sender) .. " has cleared the chat.", 0)
	TriggerClientEvent('chat:clear', -1)
	TriggerClientEvent('chatMessage', -1, "["..sender.."]", {255, 0, 0}, "cleared chat!")
end)