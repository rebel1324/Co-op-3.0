if SERVER then
	AddCSLuaFile()
end

ENT.Type = "anim"
ENT.Base = "coop_ammo"
ENT.type = "357"
ENT.amount = 15
ENT.max = 50
ENT.Model = Model("models/bloocobalt/l4d/items/w_eq_fieldkit.mdl")
ENT.skin = 1

function ENT:Touch(ent)
	if self.taken != true then
		if (ent:IsValid() and ent:IsPlayer()) then
			local wep = ent:GetActiveWeapon()
			if wep and wep:IsValid() then
				local ammonum = wep:GetPrimaryAmmoType()
				if ammonum ~= 0 and ammonum ~= -1 then
					local trans = AMMO_TRANS[wep:GetPrimaryAmmoType()]
					local limits = AMMO_LIMITS[string.lower(trans)]
					local ammo = ent:GetAmmoCount(wep:GetPrimaryAmmoType())

					local giveammo = math.Clamp( limits - ammo, 0, math.Round(limits*AMMO_SUPPLY_FACTOR))
					if giveammo > 0 then
						ent:GiveAmmo(giveammo, trans, false)
						ent:EmitSound("items/itempickup.wav")
						ScreenFlash(ent, 155, Color(222, 222, 222))

						hook.Call("OnPlayerSuppliedPlayer", GAMEMODE, ent, self.owner)
						self.taken = true
						self:Remove()
					end
				end
			end
		end
	end
end

if CLIENT then
	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	function ENT:Draw()
		self:DrawModel()

		local sin = 150 + math.abs(math.sin(RealTime()*5)*100)
		self:SetColor(Color(sin,sin,sin))

		local pos = self:GetPos()
		local min, max = self:OBBMins(), self:OBBMaxs()
		local mixvec = Vector(0, 0, 0)
		for i = 1, 3 do
			mixvec[i] = math.Rand(min[i], max[i])
		end
		
		self.emitter = self.emitter or ParticleEmitter(pos)
		if !self.emitTime or self.emitTime < RealTime() then
			local smoke = self.emitter:Add( "sprites/glow04_noz.vmt", pos + mixvec )
			smoke:SetVelocity(VectorRand()*10)
			smoke:SetDieTime(math.Rand(.1,.5))
			smoke:SetStartAlpha(math.Rand(255,255))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(0,2))
			smoke:SetEndSize(math.random(5,11))
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-3,3))
			smoke:SetColor(255,255,255)
			smoke:SetGravity( Vector( 0, 0, math.random(1,50) ) )
			smoke:SetAirResistance(200)

			self.emitTime = RealTime() + .1
		end
	end
end