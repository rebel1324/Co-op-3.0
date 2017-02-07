--[[

@PointClass base(Targetname) sphere(EatRadius) = point_weapon_eater : "Eats weapons in a radius, Yummy Yummy"
[
	EatRadius(integer) : "Eating Radius" : 256 : "Distance at which I will eat weapons."

	// Inputs
	input Eat(void) : "Nom Nom Nom Yummy. Call me multiple times to fill my hunger."
]]
ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
	if key == "EatRadius" then
		self.eat = value
	end
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "Eat" then
		print("POINT_WEAPON_EATER")
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_NEVER
end