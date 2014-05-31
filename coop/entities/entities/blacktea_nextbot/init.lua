AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/mossman.mdl");
	self:SetHealth(20)
 	
	self.loco:SetDeathDropHeight(200)	//default 200
	self.loco:SetAcceleration(400)		//default 400
	self.loco:SetDeceleration(900)		//default 400
	self.loco:SetStepHeight(35)			//default 18
	self.loco:SetJumpHeight(100)		//default 58
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
	self.Entity:SetCollisionBounds( Vector(-4,-4,0), Vector(4,4,64) )
end

function ENT:IsNPC()
	return true
end

function ENT:SetTarget(ent)
	if ent:IsValid() then
		self.target = ent
	end
end

function ENT:SetEnemy(ent)
	if ent and ent:IsValid() then
		self.target = ent
	else
		self.target = nil
	end
end

function ENT:GetTarget()
	return self.target
end

function ENT:GetEnemy()
	return self.target
end

function ENT:ForgetEnemy()
end

function ENT:OnStateUpdate()
end

function ENT:OnPlayerSpotted()
end

function ENT:OnRemoved()
end

function ENT:OnDeath()
end

function ENT:OnPlayerLost()
end

function ENT:BodyUpdate()
	local act = self:GetActivity()
	local seq = self:GetSequenceName( self:GetSequence() )
	if ( act == ACT_HL2MP_WALK_ZOMBIE_01 || act == ACT_HL2MP_RUN_FIST || act == ACT_HL2MP_RUN_FAST || seq == "zombie_run" ) then
		self:BodyMoveXY()
	end
	self:FrameAdvance()
end

function ENT:RunBehaviour()
     while ( true ) do
     	local target = self:GetNearestTarget()
     	if target and target:IsValid() then
     		self:SetEnemy(target)
     	end

     	if self:GetEnemy() then
     		self:Sched_Chase()
     	else
     		self:Sched_Wander(.1)
     	end

		coroutine.yield()
    end
end