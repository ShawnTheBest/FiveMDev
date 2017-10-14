
OnCmd:register( "emote", function( source, args )
	if args[1] ~= nil then
		local emote = args[1]
		if emote == "cop" then
			TriggerClientEvent('playCopEmote', source)
		elseif emote == "sit" then
			TriggerClientEvent('playSitEmote', source)
		elseif emote == "chair" then
			TriggerClientEvent('playChairEmote', source)
		elseif emote == "kneel" then
			TriggerClientEvent('playKneelEmote', source)
		elseif emote == "medic" then
			TriggerClientEvent('playMedicEmote', source)
		elseif emote == "notepad" then
			TriggerClientEvent('playNotepadEmote', source)
		elseif emote == "traffic" then
			TriggerClientEvent('playTrafficEmote', source)
		elseif emote == "photo" then
			TriggerClientEvent('playPhotoEmote', source)
		elseif emote == "clipboard" then
			TriggerClientEvent('playClipboardEmote', source)
		elseif emote == "lean" then
			TriggerClientEvent('playLeanEmote', source)
		elseif emote == "bleeze" then
			TriggerClientEvent('playBleezeEmote', source)
		elseif emote == "smoke" then
			TriggerClientEvent('playSmokeEmote', source)
		elseif emote == "drink" then
			TriggerClientEvent('playDrinkEmote', source)
		elseif emote == "coffee" then
			TriggerClientEvent('playCoffeeEmote', source)
		else
			TriggerClientEvent('printInvalidEmote', source)
		end
	else
		TriggerClientEvent('printEmoteList', source)
	end
end)

OnCmd:register( "emotes", function( source, args )
	TriggerClientEvent('printEmoteList', source)
end)
