hook.Add("Think", "custom_checkpoint", function()
	if SERVER then
		for k, v in ipairs(ents.GetAll()) do
			if v:GetClass() == "npc_maker" then
				v:Fire("MaxLiveChildren", 2)
			end
		end
	end
end)