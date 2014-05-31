AddCSLuaFile()

if( CLIENT ) then
	SWEP.PrintName = "Merchant Placer";
	SWEP.Slot = 0;
	SWEP.SlotPos = 0;
	SWEP.CLMode = 0
end

SWEP.HoldType = "fists"

SWEP.Category = "Co-op"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

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
	self:SetWeaponHoldType("knife")
end
	
function SWEP:Deploy()
	return true
end

function SWEP:Think()
end

local gridsize = .5

if SERVER then
	function SWEP:PrimaryAttack()
		local trace = self.Owner:GetEyeTraceNoCursor()

		dispencer = ents.Create("coop_dispencer")
		dispencer:SetPos(trace.HitPos:GridClamp(gridsize) + trace.HitNormal*1 )
		dispencer:SetAngles(trace.HitNormal:Angle() - Angle(0, 0, 0))
		dispencer:Spawn()
		dispencer:Activate()

		EntSaveTable("coop_dispencer")
	end

	function SWEP:SecondaryAttack()
		local trace = self.Owner:GetEyeTraceNoCursor()

		if trace.Entity and trace.Entity:IsValid() and trace.Entity:GetClass() == "coop_dispencer" then
			trace.Entity:Remove()

			timer.Simple( .01, function() EntSaveTable("coop_dispencer") end)
		end
		return false
	end
end

if CLIENT then
	function SWEP:Deploy()
		if self.ghost and self.ghost:IsValid() then
			self.ghost:Remove()
		end

		self.ghost = ClientsideModel("models/props_combine/combine_dispenser.mdl")
		self.ghost:SetColor(Color(255,255,255,100))
	end

	function SWEP:Holster()
		if self.Owner and self.Owner:IsValid() then
			if self.ghost and self.ghost:IsValid() then
				self.ghost:Remove()
			end
		end
		return true
	end

	function SWEP:Think()
		if self.ghost and self.ghost:IsValid() then
			local trace = LocalPlayer():GetEyeTraceNoCursor()

			self.ghost:SetPos(trace.HitPos:GridClamp(gridsize) + trace.HitNormal*1)
			self.ghost:SetAngles(trace.HitNormal:Angle() - Angle(0, 0, 0))
		end
	end
end