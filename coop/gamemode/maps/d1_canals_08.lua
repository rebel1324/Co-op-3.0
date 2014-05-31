print(1)
AddSpawn(Vector(7816.04296875, -11073.366210938, -431.33633422852))
AddSpawn(Vector(8006.16796875, -11084.575195313, -420.38815307617))
AddSpawn(Vector(8182.138671875, -11151.729492188, -426.03656005859))
AddSpawn(Vector(8138.953125, -11279.23828125, -445.94152832031))
AddSpawn(Vector(8338.216796875, -11281.41015625, -446.33602905273))
AddSpawn(Vector(8395.1982421875, -11489.653320313, -456.51702880859))

AddSpawn(Vector(-724.60412597656, -695.73291015625, -575.96875), 1)
AddSpawn(Vector(-745.42047119141, -485.95092773438, -575.96875), 1)
AddSpawn(Vector(-749.68151855469, -563.21514892578, -575.96875), 1)
AddSpawn(Vector(-823.94415283203, -544.65985107422, -575.96875), 1)
AddSpawn(Vector(-815.70379638672, -476.96725463867, -575.96875), 1)

AddCheckPoint(Vector(-520.57849121094, -17.046573638916, -575.96875), Vector(-672.30950927734, -110.32151794434, -448.03125), 1)

// Vector(-545.40106201172, -60.989234924316, -575.96875) cp1
// "tower_gate_button" "-200.28 -3622.45 -190.83"
// OnClose open towergate.

// npc_helicopter_canal_spawn "OnSpawnNPC" remove helicopter
// gun -26.8875 -3708.62 -183.335"
// gun -131.619 -3813.11 -184.335"

// npc_helicopter_canal OnDeath
// disable gun.

if SERVER then
	AddTriggerEvent("logic_chopper","OnTrigger", "waypoint_gun1,Enable,,0,-1")
	AddTriggerEvent("logic_chopper","OnTrigger", "waypoint_gun2,Enable,,0,-1")
	AddTriggerEvent("logic_chopper","OnTrigger", "hooker,Message,Destroy Helicopter to open gate.,0,-1")

	AddTriggerEvent("path_flee_rocket_end","OnPass", "waypoint_gun1,Disable,,0,-1")
	AddTriggerEvent("path_flee_rocket_end","OnPass", "waypoint_gun2,Disable,,0,-1")
	AddTriggerEvent("path_flee_rocket_end","OnPass", "tower_gate_button,Unlock,,0,-1")
	AddTriggerEvent("path_flee_rocket_end","OnPass", "hooker,Message,Victory Achieved.,0,-1")

	AddTriggerEvent("tower_gate_button","OnClose", "waypoint_gate,Disable,,0,-1")

	hook.Add("InitPostEntity", "custom_map", function()
		for k, v in ipairs(ents.FindByName("tower_gate_button")) do
			v:Fire("Lock")
		end

		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "-545.40 -60.98 -545.96")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("waypoint_1")
		obj1:Fire("Enable")

		obj_gate = ents.Create("info_waypoint")
		obj_gate:SetKeyValue("origin",  "-200.28 -3622.45 -190.83")
		obj_gate:SetKeyValue("image", "2")
		obj_gate:SetKeyValue("text", "Open Gate")
		obj_gate:SetName("waypoint_gate")

		obj_gun1 = ents.Create("info_waypoint")
		obj_gun1:SetKeyValue("origin",  "-26.8875 -3708.62 -183.335")
		obj_gun1:SetKeyValue("image", "2")
		obj_gun1:SetKeyValue("text", "Anti-Heli Gun")
		obj_gun1:SetName("waypoint_gun1")

		obj_gun2 = ents.Create("info_waypoint")
		obj_gun2:SetKeyValue("origin",  "-131.619 -3813.11 -184.335")
		obj_gun2:SetKeyValue("image", "2")
		obj_gun2:SetKeyValue("text", "Anti-Heli Gun")
		obj_gun2:SetName("waypoint_gun2") 

		obj2 = ents.Create("info_waypoint")
		obj2:SetKeyValue("origin",  "-9016.22 8841.31 -590.34")
		obj2:SetKeyValue("image", "4")
		obj2:SetKeyValue("text", "Checkpoint 2")
		obj2:SetName("waypoint_2")
	end)	

	hook.Add("OnCheckPointReached", "custom_map", function(ply)
		if CURRENT_CHECKPOINT == 1 then
			obj1:Fire("Disable")
			obj_gate:Fire("Enable")
			obj2:Fire("Enable")
		end
	end)
end