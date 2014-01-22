--------------------------------------------------------------------------------
--[[
BasiceEvents

Demonstrates onCreation, onUpdate, and onDeath particle event basics.


The Academic Section
--------------------

One of the things that makes CBEffects so customizable is the presence of
particle event functions. Particle events are like listeners and are called at
specific periods of a particle's lifetime. Each particle event gets both the
particle and the vent as arguments when the function is called.

Though this sample is primarily for particle events, you'll also find the two
parameters "perEmit" and "emitDelay". These aren't difficult; perEmit is simply
a number that tells how many particles the vent emits each "round", and
emitDelay is the delay between "rounds". In other words, if you set perEmit to 3
and emitDelay to 500, the vent will emit 3 particles every 500 milliseconds once
it gets .start()-ed.

In this sample, we create a vent with a perEmit of 1 and an emitDelay of 1000.
This makes the vent emit one particle every second. We do this because we don't
want to clutter up the terminal too much with the print() calls we do or slow
down the FPS of the app.

We also define the parameters "onCreation", "onUpdate", and "onDeath". These are
the event functions. onCreation is called directly after a particle is built.
onUpdate is called every frame, after the particle is moved, scaled, and
rotated. onDeath is called right as the particle dies and is removed from the
screen. All we do for each of these functions is notify the user that a particle
event happened with a print() statement. Though this is a trite example, you can
actually do whatever you like in the event functions.

--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local tostring = tostring
local print = print

local vent = CBE.newVent {
	perEmit = 1,
	emitDelay = 1000,

	onCreation = function(particle, vent)
		print("A particle was created: " .. tostring(particle) .. ", " .. tostring(vent))
	end,

	onUpdate = function(particle, vent)
		print("A particle was updated: " .. tostring(particle) .. ", " .. tostring(vent))
	end,

	onDeath = function(particle, vent)
		print("A particle died: " .. tostring(particle) .. ", " .. tostring(vent))
	end
}

vent:start()