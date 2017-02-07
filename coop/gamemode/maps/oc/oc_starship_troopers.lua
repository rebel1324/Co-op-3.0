hook.Add("Think", "custom_checkpoint", function()
	if SERVER then
		for k, v in ipairs(ents.GetAll()) do
			if v:GetClass() == "npc_maker" then
				v:Fire("MaxLiveChildren", 2)
			end
		end
	end
end)

Obsidian Conflict

Map: oc_starship_troopers
Author: Tysn

Description:

Stranded in outpost 87, your team and the lieutenant must fight off the arachnid hordes until help can arrive.


(There is a 40-second delay before the map begins to allow players time to load the map)


// File was created for use in Obsidian Conflict ONLY!
"oc_starship_troopers"
{
	"mp_falldamage"	"1"
	"mp_bunnyhop" "0"
	"sk_max_smg1" "300"

oc_starship_troopers
{
    Add
    {
        "scripted_sequence"
        {
            "angles" "0 0 0"
            "hammerid" "444717"
            "m_bLoopActionSequence" "1"
            "m_bSynchPostIdles" "0"
            "m_flRadius" "0"
            "m_flRepeat" "0"
            "m_fMoveTo" "0"
            "m_iszEntity" "Merchant_1"
            "m_iszEntry" "Idle_Unarmed"
            "m_iszIdle" "Idle_Unarmed"
            "m_iszPlay" "Idle_Unarmed"
            "m_iszPostIdle" "Idle_Unarmed"
            "maxdxlevel" "0"
            "mindxlevel" "0"
            "onplayerdeath" "0"
            "spawnflags" "292"
            "targetname" "Merchant_Script_1"
            "origin" "-1515.03 415.77 32"
        }
        "scripted_sequence"
        {
            "angles" "0 0 0"
            "hammerid" "444717"
            "m_bLoopActionSequence" "1"
            "m_bSynchPostIdles" "0"
            "m_flRadius" "0"
            "m_flRepeat" "0"
            "m_fMoveTo" "0"
            "m_iszEntity" "Merchant_2"
            "m_iszEntry" "Idle_Unarmed"
            "m_iszIdle" "Idle_Unarmed"
            "m_iszPlay" "Idle_Unarmed"
            "m_iszPostIdle" "Idle_Unarmed"
            "maxdxlevel" "0"
            "mindxlevel" "0"
            "onplayerdeath" "0"
            "spawnflags" "292"
            "targetname" "Merchant_Script_2"
            "origin" "-1517.61 338.485 32"
        }
        "scripted_sequence"
        {
            "angles" "0 0 0"
            "hammerid" "444717"
            "m_bLoopActionSequence" "1"
            "m_bSynchPostIdles" "0"
            "m_flRadius" "0"
            "m_flRepeat" "0"
            "m_fMoveTo" "0"
            "m_iszEntity" "Merchant_3"
            "m_iszEntry" "Idle_Unarmed"
            "m_iszIdle" "Idle_Unarmed"
            "m_iszPlay" "Idle_Unarmed"
            "m_iszPostIdle" "Idle_Unarmed"
            "maxdxlevel" "0"
            "mindxlevel" "0"
            "onplayerdeath" "0"
            "spawnflags" "292"
            "targetname" "Merchant_Script_3"
            "origin" "-1524.27 263.962 32"
        }
        "logic_auto"
        {
            "spawnflags" "1"
            "OnMapSpawn" "Merchant_Script_1,BeginSequence,,3,-1"
            "OnMapSpawn" "Merchant_Script_2,BeginSequence,,3,-1"
            "OnMapSpawn" "Merchant_Script_3,BeginSequence,,3,-1"
            "origin" "-1566.16 333.17 40"
        }
    }
    Modify
    {
        ClassName
        {
            "worldspawn"
            {
                "mapversion" "11"
            }
        }
        TargetName
        {
            "Import_Item_Explosive_Barrel_Purchase"
            {
                "CostOf" "1"
            }
            "Import_Item_Combine_Mine_Purchase"
            {
                "CostOf" "3"
            }
        }
        Origin
        {
            "-1440 416 32"
            {
                "targetname" "Merchant_1"
            }
            "-1443 256 32"
            {
                "targetname" "Merchant_3"
            }
            "-1440 336 32"
            {
                "targetname" "Merchant_2"
            }
            "-1104 960 88"
            {
                "message" "$1"
            }
            "-1040 960 88"
            {
                "message" "$3"
            }
        }
    }
SpawnItems
{
"weapon_crowbar" "1"
"custom_oicw" "1"
"item_ammo_smg1" "6"
}
}