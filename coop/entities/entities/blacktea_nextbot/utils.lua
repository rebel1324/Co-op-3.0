local function center( ent )
	return ent:GetPos() + ent:OBBCenter()
end

function ENT:Trace( target )
	local vecPosition = center( self )
	local vecPosition2 = center( target )
	local tracedata = {}
	tracedata.start = vecPosition
	tracedata.endpos = vecPosition2
	tracedata.filter = { self }
	local trace = util.TraceLine(tracedata)
	return trace
end

function ENT:IsEnemy(ent)
	if ent:IsPlayer() then
		return ent:Alive()
	end
	return false
end

function ENT:GetNearestTarget()
	local neardist = math.huge
	local nearest
	local dist = 0
	local trace

	for _, ent in ipairs(ents.GetAll()) do
		if self:IsEnemy(ent) then
			dist = ent:GetPos():Distance(ent:GetPos())
			if dist < self.searchDist and dist < neardist then
				trace = self:Trace(ent)
				if trace.Entity == ent then
					neardist = dist
					nearest = ent
				end
			end
		end
	end

	return nearest
end

function ENT:GetDot(ent)
	local vec 
	vec = ( self:GetPos() - ent:GetPos() )
	vec:Normalize()
	return vec:Dot( self:GetAngles():Forward() )
end
function ENT:ForgetPosition()
	self.lastPos = nil
end