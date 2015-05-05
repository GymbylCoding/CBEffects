--------------------------------------------------------------------------------
--[[
ProgrammerHelloWorld

Hello World in seven dialects.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBE.CBE")

-- Localize our commonly used functions
local math_random = math.random
local display_newText = display.newText

local helloWorldList = {
	"print(\"Hello, world!\")", -- Lua
	"std::cout << \"Hello, world!\";", -- C++
	"System.out.println(\"Hello, world!\");", -- Java
	"alert(\"Hello, world!\");", -- JavaScript
	"print \"Hello, world!\"", -- Python, Ruby, and others
	"[print \"Hello, world!\"]", -- IDEAL
	"(print 'Hello, world!')", -- Dynamic Cyan
	"echo \"Hello, world!\"" -- Bash, PHP, and others
}

local hello = CBE.newVent({
	title = "HelloWorld",
	radius = display.contentCenterY,

	build = function()
		local index = math_random(#helloWorldList) -- Random index of the helloWorldList
		return display_newText(helloWorldList[index], 0, 0, "Courier New", 15)
	end
})

hello:start()