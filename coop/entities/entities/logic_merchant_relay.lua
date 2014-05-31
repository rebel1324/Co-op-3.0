
ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
	if key == "OnPurchased" then
		self.actions = self.actions or {}

		local tbl = string.Explode(',', value)
		table.insert(self.actions, tbl)
	elseif key == "purchasesound" then
		self.sound = value
	elseif key == "CostOf" then
		self.cost = value
	elseif key == "targetname" then
		self.target = value
	elseif key == "PurchaseName" then
		self.name = value
	else
		--print(self:GetClass(), key, value)
	end
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	RequestPurchase(self, inputName, activator, called, data)
end

function ENT:UpdateTransmitState()
	return TRANSMIT_NEVER
end