hook.Add("PlayerBindPress", "eq.hook", function(p, b)
	if b == "undo" then
		netstream.Start("RequestEquipment")
	end
end)

if SERVER then
	local flip = ai_schedule.New("Antlion_DoFlip")
	flip:EngTask("TASK_STOP_MOVING", "0")
	flip:EngTask("TASK_RESET_ACTIVITY", "0")
	flip:EngTask("TASK_PLAY_SEQUENCE", ACT_ANTLION_ZAP_FLIP)

	local playerMeta = FindMetaTable( "Player" )

	function playerMeta:SetEquipment(uid, slot)
		self.nextCooldown = CurTime()
		self.equipments[slot] = uid
	end

	function playerMeta:RemoveEquipments(slot)
		self.nextCooldown = CurTime()
		self.equipments[slot] = nil
	end

	function playerMeta:RemoveEquipments()
		self.nextCooldown = CurTime()
		self.equipments = {}
	end

	EQUIPMENTS_EFFECTS = {}

	EQUIPMENTS_EFFECTS["act_thumper"] = {
		cooldown = 30,
		onused = function(ply)
			ply:EmitSound("coast.thumper_dust")
			ply:EmitSound("doors/vent_open3.wav")
			ply:EmitSound("coast.thumper_hit")

			local e = EffectData()
			e:SetOrigin(ply:GetPos())
			e:SetEntity(ply)
			e:SetScale( 256 )
			util.Effect( "ThumperDust" , e)

			local e = EffectData()
			e:SetOrigin(ply:GetPos())
			e:SetScale( .5 )
			util.Effect( "HelicopterMegaBomb" , e)

			util.ScreenShake( ply:GetPos() + ply:OBBCenter(), 256, 10, 1, 512)
			for k, v in ipairs(ents.FindInSphere(ply:GetPos() + ply:OBBCenter(), 312)) do
				if v:GetClass() == "npc_antlion" or v:GetClass() == "npc_antlionworker" then
					v:SetNPCState(NPC_STATE_SCRIPT)
					v:ResetSequence("Flip1")
					v.isFlipped = CurTime() + 3

					timer.Simple(3.1, function()
						if v and v:IsValid() then
							if v.isFlipped < CurTime() then
								v:SetNPCState(NPC_STATE_ALERT)
							end
						end
					end)
				end
			end
		end,
		onthink = function()

		end
	}

	EQUIPMENTS_EFFECTS["act_killswicth"] = {
		cooldown = 60,
		onused = function(ply)
			ply:EmitSound("coast.thumper_dust")
			ply:EmitSound("coast.thumper_hit")

			local e = EffectData()
			e:SetOrigin(ply:GetPos())
			e:SetEntity(ply)
			e:SetScale( 256 )
			util.Effect( "ThumperDust" , e)

			for k, v in ipairs(ents.FindInSphere(ply:GetPos() + ply:OBBCenter(), 312)) do
				if v:GetClass() == "npc_manhack" then
					v:EmitSound("NPC_Manhack.Stunned")
					v:Fire("InteractivePowerDown", ply, ply, "!activator")

					timer.Simple(2 + math.Rand(0, .5), function()
						if v and v:IsValid() then
							v:EmitSound("NPC_Manhack.Die")
							v:Fire("Break")
						end
					end)
				end
			end
		end,
		onthink = function()

		end
	}

	EQUIPMENTS_EFFECTS["act_lifesaver"] = {
		cooldown = 300,
		onused = function(ply)
			ply:EmitSound("coast.thumper_dust")
			ply:SetHealth(ply:GetMaxHealth())
		end,
		onthink = function()

		end
	}

	EQUIPMENTS_EFFECTS["act_rocketbarrage"] = {
		cooldown = 1,
		onused = function(ply)
			local class = "rpg_missile"

			for i = 1, 8 do
				if !ply:Alive() then break end
				timer.Simple( .1*i, function()
					local rocket = ents.Create(class)
					rocket:SetPos(ply:GetShootPos() + ply:GetAimVector() * 30 + ply:GetAimVector():Angle():Right()*10)
					rocket:SetAngles(ply:GetAimVector():Angle())
					rocket:Spawn()
					rocket.rnd = true
					rocket.rndtime = CurTime() + .1
					rocket.wtf = CurTime() + 2
					rocket:SetSaveValue( "m_flDamage", 150 )
					rocket:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
					rocket:SetVelocity(Vector(0,0,80) + ply:GetAimVector() * 500)
					rocket:SetOwner(ply)
					ply:EmitSound("Weapon_SMG1.Double", 100, math.random(100,111))
				end)
			end

		end,
		onthink = function()

		end
	}

	local equipment 
	local equipdata

	hook.Add("Think", "eq.rocket", function()
		for k, v in ipairs( ents.FindByClass("rpg_missile") ) do
			if v.rnd and v.rndtime < CurTime() then
				v:SetVelocity(v:GetForward()*-5+v:GetRight()*math.Rand(-22,22)+v:GetUp()*math.Rand(-11,11))
			end
		end
	end)

	hook.Add("PlayerDeath", "eq.reset", function(ply)
		ply:RemoveEquipments()
	end)

	hook.Add("ScalePlayerDamage", "eq.hook", function(ply, h, d)
		local dmgscale = 1
		local dmg = d:GetDamage()
		local chest = ply.equipments and ply.equipments[EQUIPMENT_CHEST] 

		if chest == "combat_armor_2" then
			dmgscale = .90
		elseif chest == "combat_armor_2" then
			dmgscale = .80
		elseif chest == "combat_armor_3" then
			dmgscale = .70
		elseif chest == "combat_armor_4" then
			dmgscale = .60
		end
		d:SetDamage( dmg * dmgscale )
	end)

	netstream.Hook("RequestEquipment", function(ply)
		ply.equipments = ply.equipments or {}
		equipment = ply.equipments[EQUIPMENT_ACTIVE]
		equipdata = EQUIPMENTS_EFFECTS[equipment]

		if equipdata then
			if (!ply.nextCooldown or ply.nextCooldown < CurTime()) then
				if equipdata.onused then
					equipdata.onused(ply)
				end
				ply.nextCooldown = CurTime() + equipdata.cooldown
			else
				SendNotify(ply, "You have to wait " .. math.floor(ply.nextCooldown - CurTime()) .. " seconds to use active equipment.", 2)
			end
		else
			SendNotify(ply, "You don't have any active equipment.", 2)
		end
	end)

	netstream.Hook("RequestEquipment_P", function(ply, dat)
		local scan = ents.FindInSphere(ply:GetPos(), 128)
		local near = false
		for k, v in pairs(scan) do
			if v:GetClass() == "coop_dispencer" or v:GetClass() == "npc_merchant" then
				near = v
			end
		end

		local eqdat = MERCHANT_EQUIPMENTS[dat]
		if eqdat and near then
			if ply:CanAfford(eqdat.price) and eqdat.class then
				ply.equipments = ply.equipments or {}

				if (!ply.nextBuy or ply.nextBuy < CurTime()) and !(ply.equipments[eqdat.class] and ply.equipments[eqdat.class] == eqdat.uniqueid) then
					ply:EmitSound("items/ammopickup.wav", 100, math.random(80, 90))
					near:EmitSound("ambient/levels/labs/coinslot1.wav", 100, math.random(110, 150))

					ply:GiveMoney(-eqdat.price)
					if eqdat.uniqueid and eqdat.class then
						ply:SetEquipment(eqdat.uniqueid ,eqdat.class) 
					end

					ply.nextBuy = CurTime() + .5
				end
			else
				ply:EmitSound("buttons/button11.wav")
			end
		end
	end)
end