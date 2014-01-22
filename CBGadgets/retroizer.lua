--------------------------------------------------------------------------------
--[[
CBGadget: Retroizer

Collects a vent data table and converts it into 8-bit retro style.

Usage:

---------------
local CBE = require("CBEffects.Library")

local retroizer = require("retroizer")

local myVentParams = { -- Vent parameters, not VentGroup parameters
	preset = "fountain"
}

local retroParams = retroizer.retroize{
	data = myVentParams, -- Original vent data
	cellSize = 24, -- Width/height particles will be clamped to
	particleSize = 24 -- Width/height of each particle
}

local vent = CBE.newVent(retroParams) -- Build a vent with the retro parameters

vent:start()
---------------
--]]
--------------------------------------------------------------------------------

local retroizer = {}

local presets = require("CBEffects.cbe_core.misc.presets").vents

local math_round = math.round
local display_newRect = display.newRect
local function spaceToGrid(x,y,size) return math_round((x == 0 and 1 or x) / size), math_round((y == 0 and 1 or y) / size) end

--------------------------------------------------------------------------------
-- Retroize
--------------------------------------------------------------------------------
function retroizer.retroize(params)
	local particleSize
	local cellSize

	local preset
	local build

	preset = presets[params.data.preset or "default"] or presets["default"]

	build = params.data.build or preset.build

	if not params.particleSize then
		local p = build()
		particleSize = p.width
		display.remove(p)
		p = nil
	else
		particleSize = params.particleSize
	end

	cellSize = params.cellSize or particleSize

	local phys = params.data.physics or preset.physics or {}

	phys.angularVelocity = 0
	phys.scaleRateX = 1
	phys.scaleRateY = 1
	params.data.rotateTowardVel = false

	local prevOnCreation = params.data.onCreation or preset.onCreation or function() end
	local prevOnUpdate = params.data.prevOnUpdate or preset.onUpdate or function() end

	params.data.build = function()
		return display_newRect(0, 0, particleSize, particleSize)
	end

	params.data.onCreation = function(p, v, c)
		p.cx, p.cy = p.x, p.y

		prevOnCreation(p, v, c)
	end

	params.data.onUpdate = function(p, v, c)
		p.cx, p.cy = p.cx + (p._cbe_reserved.xVel * v.scaleX), p.cy + (p._cbe_reserved.yVel * v.scaleY)
		local X, Y = spaceToGrid(p.cx, p.cy, cellSize)
		p.x, p.y = X * cellSize, Y * cellSize

		prevOnUpdate(p, v, c)
	end

	return params.data
end

return retroizer