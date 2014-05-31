AddCSLuaFile()

ENT.Type = "anim"

if SERVER then
	function ENT:Initialize()

		self.npc = ents.Create("npc_combine_s")
		self.overriden = true
		timer.Simple(0, function()

			self.npc:SetPos(self:GetPos())
			self.npc:SetAngles(self:GetAngles())
			self.npc:Spawn()
			self.npc:Activate()
			self.npc:SetHealth(150)
		end)
	end

	function ENT:GetPos()
		return self.npc:GetPos()
	end

	function ENT:GetAngles()
		return self.npc:GetAngles()
	end

	function ENT:Think()
	end

	function ENT:OnRemove()
	end
else
	function ENT:Draw()
	end
end