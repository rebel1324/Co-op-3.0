--[[

@PointClass base(Targetname) size(-8 -8 -8, 8 8 8) = game_countdown_timer : "An entity that displays a countdown timer on all players' screens."
[
  	// Inputs
	input StartTimer(float) : "Sets the countdown timer to the number of seconds input and starts it counting."
	input StopTimer(void) : "Stops and removes the countdown timer."
	input PauseTimer(void) : "Pauses the countdown timer but keeps it on players' screens."
	input ResumeTimer(void) : "Resumes a paused countdown timer."
	input SetTimerLabel(string) : "Sets the text displayed above the timer to the input string."
]
]]
ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	if inputName == "SetTimerLabel" then
		self.name = data
	elseif inputName == "StartTimer" then
		PushTimer( self, data, self.name )
	elseif inputName == "StopTimer" then
	elseif inputName == "PauseTimer" then
	elseif inputName == "ResumeTimer" then
	end
end