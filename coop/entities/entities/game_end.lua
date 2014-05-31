
ENT.Type = "point"

function ENT:Initialize()
	-- print message on something.
end

function ENT:KeyValue( key, value )
	--print(self:GetClass(), key, value)
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	RunConsoleCommand("changelevel", table.Random(MAP_CYCLE))
	--RunConsoleCommand("changelevel", "oc_antlion_attack_01")
end

function ENT:UpdateTransmitState()

	--
	-- The default behaviour for point entities is to not be networked.
	-- If you're deriving an entity and want it to appear clientside, override this
	-- TRANSMIT_ALWAYS = always send, TRANSMIT_PVS = send if in PVS
	--
	return TRANSMIT_NEVER

end