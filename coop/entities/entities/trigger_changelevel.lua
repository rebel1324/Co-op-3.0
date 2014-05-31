ENT.Type = "brush"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
	if key == "map" then
		self.nextmap = value
	end
end

function ENT:OnTouch()
end

function ENT:OnPlayerEntered(player)
end

function ENT:Think()
	local pos, min, max	= self:GetPos(), self:OBBMins(), self:OBBMaxs()
	local players = {}

	for k, v in ipairs(player.GetAll()) do
		local ppos = v:GetPos() + v:OBBCenter()
		if ppos:WithinAABox(pos + min, pos + max) then
			v:Freeze( true )
			table.insert(players, v)

			if !v.finished then
				for k, v in ipairs(player.GetAll()) do
					SendNotify(v, v:Nick() .. " finished the map!", 5)
				end

				v.finished = true
			end
		end
	end

	if #player.GetAll() > 0 and #players == #player.GetAll() then
		if !CHANGING then
			CHANGING = true

			for k, v in ipairs(player.GetAll()) do
				SendObjective(v, "All players finished the map!", 5)
			end

			timer.Simple(10, function()
				RunConsoleCommand("changelevel", self.nextmap)
			end)
		end
	end

	self:NextThink(CurTime()+.1)
	return true
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
end

function ENT:UpdateTransmitState()
	return TRANSMIT_NEVER
end