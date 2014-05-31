if SERVER then
	hook.Add("InitPostEntity", "custom_map", function()
		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "-1354.42 -3058.68 -510.94")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("waypoint_1")
		obj1:Fire("Enable")
	end)	
end