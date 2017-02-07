-- OBSIDIAN CONFLICT OFFICIAL MAP
--[[
	PASTE TEXT HERE

]]
MAP_BREIFING = [[
]]
MAP_CONFIG = {
	"oc_kake_l"
{
"mp_timelimit" "30"
"mp_flashlight" "0"

// ===========
//  NPCs
// ============
"sk_agrunt_dmg_punch" "25"
"sk_agrunt_health" "200"

"sk_antlion_air_attack_dmg" "45"
"sk_antlion_health" "150"
"sk_antlion_jump_damage" "15"
"sk_antlion_swipe_damage" "7"

"sk_antlionguard_dmg_charge" "20"
"sk_antlionguard_dmg_shove" "10"
"sk_antlionguard_health" "250"

"sk_antlion_worker_burst_damage" "50"//: How much damage is inflicted by an antlion worker's death explosion.
"sk_antlion_worker_burst_radius" "160"//: Effect radius of an antlion worker's death explosion.
"sk_antlion_worker_health" "120"//: Hitpoints of an antlion worker. If 0, will use base antlion hitpoints.
"sk_antlion_worker_spit_grenade_dmg" "20"//:Total damage done by an individual antlion worker loogie.
"sk_antlion_worker_spit_grenade_poison_ratio" "0"//Percentage of an antlion worker's spit damage done as poison (which regenerates)
"sk_antlion_worker_spit_grenade_radius" "40"//: Radius of effect for an antlion worker spit grenade.
"sk_antlion_worker_spit_speed" "600"//: Speed at which an antlion spit grenade travels.

"sk_barney_health" "110"

"sk_bullseye_health" "150"

"sk_bullsquid_dmg_bite" "30"
"sk_bullsquid_dmg_whip" "40"
"sk_bullsquid_health" "150"

"sk_citizen_health" "100"

"sk_combine_guard_health" "100"
"sk_combine_guard_kick" "15"
"sk_combine_s_health" "100"
"sk_combine_s_kick" "10"

"sk_hassassin_dmg" "5"
"sk_hassassin_health" "100"

"sk_headcrab_fast_health" "70"
"sk_headcrab_health" "70"
"sk_headcrab_melee_dmg" "5"
"sk_headcrab_poison_health" "50"

"sk_hgrunt_health" "90"
"sk_hgrunt_kick" "10"

"sk_houndeye_dmg_blast" "40"
"sk_houndeye_health" "120"

"sk_manhack_health" "80"
"sk_manhack_melee_dmg" "40"

"sk_metropolice_health" "100"

"sk_vortigaunt_armor_charge" "30"
"sk_vortigaunt_dmg_claw" "30"
"sk_vortigaunt_dmg_rake" "50"
"sk_vortigaunt_dmg_zap" "100"
"sk_vortigaunt_health" "60"

"sk_zombie_dmg_both_slash" "40"
"sk_zombie_dmg_one_slash" "20"
"sk_zombie_health" "150"

"sk_fastzombie_dmg_claw" "30" 
"sk_fastzombie_dmg_leap" "20"
"sk_fastzombie_health" "100"

"sk_zombie_poison_dmg_spit" "40"
"sk_zombie_poison_health" "175"

"sk_defender_health" "200" //temp value

"sk_scanner_health"	"30"
"sk_scanner_dmg_dive" "25"

"sk_stalker_aggressive" "1"
"sk_stalker_health"	"70"
"sk_stalker_melee_dmg"	"5"

// Mortar Synth
"sk_mortarsynth_health"	"220"
"sk_dmg_energy_grenade"	"80"
"sk_energy_grenade_radius" "300"
"sk_mortarsynth_beamdmg" "60"

"sk_hunter_buckshot_damage_scale"	   "0.5" //0.5
"sk_hunter_bullet_damage_scale"      "0.6" //0.6
"sk_hunter_charge_damage_scale"      "1"   //2
"sk_hunter_citizen_damage_scale"     "1" //0.3
"sk_hunter_dmg_charge"               "40"  //20
"sk_hunter_dmg_flechette"            "8"   //4
"sk_hunter_dmg_from_striderbuster"   "150" //150
"sk_hunter_dmg_one_slash"            "40"  //20
"sk_hunter_flechette_explode_dmg"    "24"  //12
"sk_hunter_flechette_explode_radius" "128" //128
"sk_hunter_health"                   "300" //210
"sk_hunter_vehicle_damage_scale"     "2"   //2

"sk_gargantua_dmg_fire" "3"
"sk_gargantua_dmg_slash" "30"
"sk_gargantua_dmg_stomp" "30"
"sk_gargantua_health" "800"

"sk_bigmomma_dmg_blast" "100"
"sk_bigmomma_dmg_slash" "50"
"sk_bigmomma_health" "400"
"sk_bigmomma_health_factor" "3"
"sk_bigmomma_radius_blast" "250"

// =================
//  NPC WEAPONS
// =================

"sk_npc_dmg_357" "120"
"sk_npc_dmg_ar2" "3"
"sk_npc_dmg_buckshot" "3"
"sk_npc_dmg_fraggrenade" "75"
"sk_npc_dmg_grenade" "50"
"sk_npc_dmg_pistol" "10"
"sk_npc_dmg_smg1" "3"
"sk_npc_dmg_smg1_grenade" "50"
"sk_npc_dmg_stunstick" "40"

// ========
// Weapons
// ========

"sk_plr_dmg_357" "30"
"sk_plr_dmg_ar2" "7"
"sk_plr_dmg_buckshot" "5"
"sk_plr_dmg_crowbar" "5"
"sk_plr_dmg_fraggrenade" "75"
"sk_plr_dmg_grenade" "75"
"sk_plr_dmg_pistol" "4"
"sk_plr_dmg_rpg_round" "75"
"sk_plr_dmg_smg1" "5"
"sk_plr_dmg_smg1_grenade" "50"
"sk_plr_dmg_stunstick" "20"

}	

"oc_kake_l"			{add{"logic_auto"{

//Excluded combination
//N01:Zombie N02:Combine N03:antlion N04:Manhack N05:Houndeye N06:Headcrab N07:Antlionguard 
//N08:Rebels N09:Assassin N10:Dream N11:Vortigaunt N12:Aliengrunt N13:bullsquid N14:Hgrunt
//N15:Metropolice N16:TeamBrue N17:Stalker N18:Hunter N19:Mortarsynth N20:Scanner N21 TeamRed
//N22:Antlion workers N23:Gargantua N24:Bigmomma N25:Genie N26:Odessas

	//Combine-Mortarsynth
		"OnMapSpawn" "npc_spawn_T01_N02,AddOutput,OnTrigger npc_choice_flag_T02_N19:SetValue:1:0:-1,0,-1"
		"OnMapSpawn" "npc_spawn_T01_N19,AddOutput,OnTrigger npc_choice_flag_T02_N02:SetValue:1:0:-1,0,-1"

    //Scanner-Aliengrunt
		"OnMapSpawn" "npc_spawn_T01_N20,AddOutput,OnTrigger npc_choice_flag_T02_N12:SetValue:1:0:-1,0,-1"
		"OnMapSpawn" "npc_spawn_T01_N12,AddOutput,OnTrigger npc_choice_flag_T02_N20:SetValue:1:0:-1,0,-1"

    //Hunter-Aliengrunt
		"OnMapSpawn" "npc_spawn_T01_N18,AddOutput,OnTrigger npc_choice_flag_T02_N12:SetValue:1:0:-1,0,-1"
		"OnMapSpawn" "npc_spawn_T01_N12,AddOutput,OnTrigger npc_choice_flag_T02_N18:SetValue:1:0:-1,0,-1"

    //Stalker-Assassin
		"OnMapSpawn" "npc_spawn_T01_N17,AddOutput,OnTrigger npc_choice_flag_T02_N09:SetValue:1:0:-1,0,-1"
		"OnMapSpawn" "npc_spawn_T01_N09,AddOutput,OnTrigger npc_choice_flag_T02_N17:SetValue:1:0:-1,0,-1"

    //Stalker-Dream
//		"OnMapSpawn" "npc_spawn_T01_N17,AddOutput,OnTrigger npc_choice_flag_T02_N10:SetValue:1:0:-1,0,-1"
//		"OnMapSpawn" "npc_spawn_T01_N10,AddOutput,OnTrigger npc_choice_flag_T02_N17:SetValue:1:0:-1,0,-1"

    //Stalker-Mortarsynth
		"OnMapSpawn" "npc_spawn_T01_N17,AddOutput,OnTrigger npc_choice_flag_T02_N19:SetValue:1:0:-1,0,-1"
		"OnMapSpawn" "npc_spawn_T01_N19,AddOutput,OnTrigger npc_choice_flag_T02_N17:SetValue:1:0:-1,0,-1"

						}}modify{targetname{"rate_player"{

//Ratio of player battle(0~10)
	"CompareValue" "2"
	
						}"player_weapon"{

//The player's equipment in player battle
	"weapon_healer" "1"
	"weapon_crowbar" "1"
	"weapon_357" "1"
	"weapon_pistol" "1"
	"weapon_smg1" "1"
	"weapon_shotgun" "1"
	"weapon_ar2" "1"

	"item_ammo_smg1" "6"
	"item_ammo_smg1_grenade" "1"
	"item_box_buckshot" "3"
	"item_ammo_pistol" "8"
	"item_ammo_ar2" "2"
	"item_ammo_357" "2"

						}}}	SpawnItems{}
}
}