AddSpawn(Vector(702.88897705078, 2787.5856933594, -95.96875))
AddSpawn(Vector(603.10961914063, 2838.4699707031, -95.96875))
AddSpawn(Vector(489.03057861328, 2876.9436035156, -95.96875))
AddSpawn(Vector(770.43725585938, 2980.5473632813, -95.96875))
AddSpawn(Vector(761.50891113281, 3121.9252929688, -95.96875))

AddSpawn(Vector(163.8740234375, 6393.8686523438, -54.575016021729), 1)
AddSpawn(Vector(112.86361694336, 6288.8076171875, -64.424415588379), 1)
AddSpawn(Vector(9.6713256835938, 6230.4306640625, -69.897163391113), 1)
AddSpawn(Vector(-137.95989990234, 6080.3579101563, -83.966430664063), 1)

AddSpawn(Vector(-3081.9758300781, 7876.4516601563, -15.96875), 2)
AddSpawn(Vector(-3081.9504394531, 7961.4658203125, -15.96875), 2)
AddSpawn(Vector(-2996.2507324219, 7876.9311523438, -15.96875), 2)
AddSpawn(Vector(-2986.9147949219, 7936.134765625, -15.968753814697), 2)

AddCheckPoint(Vector(-288.34210205078, 6018.6049804688, -89.75577545166), Vector(-67.898452758789, 6196.7880859375, 127.88243103027), 1)
AddCheckPoint(Vector(-2928.0915527344, 7983.2143554688, -15.96875), Vector(-3135.5717773438, 7802.3364257813, 191.96875), 2)

// Vector(-159.62776184082, 6076.0620117188, -84.369194030762)
// Vector(-3032.3215332031, 7921.5009765625, -15.96875)
// Vector(-5255.80859375, 9219.2314453125, 19.70516204834)

hook.Add("InitPostEntity", "custom_map", function()
	if SERVER then
		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "-159.62 6076.06 -54.36")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("obj_thumper")
		obj1:Fire("Enable")

		obj2 = ents.Create("info_waypoint")
		obj2:SetKeyValue("origin",  "-3032.32 7921.50 15.96")
		obj2:SetKeyValue("image", "4")
		obj2:SetKeyValue("text", "Checkpoint 2")
		obj2:SetName("obj_extract")

		obj3 = ents.Create("info_waypoint")
		obj3:SetKeyValue("origin",  "-5255.80 9219.23 49.70")
		obj3:SetKeyValue("image", "4")
		obj3:SetKeyValue("text", "Checkpoint 2")
		obj3:SetName("obj_extract")
	end
end)	

hook.Add("OnCheckPointReached", "custom_map", function(ply)
	if SERVER then
		if CURRENT_CHECKPOINT == 1 then
			obj1:Fire("Disable")
			obj2:Fire("Enable")
		else
			obj2:Fire("Disable")
			obj3:Fire("Enable")
		end
	end
end)