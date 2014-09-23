--------------------------------------------------------------------------------
--[[
CBEffects Component: Presets (Legacy Graphics version)

All the vent and field presets, modified to support Corona's old graphics module.
--]]
--------------------------------------------------------------------------------

local presets = {}

--------------------------------------------------------------------------------
-- Localize and Require
--------------------------------------------------------------------------------
local screen = require("CBEffects.cbe_core.misc.screen")
local lib_functions = require("CBEffects.cbe_core.misc.functions")

local math_random = math.random
local math_sin = math.sin
local display_newRect = display.newRect
local display_newCircle = display.newCircle
local display_newImageRect = display.newImageRect
local angleBetween = lib_functions.angleBetween

local burnColors = {{255, 0, 0}, {255, 255, 0}, {255, 255, 0}, {255, 255, 0}}

--------------------------------------------------------------------------------
-- List of Supported Presets
--------------------------------------------------------------------------------
presets.supported = {
	vents = {"aurora", "beams", "burn", "circles", "confetti", "embers", "evil", "flame", "fluid", "fountain", "hyperspace", "lasergun", "rain", "smoke", "snow", "sparks", "steam", "water", "waterfall"},
	fields = {"out", "colorchange", "rotate", "stop"}
}

--------------------------------------------------------------------------------
-- Vent Presets
--------------------------------------------------------------------------------
presets.vents = {
	-- Default preset - no contents because the parameters for it are used as defaults
	default = {physics = {}},

	------------------------------------------------------------------------------
	-- Aurora
	------------------------------------------------------------------------------
	aurora = {
		title = "aurora",
		positionType = "alongLine",
		x = 0, y = 0,
		point1 = {screen.width * 0.166666667, screen.centerY + (screen.height * 0.166666667)},
		point2 = {screen.width - (screen.width * 0.166666667), screen.centerY + (screen.height * 0.166666667)},
		build = function() return display_newImageRect("CBEffects/textures/glow.png", math_random(80, 150), math_random(160, 550)) end,
		color = {{0, 255, 0}, {150, 255, 150}},
		cycleColor = true,
		perEmit = 1,
		inTime = 500,
		outTime = 1500,
		lifeAlpha = 0.2,
		startAlpha = 0,
		onCreation = function(p) p:translate(0, -p.height * 0.5) end,
		particleProperties = {blendMode = "add"},
		physics = {
			velocity = 1,
			autoCalculateAngles = false,
			angles = {0, 180},
			scaleRateY = 0.999
		}
	},

	------------------------------------------------------------------------------
	-- Beams
	------------------------------------------------------------------------------
	beams = {
		title = "beams",
		positionType = "inRadius",
		build = function() return display_newRect(0, 0, math_random(800), 20) end,
		color = {{255, 0, 0}, {0, 0, 255}},
		cycleColor = true,
		perEmit = 1,
		inTime = 300,
		outTime = 2000,
		lifeAlpha = 0.3,
		startAlpha = 0,
		onCreation = function(p, v) local x, y = p.x, p.y p:setReferencePoint(display.CenterLeftReferencePoint) p.rotation = angleBetween(x, y, v.x, v.y, 90) p.x, p.y = x, y end,
		physics = {
			velocity = 0,
			angularVelocity = 0.04,
		}
	},

	------------------------------------------------------------------------------
	-- Burn
	------------------------------------------------------------------------------
	burn = {
		title = "burn",
		positionType = "atPoint",
		build = function() local size = math_random(50, 150) return display_newImageRect("CBEffects/textures/glow.png", size, size) end,
		color = {{0, 0, 255}},
		emitDelay = 30,
		perEmit = 3,
		inTime = 500,
		outTime = 500,
		startAlpha = 0,
		onCreation = function(p) p:changeColor({color = burnColors[math_random(4)], time = 200}) end,
		particleProperties = {blendMode = "add"},
		physics = {
			angles = {{80, 100}},
			scaleRateX = 0.98,
			scaleRateY = 0.98,
			gravityY = -0.05
		}
	},

	------------------------------------------------------------------------------
	-- Circles
	------------------------------------------------------------------------------
	circles = {
		title = "circles",
		positionType = "alongLine",
		x = 0, y = 0,
		point1 = {100, screen.height - 100},
		point2 = {screen.width - 100, screen.height - 100},
		build = function() return display_newCircle(0, 0, math_random(5, 30)) end,
		color = {{0, 0, 255}, {120, 120, 255}, {0, 0, 255}, {120, 120, 255}, {0, 0, 255}, {120, 120, 255}, {255, 0, 0}},
		emitDelay = 100,
		perEmit = 4,
		inTime = 300,
		outTime = 1000,
		startAlpha = 0,
		physics = {
			velocity = 5,
			angles = {{75, 105}},
			scaleRateX = 0.98,
			scaleRateY = 0.98
		}
	},

	------------------------------------------------------------------------------
	-- Confetti
	------------------------------------------------------------------------------
	confetti = {
		title = "confetti",
		positionType = "alongLine",
		x = 0, y = 0,
		point1 = {0, -10},
		point2 = {screen.width, -10},
		build = function() return display_newRect(0, 0, math_random(10, 15), math_random(10, 15)) end,
		color = {{255, 0, 0}, {0, 0, 255}, {255, 255, 0}, {0, 255, 0}},
		emitDelay = 100,
		perEmit = 2,
		inTime = 100,
		lifeTime = 1900,
		outTime = 50,
		startAlpha = 0,
		rotateTowardVel = true,
		physics = {
			velocity = 5,
			angles = {{200, 340}},
			gravityY = 0.1
		}
	},

	------------------------------------------------------------------------------
	-- Embers
	------------------------------------------------------------------------------
	embers = {
		title = "embers",
		positionType = "alongLine",
		x = 0, y = 0,
		point1 = {100, screen.height},
		point2 = {screen.width - 100, screen.height},
		build = function() local size = math_random(10, 20) return display_newImageRect("CBEffects/textures/glow.png", size, size) end,
		color = {{255, 255, 0}, {255, 255, 0}, {255, 255, 0}, {255, 255, 0}, {255, 0, 0}},
		emitDelay = 100,
		perEmit = 2,
		inTime = 300,
		lifeTime = 0,
		outTime = 1000,
		startAlpha = 0,
		particleProperties = {blendMode = "add"},
		physics = {
			velocity = 5,
			angles = {{75, 105}},
			gravityY = 0
		}
	},

	------------------------------------------------------------------------------
	-- Evil
	------------------------------------------------------------------------------
	evil = {
		title = "evil",
		positionType = "atPoint",
		build = function() local size = math_random(80, 120) return display_newImageRect("CBEffects/textures/glow.png", size, size) end,
		color = {{100, 0, 100}, {0, 0, 180}, {80, 0, 60}},
		emitDelay = 10,
		perEmit = 1,
		inTime = 1500,
		lifeTime = 0,
		outTime = 800,
		startAlpha = 0,
		particleProperties = {blendMode = "add"},
		physics = {
			velocity = 1.5,
			angles = {{0, 360}},
			scaleRateX = 0.997,
			scaleRateY = 0.997
		}
	},

	------------------------------------------------------------------------------
	-- Flame
	------------------------------------------------------------------------------
	flame = {
		title = "flame",
		positionType = "alongLine",
		x = 0, y = 0,
		point1 = {300, screen.height + 100},
		point2 = {screen.width - 300, screen.height + 100},
		build = function() local size = math_random(100, 300) return display_newImageRect("CBEffects/textures/cloud.png", size, size) end,
		color = {{255, 255, 0}, {255, 255, 0}, {255, 255, 0}, {255, 255, 0}, {200, 200, 0}, {200, 200, 0}, {255, 100, 0}},
		emitDelay = 100,
		perEmit = 2,
		inTime = 300,
		lifeTime = 500,
		outTime = 1000,
		startAlpha = 0,
		particleProperties = {blendMode = "screen"},
		physics = {
			xDamping = 0.2,
			yDamping = 0.2,
			velocity = 5,
			angularVelocity = 0.04,
			angles = {{75, 105}},
			scaleRateX = 1.01,
			scaleRateY = 1.01
		}
	},

	------------------------------------------------------------------------------
	-- Fluid
	------------------------------------------------------------------------------
	fluid = {
		title = "fluid",
		positionType = "inRect",
		x = 0, y = 0,
		rectLeft = screen.centerX * 0.5, rectTop = screen.centerY * 0.5,
		rectWidth = screen.centerX, rectHeight = screen.centerY,
		build = function() local size = math_random(100, 400) return display_newImageRect("CBEffects/textures/glow.png", size, size) end,
		color = {{255, 0, 255}, {255, 0, 0}, {255, 0, 0}, {0, 0, 255}},
		emitDelay = 30,
		perEmit = 1,
		inTime = 1500,
		lifeTime = 0,
		outTime = 800,
		startAlpha = 0,
		particleProperties = {blendMode = "add"},
		physics = {
			velocity = 0.5,
			angles = {{0, 360}}
		}
	},

	------------------------------------------------------------------------------
	-- Fountain
	------------------------------------------------------------------------------
	fountain = {
		title = "fountain",
		positionType = "atPoint",
		x = screen.centerX, y = screen.height * 0.75,
		build = function() local size = math_random(50, 80) return display_newImageRect("CBEffects/textures/glow.png", size, size) end,
		color = {{0, 220, 255}},
		inTime = 500,
		lifeTime = 0,
		outTime = 500,
		startAlpha = 0,
		particleProperties = {blendMode = "screen"},
		physics = {
			velocity = 12,
			angles = {{70, 110}},
			scaleRateX = 0.99,
			scaleRateY = 0.99,
			gravityY = 0.5
		}
	},

	------------------------------------------------------------------------------
	-- Hyperspace
	------------------------------------------------------------------------------
	hyperspace = {
		title = "hyperspace",
		positionType = "atPoint",
		x = screen.centerX, y = screen.centerY,
		build = function() return display_newImageRect("CBEffects/textures/glow.png", 10, 5) end,
		color = {{255, 255, 255}},
		emitDelay = 100,
		perEmit = 9,
		inTime = 500,
		lifeTime = 0,
		outTime = 1200,
		startAlpha = 0,
		onCreation = function(p) p:setReferencePoint(display.CenterLeftReferencePoint) end,
		onUpdate = function(p) if p._numUpdates > 3 then p._cbe_reserved.rotateTowardVel = false end end,
		particleProperties = {blendMode = "screen"},
		rotateTowardVel = true,
		physics = {
			linearDamping = 0.9,
			velocity = 0.01,
			angles = {{1, 360}},
			scaleRateX = 1.06,
			maxScaleX = 100,
		}
	},

	------------------------------------------------------------------------------
	-- Laser Gun
	------------------------------------------------------------------------------
	lasergun = {
		title = "lasergun",
		positionType = "atPoint",
		x = 0, y = screen.centerY,
		build = function() return display_newImageRect("CBEffects/textures/glow.png", 150, 10) end,
		color = {{255, 255, 0}},
		emitDelay = 100,
		perEmit = 1,
		inTime = 120,
		lifeTime = 0,
		outTime = 800,
		startAlpha = 0,
		endAlpha = 1,
		physics = {
			velocity = 30,
			autoCalculateAngles = false,
			angles = {0}
		}
	},

	------------------------------------------------------------------------------
	-- Rain
	------------------------------------------------------------------------------
	rain = {
		title = "rain",
		positionType = "alongLine",
		x = 0, y = 0,
		point1 = {0, screen.top - 10},
		point2 = {screen.width * 1.14, screen.top - 10},
		build = function() return display_newRect(0, 0, math_random(2,4), math_random(6,25)) end,
		color = {{255, 255, 255}, {230, 230, 255}},
		perEmit = 1,
		outTime = 2000,
		startAlpha = 0,
		physics = {
			velocity = 10,
			angles = {{250, 260}}
		}
	},

	------------------------------------------------------------------------------
	-- Smoke
	------------------------------------------------------------------------------
	smoke = {
		title = "smoke",
		positionType = "alongLine",
		x = 0, y = 0,
		point1 = {200, screen.height - 100},
		point2 = {screen.width - 200, screen.height - 100},
		build = function() local size = math_random(200, 300) return display_newImageRect("CBEffects/textures/cloud.png", size, size) end,
		color = {{140, 140, 140}, {120, 120, 120}, {100, 100, 100}, {80, 80, 80}},
		emitDelay = 100,
		perEmit = 3,
		inTime = 700,
		outTime = 1200,
		startAlpha = 0,
		physics = {
			xDamping = 0.2,
			yDamping = 0.2,
			velocity = 6,
			angularVelocity = 0.04,
			angles = {{75, 105}},
			scaleRateX = 1.01,
			scaleRateY = 1.01
		}
	},

	------------------------------------------------------------------------------
	-- Snow
	------------------------------------------------------------------------------
	snow = {
		title = "snow",
		positionType = "alongLine",
		x = 0, y = 0,
		point1 = {0, screen.top - 10},
		point2 = {screen.width, screen.top - 10},
		build = function() local size = math_random(10, 40) return display_newImageRect("CBEffects/textures/glow.png", size, size) end,
		color = {{255, 255, 255}, {230, 230, 255}},
		perEmit = 1,
		inTime = 300,
		outTime = 2000,
		startAlpha = 0,
		lifeAlpha = 0.3,
		physics = {
			velFunction = function() return math_random(-1, 1), math_random(10) end,
			useVelFunction = true
		}
	},

	------------------------------------------------------------------------------
	-- Sparks
	------------------------------------------------------------------------------
	sparks = {
		title = "sparks",
		positionType = "inRadius",
		x = screen.centerX, y = screen.centerY,
		build = function() local size = math_random(10, 20) return display_newImageRect("CBEffects/textures/glow.png", size, size) end,
		color = {{255, 255, 255}, {230, 230, 255}},
		emitDelay = 1000,
		perEmit = 6,
		inTime = 300,
		outTime = 1000,
		startAlpha = 0,
		onEmitEnd = function(v) v.perEmit = math_random(5, 15) end,
		physics = {
			velocity = 5,
			gravityY = 0.5
		}
	},

	------------------------------------------------------------------------------
	-- Steam
	------------------------------------------------------------------------------
	steam = {
		title = "steam",
		positionType = "inRadius",
		x = screen.centerX, y = screen.height,
		build = function() local size = math_random(50, 100) return display_newImageRect("CBEffects/textures/cloud.png", size, size) end,
		color = {{255, 255, 255}, {230, 230, 230}, {200, 200, 200}},
		emitDelay = 50,
		perEmit = 10,
		inTime = 200,
		outTime = 800,
		startAlpha = 0,
		physics = {
			velocity = 12.5,
			angularVelocity = 0.04,
			angles = {{85, 95}},
			scaleRateX = 1.02,
			scaleRateY = 1.02
		}
	},


	------------------------------------------------------------------------------
	-- Water
	------------------------------------------------------------------------------
	water = {
		title = "water",
		positionType = "inRect",
		x = 0, y = 0,
		rectTop = screen.height * 0.333333333,
		rectWidth = screen.width,
		rectHeight = screen.height - (screen.height * 0.333333333),
		build = function() return display_newImageRect("CBEffects/textures/glow.png", 160, 20) end,
		color = {{255, 255, 255}, {204, 204, 204}},
		inTime = 500,
		outTime = 500,
		startAlpha = 0,
		onCreation = function(p)
			local a = (p.y - (screen.height * 0.333333333)) / 500 + 0.05
			if a <= 0.2 then
				p.isVisible = false
			else
				p.yScale = a
			end
		end,
		onUpdate = function(p)
			local a = (p.y - (screen.height * 0.333333333)) / 500 + 0.05
			if a <= 0.2 then
				p.isVisible = false
			else
				p.yScale = a
			end
		end,
		physics = {
			velocity = 1,
			angles = {{-20, 20}, {160, 200}}
		}
	},

	------------------------------------------------------------------------------
	-- Waterfall
	------------------------------------------------------------------------------
	waterfall = {
		title = "waterfall",
		positionType = "inRadius",
		x = screen.left, y = 100,
		build = function() local size = math_random(50, 100) return display_newImageRect("CBEffects/textures/cloud.png", size, size) end,
		color = {{255, 255, 255}, {204, 204, 255}, {230, 230, 255}},
		emitDelay = 50,
		perEmit = 3,
		inTime = 500,
		outTime = 800,
		startAlpha = 0,
		physics = {
			velocity = 3.5,
			autoCalculateAngles = false,
			gravityY = 0.5,
			scaleRateX = 1.02,
			scaleRateY = 1.04,
			angles = {0}
		}
	}
}


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Field Presets
--------------------------------------------------------------------------------
presets.fields = {
	default = {},

	------------------------------------------------------------------------------
	-- Out
	------------------------------------------------------------------------------
	out = {
		title = "out",
		onCollision = function(p, f)
			p:applyParticleForce((p.x - f.x) * 0.01,  (p.y - f.y) * 0.01)
		end
	},

	------------------------------------------------------------------------------
	-- Color Change
	------------------------------------------------------------------------------
	colorchange = {
		title = "colorchange",
		singleEffect = true,
		onCollision = function(p, f)
			p.changeColor({0,  0,  255},  500,  0)
		end
	},

	------------------------------------------------------------------------------
	-- Rotate
	------------------------------------------------------------------------------
	rotate = {
		title = "rotate",
		onCollision = function(p, f)
			p:rotate(2)
		end
	},

	------------------------------------------------------------------------------
	-- Stop
	------------------------------------------------------------------------------
	stop = {
		title = "stop",
		onCollision = function(p)
			p:setVelocity(0, 0)
		end
	}
}

return presets