GM.Name = "Co-op 협동 임무 3.0" // Put Gamemode info here
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

team.SetUp( 0, "Spectator", Color(0, 0, 255) )
team.SetUp( 1, "Survived", Color(255, 155, 155) )
team.SetUp( 2, "Dead", Color(55, 55, 55) )

oc = oc or {}

isnpc = isnpc or {}
isnpc.old_meta = isnpc.old_meta or {} local old = isnpc.old_meta

local entityMeta = FindMetaTable("Entity")
old.IsNPC = old.IsNPC or entityMeta.IsNPC

function entityMeta:IsNPC()
	return old.IsNPC(self) or self.nextbot
end

function entityMeta:IsBoss()
	return table.HasValue(BOSSES, self:GetClass())
end

function GM:PlayerNoClip()
	return true
end

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

function GM:EntityKeyValue(entity, key, value)
	--print(entity:GetClass(), key, value)
end

-- Few Vector Fixes
vectorMeta = FindMetaTable("Vector")
function vectorMeta:GridClamp(number)
	local divider = number*10
	if divider <= 0 then
		divider = 1
	end

	for i = 1, 3 do
		self[i] = self[i] / divider
		self[i] = math.Round(self[i])
		self[i] = self[i] * divider
	end

	return self
end

function absminmax( v1, v2 )
	local fv1, fv2 = Vector( 0, 0, 0 ), Vector(0, 0, 0)

	for i = 1,3 do
		if v1[i] > v2[i] then
			fv1[i] = v2[i]
			fv2[i] = v1[i]
		else
			fv1[i] = v1[i]
			fv2[i] = v2[i]
		end
	end

	return fv1, fv2
end

function GM:CanUseFlashlight( ply )
	return true
end

local mapName = string.lower(game.GetMap())
local path = "maps/"

if (mapName:find("oc_")) then
	OBSIDIAN = true
	path = path .. "oc/"
end

if (mapName:find("cs_") or mapName:find("de_")) then
	CSMISSION = true
	path = path .. "cs/"
end

local a, b = file.Find("coop/gamemode/" .. path ..mapName..".lua", "LUA")
for k, v in pairs(a) do
	if v == mapName .. ".lua" then
		AddCSLuaFile(path ..mapName..".lua")
		include(path ..mapName..".lua")
	end
end

function CL_FT()
	return math.Clamp(FrameTime(), 1/(60*4), 1)
end

function GM:PlayerBindPress( pl, bind, down )
	if (bind == "impulse 100") then
		if (down) then
			netstream.Start("toggleFlash")
			if (SERVER) then
			end
		end
	end

	return false
end

if (SERVER) then
	netstream.Hook("toggleFlash", function(client)
		local light = client:GetNetworkedBool("light", false)

		client:EmitSound("items/flashlight1.wav")
		client:SetNetworkedBool("light", !light)
	end)
end


--[[

@NPCClass base(BaseNPC) studio() = monster_alien_controller : "HL1 Alien Controller"
[
	model(studio) : "Custom Model" : "models/controller.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_alien_grunt : "HL1 Alien Grunt"
[
	model(studio) : "Custom Model" : "models/agrunt.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_alien_slave : "HL1 Vortigaunt"
[
	model(studio) : "Custom Model" : "models/islave.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_bigmomma : "HL1 Gonarch"
[
	model(studio) : "Custom Model" : "models/big_mom.mdl"
	crabtype(choices) : "Headcrab Type" : 0 =
	[
		0 : "Classic Headcrab"
		1 : "Poison Headcrab"
		2 : "Fast Headcrab"
		3 : "Random"
	]
	crabname(string) : "Custom name of child headcrabs" : : "Custom name to set on headcrabs spawned by this NPC."
]

@NPCClass base(BaseNPC) studio() = monster_cockroach : "HL1 Cockroach"
[
	model(studio) : "Custom Model" : "models/roach.mdl"

	// Outputs
	output OnSquish(void) : "When cockroach dies / gets squished"
]

@NPCClass base(BaseNPC) studio() = monster_human_assassin : "HL1 Assassin"
[
	spawnflags(Flags) =
	[
		65536 : "Cloak even when not on hard difficulty" : 0
	]

	model(studio) : "Custom Model" : "models/hassassin.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_lightstalk : "HL1 Lightstalk"
[
	model(studio) : "Custom Model" : "models/light.mdl"

	// Outputs
	output OnRise(void) : "When Lightstalk Rises"
	output OnLower(void) : "When Lightstalk Lowers"
]

@NPCClass base(BaseNPC) studio() = monster_tentacle : "HL1 Tentacle"
[
	model(studio) : "Custom Model" : "models/tentacle2.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_snark : "HL1 Snark"
[
	model(studio) : "Custom Model" : "models/w_squeak.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_flyer : "HL1 Flyer"
[
	model(studio) : "Custom Model" : "models/aflock.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_flyer_flock : "HL1 Flyer Flock"
[
	model(studio) : "Custom Model" : "models/aflock.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_scientist : "HL1 scientist"
[
	spawnflags(Flags) =
	[
		268435456 :  "Black Mesa Disaster state?" : 0
	]

	model(studio) : "Custom Model" : "models/scientist.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_sitting_scientist : "HL1 scientist Sitting"
[
	spawnflags(Flags) =
	[
		268435456 :  "Black Mesa Disaster state?" : 0
	]

	model(studio) : "Custom Model" : "models/scientist.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_scientist_dead : "HL1 scientist Dead"
[
	model(studio) : "Custom Model" : "models/scientist.mdl"
]

@NPCClass base(BaseNPC) studio() = monster_gargantua : "Gargantua"
[
	spawnflags(Flags) =
	[
		65536 : "Vulnerable To Bullets" : 0
	]

	model(studio) : "Custom Model" : "models/garg.mdl"
]

]]

--[[


@PointClass base(Weapon) studio("models/weapons/w_gauss.mdl") = weapon_gauss : "Gauss Gun/Tau Cannon" []
@PointClass base(Weapon) studio("models/weapons/w_manhack.mdl") = weapon_manhack : "Manhack Weapon" []
//@PointClass base(Weapon) studio("models/weapons/w_hopwire.mdl") = weapon_hopwire : "Hopwire Ball" []
@PointClass base(Weapon) studio("models/weapons/w_pistol.mdl") = weapon_scripted : "Scripted Weapon" []
@PointClass base(Weapon) studio("models/weapons/w_slam.mdl") = weapon_slam : "SLAM" []
@PointClass base(Weapon) studio("models/weapons/w_uzi_r.mdl") = weapon_uzi : "A Single Uzi" []
@PointClass base(Weapon) studio("models/weapons/w_sniper.mdl") = weapon_sniperrifle : "Sniper Rifle" []
@PointClass base(Weapon) studio("models/weapons/w_sniper.mdl") = weapon_healer : "Sniper Rifle" []
]]