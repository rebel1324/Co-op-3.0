include('shared.lua')

local EFFECT = {}

function EFFECT:Init( data ) 

	self.Entity = data:GetEntity()
	self.Scale = data:GetScale() or 1
	
	if self.Entity and self.Entity:IsValid() then
   		local at = self.Entity:GetAttachment(1)
		self.Entity.emit = self.Entity.emit or ParticleEmitter( at.Pos )

			
		if at then
			ParticleEffectAttach("muzzleflash_pistol_deagle", PATTACH_POINT_FOLLOW, self.Entity, 1)
		end

		for i=0,2 do
			local Smoke = self.Entity.emit:Add("particle/smokesprites_000"..math.random(1,9), at.Pos )
			Smoke:SetVelocity(120*i*1.5*at.Ang:Forward()*(self.Scale*1.5))
			Smoke:SetDieTime(math.Rand(0.3,1))
			Smoke:SetStartAlpha(math.Rand(11,33))
			Smoke:SetEndAlpha(0)
			Smoke:SetStartSize(math.random(33,44)*self.Scale)
			Smoke:SetEndSize(math.random(40,55)*self.Scale*i)
			Smoke:SetRoll(math.Rand(180,480))
			Smoke:SetRollDelta(math.Rand(-3,3))
			Smoke:SetColor(255,255,255)
			Smoke:SetLighting(true)
			Smoke:SetGravity( Vector( 0, 0, 100 )*math.Rand( .2, 1 ) )
			Smoke:SetAirResistance(250)
		end

		local aang = at.Ang:Forward():Angle()
		aang:RotateAroundAxis( at.Ang:Forward(), 90 )
		for a=1, 2 do
			aang:RotateAroundAxis( at.Ang:Forward(), 180 )
			for i=1, 2 do
				local Gas = self.Entity.emit:Add( "effects/muzzleflash"..math.random(1,4), at.Pos )
				Gas:SetVelocity ( aang:Up()*i*222*self.Scale/1.05  )
				Gas:SetDieTime( math.Rand(0.06, 0.08)  )
				Gas:SetStartAlpha( 80 )
				Gas:SetEndAlpha( 0 )
				Gas:SetStartSize( (11 - i*1.4)*self.Scale )
				Gas:SetEndSize( (25)*self.Scale/2 )
				Gas:SetRoll( math.Rand(0, 360) )
				Gas:SetRollDelta( math.Rand(-50, 50) )			
				Gas:SetAirResistance( 500 ) 			 		
				Gas:SetColor( 255,220,220 )
			end
		end

		for i=2, 4 do
			local Gas = self.Entity.emit:Add( "effects/muzzleflash"..math.random(1,4), at.Pos )
			Gas:SetVelocity ( at.Ang:Forward()*i*300*self.Scale/1.05  )
			Gas:SetDieTime( math.Rand(0.06, 0.08)  )
			Gas:SetStartAlpha( 80 )
			Gas:SetEndAlpha( 0 )
			Gas:SetStartSize( (25 - i*1.4)*self.Scale )
			Gas:SetEndSize( (35 - i*1.3)*self.Scale/2 )
			Gas:SetRoll( math.Rand(0, 360) )
			Gas:SetRollDelta( math.Rand(-50, 50) )			
			Gas:SetAirResistance( 500 ) 			 		
			Gas:SetColor( 255,220,220 )
		end
	end

 end 
   
function EFFECT:Think( )
end

function EFFECT:Render()
end

effects.Register( EFFECT, "TurretMuzzle" )

netstream.Hook("TurretSetTarget", function(ent, target)	
	if ent and ent:IsValid() and target and target:IsValid() then
		ent.engageReady = CurTime() + ent.PrepareTime
	end
	ent.target = target
end)

netstream.Hook("TurretMalfunction", function(data)
	if data and data:IsValid() then
		data:StartMalfunction()
	end
end)

function ENT:Initialize()
	self.poseYaw = 0
	self.posePitch = 0
	self.engageReady = CurTime()
	
	self.idleSound = CreateSound(self, "ambient/levels/canals/manhack_machine_loop1.wav")
	self.alertSound = CreateSound(self, "vehicles/digger_grinder_loop1.wav")
	self.malfuncSound = CreateSound(self, "ambient/levels/labs/teleport_malfunctioning.wav")
	
	self.animFrames = {}
	self.animEvents = {}
end

function ENT:StartMalfunction()
	if self.idleSound then
		self.idleSound:Stop()
	end
	
	if self.alertSound then
		self.alertSound:Stop()
	end

	self.malfuncSound:Play()
	self:EmitSound("npc/scanner/scanner_pain1.wav")
	self.malfunction = true
end


function ENT:Think()
   	self:TurnTurret()

   	if self.malfunction then
   		if !self.smokeEmit or self.smokeEmit < CurTime() then
			self.emit = self.emit or ParticleEmitter( self:GetPos() )

			local smoke = self.Entity.emit:Add("particle/smokesprites_000"..math.random(1,9), self:GetPos() + self:OBBCenter() + self:GetUp()*10 )
			smoke:SetVelocity(33*1.5*Vector(0,0,1)*(1.5))
			smoke:SetDieTime(math.Rand(1,2))
			smoke:SetStartAlpha(math.Rand(88,211))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(22,15))
			smoke:SetEndSize(math.random(40,55))
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-3,3))
			smoke:SetColor(255,255,255)
			smoke:SetLighting(true)
			smoke:SetGravity( Vector( 0, 0, 222 )*math.Rand( .2, 1 ) )
			smoke:SetAirResistance(501)

			self.smokeEmit = CurTime() + .15
		end

   		if !self.sparkEmit or self.sparkEmit < CurTime() then
			self.emit = self.emit or ParticleEmitter( self:GetPos() )

			for i = 1, math.random(1,3) do
				local smoke = self.Entity.emit:Add("effects/spark", self:GetPos() + self:OBBCenter() + self:GetUp()*10 )
				smoke:SetVelocity(VectorRand()*200)
				smoke:SetDieTime(math.Rand(.1,.5))
				smoke:SetStartAlpha(math.Rand(88,211))
				smoke:SetEndAlpha(0)
				smoke:SetStartSize(math.random(1,4))
				smoke:SetEndSize(math.random(0,0))
				smoke:SetStartLength(math.random(7,12))
				smoke:SetEndLength(math.random(0,0))
				smoke:SetColor(255,255,255)
				smoke:SetCollide(true)
				smoke:SetBounce(1)
				smoke:SetGravity( Vector( 0, 0, -600 )*math.Rand( 1.5, 1 ) )
			end

			self.sparkEmit = CurTime() + .1
		end
	else
	   	if self.target and self.target:IsValid() then
	   		-- beeeebeeebee
	    	if self.idleSound then
	    		self.idleSound:Stop()
	    	end
	    	if !self.alertPlayed then
	    		self:EmitSound("vehicles/tank_turret_start1.wav")
	    		self.alertPlayed = true
	    	end
	    	
	   		if self.engageReady < CurTime() then
	   			self.alertSound:Play()
	   		end
	   	else
			self.alertPlayed = false
	    	if self.alertSound then
	    		self.alertSound:Stop()
	    	end
	   		self.idleSound:Play()
	   	end
   	end
end
   	
function ENT:OnRemove()
	if self.idleSound then
		self.idleSound:Stop()
	end
	
	if self.alertSound then
		self.alertSound:Stop()
	end

	if self.malfuncSound then
		self.malfuncSound:Stop()
	end
end
	
local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
local LASER_MATERIAL = Material("effects/laser1.vmt")

function ENT:DrawTranslucent()
   	self:DrawModel()
   	local at = self:GetAttachment(1)
   	local at2 = self:GetAttachment(2)
        
	render.SetMaterial(GLOW_MATERIAL)
	if self.target and self.target:IsValid() then
		render.DrawSprite(at2.Pos + at2.Ang:Forward()*1, 16, 16, Color(255, 0, 0, math.abs(math.sin(RealTime()*30)*255)) )
	elseif self.malfunction then
		render.DrawSprite(at2.Pos + at2.Ang:Forward()*1, 16, 16, Color(255, 0, 0, math.abs(math.sin(RealTime()*2)*255)) )	
	else
		render.DrawSprite(at2.Pos + at2.Ang:Forward()*1, 16, 16, Color(255, 0, 0))
	end
end