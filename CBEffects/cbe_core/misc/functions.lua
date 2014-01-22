--------------------------------------------------------------------------------
--[[
CBEffects Component: Functions

Various helper functions for the rest of CBEffects to use.
--]]
--------------------------------------------------------------------------------

local functions = {}

--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local table_insert = table.insert
local math_rad = math.rad
local math_sin = math.sin
local math_cos = math.cos
local math_deg = math.deg
local math_atan2 = math.atan2
local math_random = math.random
local math_abs = math.abs
local type = type

--------------------------------------------------------------------------------
-- Define Functions
--------------------------------------------------------------------------------
-- First not nil
local fnn = function(...) for i = 1, #arg do if arg[i] ~= nil then return arg[i] end end end
-- Forces by angle
local forcesByAngle = function(totalForce, angle) local forces = {} local radians = -math_rad(angle) forces.x = math_cos(radians) * totalForce forces.y = math_sin(radians) * totalForce return forces end
-- Length of
local lengthOf = function(x1, y1, x2, y2) return (((x2 - x1) ^ 2) + ((y2 - y1) ^ 2)) ^ 0.5 end
-- Clamp value to range
local clamp = function(v, l, h) return (v < l and l) or (v > h and h) or v end
-- Angle between two points
local angleBetween = function(srcX, srcY, dstX, dstY, offset) local angle = (math_deg(math_atan2(dstY - srcY, dstX - srcX)) + 90) + (offset or 0) return angle end
-- Get value
local getValue = function(v) return (type(v) == "function" and v()) or v end
-- Random value from table
local either = function(t) return t[math_random(#t)] end
-- Is a point inside an ellipse?
local pointInEllipse = function(xRadius, yRadius, pointX, pointY) local xSquared = pointX * pointX local ySquared = pointY * pointY local xRadiusSquared = xRadius * xRadius local yRadiusSquared = yRadius * yRadius return (xSquared / xRadiusSquared) + (ySquared / yRadiusSquared) <= 1 end
-- Is a point inside a polygon?
local pointInPolygon = function(pointList, point) local i, j = #pointList, #pointList local oddNodes = false for i = 1, #pointList do if ((pointList[i][2] < point.y and pointList[j][2] >= point.y or pointList[j][2] < point.y and pointList[i][2] >= point.y) and (pointList[i][1] <= point.x or pointList[j][1] <= point.x)) then if (pointList[i][1] + (point.y - pointList[i][2]) / (pointList[j][2] - pointList[i][2]) * (pointList[j][1] - pointList[i][1]) < point.x) then oddNodes = not oddNodes end end j = i end return oddNodes end
-- Get point that is within an ellipse
local getPointInEllipse = function(x, y, xRadius, yRadius, innerXRadius, innerYRadius) local pointX, pointY repeat pointX, pointY = math_random(-xRadius, xRadius), math_random(-yRadius, yRadius) until pointInEllipse(xRadius, yRadius, pointX, pointY) and not pointInEllipse(innerXRadius, innerYRadius, pointX, pointY) return pointX + x, pointY + y end
-- Get point that is within a circle
local getPointInCircle = function(x, y, radius, innerRadius) local pointX, pointY repeat pointX, pointY = math_random(-radius, radius), math_random(-radius, radius) until lengthOf(pointX, pointY, 0, 0) <= radius and lengthOf(pointX, pointY, 0, 0) >= innerRadius return pointX + x, pointY + y end
-- Get point that is within a radius
local getPointInRadius = function(x, y, xRadius, yRadius, innerXRadius, innerYRadius) if xRadius ~= yRadius or innerXRadius ~= innerYRadius then return getPointInEllipse(x, y, xRadius, yRadius, innerXRadius, innerYRadius) else return getPointInCircle(x, y, xRadius, innerXRadius) end end
-- Get points along line
local getPointsAlongLine = function(x1, y1, x2, y2, d) local points = {} local diffX = x2 - x1 local diffY = y2 - y1 local distBetween local x, y = x1, y1 if d == "total" or not d then distBetween = lengthOf(x1, y1, x2, y2) else distBetween = d end local addX, addY = diffX / distBetween, diffY / distBetween for i = 1, distBetween do points[#points + 1] = {x, y} x, y = x + addX, y + addY end return points end

--------------------------------------------------------------------------------
-- Add Functions to Public Library
--------------------------------------------------------------------------------
functions.fnn = fnn
functions.forcesByAngle = forcesByAngle
functions.clamp = clamp
functions.angleBetween = angleBetween
functions.getValue = getValue
functions.either = either
functions.pointInPolygon = pointInPolygon
functions.pointInEllipse = pointInEllipse
functions.getPointInRadius = getPointInRadius
functions.getPointsAlongLine = getPointsAlongLine

return functions