AddCSLuaFile()

if( CLIENT ) then
	SWEP.PrintName = "Turret Placer";
	SWEP.Slot = 0;
	SWEP.SlotPos = 0;
	SWEP.CLMode = 0
end

SWEP.HoldType = "fists"

SWEP.Category = "Co-op"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.DrawViewModel = false
SWEP.ViewModelFOV	= 55
SWEP.Primary.Delay			= 1
SWEP.Primary.Recoil			= 0	
SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0 	
SWEP.Primary.ClipSize		= -1	
SWEP.Primary.DefaultClip	= -1	
SWEP.Primary.Automatic   	= false	
SWEP.Primary.Ammo         	= "none"
 
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
end

function SWEP:Think()
end

local gridsize = .5

if SERVER then
	function SWEP:Deploy()
		self:SendWeaponAnim(ACT_VM_DRAW)
	end
	
	local skins = {
		"skin_hexaurban",
		"skin_hexawood",
		"skin_leaffall",
		"skin_navalocean",
		"skin_snowwhite",
		"skin_usarmy",
		"skin_woodland",
		"skin_woodtiger",
	}

	function SWEP:PrimaryAttack()
		local data = {}
		data.start = self.Owner:GetShootPos()
		local aimang = self.Owner:EyeAngles()
		aimang.p = 0
		data.endpos = data.start + aimang:Forward()*70 + Vector(0, 0, -100)
		data.mins = Vector(-8, -8, 0)
		data.maxs = Vector(8, 8, 32)
		data.filter = {self.Owner, self}
		local trace = util.TraceHull(data)

		local turret = ents.Create("coop_turret")
		turret:SetPos(trace.HitPos + trace.HitNormal*1)
		turret:SetAngles(aimang)
		turret:Spawn()
		turret:Activate()
		turret:SetOwner(self.Owner)
		turret.lifetime = CurTime() + 120
		turret:EmitSound("npc/scanner/scanner_siren1.wav")

		turret:SetMaterial("blacktea/turretskins/" .. table.Random(skins))

		self.Owner:StripWeapon("coop_w_turret")
		self:SetNextPrimaryFire(CurTime() + 2)
	end

	function SWEP:SecondaryAttack()
	end
end

if CLIENT then
	SWEP.UseHands = false

	function SWEP:Deploy()
		local vm = self.Owner:GetViewModel()
		local pos
		if vm and vm:IsValid() then
			for i = 0, vm:GetBoneCount() do
				if i == 39 then
					pos = vm:GetBonePosition(i)
					vm:ManipulateBoneScale(i, Vector(1,1,1)*.01)
				end
			end
		end

		self:SendWeaponAnim(ACT_VM_DRAW)

		self.ghost = ClientsideModel("models/combine_turrets/floor_turret.mdl", RENDERGROUP_BOTH)
		self.ghost:SetMaterial("Models/Debug/debugwhite")
		self.ghost:SetNoDraw(true)
	end

	function SWEP:Holster()
		if self.Owner and self.Owner:IsValid() then
			local vm = self.Owner:GetViewModel()
			if vm and vm:IsValid() and vm:GetBoneCount() then
				for i = 0, vm:GetBoneCount() do
					if i == 39 then
						pos = vm:GetBonePosition(i)
						vm:ManipulateBoneScale(i, Vector(1,1,1))
					end
				end
			end

			if self.ghost and self.ghost:IsValid() then
				self.ghost:SetNoDraw(true)
				self.ghost:Remove()
				self.ghost = nil
			end
		end

		return true
	end

	function SWEP:Think()
		if self.ghost and self.ghost:IsValid() then
			local data = {}
			data.start = self.Owner:GetShootPos()
			local aimang = self.Owner:EyeAngles()
			aimang.p = 0
			data.endpos = data.start + aimang:Forward()*70 + Vector(0, 0, -100)
			data.mins = Vector(-8, -8, 0)
			data.maxs = Vector(8, 8, 32)
			data.filter = {self.Owner, self}
			local trace = util.TraceHull(data)

			if trace.Hit then
				if trace.HitNormal[3] < .4 then
					self.ghost:SetColor(Color(255,100,100))
				else
					self.ghost:SetColor(Color(100,255,100))
				end

				self.ghost:SetPos(trace.HitPos + trace.HitNormal*1)
				self.ghost:SetAngles(aimang)
				self.ghost:SetNoDraw(false)
			else
				self.ghost:SetNoDraw(true)
			end
		end
	end

	function SWEP:OnRemove()
		self:Holster()
	end

	function SWEP:ViewModelDrawn()
		self:NextThink(CurTime())
		return true
	end
end