AddSpawn(Vector(637.56072998047, -7533.7915039063, -127.96875))
AddSpawn(Vector(634.82897949219, -7658.0893554688, -127.96875))
AddSpawn(Vector(634.79132080078, -7771.8779296875, -127.96875))
AddSpawn(Vector(627.11322021484, -7919.2045898438, -127.96875))
AddSpawn(Vector(640.28112792969, -8131.9008789063, -127.96875))

AddSpawn(Vector(680.17431640625, -6578.466796875, 540.03125), 1)
AddSpawn(Vector(805.70068359375, -6579.8984375, 540.03125), 1)
AddSpawn(Vector(832.71118164063, -6419.5615234375, 540.03125), 1)
AddSpawn(Vector(683.18231201172, -6406.3374023438, 540.03125), 1)

AddSpawn(Vector(529.1328125, 2862.1201171875, -95.96875), 2)
AddSpawn(Vector(846.85589599609, 2640.4606933594, -58.060749053955), 2)
AddSpawn(Vector(629.15002441406, 2810.0546875, -95.96875), 2)

AddCheckPoint(Vector(995.96875, -6651.4604492188, 664.91857910156), Vector(624.23974609375, -6152.03125, 512.11614990234), 1)
AddCheckPoint(Vector(895.20721435547, 2677.6435546875, 69.87474822998), Vector(754.65588378906, 2591.0927734375, -50.96875), 2)

hook.Add("InitPostEntity", "custom_map", function()
	if SERVER then
		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "766.28 -6422.63 570")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("obj_thumper")
		obj1:Fire("Enable")

		obj2 = ents.Create("info_waypoint")
		obj2:SetKeyValue("origin",  "835.11 2639.27 -28.06")
		obj2:SetKeyValue("image", "4")
		obj2:SetKeyValue("text", "Checkpoint 2")
		obj2:SetName("obj_extract")
	end
end)	

hook.Add("OnCheckPointReached", "custom_map", function(ply)
	if SERVER then
		if CURRENT_CHECKPOINT == 1 then
			obj1:Fire("Disable")
			obj2:Fire("Enable")
		else
			obj2:Fire("Disable")
		end
	end
end)