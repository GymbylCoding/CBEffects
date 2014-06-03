--------------------------------------------------------------------------------
--[[
BasicRadius

Basic use of "radius" parameter for inRadius position type vents.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.newVent {
	radius = display.contentCenterY * 0.5
}

vent:start()