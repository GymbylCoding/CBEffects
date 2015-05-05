--------------------------------------------------------------------------------
--[[
PolygonField

Demonstrates a polygonal collision shape for a field.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

-- Here we'll make our vent
local vent = CBE.newVent({
	positionType = "inRect",
	emitX = 0,
	emitY = 0,
	perEmit = 4, -- We want a lot of particles
	rectWidth = display.contentWidth,
	rectHeight = display.contentHeight,
	physics = {
		velocity = 0 -- Particles don't move
	}
})

-- And now our field
local field = CBE.newField({
	type = "polygon",
	points = {
		{30, 30},
		{display.contentWidth - 30, 30},
		{display.contentCenterX, display.contentHeight - 30}
	},
	onCollision = function(p, f)
		p:destroyParticle() -- Delete the particle
	end
})

-- Link the field to the vent
field:linkVent(vent)

-- Start them both
vent:start()
field:start() -- Fields must be started, just like vents