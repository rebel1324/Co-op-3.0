--[[

@SolidClass base(Trigger) = trigger_multiple_oc : "A trigger volume that can be triggered multiple times."
[
	wait(integer) : "Delay Before Reset" : 1 : "Amount of time, in seconds, after the trigger_multiple has triggered before it can be triggered again. If set to -1, it will never trigger again (in which case you should just use a trigger_once)."

	// Inputs
	input TouchTest(void) : "Tests if the trigger is being touched and fires an output based on whether the value is true or false."

	// Outputs
	output OnTrigger(void) : "Fired whenever the trigger is activated."
	output OnTouching(void) : "Fired when the TestTouch input is true (something is touching the trigger.)"
	output OnNotTouching(void) : "Fired when the TestTouch input is not true (nothing is touching the trigger.)"
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
	elseif key == "OnNotTouching" then
		self.notTouch = self.notTouch or {}

		local tbl = string.Explode(',', value)
		table.insert(self.notTouch, tbl)
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