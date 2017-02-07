--[[

@PointClass base(Targetname, Parentname, EnableDisable) sphere(TriggerRadius) = point_vehiclespawn : "Point trigger that enables vehicle spawning for players that are inside. Use sparingly, as they are processor-intensive."
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

	TriggerRadius(float) : "Trigger Radius" : 128 : ""
	filtername(filterclass) : "Filter Name" : : "Filter to use to see if activator triggers me. See filter_activator_name for more explanation."

	CanSpawnJeep(choices) : "Can Spawn Car Vehicle" : 0 =
	[
		0 : "No"
		1 : "Jeep"
		2 : "Jalopy"
	]

	CanSpawnAirboat(choices) : "Can Spawn Water Vehicle" : 0 =
	[
		0 : "No"
		1 : "Airboat"
	]

	// Inputs
	input Toggle(void) : "Toggles this trigger between enabled and disabled states."
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