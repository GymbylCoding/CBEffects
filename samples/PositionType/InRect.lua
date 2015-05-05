--------------------------------------------------------------------------------
--[[
InRect

Demonstrates positioning of particles in a rectangle.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local vent = CBE.newVent({
	positionType = "inRect",
	emitX = 0, emitY = 0, -- X and Y work as offsets with inRect position type
	rectWidth = display.contentWidth * 0.75,
	rectHeight = display.contentHeight * 0.75,
	rectLeft = display.contentCenterX * 0.25, -- Left and top coordinates
	rectTop = display.contentCenterY * 0.25
})

vent:start()