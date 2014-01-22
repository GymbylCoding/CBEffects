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
local codeLength = 6

local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
local special = "`~!@#$%^&*_=/*-+.,;:\"\'<>{}[]()"
local numCharacters = characters:len()
local numSpecial = special:len()

--------------------------------------------------------------------------------
-- Create a Unique Code
--------------------------------------------------------------------------------
function lib_uniquecode.new(groupName)
	if not codes[groupName] then codes[groupName] = {} end
	
	local code = ""
	local codeTable = {}
	
	for i = 1, codeLength do
		local characterIndex = math_random(numCharacters)
		codeTable[i] = characters:sub(characterIndex, characterIndex)
	end
	local characterIndex = math_random(numSpecial)
	codeTable[codeLength + 1] = special:sub(characterIndex, characterIndex)
	code = table_concat(codeTable)
	
	while codes[groupName][code] do
		for i = 1, codeLength do
			local characterIndex = math_random(numCharacters)
			codeTable[i] = characters:sub(characterIndex, characterIndex)
		end
		local characterIndex = math_random(numSpecial)
		codeTable[codeLength + 1] = special:sub(characterIndex, characterIndex)
		code = table_concat(codeTable)
	end
	
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