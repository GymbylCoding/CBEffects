--------------------------------------------------------------------------------
--[[
InRadius3

Elliptical positioning of particles with inner X and Y radii.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local vent = CBE.newVent({
	preset = "evil",
	positionType = "inRadius",
	xRadius = 400, -- Make an elliptical shape
	yRadius = 200,
	innerXRadius = 120, -- "Carve out" another ellipse where particles won't get positioned
	innerYRadius = 200,
	physics = {
		velocity = 0
	}
})

vent:start()