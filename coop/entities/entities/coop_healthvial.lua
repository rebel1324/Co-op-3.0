if SERVER then
	AddCSLuaFile()
end

ENT.Type = "anim"
ENT.Base = "coop_ammo"
ENT.type = "357"
ENT.amount = 15
ENT.max = 50
ENT.Model = Model("models/healthvial.mdl")

function ENT:Touch(ent)
	if self.taken != true then
		if (ent:IsValid() and ent:IsPlayer()) then
			if ent:Health() < ent:GetMaxHealth() then
				ScreenFlash(ent, 200, Color(100, 250, 100))
				ent:SetHealth(math.Clamp(ent:Health() + 25, 0, 100))
				ent:EmitSound("items/medshot4.wav")

				hook.Call("OnPlayerHealedPlayer", GAMEMODE, ent, self.owner)
				self.taken = true
				self:Remove()
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
			smoke:SetColor(144,255,144)
			smoke:SetGravity( Vector( 0, 0, 10 ) )
			smoke:SetAirResistance(200)	

			self.emitTime = RealTime() + .1
		end	
	end
end