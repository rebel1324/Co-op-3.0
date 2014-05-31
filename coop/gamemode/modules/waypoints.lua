SPAWNPOINTS = SPAWNPOINTS or {}
CHECKPOINTS = CHECKPOINTS or {}
CURRENT_CHECKPOINT = CURRENT_CHECKPOINT or 0

function AddSpawn(pos, index)
	if !pos then return end
	index = index or 0

	SPAWNPOINTS[index] = SPAWNPOINTS[index] or {}
	table.insert(SPAWNPOINTS[index], pos)
end

function AddCheckPoint(vec1, vec2, index)
	if vec1 and vec2 and index then
		local v1, v2 = absminmax(vec1, vec2)
		CHECKPOINTS[index] = {v1, v2}
	end
end


hook.Add("PlayerSpawn", "waypoint.spawn", function(ply)
	if SPAWNPOINTS[CURRENT_CHECKPOINT] and table.Count(SPAWNPOINTS[CURRENT_CHECKPOINT]) > 0 then
		local spawnpos

		while(1) do
			spawnpos = table.Random(SPAWNPOINTS[CURRENT_CHECKPOINT])
			
			local data = {}
			data.start = spawnpos + Vector(0, 0, 1)
			data.endpos = data.start + Vector(0, 0, 2)
			data.mins = Vector(-16, -16, 0)
			data.maxs = Vector(16, 16, 64)

			if !data.Hit then
				break
			end
		end

		ply:SetPos(spawnpos)
	end
end)

hook.Add("OnCheckPointReached", "waypoint.default", function(ply)
	if SERVER then
		for k, v in ipairs(player.GetAll()) do
			SendObjective(v, "Checkpoint #" .. CURRENT_CHECKPOINT .. " reached.", 5)
		end
	end
end)

hook.Add("Think", "waypoint.think", function()
	for k, v in pairs(player.GetAll()) do
		for check, vecs in ipairs(CHECKPOINTS) do
			local ppos = v:GetPos() + v:OBBCenter()
			if ppos:WithinAABox(vecs[1], vecs[2]) then
				if check > CURRENT_CHECKPOINT then
					CURRENT_CHECKPOINT = check

					hook.Call("OnCheckPointReached", GAMEMODE, v)
				end
			end
		end
	end
end)
