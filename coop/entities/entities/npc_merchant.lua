--[[

@NPCClass base(TalkNPC, BaseNPC, PlayerCompanion) studio() = npc_merchant : "Merchant NPC"
[
	model(studio) : "Custom Model" : "models/Barney.mdl"
	additionalequipment(choices) : "Weapons" : "Nothing" =
	[
		"0" : "Nothing"
	]

	ExpressionOverride(string) : "Facial expression override"
	MerchantScript(string) : "Merchant Script name"
	MerchantIconMaterial(string) : "Merchant Icon Material" : "sprites/merchant_buy.vmt"
	ShowIcon(choices) : "Show Merchant Icon?" : "1" =
	[
		"0" : "No"
		"1" : "Yes"
	]

	IconHeight(integer) : "Icon Height" : 80 : "Height Above Merchant"

	// Inputs
	input SetExpressionOverride(string) : "Set facial expression override"

	// Outputs
	output OnPlayerUse(void) : "Fires when a player +USEs"
]

]]

AddCSLuaFile()

ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.AutomaticFrameAdvance = true
ENT.SeekRange = 1500

if SERVER then
	function ENT:Initialize()
		--self:SetModel( "models/zombie/poison.mdl" )

		self:SetHullType( HULL_HUMAN );
		self:SetHullSizeNormal();
		self:SetSolid( SOLID_BBOX ) 
		self:SetMoveType( MOVETYPE_STEP )
		self:SetUseType(SIMPLE_USE)
		self:CapabilitiesAdd( CAP_MOVE_GROUND || CAP_ANIMATEDFACE || CAP_TURN_HEAD || CAP_AIM_GUN || CAP_OPEN_DOORS )
		self:SetHealth( 1 )
	end

	function ENT:SelectSchedule(npcState)

	end

	function ENT:KeyValue( key, value )
		if key == "IconHeight" then
		elseif key == "ShowIcon" then
		elseif key == "model" then
			self:SetModel(value)
		elseif key == "npcname" then
			self:SetNetworkedString("name", value)
		elseif key == "MerchantIconMaterial" then
			self.iconMat = value
		elseif key == "MerchantScript" then
			self.script = value
		elseif key == "additionalequipment" then
		elseif key == "OnPlayerUse" then
			self.trigger = self.trigger or {}

			local tbl = string.Explode(',', value)
			table.insert(self.trigger, tbl)
		else
			--print(self:GetClass(), key, value)
		end
	end

	function ENT:AcceptInput( inputName, activator, called, data )
		if inputName == "Use" then
			self.trigger = self.trigger or {}
			for k, v in pairs(self.trigger) do
				if v[1] == "!self" then
					self:Fire(v[2], v[3], v[4])
				else
					local enttbl = ents.FindByName(v[1])
					for _, target in pairs(enttbl) do
						target:Fire(v[2], v[3], v[4])
					end
				end
			end
		end
	end
else
	ENT.RenderGroup = RENDERGROUP_BOTH

	function ENT:Draw()
		self:DrawModel()
	end
end