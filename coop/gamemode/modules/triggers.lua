local additionalTriggers = {}
function AddTriggerEvent(name, input, data)
	if name and input and data then
		additionalTriggers[name] = additionalTriggers[name] or {}
		table.insert(additionalTriggers[name], {input, data})
	end
end

hook.Add("OnEntityTriggered", "custom_map", function(inputName, activator, data)
	if inputName == "Message" then
		for k, v in ipairs(player.GetAll()) do
			for k, v in ipairs(player.GetAll()) do
				SendObjective(v, data, 5)
			end
		end
	end
end)

hook.Add("InitPostEntity", "triggers", function()
	local ent = ents.Create("game_hooker")
	ent:SetName("hooker")

	for k, v in pairs(ents.GetAll()) do
		if v:IsNPC() and v:GetName() != "" then
			print(v, v:GetName())
		end
		if v:GetName() and v:GetName() != "" and additionalTriggers[v:GetName()] then
			for _, ipt in ipairs(additionalTriggers[v:GetName()]) do
				v:SetKeyValue(ipt[1], ipt[2])
			end
		end
	end
end)
