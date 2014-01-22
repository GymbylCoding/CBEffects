--------------------------------------------------------------------------------
--[[
Gravity

Demonstrates the effect of the gravity parameter on particles.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local sample = CBE.newVent {
	title = "laserVent",
	preset = "lasergun",
	
	positionType = "inRadius", -- Add a bit of randomness to the position
	
	rotateTowardVel = true,
	towardVelOffset = 90,
	
	lifeTime = 300,
	physics = {
		velocity = 20,
		gravityY = 0.5, -- Set the gravity
		autoAngle = true,
		angles = {{45, 65}}
	}
}

sample:start()