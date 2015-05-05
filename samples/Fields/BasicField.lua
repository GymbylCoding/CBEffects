--------------------------------------------------------------------------------
--[[
BasicField

Demonstrates the basic usage of a field.


The Academic Section
--------------------

CBE gives you two types of objects to make particle effects with: vents
and fields. A vent emits particles; a field modifies those that are emitted by a
vent. Fields are constructed and used almost identically to vents in every way.
A field works by setting up a virtual collision sensor and checking for
collisions with particles of any linked vent. Then, if the particle is
colliding, it calls the onCollision listener that was provided within the field
parameters.

To construct a field, call the newField() function with a table of values.
The values inside the table work in the same was as vent values. Fields also
have presets that work the same way as vent presets: if you provide a preset to
use, CBE will use those values as the defaults, but you can always
override them.

Here you'll notice two new parameters in the vent constructor: radius and
innerRadius. These tell CBE how to position particles. The default preset
makes particles appear inside of a circle, so the "radius" parameter just tells
the size of the circle particles will appear in. innerRadius is a value that
tells the size of the circles particles will *not* appear in. In a way, it cuts
out another circle inside the main circle and tells CBE not to position
particles there. So if you create an innerRadius that's just a bit smaller than
the radius, you'll get particles positioned in a ring. That's what we do to the
vent.

We also provide an onCreation function for the particles that gives them an
initial velocity toward the center of the screen using setVelocity and two
simple calculations.

After we create the vent, we actually make our field. Inside the data table, all
we provide is the preset. The "stop" preset does just that to any colliding
particles: stops them.

At the end of the sample, we link the field to the vent and start both of them.
It's important to note that fields also have to be started, just like vents, or
they'll do nothing.

--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

local vent = CBE.newVent({
	radius = display.contentCenterX * 0.5,
	innerRadius = display.contentCenterX * 0.45,
	onCreation = function(p)
		p:setVelocity((display.contentCenterX - p.x) * 0.02, (display.contentCenterY - p.y) * 0.02)
	end
})

local field = CBE.newField({
	preset = "stop" -- Fields have presets too
})

-- Link the field to the vent
vent:linkField(field)
--field:linkVent(vent) -- Alias for the above

-- Start the vent and the field
vent:start()
field:start()