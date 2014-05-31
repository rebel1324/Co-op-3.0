local playerMeta = FindMetaTable("Player")

function playerMeta:GiveMoney(amount)
	if (SERVER) then
		if self.money then
			self.money = self.money + amount
		else
			self.money = amount
		end

		netstream.Start(self, "SyncMoney", {self.money, amount})

		hook.Call("OnGiveMoney", GAMEMODE, self, self.money, amount )
	end
end

function playerMeta:GetMoney()
	return self.money or 0
end

function playerMeta:CanAfford(amount)
	if amount < 0 then
		ErrorNoHalt("Script Provided negative amount for " .. self:Name())
	end

	return (self:GetMoney() >= amount)
end

if (SERVER) then
	function playerMeta:SaveMoney()
		local filename = string.Replace( self:SteamID(), ":", "_" )
		file.CreateDir("coop")
		file.CreateDir("coop/money")
		file.Write("coop/money/"..filename..".txt", self.money or 0)
	end

	function playerMeta:LoadMoney()
		local filename = string.Replace( self:SteamID(), ":", "_" )
		local money = file.Read("coop/money/"..filename..".txt")
		if money then
			self:GiveMoney(tonumber(money))
		else
			self:GiveMoney(100)
		end
	end

	hook.Add("ShutDown", "money.save", function() 
		for k, v in ipairs(player.GetAll()) do
			v:SaveMoney() 
		end
	end)
	hook.Add("PlayerDisconnected", "money.save", function(player) player:SaveMoney() end)
	hook.Add("PlayerAuthed", "money.load", function(player) player:LoadMoney() end)
else
	netstream.Hook("SyncMoney", function(data)
		LocalPlayer().money = data[1]

		hook.Call("OnGiveMoney", GAMEMODE, LocalPlayer(), data[1], data[2] )
	end)
end