--------------------------------------------------------------------------------
--[[
ProgrammerHelloWorld

Hello World in seven dialects.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local math_random = math.random
local display_newText = display.newText

local helloWorldList = {
	"print(\"Hello, world!\")", -- Lua
	"std::cout << \"Hello, world!\";", -- C++
	"System.out.println(\"Hello, world!\");", -- Java
	"alert(\"Hello, world!\");", -- JavaScript
	"print \"Hello, world!\"", -- Python
	"[print \"Hello, world!\"]", -- IDEAL
	"echo \"Hello, world!\"", -- Bash and PHP
}

local hello = CBE.newVent {
	title = "HelloWorld",
	radius = display.contentCenterY,
	
	build = function()
		local index = math_random(#helloWorldList) -- Random index of the helloWorldList
		return display_newText(helloWorldList[index], 0, 0, "Courier New", 15)
	end
}

hello:start()