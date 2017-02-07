ENT.Base = "base_anim"

ENT.PrintName = "shitai"
ENT.Category = "Yes"
ENT.Author = "Black Tea"
ENT.Information = "Fuck you"

ENT.Spawnable = true
ENT.AdminOnly = false
ENT.RenderGroup 		= RENDERGROUP_BOTH

local size = 128
function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetModel("models/Gibs/HGIBS.mdl")
	self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )
end

function ENT:Draw()
	--self:DrawModel()
end

function ENT:Think()
	if (CLIENT) then
		self:SetRenderBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )
	end
end

local mat =  Material("particle/Particle_Ring_Wave_Additive")
local size = 128
function ENT:DrawTranslucent()
	cam.Start3D2D(self:GetPos(), Angle(0, 0, 0), .5)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(mat)
		surface.DrawTexturedRect(-size/2, -size/2, size, size)
	cam.End3D2D()

	local ang = Angle(0 , 0, 90)
	local function draww()
		draw.SimpleText("+", "creditslogo", 0, -25, color_white, 1, 3)
		draw.SimpleText(black:Name(), "ChatFont", 0, 1, color_white, 1, 5)
	end

	surface.SetFont("creditslogo")
	local w,h = surface.GetTextSize("+")
	draw.SimpleText(text, "creditslogo")

	ang:RotateAroundAxis(self:GetUp(), RealTime() * 100)
	cam.Start3D2D(self:GetPos() + self:GetUp()*80, ang, .5)
	
	render.PushFilterMag( TEXFILTER.NONE)
		render.CullMode(MATERIAL_CULLMODE_CW)
		draww()
		render.CullMode(MATERIAL_CULLMODE_CCW)
		draww()
	render.PopFilterMag( TEXFILTER.NONE)
	cam.End3D2D()
end
