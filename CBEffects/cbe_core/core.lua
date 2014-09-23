--------------------------------------------------------------------------------
--[[
CBEffects Component: Core

Wraps up all core libraries and provides the VentGroup and FieldGroup functions.
--]]
--------------------------------------------------------------------------------

local core = {}

--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local require = require

local vent_core = require("CBEffects.cbe_core.vent_core.core")
local field_core = require("CBEffects.cbe_core.field_core.core")
local lib_presets = require("CBEffects.cbe_core.misc.presets")
local lib_vst = require("CBEffects.cbe_core.misc.vs-t")

local print = print
local type = type
local pairs = pairs
local unpack = unpack
local system_getTimer = system.getTimer
local transition_to = transition.to
local timer_performWithDelay = timer.performWithDelay
local display_remove = display.remove
local table_insert = table.insert
local table_concat = table.concat

--------------------------------------------------------------------------------
-- New Vent/Field
--------------------------------------------------------------------------------
core.newVent = vent_core.new
core.newField = field_core.new

--------------------------------------------------------------------------------
-- New VentGroup
--------------------------------------------------------------------------------
function core.newVentGroup(params)
	local master = {}
	local vents = lib_vst.new("ventGroupIndex")
	local titleReference = {}

	master._cbe_reserved = {}

	------------------------------------------------------------------------------
	-- Internal Commands
	------------------------------------------------------------------------------
	function master._cbe_reserved.resetTitleReference() for vent in vents.items() do titleReference[vent.title] = vent._cbe_reserved.vstStoredIndex end end
	function master._cbe_reserved.registerDestroy(vent) vents.removeByIndex(vent._cbe_reserved.ventGroupIndex) end

	------------------------------------------------------------------------------
	-- Add a Vent
	------------------------------------------------------------------------------
	function master.addVent(params)
		local vent
		if params._cbe_reserved and params._cbe_reserved.isVent then
			vent = params
		else
			vent = vent_core.new(params)
		end
		vent._cbe_reserved.masterVentGroup = master
		vents.add(vent)
		if not master[vent.title] then master[vent.title] = vent.emit end
		titleReference[vent.title] = vent._cbe_reserved.ventGroupIndex
	end

	------------------------------------------------------------------------------
	-- Start All
	------------------------------------------------------------------------------
	function master.startMaster()
		for vent in vents.items() do
			if vent.isActive then
				vent.start()
			end
		end
	end

	------------------------------------------------------------------------------
	-- Stop All
	------------------------------------------------------------------------------
	function master.stopMaster()
		for vent in vents.items() do
			vent.stop()
		end
	end

	------------------------------------------------------------------------------
	-- Emit from All
	------------------------------------------------------------------------------
	function master.emitMaster()
		for vent in vents.items() do
			if vent.isActive then
				vent.emit()
			end
		end
	end

	------------------------------------------------------------------------------
	-- Destroy VentGroup
	------------------------------------------------------------------------------
	function master.destroyMaster()
		for vent, index in vents.items() do
			vent._cbe_reserved.destroy()
			vents.markForRemoval(index)
		end

		vents.removeMarked()

		titleReference = nil
		master = nil
	end

	------------------------------------------------------------------------------
	-- Start Vents
	------------------------------------------------------------------------------
	function master.start(...)
		local args = {...}
		local s = (type(args[1]) == "table" and 2) or 1
		for i = s, #args do
			local index = titleReference[args[i] ]
			if index then
				vents.get(index).start()
			else
				print("start(): Missing vent \"" .. args[i] .. "\".")
			end
		end
	end

	------------------------------------------------------------------------------
	-- Stop Vents
	------------------------------------------------------------------------------
	function master.stop(...)
		local args = {...}
		local s = (type(args[1]) == "table" and 2) or 1
		for i = s, #args do
			local index = titleReference[args[i] ]
			if index then
				vents.get(index).stop()
			else
				print("stop(): Missing vent \"" .. args[i] .. "\".")
			end
		end
	end

	------------------------------------------------------------------------------
	-- Emit from Vents
	------------------------------------------------------------------------------
	function master.emit(...)
		local args = {...}
		local s = (type(args[1]) == "table" and 2) or 1
		for i = s, #args do
			local index = titleReference[args[i] ]
			if index then
				vents.get(index).emit()
			else
				print("emit(): Missing vent \"" .. args[i] .. "\".")
			end
		end
	end

	------------------------------------------------------------------------------
	-- Get Vents
	------------------------------------------------------------------------------
	function master.get(...)
		local args = {...}
		local getTable = {}

		local s = (type(args[1]) == "table" and 2) or 1
		for i = s, #args do
			local index = titleReference[args[i] ]
			if index then
				table_insert(getTable, vents.get(index))
			else
				print("get(): Missing vent \"" .. args[i] .. "\".")
			end
		end

		if #getTable == 1 then return getTable[1] end
		return unpack(getTable)
	end

	------------------------------------------------------------------------------
	-- Destroy Vents
	------------------------------------------------------------------------------
	function master.destroy(...)
		local args = {...}
		local s = (type(args[1]) == "table" and 2) or 1

		for i = s, #args do
			local index = titleReference[args[i] ]
			if index then
				vents.get(index)._cbe_reserved.destroy()
				vents.markForRemoval(index)
				titleReference[args[i] ] = nil
			else
				print("destroy(): Missing vent \"" .. args[i] .. "\".")
			end
		end

		vents.removeMarked()
	end

	------------------------------------------------------------------------------
	-- List Vents
	------------------------------------------------------------------------------
	function master.listVents()
		print("listVents():")
		for vent, i in vents.items() do
			print("-> " .. vent.title)
		end
	end

	------------------------------------------------------------------------------
	-- Convenience Functions
	------------------------------------------------------------------------------
	function master.move(self, title, x, y) local title, x, y = title, x, y if not y then title, x, y = self, title, x end local index = titleReference[title] if not index then print("move(): Missing vent.") return false end vents.get(index).set({x = x, y = y}) end
	master.translate = master.move

	------------------------------------------------------------------------------
	-- Build Initial Vents
	------------------------------------------------------------------------------
	for i = 1, #params do master.addVent(params[i]) end

	return master
end


--------------------------------------------------------------------------------
-- New FieldGroup
--------------------------------------------------------------------------------
function core.newFieldGroup(params)
	local master = {}
	local fields = lib_vst.new("fieldGroupIndex")
	local titleReference = {}

	master._cbe_reserved = {}

	------------------------------------------------------------------------------
	-- Internal Commands
	------------------------------------------------------------------------------
	function master._cbe_reserved.resetTitleReference() for field in fields.items() do titleReference[field.title] = field._cbe_reserved.vstStoredIndex end end
	function master._cbe_reserved.registerDestroy(field) fields.removeByIndex(field._cbe_reserved.fieldGroupIndex) end

	------------------------------------------------------------------------------
	-- Add a Field
	------------------------------------------------------------------------------
	function master.addField(params)
		local field
		if params._cbe_reserved and params._cbe_reserved.isField then
			field = params
		else
			field = field_core.new(params)
		end
		field._cbe_reserved.masterFieldGroup = master
		fields.add(field)
		if not master[field.title] then master[field.title] = field.emit end
		titleReference[field.title] = field._cbe_reserved.fieldGroupIndex
	end

	------------------------------------------------------------------------------
	-- Start All
	------------------------------------------------------------------------------
	function master.startMaster()
		for field in fields.items() do
			if field.isActive then
				field.start()
			end
		end
	end

	------------------------------------------------------------------------------
	-- Stop All
	------------------------------------------------------------------------------
	function master.stopMaster()
		for field in fields.items() do
			field.stop()
		end
	end

	------------------------------------------------------------------------------
	-- Destroy Master
	------------------------------------------------------------------------------
	function master.destroyMaster()
		for field in fields.items() do
			fields.markForRemoval(field._cbe_reserved.fieldGroupIndex)
		end
		fields.removeMarked()
		master = nil
	end

	------------------------------------------------------------------------------
	-- Start Fields
	------------------------------------------------------------------------------
	function master.start(...)
		local args = {...}
		local s = (type(args[1]) == "table" and 2) or 1
		for i = s, #args do
			local index = titleReference[args[i] ]
			if index then
				fields.get(index).start()
			else
				print("start(): Missing field \"" .. args[i] .. "\".")
			end
		end
	end

	------------------------------------------------------------------------------
	-- Stop Fields
	------------------------------------------------------------------------------
	function master.stop(...)
		local args = {...}
		local s = (type(args[1]) == "table" and 2) or 1
		for i = s, #args do
			local index = titleReference[args[i] ]
			if index then
				fields.get(index).stop()
			else
				print("stop(): Missing field \"" .. args[i] .. "\".")
			end
		end
	end

	------------------------------------------------------------------------------
	-- Get Fields
	------------------------------------------------------------------------------
	function master.get(...)
		local args = {...}
		local getTable = {}

		local s = (type(args[1]) == "table" and 2) or 1
		for i = s, #args do
			local index = titleReference[args[i] ]
			if index then
				table_insert(getTable, fields.get(index))
			else
				print("get(): Missing field \"" .. args[i] .. "\".")
			end
		end

		if #getTable == 1 then return getTable[1] end
		return unpack(getTable)
	end

	------------------------------------------------------------------------------
	-- Convenience Functions
	------------------------------------------------------------------------------
	function master.move(self, title, x, y) local title, x, y = title, x, y if not y then title, x, y = self, title, x end local index = titleReference[title] if not index then print("move(): Missing field \"" .. title .. "\".") return false end fields.get(index).set({x = x, y = y}) end
	master.translate = master.move

	------------------------------------------------------------------------------
	-- Destroy Fields
	------------------------------------------------------------------------------
	function master.destroy(...)
		local args = {...}
		local s = (type(args[1]) == "table" and 2) or 1

		for i = s, #args do
			local index = titleReference[args[i] ]
			if index then
				fields.markForRemoval(index)
				titleReference[args[i] ] = nil
			else
				print("destroy(): Missing field \"" .. args[i] .. "\".")
			end
		end

		fields.removeMarked()
	end

	------------------------------------------------------------------------------
	-- List Fields
	------------------------------------------------------------------------------
	function master.listFields()
		print("listFields():")
		for field, i in fields.items() do
			print("-> " .. field.title)
		end
	end

	------------------------------------------------------------------------------
	-- Build Initial Fields
	------------------------------------------------------------------------------
	for i = 1, #params do master.addField(params[i]) end

	return master
end

--------------------------------------------------------------------------------
-- Convenience Functions
--------------------------------------------------------------------------------
function core.listPresets()
	local tbl = {"\nField Presets\n--------------------\n"}

	for k, v in pairs(lib_presets.fields) do
		table_insert(tbl, k)
		table_insert(tbl, "\n")
	end

	table_insert(tbl, "\n")
	table_insert(tbl, "\nVent Presets\n--------------------\n")

	for k, v in pairs(lib_presets.vents) do
		table_insert(tbl, k)
		table_insert(tbl, "\n")
	end

	print(table_concat(tbl))
end

return core
