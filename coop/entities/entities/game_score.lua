--[[
@PointClass base(Targetname) size(-8 -8 -8, 8 8 8) = game_lives_manager : "An entity that can give or take lives to or from players and teams."
[
	// Inputs
	input GiveLivesToActivator(integer) : "Gives lives to the activator."
	input GiveLivesToActivatorTeam(integer) : "Gives lives to the activator and their team."
	input GiveLivesToEnemyTeam(integer) : "Gives lives to enemy team."
	input GiveLivesToBlueTeam(integer) : "Gives lives to the Blue team."
	input GiveLivesToRedTeam(integer) : "Gives lives to the Red team."
	input GiveLivesToAlivePlayers(integer) : "Gives lives to players who are still alive."
	input GiveLivesToDeadPlayers(integer) : "Gives lives to players who are dead."
	input GiveLivesToAllPlayers(integer) : "Gives lives all players."
]
]]
ENT.Type = "point"

function ENT:Initialize()
	-- print message on something.
end

function ENT:KeyValue( key, value )
	--print(self:GetClass(), key, value)
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if (inputName == "GiveLivesToAllPlayers") then
		for k, v in ipairs(player.GetAll()) do
			if (v.lives) then
				v.lives = v.lives + tonumber(data)
			end
		end
	elseif (inputName == "GiveLivesToActivator") then
	elseif (inputName == "GiveLivesToActivatorTeam") then
	elseif (inputName == "GiveLivesToEnemyTeam") then
	elseif (inputName == "GiveLivesToBlueTeam") then
	elseif (inputName == "GiveLivesToRedTeam") then
	else
		print("GAMELIVES MANAGER")
		print(self, inputName, data)
	end
end

function ENT:UpdateTransmitState()

	--
	-- The default behaviour for point entities is to not be networked.
	-- If you're deriving an entity and want it to appear clientside, override this
	-- TRANSMIT_ALWAYS = always send, TRANSMIT_PVS = send if in PVS
	--
	return TRANSMIT_NEVER

end