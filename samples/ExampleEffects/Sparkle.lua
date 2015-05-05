--------------------------------------------------------------------------------
--[[
Sparkle

A sparkle effect.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local math_random = math.random
local display_newImageRect = display.newImageRect

local vent = CBE.newVent({
	radius = 120,
	lifeSpan = 500,
	fadeInTime = 200,
	startAlpha = 0,
	perEmit = 3,
	emitDelay = 100,
	color = {255, 255, 0},
	build = function()
		local size = math_random(30, 60)
		return display_newImageRect("textures/sparkle.png", size, size)
	end,
	physics = {
		velocity = 0
	}
})

vent:start()