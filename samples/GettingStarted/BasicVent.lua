--------------------------------------------------------------------------------
--[[
BasicVent

The absolute minimum code required to get a functional particle effect onscreen.


The Academic Section
--------------------

CBEffects runs in a different way than most particle effects systems. While most
systems have you create the emitter and interact with it through the library,
CBEffects creates it and gives you a reference to it. Then, you modify it, start
it, stop it, and delete it through that reference, rather than through the
library. This puts the user in direct control, rather than the library.

You'll also notice that what most systems call "emitters" are called "vents" in
CBEffects. That's just me being different...

In this sample, first we load up the CBEffects engine with a require() call.
Then, we create a vent through the newVent() command. Finally, we call
vent:start(), which tells the vent to start emitting particles.

--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.newVent({})

vent:start()