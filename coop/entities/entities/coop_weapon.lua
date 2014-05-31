 AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Money"
ENT.Author = "Chessnut"
ENT.Category = "NutScript"
ENT.RenderGroup 		= RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
  		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

		if SERVER then
			self:SetTrigger(true)
		end
		self.taken = false

		local physObj = self:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:Wake()
		end
	end

	function ENT:OnRemove()
		if self.respawn and !self.cleanup then
			local pos, ang, model, wep = self.pos, self.ang, self:GetModel(), self.weapon
			timer.Simple(WEAPON_RESPAWN_TIME, function()
				local ent = ents.Create("coop_weapon")
				ent:SetModel(model)
				ent:SetPos(pos)
				ent:SetAngles(ang)
				ent:Spawn()
				ent:Activate()
				ent.respawn = true
				ent.weapon = wep
				ent.pos = pos
				ent.ang = ang

				local physObj = ent:GetPhysicsObject()
				if (IsValid(physObj)) then
					physObj:Wake()
				end
			end)
		end
	end
	
	local hl2weapons = {
		weapon_pistol = {"pistol", 18},
		weapon_smg1 = {"smg1", 30},
		weapon_ar2 = {"ar2", 30},
		weapon_frag = {"grenade", 1},
		weapon_crossbow = {"xbowbolt", 2},
		weapon_357 = {"357", 6},
		weapon_shotgun = {"buckshot", 6},
		weapon_rpg = {"rpg_round", 3},
	}

	function ENT:Touch(ent)
		if self.taken != true then
			if (ent:IsValid() and ent:IsPlayer()) then

				local used = false
				if !ent:HasWeapon(self.weapon) then
					ent:Give(self.weapon)
					used = true
				else
					local wepdat = weapons.Get(self.weapon)
					local plyammo, ammoamt, ammolimit = 0
					if wepdat then
						if wepdat.Primary then
							if wepdat.Primary.Ammo ~= "none" then
								ammolimit = AMMO_LIMITS[wepdat.Primary.Ammo]
								plyammo = ent:GetAmmoCount(wepdat.Primary.Ammo)
								ammoamt = wepdat.Primary.ClipSize or 0
								local giveammo = math.Clamp( ammolimit - plyammo, 0, ammoamt)

								if giveammo > 0 then
									ent:GiveAmmo(giveammo, wepdat.Primary.Ammo, false)
									used = true
								end
							end
						end
					else
						local amdat = hl2weapons[string.lower(self.weapon)]

						if amdat then
							ammolimit = AMMO_LIMITS[amdat[1]]
							plyammo = ent:GetAmmoCount(amdat[1])
							ammoamt = amdat[2]
							local giveammo = math.Clamp( ammolimit - plyammo, 0, ammoamt)

							if giveammo > 0 then
								ent:GiveAmmo(giveammo, amdat[1], false)
								used = true
							end
						end
					end
				end
				
				if used then
					self.taken = true
					self:Remove()
				end
			end
		end
	end

	function ENT:Use(activator)
		self:Touch(activator)
	end
else
	function ENT:DrawTranslucent()
	end
	
	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	function ENT:Draw()
		self:DrawModel()

		local sin = 150 + math.abs(math.sin(RealTime()*5)*100)
		self:SetColor(Color(sin,sin,sin))

		local pos = self:GetPos()
		local min, max = self:GetRotatedAABB(self:OBBMins(), self:OBBMaxs())
		local mixvec = Vector(0, 0, 0)
		for i = 1, 3 do
			mixvec[i] = math.Rand(min[i], max[i])
		end

		self.emitter = self.emitter or ParticleEmitter(pos)
		if !self.emitTime or self.emitTime < RealTime() then
			local smoke = self.emitter:Add( "sprites/glow04_noz.vmt", pos + mixvec )
			smoke:SetVelocity(Vector( 0, 0, 1))
			smoke:SetDieTime(math.Rand(.1,.5))
			smoke:SetStartAlpha(math.Rand(255,255))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(0,2))
			smoke:SetEndSize(math.random(5,11))
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-3,3))
			smoke:SetColor(250,250,250)
			smoke:SetGravity( Vector( 0, 0, 10 ) )
			smoke:SetAirResistance(200)

			self.emitTime = RealTime() + .1
		end
	end
end