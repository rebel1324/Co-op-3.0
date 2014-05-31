print(1)

AddSpawn(Vector(3482.4536132813, 6485.6049804688, -287.96875))
AddSpawn(Vector(3482.2209472656, 6587.1254882813, -287.96875))
AddSpawn(Vector(3483.44921875, 6661.8159179688, -287.96875))
AddSpawn(Vector(3551.1145019531, 6642.0336914063, -287.96875))

AddSpawn(Vector(4142.078125, 1989.4180908203, -474.35696411133), 1)
AddSpawn(Vector(4135.6748046875, 2052.7761230469, -475.74493408203), 1)
AddSpawn(Vector(4293.5825195313, 1954.8122558594, -462.96844482422), 1)
AddSpawn(Vector(4287.3071289063, 2076.7114257813, -471.46005249023), 1)
AddSpawn(Vector(4174.5029296875, 2130.6037597656, -474.65399169922), 1)

AddSpawn(Vector(7344.2978515625, 1531.0903320313, -447.96875), 2)
AddSpawn(Vector(7239.54296875, 1555.2244873047, -447.96875), 2)
AddSpawn(Vector(7304.0732421875, 1609.6844482422, -447.96875), 2)
AddSpawn(Vector(7007.7744140625, 1578.9156494141, -447.96875), 2)
AddSpawn(Vector(7251.82421875, 1572.3892822266, -447.96875), 2)

AddCheckPoint(Vector(4351.25, 2817.6257324219, -473.67730712891), Vector(4096.7055664063, 3199.96875, -279.74957275391), 1)

AddCheckPoint(Vector(6785.4301757813, 1280.03125, -446.75445556641), Vector(7043.337890625, 1598.8138427734, -318.64471435547), 2)

// Vector(4213.5014648438, 3087.654296875, -474.89477539063) check 1
// Vector(7220.0712890625, 1557.2252197266, -447.96875) check 2
// gate open( check 2)
// Vector(-630.533203125, -1293.5541992188, -502.23629760742) check 3

if SERVER then
	AddTriggerEvent("gate3_wheel","OnFullyClosed", "waypoint_valve,Disable,,0,-1")

	hook.Add("InitPostEntity", "custom_map", function()
		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "4213.50 3087.65 -494.89")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("waypoint_1")
		obj1:Fire("Enable")

		obj2 = ents.Create("info_waypoint")
		obj2:SetKeyValue("origin",  "7220.07 1557.22 -417.96")
		obj2:SetKeyValue("image", "4")
		obj2:SetKeyValue("text", "Checkpoint 2")
		obj2:SetName("waypoint_2")

		obj_valve = ents.Create("info_waypoint")
		obj_valve:SetKeyValue("origin",  "56.5 -1081.5 -290")
		obj_valve:SetKeyValue("image", "2")
		obj_valve:SetKeyValue("text", "Release Gate")
		obj_valve:SetName("waypoint_valve")

		obj3 = ents.Create("info_waypoint")
		obj3:SetKeyValue("origin",  "-630.53 -1293.55 -452.23")
		obj3:SetKeyValue("image", "4")
		obj3:SetKeyValue("text", "Checkpoint 3")
		obj3:SetName("waypoint_3")
	end)	

	hook.Add("OnCheckPointReached", "custom_map", function(ply)
		if CURRENT_CHECKPOINT == 1 then
			obj1:Fire("Disable")
			obj2:Fire("Enable")
		elseif CURRENT_CHECKPOINT == 2 then
			obj2:Fire("Disable")
			obj_valve:Fire("Enable")
			obj3:Fire("Enable")
		end
	end)
end