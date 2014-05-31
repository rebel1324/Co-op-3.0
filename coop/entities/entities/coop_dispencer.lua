AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Merchant Dispenser"
ENT.Author = "Black Tea"
ENT.Category = "Fuck You"

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_junk/gascan001a.mdl")
		self:PhysicsInit(SOLID_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetUseType(SIMPLE_USE)
  		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

		-- Use prop_dynamic so we can use entity:Fire("SetAnimation")
		self.dummy = ents.Create("prop_dynamic")
		self.dummy:SetModel("models/props_combine/combine_dispenser.mdl")
		self.dummy:SetPos(self:GetPos())
		self.dummy:SetAngles(self:GetAngles())
		self.dummy:SetParent(self)
		self.dummy.blacklist = true
		self.dummy:Spawn()
		self.dummy:Activate()

		self:DeleteOnRemove(self.dummy)
	end

	function ENT:Use(activator)
		netstream.Start(activator, "coop_vendor")
	end
else
	function ENT:Draw()
		if !self.nextBeep or self.nextBeep < CurTime() then
			self:EmitSound("ambient/machines/combine_terminal_idle"..math.random(1,4)..".wav", 70, math.random(80,120))

			self.nextBeep = CurTime() + 5
		end
	end
end