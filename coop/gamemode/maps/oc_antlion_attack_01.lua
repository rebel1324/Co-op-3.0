if SERVER then
	resource.AddWorkshop(239279433)
end

AddSpawn(Vector(430.048157, 3288.840088, -943.088318))
AddSpawn(Vector(414.393799, 3142.809326, -943.088318))
AddSpawn(Vector(396.068939, 3007.138672, -943.088318))
AddSpawn(Vector(385.221710, 2926.831299, -943.088318))
AddSpawn(Vector(375.565369, 2855.339600, -943.088318))
AddSpawn(Vector(365.905670, 2783.823486, -943.088318))

if SERVER then
	mapgo = mapgo or {}

	local shittoremove = {
		"weapon_maker_01_model",
		"weapon_maker_01_model1",
		"weapon_maker_01_model2",
		"weapon_maker_01_button_rpg1",
		"weapon_maker_01_button_rpg_model1",
		"weapon_maker_01_button_shotgun1",
		"weapon_maker_01_button_shotgun_model1",
		"weapon_maker_01_button_ar3",
		"weapon_maker_01_button_ar2_model1",
		"weapon_ar2_01_env_template_merchant1",
		"weapon_rpg_01_env_template_merchant1",
		"weapon_shotgun_01_env_template_merchant1",
		"weapon_ar2_01_env_template1",
		"weapon_rpg_01_env_template1",
		"buy_failure_sound1",
		"weapon_maker_01_button_rpg2",
		"weapon_maker_01_button_shotgun2",
		"weapon_maker_01_button_ar4",
		"weapon_ar2_01_env_template_merchant2",
		"weapon_rpg_01_env_template_merchant2",
		"weapon_shotgun_01_env_template_merchant2",
		"weapon_ar2_01_env_template2",
		"weapon_shotgun_01_env_template2",
		"weapon_rpg_01_env_template2",
		"buy_failure_sound2",
		"weapon_maker_01_model2",
		"weapon_maker_01_button_rpg_model2",
		"weapon_maker_01_button_shotgun_model2",
		"weapon_maker_01_button_ar2_model2",
		"weapon_maker_01_button_ar2",
		"weapon_maker_01_button_ar2_model",
		"weapon_maker_01_button_shotgun_model",
		"weapon_maker_01_button_rpg_model",
		"weapon_maker_01_button_shotgun",
		"weapon_maker_01_button_rpg",
		"weapon_rpg_01_env_template",
		"weapon_ar2_01_env_template",
		"weapon_shotgun_01_env_template",
		"weapon_rpg_01_env_template_merchant",
		"weapon_ar2_01_env_template_merchant",
		"weapon_shotgun_01_env_template_merchant",
		"lives_button1",
		"lives_merchant",
		"lives_button",
		"lives_merchant_sprite",
		"lives_merchant_sprite1",
		"lives_merchant1",
		"lives_merchant_sprite2",
		"357_txt",
		"healer_txt",
		"slam_txt",
		"rpg_txt",
		"sniper_rifle_txt",
		"manhack_txt",
		"live_txt",
		"lives_txt",
		"shotgun_txt",
		"pulse_rifle_txt",
		"grenade_txt",
	}

	AddTriggerEvent("antlion_attack_wave_1","OnTrigger", "hooker,RoundStart,1,0,-1")
	AddTriggerEvent("antlion_attack_wave_2","OnTrigger", "hooker,RoundStart,2,0,-1")
	AddTriggerEvent("antlion_attack_wave_3","OnTrigger", "hooker,RoundStart,3,0,-1")
	AddTriggerEvent("antlion_attack_wave_4","OnTrigger", "hooker,RoundStart,4,0,-1")
	AddTriggerEvent("antlion_attack_wave_5","OnTrigger", "hooker,RoundStart,5,0,-1")
	AddTriggerEvent("antlion_attack_wave_5","OnTrigger", "hooker,DisableMedics,,0,-1")
	AddTriggerEvent("antlion_attack_wave_6","OnTrigger", "hooker,RoundStart,6,0,-1")
	AddTriggerEvent("antlion_attack_wave_7","OnTrigger", "hooker,RoundStart,7,0,-1")
	AddTriggerEvent("antlion_attack_wave_8","OnTrigger", "hooker,RoundStart,8,0,-1")
	AddTriggerEvent("antlion_attack_wave_9","OnTrigger", "hooker,RoundStart,9,0,-1")
	AddTriggerEvent("antlion_attack_wave_10", "OnTrigger", "hooker,RoundStart,10,0,-1")
	AddTriggerEvent("outland_failure_vox_relay", "OnTrigger", "obj_thumper,Enable,,1,-1")
	AddTriggerEvent("outland_failure_relay2", "OnTrigger", "obj_thumper,Disable,,1,-1")
	AddTriggerEvent("dropship_01_track_10", "OnPass", "obj_extract,Enable,,1,-1")
	AddTriggerEvent("start", "OnIn", "hooker,Faget,1,0,-1")
	AddTriggerEvent("med", "OnIn", "hooker,Faget,2,0,-1")

	hook.Add("OnEntityTriggered", "custom_map", function(inputName, activator, data)
		if inputName == "DisableMedics" then
				for k, v in ipairs(ents.FindByClass("coop_healer")) do
					v:Disable()
				end
		elseif inputName == "RoundStart" then
			netstream.Start(player.GetAll(), "RoundStartMusic")	

			for k, v in ipairs(player.GetAll()) do
				SendObjective(v, "Attack Wave: " .. data, 5)
			end
		end
	end)

	hook.Add("CanMapPurchase", "custom_map", function(ent, input, activator, called, data)
		if #ents.FindByClass("npc_turret_floor") >= 5 then
			called:EmitSound("common/wpn_denyselect.wav")
			SendNotify(activator, "Can't own more than 5 floor turrets.", 5)

			return false
		end
	end)

	hook.Add("InitPostEntity", "custom_map", function()
		local obj = ents.Create("info_waypoint")
		obj:SetKeyValue("origin",  "644.48 -2610.52 -658.74")
		obj:SetKeyValue("image", "3")
		obj:SetKeyValue("text", "Activate Thumper")
		obj:SetName("obj_thumper")

		local obj = ents.Create("info_waypoint")
		obj:SetKeyValue("origin",  "637.09 3219.12 -626.55")
		obj:SetKeyValue("image", "4")
		obj:SetKeyValue("text", "Evacuate")
		obj:SetName("obj_extract")

		for k, v in pairs(ents.GetAll()) do
			if table.HasValue(shittoremove, v:GetName()) then
				v:Fire("Kill")
			end

			if v:GetClass() == "func_button" then
				if v:GetName() == "easy" then
					mapgo.easy = v
				elseif v:GetName() == "med" then
					mapgo.med = v
				elseif v:GetName() == "hard" then
					mapgo.hard = v
				elseif v:GetName() == "start" then
					mapgo.start = v
				end
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
					end
					starttimer = CurTime() + timetostart
					roundtimer = CurTime() + timetostart + roundtime

					PushTimer( nil, timetostart, "Game is starting." )

					rsevent = false
					started = true
				elseif started and starttimer <= CurTime() then
					if !rsevent then
						for k, v in ipairs(player.GetAll()) do
							SendObjective(v, "DIFFICULTY: MEDIUM", 5)
						end

						rsevent = true

						print(mapgo.med, mapgo.start)
						mapgo.med:Fire("Use", "", .5)
						mapgo.start:Fire("Use", "", 3)
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