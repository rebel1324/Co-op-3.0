AddCSLuaFile()

ENT.Type = "anim"

if SERVER then
	function ENT:Initialize()
		timer.Simple(0, function()
			self.overriden = true

			self.npc = ents.Create("npc_manhack")
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
		if !self.npc:IsValid() then
			self:Remove()
		else
			-- think.
			local npc = self.npc
			local target = npc:GetEnemy()
			local phys = npc:GetPhysicsObject()

			if phys and phys:IsValid() then
				phys:SetVelocity(phys:GetVelocity()*2)
			end
			
			if ( target and target:IsValid() ) then
				local dist = target:GetPos():Distance(npc:GetPos())
				local dir = (target:GetPos() + target:OBBCenter()) - (npc:GetPos() + npc:OBBCenter())	
				dir:Normalize()

				if !self.nextAttack or self.nextAttack < CurTime() then
					if dist < 280 then
						if !self.charging then
							self:EmitSound("npc/attack_helicopter/aheli_charge_up.wav", 100, math.random(110, 120))
							self.charging = true
							self.timeCharge = CurTime() + .5
						end

						if !self.timeCharge or self.timeCharge < CurTime() then
							self.nextAttack = CurTime() + 1.5
							self.charging = false

							self:EmitSound("ambient/levels/labs/electric_explosion1.wav", 80, math.random(130, 150))

							if phys and phys:IsValid() then
								phys:SetVelocity(dir*1000*dist/150)
							end
						end
					end
				end
			end

			self:NextThink(CurTime()+.2)
			return true
		end
	end

	function ENT:OnRemove()
		if self.npc and self.npc:IsValid() then
			self.npc:Remove()
		end
	end
else
	function ENT:Draw()
	end
end