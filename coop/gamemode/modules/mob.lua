mob = mob or {}

mob.ranks = {
	[1] = {
		name = "BOSS",
		chance = .1,
		color = Color(255, 50, 50),
	},
	[2] = {
		name = "SPECIAL",
		chance = 1,
		color = Color(255, 80, 80),
		killed = function(ent, ply, wep)
			local e = ents.Create("coop_money")
			e:SetPos(ent:GetPos() + ent:OBBCenter())
			e:SetAngles(AngleRand())
			e:Spawn()
			e.amount = math.random(1,999)

			local phys = e:GetPhysicsObject()
			phys:SetVelocity(VectorRand()*phys:GetMass()*150)
		end,
	},
	[3] = {
		name = "S",
		chance = 2,
		color = Color(255, 60, 60),
		onspawn = function(ent)
			if SERVER then
				ent:SetBloodColor( BLOOD_COLOR_MECH )
				ent:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)
				if ent:GetClass() == "npc_combine_s" then
					ent:SetKeyValue("NumGrenades", 10)
					ent:SetKeyValue("tacticalvariant", "true")
				end
			end
		end,
		damaged = function(ent, hitgroup, dmginfo)
			if hitgroup ~= HITGROUP_HEAD then
				dmginfo:ScaleDamage(.1)
				ent:EmitSound(Format("weapons/fx/rics/ric%s.wav", math.random(1,5)), 100, math.random(90,120))
				ent:EmitSound(Format("physics/metal/metal_box_impact_hard%s.wav", math.random(1,3)), 100, math.random(90,120))

				if hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH or hitgroup == HITGROUP_GENERIC then
					dmginfo:ScaleDamage(.35)
				end
			else
				dmginfo:ScaleDamage(.5)
			end

			return dmginfo
		end,
		killed = function(ent, ply, wep)
			local e = ents.Create("coop_money")
			e:SetPos(ent:GetPos() + ent:OBBCenter())
			e:SetAngles(AngleRand())
			e:Spawn()
			e.amount = math.random(66,222)

			local phys = e:GetPhysicsObject()
			phys:SetVelocity(VectorRand()*phys:GetMass()*150)
		end,
	},
	[4] = {
		name = "A",
		chance = 8,
		color = Color(255, 80, 80),
		onspawn = function(ent)
			if SERVER then
				ent:SetBloodColor( BLOOD_COLOR_GREEN )
				ent:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)
				if ent:GetClass() == "npc_combine_s" then
					ent:SetKeyValue("NumGrenades", 5)
					ent:SetKeyValue("tacticalvariant", "true")
				end
			end
		end,
		damaged = function(ent, hitgroup, dmginfo)
			dmginfo:ScaleDamage(.6)
		end,
		killed = function(ent, ply, wep)
			local e = ents.Create("coop_money")
			e:SetPos(ent:GetPos() + ent:OBBCenter())
			e:SetAngles(AngleRand())
			e:Spawn()
			e.amount = math.random(44,66)

			local phys = e:GetPhysicsObject()
			phys:SetVelocity(VectorRand()*phys:GetMass()*150)
		end,
	},
	[5] = {
		name = "B",
		chance = 16,
		color = Color(255, 100, 100),
		onspawn = function(ent)
			if SERVER then
				ent:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_GOOD)
				if ent:GetClass() == "npc_combine_s" then
					ent:SetKeyValue("NumGrenades", 3)
					ent:SetKeyValue("tacticalvariant", "true")
				end
			end
		end,
		damaged = function(ent, hitgroup, dmginfo)
			dmginfo:ScaleDamage(.8)
		end,
		killed = function(ent, ply, wep)
			local e = ents.Create("coop_money")
			e:SetPos(ent:GetPos() + ent:OBBCenter())
			e:SetAngles(AngleRand())
			e:Spawn()
			e.amount = math.random(22,44)

			local phys = e:GetPhysicsObject()
			phys:SetVelocity(VectorRand()*phys:GetMass()*150)
		end,
	},
	[6] = {
		name = "C",
		chance = 32,
		color = Color(255, 150, 150),
		onspawn = function(ent)
			if SERVER then
				ent:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_AVERAGE)
			end
		end,
		killed = function(ent, ply, wep)
			local e = ents.Create("coop_money")
			e:SetPos(ent:GetPos() + ent:OBBCenter())
			e:SetAngles(AngleRand())
			e:Spawn()
			e.amount = math.random(10,20)

			local phys = e:GetPhysicsObject()
			phys:SetVelocity(VectorRand()*phys:GetMass()*150)
		end,
	},
}
mob.ranked = mob.ranked or {}

local function AddRanked(ent, rank)
	if !ent:IsValid() then

		return
	end

	local rankdata = mob.ranks[rank]
	if rankdata and rankdata.onspawn then
		rankdata.onspawn(ent)
	end

	mob.ranked[rank] = mob.ranked[rank] or {}
	table.insert(mob.ranked[rank], ent)
end

if SERVER then
	hook.Add("Think", "mob.think", function()
		for rank, ent in pairs(mob.ranked) do
			for k, v in ipairs(ent) do
				if !v or !v:IsValid() or !v:IsNPC() or v:GetNPCState() == NPC_STATE_DEAD then
					table.remove(mob.ranked, k)

					continue
				end

				local rankdata = mob.ranks[rank]
				if rankdata and rankdata.server then
					rankdata.server(ent)
				end
			end
		end
		for k, v in ipairs(ents.GetAll()) do
			if v:IsNPC() then
				if !v.assigned then
					-- to solve fucking OnEntityCreated Bug
					v.assigned = true
				end
			end
		end
	end)

	hook.Add("OnNPCKilled", "mob.loot", function(ent, attacker, inflicter)
		if !table.HasValue(DEFAULT_LOOTS_BLACKLIST, ent:GetClass()) then
			if ent.rank then
				local rankdata = mob.ranks[ent.rank]
				if rankdata and rankdata.killed then
					rankdata.killed(ent, attacker, inflicter)
				end
			end
		end
	end)

	hook.Add("OnEntityCreated", "mob.random", function(ent)
		if ent:IsNPC() then
			for k, v in ipairs(mob.ranks) do
				local dice = math.Rand(0, 100)
				if dice <= v.chance then
					ent.rank = k
					AddRanked(ent, k)

					netstream.Start(player.GetAll(), "rankmob", {ent:EntIndex(), k})
					break
				end
			end
		end
	end)

	hook.Add("ScaleNPCDamage", "mob.damage", function(ent, hitgroup, dmginfo)
		if ent.rank then
			local rankdata = mob.ranks[ent.rank]
			if rankdata and rankdata.damaged then
				rankdata.damaged(ent, hitgroup, dmginfo)
			end
		end
	end)

	hook.Add("PlayerAuthed", "mob.sync", function(ply)
		netstream.Start(ply, "rankmobsync", mob.ranked)
	end)
else
	surface.CreateFont("RankFont", {
		font = "Trajan Pro",
		size = 55,
		weight = 800,
		shadow = true,
	})

	local customoffset = {
		["npc_manhack"] = function(ent)
			return ent:GetPos() + ent:OBBCenter() + Vector(0, 0, 10)
		end,
		["npc_scanner"] = function(ent)
			return ent:GetPos() + ent:OBBCenter() + Vector(0, 0, 10)
		end,
		["npc_antlion"] = function(ent)
			return ent:GetPos() + ent:GetUp()*22
		end,
		["npc_zombie"] = function(ent)
			return ent:GetPos() + ent:GetUp()*69
		end,
	}

	local mindist = 100
	local maxdist = 500

	hook.Add("CreateClientsideRagdoll", "mob.crag", function(e, r)
		if e.ranked then
			for k, v in ipairs(mob.ranked[e.ranked]) do
				if v == e then
					table.remove(mob.ranked[e.ranked], k)
				end
			end
		end
	end)

	hook.Add("HUDPaint", "mob.draw", function()
		local ply = LocalPlayer()

		for rank, ent in pairs(mob.ranked) do
			for k, v in ipairs(ent) do
				if !v:IsValid() then
					continue
				end

				if ply:GetPos():Distance(v:GetPos()) > mindist * 10 then
					continue	
				end

				local bpos
				local offsetdata = customoffset[v:GetClass()]
				if offsetdata then
					bpos = offsetdata(v)
				else
					local bone = v:LookupBone("ValveBiped.Bip01_Head1")
					bpos = bone and v:GetBonePosition(bone) or v:GetPos()
					bpos = bpos + Vector(0, 0, 20)
				end

				local rankdata = mob.ranks[rank]
				local nametext = "RANK: " .. rankdata.name or "NONE"

				local x, y, visible = bpos:ToScreen().x, bpos:ToScreen().y, bpos:ToScreen().visible
				if !visible then continue end
				local fov = 90/ply:GetFOV()
				local scale = mindist/ply:EyePos():Distance(bpos)*fov
				local alpha = math.Clamp( 255 + maxdist - ply:EyePos():Distance(bpos), 0, 255 )
				local mx = Matrix()

				if alpha == 0 then
					continue
				end

				surface.SetFont("RankFont")
				local tx, ty = surface.GetTextSize(nametext)

				mx:Translate(Vector(x - tx/2*scale, y, 1))
				mx:Scale(Vector(scale, scale, 1))

				cam.PushModelMatrix(mx)
					surface.SetTextPos(2, 2)

					surface.SetTextColor(Color(0,0,0,alpha))
					surface.DrawText(nametext)

					local color = rankdata.color or color_white
					color.a = alpha
					surface.SetTextPos(0, 0)
					surface.SetTextColor(color)
					surface.DrawText(nametext)
				cam.PopModelMatrix()
			end
		end
	end)
	
	mob.queue = mob.queue or {}
	function AddQueue(ent, rank)
		table.insert(mob.queue, {ent, rank})
	end
	
	hook.Add("Think", "mob.think", function()
		for k, v in ipairs(mob.queue) do
			local npc = ents.GetByIndex(v[1])

			if npc:IsValid() and npc:IsNPC() then
				npc.ranked = v[2]
				AddRanked(npc, v[2])

				table.remove(mob.queue, k)	
			end
		end

		for rank, ent in pairs(mob.ranked) do
			for k, v in ipairs(ent) do
				if !v or !v:IsValid() then
					table.remove(mob.ranked[rank], k)

					continue
				end

				local rankdata = mob.ranks[rank]
				if rankdata and rankdata.client then
					rankdata.client(ent)
				end
			end
		end
	end)

	netstream.Hook("rankmobsync", function(dat)
		mob.ranked = dat
	end)

	netstream.Hook("rankmob", function(dat)
		local ent, rank = dat[1], dat[2]

		AddQueue(ent, rank)
	end)
end