--------------------------------------------------------------------------------
--[[
RadiusTransition

Transitions radius parameters.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

-- Create the vent
local vent = CBE.newVent({
	preset = "evil",
	positionType = "inRadius",
	xRadius = display.contentCenterX,
	yRadius = display.contentCenterY * 0.5,
	innerXRadius = display.contentCenterX * 0.25,
	innerYRadius = display.contentCenterY * 0.5,
	physics = {
		velocity = 0 -- Make particles stationary for visibility
	}
})

-- Start our transition
transition.to(vent, {
	xRadius = display.contentCenterX * 0.5,
	yRadius = display.contentCenterY,
	innerXRadius = display.contentCenterX * 0.5,
	innerYRadius = display.contentCenterY * 0.25,
	time = 5000,
	delay = 1000
})

vent:start()