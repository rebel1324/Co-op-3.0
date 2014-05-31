GM.Name = "Co-op 협동 임무 3.0" // Put Gamemode info here
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

print('registered.')
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
	return (ply:Team() != TEAM_DEAD)
end

local a, b = file.Find("coop/gamemode/maps/"..string.lower(game.GetMap())..".lua", "LUA")
for k, v in pairs(a) do
	if v == string.lower(game.GetMap()) .. ".lua" then
		AddCSLuaFile("maps/"..string.lower(game.GetMap())..".lua")
		include("maps/"..string.lower(game.GetMap())..".lua")
	end
end

function CL_FT()
	return math.Clamp(FrameTime(), 1/(60*4), 1)
end