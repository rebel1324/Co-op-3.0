AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Medical Device"
ENT.Author = "Black Tea"
ENT.Category = "Fuck You"

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_combine/health_charger001.mdl")
		self:PhysicsInit(SOLID_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetUseType(SIMPLE_USE)
  		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	end

	hook.Add("Think", "medical.think", function()
		for ind, ent in ipairs(ents.FindByClass("coop_healer")) do
			for k, v in ipairs(player.GetAll()) do
				if !v:Alive() or v:Team() == TEAM_DEAD or ent.disable then
					if v.healsound then
						v.healsound:Stop()
					end
					
					continue	
				end

				local dist = v:GetPos():Distance(ent:GetPos())
				if dist <= 128 then
					if v.healing then
						if !v.nextHeal or v.nextHeal < CurTime() then
							v:SetHealth(math.Clamp(v:Health() + 1, 0, v:GetMaxHealth()))

							v.nextHeal = CurTime() + .2
						end
					else
						v.healer = ent
						v.healsound = v.healsound or CreateSound(v, "items/medcharge4.wav")
						v.healsound:Play()
						v:EmitSound("items/medshot4.wav")
						v.healing = true
					end
				else
					if v.healing then
						if v.healer ~= ent then
							continue
						end

						v.healer = nil
						if v.healsound then
							v.healsound:Stop()
						end
						v:EmitSound("items/medshotno1.wav")
						v.healing = false
					end
				end
			end
		end
	end)

	function ENT:Think()
		return true
	end
	
	function ENT:Use(activator)
	end

	function ENT:Disable()
		self:EmitSound("npc/scanner/scanner_electric1.wav")
		self.disable = true
		for k, v in ipairs(player.GetAll()) do
			netstream.Start(v, "MedicStationDisable", {self, true})
		end
	end

	function ENT:Enable()
		self.disable = false
		for k, v in ipairs(player.GetAll()) do
			netstream.Start(v, "MedicStationDisable", {self, false})
		end
	end
	
	hook.Add("PlayerAuthed", "healer_disabled", function(ply)
		for k, v in ipairs(ents.FindByClass("coop_healer")) do
			if v.disable then
				netstream.Start(ply, "MedicStationDisable", {v, true})
			end
		end
	end)
else
	gptcl = {}

	local maxquad = 10

	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	function ENT:Think()
		if self.disable then
			if !self.nextFuzz or self.nextFuzz < CurTime() then
				self.nextFuzz = CurTime() + 1
				self.onLight = CurTime() + .5
				self:EmitSound("HL1/fvox/fuzz.wav")
			end			
		end

		self:NextThink(CurTime())
		return true
	end

	local pm = ParticleEmitter(Vector(0,0,0))

	hook.Add("Think", "medical.think", function()
		for ind, ent in ipairs(ents.FindByClass("coop_healer")) do
			for k, v in ipairs(player.GetAll()) do
				if !v:Alive() or v:Team() == TEAM_DEAD or ent.disable then
					continue	
				end

				local dist = v:GetPos():Distance(ent:GetPos())
				if dist <= 128 then
					if v.healing then
						if !v.nextHeal or v.nextHeal < CurTime() then
							gptcl[v] = gptcl[v] or {}

							local pos = ent:GetPos()
							local min, max = ent:OBBMins(), ent:OBBMaxs()
							local mixvec = Vector(0, 0, 0)
							for i = 1, 3 do
								mixvec[i] = math.Rand(min[i], max[i])
							end

							table.insert(gptcl[v], {pos + mixvec*.5, CurTime() + .4, 255})

							local pos = v:GetPos()
							local min, max = v:OBBMins(), v:OBBMaxs()
							local mixvec = Vector(0, 0, 0)
							for i = 1, 3 do
								mixvec[i] = math.Rand(min[i], max[i])
							end

							v.emitter = v.emitter or ParticleEmitter(pos)
							if !v.emitTime or v.emitTime < RealTime() then
								local smoke = pm:Add( "sprites/glow04_noz.vmt", pos + mixvec*.9 )
								smoke:SetVelocity(Vector(0, 0, 1))
								smoke:SetDieTime(math.Rand(.1,.5))
								smoke:SetStartAlpha(math.Rand(255,255))
								smoke:SetEndAlpha(0)
								smoke:SetStartSize(math.random(0,2))
								smoke:SetEndSize(math.random(5,11))
								smoke:SetRoll(math.Rand(180,480))
								smoke:SetRollDelta(math.Rand(-3,3))
								smoke:SetColor(150,250,150)
								smoke:SetGravity( Vector( 0, 0, 10 ) )
								smoke:SetAirResistance(200)

								v.emitTime = RealTime() + .1
							end
							v.nextHeal = CurTime() + .05
						end
					else
						v.healer = ent
						v.healing = true
					end
				else
					if v.healing then
						if v.healer ~= ent then
							continue
						end
						v.healer = nil
						v.healing = false
					end
				end
			end
		end
	end)

	hook.Add("PostDrawOpaqueRenderables", "medical.effects", function()
		render.SetMaterial(GLOW_MATERIAL)
		for ply, dat in pairs(gptcl) do
			for k, v in ipairs(dat) do
				if !ply or !ply:IsValid() then
					continue
				end

				if v[2] < CurTime() then
					table.remove(dat, k)
				end

				v[3] = Lerp(CL_FT()*5, v[3], 0)
				v[1] = LerpVector(CL_FT()*2, v[1], ply:GetPos()+ply:OBBCenter())
				render.DrawSprite(v[1], 4, 4, Color(100,150,100,v[3]))
			end
		end
	end)

	function ENT:Draw()
		self:DrawModel()
		
		if self.disable then
			if !self.onLight or self.onLight >= CurTime() then
				local position = self:GetPos() + self:GetForward() * 8 + self:GetUp() * -.9 + self:GetRight() * 2

				render.SetMaterial(GLOW_MATERIAL)
				render.DrawSprite(position, 14, 14, Color(255, 150, 150))
			end
		else
			if !self.nextBeep or self.nextBeep < CurTime() then
				self:EmitSound("ambient/machines/combine_terminal_idle"..math.random(1,4)..".wav", 70, math.random(80,120))

				self.nextBeep = CurTime() + 5
			end
		end
	end
end