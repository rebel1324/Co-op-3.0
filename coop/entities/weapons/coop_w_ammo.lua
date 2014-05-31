AddCSLuaFile()

if( CLIENT ) then
	SWEP.PrintName = "Ammo Supply";
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
		self:SendWeaponAnim(ACT_VM_THROW)
		self:SetNextPrimaryFire(CurTime() + 2)

		timer.Simple(.3, function()
			self:EmitSound("weapons/slam/throw.wav")

			local e = ents.Create("coop_ammopack")
			e:SetPos(self.Owner:GetPos() + self.Owner:OBBCenter() + self.Owner:GetForward()*25)
			e:SetAngles(AngleRand())
			e:Spawn()
			e.owner = self.Owner 
			
			local phys = e:GetPhysicsObject()
			phys:SetVelocity(self.Owner:GetAimVector()*phys:GetMass()*40)

			timer.Simple(60, function()
				if e:IsValid() then
					e:Remove()
				end
			end)

			self:SendWeaponAnim(ACT_VM_DRAW)
		end)
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

		if !(self.ammo and self.ammo:IsValid()) then
			self.ammo = ClientsideModel("models/bloocobalt/l4d/items/w_eq_fieldkit.mdl", RENDERGROUP_BOTH)
			self.ammo:SetSkin(1)
			self.ammo:SetNoDraw( true )
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

			if self.ammo and self.ammo:IsValid() then
				self.ammo:Remove()
				self.ammo = nil
			end
		end

		return true
	end

	function SWEP:OnRemove()
		self:Holster()
	end

	local ammopos = Vector(2, -2, -2)
	local ammoang = Angle(50, 30, -40)

	function SWEP:ViewModelDrawn()
		if self.ammo and self.ammo:IsValid() then
			local vm = self.Owner:GetViewModel()

			if vm and vm:IsValid() then
				local pos, ang = vm:GetBonePosition(39)
				pos = pos + ang:Forward()*ammopos.x + ang:Up()*ammopos.z + ang:Right()*-ammopos.y
				local ang2 = ang

				ang2:RotateAroundAxis( ang:Right(), ammoang.pitch )
				ang2:RotateAroundAxis( ang:Up(),  ammoang.yaw )
				ang2:RotateAroundAxis( ang:Forward(), ammoang.roll )

				self.ammo:SetRenderOrigin( pos )	
				self.ammo:SetRenderAngles( ang2 )
				self.ammo:DrawModel()
			end
		end

		self:NextThink(CurTime())
		return true
	end
end