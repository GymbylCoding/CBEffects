--------------------------------------------------------------------------------
--[[
CBEffects Component: Field Core

Core engine for fields.
--]]
--------------------------------------------------------------------------------

local field_core = {}

--------------------------------------------------------------------------------
-- Include Libraries and Localize
--------------------------------------------------------------------------------
local require = require

local screen = require("CBEffects.cbe_core.misc.screen")
local lib_runtime = require("CBEffects.cbe_core.misc.runtime")
local lib_frame = require("CBEffects.cbe_core.field_core.frame")
local lib_presets = require("CBEffects.cbe_core.misc.presets")
local lib_functions = require("CBEffects.cbe_core.misc.functions")
local lib_vst = require("CBEffects.cbe_core.misc.vs-t")

local pointInPolygon = lib_functions.pointInPolygon

--------------------------------------------------------------------------------
-- New Field
--------------------------------------------------------------------------------
function field_core.new(params)
	local params = params or {}
	local presetName = (params.preset or "default"):lower()
	local preset = lib_presets.fields[presetName] or lib_presets.fields["default"]

	------------------------------------------------------------------------------
	-- Create Field
	------------------------------------------------------------------------------
	local field = lib_frame.newFrame(params, preset)

	------------------------------------------------------------------------------
	-- Execute Collision Check & Effect
	------------------------------------------------------------------------------
	function field._cbe_reserved.execute(p)
		local collided = false
		if field.type == "rect" then
			-- Run a simple rectangle test
			if (p.x >= field.x and p.x <= field.x + field.width) and (p.y >= field.y and p.y <= field.y + field.height) then collided = true end
		elseif field.type == "circle" then
			-- Calculate the distance and compare it with the radius
			local dist = (((p.x - field.x) ^ 2) + ((p.y - field.y) ^ 2)) ^ 0.5
			if dist <= field.radius then collided = true end
		elseif field.type == "polygon" then
			-- Collision check with polygon
			if pointInPolygon(field.points, p) then collided = true end
		end

		if field.singleEffect and collided then
			if p.collided then
				return false
			else
				p.collided = true
			end
		end

		-- Collide if collision checks returned true
		if collided then
			field.onCollision(p, field)
		end
	end

	----------------------------------------------------------------------------
	-- Field Methods
	----------------------------------------------------------------------------
	function field.set(params) for k, v in pairs(params) do if k ~= "_cbe_reserved" then field[k] = v end end end
	function field.linkVent(vent) local vent = vent or self vent.linkField(field) end
	function field.unlinkVent(vent) local vent = vent or self vent.unlinkField(field) end
	function field.start() field._cbe_reserved.enabled = true end
	function field.stop() field._cbe_reserved.enabled = false end

	----------------------------------------------------------------------------
	-- Destroy Field
	----------------------------------------------------------------------------
	function field.destroy()
		if field._cbe_reserved.masterFieldGroup then field._cbe_reserved.masterFieldGroup._cbe_reserved.registerDestroy(field) end
	end

	if params.targetVent then field.linkVent(params.targetVent) end
	field.onFieldInit(field)

	return field
end

return field_core