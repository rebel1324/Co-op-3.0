if SERVER then
	AddPlayerBarrier(Vector(4320.0322265625, -2880.4924316406, -3767.96875), Vector(4200.03125, -2847.48828125, -3648.0471191406))

	hook.Add("InitPostEntity", "custom_map", function()
		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "315.60 579.65 -3280.96")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("waypoint_1")
		obj1:Fire("Enable")
	end)	
end