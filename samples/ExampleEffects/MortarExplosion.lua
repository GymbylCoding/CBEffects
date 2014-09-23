--------------------------------------------------------------------------------
--[[
Mortar Explosion

Based on Explosion 1, it's a mortar that launches and explodes.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local mortarX, mortarY

local ventGroup

ventGroup = CBE.newVentGroup({
	{
		preset = "flame",
		title = "flame",

		scale = 0.5,
		positionType = "inRadius",
		color = {{1, 1, 0}, {1, 0.5, 0}},
		particleProperties = {blendMode = "add"},
		x = display.contentCenterX,
		y = display.contentCenterY,

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
			particle:setCBEProperty("scaleRateX", particle:getCBEProperty("scaleRateX") * 0.997)
			particle:setCBEProperty("scaleRateY", particle:getCBEProperty("scaleRateY") * 0.997)
		end,

		physics = {
			velocity = 0,
			gravityY = -0.035,
			angles = {0, 360},
			scaleRateX = 1.05,
			scaleRateY = 1.05
		}
	},

	{
		preset = "lasergun",
		title = "mortar",
		x = display.contentCenterX,
		y = display.contentCenterY,

		build = function()
			return display.newCircle(0, 0, 10)
		end,

		onUpdate = function(particle)
			if particle.x < display.screenOriginX or particle.x > display.contentWidth - display.screenOriginX or particle.y < display.screenOriginY or particle.y > display.contentHeight - display.screenOriginY then
				particle._kill()
			end
		end,

		onDeath = function(particle, vent)
			ventGroup:move("flame", particle.x, particle.y)
			ventGroup:start("flame")
		end,

		rotateTowardVel = true,
		towardVelOffset = 90,

		physics = {
			gravityY = 0.5,
			useVelFunction = true,
			velFunction = function(particle, vent)
				return (mortarX - vent.x) * 0.05, (mortarY - vent.y) * 0.05
			end
		}
	}
})

local function onTap(event)
	mortarX, mortarY = event.x, event.y
	ventGroup:emit("mortar")
end

Runtime:addEventListener("tap", onTap)





























