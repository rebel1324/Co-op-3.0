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
if (SERVER) then
    MAPCHECKPOINTS = MAPCHECKPOINTS or {
        ["Spawns_1"] = {},
        ["Spawns_2"] = {},
        ["Spawns_3"] = {}, 
    }
    CHECKRELAYS = {
        ["PlatformRoom_Door_1"] = {}, -- [203][func_door_rotating]
        ["Reached_Checkpoint"] = {},
    }
    CURRENT_CHECKPOINT = "Spawns_1"

    hook.Add("InitPostEntity", "oc_stitches_1", function(player)
        for k, v in ipairs(ents.GetAll()) do
            if (CHECKRELAYS[v:GetName()]) then
                if (v and v:IsValid()) then
                    table.insert(CHECKRELAYS[v:GetName()], v)
                end
            end

            if (MAPCHECKPOINTS[v:GetName()]) then
                if (v and v:IsValid()) then
                    table.insert(MAPCHECKPOINTS[v:GetName()], v)
                end
            end
        end

        for tname, ents in pairs(CHECKRELAYS) do
            for k, v in ipairs(ents) do
                    print(v)
                if (tname == "PlatformRoom_Door_1") then
                    v:SetKeyValue("OnFullyOpen", "hooker,Message,CHECKPOINT REACHED,0,-1")
                    v:SetKeyValue("OnFullyOpen", "hooker,Spawn,Spawns_2,0,-1")         
                elseif (tname == "Reached_Checkpoint") then
                    v:SetKeyValue("EnableRefire", "hooker,Spawn,Spawns_3,0,-1")
                end
                
                print("HOOKED " .. tostring(v))
            end
        end
    end)

    hook.Add("MapSpawnPoint", "oc_stitches_1", function(player)
        local point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
        while (!point:IsValid()) do
            point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
        end

        return point
    end)

    hook.Add("OnEntityTriggered", "oc_stitches_1", function(inputName, activator, data)
        if (inputName == "Spawn") then
            CURRENT_CHECKPOINT = data
        end
    end)
end