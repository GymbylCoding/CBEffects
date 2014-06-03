## CBEffects for Corona® SDK

[Love CBEffects and want it to continue to evolve? Please donate! Donations are **greatly** appreciated.](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=EZ9CHTHTGA2XG)

As the ultimate particle effects system of Corona SDK, CBEffects melds ease of use and infinite flexibility to create a vastly powerful engine and a completely new way of creating and managing particle effects. It gives you utter control over the very fabric of each particle to provide the quickest, easiest, and most beatiful visuals Corona SDK can create. Rather than forcing the programmer to stick to tight rules and rigid guidelines, CBEffects allows the programmer to completely customize every minute aspect of their effect, while at the same time allowing the user to step back and let the engine take over, if they so desire. The best part? It's completely free and open-source.

There is now a reference file, named `reference.html`, that is the parameter reference.

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

Version Name: 3.1
Released: June 2014

A quick update to freshen things up.

Changelog:
```
Resources
--------------------
Added samples to the SampleCache
Removed reference.cy

Core
--------------------
Various speed improvements
Minor enhancements
```