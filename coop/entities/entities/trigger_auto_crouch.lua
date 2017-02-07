-- @SolidClass base(Trigger) = trigger_auto_crouch : "A trigger volume that let all players inside automatically crouch (duck)" []


ENT.base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()
	self:SetTrigger(true)
end

function ENT:KeyValue( key, value )
end

function ENT:Touch()
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
end

function ENT:UpdateTransmitState()

	return TRANSMIT_NEVER

end