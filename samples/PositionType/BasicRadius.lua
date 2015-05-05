--------------------------------------------------------------------------------
--[[
BasicRadius

Basic use of "radius" parameter for inRadius position type vents.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local vent = CBE.newVent({
	radius = display.contentCenterY * 0.5
})

vent:start()