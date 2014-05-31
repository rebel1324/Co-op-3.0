HARDCORE = false -- use lives?
DEFAULT_LIVES = 3 -- how lives will be?

DEFAULT_MONEY = 100
PLAYER_DIFFICULTY_MULTIPLY = 1.5
PLAYER_DIFFICULTY_FACTOR = 20
DIFFICULTY = 1.2
TEAMKILL_PUNISHMENT = 0 -- 1 is killing the team killer, 2 is kicking the team killer, 3 is banning team killer.
TEAMKILL_BANTIME = 5 -- 5 minitues. setting this var to 0 will make ban perma.
ALLOW_SUICIDE = true

if SERVER then

	MAP_CYCLE = {
		"oc_trainride_a",
		"oc_antlion_attack_01",
		"syn_lvcoop_part1",
		"rebel_ways_01",
		"rebel_ways_02",
		"syn_urbanchaos"
	}

	REMOVE_ALL_ITEMS = false
	WEAPON_RESPAWN_TIME = 1
	ITEM_RESPAWN_TIME = 1

	DEFAULT_WEAPONS = {
		"weapon_crowbar",
		"weapon_physcannon",
		"spy_pistol",
		"coop_w_medic",
	}

	MAP_ENTITIES = {
		"coop_dispencer",
		"coop_healer",
	}

	DEFAULT_POINT_AWARD = {1, 5}
	DEFAULT_LOOTS_AMOUNT = {1, 3}
	DEFAULT_LOOTS_CHANCE = 30
	DEFAULT_LOOTS_BLACKLIST = {
		"npc_manhack",
		"npc_scanner",
		"npc_headcrab",
		"npc_turret_floor",
	}

	TAKEDAMAGE_BLACKLIST = {
		"npc_helicopter"
	}

	AMMO_SUPPLY_FACTOR = .1 -- Ammo Pack will supply <[ammo type limit]*[ammo supply factor]> amount of ammo to player.

else

	MAP_ENTITY_TEXTS = {
		["coop_dispencer"] = {name = lang.ent_vending, pos = function(ent) return ent:GetPos() + ent:GetUp()*40 end},
		["coop_healer"] = {name = lang.ent_healer, pos = function(ent) return ent:GetPos() + ent:GetUp()*28 end},
	}

end


AMMO_LIMITS = {}
AMMO_LIMITS["ar2"] = 180
AMMO_LIMITS["alyxgun"] = 100
AMMO_LIMITS["pistol"] = 150
AMMO_LIMITS["smg1"] = 200
AMMO_LIMITS["357"] = 30
AMMO_LIMITS["xbowbolt"] = 20
AMMO_LIMITS["buckshot"] = 30
AMMO_LIMITS["rpg_round"] = 5
AMMO_LIMITS["smg1_grenade"] = 15
AMMO_LIMITS["sniperround"] = 20
AMMO_LIMITS["sniperpenetratedround"] = 15
AMMO_LIMITS["grenade"] = 8
AMMO_LIMITS["thumper"] = 16
AMMO_LIMITS["gravity"] = 32
AMMO_LIMITS["battery"] = 64
AMMO_LIMITS["gaussenergy"] = 64
AMMO_LIMITS["combinecannon"] = 100
AMMO_LIMITS["airboatgun"] = 100
AMMO_LIMITS["striderminigun"] = 100
AMMO_LIMITS["helicoptergun"] = 100
AMMO_LIMITS["ar2altfire"] = 5
AMMO_LIMITS["slam"] = 5

MERCHANT_WEAPONS = {}

local wep = {}
wep.name = "Galiua Rifle"
wep.desc = "A Powerful gun that consumes AR2 ammo."
wep.price = 100
wep.icon = "galil"
wep.class = "spy_galil"
table.insert(MERCHANT_WEAPONS, wep)

local wep = {}
wep.name = "Democracy Rifle"
wep.desc = "A Powerful gun that consumes AR2 ammo."
wep.price = 100
wep.icon = "m4a1"
wep.class = "spy_m4a1"
table.insert(MERCHANT_WEAPONS, wep)

local wep = {}
wep.name = "Autovmat Rifle"
wep.desc = "A Powerful gun that consumes AR2 ammo."
wep.icon = "ak47"
wep.class = "spy_ak47"
wep.price = 100
table.insert(MERCHANT_WEAPONS, wep)

local wep = {}
wep.name = "URP Sub Machinegun"
wep.desc = "A Powerful gun that consumes SMG ammo."
wep.class = "spy_smg"
wep.price = 80
table.insert(MERCHANT_WEAPONS, wep)

local wep = {}
wep.name = "Terminator Sub Machinegun"
wep.desc = "A Powerful gun that consumes SMG ammo."
wep.icon = "tmp"
wep.class = "spy_tmp"
wep.price = 170
table.insert(MERCHANT_WEAPONS, wep)

local wep = {}
wep.name = "Sniper Pistol"
wep.desc = "A Powerful gun that consumes Sniper ammo."
wep.price = 150
wep.icon = "deagle"
wep.class = "weapon_sniperrifle"
table.insert(MERCHANT_WEAPONS, wep)

local wep = {}
wep.name = "Compact Pistol"
wep.desc = "A Powerful gun that consumes Pistol ammo."
wep.price = 30
wep.icon = "p228"
wep.class = "spy_pistol"
table.insert(MERCHANT_WEAPONS, wep)

local wep = {}
wep.name = "Grenade Launcher"
wep.desc = "Special Grenade Launcher. Consumes Grenade shell."
wep.price = 300
wep.icon = "smg1"
wep.class = "spy_glauncher"
table.insert(MERCHANT_WEAPONS, wep)

local wep = {}
wep.name = "Mark.II Rebelion Turret"
wep.desc = "Rebel-Manufactured Well-made Automatic Turret."
wep.price = 250
wep.icon = "turret"
wep.class = "coop_w_turret"
table.insert(MERCHANT_WEAPONS, wep)

MERCHANT_AMMO = {}

local ammo = {}
ammo.name = "Pistol Ammo"
ammo.desc = "A Small Pistol Round."
ammo.price = 1
ammo.icon = "ammo3"
ammo.ammo = "pistol"
table.insert(MERCHANT_AMMO, ammo)

local ammo = {}
ammo.name = "357 Ammo"
ammo.desc = "A Medium 357 Magnum Round."
ammo.price = 5
ammo.icon = "ammo3"
ammo.ammo = "357"
table.insert(MERCHANT_AMMO, ammo)

local ammo = {}
ammo.name = "SMG Ammo"
ammo.desc = "A Medium Sub Machine Gun Round."
ammo.price = 2
ammo.icon = "ammo1"
ammo.ammo = "smg1"
table.insert(MERCHANT_AMMO, ammo)

local ammo = {}
ammo.name = "AR2 Ammo"
ammo.desc = "A Large AR2 Round."
ammo.price = 3
ammo.icon = "ammo1"
ammo.ammo = "ar2"
table.insert(MERCHANT_AMMO, ammo)

local ammo = {}
ammo.name = "Shotgun Ammo"
ammo.desc = "A Medium Buckshot Shells."
ammo.price = 4
ammo.icon = "ammo4"
ammo.ammo = "buckshot"
table.insert(MERCHANT_AMMO, ammo)

local ammo = {}
ammo.name = "Grenade Shell"
ammo.desc = "A Medium Grenade Shells."
ammo.price = 8
ammo.icon = "ammo3"
ammo.ammo = "smg1_grenade"
table.insert(MERCHANT_AMMO, ammo)

MERCHANT_EQUIPMENTS = {}

EQUIPMENT_CHEST = 1
EQUIPMENT_ACTIVE = 2

local eq = {}
eq.name = "Combat Armor Mk.I"
eq.desc = "Multi-Purpose BTC Made Quality 'B' Armor for Universal Soldiers.\nAbsorbs 10% of the damage."
eq.price = 80
eq.class = EQUIPMENT_CHEST
eq.uniqueid = "combat_armor_1"
table.insert(MERCHANT_EQUIPMENTS, eq)

local eq = {}
eq.name = "Combat Armor Mk.II"
eq.desc = "Multi-Purpose BTC Made Quality 'A' Armor for Universal Soldiers.\nAbsorbs 20% of the damage."
eq.price = 200
eq.class = EQUIPMENT_CHEST
eq.uniqueid = "combat_armor_2"
table.insert(MERCHANT_EQUIPMENTS, eq)

local eq = {}
eq.name = "Combat Armor Mk.III"
eq.desc = "Multi-Purpose BTC Made Quality 'S' Armor for Universal Soldiers.\nAbsorbs 30% of the damage.\nSlows movement a bit."
eq.price = 350
eq.class = EQUIPMENT_CHEST
eq.uniqueid = "combat_armor_3"
table.insert(MERCHANT_EQUIPMENTS, eq)

local eq = {}
eq.name = "Combat Armor Mk.VI"
eq.desc = "Multi-Purpose BTC Made Quality Handmade Armor for Universal Soldiers.\nAbsorbs 40% of the damage.\nSlows movement a bit."
eq.price = 500
eq.class = EQUIPMENT_CHEST
eq.uniqueid = "combat_armor_4"
table.insert(MERCHANT_EQUIPMENTS, eq)

local eq = {}
eq.name = "Portable Thumper"
eq.desc = "Portable AR2 Plasma Powered Mini-Thumper.\nCan thump the ground with 'Undo' Key.\n1 Minitue of Cooldown."
eq.price = 250
eq.class = EQUIPMENT_ACTIVE
eq.uniqueid = "act_thumper"
table.insert(MERCHANT_EQUIPMENTS, eq)

local eq = {}
eq.name = "Killswitch Activator"
eq.desc = "High-tech Hacking signal Transmitter for all Mechanic Objects.\nCan emit Fake Signals with 'Undo' Key.\n1 Minitue 30 Seconds of Cooldown."
eq.price = 350
eq.class = EQUIPMENT_ACTIVE
eq.uniqueid = "act_killswicth"
table.insert(MERCHANT_EQUIPMENTS, eq)

local eq = {}
eq.name = "Highspeed Gyro Boots"
eq.desc = "Highspeed Gyro included Boots calculates safe-fall angle for the owner.\nCan reduce Fall Damage for 10 seconds with 'Undo' Key \n1 Minitue of Cooldown."
eq.price = 150
eq.class = EQUIPMENT_ACTIVE
eq.uniqueid = "act_gyroboots"
table.insert(MERCHANT_EQUIPMENTS, eq)

local eq = {}
eq.name = "Emergency Lifesaver"
eq.desc = "Designed and made for urgent injured subject.\nCan activate Emergency Heal with 'Undo' Key \n3 Minitues of Cooldown."
eq.price = 300
eq.class = EQUIPMENT_ACTIVE
eq.uniqueid = "act_lifesaver"
table.insert(MERCHANT_EQUIPMENTS, eq)

local eq = {}
eq.name = "Rocket Barrage"
eq.desc = "Launch few rockets against enemy front.\nCan launch rocket barrage with 'Undo' Key \n2 Minitues of Cooldown."
eq.price = 300
eq.class = EQUIPMENT_ACTIVE
eq.uniqueid = "act_rocketbarrage"
table.insert(MERCHANT_EQUIPMENTS, eq)


MERCHANT_PERKS = {}

/*
	DONT TOUCH ANYTHING BELOW HERE.
*/


AMMO_TRANS = {}

AMMO_TRANS[-1] = "none"
AMMO_TRANS[0] = "none"
AMMO_TRANS[1] = "ar2"
AMMO_TRANS[2] = "alyxgun"
AMMO_TRANS[3] = "pistol"
AMMO_TRANS[4] = "smg1"
AMMO_TRANS[5] = "357"
AMMO_TRANS[6] = "xbowbolt"
AMMO_TRANS[7] = "buckshot"
AMMO_TRANS[8] = "rpg_round"
AMMO_TRANS[9] = "smg1_grenade"
AMMO_TRANS[13] = "sniperround"
AMMO_TRANS[11] = "sniperpenetratedround"
AMMO_TRANS[12] = "grenade"
AMMO_TRANS[10] = "thumper"
AMMO_TRANS[14] = "gravity"
AMMO_TRANS[14] = "battery"
AMMO_TRANS[15] = "gaussenergy"
AMMO_TRANS[16] = "combinecannon"
AMMO_TRANS[17] = "airboatgun"
AMMO_TRANS[18] = "striderminigun"
AMMO_TRANS[19] = "helicoptergun"
AMMO_TRANS[20] = "ar2altfire"
AMMO_TRANS[21] = "slam"

TEAM_SPECTATE = 0
TEAM_ALIVE = 1
TEAM_DEAD = 2

DEAD_LIST = {}

if CLIENT then
	local temp_icon = {}
	ICON_MATERIALS = ICON_MATERIALS or {}

	local icon= {
		name = "default",
		model = "models/weapons/w_irifle.mdl",
		origin = Vector( 1.8000001907349, 2.1000001430511, 0 ),
		angle = Angle( 20.400032043457, -24.900035858154, 10.999998092651 ),
		distance = 20,
		fov = 46.028880866426,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "m4a1",
		model = "models/weapons/w_rif_m4a1.mdl",
		origin = Vector( -11.900003433228, -5.9000015258789, -0.40000370144844 ),
		angle = Angle( 34.84659576416, 141.36614990234, 24.199989318848 ),
		distance = 170.21668274451,
		fov = 4.8442336436176,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "ak47",
		model = "models/weapons/w_rif_ak47.mdl",
		origin = Vector( -10.10003433228, -5.9000015258789, -1.4000370144844 ),
		angle = Angle( 34.84659576416, 141.36614990234, 24.199989318848 ),
		distance = 170.21668274451,
		fov = 4.8442336436176,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "galil",
		model = "models/weapons/w_rif_galil.mdl",
		origin = Vector( -11.900003433228, -5.9000015258789, -1.4000370144844 ),
		angle = Angle( 34.84659576416, 141.36614990234, 24.199989318848 ),
		distance = 170.21668274451,
		fov = 4.8442336436176,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "p228",
		model = "models/weapons/w_pist_p228.mdl",
		origin = Vector( 0.66678547859192, -1.7040070295334, 4.3958506584167 ),
		angle = Angle( -2.5817420482635, 168.6563873291, 54.934902191162 ),
		distance = 17.333476723808,
		fov = 17.148014440433,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "deagle",
		model = "models/weapons/w_pist_deagle.mdl",
		origin = Vector( 0.66678547859192, -2.240070295334, 4.3958506584167 ),
		angle = Angle( -2.5817420482635, 155.6563873291, 49.934902191162 ),
		distance = 20.333476723808,
		fov = 17.148014440433,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "ammo1",
		model = "models/items/boxsrounds.mdl",
		origin = Vector( -1.4901161193848e-008, -1.1000000238419, 5.1999974250793 ),
		angle = Angle( 3.8000001907349, 85.399932861328, 0.80000007152557 ),
		distance = 46.936823104693,
		fov = 16.819957015009,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "ammo2",
		model = "models/items/boxmrounds.mdl",
		origin = Vector( -1.4901161193848e-008, -1.1000000238419, 5.1999974250793 ),
		angle = Angle( 3.8000001907349, 85.399932861328, 0.80000007152557 ),
		distance = 46.936823104693,
		fov = 16.819957015009,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "ammo3",
		model = "models/items/357ammo.mdl",
		origin = Vector( -1.9000002145767, 2.1000001430511, 0 ),
		angle = Angle( 9.4000024795532, 77.900016784668, -1.8999999761581 ),
		distance = 51.19048268636,
		fov = 11.542263020019,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "ammo4",
		model = "models/items/boxbuckshot.mdl",
		origin = Vector( -0.20000000298023, -0.19999998807907, 4.5999989509583 ),
		angle = Angle( 17.399982452393, 83.200080871582, -1.0000001192093 ),
		distance = 50.44886858172,
		fov = 11.642307158844,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "battery",
		model = "models/items/car_battery01.mdl",
		origin = Vector( 0.60000002384186, 0.59999996423721, -0.60000002384186 ),
		angle = Angle( 1.7999943494797, -93.299896240234, -0.10000000149012 ),
		distance = 81.455436470614,
		fov = 10.537671668579,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "armor",
		model = "models/props_c17/suitcase001a.mdl",
		origin = Vector( 0.49999997019768, -0.60000002384186, -2.0000002384186 ),
		angle = Angle( 8.4000015258789, -187.20027160645, 0 ),
		distance = 135.20758122744,
		fov = 9.1833465892224,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "turret",
		model = "models/combine_turrets/floor_turret.mdl",
		origin = Vector( 8.4346008300781, -4.600691318512, 31.283390045166 ),
		angle = Angle( -27.812225341797, 158.77670288086, 288.22689819336 ),
		distance = 207.26534296029,
		fov = 11.73285198556,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "tmp",
		model = "models/weapons/w_smg_tmp.mdl",
		origin = Vector( 19.000026702881, 7.2999954223633, -0.79999995231628 ),
		angle = Angle( -61.599987030029, 175.29983520508, 0.5 ),
		distance = 55.406303653715,
		fov = 10.245769410028,
	}
	table.insert(temp_icon, icon)

	local icon = {
		name = "smg1",
		model = "models/weapons/w_smg1.mdl",
		origin = Vector( 0.5999995470047, 1.5000001192093, -1 ),
		angle = Angle( -71.999992370605, -166.49984741211, -12.899995803833 ),
		distance = 20,
		fov = 22.563176895307,
	}
	table.insert(temp_icon, icon)

	timer.Simple(2, function()
		for k, v in ipairs(temp_icon) do
			ICON_MATERIALS[v.name] = GetIconRenderer( v, 0, 64, 64 )
		end
	end)
end
