--------------------------------------------------------------------------------
--[[
Hose

Demonstrates use of cycleAngle to wave back and forth.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local display_newImageRect = display.newImageRect

local vent = CBE.newVent({
	preset = "fountain",
	perEmit = 1,
	physics = {
		autoCalculateAngles = true,
		angles = {{60, 120}, {120, 60}}, -- Add angles in form of 60-120-60
		cycleAngle = true
	}
})

vent:start()