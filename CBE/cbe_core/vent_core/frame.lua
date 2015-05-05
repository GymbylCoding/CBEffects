--------------------------------------------------------------------------------
--[[
CBE Component: Vent Frame

Builds the framework for a CBVent object.
--]]
--------------------------------------------------------------------------------

local lib_ventframe = {}

--------------------------------------------------------------------------------
-- Include Libraries and Localize
--------------------------------------------------------------------------------
local screen = require("CBE.cbe_core.misc.screen")
local lib_functions = require("CBE.cbe_core.misc.functions")

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

	local vent = display_newGroup()

	vent.calculatedAngles = {}
	vent.calculatedLinePoints = {}
	vent._cbe_reserved = {
		isVent = true
	}

	------------------------------------------------------------------------------
	---- Basic Parameters
	------------------------------------------------------------------------------
	vent.emitX               = fnn(params.emitX, preset.emitY, screen.centerX)
	vent.emitY               = fnn(params.emitY, preset.emitY, screen.centerY)
	vent.build               = fnn(params.build, preset.build, function() return display.newRect(0, 0, 20, 20) end)
	vent.particleProperties  = fnn(params.particleProperties, params.propertyTable, preset.particleProperties, {})
	vent.scale               = fnn(params.scale, preset.scale, 1)
	vent.scaleX              = fnn(params.scaleX, params.scale or preset.scaleX, preset.scaleX, 1)
	vent.scaleY              = fnn(params.scaleY, params.scale or preset.scaleY, preset.scaleY, 1)
	vent.isActive            = fnn(params.isActive, preset.isActive, true)
	vent.title               = fnn(params.title, preset.title, "vent")
	vent.content             = vent
	vent.rotateTowardVel     = fnn(params.rotateTowardVel, preset.rotateTowardVel, false)
	vent.towardVelOffset     = fnn(params.towardVelOffset, preset.towardVelOffset, 0)

	------------------------------------------------------------------------------
	-- Color Parameters
	------------------------------------------------------------------------------
	vent.color               = fnn(params.color, preset.color, {{1, 1, 1}})
	vent.cycleColor          = fnn(params.cycleColor, preset.cycleColor, false)
	vent.curColor            = fnn(params.curColor, preset.curColor, 1)
	vent.colorIncr           = fnn(params.colorIncr, preset.colorIncr, 1)
	vent.hasColor            = fnn(params.hasColor, preset.hasColor, true)

	------------------------------------------------------------------------------
	-- Emit Parameters
	------------------------------------------------------------------------------
	vent.emitDelay           = fnn(params.emitDelay, preset.emitDelay, 5)
	vent.perEmit             = fnn(params.perEmit, preset.perEmit, 2)
	vent.emissionNum         = fnn(params.emissionNum, preset.emissionNum, 0)
	vent.roundNum            = 0

	----------------------------------------------------------------------------
	-- Particle Life Parameters
	----------------------------------------------------------------------------
	vent.startAlpha          = fnn(params.startAlpha, preset.startAlpha, 1)
	vent.lifeAlpha           = fnn(params.lifeAlpha, params.alpha, preset.lifeAlpha, 1)
	vent.endAlpha            = fnn(params.endAlpha, preset.endAlpha, 0)
	vent.inTime              = fnn(params.inTime, params.fadeInTime, preset.inTime, 0)
	vent.lifeTime            = fnn(params.lifeTime, params.lifeStart, preset.lifeTime, 0)
	vent.outTime             = fnn(params.outTime, params.lifeSpan, preset.outTime, 1000)

	----------------------------------------------------------------------------
	-- Callback Function Parameters
	----------------------------------------------------------------------------
	vent.onCreation          = fnn(params.onCreation, preset.onCreation, function() end)
	vent.onCreationTime      = fnn(params.onCreationTime, preset.onCreationTime, "")
	vent.onDeath             = fnn(params.onDeath, preset.onDeath, function() end)
	vent.onUpdate            = fnn(params.onUpdate, preset.onUpdate, function() end)
	vent.onVentInit          = fnn(params.onVentInit, preset.onVentInit, function() end)
	vent.onEmitBegin         = fnn(params.onEmitBegin, preset.onEmitBegin, function() end)
	vent.onEmitEnd           = fnn(params.onEmitEnd, preset.onEmitEnd, function() end)
	
	----------------------------------------------------------------------------
	-- Position Parameters
	----------------------------------------------------------------------------
	vent.positionType        = fnn(params.positionType, preset.positionType, "inRadius")
	vent.pointList           = fnn(params.pointList, preset.pointList, {{0, 0}})
	vent.cyclePoint          = fnn(params.cyclePoint, params.iteratePoint, preset.cyclePoint, false)
	vent.curPoint            = fnn(params.curPoint, preset.curPoint, 1)
	vent.pointIncr           = fnn(params.pointIncr, preset.pointIncr, 1)
	vent.point1              = fnn(params.point1, preset.point1, {0,0})
	vent.point2              = fnn(params.point2, preset.point2, {1,0})
	vent.lineDensity         = fnn(params.lineDensity, preset.lineDensity, "total")
	vent.radius              = fnn(params.radius, params.posRadius, preset.radius, 30)
	vent.xRadius             = fnn(params.xRadius, params.radius or params.posRadius or preset.radius, preset.xRadius, 30)
	vent.yRadius             = fnn(params.yRadius, params.radius or params.posRadius or preset.radius, preset.radius, 30)
	vent.innerRadius         = fnn(params.innerRadius, params.posInner, preset.innerRadius, 1)
	vent.innerXRadius        = fnn(params.innerXRadius, params.innerRadius or params.posInner or preset.innerRadius, preset.innerXRadius, 1)
	vent.innerYRadius        = fnn(params.innerYRadius, params.innerRadius or params.posInner or preset.innerRadius, preset.innerYRadius, 1)
	vent.rectLeft            = fnn(params.rectLeft, preset.rectLeft, 0)
	vent.rectTop             = fnn(params.rectTop, preset.rectTop, 0)
	vent.rectWidth           = fnn(params.rectWidth, preset.rectWidth, screen.centerX)
	vent.rectHeight          = fnn(params.rectHeight, preset.rectHeight, screen.centerY)
	
	----------------------------------------------------------------------------
	-- Physics Parameters
	----------------------------------------------------------------------------
	vent.linearDamping       = fnn(params.physics.linearDamping, preset.physics.linearDamping, 1)
	vent.xDamping            = fnn(params.physics.xDamping, fnn(params.physics.linearDamping, preset.physics.linearDamping, 1), preset.physics.xDamping, preset.physics.linearDamping)
	vent.yDamping            = fnn(params.physics.yDamping, fnn(params.physics.linearDamping, preset.physics.linearDamping, 1), preset.physics.yDamping, preset.physics.linearDamping)
	vent.velocity            = fnn(params.physics.velocity, preset.physics.velocity, 2)
	vent.angularVelocity     = fnn(params.physics.angularVelocity, preset.physics.angularVelocity, 0)
	vent.angularDamping      = fnn(params.physics.angularDamping, preset.physics.angularDamping, 1)
	vent.scaleRateX          = fnn(params.physics.scaleRateX, params.physics.sizeX, preset.physics.scaleRateX, 1)
	vent.scaleRateY          = fnn(params.physics.scaleRateY, params.physics.sizeY, preset.physics.scaleRateY, 1)
	vent.maxScaleX           = fnn(params.physics.maxScaleX, params.physics.maxX, preset.physics.maxScaleX, 3)
	vent.maxScaleY           = fnn(params.physics.maxScaleY, params.physics.maxY, preset.physics.maxScaleY, 3)
	vent.minScaleX           = fnn(params.physics.minScaleX, params.physics.minX, preset.physics.minScaleX, 0.01)
	vent.minScaleY           = fnn(params.physics.minScaleY, params.physics.minY, preset.physics.minScaleY, 0.01)
	vent.velFunction         = fnn(params.physics.velFunction, preset.physics.velFunction, function() end)
	vent.useVelFunction      = fnn(params.physics.useVelFunction, params.physics.useFunction, preset.physics.useVelFunction, false)
	vent.divisionDamping     = fnn(params.physics.divisionDamping, preset.physics.divisionDamping, true)
	vent.autoCalculateAngles = fnn(params.physics.autoCalculateAngles, params.physics.autoAngle, preset.physics.autoCalculateAngles, true)
	vent.angles              = fnn(params.physics.angles, preset.physics.angles, {{1, 360}})
	vent.preCalculateAngles  = fnn(params.physics.preCalculateAngles, params.physics.preCalculate, preset.physics.preCalculateAngles, true)
	vent.cycleAngle          = fnn(params.physics.cycleAngle, params.physics.iterateAngle, preset.physics.cycleAngle, false)
	vent.curAngle            = fnn(params.physics.curAngle, preset.physics.curAngle, 1)
	vent.angleIncr           = fnn(params.physics.angleIncr, preset.physics.angleIncr, 1)
	vent.gravityX            = fnn(params.physics.gravityX, preset.physics.gravityX, 0)
	vent.gravityY            = fnn(params.physics.gravityY, preset.physics.gravityY, 0)

	if params.parentGroup then params.parentGroup:insert(vent) end

	if not vent.hasColor then vent.color = {{1, 1, 1}} end
	if type(vent.color[1]) == "number" then vent.color = {vent.color} end
	if vent.autoCalculateAngles and type(vent.angles[1]) == "number" then vent.angles = {vent.angles} end

	return vent
end

return lib_ventframe