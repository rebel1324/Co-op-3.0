ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "SetTimerLabel" then
		self.name = data
	elseif inputName == "StartTimer" then
		PushTimer( self, data, self.name )
	end
end