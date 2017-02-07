--[[
@PointClass base(Targetname) = logic_player_branch : "On Test, compares the value to the current player count. Returns true if the player count is equal to or larger than the value. If 'Strict Equal To' is set to true, will only output true if the value is exactly equal to the number of players."
[
	spawnflags(flags) =
	[
		1: "Live players only" : 0
	]

	InitialValue(integer) : "Test Value" : 0
	StrictEqualto(choices) : "Strict Equal To?" : 0 =
	[
		0 : "No"
		1 : "Yes"
	]

	// Inputs
	input SetValue(integer) : "Sets the value to compare the current player count to."
	input SetValueTest(integer) : "Sets the value to compare the current player count to, plus tests."
	input Test(void) : "Compares the current player count to the current value, and outputs true or false."

	// Outputs
	output OnTrue(bool) : "Fired when the current player count is greater than or equal to the current value."
	output OnFalse(bool) : "Fired when the current player count is less than the current value."
]
]]
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
end

function ENT:UpdateTransmitState()
	return TRANSMIT_NEVER
end