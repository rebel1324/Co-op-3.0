AddCSLuaFile()
ENT.Base = "base_entity"
ENT.Type = "anim"

function ENT:Initialize()
	self:SetModel("models/props_junk/garbage_milkcarton002a.mdl")
end

function ENT:KeyValue( key, value )
end

function ENT:Think()
	local wow = self:GetNetworkedVar("texture")
	if (wow) then
		local newMat = CreateMaterial("FUCK_"..wow, "UnlitGeneric",
		{
			["$basetexture"] = wow,
			["$translucent"] = 1,
			["$ignorez"] = 1,
			["$vertexcolor"] = 1,
			["$vertexalpha"] = 1,
		})

		self.wowMat = newMat
	end
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
end

function ENT:Draw()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)

	local wow = self:GetNetworkedVar("texture")
	local mat = Material("FUCK_"..wow)

	if (self.wowMat) then
		cam.Start3D2D(self:GetPos(), ang, 1)
			surface.SetMaterial(self.wowMat)
			surface.SetDrawColor(255, 255, 255, 512)
			surface.DrawTexturedRect(-32, -32, 64, 64)
		cam.End3D2D()
	end

end