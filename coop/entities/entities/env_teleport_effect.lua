AddCSLuaFile()
ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
	--print(key, value)
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	print("TELEPORT EFFECT")
	print(inputName, data)
end