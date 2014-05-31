AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Money"
ENT.Author = "Chessnut"
ENT.Category = "NutScript"
ENT.RenderGroup 		= RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props/cs_assault/money.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
  		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

  		self.amount = 0
  		self.life = CurTime() + 30
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
	end

	function ENT:Think()
		if self.life < CurTime() then
			self:Remove()
		end
	end
	
	function ENT:Touch(ent)
		if self.taken != true then
			if (ent:IsValid() and ent:IsPlayer()) then
				ent:GiveMoney(self.amount)
				SendNotify(ent, Format(lang.earnpoint, self.amount))
				self.taken = true
				self:Remove()
			end
		end
	end

	function ENT:Use(activator)
		self:Touch(activator)
	end
else
	function ENT:DrawTranslucent()
	end
	
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
			local smoke = self.emitter:Add( "effects/yellowflare.vmt", pos + mixvec )
			smoke:SetVelocity(VectorRand()*5)
			smoke:SetDieTime(math.Rand(.1,.5))
			smoke:SetStartAlpha(math.Rand(255,255))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(0,2))
			smoke:SetEndSize(math.random(2,4))
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-3,3))
			smoke:SetColor(255,255,255)
			smoke:SetGravity( Vector( 0, 0, 20 ) )
			smoke:SetAirResistance(200)

			self.emitTime = RealTime() + .1
		end
	end
end