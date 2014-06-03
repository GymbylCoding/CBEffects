--------------------------------------------------------------------------------
--[[
CBEffects Component: Iterate

Update particles each frame.
--]]
--------------------------------------------------------------------------------

local lib_iterator = {}

--------------------------------------------------------------------------------
-- Localize and Include Libraries
--------------------------------------------------------------------------------
local screen = require("CBEffects.cbe_core.misc.screen")
local lib_functions = require("CBEffects.cbe_core.misc.functions")
local lib_runtime = require("CBEffects.cbe_core.misc.runtime")
local lib_vst = require("CBEffects.cbe_core.misc.vs-t")
local lib_uniquecode = require("CBEffects.cbe_core.misc.uniquecode")

local system_getTimer = system.getTimer
local math_huge = math.huge
local math_nhuge = -math.huge
local table_insert = table.insert
local clamp = lib_functions.clamp
local angleBetween = lib_functions.angleBetween

--------------------------------------------------------------------------------
-- New Iteration Stage
--------------------------------------------------------------------------------
function lib_iterator.newStage(masterVent)
	local stage = {}
	stage.id = lib_uniquecode.new("iter")
	local vstTitle = "f" .. stage.id
	local fields = lib_vst.new(vstTitle)
	stage.productUpdate = {
		angular = true,
		size = true
	}

	stage.xGravity, stage.yGravity, stage.scaleX, stage.scaleY = 0, 0, 1, 1

	------------------------------------------------------------------------------
	-- Link/Unlink a Field
	------------------------------------------------------------------------------
	function stage.linkField(self, f)
		local f = f or self
		fields.add(f)
	end

	function stage.unlinkField(self, f)
		local f = f or self
		fields.markForRemoval(f._cbe_reserved[vstTitle])
		fields.removeMarked()
	end

	function stage.unlinkAllFields()
		for field in fields.items() do
			fields.markForRemoval(field._cbe_reserved[vstTitle])
		end
		fields.removeMarked()
	end

	------------------------------------------------------------------------------
	-- Update a Particle
	------------------------------------------------------------------------------
	function stage.updateParticle(this)
		local delta = lib_runtime.delta
		local vals = this._cbe_reserved

		if (not this) or (vals.killed) then return false end
		this._numUpdates = this._numUpdates + 1

		----------------------------------------------------------------------------
		-- Color
		----------------------------------------------------------------------------
		if (vals.r ~= vals.prevR) or
			 (vals.g ~= vals.prevG) or
			 (vals.b ~= vals.prevB) or
			 (vals.a ~= vals.prevA) then

			vals.setFillColor(this, vals.r, vals.g, vals.b, vals.a)
			vals.prevR = vals.r
			vals.prevG = vals.g
			vals.prevB = vals.b
			vals.prevA = vals.a
		end

		----------------------------------------------------------------------------
		-- Velocity
		----------------------------------------------------------------------------
		vals.xVel = (vals.xVel + stage.xGravity) * vals.xDamping
		vals.yVel = (vals.yVel + stage.yGravity) * vals.yDamping

		----------------------------------------------------------------------------
		-- Rotation
		----------------------------------------------------------------------------
		if not vals.rotateTowardVel then
			if not stage.productUpdate.angular then
				if vals.angularVel > 0 then
					vals.angularVel = clamp(vals.angularVel - vals.angularDamping, 0, math_huge)
				elseif vals.angularVel < 0 then
					vals.angularVel = clamp(vals.angularVel + vals.angularDamping, math_nhuge, 0)
				end
			else
				if vals.angularDamping ~= vals.prevAngularDamping then vals.angularDamping = 1 / vals.angularDamping vals.prevAngularDamping = vals.angularDamping end
				vals.angularVel = vals.angularVel * vals.angularDamping
			end

			this:rotate(vals.angularVel)
		else
			local ang = angleBetween(vals.prevX, vals.prevY, this.x, this.y, vals.towardVelOffset)
			if ang ~= math_huge and ang ~= math_nhuge then this.rotation = ang end
		end

		----------------------------------------------------------------------------
		-- Scale
		----------------------------------------------------------------------------
		if not stage.productUpdate.size then
			if vals.scaleRateX ~= 0 then
				this.xScale = clamp(this.xScale + vals.scaleRateX, vals.minScaleX, vals.maxScaleX)
			end
			if vals.scaleRateY ~= 0 then
				this.yScale = clamp(this.yScale + vals.scaleRateY, vals.minScaleY, vals.maxScaleY)
			end
		else
			if vals.scaleRateX ~= 1 then
				this.xScale = clamp(this.xScale * vals.scaleRateX, vals.minScaleX, vals.maxScaleX)
			end
			if vals.scaleRateY ~= 1 then
				this.yScale = clamp(this.yScale * vals.scaleRateY, vals.minScaleY, vals.maxScaleY)
			end
		end

		vals.prevX, vals.prevY = this.x, this.y
		this:translate(vals.xVel * delta * stage.scaleX * masterVent.scaleX, vals.yVel * delta * stage.scaleY * masterVent.scaleY)
		masterVent.onUpdate(this, masterVent, masterVent.content)

		----------------------------------------------------------------------------
		-- Field Collisions
		----------------------------------------------------------------------------
		for field in fields.items() do
			if field._cbe_reserved.enabled then
				field._cbe_reserved.execute(this)
			end
		end

	end

	return stage
end

return lib_iterator