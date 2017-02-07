--[[
@NPCClass base(BaseNPC) studio() = npc_defender : "Defender - NPC used for Evasion maps."
[
	spawnflags(Flags) =
	[
		65536 :  "No Dynamic Light" : 0
	]

	model(studio) : "Custom Model" : "models/combine_scanner.mdl"
	spotlightlength(integer) : "SpotlightLength" : 500
	spotlightwidth(integer) : "SpotlightWidth" : 50

	spotlightdisabled(choices) : "SpotlightDisabled" : 0 =
	[
		0 : "No"
		1 : "Yes"
	]

	ShouldInspect(choices) : "Should inspect" : 1 =
	[
		0 : "No"
		1 : "Yes"
	]

	OnlyInspectPlayers(choices) : "Only Inspect Players" : 0 =
	[
		0 : "No"
		1 : "Yes"
	]

	NeverInspectPlayers(choices) : "Never Inspect Players" : 0 =
	[
		0 : "No"
		1 : "Yes"
	]

	gibmodel0(studio) : "Gib Model 1" : : "Custom gib model.  Leave blank for default gib."
	gibmodel1(studio) : "Gib Model 2" : : "Custom gib model.  Leave blank for default gib."
	gibmodel2(studio) : "Gib Model 3" : : "Custom gib model.  Leave blank for default gib."
	gibmodel3(studio) : "Gib Model 4" : : "Custom gib model.  Leave blank for default gib."

	// Inputs
	input DisableSpotlight(void) : "DisableSpotlight"
	input InspectTargetSpotlight(string) : "Tells the scanner to spotlight the given entity, named by classname or by target name. !activator or !player works here also."
	input InputSetFlightSpeed(integer) : "Sets the flight speed of the scanner"
	input InputShouldInspect(integer) : "Set whether should inspect or not"
	input SetFollowTarget(string) : "Set target to follow until told otherwise"
	input ClearFollowTarget(void) : "Stop following our target"
	input SetDistanceOverride(float) : "Override the distance the scanner will attempt to keep between inspection targets and itself"
]]

AddCSLuaFile()

ENT.Type = "anim"

if SERVER then
	function ENT:Initialize()
		timer.Simple(0, function()
			self.overriden = true

			self.npc = ents.Create("npc_manhack")
			self.npc:SetPos(self:GetPos())
			self.npc:SetAngles(self:GetAngles())
			self.npc:Spawn()
			self.npc:Activate()
			self.npc:SetHealth(150)
		end)
	end

	function ENT:GetPos()
		return self.npc:GetPos()
	end

	function ENT:GetAngles()
		return self.npc:GetAngles()
	end

	function ENT:Think()
		if !self.npc:IsValid() then
			self:Remove()
		else
			-- think.
			local npc = self.npc
			local target = npc:GetEnemy()
			local phys = npc:GetPhysicsObject()

			if phys and phys:IsValid() then
				phys:SetVelocity(phys:GetVelocity()*2)
			end
			
			if ( target and target:IsValid() ) then
				local dist = target:GetPos():Distance(npc:GetPos())
				local dir = (target:GetPos() + target:OBBCenter()) - (npc:GetPos() + npc:OBBCenter())	
				dir:Normalize()

				if !self.nextAttack or self.nextAttack < CurTime() then
					if dist < 280 then
						if !self.charging then
							self:EmitSound("npc/attack_helicopter/aheli_charge_up.wav", 100, math.random(110, 120))
							self.charging = true
							self.timeCharge = CurTime() + .5
						end

						if !self.timeCharge or self.timeCharge < CurTime() then
							self.nextAttack = CurTime() + 1.5
							self.charging = false

							self:EmitSound("ambient/levels/labs/electric_explosion1.wav", 80, math.random(130, 150))

							if phys and phys:IsValid() then
								phys:SetVelocity(dir*1000*dist/150)
							end
						end
					end
				end
			end

			self:NextThink(CurTime()+.2)
			return true
		end
	end

	function ENT:OnRemove()
		if self.npc and self.npc:IsValid() then
			self.npc:Remove()
		end
	end
else
	function ENT:Draw()
	end
end