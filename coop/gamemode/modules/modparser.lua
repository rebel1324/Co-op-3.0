
local MODEA = 1
local MODEB = 2
local CURMODE = MODEA
function parseString(ehh)
	local a = os.time()
	local powString = {}
	local addme = {}

	local a_1 = false
	local a_2 = 0
	local b_2 = 0

	local saved = ""

	for progress = 1, ehh:len() + 1 do
		if (CURMODE == MODEA) then
			if (ehh[progress] == '"') then
				if (!a_1) then
					a_2 = progress
					a_1 = true
				else
					saved = ehh:sub(a_2 + 1, progress - 1)
					a_2 = 0
					a_1 = false
					CURMODE = MODEB
				end
			end
		elseif (CURMODE == MODEB) then
			if (ehh[progress] == '{') then
				b_2 = progress
			elseif (ehh[progress] == '}') then
				local contents = ehh:sub(b_2 + 1, progress - 1)
				table.insert(powString, {saved, contents})
				b_2 = 0
				CURMODE = MODEA
			end
		end
	end

	a_1 = false
	a_2 = 0
	for aod, v in ipairs(powString) do
		local tstring = v[2]

		addme = {}
		for progress = 1, tstring:len() + 1 do
			if (CURMODE == MODEA) then
				if (tstring[progress] == '"') then
					if (!a_1) then
						a_2 = progress
						a_1 = true
					else
						saved = tstring:sub(a_2 + 1, progress - 1)
						a_2 = 0
						a_1 = false
						CURMODE = MODEB
					end
				end
			elseif (CURMODE == MODEB) then
				if (tstring[progress] == '"') then
					if (!a_1) then
						a_2 = progress
						a_1 = true
					else
						local contents = tstring:sub(a_2 + 1, progress - 1)
						table.insert(addme, {saved, contents})
						saved = nil
						a_2 = 0
						a_1 = false
						CURMODE = MODEA
					end
				end
			end
		end

		v[2] = addme
	end

	return powString
end
