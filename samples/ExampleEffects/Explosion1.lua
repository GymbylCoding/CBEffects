--------------------------------------------------------------------------------
--[[
Explosion 1

Just a simple explosion.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local vent = CBE.newVent({
	preset = "flame",
	title = "explosion",

	positionType = "inRadius",
	color = {{1, 1, 0}, {1, 0.5, 0}, {0.2, 0.2, 0.2}},
	particleProperties = {blendMode = "add"},
	emitX = display.contentCenterX,
	emitY = display.contentCenterY,

	emissionNum = 5,
	emitDelay = 5,
	perEmit = 1,

	inTime = 100,
	lifeTime = 0,
	outTime = 600,

	onCreation = function(particle)
		particle:changeColor({
			color = {0.1, 0.1, 0.1},
			time = 600
		})
	end,

	onUpdate = function(particle)
		particle:setCBEProperty("scaleRateX", particle:getCBEProperty("scaleRateX") * 0.998)
		particle:setCBEProperty("scaleRateY", particle:getCBEProperty("scaleRateY") * 0.998)
	end,

	physics = {
		velocity = 0,
		gravityY = -0.035,
		angles = {0, 360},
		scaleRateX = 1.05,
		scaleRateY = 1.05
	}
})

vent:start()

timer.performWithDelay(100, function()
	vent.emitX = math.random(display.contentCenterX - display.contentWidth * 0.25, display.contentCenterX + display.contentWidth * 0.25)
	vent.emitY = math.random(display.contentCenterY - display.contentHeight * 0.25, display.contentCenterY + display.contentHeight * 0.25)
	vent:start()
end, 0)