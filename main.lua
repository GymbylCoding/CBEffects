--------------------------------------------------------------------------------
-- main.lua
--------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

--------------------------------------------------------------------------------
-- Create Sample Effect
--------------------------------------------------------------------------------
local CBE = require("CBEffects.Library")

local t = display.newText({
	-- Manual kerning for fun and profit:
	text = "C h e c k   o u t   t h e   S a m p l e C a c h e   f o l d e r   t o   g e t   s t a r t e d",
	font = "Times New Roman",
	fontSize = 30
})

t.x,t.y = display.contentCenterX, t.height * 0.5 + 10

local vent = CBE.newVent({
	positionType = "inRadius",
	radius = 500,
	innerRadius = 400,
	onCreation = function(particle, vent)
		particle:setVelocity((vent.x - particle.x) * 0.01, (vent.y - particle.y) * 0.01)
	end,
	physics = {
		gravityY = 0,
		velocity = 0
	}
})

vent:start()