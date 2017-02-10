AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CurFOVMod = 0
	SWEP.BobScale = 0
	SWEP.SwayScale = 0
	SWEP.ZoomAmount = 15
	SWEP.FadeOnAim = true
	SWEP.UseHands = true
	SWEP.Adjust = Vector( 0, 0, 0 )
	SWEP.thirdEjectAdjust = Vector( 0, 10, -5 )
end

SWEP.Category = "NPC Weapons"
SWEP.AimMobilitySpreadMod = 0.5
SWEP.PenMod = 1
SWEP.RazborkaWeapon = true
SWEP.Author			= "Black Tea"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "I modded it: Black Tea"

SWEP.ViewModelFOV	= 40
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= ""
SWEP.WorldModel		= ""
SWEP.AnimPrefix		= "fist"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= -1				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"
SWEP.FireDelay		= .02

SWEP.Secondary.ClipSize		= -1				// Size of a clip
SWEP.Secondary.DefaultClip	= -1				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= true				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none"

SWEP.AddSpread = 0
SWEP.SpreadWait = 0
SWEP.AddSpreadSpeed = 1
SWEP.npcSWEP = true
SWEP.minBurst = 3
SWEP.maxBurst = 4

local math = math

hook.Add("Think", "csFix.think", function()
	for k, v in ipairs(ents.GetAll()) do
		if v:IsWeapon() then
			local npc = v.Owner
			if npc and npc:IsValid() then
				if v.npcSWEP and npc:IsPlayer() then
					v:Remove()	
				end

				if v.csFix then
						local act = npc.GetActivity and npc:GetActivity()
						if act and act == 16 then
							--v:RestartGesture( number sequence )
							v:PrimaryAttack()
					end
				end
			else
				if v.npcSWEP then
					v:Remove()
				end
			end
		end
	end
end)

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self.CurCone = self.Spread
	self.nextFire = CurTime()

	if self.Owner and self.Owner:IsValid() and self.Owner:GetClass() == "npc_combine_s" then
		self.csFix = true
	end
end

function SWEP:Think()
	if !self.csFix then
		self:NextThink(CurTime()+.1)
		return true
	end
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if self.nextFire < CurTime() then
		local burst = math.random(self.minBurst, self.maxBurst)
		for i = 1, burst do
			timer.Simple( self.FireDelay*i, function() if self:IsValid() and self.Owner:IsValid() then self:FireBullet(m) end end)
		end

		self.nextFire = CurTime() + self.FireDelay*burst
	end
end

local Dir, Dir2, dot, sp, ent, trace, seed, hm
local bul = {}

local SpreadAng = Angle(0, 0, 0)

function SWEP:FireBullet(m)
	sp = self.Owner:GetShootPos()

	SpreadAng[1] = math.Rand(-self.CurCone, self.CurCone)
	SpreadAng[2] = math.Rand(-self.CurCone, self.CurCone)
	Dir = self.Owner:GetAimVector()
	
	self:EmitSound(self.FireSound)
	netstream.Start(player.GetAll(), "SendMuzzle", self)

	m = m and m or 1
	
	for i = 1, self.Shots * m do
		Dir2 = Dir
		
		if self.ClumpSpread and self.ClumpSpread > 0 then
			Dir2 = Dir + Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * self.ClumpSpread
		end
		
		bul.Num = 1
		bul.Src = sp
		bul.Dir = Dir2
		bul.Spread 	= Vector(0, 0, 0)
		bul.Tracer	= 4
		bul.Force	= self.Damage
		bul.Damage = math.Round(self.Damage)
		
		self.Owner:FireBullets(bul)
	end
end

local ang

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 0.1)
end

if CLIENT then
	local EP, EA2, FT
	local ply, wep

	function SWEP:BeLight( pos )
		local dlight = DynamicLight(self:EntIndex())
			
		dlight.Pos = pos
		dlight.r = 255
		dlight.g = 170
		dlight.b = 0
		dlight.Brightness = 2
		dlight.Size = 128
		dlight.Decay = 512
		dlight.DieTime = CurTime() + 0.02
	end

	netstream.Hook("SendMuzzle", function(dat)
		if dat and dat:IsValid() then
			dat:WorldMuzzleFlash()
			--dat:ShellEject()
		end
	end)

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

			self.delayWorldMuzzle = CurTime() + 0.01
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
			e:SetNormal( atpos.Ang:Up() * 1 )
			e:SetScale( self.muzScale or .2 )
			util.Effect( "muzzleflosh" , e)
			self:BeLight( atpos.Pos )
		end
	end

	function SWEP:ShellEject()
		local e = EffectData()
		e:SetStart( self.ShellAngle or Vector( 0, 0, 0 ) )
		e:SetRadius( self.Shell or 1 )
		e:SetEntity( self )
		e:SetScale( self.ShellSize or 1 )
		e:SetAttachment("2")
		util.Effect( "cusshell" , e)
	end

	function SWEP:FireAnimationEvent(pos,ang,event)
		print(event)
		if event==5001 then
			-- muzzle
			self:ViewMuzzleFlash()
			return (event==5001)
		end
		if event==5003 then
			-- muzzle
			self:WorldMuzzleFlash()
			return (event==5003)
		end
		if event==20 then
			-- shell
			self:ShellEject()
			return (event==20)
		end
	end	

end