--[[
CBGadget: MultiParam

A small CBGadget that collects a vent data table and a table of multi-params and melds them into the vent data table. The new function then becomes one that randomly picks from the multi-param table for that key and executes it.

Usage:
---------------------
local CBE = require("CBEffects.Library")

local multiparam = require("multiparam")

local myVentParams = { -- Vent parameters, not VentGroup parameters
	preset = "flame",
	build = function() return display.newImage("smoke.png") end -- Mundane old single-build function
}

local editParams = {
	build = {
		function() -- The first build function you want to add
			return display.newImageRect("smoke.png", 24, 24)
		end,

		function() -- The second build function you want to add
			return display.newImageRect("ember.png", 10, 10)
		end,

		function() -- The third build function you want to add
			return display.newImageRect("flame.png", 30, 30)
		end
	}
}

local myVent = CBE.newVent(multiparam.edit(myVentParams, editParams)) -- Edit the params using the editParams

myVent:start()
---------------------
--]]

local multiparam = {}

local mrand		= math.random
local pairs		= pairs
local type		= type
local either	= function(t) if t and #t>1 then return t[mrand(#t)] elseif t and #t == 1 then return t[1] elseif not t then error("Missing table for 'either'", 3) end end

function multiparam.edit(params, params2)
	assert(params and params2, "Missing 1 or more arguments to 'edit'")
	
	for k, v in pairs(params2) do
		if type(v) == "table" and type(v[1]) == "function" then
			params[k] = function(...)
				return either(v)(...)
			end
		end
	end

	return params
end

return multiparam