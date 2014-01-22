--------------------------------------------------------------------------------
--[[
HelloWorld

Loads the water preset and changes particles to text objects that say "Hello, World!"

This is the CBEffects version of the classic tutorial :)


The Academic Section
--------------------

You'll notice in this sample we've provided another parameter: "build". This
parameter is a very cool feature of CBEffects. Instead of clamping the user to
parameters like particle width, particle height, particle image, type of
particle, etc., CBEffects simply lets the user provide a "build" function. Then,
to create particles, the vent internally calls that function and uses whatever
gets returned as particles. Want rectangles with a varying width between 60 and
191? Put it in the build function and that's what you'll get. How about sprites
that are either dust clouds or sparks depending on what the player in your game
is walking on? If you can do it in a function, you can make particles out of it.

Every build function you provide is arbitrarily sized. Do whatever you want in
it; all that is required is that, when the function is called, it returns a
display object of some sort.

You'll also notice that we've loaded a preset here: "water". It normally creates
its own particles, but when we provide the build function, our function
overrides that. Thus, instead of the particles the "water" preset has, we have
text that says "Hello, World!".

--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local display_newText = display.newText

local hello = CBE.newVent {
	preset = "water",
	
	build = function()
		return display_newText("Hello, World!", 0, 0, "Trebuchet MS", 30)
	end
}

hello:start()