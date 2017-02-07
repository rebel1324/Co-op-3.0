include("language.lua")
include("settings.lua")
include("derma/icon.lua")

include("modules/von.lua")
include("modules/netstream.lua")
include("modules/money.lua")
include("modules/signal.lua")
include("modules/weapons.lua")
include("modules/mob.lua")
include("modules/3dtext.lua")
include("modules/equipments.lua")
include("modules/waypoints.lua")
include("modules/effects.lua")
include("modules/cw2.lua")
include("modules/chatbox.lua")
include("modules/dev.lua")
include("modules/screen.lua")
include("derma/infobar.lua")
include("derma/vendor.lua")

include("shared.lua")

local w, h = ScrW(), ScrH()
local text = {}
local math_clamp = math.Clamp
local math_round = math.Round
local math_sin = math.sin

PLACEMENT_MATERIAL = CreateMaterial("placement_mat", "VertexlitGeneric",
{
	["$basetexture"] = "Models/Debug/debugwhite",
	["$model"] = 1,
})

surface.CreateFont("MoneyFont", {
	font = "Trajan Pro",
	size = ScreenScale(11),
	weight = 800,
	shadow = true,
})

surface.CreateFont("HealthFont", {
	font = "Trajan Pro",
	size = ScreenScale(30),
	weight = 800,
	shadow = true,
})

surface.CreateFont("TimerTitleFont", {
	font = "Trajan Pro",
	size = ScreenScale(10),
	weight = 800,
	shadow = true,
})

surface.CreateFont("TimerFont", {
	font = "Trajan Pro",
	size = ScreenScale(20),
	weight = 800,
	shadow = true,
})

surface.CreateFont("SubFont", {
	font = "Trajan Pro",
	size = ScreenScale(15),
	weight = 800,
	shadow = true,
})

surface.CreateFont("MessageFont", {
	font = "Trajan Pro",
	size = 22,
	weight = 800,
	shadow = true,
})

surface.CreateFont("ObjectiveFont", {
	font = "Trajan Pro",
	size = 44,
	weight = 800,
	shadow = true,
})

surface.CreateFont("PointmsgFont", {
	font = "Trajan Pro",
	size = 20,
	weight = 800,
	shadow = true,
})

surface.CreateFont("WaypointFont", {
	font = "Trajan Pro",
	size = 19,
	weight = 800,
	shadow = true,
})

surface.CreateFont("WaypointMeterFont", {
	font = "Trajan Pro",
	size = 15,
	weight = 400,
	shadow = true,
})

oc.waypoints = oc.waypoints or {}
oc.pointmsgs = oc.pointmsgs or {}

netstream.Hook("ClearClientTables", function(data)
	for k, v in pairs(oc.waypoints) do
		v.curobj = false
	end
end)

netstream.Hook("oc.Waypoints", function(data)
	oc.waypoints = data
end)

netstream.Hook("oc.Pointmsgs", function(data)
	oc.pointmsgs = data
end)

netstream.Hook("oc.WaypointToggle", function(a, b)
	if !oc.waypoints[a] then
		Error('Pointmsg Error: '..a..' Objective Not Found.')
		return
	end
	oc.waypoints[a].curobj = b
end)

netstream.Hook("oc.PointmsgToggle", function(data)
	if !oc.pointmsgs[data] then
		Error('Objective Error: '..data..' Pointmsg Not Found.')
		return
	end
	oc.pointmsgs[data].nodisp = true
end)

netstream.Hook("SendNotify", function(a, b)
	AddNotice(a, b)
end)

netstream.Hook("SendObjective", function(a, b)
	DisplayObjective(a, b)
end)

netstream.Hook("SendPlaySound", function(data)
	surface.PlaySound(data)
end)

netstream.Hook("MedicStationDisable", function(ent, disable)	
	ent.disable = disable
end)

netstream.Hook("GameLostMusic", function(data)
	local musictimer = data or 10
	local musicsound = CreateSound(LocalPlayer(), "music/radio1.mp3")
	musicsound:Play()
	timer.Simple(musictimer, function()
		musicsound:ChangeVolume(0, .1)
	end)
end)

function CL_FT()
	return math.Clamp(FrameTime(), 1/(60*4), 1)
	--return curTime * 10
end

function AddNotice( str, t )
	surface.SetFont("MessageFont")
	local tw, th = surface.GetTextSize(str)
	surface.PlaySound("common/talk.wav")
	table.insert( text, {string=str, time=CurTime()+t, x=w/2-tw/2, y=h/4*3, alpha=0} )
end

local objstring = "Activate the button."
local objalpha = 0
local objtime = 0
function DisplayObjective( str, t )
	objstring = str
	objalpha = 0
	objtime = CurTime() + t
	surface.PlaySound("HL1/fvox/blip.wav")
end

local function textdisplay(ply)
	for k, v in ipairs(text) do
		
		if v.time < CurTime() then
			v.alpha = math_clamp(Lerp(CL_FT()*4, v.alpha, 0), 0, 255)	
			if v.alpha < 1 then
				table.remove( text, k )	
			end
		else
			v.alpha = math_clamp(Lerp(CL_FT()*3, v.alpha, 255), 0, 255)	
		end
		
		surface.SetFont("MessageFont")
		surface.SetTextColor(Color(255, 255, 255, v.alpha))
		local tw, th = surface.GetTextSize(v.string)
		
		v.x = Lerp(CL_FT()*5, v.x, w/2-tw/2)
		v.y = Lerp(CL_FT()*5, v.y, h/4*3-th/2 + k*th*1.2)
		surface.SetTextPos(math_round(v.x), math_round(v.y))
		
		surface.DrawText(v.string)
	end
end

local function objectivedisplay(ply)
	if objtime < CurTime() then
		objalpha = math_clamp(Lerp(CL_FT()*4, objalpha, 0), 0, 255)	
	else
		objalpha = math_clamp(Lerp(CL_FT()*3, objalpha, 255), 0, 255)	
	end
		
	surface.SetFont("ObjectiveFont")
	surface.SetTextColor(Color(255, 255, 255, objalpha))
	local tw, th = surface.GetTextSize(objstring)
	surface.SetTextPos(math_round(w/2-tw/2), math_round(h/3*1-th/2))
	surface.DrawText(objstring)
end

local icons = {
	[1] = surface.GetTextureID("vgui/notices/error"),
	[2] = surface.GetTextureID("vgui/notices/generic"),
	[3] = surface.GetTextureID("vgui/notices/hint"),
	[4] = surface.GetTextureID("vgui/notices/undo"),
	[5] = surface.GetTextureID("vgui/notices/cleanup"),
}

local function checkpointdisplay(ply)
	for k, v in pairs(oc.waypoints) do
		if (!v.origin) then continue end
		
		local sx, sy, visible = v.origin:ToScreen().x, v.origin:ToScreen().y,  v.origin:ToScreen().visible
		sx = math_clamp(sx, h*.1, w - h*.1)
		sy = math_clamp(sy, h*.1, h - h*.1)
		if v.curobj then
			surface.SetFont("WaypointFont")
			surface.SetTextColor(Color(255, 255, 255, 255))
			local tw, th = surface.GetTextSize(v.text or "")
			surface.SetTextPos(math_round(sx-tw/2), math_round(sy-th/2))
			surface.DrawText(v.text or "")


			surface.SetDrawColor(255, 255, 255, 200)
			surface.SetTexture(icons[v.image] or icons[2])
			surface.DrawTexturedRect(math_round(sx-16), math_round(sy-16) - th*1.4, 32, 32)

			surface.SetFont("WaypointMeterFont")
			local text = math_round(v.origin:Distance(ply:GetPos())/16) .. ' m'
			local tw, th = surface.GetTextSize(text)
			surface.SetTextPos(math_round(sx-tw/2), math_round(sy-th/2 + th*1.1))
			surface.DrawText(text)
		end
	end
end

local function pointmsgdisplay(ply)
	for k, v in pairs(oc.pointmsgs) do
		if (!v.origin) then continue end
		--print(v.origin[2], v.origin[2].SetNetworkedEntity and v.origin[2]:SetNetworkedEntity("textparent"))
		local origin = (v.origin[2] and v.origin[2]:IsValid()) and v.origin[2]:GetPos() or v.origin[1]
		local sx, sy, visible = origin:ToScreen().x, origin:ToScreen().y,  origin:ToScreen().visible
		if visible and !v.nodisp then
			local col = v.textcolor or Color(255, 255, 255)
			col.a = math_clamp(v.radius + 255 - ply:GetPos():Distance(origin), 0, 255)

			surface.SetFont("PointmsgFont")
			surface.SetTextColor(col)
			local tw, th = surface.GetTextSize(v.message or "")
			surface.SetTextPos(math_round(sx-tw/2), math_round(sy-th/2))
			surface.DrawText(v.message or "")
		end
	end
end

local function drawdot( pos, size, col )
	pos[1] = math_round( pos[1] )
	pos[2] = math_round( pos[2] )
	draw.RoundedBox( 0, pos[1] - size/2, pos[2] - size/2 , size, size, col[1] )
	size = size-2
	draw.RoundedBox( 0, pos[1] - size/2, pos[2] - size/2, size, size, col[2] )
end

local gap = 10
local oldhealth = 0
local oldmoney = 0
local moneytimer = CurTime()
local ticktimer = CurTime()
local moneypos = ScrW()
local moneyalpha = 0
local tarhcol = {255, 255, 255}
local curhcol = {255, 255, 255}

local function playerhud(ply)

	if !ply:IsValid() then 
		return 
	end
	
	if ply:Alive() then

		if ply:Team() == TEAM_DEAD then
			surface.SetDrawColor(0, 0, 0)
			surface.DrawRect(0, 0, w, h*.08)

			surface.SetDrawColor(0, 0, 0)
			surface.DrawRect(0, h - h*.08 + 1, w, h*.08)

			surface.SetFont("TimerFont")
			surface.SetTextColor(Color(255, 255, 255, 255))
			local tw, th = surface.GetTextSize("Spectating")
			surface.SetTextPos(math_round(w*.03), math_round(h-th*1.15))
			surface.DrawText("Spectating")
		else
			local health = math_clamp(ply:Health(), 0, 100)

			if health < 30 then
				for i = 2, 3 do
					tarhcol[i] = 50 + math.abs(math.sin(RealTime()*10)*205)
				end	
			else
				tarhcol = {255, 255, 255}
			end

			if health ~= oldhealth then
				local diff = health - oldhealth
				if diff > 0 then
					curhcol[1] = 99
					curhcol[3] = 99
				else
					curhcol[2] = 0
					curhcol[3] = 0
				end
			end

			for i = 1, 3 do
				curhcol[i] = Lerp(CL_FT()*10, curhcol[i], tarhcol[i])	
			end

			surface.SetFont("HealthFont")
			surface.SetTextColor(Color(curhcol[1], curhcol[2], curhcol[3], 255))
			local tw, th = surface.GetTextSize(health)
			surface.SetTextPos(math_round(w*.03), math_round(h-th*1.1))
			surface.DrawText(health)

			oldhealth = health

			if ( ply.money or 0 ) ~= oldmoney then
				moneytimer = CurTime() + 3
				
				if ticktimer < CurTime() then
					surface.PlaySound("UI/buttonclick.wav")
					ticktimer = CurTime() + .1
				end
				
			end


			surface.SetFont("MoneyFont")
			local tw, th = surface.GetTextSize(oldmoney .. "$")

			if moneytimer > CurTime() then
				moneypos = Lerp(CL_FT()*2, moneypos, w - 30 - tw)
				moneyalpha = Lerp(CL_FT()*3, moneyalpha, 255)
			else
				moneyalpha = Lerp(CL_FT()*3, moneyalpha, 0)
				moneypos = Lerp(CL_FT()*3, moneypos, w + tw)
			end

			--oldmoney = math.ceil(math.Approach(oldmoney, ply:GetMoney() or 0, math.Clamp( CL_FT()*ply:GetMoney()/5, 10, math.huge )))
			oldmoney = math.ceil(math.min(ply:GetMoney(), oldmoney + FrameTime()*50))

			surface.SetTextColor(Color(255, 255, 255, moneyalpha))
			surface.SetTextPos(math_round(moneypos), math_round(h/2-th/2))
			surface.DrawText(oldmoney .. "$")
		end
	end

	local wep = ply:GetActiveWeapon()
	if wep and wep:IsValid() then
		if wep:GetPrimaryAmmoType() ~= -1 then
			local ammo = wep:Clip1()
			if ammo > -1 then
				local reserves = ply:GetAmmoCount((wep.Primary and AMMO_CONV[wep.Primary.Ammo]) or wep:GetPrimaryAmmoType()) 
				surface.SetFont("SubFont")
				surface.SetTextColor(Color(255, 255, 255, 255))

				local tw2, th2 = surface.GetTextSize(reserves)
				surface.SetTextPos(math_round(w - w*.02-tw2*1.2), math_round(h-th2*1.4))
				surface.DrawText(reserves)

				surface.SetFont("HealthFont")
				surface.SetTextColor(Color(255, 255, 255, 255))
				local tw, th = surface.GetTextSize(ammo)
				surface.SetTextPos(math_round(w - w*.02-tw2*1.6-tw), math_round(h-th*1.1))
				surface.DrawText(ammo)
			else
				local reserves = ply:GetAmmoCount(wep:GetPrimaryAmmoType())
				surface.SetFont("HealthFont")
				surface.SetTextColor(Color(255, 255, 255, 255))
				local tw, th = surface.GetTextSize(reserves)
				surface.SetTextPos(math_round(w - w*.02-tw*1.1), math_round(h-th*1.1))
				surface.DrawText(reserves)
			end
		end
	end

	local t = util.QuickTrace( ply:GetShootPos(), ply:GetAimVector() * 15000, ply )
	local pos = t.HitPos:ToScreen()
	local col = { color_black, color_white }

	if !wep.dt or wep.KeepCrosshair or wep.dt.State != CW_AIMING then
		drawdot( {pos.x, pos.y},4, col )
		drawdot( {pos.x + gap, pos.y},4, col )
		drawdot( {pos.x - gap, pos.y},4, col ) 
		drawdot( {pos.x, pos.y + gap * .8},4, col ) 
		drawdot( {pos.x, pos.y - gap * .8},4, col ) 
	end

end

local down_gradient = surface.GetTextureID("gui/gradient_down")
local mindist = 100
local function playerdisp(ply)
	for k, v in ipairs(player.GetAll()) do
		if v == ply then
			if !v:ShouldDrawLocalPlayer() then
				continue
			end
		end

		if v:Team() == TEAM_DEAD then
			continue
		end

		if ply:GetPos():Distance(v:GetPos()) > mindist * 10 then
			continue	
		end

		local bone, bpos
		local rag = v:GetRagdollEntity() or NULL
		if rag:IsValid() then
			bone = rag:LookupBone("ValveBiped.Bip01_Head1")
			bpos = bone and rag:GetBonePosition(bone)
		else
			bone = v:LookupBone("ValveBiped.Bip01_Head1")
			bpos = bone and v:GetBonePosition(bone)
		end

		bpos = bpos + Vector(0,0,15)
		local x, y, visible = bpos:ToScreen().x, bpos:ToScreen().y, bpos:ToScreen().visible
		local fov = 75/(ply:GetFOV())
		local scale = mindist/ply:EyePos():Distance(bpos)*fov
		local mx = Matrix()

		surface.SetFont("ObjectiveFont")
		local tx, ty = surface.GetTextSize(v:Name())

		mx:Translate(Vector(x - tx/2*scale, y, 1))
		mx:Scale(Vector(scale, scale, 1))

		cam.PushModelMatrix(mx)
			surface.SetTextPos(2, 2)
			surface.SetTextColor(color_black)
			surface.DrawText(v:Name())

			surface.SetTextPos(0, 0)
			surface.SetTextColor(color_white)
			surface.DrawText(v:Name())


			surface.SetDrawColor(150, 50, 50)
			surface.DrawRect(0, ty*.95, tx, 8)
			surface.SetDrawColor(222, 99, 99)
			surface.SetTexture(down_gradient)
			surface.DrawTexturedRect(0, ty*.95, tx, 8)

			local healthmul = math_clamp(v:Health(), 0, 100)/100
			surface.SetDrawColor(50, 150, 50)
			surface.DrawRect(0, ty*.95, tx*healthmul, 8)
			surface.SetDrawColor(99, 222, 99)
			surface.SetTexture(down_gradient)
			surface.DrawTexturedRect(0, ty*.95, tx*healthmul, 8)
		cam.PopModelMatrix()
	end
end

local timertime = CurTime()
local timertitle = "Time Remaining"
local center_gradient = surface.GetTextureID("gui/center_gradient")
local ding = false
local tarcol = {255,255,255}
local curcol = {255,255,255}
local timeralpha = 0
local noshit = 0

function PushTimer(time, title)
	timertime = CurTime() + time
	tarcol = {255,255,255}
	curcol = {255,255,255}
	ding = false
	timeralpha = 0
	if title then
		timertitle = title
	else
		timertitle = "Time Remaining"
	end
end

function PauseTime()

end

function ResumeTime()

end

netstream.Hook("PushTimer", function(a, b)
	PushTimer(a, b)
end)

netstream.Hook("StopTimer", function(data)
	timertime = CurTime()
end)

local function drawtimer()
	local time = math_clamp(timertime - CurTime(), 0, math.huge)

	if time == 0 then
		if !ding then
			for i = 2, 3 do
				curcol[i] = 0
			end
			ding = true
		else
			noshit = 0
			for i = 1, 3 do
				if curcol[i] < 250 then
					continue
				else
					noshit = noshit + 1
				end
				if noshit == 3 then
					timeralpha = Lerp(CL_FT()*4,timeralpha,0)
				end
			end
		end	

		for i = 1, 3 do
			curcol[i] = Lerp(CL_FT()*5, curcol[i], tarcol[i])
		end
	else
		timeralpha = Lerp(CL_FT()*4,timeralpha,255)
	end

	surface.SetDrawColor(155, 155, 150, timeralpha)
	surface.SetTexture(center_gradient)
	surface.DrawTexturedRect(w/2-w*.2*.5, h*.005, w*.2, h*.09)

	local text = timertitle
	surface.SetFont("TimerTitleFont")
	surface.SetTextColor(Color(curcol[1], curcol[2], curcol[3], timeralpha))
	local tw, th = surface.GetTextSize(text)
	surface.SetTextPos(math_round(w/2-tw/2), math_round(h*.015))
	surface.DrawText(text)
	
	text = string.ToMinutesSecondsMilliseconds(time)
	surface.SetFont("TimerFont")
	surface.SetTextColor(Color(curcol[1], curcol[2], curcol[3], timeralpha))
	local tw2, th2 = surface.GetTextSize(text)
	surface.SetTextPos(math_round(w/2-tw2/2), math_round(h*.01+th))
	surface.DrawText(text)
end

local down_gradient = surface.GetTextureID("gui/gradient_down")
local mindist = 100
local maxdist = 500
local function stuffdisp(ply)
	for k, v in ipairs(ents.GetAll()) do
		local stuffdat = MAP_ENTITY_TEXTS[v:GetClass()]

		if !stuffdat then 
			continue
		end
		
		if ply:GetPos():Distance(v:GetPos()) > mindist * 10 then
			continue	
		end

		local nametext = stuffdat.name
		bpos = stuffdat.pos and stuffdat.pos(v) or v:GetPos()

		local x, y, visible = bpos:ToScreen().x, bpos:ToScreen().y, bpos:ToScreen().visible
		local fov = 90/ply:GetFOV()
		local scale = mindist/ply:EyePos():Distance(bpos)*fov
		local alpha = math_clamp( 255 + maxdist - ply:EyePos():Distance(bpos), 0, 255 )
		local mx = Matrix()

		if alpha == 0 then
			continue
		end

		surface.SetFont("ObjectiveFont")
		local tx, ty = surface.GetTextSize(nametext)

		mx:Translate(Vector(x - tx/2*scale, y, 1))
		mx:Scale(Vector(scale, scale, 1))

		cam.PushModelMatrix(mx)
			surface.SetTextPos(2, 2)
			surface.SetTextColor(Color(0,0,0,alpha))
			surface.DrawText(nametext)

			surface.SetTextPos(0, 0)
			surface.SetTextColor(Color(255,255,255,alpha))
			surface.DrawText(nametext)
		cam.PopModelMatrix()
	end
end

local screenalpha = 0
local screencol = {255,255,255}
local fadespeed = 3

netstream.Hook("PushFlash", function(alpha, sccolor, fs)
	if alpha and sccolor then
		screenalpha = 255
		screencol[1] = sccolor.r; screencol[2] = sccolor.g; screencol[3] = sccolor.b;
		fadespeed = fs or 5
	end
end)

local function screenflash()

	if screenalpha > 0 then
		screenalpha = Lerp(math_clamp(CL_FT(), 1/120, 1)*fadespeed, screenalpha, 0)

		surface.SetDrawColor(screencol[1], screencol[2], screencol[3], screenalpha)
		surface.DrawRect(0, 0, w, h)
	end
end

function GM:HUDShouldDraw(element)
	if (element == "CHudHealth" or element == "CHudBattery" or element == "CHudAmmo" or element == "CHudSecondaryAmmo") then
		return false
	end
	
	if (element == "CHudCrosshair") then
		return false
	end

	return true
end

function GM:HUDAmmoPickedUp( name, amount )
	AddNotice( Format(lang.ammopickup, amount, name), 2.5 )
end

function GM:HUDWeaponPickedUp( wep )
	if (wep and wep:IsValid() and wep.PrintName != nil) then
		AddNotice( Format(lang.weaponpickup, wep.PrintName), 2.5 )
	end
end


function GM:HUDPaint()
	local ply = LocalPlayer()

	textdisplay(ply)
	objectivedisplay(ply)
	checkpointdisplay(ply)
	pointmsgdisplay(ply)
	playerhud(ply)
	playerdisp(ply)
	stuffdisp(ply)
	screenflash()
	drawtimer()
end

hook.Add("UpdateAnimation", "NameTags", function(pl)
	local light = pl:GetNetworkedBool("light", false)
	if (light) then
		local firepos = pl:EyePos() + pl:GetAimVector() * -5

		local dlight = DynamicLight(pl:EntIndex())
		dlight.Pos = firepos
		dlight.r, dlight.g, dlight.b = 255, 255, 255
		dlight.Brightness = 1
		dlight.Size = (512 + math.sin( CurTime()*FrameTime()/2 )*10)
		dlight.Decay = 1024
		dlight.DieTime = CurTime() + 0.1
	end
end)	