AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AK-47"
	SWEP.CSMuzzleFlashes = true
end

SWEP.Category = "NPC Weapons"
SWEP.PlayBackRate = 30
SWEP.PlayBackRateSV = 12
SWEP.SpeedDec = 30
SWEP.BulletLength = 5.45
SWEP.CaseLength = 39

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.Base = "nwep_base"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_m4a1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV	= 65
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"

SWEP.FireDelay = 0.2
SWEP.FireSound = Sound("Weapon_M4A1.Single")
SWEP.Recoil = 1

SWEP.Spread = 0.007
SWEP.CrouchSpread = 0.005
SWEP.VelocitySensitivity = 3.5
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 1000
SWEP.DeployTime = 1
SWEP.ReloadTime = 1.75
SWEP.muzScale = .7
SWEP.Shell = 2
SWEP.ShellSize = .8