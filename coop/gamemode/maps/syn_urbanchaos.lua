if SERVER then
	resource.AddWorkshop(237555347)
end

AddSpawn(Vector(-196.999084, -363.236694, -319.968750))
AddSpawn(Vector(-9.639305, -339.289001, -319.968750))
AddSpawn(Vector(186.934174, -361.876556, -319.968750))
AddSpawn(Vector(407.477570, -198.854294, -313.560364))
AddSpawn(Vector(200.931000, -175.120682, -319.968750))
AddSpawn(Vector(13.298714, -153.560471, -319.968750))

AddSpawn(Vector( 5072.645996, -858.426819, -111.968750), 1)
AddSpawn(Vector( 5148.554199, -851.537048, -111.968750), 1)
AddSpawn(Vector( 5153.560059, -924.513428, -111.968735), 1)
AddSpawn(Vector( 5079.989258, -928.357422, -111.968735), 1)

AddSpawn(Vector(6005.166992, -1059.036377, -15.968758), 2)
AddSpawn(Vector(6001.862793, -1104.409424, -15.968750), 2)
AddSpawn(Vector(5937.988281, -1056.348511, -15.968750), 2)
AddSpawn(Vector(5854.354980, -1050.293579, -15.968742), 2)
AddSpawn(Vector(5867.053711, -989.424255, -15.968750), 2)

AddCheckPoint(Vector(5024.530273, -800.373169, -111.968750), Vector(5215.652344, -991.968750, 15.621668), 1)
AddCheckPoint(Vector(5983.968750, -976.976990, -32.984695), Vector(5776.031250, -1151.031128, -159.908432), 2)

local healthlevel = {
	[1] = {1000, "It is almost faling! Few more rockets will do the job!"},
	[2] = {2000, "I can see it's malfunctioning! Keep shooting!"},
	[3] = {3000, "That's right! We're getting the result!"},
	[4] = {4000, "Helicopter is damaged! Let's feed more rockets!"},
}

hook.Add("Think", "custom_checkpoint", function()
	if SERVER then
		for k, v in ipairs(ents.FindByClass("npc_helicopter")) do
			if !v.init then
				v:Fire("SetHealth", 5000)
				v:Fire("MissileOn", 1)
				v:Fire("StartNormalShooting", 1)

				v.init = true
				v.healthlevel = 5
			end

			for level, dat in ipairs(healthlevel) do
				if v.healthlevel > level and v:Health() < dat[1] then
					v.healthlevel = level

					for k, v in ipairs(player.GetAll()) do
						SendObjective(v, dat[2], 5)
					end
				end
			end
		end
	end
end)