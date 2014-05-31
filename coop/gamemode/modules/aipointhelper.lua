// AI HELPER
local rallypoints = {
	//{ vector, name, target }
} 

local assaultpoint = {
	//{ vector, name, target }
} 

local pathtracks = {
	//{ vector, name, target, radius }
}

local pathcorner = {
	//{ vector, name, target, wait, speed }
}

function AddAssaultPoint( vec, name, tgt )
	table.insert(assaultpoint, {vec = vec, name = name, tgt = tgt})
end

function AddRallyPoint( vec, name, tgt )
	table.insert(rallypoints, {vec = vec, name = name, tgt = tgt})
end

function AddPathTrack( vec, name, tgt, rad )
	table.insert(pathtracks, {vec = vec, name = name, tgt = tgt, rad = rad})
end

function AddPathCorner( vec, name, target, wait, speed )
	table.insert(pathtracks, {vec = vec, name = name, tgt = target, wait = wait, spd = speed})
end

function SpawnAPC( vec, ang, name )
	if !vec then
		Error("Spawn NPC: No specified vector!")
	elseif !ang then
		Error("Spawn NPC: No specified angles!")
	elseif !name then
		Error("Spawn NPC: No specified target name!")
	end

	local apc = ents.Create("prop_vehicle_apc")
	apc:SetKeyValue( "model", "models/combine_apc.mdl" )
	apc:SetKeyValue( "vehiclescript", "scripts/vehicles/apc_npc.txt" )
	apc:SetKeyValue( "actionScale", "1" )
	apc:SetPos(vec)
	apc:SetAngles(ang)
	apc:SetName(apc:EntIndex().."_apc")
	apc:Spawn()
	apc:Activate()

	local driver = ents.Create("npc_vehicledriver")
	driver:SetPos(vec)
	driver:SetAngles(ang)
	driver:SetName(apc:EntIndex().."_apc" .. "_driver")
	driver:Spawn()
	driver:Activate()
	driver:SetKeyValue("vehicle", apc:EntIndex().."_apc" .. "_driver")
	driver:SetKeyValue("drivermaxspeed", "1")
	driver:SetKeyValue("physdamagescale", "1.0")

	return apc, driver
end

function SpawnHelicopter( vec, ang, name )
	local heli = ents.Create("npc_helicopter")
	heli:SetPos(vec)
	heli:SetAngles(ang)
	heli:Spawn()
	heli:Activate()

	return heli
end

hook.Add("InitPostEntity", "aipoints.spawn", function()
	for k, v in ipairs(rallypoints) do
		local rally = ents.Create("assault_rallypoint")
		rally:SetPos(v.vec)
		rally:SetName(v.name)
		rally:Spawn()
		if v.tgt then
			rally:SetKeyValue("target", v.tgt)
		end
	end

	for k, v in ipairs(assaultpoint) do
		local rally = ents.Create("assault_assaultpoint")
		rally:SetPos(v.vec)
		rally:SetName(v.name)
		rally:Spawn()
		if v.tgt then
			rally:SetKeyValue("target", v.tgt)
		end
	end

	for k, v in ipairs(pathtracks) do
		local track = ents.Create("path_track")
		track:SetPos(v.vec)
		track:SetName(v.name)
		track:Spawn()
		track:Activate()
		if v.name then
			track:SetKeyValue("targetname", v.name)
		end
		if v.rad then
			track:SetKeyValue("radius", v.rad)
		end
		if v.tgt then
			track:SetKeyValue("target", v.tgt)
		end
		track:SetKeyValue("orientationtype", "1")
	end

	for k, v in ipairs(pathcorner) do
		local track = ents.Create("path_corner")
		track:SetPos(v.vec)
		track:SetName(v.name)
		track:Spawn()
		track:Activate()
		if v.name then
			track:SetKeyValue("targetname", v.name)
		end
		if v.rad then
			track:SetKeyValue("radius", v.rad)
		end
		if v.tgt then
			track:SetKeyValue("target", v.tgt)
		end
		track:SetKeyValue("orientationtype", "1")
	end
end)