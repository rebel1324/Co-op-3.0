if SERVER then
	local playerclips = {}

	function AddPlayerBarrier( min, max )
		table.insert(playerclips, {min, max})
	end

	hook.Add("InitPostEntity", "playerclip.addass", function()
		local spawnpos, obb
		for _, vecs in ipairs(playerclips) do
			obb = (vecs[2]-vecs[1])/2
			spawnpos = vecs[1] + obb

			local c_brush = ents.Create("brush_playerclip")
			c_brush:SetNWVector("obb", obb)
			c_brush:SetPos(spawnpos)
			c_brush:Spawn()
			c_brush:Activate()
		end
	end)	
end