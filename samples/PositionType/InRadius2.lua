--------------------------------------------------------------------------------
--[[
InRadius2

Elliptical positioning of particles.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.newVent {
	preset = "evil",
	positionType = "inRadius",
	xRadius = 200, -- Instead of a circle, this time we'll make an ellipse
	yRadius = 400, -- Simply provide xRadius and yRadius instead of just radius
	physics = {
		velocity = 0
	}
}

vent:start()