if SERVER then
	AddTriggerEvent("c-button_1_button", "OnOpen", "obj_access,Disable,,2,-1")
	AddTriggerEvent("c-button_1_button", "OnOpen", "hooker,Message,Vehicle Storage access is now open.,0,-1")
	AddTriggerEvent("c-button_1_button", "OnOpen", "obj_access_2,Enable,,2,-1")

	AddTriggerEvent("c-button_2_button", "OnOpen", "obj_access_2,Disable,,2,-1")
	AddTriggerEvent("c-button_2_button", "OnOpen", "hooker,Message,Go to the side bridge.,0,-1")
	AddTriggerEvent("c-button_2_button", "OnOpen", "obj_bridge,Enable,,2,-1")

	AddTriggerEvent("train-station_gateway-door_button", "OnPressed", "obj_bridge,Disable,,2,-1")
	AddTriggerEvent("train-station_gateway-door_button", "OnPressed", "hooker,Message,Get to the Extraction Point.,0,-1")
	AddTriggerEvent("train-station_gateway-door_button", "OnPressed", "obj_extract,Enable,,2,-1")

	hook.Add("InitPostEntity", "custom_map", function()
		obj_access = ents.Create("info_waypoint")
		obj_access:SetKeyValue("origin",  "-2059.02 -1828.13 -622.24")
		obj_access:SetKeyValue("image", "4")
		obj_access:SetKeyValue("text", "Access")
		obj_access:SetName("obj_access")
		obj_access:Fire("Enable")

		obj_access_2 = ents.Create("info_waypoint")
		obj_access_2:SetKeyValue("origin",  "-1742.83 -575 -497.24")
		obj_access_2:SetKeyValue("image", "4")
		obj_access_2:SetKeyValue("text", "Access")
		obj_access_2:SetName("obj_access_2")

		obj_bridge = ents.Create("info_waypoint")
		obj_bridge:SetKeyValue("origin",  "-1023 -2139.5 -516")
		obj_bridge:SetKeyValue("image", "4")
		obj_bridge:SetKeyValue("text", "Across")
		obj_bridge:SetName("obj_bridge")

		obj_extract = ents.Create("info_waypoint")
		obj_extract:SetKeyValue("origin",  "-359.58 -920.65 -703.96")
		obj_extract:SetKeyValue("image", "4")
		obj_extract:SetKeyValue("text", "Extract")
		obj_extract:SetName("obj_extract")
	end)	
end