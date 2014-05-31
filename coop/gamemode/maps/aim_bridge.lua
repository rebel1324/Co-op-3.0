if SERVER then
	resource.AddWorkshop(242101754)
end

HARDCORE = true

/*
local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
if CLIENT then
	hook.Add("PostDrawTranslucentRenderables", "drawboxes", function()
		render.SetMaterial(GLOW_MATERIAL)
		for _, vecs in ipairs(playerclips) do
			for _, v in ipairs(vecs) do
				render.DrawSprite(v, 32, 32, Color(255, 0, 0 ))
			end

			render.DrawSprite(vecs[1] + (vecs[2]-vecs[1])/2, 16, 16, Color(255, 255, 0 ))
			render.DrawSprite(vecs[1], 16, 16, Color(0, 0, 255 ))
		end
	end)
end
*/

if SERVER then
	DEFAULT_POINT_AWARD = {1, 20}
	DEFAULT_LOOTS_AMOUNT = {1, 3}
	DEFAULT_LOOTS_CHANCE = 15

	REMOVE_ALL_ITEMS = true

	npc_spawns = npc_spawns or {}

	AddSpawn(Vector(111.5316619873, 7.7361946105957, 0.03125))
	AddSpawn(Vector(-89.699195861816, 257.01364135742, 0.03125))
	AddSpawn(Vector(-336.84133911133, 63.768756866455, 0.03125))
	AddSpawn(Vector(-293.89730834961, -71.628868103027, 0.03125))
	AddSpawn(Vector(212.75421142578, 352.89385986328, 0.03125))
	AddSpawn(Vector(614.32305908203, 374.37017822266, 0.031234741210938))
	AddSpawn(Vector(174.62155151367, 509.94415283203, 8.03125))
	AddSpawn(Vector(-211.89538574219, 504.80355834961, 8.03125))

	AddPlayerBarrier(Vector(1023.8677978516, 551.16424560547, 8.03125), Vector(1092.1293945313, -231.96875, 303.818359375))
	AddPlayerBarrier(Vector(-1023.99609375, -231.90129089355, 8.03125), Vector(-1104.7032470703, 551.96875, 303.55535888672))

	local helispawn = {}
	helispawn[1] = Vector(1754.628418, 1823.486572, 1220.559937)
	helispawn[2] = Vector(-1876.385010, -1594.379395, 1345.680908)

	local path_track = {}
	path_track[1] = Vector(390.730743, 1660.981323, 1000.111694)
	path_track[2] = Vector(-351.258545, 1426.846680, 942.984314)
	path_track[3] = Vector(-329.455048, -1434.703369, 928.283630)
	path_track[4] = Vector(494.601013, -1136.045654, 963.877075)

	local waypoints = {
		["leftside"] = Vector(-148.00531005859, 315.50067138672, 0.03125),
		["rightside"] =Vector(-148.00531005859, 315.50067138672, 0.03125),
	}

	local missilepos = {
		Vector(-916.40899658203, 2943.96875, 1542.3122558594),
		Vector(-279.45440673828, 2943.9692382813, 1574.7965087891),
		Vector(22.384185791016, 2943.9685058594, 1735.8073730469)
	}

	local missileguide = {
		Vector(-643.87243652344, 307.79071044922, 0.03125),
		Vector(-432.02548217773, -7.2239074707031, 0.03125),
		Vector(203.36456298828, 20.493469238281, 0.03125),
		Vector(187.31106567383, 350.04229736328, 0.03125),
		Vector(545.34252929688, 265.53149414063, 0.03125),
		Vector(721.56311035156, 72.357635498047, 0.031219482421875),
		Vector(399.43453979492, -30.555694580078, 0.03125),
		Vector(26.072265625, 429.52252197266, 84.701110839844),
		Vector(-65.172676086426, 26.220794677734, 87.058990478516),
	}

	local npc_spawns = {
		{ Vector(1652.8955078125, 370.92111206055, 0.03125), "leftside" },
		{ Vector(1651.4069824219, 245.24304199219, 0.03125), "leftside" },
		{ Vector(-1614.0080566406, 246.86801147461, 0.03125), "leftside" },
		{ Vector(-1585.5910644531, 379.99075317383, 0.03125), "leftside" },
		{ Vector(-1614.5107421875, 508.21240234375, 8.03125), "leftside" },
		{ Vector(1612.3033447266, 504.83151245117, 8.0312423706055), "leftside" },
		{ Vector(-1520.5386962891, 303.40173339844, 0.03125), "leftside" },

		{ Vector(1627.6859130859, 68.696212768555, 0.03125), "rightside" },
		{ Vector(1629.8656005859, -62.80392074585, 0.03125), "rightside" },
		{ Vector(1572.5729980469, -194.42486572266, 8.03125), "rightside" },
		{ Vector(-1623.8865966797, -52.244522094727, 0.03125), "rightside" },
		{ Vector(-1631.4549560547, 83.220489501953, 0.03125), "rightside" },
		{ Vector(-1659.7481689453, -182.19366455078, 8.03125), "rightside" },
		{ Vector(-1528.3830566406, 12.211303710938, 0.031265258789063), "rightside" },
	}	

	hook.Add("InitPostEntity", "custom_map", function()
		for k, v in ipairs(path_track) do
			local track = ents.Create("path_track")
			track:SetPos(v)
			track:SetName("heli_track_"..k)
			track:Spawn()
			track:Activate()
			track:SetKeyValue("radius", "3000")
			track:SetKeyValue("target", "heli_track_"..k+1)
			track:SetKeyValue("orientationtype", "1")
		end

		for k, v in pairs(waypoints) do
			local rally = ents.Create("assault_rallypoint")
			rally:SetPos(v)
			rally:SetName(k)
			rally:Spawn()
		end
	end)	

	local heli_patrol_time = 8
	function spawnheli()
		local heli = ents.Create("npc_helicopter")
		heli:SetPos(helispawn[1])
		heli:Spawn()
		heli:Activate()

		heli.timeTrack = CurTime() + heli_patrol_time
		heli.curTrack = 1
		heli:SetKeyValue("target", "heli_track_1")
		heli:SetKeyValue("OnDeath", "hooker,GameEnd,,0,-1")
	end

	function missilespawn()
		local dir = Vector(0,-1,0)

		for i = 1, 300 do
			timer.Simple( i*.1, function()
				local pos = table.Random(missilepos)
				local rocket = ents.Create("rpg_missile")
				rocket:SetPos(pos + dir*10 + Vector( 1, 0, 1 ) * math.random(1, 50))
				rocket:SetAngles(dir:Angle())
				rocket:Spawn()
				rocket.guidepos = table.Random(missileguide)  + VectorRand()*100
				rocket.guide = true
				rocket.guidetime = CurTime() + .4
				rocket:SetSaveValue( "m_flDamage", 1 )
				rocket:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
				rocket:SetVelocity(Vector(0,0,80) + dir * 500)
			end)
		end
	end

	function getheli()
		for k, heli in ipairs(ents.FindByClass("npc_helicopter")) do
			return heli 
		end
		return
	end

	local veclimit = 5000
	hook.Add("Think", "rocket.faget", function()
		for k, v in ipairs( ents.FindByClass("rpg_missile") ) do
			if v.guide and v.guidetime < CurTime() then
				--local tarpos = getheli():GetPos()
				local tarpos = v.guidepos
				local dir = tarpos - v:GetPos()
				dir:Normalize()
				local vecang = v:GetVelocity():GetNormalized():Angle()
				v:SetAngles(vecang)
				--v:SetVelocity(Vector(0, dir.y*.03, dir.z*.03))
				v:SetVelocity(dir*100)
			end
		end
	end)

	hook.Add("OnEntityTriggered", "custom_map", function(inputName, activator, data)
		if inputName == "GameEnd" then
			print('game is ended')
		end
	end)


	local timetostart = 30
	local roundtime = 120
	local nomedic = 5
	local attackto = Vector(1588.960327, 91.152855, 48.031250)
	local rsevent = false

	roundtimer = roundtimer or CurTime()
	starttimer = starttimer or CurTime()
	started = started or false
	curround = curround or 1
	spawnednpcs = spawnednpcs or {}

	npcdata = {}
	npcdata[1] = {
		interval = {2, 4},
		max = 8,
		time = CurTime(),
		spawnfunc = function(pos)
			local npc = ents.Create("npc_combine_s")
			npc:SetPos(pos)
			npc:Give("ai_weapon_smg1")
			npc:Spawn()
			npc:Activate()
			npc:SetKeyValue("spawnflag", 16 + 256 + 1024 + 8192 )
			npc:SetKeyValue("tacticalvariant", 2 )
			npc:SetKeyValue("squadname", "koreanboners")
			npc:SetKeyValue("customsquads", 1)
			npc:SetKeyValue("squadoverride", 0)

			return npc
		end,
		round = 1,
	}

	npcdata[2] = {
		interval = {2, 4},
		max = 4,
		time = CurTime(),
		spawnfunc = function(pos)
			local npc = ents.Create("npc_combine_s")
			npc:SetSkin(2)
			npc:SetPos(pos)
			npc:Give("ai_weapon_shotgun")
			npc:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_GOOD)
			npc:Spawn()
			npc:Activate()
			npc:SetKeyValue("spawnflag", 16 + 256 + 1024 + 8192 )
			npc:SetKeyValue("tacticalvariant", 2 )
			npc:SetKeyValue("squadname", "koreanboners")
			npc:SetKeyValue("customsquads", 1)
			npc:SetKeyValue("squadoverride", 0)

			return npc
		end,
		round = 3,
	}

	npcdata[3] = {
		interval = {2, 4},
		max = 4,
		time = CurTime(),
		spawnfunc = function(pos)
			local npc = ents.Create("npc_combine_s")
			npc:SetModel("models/combine_super_soldier.mdl")
			npc:SetPos(pos)
			npc:Give("nwep_ak47")
			npc:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)
			npc:Spawn()
			npc:Activate()
			npc:SetKeyValue("spawnflag", 16 + 256 + 1024 + 8192 )
			npc:SetKeyValue("tacticalvariant", 2 )
			npc:SetKeyValue("squadname", "koreanboners")
			npc:SetKeyValue("customsquads", 1)
			npc:SetKeyValue("squadoverride", 0)

			return npc
		end,
		round = 5,
	}


	roundevents = {}
	roundevents[3] = function()
		for k, v in ipairs(player.GetAll()) do
			SendNotify(v, "They called new combine soldier!", 5)
		end
	end

	roundevents[5] = function()
		for k, v in ipairs(player.GetAll()) do
			SendNotify(v, "Medical Station is Compromised!", 5)
			SendNotify(v, "They called new combine soldier!", 5)
		end

		for k, v in ipairs(ents.FindByClass("coop_healer")) do
			v:Disable()
		end
	end

	roundevents[7] = function()
		timer.Simple(5, function()
			for k, v in ipairs(player.GetAll()) do
				SendObjective(v, "Prepare for the boss.", 5)
			end

			spawnheli()
		end)

		timer.Simple(2, function()
			for k, v in ipairs(player.GetAll()) do
				PlayBackgroundSound(v, "npc/overwatch/cityvoice/fcitadel_30sectosingularity.wav")
				SendNotify(v, "You hear rotor wash sound from the far.", 5)
			end
		end)

		timer.Simple(30, function()
			for k, v in ipairs(player.GetAll()) do
				PlayBackgroundSound(v, "ambient/machines/floodgate_stop1.wav")

				timer.Simple(2, function()
					PlayBackgroundSound(v, "ambient/levels/labs/teleport_weird_voices1.wav")
				end)
			end

			timer.Simple(10, function()
				for k, v in ipairs(player.GetAll()) do
					SendObjective(v, "Now Helicopter is vulnerable! Shoot the Helicopter!", 5)
				end
			end)
		end)
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

		for k, heli in ipairs(ents.FindByClass("npc_helicopter")) do
			if heli.timeTrack < CurTime() then
				heli.curTrack = heli.curTrack + 1
				if heli.curTrack > 4 then
					heli.curTrack = 1
				end

				heli:Fire("FlyToPathTrack", "heli_track_" .. heli.curTrack)
				heli.timeTrack = CurTime() + heli_patrol_time
			end
		end

		if #player.GetAll() >= 22 then
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

					if curround < 7 then
						roundtimer = CurTime() + timetostart + roundtime
					else
						roundtimer = CurTime() + timetostart + math.huge
					end

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

					for dat, tbl in ipairs(spawnednpcs) do
						for k, v in ipairs(tbl) do
							if !v or !v:IsValid() then
								table.remove(spawnednpcs[dat], k)
							end
						end
					end

					for k, data in ipairs(npcdata) do
						if spawnednpcs[k] and #spawnednpcs[k] > data.max then
							continue
						end
						
						if data.round > curround then
							continue
						end

						if data.time <= CurTime() then
							local retry = 5 -- Crash Protection

							while true do

								retry = retry - 1
								local pos = table.Random(npc_spawns)
								local d = {}
								d.start = pos[1] + Vector(0, 0, 1)
								d.endpos = d.start + Vector(0, 0, 2)
								d.mins = Vector(-16, -16, 0)
								d.maxs = Vector(16, 16, 64)
								
								local trace = util.TraceHull(d)

								if !trace.Hit or true then
									local npc = data.spawnfunc(trace.HitPos)
									spawnednpcs[k] = spawnednpcs[k] or {}
									table.insert(spawnednpcs[k], npc)

									if pos[2] then
										npc:Fire("assault", pos[2])
									end

									break;
								end

								if retry <= 0 then
									break;
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