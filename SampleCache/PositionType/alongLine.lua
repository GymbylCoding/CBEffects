--------------------------------------------------------------------------------
--[[
alongLine

Particles positioned along a line.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.newVent {
	preset = "burn",
	positionType = "alongLine",
	x = 0, y = 0, -- Set the X and Y to 0, because with alongLine position type, X and Y act as offsets
	point1 = {0, 0},
	point2 = {display.contentWidth, display.contentHeight},
	physics = {
		velocity = 0,
		gravityY = 0
	}
}

vent:start()