AddCSLuaFile()

if( CLIENT ) then
	SWEP.PrintName = "Text Placer";
	SWEP.Slot = 0;
	SWEP.SlotPos = 0;
	SWEP.CLMode = 0
end

SWEP.HoldType = "fists"

SWEP.Category = "Co-op"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.Primary.Delay			= 1
SWEP.Primary.Recoil			= 0	
SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0 	
SWEP.Primary.ClipSize		= -1	
SWEP.Primary.DefaultClip	= -1	
SWEP.Primary.Automatic   	= false	
SWEP.Primary.Ammo         	= "none"
 
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"

function SWEP:Initialize()
	self:SetWeaponHoldType("knife")
end
	
function SWEP:Deploy()
	return true
end

function SWEP:Think()
end

local gridsize = 1

if SERVER then
	function SWEP:PrimaryAttack()
	end

	function SWEP:Reload()
	end

	function SWEP:SecondaryAttack()
	end
end

if CLIENT then
	function SWEP:PrimaryAttack()
		if IsFirstTimePredicted() then
			netstream.Start("MapTextRequest", textsample.text, textsample.pos, textsample.angle, textsample.scale)
		end
	end


	function OpenTextManager()		
		textmanager = vgui.Create("DFrame")
		local w, h = ScrW(), ScrH()
		local sizex, sizey = 400, 200
		textmanager:SetTitle("Text Manager")
		textmanager:SetSize(sizex, sizey)
		textmanager:SetPos(w/2-sizex/2, h/2-sizey/2)
		textmanager:MakePopup()	

		local content = textmanager:Add("DPanel")
		content:Dock(FILL)
		content:DockPadding(5,5,5,5)

		local tlist = content:Add("DListView")
		tlist:Dock(FILL)
		tlist:AddColumn("Text")
		tlist:AddColumn("Distance")
		tlist.OnClickLine = function(panel, line, selected)
			if (input.IsMouseDown(MOUSE_LEFT)) then
				local menu = DermaMenu()
				menu:AddOption( "Delete This Text", function()
					netstream.Start("MapTextUpdateRequest", true, line.index)
				end):SetImage("icon16/money_add.png")
				menu:AddOption( "Modify This Text", function()
					if texttable[line.index] then
						Derma_StringRequest("Map Text Manager", "Write down the text to change.", texttable[line.index].text, function(text)
							netstream.Start("MapTextUpdateRequest", false, line.index, text)
						end, function() end)
					end
				end):SetImage("icon16/money_delete.png")
				menu:Open()
			end		
		end

		for k, v in ipairs(texttable) do
			local line = tlist:AddLine(v.text, v.pos:Distance(LocalPlayer():GetPos()))
			line.index = k
		end
	end

	function SWEP:Reload()
		if !self.nextMenu or self.nextMenu < CurTime() then
			OpenTextManager()
			self.nextMenu = CurTime() + 1
		end
	end

	function SWEP:TextSettingMenu()		
		local menu = vgui.Create("DFrame")
		local w, h = ScrW(), ScrH()
		local sizex, sizey = 400, 100
		menu:SetTitle("Text Property")
		menu:SetSize(sizex, sizey)
		menu:SetPos(w/2-sizex/2, h/4*3-sizey/2)
		menu:MakePopup()	

		local content = menu:Add("DPanel")
		content:Dock(FILL)
		content:DockPadding(5,5,5,5)

		local text = content:Add("DTextEntry")
		text:Dock(TOP)
		text:SetValue(textsample.text)
		text.OnTextChanged = function(p)
			textsample.text = text:GetValue()
		end

		local slider = content:Add("DNumSlider")
		slider:Dock(TOP)
		slider:SetText("Scale")
		slider.Label:SetTextColor(Color(22, 22, 22))
		slider:SetMin(.1)                
		slider:SetMax(2)
		slider:SetDecimals(2)
		slider:SetValue(textsample.scale)
		slider:DockMargin(10, 2, 0, 2)
		slider.OnValueChanged = function(p)
			textsample.scale = slider:GetValue()
		end
	end
	
	function SWEP:SecondaryAttack()
		if IsFirstTimePredicted() then
			if !self.nextText or self.nextText < CurTime() then
				self:TextSettingMenu()
				self.nextText = CurTime() + .5
			end
		end
		return false
	end

	function SWEP:Deploy()
		textsample.enabled = true
		-- set 3dtext sample on.
	end

	function SWEP:Holster()
		if self.Owner and self.Owner:IsValid() then
			textsample.enabled = false
		end
		-- set 3dtext sample off
		return true
	end

	function SWEP:OnRemove()
		textsample.enabled = false
	end

	function SWEP:Think()
		if textsample.enabled then
			local trace = LocalPlayer():GetEyeTraceNoCursor()

			textsample.pos = trace.HitPos + trace.HitNormal*.1
			local ang = trace.HitNormal:Angle()
			ang:RotateAroundAxis(ang:Up(), 90)
			ang:RotateAroundAxis(ang:Forward(), 90)
			textsample.angle = ang
		end
		-- move 3d text sample.
	end
end