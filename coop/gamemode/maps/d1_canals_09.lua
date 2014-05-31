print(1)
AddSpawn(Vector(7371.474609375, 10791.4921875, -459.28479003906))
AddSpawn(Vector(7366.6240234375, 10651.77734375, -466.52969360352))
AddSpawn(Vector(7516.005859375, 10656.809570313, -486.67953491211))
AddSpawn(Vector(7556.388671875, 10777.319335938, -486.93899536133))
AddSpawn(Vector(7803.6489257813, 10657.26953125, -466.20626831055))
AddSpawn(Vector(7888.4208984375, 10927.783203125, -447.09173583984))

if SERVER then
	hook.Add("InitPostEntity", "custom_map", function()
		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "-1610.84 -7128.71 -417.85")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("waypoint_1")
		obj1:Fire("Enable")
	end)	
end