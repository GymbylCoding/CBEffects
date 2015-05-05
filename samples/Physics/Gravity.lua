--------------------------------------------------------------------------------
--[[
Gravity

Demonstrates the effect of the gravity parameter on particles.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local sample = CBE.newVent({
	title = "laserVent",
	preset = "lasergun",

	positionType = "inRadius", -- Add a bit of randomness to the position

	rotateTowardVel = true,
	towardVelOffset = 90,

	lifeTime = 300,
	physics = {
		velocity = 20,
		gravityY = 0.5,
		autoCalculateAngles = true,
		angles = {{45, 65}}
	}
})

sample:start()