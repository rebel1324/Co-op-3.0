AddCSLuaFile()

if( CLIENT ) then
	SWEP.PrintName = "Knife";
	SWEP.Slot = 0;
	SWEP.SlotPos = 0;
	SWEP.CLMode = 0
end

SWEP.HoldType = "fists"
SWEP.EpiHoldType = "pistol";

SWEP.Category = "Alliance of Valiant Arms Weaponry - Misc"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel = "models/ava/weapons/v_melee_knife.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"

SWEP.SwingDelay = 0.7

SWEP.DamageToEnts1 = 15
SWEP.DamageToEnts2 = 50

SWEP.ForceToEntsSmall = 300
SWEP.ForceToEntsMedium = 140

SWEP.DamageToPlayers1 = 13
SWEP.DamageToPlayers2 = 17

SWEP.Range = 60
SWEP.TimerDelay = 0.1
SWEP.HurtTime = 0

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.7	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 15	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= -1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "none"	--Ammo Type
 
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"

SWEP.ShatterGlass = {
	Sound("physics/glass/glass_impact_bullet1.wav"),
	Sound("physics/glass/glass_impact_bullet2.wav"),
	Sound("physics/glass/glass_impact_bullet3.wav") }
	
function SWEP:Initialize()
	self:SetWeaponHoldType("knife")
end
	
function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	self.Weapon:SetDTBool(1, false)
	return true
end

function SWEP:Think()
	if CurTime() < self.Weapon.HurtTime then -- this way there is no way we miss the entity even though we are in-range but have missed the moment when it was supposed to hit the entity
		local trace = {}
		
		trace.start = self.Owner:GetShootPos()
		trace.endpos = trace.start + self.Owner:GetForward() * self.Weapon.Range
		trace.filter = self.Owner
		trace.mins = Vector(-4, -4, -8)
		trace.maxs = Vector(12, 12, 8)
		
		local trace2 = util.TraceHull(trace)
		if trace2.Entity != NULL then
			if trace2.Entity:IsPlayer() and trace2.Entity:Team() != self.Owner:Team() or trace2.Entity:IsNPC() or trace2.Entity:GetClass() == "prop_ragdoll" then
				if SERVER then
					if (trace2.Entity:GetAimVector():DotProduct(self.Owner:GetAimVector()) > 0.3) then
						trace2.Entity:TakeDamage(500, self.Owner, self.Weapon)
					else
						local dmginfo = DamageInfo()
						dmginfo:SetDamage(math.random(self.Weapon.DamageToPlayers1, self.Weapon.DamageToPlayers2))
						dmginfo:SetDamageType(DMG_CLUB)
						dmginfo:SetAttacker(self.Owner)
						dmginfo:SetInflictor(self.Weapon)
						trace2.Entity:TakeDamageInfo(dmginfo)
					end
					
					self.Owner:EmitSound("weapons/knife/knife_hit" .. math.random(1, 4) .. ".wav", 80, math.random(99, 101))
				end
	
				local ED = EffectData()
				ED:SetStart(trace2.HitPos)
				ED:SetOrigin(trace2.HitPos)
				ED:SetScale(1)
				util.Effect("bloodspray", ED)
				
			elseif trace2.Entity:GetClass() == "func_breakable_surf" then
				if SERVER then
					trace2.Entity:Input("Shatter", NULL, NULL, "")
					self.Owner:EmitSound("weapons/knife/knife_hitwall1.wav", 80, math.random(99, 101))
					self.Owner:EmitSound(table.Random(self.ShatterGlass), 80, math.random(99, 101))
				end
			elseif trace2.Entity:Health() > 0 then
				if SERVER then
					self.Owner:EmitSound("weapons/knife/knife_hitwall1.wav", 80, math.random(99, 101))
					trace2.Entity:TakeDamage(math.random(self.Weapon.DamageToEnts1, self.Weapon.DamageToEnts2), self.Owner, self)
				end
			else
				if SERVER then
					self.Owner:EmitSound("weapons/knife/knife_hitwall1.wav", 80, math.random(99, 101))
				end
			end
			
			local phys = trace2.Entity:GetPhysicsObject()
			
			if phys:IsValid() then
				if phys:GetMass() < 10 then
					phys:AddVelocity(self.Owner:GetForward() * self.Weapon.ForceToEntsSmall)
				elseif phys:GetMass() < 150 then
					phys:AddVelocity(self.Owner:GetForward() * self.Weapon.ForceToEntsMedium)
				end
			end
			self.Weapon.HurtTime = 0
			
		end
		
	end
end

function SWEP:PrimaryAttack()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	
	timer.Simple(self.TimerDelay, function()
		if self.Weapon == nil then
			return
		end
		
		self.Weapon.HurtTime = CurTime() + 0.2
		self.Owner:ViewPunch(Angle(math.random(self.Weapon.DamageToPlayers1, self.Weapon.DamageToPlayers2) * 0.3, math.random(-20, 5), math.random(-2, 2)))
		
		if SERVER then
			self.Owner:EmitSound("weapons/knife/knife_slash" .. math.random(1, 2) .. ".wav", 80, math.random(95, 105))
			if self.Owner.CloakOn then
				self.Owner:SetDTInt(2, 0)
			end
		end
	end)
	
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon.SwingDelay)
end

function SWEP:SecondaryAttack()
	return false
end