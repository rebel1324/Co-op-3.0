if SERVER then
	resource.AddWorkshop(237561627)
end

HARDCORE = true

if SERVER then
	DEFAULT_POINT_AWARD = {1, 20}
	DEFAULT_LOOTS_AMOUNT = {1, 3}
	DEFAULT_LOOTS_CHANCE = 15

	REMOVE_ALL_ITEMS = true

	local shittoremove = {
		"zombiesound",
		"sound1",
		"sound2",
		"sound3",
	}

	npc_spawns = npc_spawns or {}

	AddSpawn(Vector(1657.100098, -59.820244, 48.031250))
	AddSpawn(Vector(1483.473755, -50.645741, 48.031250))
	AddSpawn(Vector(1489.324829, 60.066704, 48.031250))
	AddSpawn(Vector(1494.859253, 164.787476, 48.031250))
	AddSpawn(Vector(1465.642334, 259.787018, 48.031250))
	AddSpawn(Vector(1648.256226, 250.136810, 48.031250))
	AddSpawn(Vector(1639.396973, 82.503830, 48.031250))
	AddSpawn(Vector(1909.258179, 362.185120, 0.031250))
	AddSpawn(Vector(1783.707520, 494.455750, 0.031250))
	AddSpawn(Vector(1366.447632, 488.292450, 0.031250))
	AddSpawn(Vector(1256.536621, 308.174622, 0.031250))
	AddSpawn(Vector(1223.837891, -190.037552, 0.031250))
	AddSpawn(Vector(1375.671997, -306.029541, 0.031250))
	AddSpawn(Vector(1773.923218, -307.285461, 0.031250))
	AddSpawn(Vector(1925.651245, -133.743622, 0.031250))

	hook.Add("InitPostEntity", "custom_map", function()
		for k, v in ipairs(shittoremove) do
			local shits = ents.FindByName(v)
			for _, ent in ipairs(shits) do
				ent:Remove()
			end
		end

		for k, v in pairs(ents.FindByClass("prop_*")) do
			v:Remove()
		end

		for k, v in pairs(ents.FindByClass("func_*")) do
			v:Remove()
		end

		for k, v in pairs(ents.FindByClass("logic_*")) do
			v:Remove()
		end

		for k, v in pairs(ents.FindByClass("npc_maker")) do
			table.insert(npc_spawns, v:GetPos())
			v:Remove()
		end

		for k, v in pairs(ents.GetAll()) do
			if v:GetClass() == "coop_ammo" or v:GetClass() == "coop_weapon" or v:GetClass() == "coop_healthvial" then
				v.cleanup = true
				v:Remove()
			end
		end
	end)	

	local timetostart = 30
	local roundtime = 150
	local nomedic = 5
	local attackto = Vector(1588.960327, 91.152855, 48.031250)
	local rsevent = false
	roundtimer = roundtimer or CurTime()
	starttimer = starttimer or CurTime()
	started = started or false

	curround = curround or 1
	zombies = {}
	zombies["npc_zombie"] = {
		interval = {2, 4},
		max = 8,
		time = CurTime(),
		round = 1,
	}

	zombies["npc_fastzombie"] = {
		interval = {4, 6},
		max = 6,
		time = CurTime(),
		round = 3,
	}

	roundevents = {}
	roundevents[5] = function()
		for k, v in ipairs(player.GetAll()) do
			SendNotify(v, "Medical Station is Compromised!", 5)
			SendNotify(v, "Horde became more stronger.", 5)
		end

		for k, v in ipairs(ents.FindByClass("coop_healer")) do
			v:Disable()
		end
	end
	roundevents[10] = function()
		for k, v in ipairs(player.GetAll()) do
			SendNotify(v, "You hear strange sound from somewhere.", 5)
			SendNotify(v, "Horde became more stronger.", 5)
		end
	end
	roundevents[15] = function()
		for k, v in ipairs(player.GetAll()) do
			SendNotify(v, "Horde became more stronger.", 5)
		end
	end
	roundevents[20] = function()
		for k, v in ipairs(player.GetAll()) do
			SendNotify(v, "Horde became more stronger.", 5)
		end
	end

	hook.Add("PostRoundLose", "custom_map", function()
		for k, v in ipairs(ents.FindByClass("coop_healer")) do
			v:Enable()
		end

		StopTimer()
		roundtimer = CurTime()
		starttimer = CurTime()
		started = false
		curround = 1
	end)

	hook.Add("Think", "custom_map", function()
		local alives = 0
		for k, v in ipairs(player.GetAll()) do
			if v:Team() == TEAM_ALIVE then
				alives = alives + 1
			end
		end

		if #player.GetAll() >= 2 then
			if !GAME_LOST then
				if !started then
					if curround == 1 then
						for k, v in ipairs(player.GetAll()) do
							SendObjective(v, "GAME COUNTDOWN ACTIVATED.", 5)
						end
					else
						for k, v in ipairs(player.GetAll()) do
							SendObjective(v, "SQUAD SURVIVED!", 5)
						end
					end
					starttimer = CurTime() + timetostart
					roundtimer = CurTime() + timetostart + roundtime

					PushTimer( nil, timetostart, "Waiting for Players" )

					rsevent = false
					started = true
				elseif started and starttimer <= CurTime() then
					if roundtimer < CurTime() then
						curround = curround + 1
						started = false
					end

					if !rsevent then
						netstream.Start(player.GetAll(), "RoundStartMusic")	

						for k, v in ipairs(player.GetAll()) do
							SendObjective(v, "Round " .. curround, 5)
						end

						if roundevents[curround] then
							roundevents[curround]()
						end

						rsevent = true
					end

					for class, data in pairs(zombies) do
						if #ents.FindByClass(class) > data.max then
							continue
						end

						if data.round > curround then
							continue
						end

						if data.time <= CurTime() then
							local findspawn = true
							
							while findspawn == true do
								local pos = table.Random(npc_spawns)
								local data = {}
								data.start = pos + Vector(0, 0, 1)
								data.endpos = data.start + Vector(0, 0, 2)
								data.mins = Vector(-16, -16, 0)
								data.maxs = Vector(16, 16, 64)
								
								local trace = util.TraceHull(data)

								if !trace.Hit then
									print(1)
									local npc = ents.Create(class)
									npc:SetPos(pos)
									npc:Spawn()
									npc:Activate()

									timer.Simple(.1, function()
										if npc and npc:IsValid() then
										--	npc:SetEnemy(table.Random(player.GetAll()))
										end
									end)

									findspawn = false
								end
							end
							
							data.time = CurTime() + math.random(data.interval[1], data.interval[2])
						end
					end
				end
			end
		else
			if started then
				ResetMap()
				hook.Call("PostRoundLose", GAMEMODE)

				for k, v in ipairs(player.GetAll()) do
					v:Spawn()
					SendObjective(v, "Game is Dropped.", 5)
				end
			end
		end
	end)

else
	netstream.Hook("RoundStartMusic", function(data)
		sound.PlayURL("https://dl.dropboxusercontent.com/s/t0nbijwe8eusps5/bgm_af_start.ogg", "mono", function() end)
	end)
end