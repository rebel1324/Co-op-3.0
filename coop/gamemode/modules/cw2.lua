local function initializeCW2() 
	for k, v in ipairs(weapons.GetList()) do
		local class = v.ClassName

		if (AMMO_CONV[v.Primary.Ammo]) then
			v.Primary.Ammo = AMMO_CONV[v.Primary.Ammo]
		end
		
		if (class:find("csgo_m9")) then
			v.Slot = 0
		end

		if (class:find("cw_")) then
				-- Configure Weapon's Variables
				v.CanRicochet = false
				v.isCW2 = true

				function v:recalculateDamage()
					local mult = hook.Run("CalculateDamage", self, self.Owner) or 1

					self.Damage = self.Damage_Orig * self.DamageMult * mult
				end

				function v:recalculateRecoil()
					local mult = hook.Run("CalculateRecoil", self, self.Owner) or 1

					self.Recoil = self.Recoil_Orig * self.RecoilMult * mult
				end

				function v:recalculateFirerate()
					local mult = hook.Run("CalculateFirerate", self, self.Owner) or 1

					self.FireDelay = self.FireDelay_Orig * self.FireDelayMult * mult
				end

				function v:recalculateVelocitySensitivity()
					local mult = hook.Run("CalculateVel", self, self.Owner) or 1

					self.VelocitySensitivity = self.VelocitySensitivity_Orig * self.VelocitySensitivityMult * mult
				end

				function v:recalculateAimSpread()
					local mult = hook.Run("CalculateAimSpread", self, self.Owner) or 1

					self.AimSpread = self.AimSpread_Orig * self.AimSpreadMult * mult
				end

				function v:recalculateHipSpread()
					local mult = hook.Run("CalculateHipSpread", self, self.Owner) or 1

					self.HipSpread = self.HipSpread_Orig * self.HipSpreadMult * mult
				end

				function v:recalculateDeployTime()
					local mult = hook.Run("CalculateDeployTime", self, self.Owner) or 1

					self.DrawSpeed = self.DrawSpeed_Orig * self.DrawSpeedMult * mult
				end

				function v:recalculateReloadSpeed()
					local mult = hook.Run("CalculateReloadSpeed", self, self.Owner) or 1

					self.ReloadSpeed = self.ReloadSpeed_Orig * self.ReloadSpeedMult * mult
				end

				function v:recalculateMaxSpreadInc()
					local mult = hook.Run("CalculateMaxSpread", self, self.Owner) or 1

					self.MaxSpreadInc = self.MaxSpreadInc_Orig * self.MaxSpreadIncMult * mult
				end
		end
	end

	-- Reconfigure Customizable Weaponry in Lua Level
	do
		CustomizableWeaponry.canDropWeapon = false
		CustomizableWeaponry.enableWeaponDrops = false
		CustomizableWeaponry.quickGrenade.enabled = false
		CustomizableWeaponry.quickGrenade.canDropLiveGrenadeIfKilled = false
		CustomizableWeaponry.quickGrenade.unthrownGrenadesGiveWeapon = false
		CustomizableWeaponry.physicalBulletsEnabled = false
		CustomizableWeaponry.customizationEnabled = false

		hook.Remove("PlayerInitialSpawn", "CustomizableWeaponry.PlayerInitialSpawn")
		hook.Remove("PlayerSpawn", "CustomizableWeaponry.PlayerSpawn")
		hook.Remove("AllowPlayerPickup", "CustomizableWeaponry.AllowPlayerPickup")

		if (CLIENT) then
			local up = Vector(0, 0, -100)
			local shellMins, shellMaxs = Vector(-0.5, -0.15, -0.5), Vector(0.5, 0.15, 0.5)
			local angleVel = Vector(0, 0, 0)

			function CustomizableWeaponry.shells:finishMaking(pos, ang, velocity, soundTime, removeTime)
				velocity = velocity or up
				velocity.x = velocity.x + math.Rand(-5, 5)
				velocity.y = velocity.y + math.Rand(-5, 5)
				velocity.z = velocity.z + math.Rand(-5, 5)
				
				time = time or 0.5
				removetime = removetime or 5
				
				local t = self._shellTable or CustomizableWeaponry.shells:getShell("mainshell") -- default to the 'mainshell' shell type if there is none defined

				local ent = ClientsideModel(t.m, RENDERGROUP_BOTH) 
				ent:SetPos(pos)
				ent:PhysicsInitBox(shellMins, shellMaxs)
				ent:SetAngles(ang + AngleRand())
				ent:SetModelScale((self.ShellScale*.9 or .7), 0)
				ent:SetMoveType(MOVETYPE_VPHYSICS) 
				ent:SetSolid(SOLID_VPHYSICS) 
				ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
				
				local phys = ent:GetPhysicsObject()
				phys:SetMaterial("gmod_silent")
				phys:SetMass(10)
				phys:SetVelocity(velocity)
				
				angleVel.x = math.random(-500, 500)
				angleVel.y = math.random(-500, 500)
				angleVel.z = math.random(-500, 500)
				
				phys:AddAngleVelocity(ang:Right() * 100 + angleVel + VectorRand()*50000)

				timer.Simple(time, function()
					if t.s and IsValid(ent) then
						sound.Play(t.s, ent:GetPos())
					end
				end)
				
				SafeRemoveEntityDelayed(ent, removetime)
			end
		end

		do
			if (CLIENT) then
				netstream.Hook("coopUpdateWeapon", function(weapon) if (weapon and weapon:IsValid()) then weapon:recalculateStats() end end)
			end

			function CustomizableWeaponry:hasAttachment(ply, att, lookIn)		
				return true
			end


			CustomizableWeaponry.callbacks:addNew("deployWeapon", "uploadAttachments", function(weapon)
				if (SERVER) then
					timer.Simple(.2, function()
						if (weapon and weapon:IsValid() and weapon.recalculateStats) then
							if (!weapon.attached and weapon:GetClass() == "cw_m14") then
								weapon:attachSpecificAttachment("md_saker")
								weapon:attachSpecificAttachment("md_aimpoint")
								weapon.attached = true
							end

							if (!weapon.attached and weapon:GetClass() == "cw_ar15") then
								weapon:attachSpecificAttachment("bg_ar15heavystock")
								weapon:attachSpecificAttachment("bg_longbarrel")
								weapon:attachSpecificAttachment("md_schmidt_shortdot")
								weapon.attached = true
							end

							if (!weapon.attached and weapon:GetClass() == "cw_g36c") then
								weapon:attachSpecificAttachment("md_eotech")
								weapon:attachSpecificAttachment("md_foregrip")
								weapon.attached = true
							end

							weapon:recalculateStats()
							
							netstream.Start(weapon.Owner, "coopUpdateWeapon", weapon)
						end
					end)
				end
			end)


			CustomizableWeaponry.callbacks:addNew("suppressHUDElements", "wow", function(weapon)
				return true, true, true
			end)
		end
	end
end
hook.Add("PostGamemodeLoaded", "initializeCW2", initializeCW2)


function GM:CalculateReloadSpeed()
	return 1.5
end

function GM:CalculateDamage(self, client)
	if (self:GetClass() == "cw_l115") then
		return 2
	end
end