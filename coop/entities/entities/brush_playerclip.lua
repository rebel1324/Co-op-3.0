if SERVER then AddCSLuaFile() end
ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Initialize()
	self.obb = self:GetNWVector("obb")

	self:InitCollision()
end

hook.Add("PlayerAuthed", "clip.clinit", function(ply)
	for k, v in ipairs(ents.FindByClass("brush_playerclip")) do
		-- re-init for shit.
		v:InitCollision()
	end
end)

function ENT:InitCollision()
	self:DrawShadow(false)
	self:SetCollisionBounds(-self.obb, self.obb)
	self:SetSolid(SOLID_BBOX)
	self:SetMoveType(0)
	self:SetCustomCollisionCheck(true)
	if CLIENT then
		self:SetRenderBounds(-self.obb, self.obb)
	end
end

hook.Add("ShouldCollide", "clip.colide", function(a, b)
	if a:GetClass() == "brush_playerclip" then
		if b:IsPlayer() then
			return true
		else
			return false
		end
	end
end)

/*

netstream.Hook("InitClientClip", function(ent)
	local obb = self:GetNWVector("obb")
	ent:SetCollisionBounds(-obb, obb)
	ent:SetCollisionGroup(COLLISION_GROUP_PLAYER)
end)
*/

function ENT:Draw()
end

/*
local matdat = {
	["$basetexture"] = "vgui/progressbar",
}
local clipmat = CreateMaterial("VisualClipMaterial", "VertexLitGeneric", matdat)
*/

function ENT:BuildMeshObj()
	self.meshobj = Mesh()

	local origin = self:GetPos()
	local up = self:GetUp()
	local right = self:GetRight()
	local forward = self:GetForward()

	local sizex = math.abs(self.obb.y)
	local sizey = math.abs(self.obb.x)
	local sizez = math.abs(self.obb.z)

	local scale = 4
	local uv = 1
	local fou = sizex / sizez * scale
	local fov = 1 * scale
	local riu = sizey / sizez * scale
	local riv = 1 * scale
	local upu = sizey / sizex * scale / 2
	local upv = 1 * scale / 2

	local verts = { -- A table of 3 vertices that form a triangle
		-- down
		{ pos = origin - right*sizex + forward*sizey - up*sizez, u = 0, v = 0, normal = -up }, -- -+
		{ pos = origin - right*sizex - forward*sizey - up*sizez, u = upu, v = 0, normal = -up }, -- --
		{ pos = origin + right*sizex - forward*sizey - up*sizez, u = upu, v = upv, normal = -up }, -- +-

		{ pos = origin - right*sizex + forward*sizey - up*sizez, u = upu, v = upv, normal = -up }, -- -+
		{ pos = origin + right*sizex - forward*sizey - up*sizez, u = upu, v = 0, normal = -up }, -- +-
		{ pos = origin + right*sizex + forward*sizey - up*sizez, u = 0, v = 0, normal = -up }, -- ++

		-- up
		{ pos = origin - right*sizex + forward*sizey + up*sizez, u = 0, v = 0, normal = up }, -- -+
		{ pos = origin + right*sizex + forward*sizey + up*sizez, u = 0, v = upv, normal = up }, -- ++
		{ pos = origin + right*sizex - forward*sizey + up*sizez, u = upu, v = upv, normal = up }, -- +-

		{ pos = origin + right*sizex - forward*sizey + up*sizez, u = upu, v = upv, normal = up }, -- +-
		{ pos = origin - right*sizex - forward*sizey + up*sizez, u = upu, v = 0, normal = up }, -- --
		{ pos = origin - right*sizex + forward*sizey + up*sizez, u = 0, v = 0, normal = up }, -- -+

		-- forward
		{ pos = origin + right*sizex + forward*sizey + up*sizez, u = fou, v = fov, normal = forward }, -- ++
		{ pos = origin - right*sizex + forward*sizey + up*sizez, u = 0, v = fov, normal = forward }, -- -+
		{ pos = origin - right*sizex + forward*sizey - up*sizez, u = 0, v = 0, normal = forward }, -- --
		
		{ pos = origin - right*sizex + forward*sizey - up*sizez, u = 0, v = 0, normal = forward }, -- --
		{ pos = origin + right*sizex + forward*sizey - up*sizez, u = fou, v = 0, normal = forward }, -- +-
		{ pos = origin + right*sizex + forward*sizey + up*sizez, u = fou, v = fov, normal = forward }, -- ++

		-- backward
		{ pos = origin + right*sizex - forward*sizey + up*sizez, u = fou, v = fov, normal = -forward }, -- ++
		{ pos = origin - right*sizex - forward*sizey - up*sizez, u = 0, v = 0, normal = -forward }, -- --
		{ pos = origin - right*sizex - forward*sizey + up*sizez, u = 0, v = fov, normal = -forward }, -- -+
		
		{ pos = origin - right*sizex - forward*sizey - up*sizez, u = 0, v = 0, normal = -forward }, -- --
		{ pos = origin + right*sizex - forward*sizey + up*sizez, u = fou, v = fov, normal = -forward }, -- ++
		{ pos = origin + right*sizex - forward*sizey - up*sizez, u = fou, v = 0, normal = -forward }, -- +-
	
		-- left
		{ pos = origin - right*sizex + forward*sizey + up*sizez, u = riu, v = riv, normal = -right }, -- ++
		{ pos = origin - right*sizex - forward*sizey + up*sizez, u = 0, v = riv, normal = -right }, -- -+
		{ pos = origin - right*sizex - forward*sizey - up*sizez, u = 0, v = 0, normal = -right }, -- --
		
		{ pos = origin - right*sizex - forward*sizey - up*sizez, u = 0, v = 0, normal = -right }, -- --
		{ pos = origin - right*sizex + forward*sizey - up*sizez, u = riu, v = 0, normal = -right }, -- +-
		{ pos = origin - right*sizex + forward*sizey + up*sizez, u = riu, v = riv, normal = -right }, -- ++
		
		-- right
		{ pos = origin + right*sizex + forward*sizey + up*sizez, u = riu, v = riv, normal = right }, -- ++
		{ pos = origin + right*sizex - forward*sizey - up*sizez, u = 0, v = 0, normal = right }, -- --
		{ pos = origin + right*sizex - forward*sizey + up*sizez, u = 0, v = riv, normal = right }, -- -+
	
		{ pos = origin + right*sizex - forward*sizey - up*sizez, u = 0, v = 0, normal = right }, -- --
		{ pos = origin + right*sizex + forward*sizey + up*sizez, u = riu, v = riv, normal = right }, -- ++
		{ pos = origin + right*sizex + forward*sizey - up*sizez, u = riu, v = 0, normal = right }, -- +-
	}

	self.meshobj:BuildFromTriangles( verts ) -- Load the vertices into the IMesh object
end

function ENT:DrawTranslucent()
	self.obb = self:GetNWVector("obb")
	self:SetRenderBounds(-self.obb, self.obb)
	self:SetCollisionBounds(-self.obb, self.obb)
		
	if self.obb then
		self:BuildMeshObj()
	end

	if self.meshobj then
		render.SetMaterial(Material("effects/com_shield003a"))

		self.meshobj:Draw()
	end
end

function ENT:StartTouch(ent)
	self.touchSound = self.touchSound or CreateSound(self, "ambient/machines/combine_shield_touch_loop1.wav")
	self.touchSound:Play()
end

function ENT:EndTouch(ent)
	self.touchSound:Stop()
end

function ENT:KeyValue( key, value )
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

-- OLD CODE SNIPPET


		/*
		local matrix = Matrix( )
		matrix:Translate( self:GetPos() )
		matrix:Rotate( self:GetAngles() )
		matrix:Scale( Vector( self.obb.x*2, self.obb.y*2, self.obb.z*2 ) )

		local up = self:GetUp()
		local right = self:GetRight()
		local forward = self:GetForward()
		local uv = .1

		--render.SuppressEngineLighting(true)
			cam.PushModelMatrix( matrix )
				mesh.Begin(MATERIAL_QUADS, 6)
					mesh.TexCoord( 1, uv, uv )
					mesh.QuadEasy( up / 2, -up, 1, 1 )
					mesh.TexCoord( 1, uv, uv )
					mesh.QuadEasy( -forward / 2, forward, 1, 1 )
					
					mesh.TexCoord( 1, uv, uv )
					mesh.QuadEasy( -right / 4, right, 1, 1 )
					mesh.TexCoord( 1, uv, uv )
					mesh.QuadEasy( right / 2, -right, 1, 1 )
					
					mesh.TexCoord( 1, uv, uv )
					mesh.QuadEasy( forward / 2, -forward, 1, 1 )
					mesh.TexCoord( 1, uv, uv )
					mesh.QuadEasy( -forward / 2, forward, 1, 1 )
				mesh.End()
			cam.PopModelMatrix( )
		--render.SuppressEngineLighting(false)
		*/
		/*
		local origin = self:OBBCenter()
		local meshobj = Mesh()
		local up = self:GetUp()
		local right = self:GetRight()
		local forward = self:GetForward()

		local uv = 1
		local verts = {
			{pos = origin + right*self.obb.x + forward*self.obb.y - up*self.obb.z, u = uv, v = uv},
			{pos = origin - right*self.obb.x + forward*self.obb.y - up*self.obb.z, u = uv, v = uv},
			{pos = origin + right*self.obb.x + forward*self.obb.y + up*self.obb.z, u = uv, v = uv},
			{pos = origin - right*self.obb.x + forward*self.obb.y + up*self.obb.z, u = uv, v = uv},

			{pos = origin + right*self.obb.x - forward*self.obb.y - up*self.obb.z, u = uv, v = uv},
			{pos = origin - right*self.obb.x - forward*self.obb.y - up*self.obb.z, u = uv, v = uv},
			{pos = origin + right*self.obb.x - forward*self.obb.y + up*self.obb.z, u = uv, v = uv},
			{pos = origin - right*self.obb.x - forward*self.obb.y + up*self.obb.z, u = uv, v = uv},
		}
		*/