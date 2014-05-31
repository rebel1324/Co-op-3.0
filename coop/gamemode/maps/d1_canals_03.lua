AddSpawn(Vector(-1191.6801757813, 1601.2338867188, -831.96875))
AddSpawn(Vector(468.63626098633, 3127.2868652344, -847.96875))
AddSpawn(Vector(372.53393554688, 3239.0676269531, -847.96875))
AddSpawn(Vector(284.32330322266, 3250.4775390625, -847.96875))
AddSpawn(Vector(261.65313720703, 3358.025390625, -847.96875))

AddSpawn(Vector(-1227.3283691406, 1415.3364257813, -839.96875), 1)
AddSpawn(Vector(-1300.3970947266, 1483.4921875, -831.96875), 1)
AddSpawn(Vector(-1247.9752197266, 1549.7283935547, -829.44873046875), 1)
AddSpawn(Vector(-1160.4970703125, 1484.7192382813, -839.96875), 1)
AddSpawn(Vector(-1191.6801757813, 1601.2338867188, -831.96875), 1)

AddSpawn(Vector(-962.17828369141, 1035.669921875, -955.96875), 2)
AddSpawn(Vector(-853.06823730469, 1117.5263671875, -879.96875), 2)
AddSpawn(Vector(-902.14056396484, 1116.2347412109, -879.96875), 2)
AddSpawn(Vector(-879.46105957031, 1178.935546875, -885.35528564453), 2)
AddSpawn(Vector(-799.10845947266, 1038.3690185547, -955.96875), 2)

AddSpawn(Vector(-2554.4846191406, -941.92016601563, -1263.96875), 3)
AddSpawn(Vector(-2555.80859375, -798.35589599609, -1263.96875), 3)
AddSpawn(Vector(-2410.8161621094, -784.32250976563, -1263.96875), 3)
AddSpawn(Vector(-2383.2351074219, -929.00872802734, -1263.96875), 3)
AddSpawn(Vector(-2224.1118164063, -882.76373291016, -1263.96875), 3)

AddCheckPoint(Vector(-839.2822265625, 1399.8447265625, -831.96875), Vector(-924.11102294922, 1612.0668945313, -705.15875244141), 1)
AddCheckPoint(Vector(-1039.1396484375, 719.38427734375, -1023.96875), Vector(-771.44995117188, 986.13696289063, -828.74499511719), 2)
AddCheckPoint(Vector(-2831.96875, -1079.1065673828, -1231.1114501953), Vector(-1985.5321044922, -631.21527099609, -976.03125), 3)

// Add trigger.
// Vector(-893.48229980469, 1496.5618896484, -821.04406738281) check 1
// Vector(-882.45007324219, 1120.6958007813, -879.96875) check 2
// Vector(-2385.4775390625, -862.06066894531, -1200.96875) check 3
// Vector(-2411.7895507813, -167.26789855957, -1509.5654296875) valve( check 3 )
// Vector(-3202.8295898438, 76.922210693359, -1071.96875) next map
if SERVER then
	AddTriggerEvent("RotateSpeedWheel","OnOpen", "waypoint_valve,Disable,,0,-1")

	hook.Add("InitPostEntity", "custom_map", function()
		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "-893.48 1496.56 -821.04")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("waypoint_1")
		obj1:Fire("Enable")

		obj2 = ents.Create("info_waypoint")
		obj2:SetKeyValue("origin",  "-882.45 1120.69 -879.96")
		obj2:SetKeyValue("image", "4")
		obj2:SetKeyValue("text", "Checkpoint 2")
		obj2:SetName("waypoint_2")

		obj3 = ents.Create("info_waypoint")
		obj3:SetKeyValue("origin",  "-2385.47 -862.06 -1200.96")
		obj3:SetKeyValue("image", "4")
		obj3:SetKeyValue("text", "Checkpoint 3")
		obj3:SetName("waypoint_3")

		obj_valve = ents.Create("info_waypoint")
		obj_valve:SetKeyValue("origin",  "-2208 -47 -1427")
		obj_valve:SetKeyValue("image", "2")
		obj_valve:SetKeyValue("text", "Release Water")
		obj_valve:SetName("waypoint_valve")

		obj4 = ents.Create("info_waypoint")
		obj4:SetKeyValue("origin",  "-3202.82 76.92 -1071.96")
		obj4:SetKeyValue("image", "4")
		obj4:SetKeyValue("text", "Checkpoint 4")
		obj4:SetName("waypoint_4")
	end)	

	hook.Add("OnCheckPointReached", "custom_map", function(ply)
		if CURRENT_CHECKPOINT == 1 then
			obj1:Fire("Disable")
			obj2:Fire("Enable")
		elseif CURRENT_CHECKPOINT == 2 then
			obj2:Fire("Disable")
			obj3:Fire("Enable")
		elseif CURRENT_CHECKPOINT == 3 then
			obj3:Fire("Disable")
			obj_valve:Fire("Enable")
			obj4:Fire("Enable")
		end
	end)
end