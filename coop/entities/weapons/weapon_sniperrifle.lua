AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Sniper Pistol"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 0.6
	SWEP.ZoomAmount = 30
	SWEP.AimPos = Vector(-4.35, -5, 0)
	SWEP.AimAng = Vector(-1, -0, 0)
	SWEP.Adjust = Vector( -2, -10, 1.5 )
	SWEP.KeepCrosshair = true
end

SWEP.Category = "NutScript - Spy Base"
SWEP.PlayBackRate = 25
SWEP.PlayBackRateSV = 12
SWEP.SpeedDec = 30
SWEP.BulletLength = 7.62
SWEP.CaseLength = 54

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.Base = "spy_base"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_deagle.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV	= 65
SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "sniperround"

SWEP.FireDelay = .2
SWEP.FireSound = Sound("Weapon_Deagle.Single")
SWEP.Recoil = 3

SWEP.Spread = 0.005
SWEP.CrouchSpread = 0.0025
SWEP.VelocitySensitivity = 5
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.05
SWEP.SpreadCooldown = .3
SWEP.Shots = 1
SWEP.Damage = 100
SWEP.DeployTime = 1
SWEP.ReloadTime = 1.75
SWEP.muzScale = 1
SWEP.Shell = 1
SWEP.ShellAngle = Vector( -40, -50, -90)
SWEP.ShellSize = 1