--------------------------------------------------------------------------------
--[[
CBEffects Component: Field Frame

Builds the framework for a CBField object.
--]]
--------------------------------------------------------------------------------

local lib_fieldframe = {}

--------------------------------------------------------------------------------
-- Include Libraries and Localize
--------------------------------------------------------------------------------
local screen = require("CBEffects.cbe_core.misc.screen")
local lib_functions = require("CBEffects.cbe_core.misc.functions")

local pairs = pairs
local assert = assert
local display_newGroup = display.newGroup
local fnn = lib_functions.fnn

--------------------------------------------------------------------------------
-- New Field Frame
--------------------------------------------------------------------------------
function lib_fieldframe.newFrame(params, preset)
	local params = params
	local preset = preset

	local field = {
		_cbe_reserved = {
			isField = true
		},

		----------------------------------------------------------------------------
		-- Parameters
		----------------------------------------------------------------------------
		title        = fnn(params.title, preset.title, "field"),
		type         = fnn(params.type, params.shape, preset.type, "circle"),
		x            = fnn(params.x, preset.x, screen.centerX),
		y            = fnn(params.y, preset.y, screen.centerY),
		width        = fnn(params.width, preset.width, screen.centerX),
		height       = fnn(params.height, preset.height, screen.centerY),
		radius       = fnn(params.radius, preset.radius, 200),
		points       = fnn(params.points, preset.points, {{0,0}, {100,0}, {100,100}, {0,100}}),
		onCollision  = fnn(params.onCollision, preset.onCollision, function(p, f) p:applyParticleForce((f.x - p.x) * 0.01,  (f.y - p.y) * 0.01) end),
		singleEffect = fnn(params.singleEffect, preset.singleEffect, false),
		onFieldInit  = fnn(params.onFieldInit, preset.onFieldInit, function() end)
	}

	return field
end

return lib_fieldframe