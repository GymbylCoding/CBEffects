--------------------------------------------------------------------------------
--[[
Box2D

Demonstrates how to use Box2D physics to control particles.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local physics = require("physics")
physics.start()
physics.setGravity(0, 9.8)

local physicsVentGroup = CBE.newVentGroup {
	{
		title = "snow", -- Though the preset already names the vent "snow", always title!
		preset = "snow",
		alpha = 1,
		onVentInit = function(v)
			v.setMovementScale(0) -- Make the vent's internal movement scale zero, which means particles will not be moved by the vent
		end,
		onCreation = function(p, v)
			physics.addBody(p, {density = 0.1, radius = p.width * 0.5})
		end
	},

	{
		title = "snow2",
		preset = "snow",
		alpha = 1, -- For visibility
		y = display.contentHeight, -- The snow preset appears at the top of the screen, but we want to make it appear at the bottom
		onVentInit = function(v)
			v.setMovementScale(0)
		end,
		onCreation = function(p, v)
			physics.addBody(p, {density = 0.1, radius = p.width * 0.5})
			p.gravityScale = -2 -- Make particles move upwards
		end
	}
}

physicsVentGroup:start("snow", "snow2")