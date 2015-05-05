## CBE 3.2

CBE version 3.2 is finally here!

After quite some time, CBE has finally gotten a major update. CBE 3.2 cleans everything up, modernizes everything, and better-izes everything.

In order to stay current, however, CBE 3.2 brings a few non-backwards-compatible changes to prior versions of CBE. This means that, in order to use 3.2, you'll need to make some changes in your game.

* The module name has been changed from `CBE.Library` to `CBE.CBE`. This means that you actually don't have to even adopt 3.2 until you're ready. I recommend, however, that you do to make things easier in the future.
* All deprecated parameters will cease to function as aliases
* The alias library functions have all been removed; instead of `CBE.NewVentGroup` or `CBE.VentGroup`, for example, use `CBE.newVentGroup`
* Graphics v1 compatibility has been be dropped
* The parentGroup parameter and vent.content has been deprecated (still functional, but their use is discouraged); the vent has become a display group instead for better "Corona-izing" of the library
* The `x` and `y` parameters has been renamed to `emitX` and `emitY`, and `contentX`/`contentY` to `x` and `y` - this is because the vent is now a display group and `x` and `y` are sensitive Corona properties
* All object functions require a colon instead of a dot for calling (`ventGroup:start(...)` rather than `ventGroup.start(...)`) in keeping with Lua OOP practices
* `particle._kill()` has been renamed to `particle:destroyParticle()`

I've also unofficially moved from calling the engine "CBEffects" to mostly calling it "CBE". This is just really a personal preference of mine. The engine's "real" name is still technically CBEffects, but CBE somehow sounds more professional `:)`.
