--------------------------------------------------------------------------------------------------------------------------------
--[[                                              Copyright © Inertia Lighting                                              ]]--
--------------------------------------------------------------------------------------------------------------------------------

local LuaAdditions = {}

---------------------------------------------------------------

local srcFolder = script.Parent:WaitForChild('src')

LuaAdditions.Table = require(srcFolder.Table)

LuaAdditions.String = require(srcFolder.String)

LuaAdditions.Utility = require(srcFolder.Utility)

---------------------------------------------------------------

return LuaAdditions
