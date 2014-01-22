--------------------------------------------------------------------------------
--[[
inRadius3

Elliptical positioning of particles with inner X and Y radii.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.newVent {
	preset = "evil",
	positionType = "inRadius",
	xRadius = 400, -- Make an elliptical shape
	yRadius = 200,
	innerYRadius = 200, -- "Carve out" another ellipse where particles won't get positioned
	innerXRadius = 120,
	physics = {
		velocity = 0
	}
}

vent:start()