--------------------------------------------------------------------------------
-- main.lua
--------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

--------------------------------------------------------------------------------
-- Create Sample Effect
--------------------------------------------------------------------------------
local CBE = require("CBEffects.Library")

local t = display.newText({
	-- Manual kerning for fun and profit:
	text = "C h e c k   o u t   t h e   S a m p l e C a c h e   f o l d e r   t o   g e t   s t a r t e d",
	font = "Times New Roman",
	fontSize = 30
})

t.x, t.y = 0, display.screenOriginY
t.x,t.y = display.contentCenterX, t.height * 0.5 + 10

local vent = CBE.newVent({
	preset = "burn"
})

vent:start()