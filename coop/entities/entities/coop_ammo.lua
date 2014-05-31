AddCSLuaFile()

	ENT.Type = "anim"
	ENT.PrintName = "Shipment Vending Machine"
	ENT.Author = "Black Tea"
	ENT.Spawnable = true
	ENT.AdminOnly = true
	ENT.Category = "Black Tea"
	ENT.RenderGroup 		= RENDERGROUP_BOTH

	if CLIENT then
		
		local glow = Material("sprites/glow04_noz.vmt")
	
		function ENT:Initialize()
		end
	
		function ENT:Draw()
			self:DrawModel()
		end
		
		local sx, sy = 292, 93
		function ENT:DrawTranslucent()
			if LocalPlayer():GetPos():Distance(self:GetPos()) > 1000 then return end
			
			self:Draw()
			
			local pos, ang = self:GetPos(), self:GetAngles()
			local opos = pos
			
			pos = pos + self:GetForward() * 13
			pos = pos + self:GetUp()*27.9
			pos = pos + self:GetRight()*7.4
			ang:RotateAroundAxis( self:GetRight(), -90 )
			ang:RotateAroundAxis( self:GetForward(), 90 )

			cam.Start3D2D(pos, ang, .08)
				surface.SetDrawColor(22, 22, 22, 255)
				surface.DrawRect(0, 0, sx, sy)

				local text = DarkRP.formatMoney(self:GetDTInt(2) or 0)
				surface.SetTextColor(255, 255, 255)
				surface.SetFont("ShipmentVenderFont1")
				local tx, ty = surface.GetTextSize(text)
				surface.SetTextPos(sx/2 - tx/2,sy/3*2 - ty/2)
				surface.DrawText(text)
				
				text = self:GetNWString("title", "A Shipment")
				surface.SetTextColor(255, 255, 255)
				surface.SetFont("ShipmentVenderFont2")
				local tx, ty = surface.GetTextSize(text)
				surface.SetTextPos(sx/2 - tx/2,sy/3 - ty/2)
				surface.DrawText(text)
			cam.End3D2D()
			
			pos = opos
			pos = pos + self:GetForward() * 14.5
			pos = pos + self:GetUp()*13
			pos = pos + self:GetRight()*-10
			
			render.SetMaterial(glow)	
			if self:GetDTBool(0) then
				render.DrawSprite(pos, 12, 12, Color( 44, 255, 44 ) )
			else
				render.DrawSprite(pos, 12, 12, Color( 255, 44, 44 ) )
			end
		end
		
		
		net.Receive("VendorOwnerMenu", function()
			Derma_Query("Choose the action", "Confirm", 
				"Empty Machine",
				function()
					net.Start("VendorOwnerUse")
						net.WriteUInt(0, 2)
					net.SendToServer()
				end,
				
				"Use Machine",
				function()
					net.Start("VendorOwnerUse")
						net.WriteUInt(1, 2)
					net.SendToServer()
				end,
				
				"Set Price",
				function()
					Derma_StringRequest("Enter the amount of the price", "Set Price", "",
						function(txt)
							txt = string.gsub(txt, "%a", "")
							if txt == "" then txt = 0 end
							
							net.Start("VendorOwnerUse")
								net.WriteUInt(2, 2)
								net.WriteFloat(txt)
							net.SendToServer()
						end
					)
				end,
				
				"Set Title",	
				function()
					Derma_StringRequest("Enter the title of the product", "Set Title", "",
						function(txt)
							net.Start("VendorOwnerUse")
								net.WriteUInt(3, 2)
								net.WriteString(txt)
							net.SendToServer()
						end
					)
				end
			)
		end)
		
	else
		net.Receive("VendorOwnerUse", function(_, client)
			local com = net.ReadUInt(2)
			if client and client:IsValid() and client.tMachine and client.tMachine:IsValid() then
				local dist = client:GetPos():Distance(client.tMachine:GetPos())
				if (!client.tMachine.vMachine and client == client.tMachine.Owner and dist > 256) then return end
				
				if com == 0 then
					if !client.tMachine:Shipment(client.tMachine:GetPos() + client.tMachine:OBBCenter() + client.tMachine:GetForward()*40) then
						client:ChatPrint("The machine is empty.")	
					else
						client.tMachine:EmitSound("vehicles/atv_ammo_open.wav", 110, 100)
					end
				elseif com == 1 then
					client.tMachine:SpawnItem()
				elseif com == 2 then
					local price = math.abs(tonumber(net.ReadFloat()))
					
					client.tMachine:SetDTInt(2, price)
				elseif com == 3 then
					local string = net.ReadString()
					
					client.tMachine:SetNWString("title", string)
				else
					print('INVALID COMMAND')
				end
			end
		end)
		
		function ENT:Setowning_ent(client)
			if self.CPPISetOwner then
				self:CPPISetOwner(client)
			end
			self.Owner = client
			timer.Simple(.1, function()
				self:SetPos(self:GetPos() + self:GetUp()*50)
			end)
		end
		
		function ENT:Initialize()
			self:SetModel("models/props_lab/reciever_cart.mdl")
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetUseType(SIMPLE_USE)
			self.vMachine = true
			self.health = VENDING_HEALTH:GetInt()
			self.alerttime = CurTime()
			self.alertsnd = CreateSound(self, "ambient/alarms/city_firebell_loop1.wav")
				
			local physicsObject = self:GetPhysicsObject()
			if (IsValid(physicsObject)) then
				physicsObject:Wake()
			end
		end
		
		function ENT:Think()
			if self.alerttime > CurTime() then
				if !self.alert then
					self:GetMachineOwner():ChatPrint("Your machine has been damaged!")
					self.alertsnd:Play()	
				end
				self.alert = true
			else
				if self.alert then
					self.alertsnd:Stop()	
				end
				self.alert = false
			end
		end
		
		function ENT:OnTakeDamage(dmginfo)
			local dmg = dmginfo:GetDamage()
			self.health = self.health - dmg
			self.alerttime = CurTime() + VENDING_ALERTTIME:GetInt()
			
			if self.health < 0 then
				local effectdata = EffectData()
				effectdata:SetStart(self:GetPos())
				effectdata:SetOrigin(self:GetPos())
				effectdata:SetScale(1)
				util.Effect("Explosion", effectdata)
	
				if (self:Shipment(self:GetPos())) then
					self:GetMachineOwner():ChatPrint("Your Shipment Vending Maching has been destroyed!")
				end
				
				self:Remove()	
			end
		end
		
		function ENT:OnRemove()
		end
		
		function ENT:Shipment(pos)
			if (!self:GetDTBool(0) or self:GetDTInt(0) <= 0) then
				return false	
			end
			
			local ply = self:GetMachineOwner()
			local crate = ents.Create("spawned_shipment")
			crate.SID = ply.SID
			crate:Setowning_ent(ply)
			crate:SetContents(self:GetDTInt(0), self:GetDTInt(1))
			crate:SetPos(pos)
			crate.nodupe = true
			crate:Spawn()
			crate:SetPlayer(ply)
			local phys = crate:GetPhysicsObject()
			phys:Wake()	
			
			self:SetDTBool(0, false)
				
			self:SetDTInt(0, 0) // content
			self:SetDTInt(1, 0) // 
			
			return true
		end
		
		function ENT:SpawnItem()
			if self:GetDTInt(1) <= 0 then
				self:EmitSound("plats/elevator_stop.wav", 60, 200)
				return false
			end
			
			local contents = self:GetDTInt(0)
			local class, model
			
			if CustomShipments[contents] then
				class = CustomShipments[contents].entity
				model = CustomShipments[contents].model
			else
				return
			end
			
			self:EmitSound("plats/elevator_stop.wav", 60, 140)
			local pos, ang = self:GetPos(), self:GetAngles()
			pos = pos + self:GetForward()*4
			pos = pos + self:GetUp()*-12
			pos = pos + self:GetRight()*-5
		
			local weapon = ents.Create("spawned_weapon")
			weapon:SetWeaponClass(class)
			weapon:SetModel(model)
			weapon.ammoadd = self.ammoadd or (weapons.Get(class) and weapons.Get(class).Primary.DefaultClip)
			weapon.clip1 = 0
			weapon.clip2 = 0
			weapon.ShareGravgun = true
			weapon:SetPos(pos)
			weapon:SetAngles(AngleRand())
			weapon.nodupe = true
			weapon:Spawn()
			
			local phys = weapon:GetPhysicsObject()
			phys:SetVelocity(self:GetForward()*phys:GetMass()*50)
			
			self:SetDTInt(1, self:GetDTInt(1) - 1)
			
			if self:GetDTInt(1) <= 0 then
				self:SetDTBool(0, false)
			end
			
			return true
		end
		
		function ENT:PhysicsCollide(ent)
			if (ent.HitEntity:IsValid() and ent.HitEntity:GetClass() == "spawned_shipment") then
				if (self:GetDTBool(0)) then
					if ent.HitEntity:Getcontents() == self:GetDTInt(0) then
						self:SetDTInt(1, self:GetDTInt(1) + ent.HitEntity:Getcount())
						self:GetMachineOwner():ChatPrint("You resupplied the machine.")
						self:EmitSound("vehicles/atv_ammo_open.wav", 110, 100)
						ent.HitEntity:Remove()
					else
						self:GetMachineOwner():ChatPrint("You have to empty the machine first!")
					end
				else
					self:SetDTBool(0, true)
					
					self:SetDTInt(0, ent.HitEntity:Getcontents()) // content
					self:SetDTInt(1, ent.HitEntity:Getcount()) // 
						
					self:SetDTInt(2, 1500)
					self:SetNWString("title", CustomShipments[self:GetDTInt(0)].entity)
					
					ent.HitEntity:Remove()
					self:GetMachineOwner():ChatPrint("You registered new item in the machine.")
					self:EmitSound("vehicles/atv_ammo_open.wav", 110, 100)
				end
			end
		end
		
		function ENT:GetMachineOwner()
			if (!self.Owner:IsValid()) then
				if self.CPPIGetOwner then
					local a, b = self:CPPIGetOwner()
					self.Owner = a
				end
			end
		
			return self.Owner
		end
		
		function ENT:Use(client)
			if (self:GetMachineOwner() == client) then
				net.Start("VendorOwnerMenu")
				net.Send(client)
				client.tMachine = self
			else	
				if !client:canAfford(self:GetDTInt(2)) then
					self:EmitSound("hl1/fvox/beep.wav")
					return
				end
				
				if self:SpawnItem() then
					client:addMoney(-self:GetDTInt(2))
					self:GetMachineOwner():addMoney(self:GetDTInt(2))
				end
			end
		end
	
	end