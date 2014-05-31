AddCSLuaFile()

if( CLIENT ) then
	SWEP.PrintName = "Medic Supply";
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
	
	function SWEP:PrimaryAttack()
		self:SetNextPrimaryFire(CurTime() + 2)

		if !self.nextThrow or self.nextThrow < CurTime() then
			self:SendWeaponAnim(ACT_VM_THROW)

			self.nextThrow = CurTime() + 30

			timer.Simple(.3, function()
				self:EmitSound("weapons/slam/throw.wav")

				local e = ents.Create("coop_healthvial")
				e:SetPos(self.Owner:GetPos() + self.Owner:OBBCenter() + self.Owner:GetForward()*25)
				e:SetAngles(AngleRand())
				e:Spawn()
				e.owner = self.Owner 

				local phys = e:GetPhysicsObject()
				phys:SetVelocity(self.Owner:GetAimVector()*phys:GetMass()*250)

				timer.Simple(60, function()
					if e:IsValid() then
						e:Remove()
					end
				end)

				self:SendWeaponAnim(ACT_VM_DRAW)
			end)
		else
			SendNotify(self.Owner, "Please wait " .. math.ceil(self.nextThrow - CurTime()) .. " seconds to throw next vial.")
		end

		return true
	end

	function SWEP:SecondaryAttack()
	end
end

if CLIENT then
	SWEP.UseHands = false

	function SWEP:Deploy()
		local vm = self.Owner:GetViewModel()
		local pos
		for i = 0, vm:GetBoneCount() do
			if i == 39 then
				pos = vm:GetBonePosition(i)
				vm:ManipulateBoneScale(i, Vector(1,1,1)*.01)
			end
		end

		self:SendWeaponAnim(ACT_VM_DRAW)

		if !(self.vial and self.vial:IsValid()) then
			self.vial = ClientsideModel("models/healthvial.mdl", RENDERGROUP_BOTH)
			self.vial:SetNoDraw( true )
		end
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

			if self.vial and self.vial:IsValid() then
				self.vial:Remove()
				self.vial = nil
			end
		end

		return true
	end

	function SWEP:OnRemove()
		self:Holster()
	end

	local vialpos = Vector(.1, .2, -5)
	local vialang = Angle(0, 180, 0)

	function SWEP:ViewModelDrawn()
		if self.vial and self.vial:IsValid() then
			local vm = self.Owner:GetViewModel()

			if vm and vm:IsValid() then
				local pos, ang = vm:GetBonePosition(39)
				pos = pos + ang:Forward()*vialpos.x + ang:Up()*vialpos.z + ang:Right()*-vialpos.y
				local ang2 = ang

				ang2:RotateAroundAxis( ang:Right(), vialang.pitch )
				ang2:RotateAroundAxis( ang:Up(),  vialang.yaw )
				ang2:RotateAroundAxis( ang:Forward(), vialang.roll )

				self.vial:SetRenderOrigin( pos )	
				self.vial:SetRenderAngles( ang2 )
				self.vial:DrawModel()
			end
		end

		self:NextThink(CurTime())
		return true
	end
end