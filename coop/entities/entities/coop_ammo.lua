
--[[

@PointClass base(Item) studio("models/Player/w_helmet.mdl")= item_shield : "Player Shield Device" []
@PointClass base(Item) studio("models/Player/w_cloak.mdl")= item_cloak : "Cloaking Device" []

@PointClass base(Item) studio("models/items/item_gaussammo.mdl")= item_ammo_tau : "Tau Round" []
@PointClass base(Item) studio("models/items/boxalyxrounds.mdl")= item_box_alyxrounds : "Box of Alyx Gun Rounds" []
@PointClass base(Item) studio("models/items/boxsniperrounds.mdl")= item_box_sniper_rounds : "Box of Sniper Rifle Rounds" []

]]

 AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Money"
ENT.Author = "Chessnut"
ENT.Category = "NutScript"
ENT.RenderGroup 		= RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
  		if (self.Model) then
  			self:SetModel(self.Model)
  		end

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
  		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
  		
		if SERVER then
			self:SetTrigger(true)
		end
		self.taken = false

		local physObj = self:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:Wake()
		end
	end

	function ENT:OnRemove()
		if self.respawn and !self.cleanup then
			local class, pos, ang, model, wep, tt, aa = self:GetClass(), self.pos, self.ang, self:GetModel(), self.weapon, self.type, self.amount

			timer.Simple(WEAPON_RESPAWN_TIME, function()
				local ent = ents.Create(class)
				ent:SetModel(model)
				ent:SetPos(pos)
				ent:SetAngles(ang)
				ent:Spawn()
				ent:Activate()
				ent.respawn = true
				ent.type = tt
				ent.amount = aa
				ent.pos = pos
				ent.ang = ang

				local physObj = ent:GetPhysicsObject()
				if (IsValid(physObj)) then
					physObj:Wake()
				end
			end)
		end
	end

	function ENT:Touch(ent)
		if self.taken != true then
			if (ent:IsValid() and ent:IsPlayer()) then

				local used = false
				local plyammo, ammoamt, ammolimit = 0

				if self.type ~= "none" then
					if (self.type) then
						ammolimit = AMMO_LIMITS[self.type] or 200
						plyammo = ent:GetAmmoCount(self.type)
						ammoamt = self.amount or 0
						local giveammo = math.Clamp( ammolimit - plyammo, 0, ammoamt)

						if giveammo > 0 then
							ent:GiveAmmo(giveammo, self.type, false)
							used = true
						end
					end
				end
				
				if used then
					self.taken = true
					self:Remove()
				end
			end
		end
	end

	function ENT:Use(activator)
		self:Touch(activator)
	end
else
	function ENT:DrawTranslucent()
	end
	
	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	function ENT:Draw()
		self:DrawModel()

		local sin = 150 + math.abs(math.sin(RealTime()*5)*100)
		self:SetColor(Color(sin,sin,sin))

		local pos = self:GetPos()
		local min, max = self:GetRotatedAABB(self:OBBMins(), self:OBBMaxs())
		local mixvec = Vector(0, 0, 0)
		for i = 1, 3 do
			mixvec[i] = math.Rand(min[i], max[i])
		end

	end
end