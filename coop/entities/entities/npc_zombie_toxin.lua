AddCSLuaFile()

ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.AutomaticFrameAdvance = true
ENT.SeekRange = 1500

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/zombie/poison.mdl" )

		self:SetHullType( HULL_HUMAN );
		self:SetHullSizeNormal();
		self:SetSolid( SOLID_BBOX ) 
		self:SetMoveType( MOVETYPE_STEP )
		self:CapabilitiesAdd( CAP_MOVE_GROUND || CAP_ANIMATEDFACE || CAP_TURN_HEAD || CAP_AIM_GUN || CAP_OPEN_DOORS )
		self:SetHealth( 1 )
	end

	function ENT:SeekEnemy()
		local nearest = math.huge
		local near
		local npcpos = self:GetPos() + self:OBBCenter()

		for k, v in pairs(player.GetAll()) do
			local dist = v:EyePos():Distance(npcpos)
			local trace = util.TraceLine({start = npcpos, endpos = v:GetPos()+v:OBBCenter()})
			print(trace.HitPos)
			print(trace.HitEntity)
			if dist < nearest and trace.HitEntity == v then
				nearest = dist
				near = v
			end
		end

		return near
	end
	
	function ENT:SelectSchedule(npcState)
		if GetConVarNumber("ai_disabled") == 1 or self:GetNPCState() == NPC_STATE_DEAD then return end
		/*
		if near then
			schdChase:EngTask( "TASK_STOP_MOVING", 0 )
			schdChase:EngTask( "TASK_FACE_ENEMY", 0 )
		    schdChase:EngTask( "TASK_WAIT", 0.1 )
			schdChase:AddTask( "PlaySequence", { Name = "releasecrab", Speed = 3 } )
		end
		*/

		local wander = ai_schedule.New( "toxin_wander" )
		wander:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 384)
		wander:AddTask("TASK_WALK_PATH", 0)
		wander:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
		self:StartSchedule(wander)

	--local combat = ai_schedule.New( "toxin_find" ) //creates the schedule used for this npc
	--combat:AddTask( "FindEnemy", { Class = "player", Radius = 1500 } )
	--combat:EngTask( "TASK_GET_PATH_TO_RANDOM_NODE", 128 )
	--combat:EngTask( "TASK_RUN_PATH_TIMED", 0.1 )
	--combat:EngTask( "TASK_WAIT", 0.1 )

		--self:SeekEnemy()
		--self:StartSchedule( wander ) 

	end

else
	ENT.RenderGroup = RENDERGROUP_BOTH

	function ENT:Draw()
		self:DrawModel()
	end
end