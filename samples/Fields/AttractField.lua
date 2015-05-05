--------------------------------------------------------------------------------
--[[
AttractField

Creates a field that attracts particles.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

-- Create the vent
local vent = CBE.newVent({
	positionType = "inRect",
	emitX = 0,
	emitY = 0,
	rectWidth = display.contentWidth,
	rectHeight = display.contentHeight
})

-- Create the field
local field = CBE.newField {
	onCollision = function(p, f)
		p:applyForce((f.x - p.x) * 0.01, (f.y - p.y) * 0.01)
	end
}

-- Link the field to the vent in one of three ways

-- Way #1:
vent:linkField(field)
-- Way #2: field:linkVent(vent) - alias for vent.linkField(field)
-- Way #3: In parameters for the field, put "targetVent = vent"


-- Start both the vent and the field
vent:start()
field:start()