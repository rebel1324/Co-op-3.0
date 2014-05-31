AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Combine Terminal( Object )"
ENT.Author = "Black Tea"
ENT.Category = "Fuck You"
ENT.RenderGroup 		= RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_combine/masterinterface.mdl")
		self:PhysicsInit(SOLID_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetUseType(SIMPLE_USE)
  		//self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	end

	function ENT:Think()
		if self.hacking then
			if self.hacktime < CurTime() then
				self:FireTriggers()
			end
		end
		return true
	end
	
	function ENT:Use(activator)
	end

	function ENT:Disable()
	end

	function ENT:Enable()
	end
else

	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	function ENT:Think()
		self:NextThink(CurTime())
		return true
	end

	function ENT:DrawTranslucent()
	end

	function ENT:Draw()
		self:DrawModel()
	end
end