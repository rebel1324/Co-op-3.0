
ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
	print(self:GetClass(), key, value)
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "Command" then
		for k, v in pairs(player.GetAll()) do
			if (data:find("sk_")) then
				print("SERVER CONFIG CHANGED: " .. data)
				local wow = string.Explode(wow)
				--RunConsoleCommand(wow[1], wow[2], wow[3])
			end
		end
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_NEVER
end