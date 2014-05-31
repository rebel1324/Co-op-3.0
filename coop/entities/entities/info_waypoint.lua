
ENT.Type = "point"

function ENT:Initialize()
end

local imgtbl = {
	["sprites/waypoint_move2.vmt"] = 4,
	["sprites/attention_waypoint"] = 3,
}
function ENT:KeyValue( key, value )
	key = string.lower(key)
	oc.waypoints[self:EntIndex()] = oc.waypoints[self:EntIndex()] or {}

	if key == "origin" then
		local vectbl = string.Explode( " ", value )
		oc.waypoints[self:EntIndex()][key] = Vector(vectbl[1],vectbl[2],vectbl[3])
	elseif key == "image" then
		if imgtbl[value] then
			oc.waypoints[self:EntIndex()][key] = imgtbl[value]
		else
			oc.waypoints[self:EntIndex()][key] = value or 2
		end
	elseif key == "parent" then
		--
	else
		oc.waypoints[self:EntIndex()][key] = value
	end
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "Enable" then
		oc.waypoints[self:EntIndex()].curobj = true
		netstream.Start(player.GetAll(), "oc.WaypointToggle", {self:EntIndex(), true})
	elseif inputName == "Disable" then
		oc.waypoints[self:EntIndex()].curobj = false
		netstream.Start(player.GetAll(), "oc.WaypointToggle", {self:EntIndex(), false})
	end
end