--------------------------------------------------------------------------------
--[[
InRadius1

Inner and outer radius positioning of particles.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.newVent {
	preset = "evil",
	positionType = "inRadius",
	radius = 100,
	innerRadius = 60,
	physics = {
		velocity = 0
	}
}

vent:start()