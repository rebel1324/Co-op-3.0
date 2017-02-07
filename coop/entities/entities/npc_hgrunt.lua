--[[

@NPCClass base(BaseCombine) studio() = npc_hgrunt : "Human Grunt"
[
	spawnflags(Flags) =
	[
		32 : "Use Leader Model" : 0
	]

	// No default so it will default to random
	//	model(studio)  : "Custom Model" : "models/hgrunt1.mdl"
]

]]
AddCSLuaFile()
ENT.Base = "monster_human_grunt" 