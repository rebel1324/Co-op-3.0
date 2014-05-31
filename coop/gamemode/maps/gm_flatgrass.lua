if CLIENT then return end
AddPathCorner( Vector(1785.716796875, 1210.1652832031, -12799.96875), "path1", "path2" )
AddPathCorner( Vector(2042.8941650391, 474.58529663086, -12799.96875), "path2", "path3" )
AddPathCorner( Vector(2833.5283203125, 847.73999023438, -12799.96875), "path3", "path4" )
AddPathCorner( Vector(1993.1613769531, 1913.3317871094, -12799.96875), "path4" )
/*
	if (apca and apca:IsValid()) then
		apca:Remove()
	end
	if (apcb and apcb:IsValid()) then
		apca:Remove()
	end

	apca, apcb = SpawnAPC(Vector(1039.0764160156, 3144.7329101563, -12700), Angle(10, 10, 10), "apc_go")
	apcb:SetKeyValue("target", "path1")
	apcb:Fire("StartForward", "", 0)
	apcb:Fire("GotoPathCorner", "path1", .1)
	*/