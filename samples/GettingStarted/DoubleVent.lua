--------------------------------------------------------------------------------
--[[
DoubleVent

Two default vents on either side of the screen - demonstrates getting started with VentGroups.


The Academic Section
--------------------

In this sample, there are a few new things that we've done. First of all, we've
introduced a new function: CBE.newVentGroup(). Second, we have two new parameters:
"title" and "emitX".

To provide easier management for multiple vents, CBE provides an object
called a "VentGroup". It keeps track of all vents inside it internally, and lets
you access their methods through the VentGroup, rather than individually. To
create a VentGroup, use the CBE.newVentGroup() command.

It's important to note that, to have a handle to a vent in a VentGroup, you need
to provide a "title" parameter. This gives the vent an ID that you will use to
access it within the VentGroup. For example, if you title your vent "someVent",
to start or stop it, you'd provide the string "someVent" to those commands.

The newVentGroup() command takes a table of values, just as the newVent()
command does, but instead of containing parameters, the newVentGroup() table
contains a list of parameters for vents. Each of these parameter tables in turn
is used to create a separate vent.

In this sample, we create a VentGroup with two vents in it. One we call "vent1"
and the other we call "vent2". Then, we start both of them with the VentGroup's
:start() command. This command takes a list of titles and starts each vent whose
title appears in that list. So when we say "double:start("vent1", "vent2")",
that's like saying, "VentGroup, start the vents I titled 'vent1' and 'vent2'".
There is another way to start vents in a VentGroup, but I'm not going to go into
it right now.

--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local double = CBE.newVentGroup({
	{
		title = "vent1",
		emitX = display.contentCenterX * 0.5
	},

	{
		title = "vent2",
		emitX = display.contentWidth * 0.75
	}
})

double:start("vent1", "vent2")