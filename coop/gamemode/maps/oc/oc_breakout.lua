-- OBSIDIAN CONFLICT OFFICIAL MAP
--[[
	PASTE TEXT HERE

]]
MAP_BREIFING = [[Obsidian Conflict

Map: oc_breakout
Author: Tysn

Description:

Begin escaping from prison while the combine are distracted by rebel mortars.
]]



if (SERVER) then
    MAPCHECKPOINTS = MAPCHECKPOINTS or {
        ["PlayerSpawns_0"] = {},
        ["PlayerSpawns_1"] = {},
        ["PlayerSpawns_2"] = {}, 
        ["PlayerSpawns_3"] = {}, 
        ["PlayerSpawns_4"] = {}, 
    }
    CHECKRELAYS = {
        ["Checkpoint_1"] = {},
        ["Checkpoint_2"] = {},
        ["Checkpoint_3"] = {},
        ["Checkpoint_4"] = {},
    }
    CURRENT_CHECKPOINT = "PlayerSpawns_0"

    hook.Add("InitPostEntity", "oc_breakout", function(player)
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

        local spawnTable = {
        	Checkpoint_1 = "PlayerSpawns_1",
        	Checkpoint_2 = "PlayerSpawns_2",
        	Checkpoint_3 = "PlayerSpawns_3",
        	Checkpoint_4 = "PlayerSpawns_4",
    	}

        for tname, ents in pairs(CHECKRELAYS) do
            for k, v in ipairs(ents) do
                v:SetKeyValue("OnTrigger", "hooker,Message,CHECKPOINT REACHED,0,-1")
                v:SetKeyValue("OnTrigger", "hooker,Spawn," .. spawnTable[v:GetName()] .. ",0,-1")     
                
                print("HOOKED " .. tostring(v))
            end
        end
    end)

    hook.Add("MapSpawnPoint", "oc_breakout", function(player)
        local point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
        while (!point:IsValid()) do
            point = table.Random(MAPCHECKPOINTS[CURRENT_CHECKPOINT])
        end

        return point
    end)

    hook.Add("OnEntityTriggered", "oc_breakout", function(inputName, activator, data)
        if (inputName == "Spawn") then
            CURRENT_CHECKPOINT = data
        end
    end)

	hook.Add("EntityKeyValue", "oc_breakout", function( ent, key, value )
			if (value:find("spawn")) then
				print(ent:GetName(), ent)
				print(key, value)
			end

		if (ent:GetClass() == "logic_relay") then
			if (value:find("Harbor_SetupScript")) then
				print("반동분자")
				print(ent:GetName(), ent)
				print(key, value)
			end
		end
	end)
end
