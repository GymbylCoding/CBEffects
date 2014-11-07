--------------------------------------------------------------------------------
--[[
LoadPreset

The absolute minimum code required to get a preset loaded onscreen.


The Academic Section
--------------------

If you've just come from the BasicVent tutorial, you'll probably be wondering
where customization comes in. When you create a vent, you call the NewVent
command and pass a table of parameters. These parameters tell CBEffects exactly
how to build the vent. Using this parameter table, you can control the way
particles are created, their color, where and how to position them, the speed
and direction they move, and far more. Each of these capabilities is given as a
value in that parameter table.

Because there are so many customizable values in a parameter table, CBEffects
provides something called "presets". These are parameters for a vent that have
the necessary values provided. When you tell CBEffects what preset to use, those
values become the defaults. Then, you can get a certain effect like flame or
smoke by only providing one parameter.

You're not clamped to that one effect, though: CBEffects treats any parameters
you provide as having more precedence than a preset's, and uses the preset
parameters as defaults. So, if you want to modify something about a vent after
you've provided a preset for CBEffects to use, just add that value into your
parameter table. It will then "overwrite" the value the preset provided and use
yours.

Here, we create a vent and tell it to use the "burn" preset as the default
values. Then, we start it, just like usual, and get a completely different
effect simply by providing a single value.

To see a list of presets, call CBE.listPresets() and CBEffects will print all
available presets to the terminal.

--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.newVent({
	preset = "burn"
})

vent:start()