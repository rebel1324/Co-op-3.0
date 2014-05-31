texttable = texttable or {}
function MapTextAdd(text, pos, ang, scale)
	table.insert(texttable, {text = text, pos = pos, angle = ang, scale = scale})
end

if CLIENT then
	surface.CreateFont("MapTextFont", {
		font = "Trajan Pro",
		size = 40,
		weight = 800,
		shadow = true,
		antialias = true,
	})

	textsample = textsample or {}
	textsample.enabled = textsample.enabled or false
	textsample.pos = Vector(0,0,0)
	textsample.angle = Angle(0,0,0)
	textsample.scale = .25
	textsample.text = "This is sample text."

	local maxdist = 800
	hook.Add("PostDrawTranslucentRenderables", "3dtext.draw", function()
		-- example
		if textsample and textsample.enabled then
			cam.Start3D2D(textsample.pos, textsample.angle, textsample.scale or 0.25)
				draw.SimpleText(textsample.text, "MapTextFont", 0, 0, Color(255, 255, 255), 1, 1)
			cam.End3D2D()
		end

		for k, v in ipairs(texttable) do
			local dist = v.pos:Distance(LocalPlayer():GetPos())
			local alpha = math.Clamp( maxdist + 255 - dist, 0, 255 )

			cam.Start3D2D(v.pos, v.angle, v.scale)
				draw.SimpleText(v.text, "MapTextFont", 0, 0, Color(255, 255, 255, alpha), 1, 1)
			cam.End3D2D()
		end
	end)

	netstream.Hook("MapTextServer", function(data)
		MapTextAdd(text, pos, ang, scale)
	end)

	netstream.Hook("MapTextSync", function(data)
		texttable = data

		if textmanager and textmanager:IsVisible() then
			textmanager:Close()
			textmanager = nil
			OpenTextManager()
		end
	end)
else

	function SaveMapTexts()
		local map = string.lower(game.GetMap())

		file.CreateDir("coop")
		file.CreateDir("coop/maps")
		file.CreateDir("coop/maps/"..map)
		local encoded = von.serialize(texttable)

		file.Write("coop/maps/"..map.."/maptexts.txt", encoded)
	end

	function LoadMapTexts()
		local map = string.lower(game.GetMap())

		local contents 
		local decoded

		if (file.Exists("coop/maps/"..map.."/maptexts.txt", "DATA")) then
			contents = file.Read("coop/maps/"..map.."/maptexts.txt", "DATA")
		end

		if contents then
			decoded = von.deserialize(contents)
		end

		if decoded then
			texttable = decoded
		end
	end

	hook.Add("InitPostEntity", "3dtext.load", LoadMapTexts)

	netstream.Hook("MapTextUpdateRequest", function(ply, data)
		local delete, index, text = data[1], data[2], data[3]

		if 1 or ply:IsAdmin() then -- only admin can auth fucking text.
			if delete then
				table.remove(texttable, index)
			else
				texttable[index].text = text
			end

			SaveMapTexts()
			netstream.Start(player.GetAll(), "MapTextSync", texttable) -- It's fucking not efficient but I'm fucking lazy to improve this.
			-- also you can't even set co-op map when players are playing on the map.
		end
	end)

	netstream.Hook("MapTextRequest", function(ply, data)
		local text, pos, ang, scale = data[1], data[2], data[3], data[4]

		if 1 or ply:IsAdmin() then -- only admin can auth fucking text.
			MapTextAdd(text, pos, ang, scale)

			SaveMapTexts()
			netstream.Start(player.GetAll(), "MapTextSync", texttable) -- It's fucking not efficient but I'm fucking lazy to improve this.
			-- also you can't even set co-op map when players are playing on the map.
		end
	end)

	hook.Add("PlayerAuthed", "3dtext.sync", function(ply)
		netstream.Start(ply, "MapTextSync", texttable)
	end)
end