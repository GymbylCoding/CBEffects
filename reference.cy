!!----------------------------------------------------------------------------!!
!{
Cydoc reference file; transformed to HTML with the Cydoc utility.

Also just a plain-text version of the parameter reference.
}!
!!----------------------------------------------------------------------------!!

!!----------------------------------------------------------------------------!!
!! Cydoc Data                                                                 !!
!!----------------------------------------------------------------------------!!
!cydoc-prefs! -> [
	title -> "CBEffects Parameter Reference"
	version -> "3.1"
	write_as_code -> [
		supported_values -> true
	]
]

!!----------------------------------------------------------------------------!!
!! Vent Parameters                                                            !!
!!----------------------------------------------------------------------------!!
"Vent Parameters" -> [
	x -> [
		type -> number
		description -> "The position of the vent on the X-axis."
		related -> [
			@ y
			@ contentX
			@ contentY
		]
	]

	y -> [
		type -> number
		description -> "The position of the vent on the Y-axis."
		related -> [
			@ x
			@ contentX
			@ contentY
		]
	]

	contentX -> [
		type -> number
		description -> "The position of the vent's content group on the X-axis."
		related -> [
			@ x
			@ y
			@ contentY
		]
	]

	contentY -> [
		type -> number
		description -> "The position of the vent's content group on the Y-axis."
		related -> [
			@ x
			@ y
			@ contentX
		]
	]

	build -> [
		type -> function
		description -> "A function that builds and returns a display object that CBEffects will use as a particle."
		related -> []
	]

	propertyTable -> [
		type -> table
		description -> "A table of properties that are transferred to each particle on creation."
		related -> []
	]

	scale -> [
		type -> number
		description -> "The scale of the vent. Used as default for `scaleX` and `scaleY`."
		related -> [
			@ scaleX
			@ scaleY
		]
	]

	scaleX -> [
		type -> number
		description -> "The scale of the vent on the X-axis. Defaults to `scale`."
		related -> [
			@ scale
			@ scaleY
		]
	]

	scaleY -> [
		type -> number
		description -> "The scale of the vent on the Y-axis. Defaults to `scale`."
		related -> [
			@ scale
			@ scaleX
		]
	]

	parentGroup -> [
		type -> "Corona display object"
		description -> "The group that the vent's content will be inserted into."
		related -> []
	]

	isActive -> [
		type -> Boolean
		description -> "Whether this vent accepts `startMaster()` and `emitMaster()` commands in a VentGroup."
		related -> []
	]

	title -> [
		type -> string
		description -> "The access-ID of the vent in a VentGroup. Used in VentGroup commands that apply only to specific vents."
		related -> []
	]

	rotateTowardVel -> [
		type -> Boolean
		description -> "Whether particles rotate to face the direction they are travelling."
		related -> [
			@ towardVelOffset
		]
	]

	towardVelOffset -> [
		type -> number
		description -> "An offset by which particles are rotated toward their direction if `rotateTowardVel` is enabled."
		related -> [
			@ rotateTowardVel
		]
	]

	color -> [
		type -> table
		description -> "A table containing inner tables that specify the color of particles. The inner tables must be in the form of `{r, g, b}`."
		related -> [
			@ cycleColor
			@ curColor
			@ colorIncr
		]
	]
	
	cycleColor -> [
		type -> Boolean
		description -> "If set to `true`, particle colors will be cycled through in order. If set to `false`, particles will be colored randomly from the color table."
		related -> [
			@ color
			@ curColor
			@ colorIncr
		]
	]

	curColor -> [
		type -> number
		description -> "The color color cycling starts with if `cycleColor` is `true`."
		related -> [
			@ color
			@ cycleColor
			@ colorIncr
		]
	]

	colorIncr -> [
		type -> number
		description -> "The value by which the current color is incremented if `cycleColor` is `true`."
		related -> [
			@ color
			@ cycleColor
			@ curColor
		]
	]

	emitDelay -> [
		type -> number
		description -> "The delay between particle emission sequences."
		related -> [
			@ perEmit
			@ emissionNum
		]
	]
		
	perEmit -> [
		type -> number
		description -> "The number of particles emitted for each emission sequence."
		related -> [
			@ emitDelay
			@ emissionNum
		]
	]
	
	emissionNum -> [
		type -> number
		description -> "The number of emission sequences to toggle when `vent.start()` is called."
		related -> [
			@ emitDelay
			@ perEmit
		]
	]

	startAlpha -> [
		type -> number
		description -> "The alpha particles are when they are created."
		related -> [
			@ lifeAlpha
			@ endAlpha
		]
	]
	
	lifeAlpha -> [
		type -> number
		description -> "The alpha particles are during their life span."
		related -> [
			@ startAlpha
			@ endAlpha
		]
	]
	
	endAlpha -> [
		type -> number
		description -> "The alpha particles are when they are destroyed."
		related -> [
			@ startAlpha
			@ lifeAlpha
		]
	]
	
	inTime -> [
		type -> number
		description -> "The duration of the transition from startAlpha to lifeAlpha."
		related -> [
			@ lifeTime
			@ outTime
		]
	]
	
	lifeTime -> [
		type -> number
		description -> "The duration of the particle's life span, when no alpha changes are taking place and the particle's alpha is `lifeAlpha`."
		related -> [
			@ inTime
			@ outTime
		]
	]
	
	outTime -> [
		type -> number
		description -> "The duration of the transition from `lifeAlpha` to `endAlpha`."
		related -> [
			@ inTime
			@ lifeTime
		]
	]
	
	onCreation -> [
		type -> function
		description -> "A function called when a particle is created. The particle, the vent, and the vent's content group are passed as arguments."
		related -> [
			@ onCreationTime
			@ onDeath
			@ onUpdate
		]
	]
	
	onCreationTime -> [
		type -> string
		description -> "When during the particle's creation sequence to call the onCreation function."
		supported_values -> [
			!! In chronological order
			afterBuild -> "Calls the function directly after the particle is built. The particle has only the CBEffects particle core methods and values."
			afterVel -> "Calls the function once the particle's velocity has been set."
			afterColor -> "Calls the function once the particle has been colored and has the `.colorChange()` function available."
			afterPosition -> "Calls the function once the particle has been positioned."
		]
		related -> [
			@ onCreation
		]
	]
	
	onDeath -> [
		type -> function
		description -> "A function called when the particle's life span is over and it is destroyed. The particle, the vent, and the vent's content group are passed as arguments."
		related -> [
			@ onCreation
			@ onUpdate
		]
	]
	
	onUpdate -> [
		type -> function
		description -> "A function called each frame for each particle that is updated. The particle, the vent, and the vent's content group are passed as arguments."
		related -> [
			@ onCreation
			@ onDeath
		]
	]
	
	onVentInit -> [
		type -> function
		description -> "A function called when a vent is created using the parameters. The vent is passed as an argument.  This is a good place to set up extra vent properties or custom values."
		related -> []
	]
	
	onEmitBegin -> [
		type -> function
		description -> "A function called directly before an emission sequence begins."
		related -> [
			@ onEmitEnd
		]
	]
	
	onEmitEnd -> [
		type -> function
		description -> "A function called directly after an emission sequence ends."
		related -> [
			@ onEmitBegin
		]
	]
	
	positionType -> [
		type -> string
		description -> "Specifies the way particles are positioned."
		supported_values -> [
			inRadius -> "Makes particles appear inside an elliptical shape. To customize, see `radius`, `xRadius`, `yRadius`, `innerRadius`, `innerXRadius`, and `innerYRadius`."
			alongLine -> "Makes particles appear along a line. To customize, see `point1`, `point2`, and `lineDensity`."
			inRect -> "Makes particles appear inside of a rectangle. To customize, see `rectLeft`, `rectTop`, `rectWidth`, and `rectHeight`."
			atPoint -> "Makes particles appear at a single `(x, y)` point. To customize, see `x` and `y`."
			fromPointList -> "Makes particles appear on multiple points from the `pointList`. To customize, see `pointList`, and `cyclePoint`."
			"custom function" -> "Position particles using your own custom function. It must return two numbers, `x` and `y`, respectively. To use this capability, make this parameter, `positionType`, a function."
		]
		related -> [
			@ radius
			@ xRadius
			@ yRadius
			@ innerRadius
			@ innerXRadius
			@ innerYRadius
			@ point1
			@ point2
			@ lineDensity
			@ rectLeft
			@ rectTop
			@ rectWidth
			@ rectHeight
			@ pointList
			@ cyclePoint
			@ curPoint
			@ x
			@ y
		]
	]
	
	radius -> [
		type -> number
		description -> "The master size of the ellipse particles will appear in if `positionType` is `inRadius`. Acts as a default for `xRadius` and `yRadius`."
		related -> [
			@ positionType
			@ xRadius
			@ yRadius
			@ innerRadius
			@ innerXRadius
			@ innerYRadius
		]
	]

	xRadius -> [
		type -> number
		description -> "The half-width of the ellipse particles will appear in if `positionType` is `inRadius`. Defaults to `radius`."
		related -> [
			@ positionType
			@ radius
			@ yRadius
			@ innerRadius
			@ innerXRadius
			@ innerYRadius
		]
	]

	yRadius -> [
		type -> number
		description -> "The half-height of the ellipse particles will appear in if `positionType` is `inRadius`. Defaults to `radius`."
		related -> [
			@ positionType
			@ radius
			@ xRadius
			@ innerRadius
			@ innerXRadius
			@ innerYRadius
		]
	]

	innerRadius -> [
		type -> number
		description -> "The master size of the ellipse particles will be blocked from appearing in if `positionType` is `inRadius`. Acts as a default for `innerXRadius` and `innerYRadius`."
		related -> [
			@ positionType
			@ radius
			@ xRadius
			@ yRadius
			@ innerXRadius
			@ innerYRadius
		]
	]

	innerXRadius -> [
		type -> number
		description -> "The half-width of the ellipse particles will be blocked from appearing in if `positionType` is `inRadius`. Defaults to `innerRadius`."
		related -> [
			@ positionType
			@ radius
			@ xRadius
			@ yRadius
			@ innerRadius
			@ innerYRadius
		]
	]

	innerYRadius -> [
		type -> number
		description -> "The half-height of the ellipse particles will be blocked from appearing in if `positionType` is `inRadius`. Defaults to `innerRadius`."
		related -> [
			@ positionType
			@ radius
			@ xRadius
			@ yRadius
			@ innerRadius
			@ innerXRadius
		]
	]

	point1 -> [
		type -> table
		description -> "The `(x, y)` location of the first point of the line particles will appear on if `positionType` is `alongLine`. Provided in the form of `{x, y}`."
		related -> [
			@ positionType
			@ point2
			@ lineDensity
		]
	]

	point2 -> [
		type -> table
		description -> "The `(x, y)` location of the second point of the line particles will appear on if `positionType` is `alongLine`. Provided in the form of `{x, y}`."
		related -> [
			@ positionType
			@ point1
			@ lineDensity
		]
	]

	lineDensity -> [
		type -> table
		description -> "The number of points to calculate along the line if `positionType` is `alongLine`. If set to the string `total`, will make an unbroken line."
		related -> [
			@ positionType
			@ point1
			@ point2
		]
	]

	rectLeft -> [
		type -> number
		description -> "The left side of the rectangle particles appear inside if `positionType` is `inRect`."
		related -> [
			@ positionType
			@ rectTop
			@ rectWidth
			@ rectHeight
		]
	]

	rectTop -> [
		type -> number
		description -> "The top side of the rectangle particles appear inside if `positionType` is `inRect`."
		related -> [
			@ positionType
			@ rectLeft
			@ rectWidth
			@ rectHeight
		]
	]

	rectWidth -> [
		type -> number
		description -> "The width of the rectangle particles appear inside if `positionType` is `inRect`."
		related -> [
			@ positionType
			@ rectLeft
			@ rectTop
			@ rectHeight
		]
	]

	rectHeight -> [
		type -> number
		description -> "The height of the rectangle particles appear inside if `positionType` is `inRect`."
		related -> [
			@ positionType
			@ rectLeft
			@ rectTop
			@ rectWidth
		]
	]

	pointList -> [
		type -> table
		description -> "The list of points particles will appear in if `positionType` is `fromPointList`. Provided in the form of `{{x, y}, {x, y}, {x, y}, ... }`."
		related -> [
			@ positionType
			@ cyclePoint
			@ pointIncr
			@ curPoint
		]
	]

	cyclePoint -> [
		type -> Boolean
		description -> "Whether points are chosen in order or randomly from the `pointTable` if `positionType` is `fromPointList`. If set to `true`, points are chosen in order. If `false`, they are picked randomly."
		related -> [
			@ positionType
			@ pointList
			@ pointIncr
			@ curPoint
		]
	]

	pointIncr -> [
		type -> Boolean
		description -> "The value by which the current point is incremented if `cyclePoint` is `true`."
		related -> [
			@ positionType
			@ pointList
			@ cyclePoint
			@ curPoint
		]
	]

	curPoint -> [
		type -> Boolean
		description -> "The point point cycling starts with if `positionType` is `fromPointList`."
		related -> [
			@ positionType
			@ pointList
			@ pointIncr
			@ curPoint
		]
	]
]