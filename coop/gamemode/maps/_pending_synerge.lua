if SERVER then
	resource.AddWorkshop(237555347)
end

SPAWNPOINTS = {
	Vector(-394.128265, 905.061646, 64.03125),
	Vector(-394.603699, 747.083862, 64.03125),
	Vector(-392.920532, 534.978699, 64.03125),
	Vector(-392.175720, 441.094147, 64.03125),
	Vector(-391.090454, 304.338135, 64.03125),
	Vector(-390.348358, 210.816605, 64.03125),
	Vector(-389.514648, 105.746735, 64.03125),
	Vector(-388.825409, 18.883591, 64.031250),
}

CURRENT_CHECKPOINT = CURRENT_CHECKPOINT or 0

CHECKPOINT_SPAWN = {}
CHECKPOINT_SPAWN[1] = {
	Vector(306.419189, 735.828918, 448.031250),
	Vector(406.334747, 738.114075, 448.031250),
	Vector(427.174500, 606.040955, 448.031250),
	Vector(287.679047, 603.846985, 448.031250),
	Vector(355.079895, 670.087158, 448.031250),
}

CHECKPOINTS = {}

local vec1, vec2 = absminmax( Vector(249.289230, 795.250916, 448.031250), Vector(471.296173, 548.031250, 575.327454) )
CHECKPOINTS[1] = { vec1, vec2 }

hook.Add("InitPostEntity", "custom_map", function()
	for k, v in ipairs(ents.GetAll()) do
		if v:GetName() and v:GetName() ~= "" then
			print(v)
		end
	end
end)

hook.Add("Think", "custom_checkpoint", function()
	for k, v in ipairs(player.GetAll()) do
		for check, vecs in ipairs(CHECKPOINTS) do
			local ppos = v:GetPos() + v:OBBCenter()
			if ppos:WithinAABox(vecs[1], vecs[2]) then
				if check > CURRENT_CHECKPOINT then
					CURRENT_CHECKPOINT = check

					if SERVER then
						for k, v in ipairs(player.GetAll()) do
							SendObjective(v, "Checkpoint #" .. CURRENT_CHECKPOINT .. " reached.", 5)
						end
					end
				end
			end
		end
	end
end)

hook.Add("PlayerSpawn", "custom_spawn", function(ply)
	if CURRENT_CHECKPOINT > 0 then
		ply:SetPos(table.Random(CHECKPOINT_SPAWN[CURRENT_CHECKPOINT]))
	else
		ply:SetPos(table.Random(SPAWNPOINTS))
	end
end)
