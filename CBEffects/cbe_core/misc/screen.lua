--------------------------------------------------------------------------------
--[[
CBEffects Component: Screen

Gives correct screen dimensions.
--]]
--------------------------------------------------------------------------------

local screen = {}

screen.left = display.screenOriginX -- Left side of the screen
screen.right = display.contentWidth - screen.left -- Right side of the screen
screen.top = display.screenOriginY -- Top of the screen
screen.centerX = display.contentCenterX
screen.centerY = display.contentCenterY
screen.bottom = display.contentHeight - screen.top -- Bottom of the screen
screen.width = screen.right - screen.left -- Actual width of the screen
screen.height = screen.bottom - screen.top -- Actual height of the screen
screen.zoomX = screen.width / display.contentWidth
screen.zoomY = screen.height / display.contentHeight

return screen