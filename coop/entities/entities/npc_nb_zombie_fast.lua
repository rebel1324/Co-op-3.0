ENT.Base            = "blacktea_nextbot"
ENT.PrintName = "Basic Zombie"
ENT.Author = "Black Tea"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.searchDist = 1000
ENT.attackRange = 100
ENT.attackDamage = 50
ENT.attackDelay = 1
ENT.rangeFactor = .5

ENT.runSpeed = 200
ENT.walkSpeed = 66

ENT.anim = {}
ENT.anim.Walk = ACT_HL2MP_WALK_ZOMBIE_01
ENT.anim.Run = ACT_HL2MP_WALK_ZOMBIE_01
ENT.anim.Idle = ACT_HL2MP_WALK_ZOMBIE_01

function ENT:Initialize()
    self:SetModel("models/player/zombie_classic.mdl");
	self:SetHealth(self.health)
 
	self.loco:SetDeathDropHeight(200)	//default 200
	self.loco:SetAcceleration(200)		//default 400
	self.loco:SetDeceleration(1500)		//default 400
	self.loco:SetStepHeight(32)			//default 18
	self.loco:SetJumpHeight(130)		//default 58

	self:SetCustomCollisionCheck(true)
	self:SetCollisionGroup(9)
	self:SetMoveType(3)
	self:SetCollisionBounds( Vector(-4,-4,0), Vector(4,4,64) )
end

function ENT:PhysicsCollide()
	print(1)
end

hook.Add("ShouldCollide", "checkbsp", function(ent1, ent2)
	print(ent1, ent2
		)
end)

function ENT:StartRunAnimation()
	self:ResetSequence( "zombie_run" )    
end

function ENT:StartIdleAnimation()
	self:ResetSequence( "zombie_run" )    
end

function ENT:MeleeAttack( dmg, reach )
	
end

function ENT:Sched_Attack()
	self:StartIdleAnimation() 
	self:RestartGesture( ACT_GMOD_GESTURE_RANGE_ZOMBIE )  
	self.loco:FaceTowards( self:GetEnemy():GetPos() )

	self:EmitSound("npc/zombie/zo_attack" .. math.random(1, 2) .. ".wav")

	if self:GetDot(self:GetEnemy()) < -0.8 then
		timer.Simple( .4, function()
			if not ( self:IsValid() ) then return end
			if self:GetEnemy():IsValid() then
				if self:GetDot(self:GetEnemy()) < -0.8 and self:GetPos():Distance(self:GetEnemy():GetPos()) < 100 then
					local trace = self:Trace(self:GetEnemy())
					if trace.Entity and trace.Entity:IsValid() then
						trace.Entity:TakeDamage(10, self, self)
					end
				end

				self:EmitSound("weapons/slam/throw.wav")
			end
		end)

		coroutine.wait(idletime or .7)
	end
	
	coroutine.wait(.1)
end

function ENT:OnInjured()
	self:EmitSound( "npc/zombie/zombie_pain" .. math.random( 1, 6 ) .. ".wav" )
end
