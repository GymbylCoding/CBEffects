--------------------------------------------------------------------------------
--[[
MoveToTap

A vent that transitions to a tap event's location.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.newVent {
	preset = "burn"
}

local function onScreenTap(event)
	if vent.trans then transition.cancel(vent.trans) end
	vent.trans = transition.to(vent, {x = event.x, y = event.y, time = 500})
end

vent:start()
Runtime:addEventListener("tap", onScreenTap)