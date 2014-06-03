--------------------------------------------------------------------------------
--[[
CBEffects Component: Runtime

CBEffects runtime system.
--]]
--------------------------------------------------------------------------------

local lib_runtime = {}

--------------------------------------------------------------------------------
-- Localize and Include Libraries
--------------------------------------------------------------------------------
local lib_vst = require("CBEffects.cbe_core.misc.vs-t")

local system_getTimer = system.getTimer

local timeFrac = 1000 / 60
local runtime = 0
local delta = 1
local time = system_getTimer()

local updateDelta = function() local temp = system_getTimer() delta = ((temp - time) / timeFrac) time = temp end

--------------------------------------------------------------------------------
-- Internals
--------------------------------------------------------------------------------
local vents = lib_vst.new("runtimeIndex")
local fields = lib_vst.new("runtimeIndex")

--------------------------------------------------------------------------------
-- Add Objects to Runtime
--------------------------------------------------------------------------------
function lib_runtime.addVent(v) vents.add(v) end
function lib_runtime.removeVent(v) vents.markForRemoval(v._cbe_reserved.runtimeIndex) end
function lib_runtime.addField(f) fields.add(f) end
function lib_runtime.removeField(f) fields.markForRemoval(f._cbe_reserved.runtimeIndex) end

--------------------------------------------------------------------------------
-- Update Runtime System
--------------------------------------------------------------------------------
function lib_runtime.update()
	updateDelta()
	lib_runtime.delta = delta

	vents.removeMarked()
	fields.removeMarked()

	for v in vents.items() do
		v._cbe_reserved.updateParticles()
	end
end


Runtime:addEventListener("enterFrame", lib_runtime.update)

return lib_runtime