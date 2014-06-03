--------------------------------------------------------------------------------
--[[
RectTransition

Transitioning vent rectangle parameters.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

-- Create the vent
local vent = CBE.newVent {
	positionType = "inRect",
	x = 0, y = 0, -- X and Y work as offsets with inRect position type
	rectWidth = display.contentWidth,
	rectHeight = display.contentCenterY * 0.5,
	rectTop = display.contentCenterY * 0.75
}

-- Start our transition
transition.to(vent, {
	rectWidth = display.contentCenterX * 0.5,
	rectHeight = display.contentHeight,
	rectLeft = display.contentCenterX * 0.75,
	rectTop = 0,
	time = 1000,
	delay = 1000
})

vent:start()