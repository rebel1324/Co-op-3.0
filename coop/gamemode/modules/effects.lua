/*
local e = ParticleEmitter(Vector(0, 0, 0))
local scale = .45
local function ImpactEffect(p, n, d, m)
	if m == 77 then

		local particle = e:Add("particle/smokesprites_000"..math.random(1,9), p)
		particle:SetVelocity(30*-n)
		particle:SetDieTime(math.Rand(1,1.5)*scale)
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(math.Rand(50,80)*scale)
		particle:SetRoll(math.Rand(180,480))
		particle:SetRollDelta(math.Rand(-3,3))
		particle:SetAirResistance(150)
		particle:SetLighting(true)
		
		local ang = -n:Angle()
		for i=0,math.random(4,6) do
			local particle = e:Add("effects/spark", p)
			particle:SetVelocity( ( -n + (ang:Up()*math.Rand(-1,1)+ang:Right()*math.Rand(-1,1)+ang:Forward()*math.Rand(-1,1)))* math.Rand( 100, 500 ))
			particle:SetDieTime(math.Rand(.05,.1))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(math.random(5, 12)*scale)
			particle:SetEndSize(math.random(1,1)*scale*i/2)
			particle:SetStartLength(math.Rand( 5, 10 ) )
			particle:SetEndLength( math.Rand( 15, 20 ) )
			particle:SetGravity( Vector( 0, 0, -10 ) )
			particle:SetColor(200,200,200)
			particle:SetAirResistance(500)
		end
		
		for i=0,math.random(2,5) do
			local particle = e:Add("effects/spark", p)
			particle:SetVelocity( ( -n + Vector( math.Rand( -.5, .5 ), math.Rand( -.5, .5 ), math.Rand( -.5, .5 ) ) ) * math.Rand( 150, 250 ))
			particle:SetDieTime(math.Rand(.2,.4))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(math.random(2,5)*scale)
			particle:SetEndSize(math.random(1,1)*scale*i/2)
			particle:SetStartLength(10 )
			particle:SetEndLength(5)
			particle:SetGravity( Vector( 0, 0, -math.Rand(200,350) ) )
			particle:SetColor(200,200,200)
			particle:SetAirResistance(33)
		end
		
		local particle = e:Add("effects/yellowflare", p)
		particle:SetVelocity(120*-n)
		particle:SetDieTime(math.Rand(0.1,.05)*scale)
		particle:SetStartAlpha(150)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(math.Rand(40,70)*scale)
		particle:SetRoll(math.Rand(180,480))
		particle:SetRollDelta(math.Rand(-3,3))
		particle:SetAirResistance(500)
	else
		for i=0,5 do
			local p1 = e:Add("particle/smokesprites_000"..math.random(1,9), p)
			p1:SetVelocity(20*n*i + Vector(math.Rand(-1, 1), math.Rand(-1, 1), 0)*20 )
			p1:SetDieTime(math.Rand(.8,.9)*scale*i/4)
			p1:SetStartAlpha(200)
			p1:SetEndAlpha(0)
			p1:SetStartSize(0)
			p1:SetEndSize(math.Rand(40,50)*scale*(math.Clamp(i/5, .9, 10)))
			p1:SetRoll(math.Rand(180,480))
			p1:SetRollDelta(math.Rand(-3,3))
			p1:SetAirResistance(2)
			p1:SetLighting(true)
		end

		for i=0,4 do
			local smoke = e:Add("particle/smokesprites_000"..math.random(1,9), p)
			smoke:SetVelocity(90*i*n + Vector(math.Rand(-1, 1), math.Rand(-1, 1), 0)*20 )
			smoke:SetDieTime(math.Rand(.7,.8)*scale*i/4)
			smoke:SetStartAlpha(math.Rand(150,200))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(5,18)*i/3)
			smoke:SetEndSize(math.random(18,22)*scale*i/2)
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-3,3))
			smoke:SetGravity( Vector( 0, 0, 0 ) )
			smoke:SetAirResistance(256)
			smoke:SetLighting(true)
		end
	end
end

local EFFECT = {}

function EFFECT:Init(data)
	local origin = data:GetOrigin()
	local start = data:GetStart()
	local normal = data:GetNormal()
	local rad = data:GetRadius()
	local scale = data:GetScale()
	local dir = (origin - start)
	dir:Normalize()

	local tracedata = {}
	tracedata.start = start
	tracedata.endpos = start + dir*65535
	tracedata.mask = MASK_SHOT

	local trace = util.TraceLine(tracedata)
	ImpactEffect(trace.HitPos, trace.HitNormal, trace.Normal, trace.MatType)
end

function EFFECT:Think( )
	return false
end
function EFFECT:Render()
	return false
end


effects.Register(EFFECT, "Impact")
*/
hook.Add("EntityFireBullets", "effect.bullet", function( ent, data )
end)