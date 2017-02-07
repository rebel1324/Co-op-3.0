local PANEL = {}
local w, h = ScrW(), ScrH()
local wide, tall = 600, 505

surface.CreateFont("vendor_display1", {
	font = "Trajan Pro",
	size = 25,
	weight = 700,
	antialias = true
})

surface.CreateFont("vendor_display2", {
	font = "Trebuchet MS",
	size = 20,
	weight = 800,
	antialias = true
})

surface.CreateFont("vendor_display3", {
	font = "Trebuchet MS",
	size = 18,
	weight = 800,
	antialias = true
})



function PANEL:Init()
	self:SetSize(wide, tall)
	self:SetTitle("")
	self:SetDraggable(false)
	self:ShowCloseButton(false)

	self:Center()
	self.pick = self:Add("DPanel")
	self.pick:Dock(TOP)
	self.pick:DockMargin(0,2,0,5)

	self.close = self:Add("DButton")
	self.close:SetSize(25,25)
	self.close:SetPos(wide-25-5, 0)
	self.close:SetFont("ChatFont")
	self.close:SetText("X")
	self.close:SetTextColor(color_white)
	self.close.Paint = function() end
	self.close.DoClick = function()
		surface.PlaySound("ambient/levels/citadel/pod_open1.wav")

		if self.picker and self.picker.Close then
			self.picker:Close()
		end

		self:Close()
	end

	self.curmoney = self:Add("DPanel")
	self.curmoney:Dock(BOTTOM)
	self.curmoney:DockMargin(0,5,0,0)
	self.curmoney:SetTall(30)
	self.curmoney.Paint = function(p, w, h)
		local money = "Current Balance: " .. LocalPlayer():GetMoney() .. "$"
		surface.SetFont("vendor_display1")

		local tw, th = surface.GetTextSize(money)
		surface.SetTextColor(Color(1, 1, 1, 255))
		surface.SetTextPos(math.Round(w/2-tw/2+1), math.Round(h/2-th/2+1))
		surface.DrawText(money)

		surface.SetTextColor(Color(255, 255, 255, 255))
		surface.SetTextPos(math.Round(w/2-tw/2), math.Round(h/2-th/2))
		surface.DrawText(money)
	end

	self.right = self.pick:Add("DButton")
	self.right:Dock(RIGHT)
	self.right:SetText(">")
	self.right:SetFont( "vendor_display1" )
	self.right.Paint = function() end
	self.right.DoClick = function()
		surface.PlaySound("buttons/lightswitch2.wav")
		self:Change(self.curmenu + 1)
	end
	
	self.left = self.pick:Add("DButton")
	self.left:Dock(LEFT)
	self.left:SetText("<")
	self.left:SetFont( "vendor_display1" )
	self.left.Paint = function() end
	self.left.DoClick = function()
		surface.PlaySound("buttons/lightswitch2.wav")
		self:Change(self.curmenu - 1)
	end

	self.current = self.pick:Add("DLabel")
	self.current:Dock(FILL)
	self.current:SetContentAlignment(5)
	self.current:SetTextColor(Color(0,0,0,255))
	self.current:SetFont( "vendor_display1" )
	self.current:DockMargin(0,3,0,0)

	self.content = self:Add("DScrollPanel")
	self.content:Dock(FILL)
	self.content:SetDrawBackground(true)

	self.curmenu = 0
	self.init = true
end

local gradient_center = surface.GetTextureID("gui/center_gradient")
function PANEL:Paint(w, h)
end

local yellow 	= Color( 250, 210, 0 )
local gray		= Color( 199, 199, 210 )
local dark		= Color( 20, 20, 20 )
local white		= Color( 255, 255, 255 )

local gradient_down = surface.GetTextureID("gui/gradient_down")
function PANEL:AddWeaponPanel(v, k)
	local wep = self.content:Add("DPanel")
	wep:Dock(TOP)
	wep:DockMargin(5,5,5,0)
	wep:SetTall(64+8)
	wep.Paint = function(p, w, h)
		local color = gray
		surface.SetDrawColor( color )
		surface.DrawRect( 0, 0, w, h )
		surface.SetDrawColor( Color(144, 144, 144) )
		surface.SetTexture( gradient_down )
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetDrawColor( color )
		surface.DrawOutlinedRect( 1, 1, w -2, h -2 )
		surface.SetDrawColor( dark )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end

	local icon = wep:Add("DPanel")
	icon:Dock(LEFT)
	icon:SetWide(64)
	icon:DockMargin(4,4,4,4)
	icon.Paint = function(p, w, h)
		surface.SetDrawColor( color_white )
		if v.icon then
			surface.SetMaterial( ICON_MATERIALS[v.icon] )
		else
			surface.SetMaterial( ICON_MATERIALS["default"] )
		end
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetDrawColor( dark )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end

	local name = wep:Add("DLabel")
	name:Dock(TOP)
	name:SetText(v.name)
	name:SetTextColor(color_white)
	name:SetExpensiveShadow(1, color_black)
	name:SetFont("vendor_display1")
	name:DockMargin(8,8,4,0)

	local name = wep:Add("DLabel")
	name:Dock(TOP)
	name:SetText(v.desc)
	name:SetTextColor(color_white)
	name:SetExpensiveShadow(1, color_black)
	name:SetFont("vendor_display2")
	name:DockMargin(8,0,4,4)

	local btn = wep:Add("DButton")
	btn:Dock(RIGHT)
	btn:SetText(v.price .. "$")
	btn:SetWide(90)
	btn:DockMargin(0,0,4,4)
	btn.DoClick = function()
		surface.PlaySound("buttons/button15.wav")
		netstream.Start("RequestWeapon", k)
	end

	return wep
end

function PANEL:BringAmmoAmount(v, k)	
	surface.PlaySound("weapons/smg1/switch_single.wav")

	if self.picker and self.picker.Close then
		self.picker:Close()
	end

	local menu = vgui.Create("DFrame")
	local w, h = ScrW(), ScrH()
	local sizex, sizey = 350, 130
	menu:SetTitle("Select Amount")
	menu:SetSize(sizex, sizey)
	menu:Center()
	menu:MakePopup()	
	self.picker = menu

	local content = menu:Add("DPanel")
	content:Dock(FILL)
	content:DockPadding(5,5,5,5)

	local atext = content:Add( "DLabel" )
	atext:SetFont( "vendor_display3" )
	atext:SetContentAlignment(5)
	atext:SetTextColor( color_black )
	atext:SizeToContents()
	atext:Dock( TOP )
	atext:DockMargin(2, 2, 2, 2)
	atext:SetExpensiveShadow(1, Color(25, 25, 25, 120))
	atext:SetText("Ammo Price: " .. v.price .. "$")

	local slider = content:Add("DNumSlider")
	slider:Dock(TOP)
	slider:SetText("Amount")
	slider.Label:SetTextColor(Color(22, 22, 22))
	slider:SetMin(1)  
	slider:SetMax(AMMO_LIMITS[v.ammo])
	slider:SetDecimals(0)
	slider:SetValue(textsample.scale)
	slider:DockMargin(27, 2, 0, 2)
	slider.OnValueChanged = function(p)
		atext:SetText("Ammo Price: ".. math.Round(p:GetValue()) * v.price .."$")
	end

	local btn = content:Add("DButton")
	btn:Dock(TOP)
	btn:SetText("Purchase")
	btn:DockMargin(15, 5, 15, 2)
	btn.DoClick = function(p)
		surface.PlaySound("buttons/button15.wav")
		netstream.Start("RequestAmmo", k, slider:GetValue())
		menu:Close()
	end

end

function PANEL:AddAmmoPanel(v, k)
	local wep = self.content:Add("DPanel")
	wep:Dock(TOP)
	wep:DockMargin(5,5,5,0)
	wep:SetTall(64+8)
	wep.Paint = function(p, w, h)
		local color = gray
		surface.SetDrawColor( color )
		surface.DrawRect( 0, 0, w, h )
		surface.SetDrawColor( Color(144, 144, 144) )
		surface.SetTexture( gradient_down )
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetDrawColor( color )
		surface.DrawOutlinedRect( 1, 1, w -2, h -2 )
		surface.SetDrawColor( dark )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end

	local icon = wep:Add("DPanel")
	icon:Dock(LEFT)
	icon:SetWide(64)
	icon:DockMargin(4,4,4,4)
	icon.Paint = function(p, w, h)
		surface.SetDrawColor( color_white )
		if v.icon then
			surface.SetMaterial( ICON_MATERIALS[v.icon] )
		else
			surface.SetMaterial( ICON_MATERIALS["default"] )
		end
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetDrawColor( dark )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end

	local name = wep:Add("DLabel")
	name:Dock(TOP)
	name:SetText(v.name)
	name:SetTextColor(color_white)
	name:SetExpensiveShadow(1, color_black)
	name:SetFont("vendor_display1")
	name:DockMargin(8,8,4,0)

	local name = wep:Add("DLabel")
	name:Dock(TOP)
	name:SetText(v.desc)
	name:SetTextColor(color_white)
	name:SetExpensiveShadow(1, color_black)
	name:SetFont("vendor_display2")
	name:DockMargin(8,0,4,4)

	local btn = wep:Add("DButton")
	btn:Dock(RIGHT)
	btn:SetText("Purchase")
	btn:SetWide(90)
	btn:DockMargin(0,0,4,4)
	btn.DoClick = function()
		self:BringAmmoAmount(v, k)
	end

	return wep
end


function PANEL:AddEquipmentPanel(v, k)
	local wep = self.content:Add("DPanel")
	wep:Dock(TOP)
	wep:DockMargin(5,5,5,0)
	wep:SetTall(100)
	wep.Paint = function(p, w, h)
		local color = gray
		surface.SetDrawColor( color )
		surface.DrawRect( 0, 0, w, h )
		surface.SetDrawColor( Color(144, 144, 144) )
		surface.SetTexture( gradient_down )
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetDrawColor( color )
		surface.DrawOutlinedRect( 1, 1, w -2, h -2 )
		surface.SetDrawColor( dark )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end

	local name = wep:Add("DLabel")
	name:Dock(TOP)
	name:SetText(v.name)
	name:SetTextColor(color_white)
	name:SetExpensiveShadow(1, color_black)
	name:SetFont("vendor_display1")
	name:DockMargin(8,8,4,0)

	local name = wep:Add("DLabel")
	name:Dock(TOP)
	name:SetText(v.desc)
	name:SetTextColor(color_white)
	name:SetExpensiveShadow(1, color_black)
	name:SetFont("vendor_display2")
	name:DockMargin(8,0,4,4)
	name:SetWrap()
	name:SetAutoStretchVertical( true )

	local btn = wep:Add("DButton")
	btn:Dock(BOTTOM)
	btn:SetText(v.price .. "$")
	btn:SetPos()
	btn:DockMargin(470,4,4,4)
	btn.DoClick = function()
		surface.PlaySound("buttons/button15.wav")
		netstream.Start("RequestEquipment_P", k)
	end

	return wep
end


function PANEL:WeaponCategory()
	self.current:SetText("Arsenals")
	self.content:Clear()
	for k, v in pairs(MERCHANT_WEAPONS) do
		self:AddWeaponPanel(v, k)
	end
end

function PANEL:AmmoCategory()
	self.current:SetText("Ammunition")
	self.content:Clear()
	for k, v in pairs(MERCHANT_AMMO) do
		self:AddAmmoPanel(v, k)
	end
end

function PANEL:EquipmentCategory()
	self.current:SetText("Equipments")
	self.content:Clear()
	for k, v in pairs(MERCHANT_EQUIPMENTS) do
		self:AddEquipmentPanel(v, k)
	end
end

function PANEL:PerkCategory()
	self.current:SetText("Perks")
	self.content:Clear()
end

function PANEL:Change(num)
	num = math.Clamp(num, 1, 4)
	if self.curmenu ~= num then
		self.curmenu = num

		if num == 1 then
			self:WeaponCategory()
		elseif num == 2 then
			self:AmmoCategory()
		elseif num == 3 then
			self:EquipmentCategory()
		elseif num == 4 then
			self:PerkCategory()
		end
	end
end

function PANEL:PerformLayout(w, h)
	if self.init and !self.postinit then
		self.pick:SetTall(40)

		self:Change(1)
		self.postinit = true
	end
end
vgui.Register("coop_vendor", PANEL, "DFrame" )

netstream.Hook("coop_vendor", function()
	surface.PlaySound("ambient/levels/citadel/pod_close1.wav")
	v = vgui.Create("coop_vendor")
	v:MakePopup()
end)
