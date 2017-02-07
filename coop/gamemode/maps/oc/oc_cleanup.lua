-- OBSIDIAN CONFLICT OFFICIAL MAP
--[[
	PASTE TEXT HERE

]]
MAP_BREIFING = [[Obsidian Conflict

Map: oc_cleanup

Description:
You have been captured in a large office building.
Fight your way out.

]]
MAP_CONFIG = {
	"OC_Cleanup"
{
	"mp_teamplay" "0"
	"r_raindensity" "0.002"
	"r_rainalpha" "0.5"
	"r_rainlength" "0.04f"
	"r_rainspeed" "300"
}oc_cleanup
{
	SpawnItems
	{
		"weapon_healer" "1"
		"weapon_pistol" "1"
	}
}
}
"cleanup.Crittervents"
{
	"dsp"	"1"

	"playrandom"
	{
		"time"		"8,13"
		"volume"	"0.8,0.9"
		"pitch"		"100"
		"position"	"random"
		"soundlevel"	"SNDLVL_140db"
		"rndwave"
		{
			"wave"	"ambient/materials/metal_stress2.wav"
			"wave"	"ambient/materials/metal_stress4.wav"
			"wave"	"ambient/materials/metal_rattle4.wav"
		}
		
	}
}
== REGISTER SOUND