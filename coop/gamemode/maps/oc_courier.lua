--[[

OnTrigger
Checkpoint_1
Checkpoint_2
Checkpoint_3
Checkpoint_4
Checkpoint_5

]]


AddCheckPoint(
	Vector(-421.93707275391, -240.7080078125, -1.5306854248047), 
	Vector(-679.28930664063, -759.17047119141, 392.94793701172),
	Vector(-528.75408935547, -494.88812255859, 3.4347305297852)
)
AddCheckPoint(
	Vector(5769.2006835938, 11076.9453125, 14.505626678467), 
	Vector(5137.0180664063, 10434.857421875, 204.97534179688),
	Vector(5502.55078125, 10790.354492188, 8.03125)
)
AddCheckPoint(
	Vector(10352.51171875, 6023.796875, 16.03125),
	Vector(10113.413085938, 6350.8818359375, 207.96875),
	Vector(10230.2109375, 6221.3520507813, 16.03125)
)
AddCheckPoint(
	Vector(12088.356445313, 1536.03125, -1673.3386230469),
	Vector(11625.71484375, 2223.96875, -1482.9428710938),
	Vector(11818.58203125, 1878.7515869141, -1673.96875)
)

if (SERVER) then
	MAPCHECKPOINTS = MAPCHECKPOINTS or {
		["PlayerSpawnGroup_1"] = {},
		["PlayerSpawnGroup_2"] = {},
		["PlayerSpawnGroup_3"] = {},
		["PlayerSpawnGroup_4"] = {},
		["PlayerSpawnGroup_5"] = {},	
	}
	CHECKRELAYS = {
		["Checkpoint_1"] = {},
		["Checkpoint_2"] = {},
		["Checkpoint_3"] = {},
		["Checkpoint_4"] = {},
		["Checkpoint_5"] = {},
	}
	CURRENT_CHECKPOINT = "PlayerSpawnGroup_5"

	hook.Add("InitPostEntity", "oc_courier", function(player)
		for k, v in ipairs(ents.GetAll()) do
			if (CHECKRELAYS[v:GetName()]) then
				if (v and v:IsValid()) then
					table.insert(CHECKRELAYS[v:GetName()], v)
				end
			end

			if (MAPCHECKPOINTS[v:GetName()]) then
				if (v and v:IsValid()) then
					table.insert(MAPCHECKPOINTS[v:GetName()], v)
				end
			end
		end

		for dd, ents in pairs(CHECKRELAYS) do
			for k, v in ipairs(ents) do
				AddTriggerEvent("antlion_attack_wave_9", "OnTrigger", "hooker,Checkpoint," .. dd .. ",0,-1")
			end
		end
	end)

	hook.Add("OnEntityTriggered", "custom_map", function(inputName, activator, data)
		print(inputName, activator, data)
	end)

	hook.Add("MapSpawnPoint", "oc_courier", function(player)
		local point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
		while (!point:IsValid()) do
			point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
		end

		return point
	end)
end