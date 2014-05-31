ENT.Type = "brush"

function ENT:Initialize()
	self:SetTrigger(true)
end

function ENT:KeyValue( key, value )
	if key == "OnStartTouch" then
		self.touch = self.touch or {}

		local tbl = string.Explode(',', value)
		table.insert(self.touch, tbl)
	elseif key == "OnTrigger" then
		self.trigger = self.trigger or {}

		local tbl = string.Explode(',', value)
		table.insert(self.trigger, tbl)
	else
		--print(self:GetClass(), key, value)
	end
end

function ENT:OnTrigger()
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
end

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
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "Enable" then
		self:OnTrigger()
	elseif inputName == "Disable" then
	end
end

function ENT:UpdateTransmitState()

	--
	-- The default behaviour for point entities is to not be networked.
	-- If you're deriving an entity and want it to appear clientside, override this
	-- TRANSMIT_ALWAYS = always send, TRANSMIT_PVS = send if in PVS
	--
	return TRANSMIT_NEVER

end