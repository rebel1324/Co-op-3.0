--[[

@NPCClass base(BaseNPC) studio() = npc_houndeye : "Houndeye"
[
	model(studio) : "Custom Model" : "models/houndeye.mdl"
	followonspawn(choices) : "Follow Player on Use?" : 0 =
	[
		0 : "No"
		1 : "Yes"
	]

	// Inputs
	input follow(void) : "Allow Player Follow"
	input dontfollow(void) : "Disable Player Follow"
]]

AddCSLuaFile()
ENT.Base = "monster_houndeye" 