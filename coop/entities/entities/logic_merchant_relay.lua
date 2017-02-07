--[[

@PointClass base(Targetname) = logic_merchant_relay : "Usefull for entity based merchants."
[

	StartDisabled(choices) : "Start Disabled?" : 0 =
	[
		0 : "No"
		1 : "Yes"
	]

	IsShared(choices) : "Is Shared?" : 0 : "Can all players chip in to buy this?" =
	[
		0 : "No"
		1 : "Yes"
	]

	AnnounceCashNeeded(choices) : "Announce Cash Needed?" : 1 : "Tell the players how much cash they still need to purchase?" =
	[
		0 : "No"
		1 : "Yes"
	]

	purchasesound(sound) : "Purchase Sound" : "" : "Name of the GameSound entry for the sound to play on purchase. Also supports direct .wav filenames."
	CostOf(integer) : "Cost of Purchase" : 5
	MaxPointsTake(integer) : "Max Points to take ( Shared Only )" : 0 : "How many points should be taken from the player when they input purchase? 0 Means as much as needed."
	PurchaseName(string) : "Name of Purchase" : "A New Car!" : "Name of the purchase, which will appear in relay messages from this entity."

	// Inputs
	input SetPurchaseCost(integer) : "Sets the cost of the purchase."
	input SetPurchaseName(string) : "Sets the name of the purchase."
	input Purchase(void) : "Purchases item, or puts points towards a purchase if shared."
	input Enable(void) : "Enables this entity."
	input Disable(void) : "Disables this entity from use."

	// Outputs
	output OnPurchased(void) : "Fired when purchase is successful. Usefull for spawning your custom purchase."
	output OnNotEnoughCash(void) : "Fired when the non-shared item is too expensive for the player."
	output OnCashReduced(void) : "Fired when the shared items price has lowered from chip-ins."
	output OnDisabled(void) : "Fired when purchase input has been given, but the relay is disabled."
]
]]
ENT.Type = "point"

function ENT:Initialize()
	--PrintTable(self:GetSaveTable())
end

function ENT:KeyValue( key, value )
	if key == "OnPurchased" then
		self.actions = self.actions or {}

		local tbl = string.Explode(',', value)
		table.insert(self.actions, tbl)
	elseif key == "purchasesound" then
		self.sound = value
	elseif key == "CostOf" then
		self.cost = value
	elseif key == "targetname" then
		self.target = value
	elseif key == "PurchaseName" then
		self.name = value
	elseif key == "StartDisabled" then
	elseif key == "IsShared" then
	elseif key == "AnnounceCashNeeded" then
	elseif key == "MaxPointsTake" then
	elseif key == "OnPurchased" then
	elseif key == "OnNotEnoughCash" then
	elseif key == "OnCashReduced" then
	elseif key == "OnDisabled" then
	else
		--print(self:GetClass(), key, value)
	end
end

function ENT:Think()
end

function ENT:OnRemove()
end

function ENT:AcceptInput( inputName, activator, called, data )
	RequestPurchase(self, inputName, activator, called, data)
end

function ENT:UpdateTransmitState()
	return TRANSMIT_NEVER
end