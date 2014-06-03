--------------------------------------------------------------------------------
--[[
CBEffects v3.1

The public CBEffects interface.
--]]
--------------------------------------------------------------------------------

local CBE = {}

--------------------------------------------------------------------------------
-- Include Libraries and Localize
--------------------------------------------------------------------------------
local core = require("CBEffects.cbe_core.core")

--------------------------------------------------------------------------------
-- Import Functions (aliases)
--------------------------------------------------------------------------------
CBE.Vent = core.newVent
CBE.NewVent = core.newVent
CBE.newVent = core.newVent
CBE.Field = core.newField
CBE.NewField = core.newField
CBE.newField = core.newField
CBE.VentGroup = core.newVentGroup
CBE.NewVentGroup = core.newVentGroup
CBE.newVentGroup = core.newVentGroup
CBE.FieldGroup = core.newFieldGroup
CBE.NewFieldGroup = core.newFieldGroup
CBE.newFieldGroup = core.newFieldGroup
CBE.ListPresets = core.listPresets
CBE.listPresets = core.listPresets

return CBE