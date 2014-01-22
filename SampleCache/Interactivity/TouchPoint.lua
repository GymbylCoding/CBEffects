--------------------------------------------------------------------------------
--[[
TouchPoint

A vent that tracks to the touch point.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.newVent {
	preset = "burn"
}

local function onScreenTouch(event)
	vent.x, vent.y = event.x, event.y -- We want the vent to move no matter what the phase of the event

	if "began" == event.phase then
		vent:start() -- Start if began
	elseif "ended" == event.phase then
		vent:stop() -- Stop if ended
	end
end

Runtime:addEventListener("touch", onScreenTouch)