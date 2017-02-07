--[[
@PointClass base(Targetname) iconsprite("editor/logic_episodic.vmt") = logic_episodic : "On Test, fires outputs depending which episodic GCFs are active."
[
	StartEnabled(choices) : "Start Enabled?" : 1 =
	[
		0 : "No"
		1 : "Yes"
	]
	
	// Inputs
	input Test(void) : "Checks which episodic GCFs are mounted and fires their outputs."
	input Enable(void) : "Enable so this logic entity can fire outputs."
	input Disable(void) : "Disable so this logic entity cant can fire outputs."

	// Outputs
	output OnEpisode1(bool) : "Fired when the Episode 1 GCFs are mounted."
	output OnEpisode2(bool) : "Fired when the Episode 2 GCFs are mounted."
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