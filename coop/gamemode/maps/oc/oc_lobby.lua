-- OBSIDIAN CONFLICT OFFICIAL MAP
--[[
	PASTE TEXT HERE

]]
MAP_BREIFING = [[Obsidian Conflict

Map: oc_lobby
Author: Tysn
Email: tysonbt@gmail.com

Description:

This is a map selection level. To select a map, break down the map's door with your crowbar and enter the resulting hallway.


For server admins, refer to oc_lobby_modify.txt in your SourceMods/obsidian/maps/cfg directory for information on how to add and remove maps for your server.




Special Thanks To:

Zteer - original map selection concept
W0rf0x - information on map selection system
Skidz - entity assistance
]]

if CLIENT then return end

MODIFY_MODIFY = [[
		"Map_Posterboard_1"   {"texture" "tysn/tysn_decal_posterboard_mounting"}
		"Map_Posterboard_2"   {"texture" "tysn/Tysn_Decal_Posterboard_Campaign"}
		"Map_Posterboard_3"   {"texture" "tysn/Tysn_Decal_Posterboard_Genre"}
		"Map_Posterboard_4"   {"texture" "tysn/Tysn_Decal_Posterboard_HowToPlay"}
		"Map_Posterboard_5"   {"texture" "tysn/tysn_decal_posterboard_items"}
		"Map_Posterboard_6"   {"texture" "tysn/Tysn_Decal_Posterboard_AddingMapsToLobby"}
		"Map_Posterboard_7"   {"texture" "tysn/Tysn_Decal_Posterboard_LivesSystem"}
		"Map_Posterboard_8"   {"texture" "tysn/Tysn_Decal_Posterboard_Merchants"}
		"Map_Posterboard_9"   {"texture" "tysn/Tysn_Decal_Posterboard_Mapping"}
		"Map_Posterboard_10"   {"texture" "tysn/Tysn_Decal_Posterboard_Keybinds"}

		"logicauto"	{"OnTrigger" "Map_Toggle_HLS,Toggle, 0, -1"}
		"logicauto"	{"OnTrigger" "Map_Toggle_HL2,Toggle, 0, -1"}
		"logicauto"	{"OnTrigger" "Map_Toggle_EP1,Toggle, 0, -1"}
		"logicauto"	{"OnTrigger" "Map_Toggle_EP2,Toggle, 0, -1"}


        "Map_Message_1" {"message" "ep1_oc_broken_escape"}	
		"logicauto"	{"OnTrigger" "Map_Toggle_1,Toggle, 0, -1"}
	    "Map_Trigger_1" {"OnStartTouch" "ServerCommand,Command,changelevel ep1_oc_broken_escape_01,5,-1"}
		"Map_Random_1"  {"OnTrigger" "ServerCommand,Command,changelevel ep1_oc_broken_escape_01,0,-1"}
	    "Map_Door_1"    {"OnHealthChanged" "text,DisplayText,ep1_oc_broken_escape,0,-1"}
		"Map_Door_1"    {"OnHealthChanged" "text2,DisplayText,Author:W0rf0x,0,-1"} 
		"Map_Door_1"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_1"    {"OnHealthChanged" "text4,DisplayText,Mounts:EP1,0,-1"}
		"Map_Decal_1"   {"texture" "maps/oc_lobby/lobby_oc_broken_escape"}

		"Map_Message_2" {"message" "ep2_oc_broken_escape_02a"}
		"logicauto"	{"OnTrigger" "Map_Toggle_2,Toggle, 0, -1"}
	    	"Map_Trigger_2" {"OnStartTouch" "ServerCommand,Command,changelevel ep2_oc_broken_escape_02a,5,-1"}
		"Map_Random_2"  {"OnTrigger" "ServerCommand,Command,changelevel ep2_oc_broken_escape_02a,0,-1"}
	    	"Map_Door_2"    {"OnHealthChanged" "text,DisplayText,ep2_oc_broken_escape_02a,0,-1"}
		"Map_Door_2"    {"OnHealthChanged" "text2,DisplayText,Author:W0rf0x,0,-1"} 
		"Map_Door_2"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_2"    {"OnHealthChanged" "text4,DisplayText,Mounts:EP2,0,-1"}
		"Map_Decal_2"   {"texture" "maps/oc_lobby/lobby_ep2_oc_broken_escape_02a"}	    	
		
		"Map_Message_3" {"message" "oc_breakout"}
		"logicauto"	{"OnTrigger" "Map_Toggle_3,Toggle, 0, -1"}
	    	"Map_Trigger_3" {"OnStartTouch" "ServerCommand,Command,changelevel oc_breakout,5,-1"}
		"Map_Random_3"  {"OnTrigger" "ServerCommand,Command,changelevel oc_breakout,0,-1"}
	    	"Map_Door_3"    {"OnHealthChanged" "text,DisplayText,oc_breakout,0,-1"} 
		"Map_Door_3"    {"OnHealthChanged" "text2,DisplayText,Author:Tysn,0,-1"} 
		"Map_Door_3"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat/Puzzle,0,-1"} 
		"Map_Door_3"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_3"   {"texture" "maps/oc_lobby/lobby_oc_breakout"}	
	    	
		"Map_Message_4" {"message" "oc_Bunker"}
		"logicauto"	{"OnTrigger" "Map_Toggle_4,Toggle, 0, -1"}
	    	"Map_Trigger_4" {"OnStartTouch" "ServerCommand,Command,changelevel oc_Bunker,5,-1"}
		"Map_Random_4"  {"OnTrigger" "ServerCommand,Command,changelevel oc_Bunker,0,-1"}
	    	"Map_Door_4"    {"OnHealthChanged" "text,DisplayText,oc_Bunker,0,-1"} 
		"Map_Door_4"    {"OnHealthChanged" "text2,DisplayText,Author:JoeScoma,0,-1"} 
		"Map_Door_4"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_4"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_4"   {"texture" "maps/oc_lobby/lobby_oc_bunker"}		
		
		"Map_Message_5" {"message" "oc_cannon"}
		"logicauto"	{"OnTrigger" "Map_Toggle_5,Toggle, 0, -1"}
	    	"Map_Trigger_5" {"OnStartTouch" "ServerCommand,Command,changelevel oc_cannon_1,5,-1"}
		"Map_Random_5"  {"OnTrigger" "ServerCommand,Command,changelevel oc_cannon_1,0,-1"}
	    	"Map_Door_5"    {"OnHealthChanged" "text,DisplayText,oc_cannon,0,-1"}
		"Map_Door_5"    {"OnHealthChanged" "text2,DisplayText,Author:Hickadam,0,-1"} 
		"Map_Door_5"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat/Puzzle,0,-1"} 
		"Map_Door_5"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}	
		"Map_Decal_5"   {"texture" "maps/oc_lobby/lobby_oc_cannon"}	

		"Map_Message_7" {"message" "oc_courier"}
		"logicauto"	{"OnTrigger" "Map_Toggle_7,Toggle, 0, -1"}
	    	"Map_Trigger_7" {"OnStartTouch" "ServerCommand,Command,changelevel oc_courier,5,-1"}
		"Map_Random_7"  {"OnTrigger" "ServerCommand,Command,changelevel oc_courier,0,-1"}
	    	"Map_Door_7"    {"OnHealthChanged" "text,DisplayText,oc_courier,0,-1"}
		"Map_Door_7"    {"OnHealthChanged" "text2,DisplayText,Author:Tysn,0,-1"} 
		"Map_Door_7"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat/Puzzle,0,-1"} 
		"Map_Door_7"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"} 
		"Map_Decal_7"   {"texture" "maps/oc_lobby/lobby_oc_courier"}

		"Map_Message_8" {"message" "oc_danmaku_i"}
		"logicauto"	{"OnTrigger" "Map_Toggle_8,Toggle, 0, -1"}
	    	"Map_Trigger_8" {"OnStartTouch" "ServerCommand,Command,changelevel oc_danmaku_i,5,-1"}
		"Map_Random_8"  {"OnTrigger" "ServerCommand,Command,changelevel oc_danmaku_i,0,-1"}
	    	"Map_Door_8"    {"OnHealthChanged" "text,DisplayText,oc_danmaku_i,0,-1"}
		"Map_Door_8"    {"OnHealthChanged" "text2,DisplayText,Author:Zteer,0,-1"} 
		"Map_Door_8"    {"OnHealthChanged" "text3,DisplayText,Genre:Funmap,0,-1"} 
		"Map_Door_8"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"} 
		"Map_Decal_8"   {"texture" "maps/oc_lobby/lobby_oc_danmaku"}

		"Map_Message_9" {"message" "oc_docks"}
		"logicauto"	{"OnTrigger" "Map_Toggle_9,Toggle, 0, -1"}
	    	"Map_Trigger_9" {"OnStartTouch" "ServerCommand,Command,changelevel oc_docks,5,-1"}
		"Map_Random_9"  {"OnTrigger" "ServerCommand,Command,changelevel oc_docks,0,-1"}
	    	"Map_Door_9"    {"OnHealthChanged" "text,DisplayText,oc_docks,0,-1"}
		"Map_Door_9"    {"OnHealthChanged" "text2,DisplayText,Author:JoeScoma,0,-1"} 
		"Map_Door_9"    {"OnHealthChanged" "text3,DisplayText,Genre:Puzzle,0,-1"} 
		"Map_Door_9"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_9"   {"texture" "maps/oc_lobby/lobby_oc_docks"}

		"Map_Message_10" {"message" "oc_evildead"}
		"logicauto"	{"OnTrigger" "Map_Toggle_10,Toggle, 0, -1"}
	    	"Map_Trigger_10" {"OnStartTouch" "ServerCommand,Command,changelevel oc_evildead,5,-1"}
		"Map_Random_10"  {"OnTrigger" "ServerCommand,Command,changelevel oc_evildead,0,-1"}
	    	"Map_Door_10"    {"OnHealthChanged" "text,DisplayText,oc_evildead,0,-1"}
		"Map_Door_10"    {"OnHealthChanged" "text2,DisplayText,Author:Hickadam,0,-1"} 
		"Map_Door_10"    {"OnHealthChanged" "text3,DisplayText,Genre:Combat,0,-1"} 
		"Map_Door_10"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_10"   {"texture" "maps/oc_lobby/lobby_oc_evildead"}

		"Map_Message_11" {"message" "oc_fireteam"}
		"logicauto"	{"OnTrigger" "Map_Toggle_11,Toggle, 0, -1"}
	    	"Map_Trigger_11" {"OnStartTouch" "ServerCommand,Command,changelevel oc_fireteam_1,5,-1"}
		"Map_Random_11"  {"OnTrigger" "ServerCommand,Command,changelevel oc_fireteam_1,0,-1"}
	    	"Map_Door_11"    {"OnHealthChanged" "text,DisplayText,oc_fireteam,0,-1"}
		"Map_Door_11"    {"OnHealthChanged" "text2,DisplayText,Author:Tysn,0,-1"} 
		"Map_Door_11"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat/Puzzle,0,-1"} 
		"Map_Door_11"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_11"   {"texture" "maps/oc_lobby/lobby_oc_fireteam"}

		"Map_Message_12" {"message" "oc_freezingpoint"}
		"logicauto"	{"OnTrigger" "Map_Toggle_12,Toggle, 0, -1"}
	    	"Map_Trigger_12" {"OnStartTouch" "ServerCommand,Command,changelevel oc_freezingpoint,5,-1"}
		"Map_Random_12"  {"OnTrigger" "ServerCommand,Command,changelevel oc_freezingpoint,0,-1"}
	    	"Map_Door_12"    {"OnHealthChanged" "text,DisplayText,oc_freezingpoint,0,-1"}
		"Map_Door_12"    {"OnHealthChanged" "text2,DisplayText,Author:skidz,0,-1"} 
		"Map_Door_12"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat/Puzzle,0,-1"} 
		"Map_Door_12"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_12"   {"texture" "maps/oc_lobby/lobby_oc_freezingpoint"}

		"Map_Message_13" {"message" "oc_harvest"}
		"logicauto"	{"OnTrigger" "Map_Toggle_13,Toggle, 0, -1"}
	    	"Map_Trigger_13" {"OnStartTouch" "ServerCommand,Command,changelevel oc_harvest,5,-1"}
		"Map_Random_13"  {"OnTrigger" "ServerCommand,Command,changelevel oc_harvest,0,-1"}
	    	"Map_Door_13"    {"OnHealthChanged" "text,DisplayText,oc_harvest,0,-1"}
		"Map_Door_13"    {"OnHealthChanged" "text2,DisplayText,Author:Tysn,0,-1"} 
		"Map_Door_13"    {"OnHealthChanged" "text3,DisplayText,Genre:Funmap,0,-1"} 
		"Map_Door_13"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_13"   {"texture" "maps/oc_lobby/lobby_oc_harvest"}

		"Map_Message_14" {"message" "oc_kake_l"}
		"logicauto"	{"OnTrigger" "Map_Toggle_14,Toggle, 0, -1"}
	    	"Map_Trigger_14" {"OnStartTouch" "ServerCommand,Command,changelevel oc_kake_l,5,-1"}
		"Map_Random_14"  {"OnTrigger" "ServerCommand,Command,changelevel oc_kake_l,0,-1"}
	    	"Map_Door_14"    {"OnHealthChanged" "text,DisplayText,oc_kake_l,0,-1"}
		"Map_Door_14"    {"OnHealthChanged" "text2,DisplayText,Author:Zteer,0,-1"} 
		"Map_Door_14"    {"OnHealthChanged" "text3,DisplayText,Genre:Funmap/PVP,0,-1"} 
		"Map_Door_14"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_14"   {"texture" "maps/oc_lobby/lobby_oc_kake"}

		"Map_Message_15" {"message" "oc_manor"}
		"logicauto"	{"OnTrigger" "Map_Toggle_15,Toggle, 0, -1"}
	    	"Map_Trigger_15" {"OnStartTouch" "ServerCommand,Command,changelevel oc_manor,5,-1"}
		"Map_Random_15"  {"OnTrigger" "ServerCommand,Command,changelevel oc_manor,0,-1"}
	    	"Map_Door_15"    {"OnHealthChanged" "text,DisplayText,oc_manor,0,-1"}
		"Map_Door_15"    {"OnHealthChanged" "text2,DisplayText,Author:Tysn,0,-1"} 
		"Map_Door_15"    {"OnHealthChanged" "text3,DisplayText,Genre:Puzzle,0,-1"} 
		"Map_Door_15"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_15"   {"texture" "maps/oc_lobby/lobby_oc_manor"}

		"Map_Message_16" {"message" "oc_seamus"}
		"logicauto"	{"OnTrigger" "Map_Toggle_16,Toggle, 0, -1"}
	    	"Map_Trigger_16" {"OnStartTouch" "ServerCommand,Command,changelevel oc_seamus,5,-1"}
		"Map_Random_16"  {"OnTrigger" "ServerCommand,Command,changelevel oc_seamus,0,-1"}
	    	"Map_Door_16"    {"OnHealthChanged" "text,DisplayText,oc_seamus,0,-1"}
		"Map_Door_16"    {"OnHealthChanged" "text2,DisplayText,Author:skidz,0,-1"} 
		"Map_Door_16"    {"OnHealthChanged" "text3,DisplayText,Genre:PVP/Combat,0,-1"} 
		"Map_Door_16"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_16"   {"texture" "maps/oc_lobby/lobby_oc_seamus"}

		"Map_Message_17" {"message" "oc_sewers"}
		"logicauto"	{"OnTrigger" "Map_Toggle_17,Toggle, 0, -1"}
	    	"Map_Trigger_17" {"OnStartTouch" "ServerCommand,Command,changelevel oc_sewers,5,-1"}
		"Map_Random_17"  {"OnTrigger" "ServerCommand,Command,changelevel oc_sewers,0,-1"}
	    	"Map_Door_17"    {"OnHealthChanged" "text,DisplayText,oc_sewers,0,-1"}
		"Map_Door_17"    {"OnHealthChanged" "text2,DisplayText,Author:JoeScoma,0,-1"} 
		"Map_Door_17"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_17"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_17"   {"texture" "maps/oc_lobby/lobby_oc_sewers"}

		"Map_Message_18" {"message" "oc_stadium"}
		"logicauto"	{"OnTrigger" "Map_Toggle_18,Toggle, 0, -1"}
	    	"Map_Trigger_18" {"OnStartTouch" "ServerCommand,Command,changelevel oc_stadium,5,-1"}
		"Map_Random_18"  {"OnTrigger" "ServerCommand,Command,changelevel oc_stadium,0,-1"}
	    	"Map_Door_18"    {"OnHealthChanged" "text,DisplayText,oc_stadium,0,-1"}
		"Map_Door_18"    {"OnHealthChanged" "text2,DisplayText,Author:skidz,0,-1"} 
		"Map_Door_18"    {"OnHealthChanged" "text3,DisplayText,Genre:Funmap,0,-1"} 
		"Map_Door_18"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_18"   {"texture" "maps/oc_lobby/lobby_oc_stadium"}

		"Map_Message_19" {"message" "oc_starlight"}
		"logicauto"	{"OnTrigger" "Map_Toggle_19,Toggle, 0, -1"}
	    	"Map_Trigger_19" {"OnStartTouch" "ServerCommand,Command,changelevel oc_starlight,5,-1"}
		"Map_Random_19"  {"OnTrigger" "ServerCommand,Command,changelevel oc_starlight,0,-1"}
	    	"Map_Door_19"    {"OnHealthChanged" "text,DisplayText,oc_starlight,0,-1"}
		"Map_Door_19"    {"OnHealthChanged" "text2,DisplayText,Author:PowerMad,0,-1"} 
		"Map_Door_19"    {"OnHealthChanged" "text3,DisplayText,Genre:Combat/Puzzle,0,-1"} 
		"Map_Door_19"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_19"   {"texture" "maps/oc_lobby/lobby_oc_starlight"}

		"Map_Message_20" {"message" "oc_stitches"}
		"logicauto"	{"OnTrigger" "Map_Toggle_20,Toggle, 0, -1"}
	    	"Map_Trigger_20" {"OnStartTouch" "ServerCommand,Command,changelevel oc_stitches_1,5,-1"}
		"Map_Random_20"  {"OnTrigger" "ServerCommand,Command,changelevel oc_stitches_1,0,-1"}
	    	"Map_Door_20"    {"OnHealthChanged" "text,DisplayText,oc_stitches,0,-1"}
		"Map_Door_20"    {"OnHealthChanged" "text2,DisplayText,Author:Tysn,0,-1"} 
		"Map_Door_20"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Puzzle/Combat,0,-1"} 
		"Map_Door_20"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_20"   {"texture" "maps/oc_lobby/lobby_oc_stitches"}

		"Map_Message_21" {"message" "oc_umizuri_j"}
		"logicauto"	{"OnTrigger" "Map_Toggle_21,Toggle, 0, -1"}
	    	"Map_Trigger_21" {"OnStartTouch" "ServerCommand,Command,changelevel oc_umizuri_j,5,-1"}
		"Map_Random_21"  {"OnTrigger" "ServerCommand,Command,changelevel oc_umizuri_j,0,-1"}
	    	"Map_Door_21"    {"OnHealthChanged" "text,DisplayText,oc_umizuri_j,0,-1"}
		"Map_Door_21"    {"OnHealthChanged" "text2,DisplayText,Author:Zteer,0,-1"} 
		"Map_Door_21"    {"OnHealthChanged" "text3,DisplayText,Genre:Funmap,0,-1"} 
		"Map_Door_21"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_21"   {"texture" "maps/oc_lobby/lobby_oc_umizuri"}

		"Map_Message_22" {"message" "oc_waking_dead"}
		"logicauto"	{"OnTrigger" "Map_Toggle_22,Toggle, 0, -1"}
	    	"Map_Trigger_22" {"OnStartTouch" "ServerCommand,Command,changelevel oc_waking_dead,5,-1"}
		"Map_Random_22"  {"OnTrigger" "ServerCommand,Command,changelevel oc_waking_dead,0,-1"}
	    	"Map_Door_22"    {"OnHealthChanged" "text,DisplayText,oc_waking_dead,0,-1"}
		"Map_Door_22"    {"OnHealthChanged" "text2,DisplayText,Author:DaMan,0,-1"} 
		"Map_Door_22"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_22"    {"OnHealthChanged" "text4,DisplayText,Mounts:CSS,0,-1"}
		"Map_Decal_22"   {"texture" "maps/oc_lobby/lobby_oc_waking_dead"}

		"Map_Message_23" {"message" "oc_wgh"}
		"logicauto"	{"OnTrigger" "Map_Toggle_23,Toggle, 0, -1"}
	    	"Map_Trigger_23" {"OnStartTouch" "ServerCommand,Command,changelevel oc_wgh,5,-1"}
		"Map_Random_23"  {"OnTrigger" "ServerCommand,Command,changelevel oc_wgh,0,-1"}
	    	"Map_Door_23"    {"OnHealthChanged" "text,DisplayText,oc_wgh,0,-1"}
		"Map_Door_23"    {"OnHealthChanged" "text2,DisplayText,Author:TheFox,0,-1"} 
		"Map_Door_23"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_23"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_23"   {"texture" "maps/oc_lobby/lobby_oc_wgh"}

		"Map_Message_24" {"message" "ocf_deadland"}
		"logicauto"	{"OnTrigger" "Map_Toggle_24,Toggle, 0, -1"}
	    	"Map_Trigger_24" {"OnStartTouch" "ServerCommand,Command,changelevel ocf_deadland,5,-1"}
		"Map_Random_24"  {"OnTrigger" "ServerCommand,Command,changelevel ocf_deadland,0,-1"}
	    	"Map_Door_24"    {"OnHealthChanged" "text,DisplayText,ocf_deadland,0,-1"}
		"Map_Door_24"    {"OnHealthChanged" "text2,DisplayText,Author:skidz,0,-1"} 
		"Map_Door_24"    {"OnHealthChanged" "text3,DisplayText,Genre:Combat,0,-1"} 
		"Map_Door_24"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_24"   {"texture" "maps/oc_lobby/lobby_ocf_deadland"}

		"Map_Message_25" {"message" "z_harrier2_f"}
		"logicauto"	{"OnTrigger" "Map_Toggle_25,Toggle, 0, -1"}
	    	"Map_Trigger_25" {"OnStartTouch" "ServerCommand,Command,changelevel z_harrier2_f,5,-1"}
		"Map_Random_25"  {"OnTrigger" "ServerCommand,Command,changelevel z_harrier2_f,0,-1"}
	    	"Map_Door_25"    {"OnHealthChanged" "text,DisplayText,z_harrier2_f,0,-1"}
		"Map_Door_25"    {"OnHealthChanged" "text2,DisplayText,Author:Zteer,0,-1"} 
		"Map_Door_25"    {"OnHealthChanged" "text3,DisplayText,Genre:Funmap,0,-1"} 
		"Map_Door_25"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_25"   {"texture" "maps/oc_lobby/lobby_z_harrier2_c"}

		"Map_Message_26" {"message" "cs_militia"}
		"logicauto"	{"OnTrigger" "Map_Toggle_26,Toggle, 0, -1"}
	    	"Map_Trigger_26" {"OnStartTouch" "ServerCommand,Command,changelevel cs_militia,5,-1"}
		"Map_Random_26"  {"OnTrigger" "ServerCommand,Command,changelevel cs_militia,0,-1"}
	    	"Map_Door_26"    {"OnHealthChanged" "text,DisplayText,cs_militia,0,-1"}
		"Map_Door_26"    {"OnHealthChanged" "text2,DisplayText,MapAddAuthor:GandorquesHikla,0,-1"} 
		"Map_Door_26"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_26"    {"OnHealthChanged" "text4,DisplayText,Mounts:CSS,0,-1"}
		"Map_Decal_26"   {"texture" "maps/oc_lobby/lobby_cs_militia"}

		"Map_Message_27" {"message" "de_chateau"}
		"logicauto"	{"OnTrigger" "Map_Toggle_27,Toggle, 0, -1"}
	    	"Map_Trigger_27" {"OnStartTouch" "ServerCommand,Command,changelevel de_chateau,5,-1"}
		"Map_Random_27"  {"OnTrigger" "ServerCommand,Command,changelevel de_chateau,0,-1"}
	    	"Map_Door_27"    {"OnHealthChanged" "text,DisplayText,de_chateau,0,-1"}
		"Map_Door_27"    {"OnHealthChanged" "text2,DisplayText,MapAddAuthor:fug4life,0,-1"} 
		"Map_Door_27"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_27"    {"OnHealthChanged" "text4,DisplayText,Mounts:CSS,0,-1"}
		"Map_Decal_27"   {"texture" "maps/oc_lobby/lobby_de_chateau"}

		"Map_Message_28" {"message" "de_nuke"}
		"logicauto"	{"OnTrigger" "Map_Toggle_28,Toggle, 0, -1"}
	    	"Map_Trigger_28" {"OnStartTouch" "ServerCommand,Command,changelevel de_nuke,5,-1"}
		"Map_Random_28"  {"OnTrigger" "ServerCommand,Command,changelevel de_nuke,0,-1"}
	    	"Map_Door_28"    {"OnHealthChanged" "text,DisplayText,de_nuke,0,-1"}
		"Map_Door_28"    {"OnHealthChanged" "text2,DisplayText,MapAddAuthor:fug4life,0,-1"} 
		"Map_Door_28"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_28"    {"OnHealthChanged" "text4,DisplayText,Mounts:CSS,0,-1"}
		"Map_Decal_28"   {"texture" "maps/oc_lobby/lobby_de_nuke"}

		"Map_Message_29" {"message" "de_port"}
		"logicauto"	{"OnTrigger" "Map_Toggle_29,Toggle, 0, -1"}
	    	"Map_Trigger_29" {"OnStartTouch" "ServerCommand,Command,changelevel de_port,5,-1"}
		"Map_Random_29"  {"OnTrigger" "ServerCommand,Command,changelevel de_port,0,-1"}
	    	"Map_Door_29"    {"OnHealthChanged" "text,DisplayText,de_port,0,-1"}
		"Map_Door_29"    {"OnHealthChanged" "text2,DisplayText,MapAddAuthor:W0rf0x,0,-1"} 
		"Map_Door_29"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_29"    {"OnHealthChanged" "text4,DisplayText,Mounts:CSS,0,-1"}
		"Map_Decal_29"   {"texture" "maps/oc_lobby/lobby_de_port"}

		"Map_Message_30" {"message" "de_prodigy"}
		"logicauto"	{"OnTrigger" "Map_Toggle_30,Toggle, 0, -1"}
	    	"Map_Trigger_30" {"OnStartTouch" "ServerCommand,Command,changelevel de_prodigy,5,-1"}
		"Map_Random_30"  {"OnTrigger" "ServerCommand,Command,changelevel de_prodigy,0,-1"}
	    	"Map_Door_30"    {"OnHealthChanged" "text,DisplayText,de_prodigy,0,-1"}
		"Map_Door_30"    {"OnHealthChanged" "text2,DisplayText,MapAddAuthor:fug4life,0,-1"} 
		"Map_Door_30"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat/Puzzle,0,-1"} 
		"Map_Door_30"    {"OnHealthChanged" "text4,DisplayText,Mounts:CSS,0,-1"}
		"Map_Decal_30"   {"texture" "maps/oc_lobby/lobby_de_prodigy"}

		"Map_Message_31" {"message" "oc_antlion_attack_01"}	
		"logicauto"	{"OnTrigger" "Map_Toggle_31,Toggle, 0, -1"}
	    	"Map_Trigger_31" {"OnStartTouch" "ServerCommand,Command,changelevel oc_antlion_attack_01,5,-1"}
		"Map_Random_31"  {"OnTrigger" "ServerCommand,Command,changelevel oc_antlion_attack_01,0,-1"}
	    	"Map_Door_31"    {"OnHealthChanged" "text,DisplayText,oc_antlion_attack_01,0,-1"}
		"Map_Door_31"    {"OnHealthChanged" "text2,DisplayText,Author:DaMaN,0,-1"} 
		"Map_Door_31"    {"OnHealthChanged" "text3,DisplayText,Genre:Combat,0,-1"} 
		"Map_Door_31"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_31"   {"texture" "maps/oc_lobby/lobby_oc_antlion_attack"}

		"Map_Message_32" {"message" "oc_wildfire"}
		"logicauto"	{"OnTrigger" "Map_Toggle_32,Toggle, 0, -1"}
	    	"Map_Trigger_32" {"OnStartTouch" "ServerCommand,Command,changelevel oc_wildfire,5,-1"}
		"Map_Random_32"  {"OnTrigger" "ServerCommand,Command,changelevel oc_wildfire,0,-1"}
	    	"Map_Door_32"    {"OnHealthChanged" "text,DisplayText,oc_wildfire,0,-1"}
		"Map_Door_32"    {"OnHealthChanged" "text2,DisplayText,Author:Tysn,0,-1"} 
		"Map_Door_32"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat/Puzzle,0,-1"} 
		"Map_Door_32"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_32"   {"texture" "maps/oc_lobby/lobby_oc_wildfire"}

		"Map_Message_33" {"message" "oc_cardwar"}
		"logicauto"	{"OnTrigger" "Map_Toggle_33,Toggle, 0, -1"}
	    	"Map_Trigger_33" {"OnStartTouch" "ServerCommand,Command,changelevel oc_cardwar,5,-1"}
		"Map_Random_33"  {"OnTrigger" "ServerCommand,Command,changelevel oc_cardwar,0,-1"}
	    	"Map_Door_33"    {"OnHealthChanged" "text,DisplayText,oc_cardwar,0,-1"}
		"Map_Door_33"    {"OnHealthChanged" "text2,DisplayText,Author:Tysn,0,-1"} 
		"Map_Door_33"    {"OnHealthChanged" "text3,DisplayText,Genre:Funmap/PVP,0,-1"} 
		"Map_Door_33"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_33"   {"texture" "maps/oc_lobby/lobby_oc_cardwar"}

		"Map_Message_34" {"message" "oc_starship_troopers"}
		"logicauto"	{"OnTrigger" "Map_Toggle_34,Toggle, 0, -1"}
	    	"Map_Trigger_34" {"OnStartTouch" "ServerCommand,Command,changelevel oc_starship_troopers,5,-1"}
		"Map_Random_34"  {"OnTrigger" "ServerCommand,Command,changelevel oc_starship_troopers,0,-1"}
	    	"Map_Door_34"    {"OnHealthChanged" "text,DisplayText,oc_starship_troopers,0,-1"}
		"Map_Door_34"    {"OnHealthChanged" "text2,DisplayText,Author:Tysn,0,-1"} 
		"Map_Door_34"    {"OnHealthChanged" "text3,DisplayText,Genre:Combat,0,-1"} 
		"Map_Door_34"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_34"   {"texture" "maps/oc_lobby/lobby_oc_starship_troopers"}

		"Map_Message_35" {"message" "coop_zelda01_b"}
		"logicauto"	{"OnTrigger" "Map_Toggle_35,Toggle, 0, -1"}
	    	"Map_Trigger_35" {"OnStartTouch" "ServerCommand,Command,changelevel coop_zelda01_b,5,-1"}
		"Map_Random_35"  {"OnTrigger" "ServerCommand,Command,changelevel coop_zelda01_b,0,-1"}
	    	"Map_Door_35"    {"OnHealthChanged" "text,DisplayText,coop_zelda01_b,0,-1"}
		"Map_Door_35"    {"OnHealthChanged" "text2,DisplayText,Author:zteer,0,-1"} 
		"Map_Door_35"    {"OnHealthChanged" "text3,DisplayText,Genre:Combat,0,-1"} 
		"Map_Door_35"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_35"   {"texture" "maps/oc_lobby/lobby_coop_zelda01_b"}

		"Map_Message_36" {"message" "oc_zelda02_g"}
		"logicauto"	{"OnTrigger" "Map_Toggle_36,Toggle, 0, -1"}
	    	"Map_Trigger_36" {"OnStartTouch" "ServerCommand,Command,changelevel oc_zelda02_g,5,-1"}
		"Map_Random_36"  {"OnTrigger" "ServerCommand,Command,changelevel oc_zelda02_g,0,-1"}
	    	"Map_Door_36"    {"OnHealthChanged" "text,DisplayText,oc_zelda02_g,0,-1"}
		"Map_Door_36"    {"OnHealthChanged" "text2,DisplayText,Author:zteer,0,-1"} 
		"Map_Door_36"    {"OnHealthChanged" "text3,DisplayText,Genre:Combat,0,-1"} 
		"Map_Door_36"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_36"   {"texture" "maps/oc_lobby/lobby_oc_zelda02_g"}

		"Map_Message_37" {"message" "oc_newgappi_g"}
		"logicauto"	{"OnTrigger" "Map_Toggle_37,Toggle, 0, -1"}
	    	"Map_Trigger_37" {"OnStartTouch" "ServerCommand,Command,changelevel oc_newgappi_g,5,-1"}
		"Map_Random_37"  {"OnTrigger" "ServerCommand,Command,changelevel oc_newgappi_g,0,-1"}
	    	"Map_Door_37"    {"OnHealthChanged" "text,DisplayText,oc_newgappi_g,0,-1"}
		"Map_Door_37"    {"OnHealthChanged" "text2,DisplayText,Author:zteer,0,-1"} 
		"Map_Door_37"    {"OnHealthChanged" "text3,DisplayText,Genre:Combat,0,-1"} 
		"Map_Door_37"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_37"   {"texture" "maps/oc_lobby/lobby_oc_newgappi_g"}

		"Map_Message_38" {"message" "oc_return_c17_01"}
		"logicauto"	{"OnTrigger" "Map_Toggle_38,Toggle, 0, -1"}
	    	"Map_Trigger_38" {"OnStartTouch" "ServerCommand,Command,changelevel oc_return_c17_01,5,-1"}
		"Map_Random_38"  {"OnTrigger" "ServerCommand,Command,changelevel oc_return_c17_01,0,-1"}
	    	"Map_Door_38"    {"OnHealthChanged" "text,DisplayText,oc_return_c17_01,0,-1"}
		"Map_Door_38"    {"OnHealthChanged" "text2,DisplayText,Author:DaMaN,0,-1"} 
		"Map_Door_38"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_38"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
		"Map_Decal_38"   {"texture" "maps/oc_lobby/lobby_oc_return_c17"}

		"Map_Message_39" {"message" "de_dust"}
		"logicauto"	{"OnTrigger" "Map_Toggle_39,Toggle, 0, -1"}
	    	"Map_Trigger_39" {"OnStartTouch" "ServerCommand,Command,changelevel de_dust,-1"}
		"Map_Random_39"  {"OnTrigger" "ServerCommand,Command,changelevel de_dust,0,-1"}
	    	"Map_Door_39"    {"OnHealthChanged" "text,DisplayText,de_dust,0,-1"}
		"Map_Door_39"    {"OnHealthChanged" "text2,DisplayText,MapAddAuthor:fug4life,0,-1"} 
		"Map_Door_39"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
		"Map_Door_39"    {"OnHealthChanged" "text4,DisplayText,Mounts:CSS,0,-1"}
		"Map_Decal_39"   {"texture" "maps/oc_lobby/lobby_de_dust"}
]]

hook.Add("InitPostEntity", "custom_map", function()
	print("CALLED")
    local spawner = parseString(MODIFY_MODIFY:gsub("\t", ""))

    for k, v in ipairs(spawner) do
        local targetname = v[1]
        local keyvalues = v[2]
       
        local aad = ents.FindByName(targetname)
        for _, v in pairs(keyvalues) do
            key = v[1]
            val = v[2]

            for _, entity in ipairs(aad) do
                entity:SetKeyValue(key, val)
            end

	        if (targetname:find("Map_Decal_")) then
	            local pos, ang = entity:GetPos(), entity:GetAngles()

	            local agony = ents.Create("poster")
	            agony:SetPos(pos)
	            agony:SetAngles(ang)
                agony:SetNetworkedVar(key, val)
	        end
        end

    end

    for k, v in ipairs(spawner) do
        local targetname = v[1]
        local keyvalues = v[2]
        
        if (targetname == "logicauto") then
            for _, v in pairs(keyvalues) do
                key = v[1]
                val = v[2]

                if (key == "OnTrigger") then
                    local tbl = string.Explode(',', val)

                    local enttbl = ents.FindByName(tbl[1])
                    for _, target in pairs(enttbl) do
                        target:Fire(tbl[2], tbl[3], tbl[4])
                    end
                end
            end
        end
    end
end)
--[[

//oc_lobby is a map selection level that server admins can use to let players choose what map they
//want to play. Players simply have to break down a particular map's door with their crowbar
//and run though the resulting hallway to select a map, a concept invented by zteer. More players 
//attacking a door will mean that door will get broken faster, so the map that the majority of the 
//players want to play will get picked.
//
//One half of the map contains doors for the half-life series, the other half contains custom maps
//which can be edited using this modify file for your own server. All half-life series games start
//enabled, but you can disable this for your server by deleting the line referencing a particular game.
//so if you want to disable half-life: source, you would go down to the TargetName bracket and find the
//line "logicauto"  {"OnTrigger" "Map_Toggle_HLS,Toggle, 0, -1"} and delete it. This will put a metal
//gate blocking the HL:S hallway so players cannot get to the doors for each chapter.
//
//For the custom map section of the level, each door is made up of a block of entities that are numbered
//all the way up to 112. To remove a map, simply go down to the Targetname section of this file and delete
//one of the blocks of text referencing entities of a particular number. To add a new map, you'll need to
//find an empty block and put several variables into specific spots:
//
//	    "Map_Message_[NUM]" {"message" "[MAP]"}
//	    "logicauto"	        {"OnTrigger" "Map_Toggle_[NUM],Toggle, 0, -1"}
//	    "Map_Trigger_[NUM]" {"OnStartTouch" "ServerCommand,Command,changelevel [MAP],5,-1"}
//	    "Map_Random_[NUM]"  {"OnTrigger" "ServerCommand,Command,changelevel [MAP],0,-1"}
//	    "Map_Door_[NUM]"    {"OnHealthChanged" "text,DisplayText,[MAP],0,-1"} 
//	    "Map_Door_[NUM]"    {"OnHealthChanged" "text2,DisplayText,Author:[AUTHOR],0,-1"} 
//	    "Map_Door_[NUM]"    {"OnHealthChanged" "text3,DisplayText,Genre:[GENRE],0,-1"} 
//	    "Map_Door_[NUM]"    {"OnHealthChanged" "text4,DisplayText,Mounts:[MOUNTS],0,-1"}
//	    "Map_Decal_[NUM]"   {"texture" "[VTF]"}
//
//			[NUM] 	- The free door number you want to add the map to
//			[MAP] 	- The filename of the map you want to add
//			[AUTHOR]- Name of the map's creator
//			[GENRE] - A tag (or possibly a combination of tags) that describe the level's gameplay
//				  For consistency, please use the tags: Linear, Combat, Puzzle, Funmap, and PVP
//			[MOUNTS]- Games that need to be mounted for this map
//			[VTF]   - The image that will appear in the frame next to the door (64x64 area)
//
//				 (Note: Do not use any spaces when entering these variables)
//
//
//So for example, if we wanted to add the map "oc_mymap", a linear/combat map made by SomeGuy with no
//mounts needed, to door 56 and had the material "somedir/oc_mymap_image", the block of text would look like:
//
//          "Map_Message_56" {"message" "oc_mymap"}	
//	    "logicauto"	     {"OnTrigger" "Map_Toggle_56,Toggle, 0, -1"}
//	    "Map_Trigger_56" {"OnStartTouch" "ServerCommand,Command,changelevel oc_mymap,5,-1"}
//	    "Map_Random_56"  {"OnTrigger" "ServerCommand,Command,changelevel oc_mymap,0,-1"}
//	    "Map_Door_56"    {"OnHealthChanged" "text,DisplayText,oc_mymap,0,-1"} 
//	    "Map_Door_56"    {"OnHealthChanged" "text2,DisplayText,Author:SomeGuy,0,-1"} 
//	    "Map_Door_56"    {"OnHealthChanged" "text3,DisplayText,Genre:Linear/Combat,0,-1"} 
//	    "Map_Door_56"    {"OnHealthChanged" "text4,DisplayText,Mounts:None,0,-1"}
//	    "Map_Decal_56"   {"texture" "somedir/oc_mymap_image"}
//
//Once you are finished, copy this block of text between the brackets of the Targetname section of 
//this file.

]]