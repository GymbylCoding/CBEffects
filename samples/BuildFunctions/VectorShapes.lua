--------------------------------------------------------------------------------
--[[
VectorShapes

Random vector particles; slightly more complicated build function.


The Academic Section
--------------------

This sample demonstrates random particle generation. All we do is create a
random number in the build function, then create the particle based on the
number. If the number is 1, we create a square, if the number is 2, we create a
circle, and if it's 3, we make a polygon.

--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

-- Localize our commonly used functions
local math_random = math.random
local display_newRect = display.newRect
local display_newCircle = display.newCircle
local display_newPolygon = display.newPolygon

local shapes = CBE.newVent({
	title = "HelloWorld",
	radius = display.contentCenterY,

	build = function()
		local buildType = math_random(1, 3)
		local size = math_random(10, 50)

		if buildType == 1 then
			return display_newRect(0, 0, size, size)
		elseif buildType == 2 then
			return display_newCircle(0, 0, size)
		elseif buildType == 3 then
			return display_newPolygon(0, 0, {0,0, size,0, size,size, -size,size * 2})
		end
	end
})

shapes:start()