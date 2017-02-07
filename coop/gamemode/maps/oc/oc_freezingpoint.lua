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

if (SERVER) then
    MAPCHECKPOINTS = MAPCHECKPOINTS or {
        ["first_spawn"] = {},
        ["temp_middle_spawn"] = {},
        ["player_start2"] = {}, 
    }
    CHECKRELAYS = {
        ["base_1_button_model"] = {},
        ["vent_ambush_vent"] = {},
    }
    CURRENT_CHECKPOINT = "first_spawn"

    hook.Add("InitPostEntity", "oc_freezingpoint", function(player)
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
                if (tname == "base_1_button_model") then
                    print(v)
                    v:SetKeyValue("OnAnimationDone", "hooker,Message,CHECKPOINT REACHED,0,-1")
                    v:SetKeyValue("OnAnimationDone", "hooker,Spawn,temp_middle_spawn,0,-1")         
                elseif (tname == "vent_ambush_vent") then
                    print("VENT")
                    v:SetKeyValue("OnBreak", "hooker,Message,CHECKPOINT REACHED,0,-1")
                    v:SetKeyValue("OnBreak", "hooker,Spawn,player_start2,0,-1")
                end
                
                print("HOOKED " .. tostring(v))
            end
        end
    end)

    hook.Add("MapSpawnPoint", "oc_freezingpoint", function(player)
        local point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
        while (!point:IsValid()) do
            point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
        end

        return point
    end)

    hook.Add("OnEntityTriggered", "oc_freezingpoint", function(inputName, activator, data)
        if (inputName == "Spawn") then
            CURRENT_CHECKPOINT = data
        end
    end)
end