print(1)
AddSpawn(Vector(11882.328125, -11865.63671875, -540.18920898438))
AddSpawn(Vector(11893.329101563, -12089.114257813, -532.27117919922))
AddSpawn(Vector(11898.25, -12203.420898438, -526.89282226563))
AddSpawn(Vector(11895.897460938, -12364.404296875, -522.20385742188))
AddSpawn(Vector(11819.880859375, -12297.418945313, -535.34790039063))

if SERVER then
	hook.Add("InitPostEntity", "custom_map", function()
		obj1 = ents.Create("info_waypoint")
		obj1:SetKeyValue("origin",  "-13777.69 -928.50 -341.69")
		obj1:SetKeyValue("image", "4")
		obj1:SetKeyValue("text", "Checkpoint 1")
		obj1:SetName("waypoint_1")
		obj1:Fire("Enable")
	end)	
end