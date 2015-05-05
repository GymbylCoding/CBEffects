--------------------------------------------------------------------------------
--[[
CBE v3.2

The public CBE interface.
--]]
--------------------------------------------------------------------------------

local CBE = {}

--------------------------------------------------------------------------------
-- Include Libraries and Localize
--------------------------------------------------------------------------------
local core = require("CBE.cbe_core.core")

--------------------------------------------------------------------------------
-- Import Functions (aliases)
--------------------------------------------------------------------------------
CBE.newVent = core.newVent
CBE.newField = core.newField
CBE.newVentGroup = core.newVentGroup
CBE.newFieldGroup = core.newFieldGroup

CBE.listPresets = core.listPresets

return CBE