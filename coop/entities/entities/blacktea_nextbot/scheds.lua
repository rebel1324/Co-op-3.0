-- most common used shit
function ENT:StartWalkAnimation()
	self:StartActivity( self.anim.Walk )    
end

function ENT:StartRunAnimation()
	self:StartActivity( self.anim.Run ) 
end

function ENT:StartIdleAnimation()
	self:StartActivity( self.anim.Idle ) 
end

function ENT:Chase_IsNear(dist)
	return dist < self.attackRange * self.rangeFactor 
end

function ENT:Sched_Attack()
	self:StartIdleAnimation() 
	coroutine.wait(idletime or 1)
end

function ENT:Sched_Chase()
	local enemy = self:GetEnemy()
	if enemy and enemy:IsValid() then
		local trace = self:Trace(enemy)
		local pos = enemy:GetPos() + enemy:OBBCenter() + VectorRand()*10
		if trace.Entity == enemy then
			self.lastPos = pos
			self.memTime = CurTime() + self.rememberTime
		else
			if self.memTime < CurTime() then
				self.moving = false
				self:SetEnemy(nil)
			end
		end

		local dist = self:GetPos():Distance(enemy:GetPos())

		if self:Chase_IsNear(dist) then
			self.moving = false
			self:Sched_Attack()
			coroutine.yield()
		else
			self.moving = true
			self:StartRunAnimation()
			self.loco:SetDesiredSpeed( self.runSpeed )
			self:MoveToPos( pos, { maxage = .3, tolerance = 10} )
		end
	else
		self.moving = false
		coroutine.yield()
	end
end

function ENT:Sched_Wander(idletime)
	local pos
	local spot = self:FindSpot("random",  {radius = 500}) or self:GetPos() + VectorRand()*500

	self:StartWalkAnimation()
	self.loco:SetDesiredSpeed( self.walkSpeed )
	self:MoveToPos( spot, { maxage = 5, tolerance = 10} )
	self:StartIdleAnimation() 
	coroutine.wait(idletime or 1)
end

function ENT:Sched_Runaway(idletime)
	local pos
	local spot = self:FindSpot("random",  {radius = 2500, type = "hide"}) 

	self:StartWalkAnimation()
	self.loco:SetDesiredSpeed( self.walkSpeed )
	self:MoveToPos( spot, { maxage = 5, tolerance = 10} )
	self:StartIdleAnimation() 
	coroutine.wait(idletime or 1)
end

function ENT:Sched_Idle(idletime)
	self:StartIdleAnimation() 
	coroutine.wait(idletime or 1)
end