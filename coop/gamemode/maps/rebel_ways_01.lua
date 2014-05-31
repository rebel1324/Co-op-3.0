
if SERVER then
	AddTriggerEvent("combineshieldwall1_rot-bu", "OnPressed", "obj_lever,Disable,,2,-1")
	AddTriggerEvent("button_keypad_1_fake-bu", "OnPressed", "obj_keypad,Enable,,5,-1")
	AddTriggerEvent("button_keypad_1", "OnPressed", "obj_keypad,Disable,,0,-1")
	AddTriggerEvent("ballgenerator_text", "message", "Something is wrong with this!")
	AddTriggerEvent("ballgenerator_text_trigger", "OnStartTouch", "ballgenerator1_break,Break,,0,-1")

	hook.Add("InitPostEntity", "custom_map", function()
		obj_lever = ents.Create("info_waypoint")
		obj_lever:SetKeyValue("origin",  "511.863 790.208 -720.724")
		obj_lever:SetKeyValue("image", "4")
		obj_lever:SetKeyValue("text", "Pull Lever")
		obj_lever:SetName("obj_lever")
		obj_lever:Fire("Enable")

		obj_keypad = ents.Create("info_waypoint")
		obj_keypad:SetKeyValue("origin",  "1152 465.5 -705")
		obj_keypad:SetKeyValue("image", "4")
		obj_keypad:SetKeyValue("text", "Pull Lever")
		obj_keypad:SetName("obj_keypad")

		obj_combine = ents.Create("info_waypoint")
		obj_combine:SetKeyValue("origin",  "1782 -977 -435")
		obj_combine:SetKeyValue("image", "4")
		obj_combine:SetKeyValue("text", "Destroy")
		obj_combine:SetName("obj_combine")
	end)	
end

