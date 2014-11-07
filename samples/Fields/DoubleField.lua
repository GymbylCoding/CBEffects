--------------------------------------------------------------------------------
--[[
DoubleField

Creates two fields inside a FieldGroup that attract and repel particles.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

-- Create the Vent
local vent = CBE.newVent({
	title = "vent",
	x = 0,
	y = 0,
	positionType = "inRect",
	rectWidth = display.contentWidth,
	rectHeight = display.contentHeight
})

-- Create the FieldGroup
local fieldGroup = CBE.newFieldGroup({ -- We use a FieldGroup because we have two fields that belong together
	{
		title = "in",
		x = display.contentWidth * 0.75,
		radius = display.contentCenterX * 0.5,
		targetVent = vent -- It's easier here to specify a targetVent rather than link both fields seperately
	},

	{
		title = "out",
		preset = "out",
		x = display.contentCenterX * 0.5,
		radius = display.contentCenterX * 0.5,
		targetVent = vent
	}
})

-- Start both the FieldGroup and the Vent
fieldGroup:start("in", "out")
vent:start()