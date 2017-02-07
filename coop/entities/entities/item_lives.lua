if SERVER then
	AddCSLuaFile()
end

--[[
@PointClass base(Item) studio("models/healthvial.mdl")= item_lives : "Item to give or take the specified amount of lives to players who touch it."
[
	livestogive(integer) : "Number of lives to give" : 1 : "A negative number can be used here to take lives instead of give them."
]
]]
ENT.Type = "anim"
ENT.Base = "coop_ammo"
ENT.type = "357"
ENT.amount = 15
ENT.max = 50
ENT.Model = "models/healthvial.mdl"

function ENT:Touch(ent)

end

if CLIENT then
	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	function ENT:Draw()
		self:DrawModel()
	end
end