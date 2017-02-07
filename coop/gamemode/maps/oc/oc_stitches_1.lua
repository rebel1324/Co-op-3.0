-- OBSIDIAN CONFLICT OFFICIAL MAP
--[[
	PASTE TEXT HERE

]]
MAP_BREIFING = [[Obsidian Conflict

Map: oc_stitches_1
Author: Tysn

Description:

Travel through many strange environments to complete one obscure objective: kill the lieutenant.


]]
MAP_CONFIG = {
// File was created for use in Obsidian Conflict ONLY!
"oc_stitches_1"
{
	"mp_falldamage"	"1"
	"sk_max_357" "24"
	"sk_max_ar2" "120"
	"sk_max_buckshot" "60"
        "sk_max_crossbow" "20"
	"sk_max_pistol" "300"
	"sk_max_rpg_round" "9"
        "sk_max_smg1" "500"
	"mp_flashlight" "1"
	"mp_playercollide" "1"
}

	"oc_stitches_1"
{
	Modify
    	{
        	ClassName
        	{
        	    "trigger_changelevel"
        	    {
         	       "nosmooth" "1"
        	    }
        	}

	}
	SpawnItems
	{
		"weapon_crowbar" "1"
		"weapon_healer" "1"
		"custom_cz52" "1"
		"item_ammo_pistol" "8"
	}
}
}