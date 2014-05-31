AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Grenade"
ENT.Author = "Chessnut"
ENT.Category = "Co-op Weapon Projectile"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Lifetime = 2

local sndt = {}
sndt.name = "Projectile_Grenade.Ting"
sndt.sound = {
	"physics/metal/metal_grenade_impact_hard1.wav",
	"physics/metal/metal_grenade_impact_hard2.wav",
	"physics/metal/metal_grenade_impact_hard3.wav",
}
sndt.channel = CHAN_USER_BASE + 10
sndt.soundlevel = 100
sndt.pitchstart = 33
sndt.pitchend = 44
sound.Add( sndt )

sndt.name = "Projectile_Grenade.Ping"
sndt.sound = {
	"weapons/grenade/tick1.wav",
}
sndt.channel = CHAN_USER_BASE + 50
sndt.soundlevel = 90
sndt.pitchstart = 200
sndt.pitchend = 200
sound.Add( sndt )

sndt.name = "Projectile_Grenade.Boom"
sndt.sound = {
	"ambient/explosions/explode_1.wav",
}
sndt.channel = CHAN_BODY
sndt.soundlevel = SNDLVL_180dB
sndt.pitchstart = 150
sndt.pitchend = 200
sound.Add( sndt )



if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/weapons/ar2_grenade.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
  		self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
		self:PhysicsInitBox( -Vector(1,4,1)*2, Vector(1,4,1)*2 )
  		self.lifetime = CurTime() + self.Lifetime
		self:SetAngles(AngleRand())

		local physObj = self:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:Wake()
			physObj:AddAngleVelocity((self:GetForward() + self:GetRight())*800)
		end
	end
	
	function ENT:OnRemove()
	end

	function ENT:Explode()
		self:EmitSound("Projectile_Grenade.Boom")

		util.ScreenShake( self:GetPos(), 512, 10, 1, 512)
		util.BlastDamage( self, self.Owner or self, self:GetPos() + Vector( 0, 0, 1 ), 256, 50 )

		local effectdata = EffectData()
		effectdata:SetStart( self:GetPos() ) // not sure if ( we need a start and origin ( endpoint ) for this effect, but whatever
		effectdata:SetOrigin( self:GetPos() )
		effectdata:SetScale( 1 )
		util.Effect( "Explosion", effectdata )

		self:Remove()
	end

	function ENT:Think()
		if self.lifetime < CurTime() or self:WaterLevel() > 1 then
			self:Explode()
		end

		for k, v in ipairs(ents.FindByClass("npc_*")) do
			if self:GetPos():Distance(v:GetPos()) < 128 then
				self:Explode()
			end
		end
		// Add proximity effect here.
	end
else
	function ENT:Initialize()
  		self.lifetime = RealTime() + self.Lifetime
	end

	function ENT:Think()
		self.beep = self.beep or 0
		self.beep = RealTime()*10^3%255
		 
		if !self.ping or self.ping < RealTime() then
			self:EmitSound( "Projectile_Grenade.Ping" ) 
			self.ping = RealTime() + math.Clamp(((self.lifetime - RealTime())/self.Lifetime) * 1, .1, .5)
		end
		self:NextThink(CurTime())
	end

	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	function ENT:DrawTranslucent()
		// Add translucent blip here.
		local firepos = self:GetPos() + ( self:GetForward() * 2 )
		local size = self.beep/10
		local col = Color(255, 100, 100, 255 - self.beep)
		render.SetMaterial(GLOW_MATERIAL)
		render.DrawSprite(firepos, size, size, col )
	end
	
	function ENT:Draw()
		self:SetModelScale(1.7, 0)
		self:DrawModel()
	end
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 50 then
		self.Entity:EmitSound( "Projectile_Grenade.Ting" ) 
	end
	
	local impulse = -data.Speed * data.HitNormal * 2 + (data.OurOldVelocity * -0.3)
	phys:ApplyForceCenter(impulse)
end