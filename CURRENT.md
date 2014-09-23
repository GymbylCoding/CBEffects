### CBEffects v3.1.1 ###

*Note: When I say 'deprecated `xyz` parameter', that usually means I've just renamed the parameter. The old name will still work, though.*

- Deprecated `propertyTable` parameter in favor of `particleProperties`
- Deprecated `autoAngle` parameter in favor of `autoCalculateAngles`
- Adding a field or vent to a FieldGroup or VentGroup now allows already-constructed fields or vents
- Added samples `ExampleEffects/Explosion1` and `ExampleEffects/MortarExplosion`
- Added an "official" way to access private CBEffects properties of particles (`particle:setCBEProperty` and `particle:getCBEProperty()`)
- Minor adjustments