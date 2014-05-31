AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "NPC Gear"
ENT.Author = "Black Tea"
ENT.Category = "Co-op NPC"
ENT.RenderGroup = RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_junk/wood_crate001a_chunk03.mdl")
		--self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		--self:SetMoveType(MOVETYPE_VPHYSICS)
  		self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	end
	
	function ENT:Setup(owner, bone)
		self:SetNWEntity("owner", owner)
		self:SetNWString("bone", bone)
		self.Owner = owner

		local b = owner:LookupBone(bone)
		local bp = owner:GetBonePosition(b)
		self:SetPos(bp)
		self:FollowBone(onwer, 1)
		owner:DeleteOnRemove(self)
	end

	function ENT:Think()
		local bone = self:GetNWString("bone")
		local owner = self:GetNWEntity("owner")
		if !owner or !owner:IsValid() then self:Remove() end

		local b = owner:LookupBone(bone)
		if !b then self:Remove() end
		local bp = owner:GetBonePosition(b)
		
		self:AddEFlags(EFL_SETTING_UP_BONES)
		self:SetPos(bp)
		self:FollowBone(onwer, 1)
		self:NextThink(CurTime())
	end

	function ENT:OnRemove()
	end
else
	function ENT:Initialize()
	end

	function ENT:Think()
	end

	function ENT:Draw()
		local p = self:GetNWEntity("owner")
		if p and p:IsValid() then
			local offset = self:GetNWVector("offset")
			--self:SetModelScale(1.7, 0)
			// Add Client Prediction here.
			// Get NW 
			self:DrawModel()
		end
	end
end