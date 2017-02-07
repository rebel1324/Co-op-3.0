-- OBSIDIAN CONFLICT OFFICIAL MAP
--[[
	PASTE TEXT HERE

]]
MAP_BREIFING = [[Obsidian Conflict

Map: oc_freezingpoint

Description:

In an effort to destroy the combine training facilities your team has landed
ashore a frozen landmass that is believed to be the combines lead facilities.

Your mission is to shut down the combines arctic training facilities.


]]
MAP_CONFIG = {
"oc_freezingpoint"
{
"sk_npc_dmg_ar2"			"11"
"sk_npc_dmg_smg1"			"7"
"sk_npc_dmg_buckshot"			"9"

"sk_plr_dmg_ar2"			"6"
"sk_plr_dmg_smg1"			"5"
"sk_plr_dmg_buckshot"			"5"

"sk_headcrab_melee_dmg"			"10"
"sk_zombie_dmg_one_slash"		"19"
"sk_zombie_dmg_both_slash"		"29"

"sv_allowgaussjump"			"0"

"sk_helicopter_blast_push" 		"0"
}	
oc_freezingpoint
{
    Remove
    {
        Origin
        {
            "-735 5812 785.281" {}
        }
    }
    Add
    {
        "prop_dynamic"
        {
            "angles" "0 90 90"
            "disableshadows" "1"
            "fademaxdist" "400"
            "fademindist" "390"
            "fadescale" "1"
            "MaxAnimTime" "10"
            "MinAnimTime" "5"
            "model" "models/weapons/w_rocket_launcher.mdl"
            "renderamt" "255"
            "rendercolor" "255 255 255"
            "skin" "0"
            "solid" "0"
            "origin" "-738 5795 791"
        }
        "game_player_equip"
        {
            "targetname" "give_players_rpg"
            "weapon_rpg" "1"
            "origin" "-763.652 5823.93 777"
        }
        "item_ammo_crate"
        {
            "AmmoType" "3"
            "angles" "0 180 0"
            "fademindist" "-1"
            "fadescale" "1"
            "OnUsed" "give_players_rpg,EquipActivator,,1,-1"
            "origin" "-734 5813 785"
        }
    }
	SpawnItems
	{
		"weapon_crowbar" "1"
		"weapon_pistol" "1"
	}
}
	
}