AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

util.AddNetworkString("bt_SetTarget")

function ENT:Initialize()
    self:SetModel("models/combine_turrets/floor_turret.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSequence("idlealert")
	self:SetMoveType(MOVETYPE_NONE)
	self.poseYaw = 0
	self.posePitch = 0
	self.engageReady = CurTime()
	self.nextFire = CurTime()
	self.health = 125
end

function ENT:SetTarget(target)
	self.target = target
	for k, v in pairs(player.GetAll()) do
		netstream.Start(v, "TurretSetTarget", self, target)
	end
end

function ENT:IsInAngle(ent)
	if ent then
		local ang = self:WorldToLocalAngles( (ent:GetPos() - self:GetPos()):Angle() )
			
		return (math.abs(ang.p) <= 20 and math.abs(ang.y) <= 60)
	end
end

function ENT:CanTarget(ent)
	if (ent:IsPlayer()) then
		return true
	end
end

ENT.FindRange = 1500
function ENT:FindTarget()
	if self.target and self.target:IsValid() then
		local data = {}
		data.start = self:GetShootPos()
		data.endpos = self.target:EyePos()
		local filtertbl = player.GetAll()
		table.RemoveByValue(filtertbl, self.target)

		data.filter = filtertbl

		local trace = util.TraceLine(data)

		if trace.Entity != self.target then
			if (self.lost and self.lost < CurTime()) then
				self:SetTarget(nil)
			end
			return
		else
			self.lost = CurTime() + .5
		end
		
		if self.target:GetPos():Distance(self:GetShootPos()) > self.FindRange then
			self:SetTarget(nil)
		end
		
		if !self:IsInAngle(self.target) then
			self:SetTarget(nil)
		end
	else
		for k, v in pairs(player.GetAll()) do
			if !self:CanTarget(v) then continue end
			if v == self or v == self:GetOwner() then continue end	
			
			if v:GetPos():Distance(self:GetShootPos()) <= self.FindRange then
				local data = {}
				data.start = self:GetShootPos()
				data.endpos = v:EyePos()
				data.filter = self
				
				local trace = util.TraceLine(data)
				if trace.Entity == v and self:IsInAngle(v) then
					self:SetTarget(v)
					self.engageReady = CurTime() + self.PrepareTime
					break
				end
			end
		end
	end
end

function ENT:PrimaryAttack()
	--self:ResetSequence("fire")
	self:EmitSound("Weapon_SMG1.NPC_Single")
	local at = self:GetAttachment(1)

	local e = EffectData()
	e:SetEntity( self )
	e:SetScale( .7 )
	util.Effect( "TurretMuzzle" , e)

	local bullet = {
		Attacker = self:GetOwner() or self,
		Damage = math.random(1,2),
		Num = 2,
		Tracer = 2,
		TracerName = "AR2Tracer",
		Dir = at.Ang:Forward(),
		Spread = VectorRand()*.7,
		Src = at.Pos
	}
	self:FireBullets( bullet )
end

function ENT:Explode()
	self:EmitSound("ambient/levels/labs/electric_explosion"..math.random(1,5)..".wav")

	local effectdata = EffectData()
	effectdata:SetStart( self:GetPos() ) // not sure if ( we need a start and origin ( endpoint ) for this effect, but whatever
	effectdata:SetOrigin( self:GetPos() )
	effectdata:SetScale( 1 )
	util.Effect( "HelicopterMegaBomb", effectdata )

	self:Remove()
end

function ENT:setHealth(amount)
	self.health = amount
end
	
function ENT:OnTakeDamage(dmginfo)
	local damage = dmginfo:GetDamage()
	self:setHealth(self.health - damage)

	if (self.health < 0) then
   		if !self.malfunction then
	   		self.malfunction = true
	   		self:SetTarget(nil)

			netstream.Start(player.GetAll(), "TurretMalfunction", self)
	   		timer.Simple(2, function()
	   			self:Explode()
	   		end)
	   	end
	end
end

function ENT:Think()
   	if !self.malfunction then
  	 	self:FindTarget()

	   	if self.target and self.target:IsValid() then
	   		if self.engageReady < CurTime() and self.nextFire < CurTime() then
	   			self.nextFire = CurTime() + .06
	   			self:PrimaryAttack()
	   		end
		end
	end

   	self:TurnTurret()
	
    self:NextThink(CurTime())    
    return true
end