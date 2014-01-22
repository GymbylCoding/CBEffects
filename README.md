## CBEffects for Corona® SDK

As the ultimate particle effects system of Corona SDK, CBEffects melds ease of use and infinite flexibility to create a vastly powerful engine and a completely new way of creating and managing particle effects. It gives you utter control over the very fabric of each particle to provide the quickest, easiest, and most beatiful visuals Corona SDK can create. Rather than forcing the programmer to stick to tight rules and rigid guidelines, CBEffects allows the programmer to completely customize every minute aspect of their effect, while at the same time allowing the user to step back and let the engine take over, if they so desire. The best part? It's completely free and open-source.

#### Licensing 

Distributed under the TSL:
- This project is free to get
- This project is free to use
- This project is free to edit
- This project is free to use in a free or commercial game
- This project is free to use in a free or commercial non-game app
- This project is free to use without crediting the author *(credits are still appreciated)*
- This project is free to use without crediting the project *(credits are still appreciated)*
- This project is NOT free to sell for anything
- This project is NOT free to credit yourself with *(unless you port it to another framework or language, in which case a reference to the original author must be made)*

#### Using this Repository

Copy the folder named "CBEffects" (that's where the actual engine lives) into your project's **root** directory (the one with `main.lua` in it). Then, at the top of whichever scene you're planning on using CBEffects in, add the following:
```Lua
local CBE = require("CBEffects.Library")
```
That's it!

##### Note for all current users:

Please start using `.newVent()` and `.newVentGroup()` rather than `.NewVent()` and `.VentGroup()`; do the same for fields. The original function calls will still work, but it's recommended that you switch to the new name for conformity.

#### Last Library Update 

Version Name: 3.0 

Released: January 2014 

To upgrade for the Corona graphics library upgrade, a new release of CBEffects has been written and turned CBEffects back into the "one particle system to rule them all". With a completely rewritten core engine, new capabilities, numerous minor enhancements, and a new internal multi-file format, CBEffects 3.0 is the most advanced version yet of the most advanced Corona SDK particle system yet.

"Real" Changelog:
```
Resources
--------------------
Removed OldSamples folder
Rmoved demo app (needs rewriting for 3.0)
Added several samples to the SampleCache
Rewrote non-relavent CBGadgets

Core
--------------------
Split into multiple files
Speed improvements
Improved security
Better code format

Vent Miscellany
--------------------
Preset names are now case-insensitive
Removed preset "wisps"
Removed preset "jitter"

Vent Parameters
--------------------
Note: Each old parameter has been deprecated, but they still serve as an alias for the new name.

Changed or Deleted:
	fadeInTime           is now inTime
	lifeStart             "  "  lifeTime
	lifeSpan              "  "  outTime
	iteratePoint          "  "  cyclePoint
	iterateColor          "  "  cycleColor
	offsetAlongLine       "  "  [deleted, now default behavior]
	posRadius             "  "  radius
	posInner              "  "  innerRadius
	physics.preCalculate  "  "  physics.preCalculateAngles
	physics.maxX          "  "  maxScaleX
	physics.maxY          "  "  maxScaleY
	physics.minX          "  "  minScaleX
	physics.minY          "  "  minScaleY
	physics.useFunction   "  "  physics.useVelFunction
	physics.iterateAngle  "  "  physics.cycleAngle

New Parameters:
	xRadius
	yRadius
	innerXRadius
	innerYRadius

Field Miscellany
--------------------
New format for polygon points: {x,y, x,y, x,y} is now {{x, y}, {x, y}, {x, y}}

Particle Miscellany
--------------------
Cleaned up particle structure
particle:setLinearVelocity() is now particle:setVelocity()
particle.angularVelocity = x is now particle:setAngularVelocity()
particle.colorChange() is now particle.changeColor()
```