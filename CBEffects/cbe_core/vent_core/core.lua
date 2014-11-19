--------------------------------------------------------------------------------
--[[
CBEffects Component: Vent Core

Core engine for vents.
--]]
--------------------------------------------------------------------------------

local vent_core = {}

--------------------------------------------------------------------------------
-- Include Libraries and Localize
--------------------------------------------------------------------------------
local require = require

local screen = require("CBEffects.cbe_core.misc.screen")
local lib_runtime = require("CBEffects.cbe_core.misc.runtime")
local lib_frame = require("CBEffects.cbe_core.vent_core.frame")
local lib_presets = require("CBEffects.cbe_core.misc.presets")
local lib_uniquecode = require("CBEffects.cbe_core.misc.uniquecode")
local lib_functions = require("CBEffects.cbe_core.misc.functions")
local lib_iterate = require("CBEffects.cbe_core.vent_core.iterate")
local lib_vst = require("CBEffects.cbe_core.misc.vs-t")

local type = type
local pairs = pairs
local system_getTimer = system.getTimer
local transition_to = transition.to
local transition_cancel = transition.cancel
local timer_performWithDelay = timer.performWithDelay
local timer_cancel = timer.cancel
local display_remove = display.remove
local table_insert = table.insert
local math_random = math.random
local getValue = lib_functions.getValue
local forcesByAngle = lib_functions.forcesByAngle
local either = lib_functions.either
local getPointInRadius = lib_functions.getPointInRadius
local getPointsAlongLine = lib_functions.getPointsAlongLine

local removeParticlesNum = 6 -- How many updates should take place before we clear deleted particles from memory

--------------------------------------------------------------------------------
-- New Vent
--------------------------------------------------------------------------------
function vent_core.new(params)
	local params = params or {}
	local presetName = (params.preset or "default"):lower()
	local preset = lib_presets.vents[presetName] or lib_presets.vents["default"]

	------------------------------------------------------------------------------
	-- Create Objects
	------------------------------------------------------------------------------
	local vent = lib_frame.newFrame(params, preset)
	local particles = lib_vst.new("particleIndex")
	local iterStage = lib_iterate.newStage(vent)
	vent.id = iterStage.id
	local alternator = 0

	if vent.parentGroup then vent.parentGroup:insert(vent.content) end

	------------------------------------------------------------------------------
	-- Emit Particles
	------------------------------------------------------------------------------
	function vent.emit()
		vent.onEmitBegin(vent)
		local thisTime = system_getTimer()
		local colorType = type(vent.color) -- For applying the color; could be either function or table

		for i = 1, vent.perEmit do
			vent.roundNum = i

			local onCreationExecuted = false
			local p = vent.build(vent, i)
			p.alpha = vent.startAlpha --getValue(vent.startAlpha, vent, p)

			p._numUpdates = 0
			p._lifePhase = "in"

			p._cbe_reserved = {
				xDamping = vent.xDamping, --getValue(vent.xDamping, vent, p),
				yDamping = vent.yDamping, --getValue(vent.yDamping, vent, p),
				angularDamping = 1 / vent.angularDamping, --getValue(vent.angularDamping, vent, p),
				prevAngularDamping = vent.angularDamping,
				angularVel = vent.angularVelocity, --getValue(vent.angularVelocity, vent, p),
				maxScaleX = vent.maxScaleX, --getValue(vent.maxScaleX, vent, p),
				maxScaleY = vent.maxScaleY, --getValue(vent.maxScaleX, vent, p),
				minScaleX = vent.minScaleX, --getValue(vent.minScaleX, vent, p),
				minScaleY = vent.minScaleY, --getValue(vent.minScaleY, vent, p),
				scaleRateX = vent.scaleRateX, --getValue(vent.scaleRateX, vent, p),
				scaleRateY = vent.scaleRateY, --getValue(vent.scaleRateX, vent, p),
				rotateTowardVel = vent.rotateTowardVel, --getValue(vent.rotateTowardVel, vent, p),
				towardVelOffset = vent.towardVelOffset, --getValue(vent.towardVelOffset, vent, p),
				xVel = 0,
				yVel = 0,
				collided = false,
				r = 0,
				g = 0,
				b = 0,
				a = 0,
				prevR = 0,
				prevG = 0,
				prevB = 0,
				prevA = 0,
				prevX = 0,
				prevY = 0,
				setFillColor = p.setFillColor,
				killed = false
			}

			p.lifeAlpha = vent.lifeAlpha --getValue(vent.lifeAlpha, vent, p)
			p.endAlpha = vent.endAlpha --getValue(vent.endAlpha, vent, p)

			p:scale(vent.scaleX, vent.scaleY)

			for k, v in pairs(vent.particleProperties) do p[k] = v end

			--------------------------------------------------------------------------
			-- Particle Functions
			--------------------------------------------------------------------------
			-- These functions are collapsed because they aren't very complicated, and thus don't need to be fully expanded
			-- Set the linear velocity
			function p:setVelocity(x, y) p._cbe_reserved.xVel = x or p._cbe_reserved.xVel p._cbe_reserved.yVel = y or p._cbe_reserved.yVel end
			-- Get velocity
			function p:getVelocity() return p._cbe_reserved.xVel, p._cbe_reserved.yVel end
			-- Apply force
			function p:applyParticleForce(x, y) p._cbe_reserved.xVel = p._cbe_reserved.xVel + x p._cbe_reserved.yVel = p._cbe_reserved.yVel + y end
			p.applyForce = p.applyParticleForce
			-- Set the angular velocity (rotation speed)
			function p:setAngularVelocity(r) p._cbe_reserved.angularVel = r or p._cbe_reserved.angularVel end
			-- Set the fill color and, at the same time, sets the particle's inner color values
			function p:setFillColor(red, green, blue, alpha)
				local r = red
				local g = green or r
				local b = blue or r
				local a = alpha or 1
				p._cbe_reserved.r, p._cbe_reserved.b, p._cbe_reserved.g, p._cbe_reserved.a = r, g, b, a
				return p._cbe_reserved.setFillColor(p, r, g, b, a)
			end
			-- Set a property
			function p:setCBEProperty(pKey, pValue) p._cbe_reserved[pKey] = pValue end
			-- Get a property
			function p:getCBEProperty(pKey) return p._cbe_reserved[pKey] end

			if vent.onCreationTime == "afterBuild" then vent.onCreation(p, vent, vent.content) onCreationExecuted = true end

			--------------------------------------------------------------------------
			-- Kill Particle
			--------------------------------------------------------------------------
			function p._kill()
				if p._cbe_reserved.transition then transition_cancel(p._cbe_reserved.transition) end
				vent.onDeath(p, vent)
				display_remove(p)
				particles.markForRemoval(p._cbe_reserved.particleIndex)
				p._cbe_reserved.killed = true
				p = nil
			end

			--------------------------------------------------------------------------
			-- Set Velocity
			--------------------------------------------------------------------------
			if vent.useVelFunction then
				local xVel, yVel = vent.velFunction(p, vent, vent.content)
				p._cbe_reserved.xVel, p._cbe_reserved.yVel = xVel, yVel
			else
				local velocity

				if vent.cycleAngle then
					if vent.preCalculateAngles then
						velocity = vent.calculatedAngles[vent.curAngle]
					else
						local angle = vent.calculatedAngles[vent.curAngle]
						velocity = forcesByAngle(vent.velocity, angle)
					end
					vent.curAngle = (((vent.curAngle + vent.angleIncr) - 1) % (#vent.calculatedAngles)) + 1
				else
					if vent.preCalculateAngles then
						velocity = either(vent.calculatedAngles)
					else
						local angle = either(vent.calculatedAngles)
						velocity = forcesByAngle(vent.velocity, angle)
					end
				end

				p._cbe_reserved.xVel, p._cbe_reserved.yVel = velocity.x, velocity.y
			end

			if not onCreationExecuted and vent.onCreationTime == "afterVel" then vent.onCreation(p, vent, vent.content) onCreationExecuted = true end

			--------------------------------------------------------------------------
			-- Set Color
			--------------------------------------------------------------------------
			local color

			if colorType == "table" then
				if vent.cycleColor then
					color = vent.color[vent.curColor]
					vent.curColor = (((vent.curColor + vent.colorIncr) - 1) % (#vent.color)) + 1
				else
					color = either(vent.color)
				end
			elseif colorType == "function" then
				color = {vent.color()}
			end

			local redValue = color[1] or 0
			p._cbe_reserved.r, p._cbe_reserved.g, p._cbe_reserved.b, p._cbe_reserved.a = redValue, color[2] or redValue, color[3] or redValue, color[4] or 1
			p._cbe_reserved.setFillColor(p, p._cbe_reserved.r, p._cbe_reserved.g, p._cbe_reserved.b, p._cbe_reserved.a)

			-- Change color
			function p:changeColor(colorTo, time, delay, effect)
				local params
				if colorTo and colorTo.color then
					if time then print("Warning: Possible deprecated call to particle.changeColor() with dot.") colorTo = time end
					params = colorTo
					params.r = colorTo.color[1] or colorTo.color.r
					params.g = colorTo.color[2] or colorTo.color.g
					params.b = colorTo.color[3] or colorTo.color.b
					params.a = colorTo.color[4] or colorTo.color.a
					params.color = nil
				else
					params = {
						r = colorTo[1] or colorTo.r,
						g = colorTo[2] or colorTo.g,
						b = colorTo[3] or colorTo.b,
						a = colorTo[4] or colorTo.a,
						time = time,
						delay = delay,
						transition = effect
					}
				end

				if p._cbe_reserved.colorTransition then transition_cancel(p._cbe_reserved.colorTransition) end
				p._cbe_reserved.colorTransition = transition_to(p._cbe_reserved, params)
			end

			if not onCreationExecuted and vent.onCreationTime == "afterColor" then vent.onCreation(p, vent, vent.content) onCreationExecuted = true end

			--------------------------------------------------------------------------
			-- Set Position
			--------------------------------------------------------------------------
			if vent.positionType == "inRadius" then
				p.x, p.y = getPointInRadius(vent.x, vent.y, vent.xRadius * vent.scaleX, vent.yRadius * vent.scaleY, vent.innerXRadius * vent.scaleX, vent.innerYRadius * vent.scaleY)
			elseif vent.positionType == "alongLine" then
				local point = either(vent.calculatedLinePoints)
				p.x, p.y = (point[1] + vent.x) * vent.scaleX, (point[2] + vent.y) * vent.scaleY
			elseif vent.positionType == "inRect" then
				p.x, p.y = math_random(vent.rectLeft, vent.rectLeft + vent.rectWidth) * vent.scaleX + vent.x, math_random(vent.rectTop, vent.rectTop + vent.rectHeight) * vent.scaleY + vent.y
			elseif vent.positionType == "atPoint" then
				p.x, p.y = vent.x, vent.y
			elseif vent.positionType == "fromPointList" then
				local point
				if vent.cyclePoint then
					point = vent.pointList[vent.curPoint]
					vent.curPoint = (((vent.curPoint + vent.pointIncr) - 1) % (#vent.pointList)) + 1
				else
					point = either(vent.pointList)
				end
				p.x, p.y = (point[1] or point.x) + vent.x, (point[2] or point.y) + vent.y
			elseif type(vent.positionType) == "function" then
				p.x, p.y = vent.positionType(p, vent, vent.content)
			end

			p._cbe_reserved.prevX, p._cbe_reserved.prevY = p.x, p.y

			if not onCreationExecuted and vent.onCreationTime == "afterPosition" then vent.onCreation(p, vent, vent.content) onCreationExecuted = true end

			--------------------------------------------------------------------------
			-- Set Up Particle Transition
			--------------------------------------------------------------------------
			p._cbe_reserved.transition = transition_to(p, {
				alpha = p.lifeAlpha,
				time = vent.inTime, --getValue(vent.inTime, vent, p),
				transition = vent.inTransition,
				tag = iterStage.id,
				onComplete = function()
					p._lifePhase = "life"
					p._cbe_reserved.transition = transition_to(p, {
						alpha = p.endAlpha,
						delay = vent.lifeTime, --getValue(vent.lifeTime, vent, p)
						time = vent.outTime, --getValue(vent.outTime, vent, p),
						transition = vent.outTransition,
						tag = iterStage.id,
						onStart = function() p._lifePhase = "out" end,
						onComplete = function() p._cbe_reserved.transition = nil p._kill() end
					})
				end
			})

			if not onCreationExecuted then vent.onCreation(p, vent, vent.content) end
			particles.add(p)
			vent.content:insert(p)
		end

		vent.onEmitEnd(vent)
		vent.roundNum = -1
	end

	------------------------------------------------------------------------------
	-- Vent Methods
	------------------------------------------------------------------------------
	function vent.resetAngles() if vent.autoCalculateAngles then for w = 1, #vent.angles do local angle1, angle2 = vent.angles[w][1], vent.angles[w][2] local incr = 1 if angle1 > angle2 then incr = -1 end for a = angle1, angle2, incr do if vent.preCalculateAngles then table_insert(vent.calculatedAngles, forcesByAngle(vent.velocity, a)) else table_insert(vent.calculatedAngles, a) end end end else if vent.preCalculateAngles then for a = 1, #vent.angles do table_insert(vent.calculatedAngles, forcesByAngle(vent.velocity, vent.angles[a])) end else for a = 1, #vent.angles do table_insert(vent.calculatedAngles, vent.angles[a]) end end end end
	function vent.resetPoints() vent.calculatedLinePoints = getPointsAlongLine(vent.point1[1] or vent.point1.x, vent.point1[2] or vent.point1.y, vent.point2[1] or vent.point2.x, vent.point2[2] or vent.point2.y, vent.lineDensity) end
	function vent.setGravity(x, y) iterStage.xGravity, iterStage.yGravity = x, y end
	function vent.set(t) for k, v in pairs(t) do if k ~= "_cbe_reserved" then vent[k] = v end end end
	function vent.start() if vent._cbe_reserved.emitTimer then timer_cancel(vent._cbe_reserved.emitTimer) end vent._cbe_reserved.emitTimer = timer_performWithDelay(vent.emitDelay, vent.emit, vent.emissionNum) end
	function vent.stop() if vent._cbe_reserved.emitTimer then timer_cancel(vent._cbe_reserved.emitTimer) vent._cbe_reserved.emitTimer = nil end end
	function vent.setProductUpdate(k, v) if iterStage.productUpdate[k] ~= nil then iterStage.productUpdate[k] = v end end
	function vent.setMovementScale(x, y) iterStage.xScale = x iterStage.yScale = y or x end
	function vent.setScale(x, y) vent.scaleX = x vent.scaleY = y or x end
	function vent.clean() transition_cancel(iterStage.id) for p, i in particles.items() do if p then particles.markForRemoval(p._cbe_reserved.particleIndex) p._cbe_reserved.killed = true p._kill() p = nil end end particles.removeMarked() end

	vent.particles = particles.items
	vent.countParticles = particles.count
	vent.linkField = iterStage.linkField
	vent.unlinkField = iterStage.unlinkField
	vent.unlinkAllFields = iterStage.unlinkAllFields

	function vent._cbe_reserved.updateParticles()
		alternator = (alternator + 1) % removeParticlesNum
		if alternator == 0 then
			particles.removeMarked()
		end
		for p in particles.items() do
			iterStage.updateParticle(p)
		end
	end

	------------------------------------------------------------------------------
	-- Destroy Vent
	------------------------------------------------------------------------------
	-- This version will only be called by the vent's parent VentGroup
	function vent._cbe_reserved.destroy()
		particles.removeMarked() -- Make sure there isn't any "garbage" in the particle structure
		vent.stop()
		vent.clean()
		iterStage.unlinkAllFields()
		lib_uniquecode.delete("iter", iterStage.id)
		iterStage = nil

		display_remove(vent.content)
		vent.content = nil
		lib_runtime.removeVent(vent)
	end

	-- This version will only get called by a user
	function vent.destroy()
		-- If we're part of a VentGroup, make sure the VentGroup knows we're being destroyed
		if vent._cbe_reserved.masterVentGroup then vent._cbe_reserved.masterVentGroup._cbe_reserved.registerDestroy(vent, iterStage) end
		vent._cbe_reserved.destroy()

		vent = nil
	end

	------------------------------------------------------------------------------
	-- Finish Up
	------------------------------------------------------------------------------
	vent.resetAngles()
	vent.resetPoints()
	vent.setGravity(vent.gravityX, vent.gravityY)
	lib_runtime.addVent(vent)

	vent.onVentInit(vent)

	return vent
end

return vent_core