--[[


@SolidClass base(TriggerOnce) = trigger_once_oc : "A trigger volume that removes itself after it is triggered once."
[
	// Outputs
	output OnTrigger(void) : "Fired whenever the trigger is activated."
]


]]
ENT.base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()
	self:SetTrigger(true)
end

function ENT:KeyValue( key, value )
	if key == "OnStartTouch" then
		self.trigger = self.trigger or {}

		local tbl = string.Explode(',', value)
		table.insert(self.trigger, tbl)
	elseif key == "OnTrigger" then
		self.trigger = self.trigger or {}

		local tbl = string.Explode(',', value)
		table.insert(self.trigger, tbl)
	end
end

function ENT:Touch()
	self.trigger = self.trigger or {}
	for k, v in pairs(self.trigger) do
		if v[1] == "!self" then
			self:Fire(v[2], v[3], v[4])
		else
			local enttbl = ents.FindByName(v[1])
			for _, target in pairs(enttbl) do
				target:Fire(v[2], v[3], v[4])
			end
		end
	end

	self:Remove()
end

/*
function ENT:Touch()
	self.touch = self.touch or {}
	for k, v in pairs(self.touch) do
		if v[1] == "!self" then
			self:Fire(v[2], v[3], v[4])
		else
			local enttbl = ents.FindByName(v[1])
			for _, target in pairs(enttbl) do
				target:Fire(v[2], v[3], v[4])
			end
		end
	end

	self:Remove()
end
*/

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "Enable" then
		self.trigger = self.trigger or {}
		for k, v in pairs(self.trigger) do
			if v[1] == "!self" then
				self:Fire(v[2], v[3], v[4])
			else
				local enttbl = ents.FindByName(v[1])
				for _, target in pairs(enttbl) do
					target:Fire(v[2], v[3], v[4])
				end
			end
		end
		
		self:Remove()
	end
end

function ENT:UpdateTransmitState()

	return TRANSMIT_NEVER

end