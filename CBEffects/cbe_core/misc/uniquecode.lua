--------------------------------------------------------------------------------
--[[
CBEffects Component: Unique Code

Generate a unique code string.
--]]
--------------------------------------------------------------------------------

local lib_uniquecode = {}

--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local math_random = math.random
local table_insert = table.insert
local table_concat = table.concat

local codes = {}
local codeMax = 50000 -- Max number for randomly generated code numbers

--------------------------------------------------------------------------------
-- Create a Unique Code
--------------------------------------------------------------------------------
function lib_uniquecode.new(groupName)
	if not codes[groupName] then codes[groupName] = {} end

	local code = math_random(codeMax)
	while codes[groupName][code] do code = math_random(codeMax) end

	codes[groupName][code] = true
	return code
end

--------------------------------------------------------------------------------
-- Delete a Code from Code Cache
--------------------------------------------------------------------------------
function lib_uniquecode.delete(groupName, code)
	if codes[groupName] then
		if codes[groupName][code] then codes[groupName][code] = nil end
	end
end

return lib_uniquecode