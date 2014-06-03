--------------------------------------------------------------------------------
--[[
CBEffects Component: VS-T

The VS-T data structure. This implementation is adapted for CBEffects.
--]]
--------------------------------------------------------------------------------

local lib_vst = {}

--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local error = error
local table_insert = table.insert
local table_remove = table.remove
local table_indexOf = table.indexOf
local table_sort = table.sort

local threshold = 10 -- Threshold between using table.remove and nil-out based removal

--------------------------------------------------------------------------------
-- Create VS-T Structure
--------------------------------------------------------------------------------
function lib_vst.new(storeAs)
	local storeAs = storeAs or "vstStoredIndex"
	local vst = {}
	local stored = {}

	local markedIndices = {}
	local remove = {}
	local removeIndex = 0
	vst._stored = stored

	------------------------------------------------------------------------------
	-- Count Stored Items
	------------------------------------------------------------------------------
	function vst.count()
		return #stored
	end

	------------------------------------------------------------------------------
	-- Add an Item
	------------------------------------------------------------------------------
	function vst.add(p)
		if p._cbe_reserved[storeAs] and stored[p._cbe_reserved[storeAs] ] then return false end
		table_insert(stored, p)
		p._cbe_reserved[storeAs] = #stored --table_indexOf(stored, p)
		return true
	end

	------------------------------------------------------------------------------
	-- Get an Item
	------------------------------------------------------------------------------
	function vst.get(n)
		return stored[n]
	end

	------------------------------------------------------------------------------
	-- Mark an Item for Removal
	------------------------------------------------------------------------------
	function vst.markForRemoval(n)
		if markedIndices[n] then return false end
		removeIndex = removeIndex + 1
		remove[removeIndex] = n
		markedIndices[n] = removeIndex
	end

	------------------------------------------------------------------------------
	-- Remove Items Marked for Removal
	------------------------------------------------------------------------------
	function vst.removeMarked()
		if removeIndex == 0 then return false end

		if removeIndex <= threshold then
			if removeIndex > 1 then table_sort(remove) end
			local offset = 0

			for i = 1, #remove do
				local r = remove[i]

				table_remove(stored, r - offset)
				table_remove(markedIndices, r - offset)

				if i < removeIndex then
					local incr = -(offset + 1)
					for p = r - offset, remove[i + 1] - offset - 1 do
						stored[p]._cbe_reserved[storeAs] = stored[p]._cbe_reserved[storeAs] + incr
					end
				else
					local incr = -offset - 1
					for p = r - offset, #stored do
						stored[p]._cbe_reserved[storeAs] = stored[p]._cbe_reserved[storeAs] + incr
					end
				end
				offset = offset + 1
			end
		else
			local numStored = #stored
			for i = 1, removeIndex do
				stored[remove[i] ] = nil
			end

			local newStored = {}
			for i = 1, numStored do
				if stored[i] ~= nil then
					table_insert(newStored, stored[i])
					newStored[#newStored]._cbe_reserved[storeAs] = #newStored
				end
			end

			stored = newStored
		end

		markedIndices = {}
		removeIndex = 0
		remove = {}
	end

	------------------------------------------------------------------------------
	-- Item Iterator
	------------------------------------------------------------------------------
	function vst.items()
		local iterator = 0

		return function()
			iterator = iterator + 1
			if iterator <= #stored then
				return stored[iterator], iterator
			else
				return nil
			end
		end
	end

	return vst
end

return lib_vst