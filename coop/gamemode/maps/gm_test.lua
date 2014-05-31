
hook.Add("Think", "custom_checkpoint", function()
	if SERVER then
		for k, v in ipairs(ents.GetAll()) do
			if v:IsNPC() and !v.fuckyou then
				local gear = ents.Create("coop_npcgear")
				gear:Spawn()
				gear:Setup(v, "ValveBiped.Bip01_R_Hand")

				v.fuckyou = true
			end
		end
	end
end)

if SERVER then
	AddPlayerBarrier(Vector(351.99505615234, 127.56854248047, 272.03125), Vector(383.96875, 63.794719696045, 431.61709594727))
	AddPlayerBarrier(Vector(384.16232299805, 255.58598327637, 272.03125), Vector(399.72232055664, 192.03125, 367.82788085938))
else
	if 1 then return end
		local origin = Vector(-235.599457, 232.487869, 300.245148)

		local mat = Material( "models/props_combine/stasisfield_beam" ) -- The material ( a wireframe )
		local obj = Mesh() -- Create the IMesh object
		local uv = 3
		local angle = Angle( 0, 0, 0 )

		local up = angle:Up()
		local right = angle:Right()
		local forward = angle:Forward()

		local size = 150

		/*
		local function Vert(vec, norm, u, v)
			local vert = {
				pos = vec,
				normal = norm,
				u = u,
				v = v,
			}

			return vert
		end
		*/

		local verts = { -- A table of 3 vertices that form a triangle
			-- down
			{ pos = origin - right*sizex/2 + forward*sizey/2 - up*sizez/2, u = 0, v = uv, normal = -up }, -- -+
			{ pos = origin - right*sizex/2 - forward*sizey/2 - up*sizez/2, u = 0, v = 0, normal = -up }, -- --
			{ pos = origin + right*sizex/2 - forward*sizey/2 - up*sizez/2, u = uv, v = 0, normal = -up }, -- +-

			{ pos = origin - right*sizex/2 + forward*sizey/2 - up*sizez/2, u = 0, v = uv, normal = -up }, -- -+
			{ pos = origin + right*sizex/2 - forward*sizey/2 - up*sizez/2, u = uv, v = 0, normal = -up }, -- +-
			{ pos = origin + right*sizex/2 + forward*sizey/2 - up*sizez/2, u = uv, v = uv, normal = -up }, -- ++

			-- up
			{ pos = origin - right*sizex/2 + forward*sizey/2 + up*sizez/2, u = 0, v = 0, normal = up }, -- -+
			{ pos = origin + right*sizex/2 + forward*sizey/2 + up*sizez/2, u = 0, v = uv, normal = up }, -- ++
			{ pos = origin + right*sizex/2 - forward*sizey/2 + up*sizez/2, u = uv, v = uv, normal = up }, -- +-

			{ pos = origin + right*sizex/2 - forward*sizey/2 + up*sizez/2, u = uv, v = uv, normal = up }, -- +-
			{ pos = origin - right*sizex/2 - forward*sizey/2 + up*sizez/2, u = uv, v = 0, normal = up }, -- --
			{ pos = origin - right*sizex/2 + forward*sizey/2 + up*sizez/2, u = 0, v = 0, normal = up }, -- -+

			-- forward
			{ pos = origin + right*sizex/2 + forward*sizey/2 + up*sizez/2, u = uv, v = uv, normal = forward }, -- ++
			{ pos = origin - right*sizex/2 + forward*sizey/2 + up*sizez/2, u = 0, v = uv, normal = forward }, -- -+
			{ pos = origin - right*sizex/2 + forward*sizey/2 - up*sizez/2, u = 0, v = 0, normal = forward }, -- --
			
			{ pos = origin - right*sizex/2 + forward*sizey/2 - up*sizez/2, u = 0, v = 0, normal = forward }, -- --
			{ pos = origin + right*sizex/2 + forward*sizey/2 - up*sizez/2, u = uv, v = 0, normal = forward }, -- +-
			{ pos = origin + right*sizex/2 + forward*sizey/2 + up*sizez/2, u = uv, v = uv, normal = forward }, -- ++

			-- backward
			{ pos = origin + right*sizex/2 - forward*sizey/2 + up*sizez/2, u = uv, v = uv, normal = -forward }, -- ++
			{ pos = origin - right*sizex/2 - forward*sizey/2 - up*sizez/2, u = 0, v = 0, normal = -forward }, -- --
			{ pos = origin - right*sizex/2 - forward*sizey/2 + up*sizez/2, u = 0, v = uv, normal = -forward }, -- -+
			
			{ pos = origin - right*sizex/2 - forward*sizey/2 - up*sizez/2, u = 0, v = 0, normal = -forward }, -- --
			{ pos = origin + right*sizex/2 - forward*sizey/2 + up*sizez/2, u = uv, v = uv, normal = -forward }, -- ++
			{ pos = origin + right*sizex/2 - forward*sizey/2 - up*sizez/2, u = uv, v = 0, normal = -forward }, -- +-
		
			-- left
			{ pos = origin - right*sizex/2 + forward*sizey/2 + up*sizez/2, u = uv, v = uv, normal = -right }, -- ++
			{ pos = origin - right*sizex/2 - forward*sizey/2 + up*sizez/2, u = 0, v = uv, normal = -right }, -- -+
			{ pos = origin - right*sizex/2 - forward*sizey/2 - up*sizez/2, u = 0, v = 0, normal = -right }, -- --
			
			{ pos = origin - right*sizex/2 - forward*sizey/2 - up*sizez/2, u = 0, v = 0, normal = -right }, -- --
			{ pos = origin - right*sizex/2 + forward*sizey/2 - up*sizez/2, u = uv, v = 0, normal = -right }, -- +-
			{ pos = origin - right*sizex/2 + forward*sizey/2 + up*sizez/2, u = uv, v = uv, normal = -right }, -- ++
			
			-- right
			{ pos = origin + right*sizex/2 + forward*sizey/2 + up*sizez/2, u = uv, v = uv, normal = right }, -- ++
			{ pos = origin + right*sizex/2 - forward*sizey/2 - up*sizez/2, u = 0, v = 0, normal = right }, -- --
			{ pos = origin + right*sizex/2 - forward*sizey/2 + up*sizez/2, u = 0, v = uv, normal = right }, -- -+
		
			{ pos = origin + right*sizex/2 - forward*sizey/2 - up*sizez/2, u = 0, v = 0, normal = right }, -- --
			{ pos = origin + right*sizex/2 + forward*sizey/2 + up*sizez/2, u = uv, v = uv, normal = right }, -- ++
			{ pos = origin + right*sizex/2 + forward*sizey/2 - up*sizez/2, u = uv, v = 0, normal = right }, -- +-
		}
		obj:BuildFromTriangles( verts ) -- Load the vertices into the IMesh object

		hook.Add( "PostDrawOpaqueRenderables", "IMeshTest", function()

			render.SetMaterial( mat ) -- Apply the material
			obj:Draw() -- Draw the mesh
		end )

end