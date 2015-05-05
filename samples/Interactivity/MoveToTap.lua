--------------------------------------------------------------------------------
--[[
MoveToTap

A vent that transitions to a tap event's location.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local vent = CBE.newVent({
	preset = "burn"
})

local function onScreenTap(event)
	if vent.trans then transition.cancel(vent.trans) end
	vent.trans = transition.to(vent, {emitX = event.x, emitY = event.y, time = 500})
end

vent:start()
Runtime:addEventListener("tap", onScreenTap)