
--[[
@NPCClass base(BaseNPC) studio() = npc_mortarsynth : "Mortar Synth"
[
	model(studio) : "Custom Model" : "models/mortarsynth.mdl"
]
]]
AddCSLuaFile()

ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.AutomaticFrameAdvance = true
ENT.SeekRange = 1500

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/zombie/poison.mdl" )

		self:SetHullType( HULL_HUMAN );
		self:SetHullSizeNormal();
		self:SetSolid( SOLID_BBOX ) 
		self:SetMoveType( MOVETYPE_STEP )
		self:CapabilitiesAdd( CAP_MOVE_GROUND || CAP_ANIMATEDFACE || CAP_TURN_HEAD || CAP_AIM_GUN || CAP_OPEN_DOORS )
		self:SetHealth( 1 )
	end

	function ENT:SelectSchedule(npcState)

	end

else
	ENT.RenderGroup = RENDERGROUP_BOTH

	function ENT:Draw()
		self:DrawModel()
	end
end