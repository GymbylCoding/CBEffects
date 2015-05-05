## CBE for Corona® SDK

[Love CBE and want it to continue to evolve? Please donate! Donations are **greatly** appreciated.](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=EZ9CHTHTGA2XG)
[Please check out my first game!](http://forums.coronalabs.com/topic/47069-crystalline-deflection-made-by-a-14-year-old/); if you don't want to pay the $0.99 my game costs, at least read my story `:)`

As the ultimate particle effects system of Corona SDK, CBE melds ease of use and infinite flexibility to create a vastly powerful engine and a completely new way of creating and managing particle effects. It gives you utter control over the very fabric of each particle to provide the quickest, easiest, and most beatiful special effects Corona SDK can create. Rather than forcing the programmer to stick to tight rules and rigid guidelines, CBE allows the programmer to completely customize every minute aspect of their effect, while at the same time allowing the user to step back and let the engine take over, if they so desire. The best part? It's completely free and open-source.

### Using this Repository

Just start up `main.lua` in the simulator to see a menu of some samples I've built for CBE (menu built on the one by Roaming Gamer). A few of the samples have a small learning section known as the "Academic Section". You can see this from the simulator by clicking the button in the bottom-right corner.

### Using CBE

Copy the folder named "CBE" (that's where the actual engine lives) into your project's **root** directory (the one with `main.lua` in it). Then, at the top of whichever scene you're planning on using CBE in, add the following:
```Lua
local CBE = require("CBE.CBE")
```
That's it!

### Migrating to 3.2

CBE 3.2 has a few non-backwards-compatible changes with prior versions; the file `CBE_3_2.md` will list them. If I've forgotten some, please let me know and I'll add it for the benefit of others.

#### Licensing

Distributed under the TSL:
- This project is free to get
- This project is free to use
- This project is free to edit
- This project is free to use in a free or commercial game or app
- This project is free to use without crediting the author *(credits are still appreciated)*
- This project is free to use without crediting the project *(credits are still appreciated)*
- This project is NOT free to sell for anything
- This project is NOT free to credit yourself with *(unless you port it to another framework or language, in which case a reference to the original author must be made)*
