if SERVER then
	local roundtime = 5

	AddTriggerEvent("game_round01_relay", "OnTrigger", "hooker,RoundStart,1,0,-1")
	AddTriggerEvent("game_round01_relay", "OnTrigger", "obj_go,Disable,,0,-1")
	AddTriggerEvent("game_round01_relay", "OnTrigger", Format("game_round02_relay,Trigger,,%d,-1", roundtime))

	AddTriggerEvent("game_round02_relay", "OnTrigger", "hooker,RoundStart,2,0,-1")
	AddTriggerEvent("game_round02_relay", "OnTrigger", Format("game_round03_relay,Trigger,,%d,-1", roundtime))

	AddTriggerEvent("game_round03_relay", "OnTrigger", "hooker,RoundStart,3,0,-1")
	AddTriggerEvent("game_round03_relay", "OnTrigger", Format("game_round04_relay,Trigger,,%d,-1", roundtime))

	AddTriggerEvent("game_round04_relay", "OnTrigger", "hooker,RoundStart,4,0,-1")
	AddTriggerEvent("game_round04_relay", "OnTrigger", Format("game_round05_relay,Trigger,,%d,-1", roundtime))

	AddTriggerEvent("game_round05_relay", "OnTrigger", "hooker,RoundStart,5,0,-1")
	AddTriggerEvent("game_round05_relay", "OnTrigger", "hooker,DisableMedics,,0,-1")
	AddTriggerEvent("game_round05_relay", "OnTrigger", Format("game_round06_relay,Trigger,,%d,-1", roundtime))

	AddTriggerEvent("game_round06_relay", "OnTrigger", "hooker,RoundStart,6,0,-1")
	AddTriggerEvent("game_round06_relay", "OnTrigger", Format("game_round07_relay,Trigger,,%d,-1", roundtime))

	AddTriggerEvent("game_round07_relay", "OnTrigger", "hooker,RoundStart,7,0,-1")
	AddTriggerEvent("game_round07_relay", "OnTrigger", Format("game_round08_relay,Trigger,,%d,-1", roundtime))

	AddTriggerEvent("game_round08_relay", "OnTrigger", "hooker,RoundStart,8,0,-1")
	AddTriggerEvent("game_round08_relay", "OnTrigger", Format("game_round09_relay,Trigger,,%d,-1", roundtime))

	AddTriggerEvent("game_round09_relay", "OnTrigger", "hooker,RoundStart,9,0,-1")
	AddTriggerEvent("game_round09_relay", "OnTrigger", Format("game_round10_relay,Trigger,,%d,-1", roundtime))

	AddTriggerEvent("game_round10_relay", "OnTrigger", "hooker,RoundStart,10,0,-1")
	AddTriggerEvent("game_round10_relay", "OnTrigger", Format("game_final_helicopter_relay,Trigger,,%d,-1", roundtime))
	AddTriggerEvent("game_final_helicopter_waypoint", "origin", "1529 1665 46")

	CURRENT_ROUND = 0
	NPC_SPAWNPOINTS = {}

	hook.Add("OnEntityTriggered", "custom_map", function(inputName, activator, data)
		if inputName == "DisableMedics" then
				for k, v in ipairs(ents.FindByClass("coop_healer")) do
					v:Disable()
				end
		elseif inputName == "RoundStart" then
			for k, v in ipairs(player.GetAll()) do
				SendObjective(v, "Attack Wave: " .. data, 5)
			end

			CURRENT_ROUND = data

			PushTimer(nil, roundtime, "Survive")
		end
	end)

	local blacklist = {
		"npc_helicopter_maker",
	}

	hook.Add("InitPostEntity", "custom_map", function()
		local obj = ents.Create("info_waypoint")
		obj:SetKeyValue("origin",  "715 1506 72")
		obj:SetKeyValue("image", "3")
		obj:SetKeyValue("text", "Activate")
		obj:SetName("obj_go")

		obj:Fire("Enable")

		for k, v in ipairs(ents.GetAll()) do
			if v:GetClass() == "prop_ragdoll" then
				v:Remove()
			elseif v:GetClass() == "npc_template_maker" then
				local name = v:GetName()
				if !table.HasValue(blacklist, name) then
					table.insert(NPC_SPAWNPOINTS, v:GetPos())
					v:Remove()
				end
			end
		end
	end)	

	local enemies = {}
		hook.Add("Think", "custom_map", function()

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

	end)

end