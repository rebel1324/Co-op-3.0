if SERVER then
	AddCSLuaFile()
end

--[[
@PointClass base(Item) studio()= item_custom : "Custom Item"
[
	model(studio) : "Custom Model" : "models/items/boxmrounds.mdl"
	Amount(integer) : "Number of Bullets" : 1 : "Number of Bullets Per"
	AmmoName(string) : "Ammo Name"
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