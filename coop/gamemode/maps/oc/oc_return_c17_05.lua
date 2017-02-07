-- OBSIDIAN CONFLICT OFFICIAL MAP
--[[
	PASTE TEXT HERE

]]
MAP_BREIFING = [[
]]
MAP_CONFIG = {
"oc_return_c17_05"
{
"sk_ally_regen_time" "0.01"
"sk_barney_health" "100"
"sk_citizen_health" "100"
}	
	oc_return_c17_05
{
    Remove
    {
        ClassName
        {
            "game_end" {}
        }
    }
    Add
    {
        "logic_timer"
        {
            "RefireTime" "2"
            "spawnflags" "0"
            "StartDisabled" "0"
            "UseRandomTime" "0"
            "OnTimer" "security_metropolice_1,SetDamageFilter,filter_NoDamage,1,-1"
            "origin" "-5049 -1280 108"
        }
        "filter_multi"
        {
            "Negated" "1"
            "targetname" "filter_NoDamage"
            "origin" "-5033 -1280 108"
        }
    }
    Modify
    {
        ClassName
        {
            "worldspawn"
            {
                "mapversion" "5"
            }
        }
    }
}

}