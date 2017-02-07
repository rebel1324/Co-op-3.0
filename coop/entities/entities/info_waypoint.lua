--[[
@PointClass base(Targetname, Parentname) iconsprite("editor/info_waypoint.vmt") = info_waypoint : "An entity that creates a waypoint on the hud."
[
	image(sprite) : "Image" : "sprites/attention_waypoint" : "Image that will display on the HUD."
	text(string) : "Text" : : "Text that will show under the icon on the HUD. Should be kept very short."

	// Inputs
	input Enable(float) : "Add the waypoint to all players' HUDs. Input value is the lifetime on the icon on the hud (0/blank lasts until disabled)."
	input EnableForActivator(float) :  "Add the waypoint to the activator's HUD. Input value is the lifetime on the icon on the hud (0/blank lasts until disabled)."
	input Disable(void) : "Remove the waypoint from all players' HUDs."
	input DisableForActivator(void) : "Remove the waypoint from the activator's HUD only."
]
]]

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
		print("parent!!, value!!")
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
		netstream.Start(player.GetAll(), "oc.WaypointToggle", self:EntIndex(), true)
	elseif inputName == "Disable" then
		oc.waypoints[self:EntIndex()].curobj = false
		netstream.Start(player.GetAll(), "oc.WaypointToggle", self:EntIndex(), false)
	elseif inputName == "EnableForActivator" then
		netstream.Start(activator, "oc.WaypointToggle", self:EntIndex(), true)
	elseif inputName == "DisableForActivator" then
		netstream.Start(activator, "oc.WaypointToggle", self:EntIndex(), false)
	end
end