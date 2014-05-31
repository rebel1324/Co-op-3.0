AddCSLuaFile()

ENT.Type = "anim"

if SERVER then
	function ENT:Initialize()
		timer.Simple(0, function()
			self.overriden = true

			self.npc = ents.Create("npc_zombie")
			self.npc:SetPos(self:GetPos())
			self.npc:SetAngles(self:GetAngles())
			self.npc:Spawn()
			self.npc:Activate()
			self.npc:SetHealth(150)
			self.npc:SetColor(Color(255,100,100))
		end)
	end

	function ENT:GetPos()
		return self.npc:GetPos()
	end

	function ENT:SetEnemy(ent)
		self.npc:SetEnemy(ent)
	end

	function ENT:MoveOrder(vec)
		self.npc:MoveOrder(vec)
	end

	function ENT:GetAngles()
		return self.npc:GetAngles()
	end

	function ENT:OnDeath()
		self.npc:EmitSound("ambient/explosions/explode_4.wav", 120, math.random(140, 160))

		local effectdata = EffectData()
			effectdata:SetOrigin(self.npc:GetPos())
		util.Effect("HelicopterMegaBomb", effectdata)

		util.BlastDamage(self.npc, self.npc, self.npc:GetPos() + self.npc:OBBCenter(), 128, 50)
	end

	function ENT:Think()
		if !self.npc:IsValid() then
			self:Remove()
		else
			if self.npc:GetNPCState() == NPC_STATE_DEAD then
				self:OnDeath()
				self:Remove()	
			end

			self:NextThink(CurTime()+.2)
			return true
		end
	end

	function ENT:OnRemove()
	end
else
	function ENT:Draw()
	end
end