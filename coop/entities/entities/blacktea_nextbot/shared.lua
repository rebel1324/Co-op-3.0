AddCSLuaFile('utils.lua')
include('utils.lua')

AddCSLuaFile('scheds.lua')
include('scheds.lua')

ENT.Base            = "base_nextbot"
ENT.PrintName = "Black Tea Base Nextbot"
ENT.Author = "Black Tea"
ENT.Category = "Co-op Fagget"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.nextbot = true

ENT.developer = 1
ENT.Health = 100
ENT.Sound = {
	Idle = "",
}

ENT.searchDist = 1000
ENT.attackRange = 100
ENT.attackDamage = 50
ENT.attackDelay = 1
ENT.rangeFactor = .5
ENT.maxArmor = 100
ENT.maxHealth = 100
ENT.jumpPower = 400
ENT.runSpeed = 300
ENT.walkSpeed = 150
ENT.rememberTime = 5

ENT.target = 1
ENT.lastPos = 1
ENT.states = 1
ENT.attackTime = CurTime()
ENT.memTime = CurTime()
ENT.health = ENT.maxHealth
ENT.armor = 0

ENT.anim = {}
ENT.anim.Walk = ACT_WALK
ENT.anim.Run = ACT_RUN
ENT.anim.Idle = ACT_IDLE

function ENT:IsNPC() 
	return true
end