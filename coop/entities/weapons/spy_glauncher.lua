AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MGL-10 Grenade Launcher"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 0.6
	SWEP.ZoomAmount = 20
	SWEP.AimPos = Vector(-6.5, -9, -.5)
	SWEP.AimAng = Vector(0, 0, 0)
end

SWEP.Category = "NutScript - Spy Base"
SWEP.PlayBackRate = 30
SWEP.PlayBackRateSV = 12
SWEP.SpeedDec = 50
SWEP.BulletLength = 5.1
SWEP.CaseLength = 1

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.Base = "spy_base"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/c_smg1.mdl"
SWEP.WorldModel		= "models/weapons/w_smg1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV	= 60
SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1_grenade"

SWEP.FireDelay = 0.7
SWEP.FireSound = Sound("Weapon_SMG1.Double")
SWEP.Recoil = 5

SWEP.Spread = 0.007
SWEP.CrouchSpread = 0.005
SWEP.VelocitySensitivity = 3.5
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 30
SWEP.DeployTime = 2
SWEP.ReloadTime = 5
SWEP.muzScale = .4

// Reproduction.
local reg = debug.getregistry()
local GetShootPos = reg.Player.GetShootPos
local GetCurrentCommand = reg.Player.GetCurrentCommand
local CommandNumber = reg.CUserCmd.CommandNumber

function SWEP:FireBullet(m)
	if SERVER then
		sp = GetShootPos(self.Owner)
		math.randomseed(CommandNumber(GetCurrentCommand(self.Owner)))

		Dir = (self.Owner:EyeAngles() + self.Owner:GetPunchAngle()):Forward()

		local gren = ents.Create("proj_grenade")
		gren:SetPos(sp - Dir*15)
		gren:Spawn()
		gren:Activate()
		gren:SetOwner(self.Owner)

		local phys = gren:GetPhysicsObject()
		phys:SetVelocity(Dir*1200)
	end
end

function SWEP:ViewMuzzleFlash()
	if !self.Owner:ShouldDrawLocalPlayer() then
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		local at = vm:LookupAttachment( "1" )
		local atpos = vm:GetAttachment( at )
		local e = EffectData()
		e:SetOrigin( atpos.Pos )
		e:SetNormal( atpos.Ang:Up() * -1 )
		e:SetScale( self.muzScale or .2 )
		util.Effect( "muzzleflosh" , e)
	end
end

function SWEP:WorldMuzzleFlash()
	if !self.delayWorldMuzzle or self.delayWorldMuzzle < CurTime() then
		local at = self:LookupAttachment( "muzzle" )
		local atpos = self:GetAttachment( at )
		local e = EffectData()
		e:SetOrigin( atpos.Pos )
		e:SetNormal( atpos.Ang:Forward() * 1 )
		e:SetScale( self.muzScale/2 or .1 )
		util.Effect( "muzzleflosh" , e)
		self:BeLight( atpos.Pos )
	end
end