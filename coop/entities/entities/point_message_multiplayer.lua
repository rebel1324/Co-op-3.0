
ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
	oc.pointmsgs[self:EntIndex()] = oc.pointmsgs[self:EntIndex()] or {}
	if key == "textcolor" then
		local coltbl = string.Explode( " ", value )
		oc.pointmsgs[self:EntIndex()][key] = Color(coltbl[1],coltbl[2],coltbl[3])
	elseif key == "origin" then
		local vectbl = string.Explode( " ", value )
		oc.pointmsgs[self:EntIndex()][key] = Vector(vectbl[1],vectbl[2],vectbl[3])
	else
		oc.pointmsgs[self:EntIndex()][key] = value
	end
 end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "Kill" then
		oc.pointmsgs[self:EntIndex()].nodisp = true
		netstream.Start(player.GetAll(), "oc.PointmsgToggle", self:EntIndex())
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_NEVER
end