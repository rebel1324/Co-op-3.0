-- Screw other DB dlls.
-- Since it's not for medium servers, I'll give you more works for that.
-- Nah kidding. Look at NutScript for DB Modding.
-- I brought many code from NutScript for SQL Saving.

local module = "sqlite"
STAT_DB = "stats"
INV_DB = "invs"

local QUERY_INITIAL_STATS = [[
CREATE TABLE ]]..STAT_DB..[[ (
	steamid int,
	name mediumtext,
	money int
);
]]

local QUERY_INITIAL_INVENTORY = [[
CREATE TABLE ]]..INV_DB..[[ (
	steamid int,
	perks mediumtext,
	guns mediumtext,
	stamps mediumtext
);
]]

local function initTables(override)
	local halt = false

	if override then
		sql.Query("DROP TABLE "..STAT_DB)
		sql.Query("DROP TABLE "..INV_DB)
	end

	if (!sql.TableExists(STAT_DB)) then
		local result = sql.Query(QUERY_INITIAL_STATS)

		if (result == false) then
			MsgC(Color(255, 0, 0), "Co-op Player Stat Initialize Failed!\n")
			print(sql.LastError())
			halt = true
		else
			MsgC(Color(0, 255, 0), "Co-op Player Stat SQL Table is now available.\n")
		end
	else
		halt = true
	end

	if (!sql.TableExists(INV_DB)) then
		local result = sql.Query(QUERY_INITIAL_INVENTORY)

		if (result == false) then
			MsgC(Color(255, 0, 0), "Co-op Player Inventory Initialize Failed!\n")
			print(sql.LastError())
			halt = true
		else
			MsgC(Color(0, 255, 0), "Co-op Player Inventory SQL Table is now available.\n")
		end
	else
		halt = true
	end

	if !halt then
		MsgC(Color(0, 255, 0), "Co-op Player Tables are now initialized correctly!\n")
	end
end

initTables()

function dbEscape(value)
	return sql.SQLStr(value)
end

function dbQuery(query, callback)
	local data = sql.Query(query)

	if (data == false) then
		print("Query Error: "..query)
		print(sql.LastError())
	else
		local value = {}

		if (data and data[1]) then
			value = data[1]

			value.faction = tonumber(value.faction)
			value.id = tonumber(value.id)
		end

		if (callback) then
			callback(value, data or {})
		end
	end
end

function dbInsertTable(data, callback, dbTable)
	local query = "INSERT INTO "..(dbTable).." ("

	for k, v in pairs(data) do
		query = query..k..", "
	end

	query = string.sub(query, 1, -3)..") VALUES ("

	for k, v in pairs(data) do
		if (type(k) == "string" and k != "steamid") then
			if (type(v) == "table") then
				v = von.serialize(v)
			end

			-- SQLite doesn't play nice with quotations.
			if (type(v) == "string") then
				if (dbModule == "sqlite") then
					v = dbEscape(v)
				else
					v = "'"..dbEscape(v).."'"
				end
			end
		end

		query = query..v..", "
	end

	query = string.sub(query, 1, -3)..")"
	dbQuery(query, callback)
end

function dbUpdateTable(condition, data, dbTable)
	local query = "UPDATE "..(dbTable or nut.config.dbTable).." SET "

	for k, v in pairs(data) do
		query = query..dbEscape(k).." = "

		if (type(k) == "string" and k != "steamid") then
			if (type(v) == "table") then
				v = von.serialize(v)
			end

			-- SQLite doesn't play nice with quotations.
			if (type(v) == "string") then
				if (dbModule == "sqlite") then
					v = dbEscape(v)
				else
					v = "'"..dbEscape(v).."'"
				end
			end
		end

		query = query..v..", "
	end

	query = string.sub(query, 1, -3).." WHERE "..condition
	dbQuery(query, callback)
end

function dbFetchTable(condition, tables, callback, dbTable)
	local query = "SELECT "..tables.." FROM "..(dbTable).." WHERE "..condition

	dbQuery(query, callback)
end
