ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
	if key == "message" then
		self.message = value
	elseif key == "holdtime" then
		self.holdtime = value
	end
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "Display" then
		for k, v in pairs( player.GetAll() ) do
			SendObjective(v, self.message, self.holdtime or 5)
		end
	end
end
/*
function ENT:UpdateTransmitState()

	return TRANSMIT_NEVER

end
*/