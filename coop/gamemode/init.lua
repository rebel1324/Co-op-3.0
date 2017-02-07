AddCSLuaFile("language.lua")
AddCSLuaFile("settings.lua")

AddCSLuaFile("modules/von.lua")
AddCSLuaFile("modules/netstream.lua")
AddCSLuaFile("modules/money.lua")
AddCSLuaFile("modules/signal.lua")
AddCSLuaFile("modules/weapons.lua")
AddCSLuaFile("modules/mob.lua")
AddCSLuaFile("modules/3dtext.lua")
AddCSLuaFile("modules/equipments.lua")
AddCSLuaFile("modules/waypoints.lua")
AddCSLuaFile("modules/effects.lua")
AddCSLuaFile("modules/cw2.lua")
AddCSLuaFile("modules/chatbox.lua")
AddCSLuaFile("modules/dev.lua")
AddCSLuaFile("modules/screen.lua")
AddCSLuaFile("derma/icon.lua")
AddCSLuaFile("derma/infobar.lua")
AddCSLuaFile("derma/vendor.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("settings.lua")
include("language.lua")
include("modules/von.lua")
include("modules/sql.lua")
include("modules/triggers.lua")
include("modules/netstream.lua")
include("modules/money.lua")
include("modules/signal.lua")
include("modules/weapons.lua")
include("modules/mob.lua")
include("modules/3dtext.lua")
include("modules/equipments.lua")
include("modules/waypoints.lua")
include("modules/playerclip.lua")
include("modules/aipointhelper.lua")
include("modules/cw2.lua")
include("modules/dev.lua")
include("modules/modparser.lua")
include("shared.lua")
include("player.lua")

-- CUSTOMIZABLE WEAPONRY 2.0
resource.AddWorkshop(349050451)
resource.AddWorkshop(358608166)

-- PLAYER MODELS
resource.AddWorkshop(636790055)
-- CO-OP CONTENTS
resource.AddWorkshop(241429623)

-- HL:Renaissance
resource.AddWorkshop(125988781)
-- COMBINE ASSASIN
resource.AddWorkshop(108511284)

local nextqueue = 0
local msgqueue = {}

function oc.quickmsg(str)
	table.insert(msgqueue, str)
end

function SendNotify(player, str, time)
	local t = time or 2
	netstream.Start(player, "SendNotify", str, t)
end

function ScreenFlash(player, alpha, color, speed)
	netstream.Start(player, "PushFlash", alpha, color, speed)
end

function SendObjective(player, str, time)
	local t = time or 3
	netstream.Start(player, "SendObjective", str, t)
end

function PlayBackgroundSound(player, str)
	netstream.Start(player, "SendPlaySound", str)
end

function PushTimer(object, time, title)
	for k, v in pairs(player.GetAll()) do
		netstream.Start(v, "PushTimer", time, title)
	end
end

function StopTimer()
	for k, v in pairs(player.GetAll()) do
		netstream.Start(v, "StopTimer")
	end
end

function RequestPurchase(ent, input, activator, called, data)
	if (input == "SetPurchaseCost") then return end

	if hook.Call("CanMapPurchase", GAMEMODE, ent, input, activator, called, data) == false then
		return false
	end

	for k, v in pairs(ent.actions) do
		if v[1] == "!self" then
			self:Fire(v[2], v[3], v[4])
		else
			local enttbl = ents.FindByName(v[1])
			for _, target in pairs(enttbl) do
				if v[2] == "Kill" then
					target:EmitSound(ent.sound)
				end

				target:Fire(v[2], v[3], v[4])
			end
		end
	end

	for k, v in pairs(player.GetAll()) do
		local name = ""
		if activator.Name then
			name = activator:Name() .. " "
		end
		SendNotify(v, Format(lang.mappurchase, name, ent.name, ent.cost), 3)
	end

	return true
end

oc.waypoints = oc.waypoints or {}
oc.pointmsgs = oc.pointmsgs or {}

local function messagequeue() -- for fucking obsidian conflict.
	if #msgqueue > 0 then
		if nextqueue < CurTime() then
			nextqueue = CurTime() + .1
		else
			msgqueue = table.Reverse(msgqueue)
			for k, v in ipairs(player.GetAll()) do
				for _, msg in ipairs(msgqueue) do
					v:ChatPrint(msg)
				end
			end
			msgqueue = {}
		end
	end
end

local loots = {
	"coop_healthvial",
	"coop_ammopack",
}

function GM:OnNPCKilled( npc, player, weapon )
	local point = math.random(DEFAULT_POINT_AWARD[1], DEFAULT_POINT_AWARD[2])

	if table.HasValue(DEFAULT_LOOTS_BLACKLIST, npc:GetClass()) then
		return
	end
	
	if player:IsPlayer() then
		player:GiveMoney(point)	

		local amount = math.random(DEFAULT_LOOTS_AMOUNT[1], DEFAULT_LOOTS_AMOUNT[2])
		for i = 1, amount do
			local dice = math.Rand( 1, 100 )

			if dice <= DEFAULT_LOOTS_CHANCE then
				local e = ents.Create(table.Random(loots))
				e:SetPos(npc:GetPos() + npc:OBBCenter())
				e:SetAngles(AngleRand())
				e:Spawn()

				local phys = e:GetPhysicsObject()
				phys:SetVelocity(VectorRand()*phys:GetMass()*20)

				timer.Simple(30, function()
					if e and e:IsValid() then
						e:Remove()
					end
				end)
			end
		end
	end
end

function GM:OnPlayerHealedPlayer(player, healer)
	if !(player and healer and player:IsValid() and healer:IsValid()) then
		return
	end

	if player ~= healer then
		SendNotify(player, Format(lang.healed_msg, healer:Name()), 3)
		SendNotify(healer, Format(lang.healer_msg, player:Name()), 3)
		-- add prize here.
	end
end

function GM:OnPlayerSuppliedPlayer(player, supplier)
	if !(player and supplier and player:IsValid() and supplier:IsValid()) then
		return
	end

	if player ~= supplier then
		SendNotify(supplier, Format(lang.supplied_msg, player:Name()), 3)
		-- add prize here.
	end
end

function GM:EntityTakeDamage( victim, dmginfo )
	local attacker = dmginfo:GetAttacker()
	if attacker:IsValid() then
		if victim:IsPlayer() then
			if attacker:IsPlayer() then
				dmginfo:SetDamage(dmginfo:GetDamage()*0.1)

				if (!victim.nextHurt or victim.nextHurt < CurTime()) then
					victim:EmitSound(Format("vo/npc/%s01/%s.wav", "male", "onyourside"), 100, math.random(90,110))
				end
			end

			if (!victim.nextHurt or victim.nextHurt < CurTime()) then
				victim:EmitSound(Format("vo/npc/%s01/%s.wav", "male", "pain0"..math.random(1,9)), 100, math.random(90,110))
				victim.nextHurt = CurTime() + .5
			end
		end

  		return dmginfo
	end

end

function GM:PlayerDeathThink(player)
	if !player.timeDeath or player.timeDeath < CurTime() then
		player:Spawn()
	end
end

function GM:PlayerDeath(victim, attacker, inflictor)
	victim.timeDeath = CurTime() + 3

	if attacker:IsPlayer() and victim ~= attacker then
		for k, v in pairs(player.GetAll()) do
			SendNotify(v, Format(lang.teamkilled, attacker:Name(), victim:Name()), 5)
		end

		if TEAMKILL_PUNISHMENT == 1 or HARDCORE then
			attacker:Kill()
		end
	end

	if HARDCORE then
		victim.lives = math.Clamp(victim.lives - 1, 0, victim.lives)

		if victim.lives <= 0 then
			victim:SetTeam( TEAM_DEAD )
		else
			SendNotify(victim, Format("Now you have %s lives", victim.lives, ((victim.lives < 2) and "s") or "" ), 5)
		end
	end
end

function GM:ScaleNPCDamage( npc, hitgroup, dmginfo )
	if table.HasValue(TAKEDAMAGE_BLACKLIST, npc:GetClass()) then
		dmginfo:ScaleDamage( 1 / DIFFICULTY - #player.GetAll()/30 )
	else
		dmginfo:ScaleDamage( math.Clamp(1 * (1 - #player.GetAll()/PLAYER_DIFFICULTY_FACTOR * PLAYER_DIFFICULTY_MULTIPLY) / DIFFICULTY, .1, 10) )
	end
	return dmginfo
end

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )
	local damage = 1
	if ( hitgroup == HITGROUP_HEAD ) then
		damage = 2
	elseif ( hitgroup == HITGROUP_LEFTARM or
		hitgroup == HITGROUP_RIGHTARM or 
		hitgroup == HITGROUP_LEFTLEG or
		hitgroup == HITGROUP_RIGHTLEG or
		hitgroup == HITGROUP_GEAR ) then
		damage = .5
	end

	dmginfo:ScaleDamage( 1 + damage * DIFFICULTY * (1 + #player.GetAll()/PLAYER_DIFFICULTY_FACTOR * PLAYER_DIFFICULTY_MULTIPLY) )
	return dmginfo
end

function GM:PlayerUse(ply, ent)
	return (ply:Team() != TEAM_DEAD)
end

function GM:CanPlayerSuicide(ply)
	if ply:Team() == TEAM_DEAD then
		return false
	end

	return ALLOW_SUICIDE
end

function GM:PlayerInitialSpawn( ply )
	firstinit = false
	netstream.Start(ply, "oc.Waypoints", oc.waypoints)
	netstream.Start(ply, "oc.Pointmsgs", oc.pointmsgs)
	
	ply:SetGamemodeTeam( TEAM_ALIVE )
	ply.lives = DEFAULT_LIVES
end

function GM:PlayerLoadout(ply)
	if ply:Team() == TEAM_ALIVE then
		ply:SetNoTarget(false)
		ply:UnSpectate()
		ply:StripWeapons()
		ply:StripAmmo()
		ply:SetNoCollideWithTeammates(true)

		for k, v in pairs(DEFAULT_WEAPONS) do
			ply:Give(v)
		end
	else
		ply:Spectate(OBS_MODE_ROAMING)
		ply:SetNoTarget(true)
	end
end

function GM:PlayerSetModel(ply)
		ply:SetModel(Format("models/player/group01/male_0%d.mdl", math.random(1,9)))
		ply:SetSkin(math.random(1,20))
end

function GM:PlayerAuthed( ply, steamID, uniqueID )
	for k, v in pairs(player.GetAll()) do
		SendNotify(v, Format(lang.ply_join, ply:Name()))
	end
end

hybernated = hybernated or false
function ResetMap()
	for k, v in pairs(ents.GetAll()) do
		v.cleanup = true
	end
	netstream.Start(player.GetAll(), "ClearClientTables")	

	game.CleanUpMap()
	hook.Run("InitPostEntity")
	hook.Run("PostRoundLose")
	print('Server is hybernated, Clearing current game progress.')
end

function GM:PostCleanupMap()
end

GAME_LOST = false
function GM:Think()
	messagequeue()

	if #player.GetAll() == 0 then
		if !hybernated and !firstinit then
			--ResetMap()

			hybernated = true
		end
	else
		hybernated = false
	end

	if HARDCORE then
		local alives = 0
		for k, v in ipairs(player.GetAll()) do
			if v:Team() == TEAM_ALIVE then
				alives = alives + 1
			end
		end

		if #player.GetAll() > 0 and alives == 0 and !GAME_LOST then
			GAME_LOST = true
			netstream.Start(player.GetAll(), "GameLostMusic", 30)	
			PushTimer(nil, 30, "Game is restarting")

			for k, v in ipairs(player.GetAll()) do
				SendObjective(v, "DEFEATED", 30)
			end

			timer.Simple(30, function()
				ResetMap()

				for k, v in ipairs(player.GetAll()) do
					v:SetTeam(TEAM_ALIVE)
					v.lives = DEFAULT_LIVES
					v:Spawn()
				end

				GAME_LOST = false
				hook.Call("PostRoundLose", GAMEMODE)
			end)
		end
	end
end

function EntSaveTable( class )
	local map = string.lower(game.GetMap())

	local tbl = {}
	for k, v in ipairs(ents.FindByClass(class)) do
		table.insert( tbl, {v:GetPos(), v:GetAngles(), v.data or {}} )
	end

	file.CreateDir("coop")
	file.CreateDir("coop/maps")
	file.CreateDir("coop/maps/"..map)
	local encoded = pon.encode(tbl)

	file.Write("coop/maps/"..map.."/"..class..".txt", encoded)
end

function EntLoadTable( class )
	local map = string.lower(game.GetMap())

	local contents 
	local decoded

	if (file.Exists("coop/maps/"..map.."/"..class..".txt", "DATA")) then
		contents = file.Read("coop/maps/"..map.."/"..class..".txt", "DATA")
	end

	if contents then
		decoded = pon.decode(contents)
	end

	if decoded then
		return decoded
	else
		return nil
	end
end

function GM:InitPostEntity()
	for k, v in ipairs(MAP_ENTITIES) do
		local tbl = EntLoadTable(v)

		if tbl then
			for _, d in ipairs(tbl) do
				ent = ents.Create(v)
				ent:SetPos(d[1])
				ent:SetAngles(d[2])
				ent:Spawn()
				ent:Activate()
				ent.data = d[3]
			end
		else
			continue
		end
	end
end


function GM:PlayerSelectSpawn( pl )
	local spawnPoint = hook.Run("MapSpawnPoint", pl)
	if (spawnPoint) then
		return spawnPoint
	end 

	if (!IsTableOfEntitiesValid( self.SpawnPoints )) then
	
		self.LastSpawnPoint = 0
		self.SpawnPoints = ents.FindByClass( "info_player_start" )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_deathmatch" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_combine" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_rebel" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_counterterrorist" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_terrorist" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_axis" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_allies" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "gmod_player_start" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_teamspawn" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "ins_spawnpoint" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "aoc_spawnpoint" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "dys_spawn_point" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_pirate" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_viking" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_knight" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "diprip_start_team_blue" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "diprip_start_team_red" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_red" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_blue" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_coop" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_human" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_zombie" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_zombiemaster" ) )
	end
	
	local Count = table.Count( self.SpawnPoints )
	
	if ( Count == 0 ) then
		Msg("[PlayerSelectSpawn] Error! No spawn points!\n")
		return nil
	end

	for k, v in pairs(self.SpawnPoints) do
		if ( v:HasSpawnFlags(1) && hook.Call( "IsSpawnpointSuitable", GAMEMODE, pl, v, true ) ) then
			return v
		end
	end
	
	local ChosenSpawnPoint = nil
	
	for i = 1, Count do
		ChosenSpawnPoint = table.Random( self.SpawnPoints )

		if ( IsValid( ChosenSpawnPoint ) && ChosenSpawnPoint:IsInWorld() ) then
			if ( ( ChosenSpawnPoint == pl:GetVar( "LastSpawnpoint" ) || ChosenSpawnPoint == self.LastSpawnPoint ) && Count > 1 ) then continue end
			
			if ( hook.Call( "IsSpawnpointSuitable", GAMEMODE, pl, ChosenSpawnPoint, i == Count ) ) then
				self.LastSpawnPoint = ChosenSpawnPoint
				pl:SetVar( "LastSpawnpoint", ChosenSpawnPoint )
				return ChosenSpawnPoint
			end
		end
	end
	
	return ChosenSpawnPoint
end

function GM:WeaponEquip(weapon)
	if (REPLACE_ENTITIES[weapon:GetClass()]) then
		local weaponTable = REPLACE_ENTITIES[weapon:GetClass()]

		timer.Simple(0.1, function()
			local owner = weapon.Owner

			if (owner and owner:IsValid()) then
				local class = table.Random(weaponTable)

				if (owner:HasWeapon(class)) then
					owner:GiveAmmo(10, weapon:GetPrimaryAmmoType(), false)
				else
					owner:Give(class)
				end

				weapon:Remove()
			end
		end)
	end
end

function GM:AcceptInput(entity, input, activator, caller, value )
	if (input:find("spawn")) then
		print(entity, input)
	end
end