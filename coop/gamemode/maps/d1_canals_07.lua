print(1)

AddSpawn(Vector(8109.2607421875, 8445.7880859375, -501.77416992188))
AddSpawn(Vector(8154.9384765625, 8218.9990234375, -511.96871948242))
AddSpawn(Vector(8083.8583984375, 7893.2700195313, -504.91790771484))
AddSpawn(Vector(8315.1162109375, 8047.9755859375, -506.12213134766))
AddSpawn(Vector(8298.0732421875, 8351.6044921875, -511.54846191406))

AddSpawn(Vector(11295.184570313, 2212.3364257813, -255.96875), 1)
AddSpawn(Vector(11296.606445313, 2141.0283203125, -255.96875), 1)
AddSpawn(Vector(11482.275390625, 2155.5285644531, -255.96875), 1)
AddSpawn(Vector(11619.4609375, 2186.6809082031, -255.96875), 1)
AddSpawn(Vector(11752.340820313, 2188.6716308594, -255.96875), 1)

AddCheckPoint(Vector(11255.05078125, 2111.1801757813, -255.96875), Vector(11200.595703125, 2048.7038574219, -128.03125), 1)

if SERVER then
	AddTriggerEvent("ibeam_break_relay","OnTrigger", "waypoint_ibeam,Disable,,0,-1")

	hook.Add("InitPostEntity", "custom_map", function()
		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "11226.66 2083.60 -255.96")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("waypoint_1")
		obj1:Fire("Enable")

		obj_valve = ents.Create("info_waypoint")
		obj_valve:SetKeyValue("origin",  "6872.76 1280.81 -97.88")
		obj_valve:SetKeyValue("image", "2")
		obj_valve:SetKeyValue("text", "Destroy Support")
		obj_valve:SetName("waypoint_ibeam")

		obj2 = ents.Create("info_waypoint")
		obj2:SetKeyValue("origin",  "-6171.32 -4185.60 -994.64")
		obj2:SetKeyValue("image", "4")
		obj2:SetKeyValue("text", "Checkpoint 2")
		obj2:SetName("waypoint_2")
	end)	

	hook.Add("OnCheckPointReached", "custom_map", function(ply)
		if CURRENT_CHECKPOINT == 1 then
			obj1:Fire("Disable")
			obj_valve:Fire("Enable")
			obj2:Fire("Enable")
		end
	end)
end