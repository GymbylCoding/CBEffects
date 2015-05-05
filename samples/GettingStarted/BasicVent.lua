--------------------------------------------------------------------------------
--[[
BasicVent

The absolute minimum code required to get a functional particle effect onscreen.


The Academic Section
--------------------

CBE works in an object-oriented way. You make a vent with the .newVent()
function, then, to use the vent, you do what you want to with the vent object.
If you're coming from PC, you'll notice that CBE's approach is different
in that way.

You'll also notice that what most systems call "emitters" are called "vents" in
CBE. That's just me being different...

In this sample, first we load up the CBE engine with a require() call.
Then, we create a vent through the newVent() command. Finally, we call
vent:start(), which tells the vent to start emitting particles.

--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local vent = CBE.newVent({})

vent:start()