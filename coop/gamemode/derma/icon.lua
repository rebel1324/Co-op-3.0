-- Serious Thanks for : MDAVE, Ronny.
if SERVER then return end

local PANEL = {}

AccessorFunc( PANEL, "m_fAnimSpeed", 	"AnimSpeed" )
AccessorFunc( PANEL, "Entity", 			"Entity" )
AccessorFunc( PANEL, "vCamPos", 		"CamPos" )
AccessorFunc( PANEL, "fFOV", 			"FOV" )
AccessorFunc( PANEL, "vLookatPos", 		"LookAt" )
AccessorFunc( PANEL, "aLookAngle", 		"LookAng" )
AccessorFunc( PANEL, "colAmbientLight", "AmbientLight" )
AccessorFunc( PANEL, "colColor", 		"Color" )
AccessorFunc( PANEL, "bAnimated", 		"Animated" )

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	self.Entity = nil
	self.LastPaint = 0
	self.DirectionalLight = {}
	
	self:SetCamPos( Vector( 50, 50, 50 ) )
	self:SetLookAt( Vector( 0, 0, 40 ) )
	self:SetFOV( 70 )
	
	self.orbit_origin = Vector( 0, 0, 0 )
	self.orbit_ang = Angle( 0, 0, 0 )
	self.orbit_dist = 20
	self.mousemod = 10
	self:SetText( "" )
	self:SetAnimSpeed( 0.5 )
	self:SetAnimated( false )
	
	self:SetAmbientLight( Color( 50, 50, 50 ) )
	
	self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	
	self:SetColor( Color( 255, 255, 255, 255 ) )

end

--[[---------------------------------------------------------
   Name: SetDirectionalLight
-----------------------------------------------------------]]
function PANEL:SetDirectionalLight( iDirection, color )
	self.DirectionalLight[iDirection] = color
end

--[[---------------------------------------------------------
   Name: OnSelect
-----------------------------------------------------------]]
function PANEL:SetModel( strModelName )

	-- Note - there's no real need to delete the old 
	-- entity, it will get garbage collected, but this is nicer.
	if ( IsValid( self.Entity ) ) then
		self.Entity:Remove()
		self.Entity = nil		
	end
	-- Note: Not in menu dll
	if ( !ClientsideModel ) then return end
	self.Entity = ClientsideModel( strModelName, RENDER_GROUP_OPAQUE_ENTITY )
	if ( !IsValid(self.Entity) ) then return end
	self.Entity:SetNoDraw( true )
	
end

function PANEL:GetModel()
	return self.Entity:GetModel()
end

function PANEL:OnCursorEntered( )
	self.mod = true
end

function PANEL:OnCursorExited( )
	self.mod = false
end

function PANEL:PreDrawModel()
	local w, h= self:GetSize()
	surface.SetDrawColor( 255, 255, 255 )
	surface.DrawRect( 0, 0, w, h )
end

function PANEL:PostDrawModel()
	local w, h = self:GetSize()
	surface.SetDrawColor( 255, 0, 0 )
	surface.DrawLine( h/2, 0, h/2, h )
	surface.DrawLine( 0, h/2, h, h/2 )
	
	surface.SetTextColor( 150, 150, 150 )
	surface.SetFont( "ChatFont" )
	surface.SetTextPos( 10, 10 )
	surface.DrawText( "Position: " .. tostring(self.orbit_origin) )
	surface.SetTextPos( 10, 30 )
	surface.DrawText( "Angle: " .. tostring( self.orbit_ang ) )
	surface.SetTextPos( 10, 50 )
	surface.DrawText( "Distance :" .. tostring( self.orbit_dist ) )
	
	surface.SetTextColor( 255, 0, 0 )
	surface.SetFont( "ChatFont" )
	surface.SetTextPos( 10, h-30 )
	if !(input.IsKeyDown( KEY_LCONTROL ) ) then
		surface.DrawText( "LEFT CLICK: MOD ANGLE" )
	else
		surface.DrawText( "LEFT CLICK: MOD ORIGIN" )
	end
end
--[[---------------------------------------------------------
   Name: OnMousePressed
-----------------------------------------------------------]]
function PANEL:Paint()

	if ( !IsValid( self.Entity ) ) then return end
	
	local x, y = self:LocalToScreen( 0, 0 )
	
	self:PreDrawModel()
	self:LayoutEntity( self.Entity )
	
	local ang = ( self.orbit_origin - self.vCamPos ):Angle()
	
	
	local w, h = self:GetSize()
	cam.Start3D( self:GetCamPos(), ang, self.fFOV, x, y, w, h, 5, 4096 )
	cam.IgnoreZ( true )
	
	render.SuppressEngineLighting( true )
	
	render.SetLightingOrigin( self.Entity:GetPos() )
	render.ResetModelLighting( self.colAmbientLight.r/255, self.colAmbientLight.g/255, self.colAmbientLight.b/255 )
	render.SetColorModulation( self.colColor.r/255, self.colColor.g/255, self.colColor.b/255 )
	render.SetBlend( self.colColor.a/255 )
	for i=0, 6 do
		local col = self.DirectionalLight[ i ]
		if ( col ) then
			render.SetModelLighting( i, col.r/255, col.g/255, col.b/255 )
		end
	end
		
	self.Entity:DrawModel()
	
	render.SuppressEngineLighting( false )
	cam.IgnoreZ( false )
	cam.End3D()
	self:PostDrawModel()
	self.LastPaint = RealTime()
	
end

--[[---------------------------------------------------------
   Name: RunAnimation
-----------------------------------------------------------]]
function PANEL:RunAnimation()
	self.Entity:FrameAdvance( (RealTime()-self.LastPaint) * self.m_fAnimSpeed )	
end

--[[---------------------------------------------------------
   Name: RunAnimation
-----------------------------------------------------------]]
function PANEL:StartScene( name )
	
	if ( IsValid( self.Scene ) ) then
		self.Scene:Remove()
	end
	
	self.Scene = ClientsideScene( name, self.Entity )
	
end

-- x^2 + y^2 = r^2
local camvec = Vector( 0, 0, 0 )
local x, y = input.GetCursorPos( )
function PANEL:Think()
	local curx, cury = input.GetCursorPos( )
	local diffx = ( curx - x )/ self.mousemod
	local diffy = ( cury - y )/ self.mousemod
	local aang = self.orbit_ang
	if self.mod then
		if !(input.IsKeyDown( KEY_LCONTROL ) ) then
			if (input.IsMouseDown(MOUSE_LEFT)) then
				self.orbit_ang = self.orbit_ang + Angle( diffy, -diffx, 0 )
			elseif (input.IsMouseDown(MOUSE_RIGHT)) then 
				self.orbit_ang = self.orbit_ang + Angle( 0, 0, diffx+diffy )
			end
		else
			if (input.IsMouseDown(MOUSE_LEFT)) then
				self.orbit_origin = self.orbit_origin + Vector( diffy, diffx  )
			elseif (input.IsMouseDown(MOUSE_RIGHT)) then 
				self.orbit_origin = self.orbit_origin + Vector( 0, 0, diffx+diffy  )
			end
		end
	end
	self:SetCamPos( self.orbit_origin + aang:Forward()*-self.orbit_dist + aang:Right()*self.orbit_dist + aang:Up()*self.orbit_dist)
	x, y = input.GetCursorPos( )
end

function PANEL:OnMousePressed( )
end

--[[---------------------------------------------------------
   Name: LayoutEntity
-----------------------------------------------------------]]
function PANEL:LayoutEntity( Entity )
end

derma.DefineControl( "DModelPanel2", "A panel containing a model", PANEL, "DButton" )

local EDITOR = {}

function EDITOR:Init()
	self:SetSize( 512, 650 )
	self:Center()
	
	self.modelPanel = self:Add( "DModelPanel2" )
	self.modelPanel:Dock( TOP )
	self.modelPanel:SetTall( 512 )
	
	self.settings = self:Add( "DScrollPanel" )
	self.settings:Dock( FILL )
	self.settings:DockMargin( 0, 5, 0, 0 )
	
	local pnlprnt = self
	local label = self.settings:Add( "DLabel" )
	label:Dock( TOP )
	label:DockMargin( 10, 5, 10, 5 )
	label:SetText( "Model" )
	label:SetFont( "ChatFont" )
	self.modelEntry = self.settings:Add( "DTextEntry" )
	self.modelEntry:Dock( TOP )
	self.modelEntry:DockMargin( 10, 0, 10, 10 )
	self.modelEntry:SetEditable( true )
	function self.modelEntry:OnEnter( str )
		pnlprnt:SetModel( tostring( self:GetValue() ) )
	end
	
	self.sensitivity = self.settings:Add( "DNumSlider" )
	self.sensitivity:Dock( TOP )
	self.sensitivity:DockMargin( 10, 0, 10, 0 )
	self.sensitivity:SetText( "Control Sensitivity" )   // Set the text above the slider
	self.sensitivity:SetMin( 1 )                  // Set the minimum number you can slide to
	self.sensitivity:SetMax( 100 )                // Set the maximum number you can slide to
	self.sensitivity:SetDecimals( 1 )             // Decimal places - zero for whole number
	function self.sensitivity:OnValueChanged( val )
		pnlprnt.modelPanel.mousemod = val
	end
	
	self.distance = self.settings:Add( "DNumSlider" )
	self.distance:Dock( TOP )
	self.distance:DockMargin( 10, 0, 10, 0 )
	self.distance:SetText( "Orbit Distance" )   // Set the text above the slider
	self.distance:SetMin( 1 )                  // Set the minimum number you can slide to
	self.distance:SetMax( 500 )                // Set the maximum number you can slide to
	self.distance:SetDecimals( 1 )             // Decimal places - zero for whole number
	function self.distance:OnValueChanged( val )
		pnlprnt.modelPanel.orbit_dist = val
	end
	
	self.fov = self.settings:Add( "DNumSlider" )
	self.fov:Dock( TOP )
	self.fov:DockMargin( 10, 0, 10, 0 )
	self.fov:SetText( "FOV" )   // Set the text above the slider
	self.fov:SetMin( 0 )                  // Set the minimum number you can slide to
	self.fov:SetMax( 500 )                // Set the maximum number you can slide to
	self.fov:SetDecimals( 1 )             // Decimal places - zero for whole number
	function self.fov:OnValueChanged( val )
		pnlprnt.modelPanel.fFOV = val
	end
	
	self.reset = self.settings:Add( "DButton" )
	self.reset:Dock( TOP )
	self.reset:DockMargin( 10, 5, 10, 0 )
	self.reset:SetText( "RESET" )
	function self.reset:DoClick()
		pnlprnt:SetModel( pnlprnt.modelPanel:GetModel() )	
	end
	
	
	self.reset = self.settings:Add( "DButton" )
	self.reset:Dock( TOP )
	self.reset:DockMargin( 10, 5, 10, 0 )
	self.reset:SetText( "COPY TO CLIPBOARD" )
	function self.reset:DoClick()
		local m = pnlprnt.modelPanel
		local str = ""
		str = str .. "local icon = {\n"
		str = str .. Format( '\tmodel = "%s",\n', m:GetModel() )
		str = str .. Format( "\torigin = Vector( %s, %s, %s ),\n", m.orbit_origin.x, m.orbit_origin.y, m.orbit_origin.z )
		str = str .. Format( "\tangle = Angle( %s, %s, %s ),\n", m.orbit_ang.p, m.orbit_ang.y, m.orbit_ang.r )
		str = str .. Format( "\tdistance = %s,\n", m.orbit_dist )
		str = str .. Format( "\tfov = %s,\n", m.fFOV )
		str  =str .. "}\n"
		SetClipboardText( str )
	end
	

	self:SetModel( "models/weapons/w_irifle.mdl" )
end

function EDITOR:SetModel( str )
	local mp = self.modelPanel
	mp:SetModel( str )
	mp:SetCamPos( Vector( 0, 0, 0 ) )
	mp:SetLookAng( Angle( 0, 0, 0 ) )
	mp.orbit_origin = Vector( 0, 0, 0 )
	mp.orbit_ang = Angle( 0, 0, 0 )
	mp.orbit_distance = 20
	mp.fFOV = 70
	self.modelEntry:SetValue( str )
	self.distance:SetValue( mp.orbit_distance )
	self.fov:SetValue( mp:GetFOV() )
	self.sensitivity:SetValue( mp.mousemod )
end

vgui.Register( "BLACKTEA_EDITOR", EDITOR, "DFrame" )

local function PopEditor()
	if editer and editer:IsValid() then editer:Close() editer = nil end
	editer = vgui.Create( "BLACKTEA_EDITOR" )
	editer:MakePopup()
end

concommand.Add( "blacktea_icon_editor", PopEditor )

local mat_color = Material("model_color")
function GetIconRenderer( data, wide, tall, scene )
	local icon_model      = data.model
	local icon_glow_color = Color( 255, 0, 0 )
	local icon_focus      = data.origin
	local icon_angle      = data.angle
	local icon_distance   = data.distance
	local icon_fov        = data.fov

	--self:SetCamPos( self.orbit_origin + aang:Forward()*-self.orbit_dist + aang:Right()*self.orbit_dist + aang:Up()*self.orbit_dist)

	--	local ang = ( self.orbit_origin - self.vCamPos ):Angle()
	local campos = icon_focus + icon_angle:Forward()*-icon_distance + icon_angle:Right()*icon_distance + icon_angle:Up()*icon_distance 
	local camang = ( icon_focus - campos ):Angle()
	
	local width, height = 128, 128
	
	local texture = GetRenderTarget("tex_cus_".. data.name,
		width,
		height,
		RT_SIZE_NO_CHANGE,
		MATERIAL_RT_DEPTH_SEPARATE,
		bit.bor(4, 8),
		CREATERENDERTARGETFLAGS_UNFILTERABLE_OK,
	    IMAGE_FORMAT_RGBA8888
	)
	
	local material = CreateMaterial("mat_cus_".. data.name, "UnlitGeneric", {
		["$ignorez"] = 1,
		["$vertexcolor"] = 1,
		["$vertexalpha"] = 1,
		["$nolod"] = 1,
		["$basetexture"] = texture:GetName()
	})
	
	local entity = ClientsideModel(icon_model, RENDERMODE_BOTH)
	entity:SetNoDraw(true)
	local old_rendertarget = render.GetRenderTarget()
	
	render.SetRenderTarget( texture )
		render.SuppressEngineLighting(true)
			cam.Start3D(campos, camang, icon_fov, 0, 0, width, height, 1, 4096)
				render.Clear(25, 25, 25, 255, true, true)
				render.SetLightingOrigin(Vector(0, 0, 0))
				render.ResetModelLighting(1, 1, 1)
				render.SetBlend(0.99)
				render.SetColorModulation(1, 1, 1)

				render.MaterialOverride(mat_color)
				entity:SetupBones()
				entity:DrawModel()
				render.BlurRenderTarget(texture, 5, 2, 2)
				
				render.MaterialOverride(nil)
				entity:SetupBones()
				entity:DrawModel()
			cam.End3D()
		render.SuppressEngineLighting(false)
	render.SetRenderTarget(old_rendertarget)
	entity:Remove()
	return material
end

local PANEL = {}

local yellow 	= Color( 250, 210, 0 )
local gray		= Color( 64, 64, 64 )
local dark		= Color( 20, 20, 20 )
local white		= Color( 255, 255, 255 )

function PANEL:ReloadIcon()
	local wide	= self:GetWide()
	local tall	= self:GetTall()
	self.material = GetIconRenderer( self.icondata, self:GetModelSkin(), wide, tall )
end

function PANEL:Paint( w, h )
	if !self.material then
		self:ReloadIcon()
	end

	local color = self.Hovered and yellow or gray
	surface.SetDrawColor( color )
	surface.DrawRect( 0, 0, w, h )
	surface.SetDrawColor( white )
	surface.SetMaterial( self.material )
	surface.DrawTexturedRect( 0, 0, w, h )
	surface.SetDrawColor( color )
	surface.DrawOutlinedRect( 1, 1, w -2, h -2 )
	surface.SetDrawColor( dark )
	surface.DrawOutlinedRect( 0, 0, w, h )

	return true
end
function PANEL:SetData( tbl )
	self.icondata = tbl
end
function PANEL:GetModel()
	return self.icondata.model
end
function PANEL:GetModelSkin()
	return self.icondata.skin or 0
end
function PANEL:PaintOver()
	self:DrawSelections()
end
function PANEL:DoClick()
	surface.PlaySound( "ui/buttonclickrelease.wav" )
end
function PANEL:DoRightClick()
end
vgui.Register( "StyleSpawnIcon", PANEL, "DButton" )

