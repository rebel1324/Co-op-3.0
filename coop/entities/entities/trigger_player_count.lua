ENT.Type = "brush"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
	if key == "OnStartTouch" then
		self.touch = self.touch or {}

		local tbl = string.Explode(',', value)
		table.insert(self.touch, tbl)
	elseif key == "OnAllPlayersEntered" then
		self.trigger = self.trigger or {}

		local tbl = string.Explode(',', value)
		table.insert(self.trigger, tbl)
	elseif key == "OnPlayerEntered" then
		self.entered = self.entered or {}
		print(key, value)
		local tbl = string.Explode(',', value)
		table.insert(self.entered, tbl)
	elseif key == "OnPlayerLeave" then
		self.leave = self.leave or {}

		local tbl = string.Explode(',', value)
		table.insert(self.leave, tbl)
	elseif key == "OnRedPlayerEntered" then
	elseif key == "OnBluePlayerEntered" then
	elseif key == "OnRedPlayerLeave" then
	elseif key == "OnBluePlayerLeave" then
	elseif key == "OnAllRedPlayersEntered" then
	elseif key == "OnAllBluePlayersEntered" then
	elseif key == "ConstantAnnounce" then
		self.announce = value
	elseif key == "VolumeName" then
		self.volume = value
	end
end

function ENT:OnTouch()
end

function ENT:OnPlayerEntered(player)
	if self.entered then
		for k, v in pairs(self.entered) do
			if v[1] == "!self" then
				self:Fire(v[2], v[3], v[4])
			else
				local enttbl = ents.FindByName(v[1])
				for _, target in pairs(enttbl) do
					target:Fire(v[2], v[3], v[4])
				end
			end
		end
	end
end

function ENT:OnPlayerExited(player)
	if self.leave then
		for k, v in pairs(self.leave) do
			if v[1] == "!self" then
				self:Fire(v[2], v[4])
			else
				local enttbl = ents.FindByName(v[1])
				for _, target in pairs(enttbl) do
					target:Fire(v[2], v[3], v[4])
				end
			end
		end
	end
end

function ENT:OnAllPlayersEntered()
	if self.trigger then
		for k, v in pairs(self.trigger) do
			if v[1] == "!self" then
				self:Fire(v[2], v[4])
			else
				local enttbl = ents.FindByName(v[1])
				for _, target in pairs(enttbl) do
					target:Fire(v[2], v[3], v[4])
				end
			end
		end

		self:Remove()
	end
end

function ENT:Think()
	local pos, min, max	= self:GetPos(), self:OBBMins(), self:OBBMaxs()
	self.players = self.players or {}
	for k, v in ipairs(player.GetAll()) do
		local ppos = v:GetPos() + v:OBBCenter()
		if ppos:WithinAABox(pos + min, pos + max) then
			if !table.HasValue(self.players, v) then
				if v:Alive() and !v:Team() == TEAM_DEAD then
					self:OnPlayerEntered(v)

					table.insert(self.players, v)
				end
			else
				if !v:Alive() or v:Team() == TEAM_DEAD then
					self:OnPlayerExited(v) 

					table.remove(self.players, k)
				end
			end
		else
			if table.HasValue(self.players, v) then
				self:OnPlayerExited(v)

				table.remove(self.players, k)
			end
		end
	end

	--PrintTable(self.players)

	if (#player.GetAll() > 0 and #player.GetAll() == #self.players) then
		self:OnAllPlayersEntered()
	end

	self:NextThink(CurTime()+.1)
	return true
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "CountPlayers" then
	elseif inputName == "CountPlayersToActivator" then
	elseif inputName == "SetReceiver" then
	elseif inputName == "NullReceiver" then
	end
end

function ENT:UpdateTransmitState()

	return TRANSMIT_NEVER

end