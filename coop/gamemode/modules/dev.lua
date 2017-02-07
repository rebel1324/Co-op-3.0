dev = {}

if (CLIENT) then
	WOWDATA  = WOWDATA or {}

	netstream.Hook("fullUpdateEntity", function(dataTable)
		WOWDATA = dataTable
	end)

	hook.Add("HUDPaint", "devMode", function()
		for k, v in pairs(WOWDATA) do

			local scr 
			if (k and k:IsValid()) then
				scr = k:GetPos():ToScreen()

				local tx, ty = surface.GetTextSize(v.name)
				surface.SetTextPos(scr.x - tx/2, scr.y - ty)
				surface.SetFont("MessageFont")
				surface.SetTextColor(color_white)
				surface.DrawText(v.name)

				surface.SetDrawColor(color_white)
				surface.DrawRect(scr.x, scr.y, 4, 4)
			else
				if (v.class == "prop_physics") then continue end

				scr = v.pos:ToScreen()

				local tx, ty = surface.GetTextSize(v.name)
				surface.SetTextPos(scr.x - tx/2, scr.y - ty)
				surface.SetFont("MessageFont")
				surface.SetTextColor(Color(255, 0, 0))
				surface.DrawText(v.name)

				surface.SetDrawColor(Color(255, 0, 0))
				surface.DrawRect(scr.x, scr.y, 4, 4)
			end

			local dx, dy = scr.x - ScrW()/2, scr.y - ScrH()/2
			if (math.abs(dx) < 66 and math.abs(dy) < 66) then
				local aww = 0
				for a, b in pairs(v.kv) do
					local tx, ty = surface.GetTextSize(v.name)
					surface.SetTextPos(scr.x - tx/2, scr.y - ty - aww)
					surface.SetFont("DebugFixedSmall")
					surface.SetTextColor(Color(255, 0, 0))
					surface.DrawText(a .. ": " .. b)
					aww = aww + ty
				end

				break
			end
		end
	end)
else
	concommand.Add("allents", function(client, cmd, args)
		client:SetHealth(100000)
		client:SetNoTarget(true)
		client:SetSolid(0)

		local dataTable = {}
		print("DEV MODE ACTIVATE")

		for k, v in ipairs(ents.GetAll()) do
			local name = v:GetName()

			if (name and name != "") then
				dataTable[v] = {
					name = name,
					pos = v:GetPos(),
					class = v:GetClass(),
					kv = v:GetKeyValues(),
				}
			end
		end

		netstream.Start(client, "fullUpdateEntity", dataTable)
	end)
end