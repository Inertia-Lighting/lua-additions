--------------------------------------------------------------------------------------------------------------------------------
--[[                                              Copyright © Inertia Lighting                                              ]]--
--------------------------------------------------------------------------------------------------------------------------------

local LuaAdditions = {}

---------------------------------------------------------------

LuaAdditions.version = 'v0.0.3-beta'

---------------------------------------------------------------

local srcFolder = script.Parent:WaitForChild('src')

LuaAdditions.Table = require(srcFolder.Table)

LuaAdditions.String = require(srcFolder.String)

LuaAdditions.Utility = require(srcFolder.Utility)

LuaAdditions.Collection = require(srcFolder.Collection)

---------------------------------------------------------------

return LuaAdditions
