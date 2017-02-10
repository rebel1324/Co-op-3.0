-- OBSIDIAN CONFLICT OFFICIAL MAP
--[[
	PASTE TEXT HERE

]]
MAP_BREIFING = [[Obsidian Conflict

Map: oc_fireteam_2
Author: Tysn

Description:

Having reached the outpost and sucessfully defended it, you have received news that contact has been lost with another outpost located past the mountains. You are to travel through a set of underground caves to reach the outpost and deal with the situation there.
]]

MODIFY_ADD = [[    
        "point_teleport"
        {
            "angles" "0 0 0"
            "radius" "640"
            "spawnflags" "2048"
            "StartEnabled" "1"
            "TeleportDestination" "SpawnGroup_*"
            "origin" "-8 -8 9"
        }

        "weapon_scripted"
        {
            "angles" "0 342.5 -90"
            "customweaponscript" "custom_spas12"
            "fademaxdist" "0"
            "fademindist" "-1"
            "fadescale" "1"
            "minplayerstospawn" "0"
            "spawnflags" "-1073741824"
            "origin" "5462 -6450 217"
        }
        "item_box_buckshot"
        {
            "angles" "0 225 0"
            "disableshadows" "0"
            "fademaxdist" "0"
            "fademindist" "-1"
            "fadescale" "1"
            "minplayerstospawn" "0"
            "spawnflags" "-1073741824"
            "origin" "5490 -6451 214.294"
        }
        "weapon_scripted"
        {
            "angles" "0 183 -90"
            "customweaponscript" "custom_oicw"
            "fademaxdist" "0"
            "fademindist" "-1"
            "fadescale" "1"
            "minplayerstospawn" "0"
            "spawnflags" "-1073741824"
            "origin" "7614 1079.29 603"
        }
        "item_ammo_smg1"
        {
            "angles" "0 298.5 0"
            "disableshadows" "0"
            "fademaxdist" "0"
            "fademindist" "-1"
            "fadescale" "1"
            "minplayerstospawn" "0"
            "spawnflags" "-1073741824"
            "origin" "7622 1064 600.345"
        }
        "item_ammo_smg1"
        {
            "angles" "0 192 0"
            "disableshadows" "0"
            "fademaxdist" "0"
            "fademindist" "-1"
            "fadescale" "1"
            "minplayerstospawn" "0"
            "spawnflags" "-1073741824"
            "origin" "7602 1060 600.345"
        }
        "item_healthkit"
        {
            "angles" "0 192 0"
            "disableshadows" "0"
            "fademaxdist" "0"
            "fademindist" "-1"
            "fadescale" "1"
            "minplayerstospawn" "0"
            "spawnflags" "-1073741824"
            "origin" "7562.35 1079.97 600.281"
        }
        "item_healthkit"
        {
            "angles" "0 304.5 0"
            "disableshadows" "0"
            "fademaxdist" "0"
            "fademindist" "-1"
            "fadescale" "1"
            "minplayerstospawn" "0"
            "spawnflags" "-1073741824"
            "origin" "7577 1080 600.281"
        }
        "item_battery"
        {
            "angles" "0 57.5 0"
            "disableshadows" "0"
            "fademaxdist" "0"
            "fademindist" "-1"
            "fadescale" "1"
            "minplayerstospawn" "0"
            "spawnflags" "-1073741824"
            "origin" "7561 1061 600.276"
        }
        "weapon_alyxgun"
        {
            "angles" "0 41.5 -75"
            "fademaxdist" "0"
            "fademindist" "-1"
            "fadescale" "1"
            "minplayerstospawn" "0"
            "spawnflags" "-1073741824"
            "origin" "7839 -19 209"
        }
        "weapon_rpg"
        {
            "angles" "0 340.5 -90"
            "fademaxdist" "1200"
            "fademindist" "1100"
            "fadescale" "1"
            "hammerid" "203314"
            "minplayerstospawn" "0"
            "spawnflags" "-1073741824"
            "origin" "9713 10660 100"
        }
        "item_ammo_crate"
        {
            "AmmoType" "3"
            "angles" "0 226 0"
            "fademaxdist" "0"
            "fademindist" "-1"
            "fadescale" "1"
            "hammerid" "193866"
            "origin" "9761 10689 111"
        }
        "npc_turret_floor"
        {
            "angles" "0 232.5 0"
            "hammerid" "193810"
            "model" "models/combine_turrets/floor_turret.mdl"
            "spawnflags" "0"
            "origin" "9808 10714 107"
        }
        "combine_mine"
        {
            "angles" "0 0 0"
            "bounce" "1"
            "hammerid" "134179"
            "LockSilently" "1"
            "spawnflags" "0"
            "StartDisarmed" "0"
            "origin" "9700 10609 103.918"
        }
        "combine_mine"
        {
            "angles" "0 280.5 0"
            "bounce" "1"
            "hammerid" "134179"
            "LockSilently" "1"
            "spawnflags" "0"
            "StartDisarmed" "0"
            "origin" "9662 10687 103.918"
        }
        "combine_mine"
        {
            "angles" "0 234.5 0"
            "bounce" "1"
            "hammerid" "134179"
            "LockSilently" "1"
            "spawnflags" "0"
            "StartDisarmed" "0"
            "origin" "9790 10583 103.918"
        }
        "weapon_rpg"
        {
            "angles" "0 340.5 -90"
            "fademaxdist" "1200"
            "fademindist" "1100"
            "fadescale" "1"
            "hammerid" "203314"
            "minplayerstospawn" "0"
            "spawnflags" "0"
            "origin" "8152 9716.8 92"
        }
        "npc_turret_floor"
        {
            "angles" "0 75 0"
            "hammerid" "193810"
            "model" "models/combine_turrets/floor_turret.mdl"
            "spawnflags" "0"
            "origin" "8123 9708.98 92"
        }
        "shadow_control"
        {
            "angles" "0 0 0"
            "color" "128 128 128"
            "disableallshadows" "0"
            "distance" "75"
            "origin" "-6461.86 -10340.2 145"
        }]]
MODIFY_MODIFY = [[
            "9797 10725 102"
            {
                "angles" "0 216.5 0"
                "origin" "9781 10739 107"
            }
]]

if (SERVER) then
    MAPCHECKPOINTS = MAPCHECKPOINTS or {
        ["SpawnGroup_1"] = {},
        ["SpawnGroup_2"] = {},  
        ["SpawnGroup_3"] = {},  
    }
    CURRENT_CHECKPOINT = "SpawnGroup_1"

    local blacklist = {
        "weapon_scripted",
    }

    hook.Add("InitPostEntity", "oc_fireteam_1", function(player)
        for k, v in ipairs(ents.GetAll()) do
            if (MAPCHECKPOINTS[v:GetName()]) then
                if (v and v:IsValid()) then
                    table.insert(MAPCHECKPOINTS[v:GetName()], v)
                end
            end
        end

        local spawner = parseString(MODIFY_ADD:gsub("\t", ""))
        for k, v in ipairs(spawner) do
            local classname = v[1]
            local keyvalues = v[2]
            
            if (table.HasValue(blacklist, classname)) then
                continue
            end

            SOLID = nil
            if (classname == "prop_dynamic_override") then
                classname = "prop_physics"
                SOLID = true
            end

            if (classname == "prop_physics_override") then
                classname = "prop_physics"
                --SOLID = true
            end

            --if (true) then continue end

            local entity = ents.Create(classname)
            if (entity and entity:IsValid()) then
                for _, v in pairs(keyvalues) do
                    key = v[1]
                    val = v[2]
                    entity:SetKeyValue(key, val)

                    if key == "origin" then
                        local aots = string.Explode( " ", val)
                        entity:SetPos(Vector(aots[1], aots[2], aots[3]))
                    elseif key == "angles" then
                        local aots = string.Explode( " ", val)
                        entity:SetAngles(Angle(aots[1], aots[2], aots[3]))
                    elseif key == "model" then
                        entity:SetModel(val)
                    end

                    if (SOLID) then
                        timer.Simple(0, function()
                            if (entity and entity:IsValid()) then 
                                entity:SetMoveType(MOVETYPE_NONE)

                                local phys = entity:GetPhysicsObject()

                                if phys and phys:IsValid() then
                                    phys:Sleep()
                                    phys:EnableMotion(true)
                                end
                            end
                        end)
                    end

                end

                entity:Spawn()
            end
        end

    end)

    hook.Add("OnEntityTriggered", "custom_map", function(inputName, activator, data)
        if (inputName == "Spawn") then
            CURRENT_CHECKPOINT = data
        end
    end)

    hook.Add("EntityKeyValue", "oc_fireteam_1", function(entity, key, value)
        if (value:find("heck")) then
            print(entity)
            print(entity:GetName(), key, value)
        end

        if (value:find("Reached_Checkpoint,Trigger,,0,1")) then
            entity:SetKeyValue("OnTrigger", "hooker,Spawn,SpawnGroup_2,0,-1")    
        elseif (value:find("Reached_Checkpoint,Disable,,0,1")) then
            entity:SetKeyValue("OnTrigger", "hooker,Spawn,SpawnGroup_3,0,-1")      
        end
    end)

    hook.Add("MapSpawnPoint", "oc_fireteam_1", function(player)
        local point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
        while (!point:IsValid()) do
            point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
        end

        return point
    end)
end
