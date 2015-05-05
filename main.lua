--------------------------------------------------------------------------------
-- main.lua
--------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)
math.randomseed(os.time())

local CBE = require("CBE.CBE")
local widget = require("widget")

local samplesFile = io.open(system.pathForFile("samples/SAMPLES.txt"), "r")
local samplesString = samplesFile:read("*a")
samplesFile:close()
local samples = {}
for s in samplesString:gmatch("(.-)\n") do samples[#samples + 1] = s end

local buttonHeight = display.contentHeight / 15
local x = display.contentWidth * 0.25
local y = buttonHeight * 0.5
local row = 0


local buttonGroup
local academicSlider
local academicButton

buttonGroup = widget.newScrollView({
	backgroundColor = {0, 0, 0}
})

academicSlider = widget.newScrollView({
	width = display.contentCenterX,
	left = display.contentWidth,
	backgroundColor = {0, 0, 0, 0.8}
})

local toggleAcademicSlider = function()
	if academicSlider.isShown then
		if academicSlider.trans then transition.cancel(academicSlider.trans) end
		academicSlider.trans = transition.to(academicSlider, {
			x = display.contentWidth + academicSlider.width * 0.5,
			time = 500,
			transition = easing.outQuad
		})
		academicSlider.isShown = false
		academicButton:setLabel("Show Academic Section")
	else
		if academicSlider.trans then transition.cancel(academicSlider.trans) end
		academicSlider.trans = transition.to(academicSlider, {
			x = display.contentWidth - academicSlider.width * 0.5,
			time = 500,
			transition = easing.outQuad
		})
		academicSlider.isShown = true
		academicButton:setLabel("Hide Academic Section")
	end
end

academicButton = widget.newButton({
	onRelease = toggleAcademicSlider,
	label = "Show Academic Section",
	fontSize = buttonHeight * 0.25
})

-- academicButton.rotation = -90
academicButton.x, academicButton.y = display.contentWidth - academicButton.contentWidth * 0.6, display.contentHeight - academicButton.contentHeight * 0.6
academicButton.isVisible = false

local function runSample(event)
	local sampleName = event.target.sampleName
	require("samples." .. sampleName:gsub("/", "."))

	-- Read sample file contents
	local sampleFile = system.pathForFile("samples/" .. sampleName .. ".lua", system.ResourceDirectory)
	local f = io.open(sampleFile, "r")
	local sampleContents = f:read("*a")

	-- Get intro and academic section from sample contents
	local intro = sampleContents:match([=[
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-
%-%-%[%[
(.-)
%-%-%]%]
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-
]=])
	local title = intro:match("(.-)\n")
	intro = intro:sub(title:len() + 2)
	local academicSection = intro:match([[
The Academic Section
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-
(.+)
]])
	
	academicButton.isVisible = true

	if academicSection then
		local academicText = display.newText({
			text = academicSection,
			font = native.systemFont,
			fontSize = 20,
			width = display.contentCenterX * 0.8,
		})
		academicSlider:insert(academicText)
		academicText.x, academicText.y = academicSlider.width * 0.5, academicText.height * 0.5
	else
		academicButton:setLabel("(No Academic Section)")
		academicButton:setEnabled(false)
	end

	-- Build title frame and text
	local frame = display.newRect(display.contentCenterX, 30, display.contentWidth, buttonHeight)
	frame:setFillColor(0.2, 0.2, 0.2)

	local t = display.newText({
		text = "Sample: " .. sampleName,
		font = native.systemFont,
		fontSize = 30
	})
	t.x = display.contentCenterX
	t.y = t.height * 0.5 + 10

	display.remove(buttonGroup)

	academicSlider:toFront()
	academicButton:toFront()

	return true
end

for i = 1, #samples do	
	local button = widget.newButton({
		label = samples[i],
		x = display.contentCenterX,
		y = y,
		fontSize = buttonHeight * 0.5,
		onRelease = runSample,
		height = buttonHeight
	})
	button.sampleName = samples[i]
	buttonGroup:insert(button)

	row = row + 1
	y = y + buttonHeight
end