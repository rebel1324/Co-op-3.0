signal = signal or {}
signal.list = {
	{
		name = "Go",
		lines = {
			{"You lead the way!", "leadtheway01"},
			{"Lead the way!", "leadtheway02"},
			{"Let's go!", "letsgo01"},
			{"Let's go!", "letsgo02"},
		},
		image = 4,
		mark = true
	},
	{
		name = "Look",
		lines = {
			{"Look at there!", "overthere01"},
			{"Look at there!", "overthere02"},
		},
		image = 2,
		mark = true
	},
	{
		name = "No",
		lines = {
			{"I'm busy.", "busy02"},
			{"NO.", "ohno"},
			{"Uh....", "uhoh"},
		},
	},
	{
		name = "Yes",
		lines = {
			{"Affirmative.", "squad_affirm03"},
			{"Okay.", "squad_affirm04"},
			{"I got it.", "squad_affirm05"},
			{"Okay, okay.", "squad_affirm06"},
		},
	},
	{
		name = "Help",
		lines = {
			{"Help!", "help01"},
		},
	},
	{
		name = "Sorry",
		lines = {
			{"Sorry.", "sorry01"},
			{"Sorry.", "sorry02"},
			{"Sorry.", "sorry03"},
		},
	},
	{
		name = "Nice",
		lines = {
			{"Fantastic.", "fantastic01"},
			{"Fantastic!", "fantastic02"},
		},
	},
	{
		name = "Ready",
		lines = {
			{"Ok, I'm Ready.", "okimready01"},
			{"Ok, I'm Ready.", "okimready02"},
			{"Ok, I'm Ready!", "okimready03"},
		},
	},
}

if (CLIENT) then

	signal.queue = {}

	surface.CreateFont("SignalFont", {
		font = "Trajan Pro",
		size = 25,
		weight = 400,
		shadow = true,
	})

	surface.CreateFont("SignalFontBlur", {
		font = "Trajan Pro",
		size = 25,
		weight = 400,
		shadow = true,
		blursize = 4,
	})

	local w, h = ScrW(), ScrH()
	local selected = 0
	signal.open = false

	for k, v in pairs(signal.list) do
		v.curpos = {w/2, h/2}
		v.curalpha = 0
	end

	function signal.opensignal()
		if LocalPlayer():Team() == TEAM_DEAD then
			return
		end

		signal.open = true

		for k, v in pairs(signal.list) do
			v.curpos = {w/2, h/2}
		end

		surface.PlaySound("common/wpn_select.wav")
		gui.EnableScreenClicker(signal.open)
	end

	function signal.closesignal()
		signal.open = false

		local x, y = gui.MousePos( )
		x, y = (x-w/2), (y-h/2)
		if (x == 0 and y == 0) then 
			surface.PlaySound("common/wpn_denyselect.wav")
			gui.EnableScreenClicker(signal.open)
			return 
		end

		local trace = LocalPlayer():GetEyeTraceNoCursor()
		netstream.Start("RequestSignal", selected, {HitPos = trace.HitPos, HitNormal = trace.HitNormal})
		surface.PlaySound("common/wpn_hudoff.wav")

		gui.EnableScreenClicker(signal.open)
	end

	local signalalpha = 0
	local distance = w*.1
	local icons = {
		[1] = surface.GetTextureID("vgui/notices/error"),
		[2] = surface.GetTextureID("vgui/notices/generic"),
		[3] = surface.GetTextureID("vgui/notices/hint"),
		[4] = surface.GetTextureID("vgui/notices/undo"),
		[5] = surface.GetTextureID("vgui/notices/cleanup"),
	}

	function signal.draw()
		if signal.open then
			signalalpha = Lerp(FrameTime()*9, signalalpha, 255)
		else
			signalalpha = Lerp(FrameTime()*20, signalalpha, 0)
		end

		if signalalpha > 0 then
			local rad = math.rad(360/#signal.list)
			local deg = math.deg(rad)

			local x, y = gui.MousePos( )
			x, y = (x-w/2), (y-h/2)

			local seldeg = -math.deg(math.atan2(x, y))
			if seldeg < 0 then
				seldeg = 360+seldeg
			end

			for k, v in ipairs(signal.list) do
				local rdeg = deg*k
				local min = (rdeg - deg/2)
				local max = (rdeg + deg/2)
				if max > 360 then
					max = max - 360
					if min < seldeg or max > seldeg then
						selected = k
					end 
				else
					if min < seldeg and max > seldeg then
						selected = k
					end 
				end

				surface.SetFont("SignalFont")
				local tw, th = surface.GetTextSize(v.name)
				surface.SetTextColor(Color(255, 255, 255, signalalpha))
				
				v.curpos[1] = Lerp(FrameTime()*8, v.curpos[1], w/2-tw/2+math.sin(rad*-k)*distance)
				v.curpos[2] = Lerp(FrameTime()*8, v.curpos[2], h/2-th/2+math.cos(rad*k)*distance)

				if (selected == k and x ~= 0 and y ~= 0) then
					surface.SetFont("SignalFontBlur")
					local tw, th = surface.GetTextSize(v.name)
					surface.SetTextPos(math.Round(v.curpos[1]), math.Round(v.curpos[2]))
					surface.DrawText(v.name)
				end

				surface.SetFont("SignalFont")
				local tw, th = surface.GetTextSize(v.name)
				surface.SetTextPos(math.Round(v.curpos[1]), math.Round(v.curpos[2]))
				surface.DrawText(v.name)

			end
		end

		for k, v in pairs(signal.queue) do
			if v.time < CurTime() then
				v.alpha = Lerp(FrameTime()*3, v.alpha, 0)

				if v.alpha < 0 then
					table.remove(signal.queue, k)
				end
			else
				v.alpha = Lerp(FrameTime()*3, v.alpha, 255)
			end

			local sx, sy, visible = v.origin:ToScreen().x, v.origin:ToScreen().y,  v.origin:ToScreen().visible
			sx = math.Clamp(sx, h*.1, w - h*.1)
			sy = math.Clamp(sy, h*.1, h - h*.1)

			surface.SetFont("WaypointFont")
			surface.SetTextColor(Color(255, 255, 255, v.alpha))
			local tw, th = surface.GetTextSize(v.text)
			surface.SetTextPos(math.Round(sx-tw/2), math.Round(sy-th/2))
			surface.DrawText(v.text)


			surface.SetDrawColor(255, 255, 255, v.alpha)
			surface.SetTexture(icons[v.image] or icons[2])
			surface.DrawTexturedRect(math.Round(sx-16), math.Round(sy-16) - th*1.4, 32, 32)

			surface.SetFont("WaypointMeterFont")
			local text = math.Round(v.origin:Distance(LocalPlayer():GetPos())/16) .. ' m'
			local tw, th = surface.GetTextSize(text)
			surface.SetTextPos(math.Round(sx-tw/2), math.Round(sy-th/2 + th*1.1))
			surface.DrawText(text)
		end

	end

	netstream.Hook("SignalSend", function(requested, selected, trace)
		local pos = trace.HitPos
		table.insert(signal.queue, {origin = pos, text = signal.list[selected].name or 'Test', image = signal.list[selected].image or 3, alpha = 0, time = CurTime() + 5})
	end)
else
	netstream.Hook("RequestSignal", function(client, selected, trace)
		if !client.nextSignal or client.nextSignal < CurTime() then
			local linedata = table.Random(signal.list[selected].lines)
			client:ConCommand(Format("say %s", linedata[1]))
			client:EmitSound(Format("vo/npc/%s01/%s.wav", "male", linedata[2]), 100, math.random(90,110))

			if signal.list[selected].mark then
				netstream.Start(player.GetAll(), "SignalSend", client, selected, trace)
			end

			client.nextSignal = CurTime() + 1
			client.warned = false
		else
			if !client.warned then
				SendNotify(client, lang.nextsignal, 2)
				client.warned = true
			end
		end
	end)
end