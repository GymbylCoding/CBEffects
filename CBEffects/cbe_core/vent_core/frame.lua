--------------------------------------------------------------------------------
--[[
CBEffects Component: Vent Frame

Builds the framework for a CBVent object.
--]]
--------------------------------------------------------------------------------

local lib_ventframe = {}

--------------------------------------------------------------------------------
-- Include Libraries and Localize
--------------------------------------------------------------------------------
local screen = require("CBEffects.cbe_core.misc.screen")
local lib_functions = require("CBEffects.cbe_core.misc.functions")

local display_newGroup = display.newGroup
local fnn = lib_functions.fnn

--------------------------------------------------------------------------------
-- New Vent Frame
--------------------------------------------------------------------------------
function lib_ventframe.newFrame(params, preset)
	local params = params
	local preset = preset

	params.physics = params.physics or {}
	preset.physics = preset.physics or {}

	local vent = {
		calculatedAngles = {},
		calculatedLinePoints = {},
		_cbe_reserved = {
			isVent = true
		},

		----------------------------------------------------------------------------
		-- Basic Parameters
		----------------------------------------------------------------------------
		x                   = fnn(params.x, preset.x, screen.centerX),
		y                   = fnn(params.y, preset.y, screen.centerY),
		build               = fnn(params.build, preset.build, function() return display.newRect(0, 0, 20, 20) end),
		particleProperties  = fnn(params.particleProperties, preset.particleProperties, {}),
		scale               = fnn(params.scale, preset.scale, 1),
		scaleX              = fnn(params.scaleX, params.scale or preset.scaleX, preset.scaleX, 1),
		scaleY              = fnn(params.scaleY, params.scale or preset.scaleY, preset.scaleY, 1),
		parentGroup         =    (params.parentGroup),
		isActive            = fnn(params.isActive, preset.isActive, true),
		title               = fnn(params.title, preset.title, "vent"),
		content             = display_newGroup(),
		rotateTowardVel     = fnn(params.rotateTowardVel, preset.rotateTowardVel, false),
		towardVelOffset     = fnn(params.towardVelOffset, preset.towardVelOffset, 0),

		----------------------------------------------------------------------------
		-- Color Parameters
		----------------------------------------------------------------------------
		color               = fnn(params.color, preset.color, {{1, 1, 1}}),
		cycleColor          = fnn(params.cycleColor, preset.cycleColor, false),
		curColor            = fnn(params.curColor, preset.curColor, 1),
		colorIncr           = fnn(params.colorIncr, preset.colorIncr, 1),
		hasColor            = fnn(params.hasColor, preset.hasColor, true),

		----------------------------------------------------------------------------
		-- Emit Parameters
		----------------------------------------------------------------------------
		emitDelay           = fnn(params.emitDelay, preset.emitDelay, 5),
		perEmit             = fnn(params.perEmit, preset.perEmit, 2),
		emissionNum         = fnn(params.emissionNum, preset.emissionNum, 0),
		roundNum            = 0,

		----------------------------------------------------------------------------
		-- Particle Life Parameters
		----------------------------------------------------------------------------
		startAlpha          = fnn(params.startAlpha, preset.startAlpha, 1),
		lifeAlpha           = fnn(params.lifeAlpha, preset.lifeAlpha, 1),
		endAlpha            = fnn(params.endAlpha, preset.endAlpha, 0),
		inTime              = fnn(params.inTime, preset.inTime, 0),
		lifeTime            = fnn(params.lifeTime, preset.lifeTime, 0),
		outTime             = fnn(params.outTime, preset.outTime, 1000),

		----------------------------------------------------------------------------
		-- Callback Function Parameters
		----------------------------------------------------------------------------
		onCreation          = fnn(params.onCreation, preset.onCreation, function() end),
		onCreationTime      = fnn(params.onCreationTime, preset.onCreationTime, ""),
		onDeath             = fnn(params.onDeath, preset.onDeath, function() end),
		onUpdate            = fnn(params.onUpdate, preset.onUpdate, function() end),
		onVentInit          = fnn(params.onVentInit, preset.onVentInit, function() end),
		onEmitBegin         = fnn(params.onEmitBegin, preset.onEmitBegin, function() end),
		onEmitEnd           = fnn(params.onEmitEnd, preset.onEmitEnd, function() end),

		----------------------------------------------------------------------------
		-- Position Parameters
		----------------------------------------------------------------------------
		positionType        = fnn(params.positionType, preset.positionType, "inRadius"),
		pointList           = fnn(params.pointList, preset.pointList, {{0, 0}}),
		cyclePoint          = fnn(params.cyclePoint, preset.cyclePoint, false),
		curPoint            = fnn(params.curPoint, preset.curPoint, 1),
		pointIncr           = fnn(params.pointIncr, preset.pointIncr, 1),
		point1              = fnn(params.point1, preset.point1, {0,0}),
		point2              = fnn(params.point2, preset.point2, {1,0}),
		lineDensity         = fnn(params.lineDensity, preset.lineDensity, "total"),
		radius              = fnn(params.radius, preset.radius, 30),
		xRadius             = fnn(params.xRadius, params.radius or preset.xRadius, preset.radius, 30),
		yRadius             = fnn(params.yRadius, params.radius or preset.yRadius, preset.radius, 30),
		innerRadius         = fnn(params.innerRadius, preset.innerRadius, 1),
		innerXRadius        = fnn(params.innerXRadius, params.innerRadius or preset.innerXRadius, preset.innerRadius, 1),
		innerYRadius        = fnn(params.innerYRadius, params.innerRadius or preset.innerYRadius, preset.innerRadius, 1),
		rectLeft            = fnn(params.rectLeft, preset.rectLeft, 0),
		rectTop             = fnn(params.rectTop, preset.rectTop, 0),
		rectWidth           = fnn(params.rectWidth, preset.rectWidth, screen.centerX),
		rectHeight          = fnn(params.rectHeight, preset.rectHeight, screen.centerY),

		----------------------------------------------------------------------------
		-- Physics Parameters
		----------------------------------------------------------------------------
		linearDamping       = fnn(params.physics.linearDamping, preset.physics.linearDamping, 1),
		xDamping            = fnn(params.physics.xDamping, fnn(params.physics.linearDamping, preset.physics.linearDamping, 1), preset.physics.xDamping, preset.physics.linearDamping),
		yDamping            = fnn(params.physics.yDamping, fnn(params.physics.linearDamping, preset.physics.linearDamping, 1), preset.physics.yDamping, preset.physics.linearDamping),
		velocity            = fnn(params.physics.velocity, preset.physics.velocity, 2),
		angularVelocity     = fnn(params.physics.angularVelocity, preset.physics.angularVelocity, 0),
		angularDamping      = fnn(params.physics.angularDamping, preset.physics.angularDamping, 1),
		scaleRateX          = fnn(params.physics.scaleRateX, preset.physics.scaleRateX, 1),
		scaleRateY          = fnn(params.physics.scaleRateY, preset.physics.scaleRateY, 1),
		maxScaleX           = fnn(params.physics.maxScaleX, preset.physics.maxScaleX, 3),
		maxScaleY           = fnn(params.physics.maxScaleY, preset.physics.maxScaleY, 3),
		minScaleX           = fnn(params.physics.minScaleX, preset.physics.minScaleX, 0.01),
		minScaleY           = fnn(params.physics.minScaleY, preset.physics.minScaleY, 0.01),
		velFunction         = fnn(params.physics.velFunction, preset.physics.velFunction, function() end),
		useVelFunction      = fnn(params.physics.useVelFunction, preset.physics.useVelFunction, false),
		divisionDamping     = fnn(params.physics.divisionDamping, preset.physics.divisionDamping, true),
		autoCalculateAngles = fnn(params.physics.autoCalculateAngles, preset.physics.autoCalculateAngles, true),
		angles              = fnn(params.physics.angles, preset.physics.angles, {{1, 360}}),
		preCalculateAngles  = fnn(params.physics.preCalculateAngles, preset.physics.preCalculateAngles, true),
		cycleAngle          = fnn(params.physics.cycleAngle, preset.physics.cycleAngle, false),
		curAngle            = fnn(params.physics.curAngle, preset.physics.curAngle, 1),
		angleIncr           = fnn(params.physics.angleIncr, preset.physics.angleIncr, 1),
		gravityX            = fnn(params.physics.gravityX, preset.physics.gravityX, 0),
		gravityY            = fnn(params.physics.gravityY, preset.physics.gravityY, 0),

		----------------------------------------------------------------------------
		-- Placeholders (to prevent rehashing)
		----------------------------------------------------------------------------
		emit = function() end,
		resetAngles = function() end,
		resetPoints = function() end,
	}

	vent.content.x   = fnn(params.contentX, preset.contentX, 0)
	vent.content.y   = fnn(params.contentY, preset.contentY, 0)

	if not vent.hasColor then vent.color = {{1, 1, 1}} end
	if type(vent.color[1]) == "number" then vent.color = {vent.color} end
	if vent.autoCalculateAngles and type(vent.angles[1]) == "number" then vent.angles = {vent.angles} end

	return vent
end

return lib_ventframe