ENT.Base            = "base_anim"
ENT.PrintName = "Ground Turret"
ENT.Author = "Black Tea"
ENT.Category = "Co-op Fagget"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup 		= RENDERGROUP_BOTH

local sndt = {
	channel = CHAN_USER_BASE + 50,
	volume = 1,
	soundlevel = 130,
	pitchstart = 90,
	pitchend = 110,
}
sndt.name = "Turret.Single"
sndt.sound = {
	"weapons/ar2/fire1.wav",
}
sound.Add( sndt )

ENT.PrepareTime = .5
ENT.AutomaticFrameAdvance = true
	
function ENT:GetShootPos()
   local at2 = self:GetAttachment(1)
   
   return at2.Pos
end

function ENT:TurnTurret()

	if self.malfunction then
		self.poseYaw = math.Approach(self.poseYaw, 0, CL_FT() * 33 )
		self.posePitch = math.Approach(self.posePitch, 15, CL_FT() * 33 )	
	else
		if self.target and self.target:IsValid() then
			local origin = self:GetShootPos()
			local tarpos = self.target:LocalToWorld(self.target:OBBCenter())
			local ang = self:WorldToLocalAngles( (tarpos - origin):Angle() )

			self.poseYaw = math.Approach(self.poseYaw, math.Clamp(math.NormalizeAngle(ang.y)*.9, -60, 60), CL_FT() * 100 )
			self.posePitch = math.Approach(self.posePitch, math.Clamp(math.NormalizeAngle(ang.p)*.8, -15, 15), CL_FT() * 100 )
		else
			self.poseYaw = math.Approach(self.poseYaw, math.Clamp(math.sin(RealTime()*1)*45, -60, 60), CL_FT() * 100 )
			self.posePitch = math.Approach(self.posePitch, math.Clamp(0, -15, 15), CL_FT() * 100 )
		end
	end
	
	self:SetPoseParameter("aim_yaw", self.poseYaw)
	self:SetPoseParameter("aim_pitch", self.posePitch)
end