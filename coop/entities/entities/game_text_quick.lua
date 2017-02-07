--[[
@PointClass base(game_text) iconsprite("editor/game_text.vmt") = game_text_quick : "An entity that displays customized text on player's screens."
[
	// Inputs
	input DisplayText(string) : "Display this message text."
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
	if inputName == "DisplayText" then
		oc.quickmsg(data)
	end
end
/*
function ENT:UpdateTransmitState()

	return TRANSMIT_NEVER

end
*/