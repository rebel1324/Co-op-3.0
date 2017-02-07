if (SERVER) then
	hook.Add("InitPostEntity", "custom_map", function()
		for k, v in ipairs(ents.GetAll()) do
			if (v:IsNPC()) then
				if (v:GetName() == "miku") then
					SetGlobalEntity("miku", v)
				end
			end
		end
	end)

	hook.Add("Think", "custom_map", function()
		local v = GetGlobalEntity("miku")

		if (v and v:IsValid()) then
			local closest = 512
			local myhero 
			for _, p in ipairs(player.GetAll()) do
				local dist = v:GetPos():Distance(p:GetPos())

				if (dist < 512 and dist < closest) then
					closest = dist
					myhero = p
				end
			end

			if (!v.nextChase or v.nextChase < CurTime()) then
				v:SetSchedule(myhero and SCHED_TARGET_CHASE or SCHED_TAKE_COVER_FROM_ENEMY )
				v.nextChase = CurTime() + 3
			end
		end
	end)

	hook.Add("CanTurretTarget", "custom_map", function(client, target)
		print(target)
	end)
else
	local math_clamp = math.Clamp
	local math_round = math.Round
	local math_sin = math.sin

	local down_gradient = surface.GetTextureID("gui/gradient_down")
	local mindist = 100
	local function playerdisp()
		local v = GetGlobalEntity("miku")
		local ply = LocalPlayer()

		if (v and v:IsValid()) then
			if ply:GetPos():Distance(v:GetPos()) > mindist * 10 then
				return	
			end

			local bone, bpos
			bone = v:LookupBone("ValveBiped.Bip01_Head1")
			bpos = bone and v:GetBonePosition(bone)

			bpos = bpos + Vector(0,0,15)
			local x, y, visible = bpos:ToScreen().x, bpos:ToScreen().y, bpos:ToScreen().visible
			local fov = 75/(ply:GetFOV())
			local scale = mindist/ply:EyePos():Distance(bpos)*fov
			local mx = Matrix()

			surface.SetFont("ObjectiveFont")
			local tx, ty = surface.GetTextSize("PROTECT")

			mx:Translate(Vector(x - tx/2*scale, y, 1))
			mx:Scale(Vector(scale, scale, 1))

			cam.PushModelMatrix(mx)
				surface.SetTextPos(2, 2)
				surface.SetTextColor(color_black)
				surface.DrawText("PROTECT")

				surface.SetTextPos(0, 0)
				surface.SetTextColor(color_white)
				surface.DrawText("PROTECT")


				surface.SetDrawColor(150, 50, 50)
				surface.DrawRect(0, ty*.95, tx, 8)
				surface.SetDrawColor(222, 99, 99)
				surface.SetTexture(down_gradient)
				surface.DrawTexturedRect(0, ty*.95, tx, 8)

				local healthmul = math_clamp(v:Health(), 0, 80)/80
				surface.SetDrawColor(50, 150, 50)
				surface.DrawRect(0, ty*.95, tx*healthmul, 8)
				surface.SetDrawColor(99, 222, 99)
				surface.SetTexture(down_gradient)
				surface.DrawTexturedRect(0, ty*.95, tx*healthmul, 8)
			cam.PopModelMatrix()
		end
	end
	hook.Add("HUDPaint", "cust", playerdisp)
end