AddSpawn(Vector(2800.1196289063, -2263.0053710938, -639.96875))
AddSpawn(Vector(2932.4489746094, -2274.4748535156, -639.96875))
AddSpawn(Vector(3045.4975585938, -2275.236328125, -639.96875))
AddSpawn(Vector(2859.8186035156, -2139.0344238281, -639.96875))
AddSpawn(Vector(3005.8916015625, -2136.0754394531, -639.96875))

AddSpawn(Vector(-450.46054077148, -1079.1373291016, -771.33953857422) ,1)
AddSpawn(Vector(-515.20764160156, -1026.7614746094, -782.9697265625) ,1)
AddSpawn(Vector(-462.09268188477, -963.21002197266, -777.02551269531) ,1)
AddSpawn(Vector(-547.53186035156, -817.52020263672, -774.13793945313) ,1)
AddSpawn(Vector(-496.17098999023, -1004.8807373047, -782.40692138672) ,1)
AddSpawn(Vector(-534.60339355469, -949.21282958984, -779.85357666016) ,1)

AddCheckPoint(Vector(-391.54174804688, -658.30651855469, -772.06506347656), Vector(-631.34399414063, -1263.96875, -656.04357910156), 1)

//Vector(-457.32092285156, -891.60021972656, -772.05163574219) checkpoint 1
//Vector(-461.75738525391, 1605.0522460938, -831.96875) Checkpoint 2

hook.Add("InitPostEntity", "custom_map", function()
	if SERVER then
		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "-457.32 -891.60 -772.05")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("obj_thumper")
		obj1:Fire("Enable")

		obj2 = ents.Create("info_waypoint")
		obj2:SetKeyValue("origin",  "-461.75 1605.05 -831.96")
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