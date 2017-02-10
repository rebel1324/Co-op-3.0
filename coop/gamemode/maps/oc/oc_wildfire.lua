-- OBSIDIAN CONFLICT OFFICIAL MAP
--[[
	PASTE TEXT HERE

]]
MAP_BREIFING = [[Obsidian Conflict

Map: oc_wildfire
Author: Tysn

Description:

After being stranded due to the APC's engine failure, your squad must make their way back to the rebel encampment.





Special Thanks:

Worfox - Fixing the g36c model
]]

if (SERVER) then
    MAPCHECKPOINTS = MAPCHECKPOINTS or {
        ["PlayerSpawnGroup_Spawns_1"] = {},
        ["PlayerSpawnGroup_Spawns_2"] = {},
        ["PlayerSpawnGroup_Spawns_3"] = {}, 
        ["PlayerSpawnGroup_Spawns_4"] = {}, 
        ["PlayerSpawnGroup_Spawns_5"] = {}, 
        ["PlayerSpawnGroup_Spawns_5a"] = {}, 
        ["PlayerSpawnGroup_Spawns_6"] = {}, 
    }
    CHECKRELAYS = {
        ["base_1_button_model"] = {},
        ["vent_ambush_vent"] = {},
    }
    CURRENT_CHECKPOINT = "PlayerSpawnGroup_Spawns_1"

    hook.Add("EntityKeyValue", "oc_freezingpoint", function( ent, key, value )
    	if (ent:GetClass() == "logic_relay") then
    		if (value:find("Harbor_SetupScript")) then
    			print("반동분자")
    			print(ent:GetName(), ent)
    			print(key, value)
    		end
    	end
    end)
    
    hook.Add("AcceptInput", "oc_freezingpoint", function(ent, input, activator, caller, value )
        if !(ent and ent:IsValid() and
            activator and activator:IsValid() and
            caller and caller:IsValid()) then return end

            print("ENTITY ACTIVATED!!!!!: ".. input)
            print(ent, activator, caller)
            print(IsValid(ent) and ent:GetName() or "NONE", IsValid(activator) and activator:GetName() or "NONE", IsValid(caller) or caller:GetName() or "NONE")
    end)

    hook.Add("InitPostEntity", "oc_wildfire", function(player)
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

            if (v:GetName() == "Harbor_SetupScript") then
            	v:Fire("Disable")
            end
        end

        for tname, ents in pairs(CHECKRELAYS) do
            for k, v in ipairs(ents) do
                if (tname == "base_1_button_model") then
                    v:SetKeyValue("OnAnimationDone", "hooker,Message,CHECKPOINT REACHED,0,-1")
                    v:SetKeyValue("OnAnimationDone", "hooker,Spawn,temp_middle_spawn,0,-1")         
                elseif (tname == "vent_ambush_vent") then
                    v:SetKeyValue("OnBreak", "hooker,Message,CHECKPOINT REACHED,0,-1")
                    v:SetKeyValue("OnBreak", "hooker,Spawn,player_start2,0,-1")
                end
                
                print("HOOKED " .. tostring(v))
            end
        end
    end)

    hook.Add("MapSpawnPoint", "oc_wildfire", function(player)
        local point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
        while (!point:IsValid()) do
            point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
        end

        return point
    end)

    hook.Add("OnEntityTriggered", "oc_wildfire", function(inputName, activator, data)
        if (inputName == "Spawn") then
            CURRENT_CHECKPOINT = data
        end
    end)
end