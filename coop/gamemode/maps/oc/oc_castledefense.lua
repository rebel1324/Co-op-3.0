-- OBSIDIAN CONFLICT OFFICIAL MAP
--[[
	PASTE TEXT HERE

]]
MAP_BREIFING = [[Obsidian Conflict

Map: oc_castledefense
Author: W0rf0x (w0rf0x@obsidianconflict.net)

Description:
Defend The "stones of the elements" against 3 attack waves!

Hint:
Sometimes you can use the radio in the spawn room to order weapon supplies.
]]
MAP_CONFIG = {
"oc_castledefense"
{
		"mp_flashlight" "1"
                "sk_strider_health" "2000"
                "sk_strider_num_missiles1" "10"
                "sk_strider_num_missiles2" "10"
                "sk_strider_num_missiles3" "10"
                "sk_antlionguard_health" "1500"
		"sk_helicopter_blast_push" "0"
}oc_castledefense
{
    Modify
    {
        TargetName
        {
//remove tag from my name
            "map_by"
            {
		"message" "Map by W0rf0x"
            }
        }
}
	SpawnItems
	{
    "weapon_smg1" "1"
    "item_ammo_smg1_large" "1"
    "weapon_pistol" "1"
    "weapon_357" "1"
    "weapon_shotgun" "1"
    "item_ammo_pistol_large" "1"
    "weapon_crowbar" "1"
    "weapon_healer" "1"
    "item_box_buckshot" "1"
    "item_ammo_357_large" "1"
    "weapon_uzi" "2"
    "weapon_sniperrifle" "1"
    "item_box_sniper_rounds" "1"
    "weapon_slam" "1"
	}
}
}