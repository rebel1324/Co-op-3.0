AddCSLuaFile()

if( CLIENT ) then
	SWEP.PrintName = "Box Helper";
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

local gridsize = 1

if SERVER then
	function SWEP:PrimaryAttack()
	end

	function SWEP:Reload()
	end

	function SWEP:SecondaryAttack()
	end
end

if CLIENT then
	function SWEP:PrimaryAttack()
		if IsFirstTimePredicted() then
			if !self.min then
				local trace = LocalPlayer():GetEyeTraceNoCursor()
				self.min = trace.HitPos
				self:EmitSound("HL1/fvox/blip.wav")
				AddNotice( "Click again to get box vector.", 5 )
			else
				local trace = LocalPlayer():GetEyeTraceNoCursor()
				local pos = trace.HitPos
				self:EmitSound("HL1/fvox/blip.wav")
				SetClipboardText( Format("Vector(%s, %s, %s), Vector(%s, %s, %s)", self.min.x, self.min.y, self.min.z, pos.x, pos.y, pos.z) )
				AddNotice( "min, max vectors are copied to the clipboard.", 5 )
				self.min = nil
			end
		end
	end

	function SWEP:SecondaryAttack()
		if IsFirstTimePredicted() then
			if !self.nextText or self.nextText < CurTime() then
				local trace = LocalPlayer():GetEyeTraceNoCursor()
				local pos = trace.HitPos
				AddNotice( "the position where you're looking at is copied to the clipboard.", 5 )
				self:EmitSound("HL1/fvox/blip.wav")
				SetClipboardText( Format("Vector(%s, %s, %s)", pos.x, pos.y, pos.z) )
				self.nextText = CurTime() + 1
			end
		end
		return false
	end
end