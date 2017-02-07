--[[
@PointClass base(Targetname, Parentname, EnableDisable) sphere(TriggerRadius) = point_trigger : "Point based trigger.  Use sparingly, as they are processor-intensive."
[
	spawnflags(flags) =
	[
		1: "Clients" : 1
		2: "NPCs" : 0
		4: "Pushables": 0
		8: "Physics Objects" : 0
		16: "Only player ally NPCs" : 0
		32: "Only clients in vehicles" : 0
		64: "Everything" : 0
		512: "Only clients *not* in vehicles" : 0
	]


	TriggerOnce(choices) : "Trigger Type" : 0 =
	[
		0 : "Multiple"
		1 : "Once"
	]
	
	TriggerRadius(float) : "Trigger Radius" : 128 : ""
	filtername(filterclass) : "Filter Name" : : "Filter to use to see if activator triggers me. See filter_activator_name for more explanation."

	// Inputs
	input Toggle(void) : "Toggles this trigger between enabled and disabled states."

	// Outputs
	output OnStartTouch(void) : "Fired when an entity enters the radius of this trigger. The entity must pass this trigger's filters to cause this output to fire."
	output OnEndTouch(void) : "Fired when an entity stops touching this trigger. Only entities that passed this trigger's filters will cause this output to fire."
	output OnEndTouchAll(void) : "Fires when an entity stops touching this trigger, and no other entities are touching it. Only entities that passed this trigger's filters are considered."
]
]]
ENT.Type = "point"

function ENT:Initialize()
	self:SetTrigger(true)
end

local function combareBin(a, b)
    local ab = tostring(math.IntToBin(a))
    local bb = tostring(math.IntToBin(b))
    local al, bl = ab:len(), bb:len()

    -- fuck you i'm lazy 
    if (al > bl) then
        for i = 1, bl do
            local compare = (al - bl) + i
            if (ab[compare] == bb[i] and ab[compare] == "1") then
                return true
            end
        end
    else
        for i = 1, al do
            local compare = (bl - al) + i
            
            if (bb[compare] == ab[i] and bb[compare] == "1") then
                return true
            end
        end
    end

    return false
end

local function splitBins(a)
    local bin = math.IntToBin(a)
    local t = {}

    for i = 1, bin:len() do
        if (bin[i] == "1") then
            t[2^(bin:len() - i)] = true
        end
    end

   	return t
end

local bins = {
	[1] = function(ent) return ent:IsPlayer() end,
	[2] = function(ent) return ent:IsNPC() end,
	[4] = function(ent) return false end,
	[8] = function(ent) return ent:GetClass():find("physics") end,
	[16] = function(ent) return ent:IsNPC() end,
	[32] = function(ent) return ent:IsPlayer() and ent:InVehicle() end,
	[64] = function(ent) return true end,
	[512] = function(ent) return ent:IsPlayer() and !ent:InVehicle() end,
}

function ENT:KeyValue( key, value )
	--print("point_trigger")
	if key == "OnStartTouch" then
		self.touch = self.touch or {}

		local tbl = string.Explode(',', value)
		table.insert(self.touch, tbl)
	elseif key == "OnEndTouch" then
		self.endTouch = self.endTouch or {}

		local tbl = string.Explode(',', value)
		table.insert(self.endTouch, tbl)
	elseif key == "OnEndTouchAll" then
		self.endTouchAll = self.endTouchAll or {}

		local tbl = string.Explode(',', value)
		table.insert(self.endTouchAll, tbl)
	elseif key == "filtername" then
		self.filter = value
	elseif key == "TriggerOnce" then
		self.once = (value == "1" and true or false)
	elseif key == "TriggerRadius" then
		self.radius = value
	else
		--print(self:GetClass(), key, value)
	end

	self.active = true
	self.record = 0
	self.triggered = false
end

function ENT:Touch()
	if (self.triggered and self.once) then
		return
	end

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
	self.triggered = true
end

function ENT:Think()
	if (!self.active) then return end

	local tbl = ents.FindInSphere(self:GetPos(), self.radius or 128)
	local record = {}

	if (self.filter) then
		local filter = ents.FindByName(self.filter)
		local targetName = ""
		for k, v in ipairs(filter) do
			targetName = v:GetKeyValues().filtername
		end
		for k, v in ipairs(tbl) do
			if (v:GetName() == targetName) then
				table.insert(record, v)
			end
		end
	else
		for k, v in ipairs(tbl) do
			if (!self.filter and v:IsPlayer()) then
				table.insert(record, v)
			end
		end
	end

	if (self.record != #record) then
		if (self.record > #record) then
			self:EndTouch()
		elseif (self.record < #record) then
			self:Touch()
		end

		if (self.record > #record and #record == 0) then
			self:EndTouchAll()
		end
	end

	self.record = #record
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "Toggle" then
		self.active = !self.active
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_NEVER
end